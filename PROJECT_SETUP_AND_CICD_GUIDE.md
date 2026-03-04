# Project Setup and CI/CD Guide

This document summarizes the current project setup, infrastructure flow, CI/CD behavior, and operational fixes applied in this repository.

## 1) Project Overview

- Runtime: Node.js (ESM)
- API entrypoint: `index.js`
- Containerization: Docker (`dockerfile`)
- Kubernetes deployment: Helm chart (`charts/hospital-backend`)
- Infrastructure as Code: Terraform (`terraform/`)
- Server bootstrap/provision tasks: Ansible (`ansible/`)

## 2) Runtime Configuration (Backend)

Backend requires the following environment variables at runtime:

- `MONGO_URI`
- `JWT_SECRET`
- `REFRESH_SECRET`
- `PORT` (optional, default `8000`)

Kubernetes deploy currently injects these via a Kubernetes Secret named `hospital-secrets`.

## 3) Kubernetes + Helm Design

### 3.1 Secret ownership strategy

To avoid Helm ownership conflicts with pre-existing secrets, chart and workflow are configured as:

- Helm values support existing secret reference: `secrets.existingSecret`
- CI deploy uses:
  - `--set secrets.create=false`
  - `--set secrets.existingSecret=hospital-secrets`
- Secret is upserted before Helm deploy with `kubectl apply`

Result: existing `hospital-secrets` can be reused safely without `invalid ownership metadata` errors.

### 3.2 Deployment flow

Deploy workflow performs:

1. Setup kubeconfig from GitHub Secret
2. Ensure namespace exists (`num`)
3. Upsert `hospital-secrets`
4. `helm upgrade --install`
5. Verify rollout (`kubectl rollout status`)
6. On failure, collect debug info (`describe`, events, pod status)

## 4) Kubeconfig and TLS SAN Notes

Important rule:

- kubeconfig `server:` endpoint must match API server certificate SANs.

Observed issue type:

- Accessing API via public IP (e.g. `13.x.x.x`) fails if SAN does not include that IP.

Recommended practice:

- Keep node-local kubeconfig for local admin (`127.0.0.1`) on control node.
- Use separate CI kubeconfig endpoint reachable by runner (private IP or stable DNS/Elastic IP).
- If public endpoint is required, add it to k3s TLS SAN and rotate/restart correctly.

## 5) GitHub Actions Workflows

Current workflow files:

- `01-ci.yml` — Node.js CI checks
- `02-build-image.yml` — Build & push Docker image
- `03-deploy-k3s.yml` — Deploy to K3s after build completes
- `terraform.yaml` — Terraform plan/apply
- `ansible.yml` — Ansible setup workflow

### 5.1 Trigger behavior summary

- `01-ci.yml`
  - Runs on `push(main)` and `pull_request`
- `02-build-image.yml`
  - Runs on `push(main)`
- `03-deploy-k3s.yml`
  - Runs on `workflow_run` of `Build & Push Docker Image` completion
  - restricted to main branch push success
- `terraform.yaml`
  - Runs on:
    - `pull_request` with path filter `terraform/**` (and workflow file changes)
    - `push(main)` with path filter `terraform/**` (and workflow file changes)
    - manual `workflow_dispatch`
- `ansible.yml`
  - Runs on push when `ansible/**` or `ansible.yml` changes
  - and manual `workflow_dispatch`

### 5.2 PR vs Main execution model

Current expected model:

- PR: validate only (CI + Terraform plan)
- Main: execute delivery actions (image build/push, deploy, terraform apply if triggered)

### 5.3 Run title naming

`run-name` was added so Actions list shows stable workflow titles instead of only commit-message based titles.

## 6) Terraform Setup

Terraform files are under `terraform/`.

### 6.1 Local execution

From repository root, use:

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

### 6.2 CI and variables

- `terraform.tfvars` is intentionally gitignored and not available in GitHub Actions.
- CI must use GitHub Secrets / `TF_VAR_*` values for required vars.
- `TF_INPUT=false` is set to avoid interactive prompts in CI.

### 6.3 SG rule key stabilization fix

Security group rule resources were changed from index-based keys to stable hash-based keys:

- old: `for idx, rule in ... : idx => rule`
- new: `for rule in ... : sha1(jsonencode(rule)) => rule`

Benefit:

- Reordering list entries no longer causes accidental destroy/update due to shifting numeric indices.

## 7) GitHub Secrets (Required)

At minimum, repository Actions secrets should include:

### App/Deploy

- `DOCKER_USERNAME`
- `DOCKER_PASSWORD`
- `KUBECONFIG`
- `MONGODB_URI`
- `JWT_SECRET`
- `REFRESH_SECRET`

### Terraform

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_VPC_ID`

### Ansible

- `SERVER_SSH_KEY`
- `SERVER_HOST`
- `SERVER_USER`

## 8) AWS / Terraform Known Pitfalls

### 8.1 AMI architecture mismatch

If using `t3.micro` (x86_64), AMI must also be x86_64.

Error example:

- `instance type x86_64 does not match AMI arm64`

### 8.2 IAM authorization errors

If CI fails with `UnauthorizedOperation` (e.g. `ec2:CreateSecurityGroup`), IAM policy attached to CI user is insufficient.

### 8.3 tfvars not in CI

If CI asks for missing vars like `vpc_id`, this usually means the value is not provided via `TF_VAR_*` or secrets (because `terraform.tfvars` is ignored in git).

## 9) Security Cleanup Applied

Sensitive values were removed from `README.md`:

- hardcoded DB connection string
- hardcoded test-user credentials

Policy:

- never commit real credentials to repo/docs
- keep secrets only in local `.env` or GitHub Secrets

## 10) Recommended Team Workflow

1. Developer creates feature branch
2. Opens PR
3. PR checks run (CI + Terraform plan)
4. Review/approval
5. Merge to `main`
6. Main workflows run build/deploy/apply paths according to trigger filters

## 11) Operational Debug Commands

### Kubernetes

```bash
kubectl get pods -n num
kubectl describe deployment/hospital-backend -n num
kubectl get events -n num --sort-by=.metadata.creationTimestamp | tail -n 100
helm status hospital-backend -n num
```

### Terraform

```bash
cd terraform
terraform plan
terraform apply
```

### GitHub Actions via CLI

```bash
gh run list --limit 30
gh pr list --state all
```

## 12) Notes

- This guide reflects the current repository behavior and workflow files.
- If workflow triggers change, update this document accordingly in the same PR.
