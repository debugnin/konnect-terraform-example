# Kong Konnect Terraform Configuration

This repository contains Terraform configuration for managing Kong Konnect gateway resources.

## Overview

This configuration sets up:
- Kong Konnect control plane
- Gateway service for API test environment
- Route configuration with key authentication
- Consumer management

## Prerequisites

- Terraform >= 1.0
- Kong Konnect account and API credentials
- Kong Konnect Terraform provider

## Usage

1. **Initialize Terraform:**
   ```bash
   terraform init
   ```

2. **Set required variables:**
   ```bash
   export TF_VAR_konnect_token="your-konnect-token"
   ```

3. **Plan deployment:**
   ```bash
   terraform plan
   ```

4. **Apply configuration:**
   ```bash
   terraform apply
   ```

## Configuration Files

- `auth.tf` - Authentication configuration
- `control-plane.tf` - Control plane setup
- `service-config.tf` - Service, route, and plugin configuration
- `variables.tf` - Variable definitions
- `output.tf` - Output values

## Resources Created

- **Service**: `avm_test_service` - API test service on staging environment
- **Route**: `heartbeat` - `/api/v1/heartbeat` endpoint
- **Plugin**: Key authentication for the heartbeat route
- **Consumers**: `machine-locke-test` and `realtime-avm-client`

## Clean Up

```bash
terraform destroy
```