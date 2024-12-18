# Directories
TF_DIR         = ./Terraform

# Variables
TF_BIN 		  			= terraform
TF_VARS_FILE  			= terraform.tfvars
TF_PLAN_FILE			= terraform.tfplan
TF_BACEND_CONFIG_FILE 	= s3_backend.conf

# Default target
.PHONY: all
all: help

# Display help message
.PHONY: help
help:
	@echo "Makefile for ClickHouse Cluster IaC"
	@echo ""
	@echo "Usage:"
	@echo "   make tf-all                # Initialize & Execute"
	@echo "   make tf-init               # Initialize Terraform"
	@echo "   make tf-validate           # Validates Terraform"
	@echo "   make tf-plan               # Generate Terraform execution plan"
	@echo "   make tf-apply              # Apply Terraform changes"
	@echo "   make tf-destroy            # Destroy resources"
	@echo "   make clean                 # Clean Terraform plan files"

# Terraform commands
.PHONY: tf-all
tf-all: tf-init tf-plan tf-apply

.PHONY: tf-init
tf-init:
	@echo "Initializing Terraform..."
	$(TF_BIN) -chdir=$(TF_DIR) init -backend-config $(TF_BACEND_CONFIG_FILE)

.PHONY: tf-validate
tf-validate:
	@echo "Validating Terraform..."
	$(TF_BIN) -chdir=$(TF_DIR) validate

.PHONY: tf-plan
tf-plan:
	@echo "Generating Terraform execution plan..."
	$(TF_BIN) -chdir=$(TF_DIR) plan -var-file=$(TF_VARS_FILE) -out=$(TF_PLAN_FILE)

.PHONY: tf-apply
tf-apply:
	@echo "Applying Terraform plan..."
	$(TF_BIN) -chdir=$(TF_DIR) apply -var-file=$(TF_VARS_FILE) -auto-approve

.PHONY: tf-destroy
tf-destroy:
	@echo "Destroying Terraform-managed infrastructure..."
	$(TF_BIN) -chdir=$(TF_DIR) destroy -var-file=$(TF_VARS_FILE) -auto-approve

# Clean Terraform state files
.PHONY: clean
clean:
	@echo "Cleaning up Terraform plans..."
	rm -f $(TF_PLAN_FILE)
