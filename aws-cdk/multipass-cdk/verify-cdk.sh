#!/usr/bin/env bash
# Verify that all essential CLI tools are installed and working

set -e

# --- Color setup-tf ---
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
RESET="\e[0m"

check_tool() {
  local name="$1"
  local version_cmd="$2"

  printf "%-15s" "$name"
  if command -v "$name" &>/dev/null; then
    local version_output
    version_output=$(eval "$version_cmd" 2>/dev/null | head -n 1)
    echo -e "${GREEN}OK${RESET} - ${version_output}"
  else
    echo -e "${RED}MISSING${RESET}"
  fi
}

echo -e "\n🔍 Verifying developer tools...\n"

check_tool "aws"              "aws --version"
check_tool "aws-vault"        "aws-vault --version 2>&1"
check_tool "kubectl"          "kubectl version --client"
check_tool "helm"             "helm version --short"
check_tool "docker"           "docker --version"
check_tool "docker-compose"   "docker-compose version"
check_tool "k9s"              "k9s version --short"
check_tool "skopeo"           "skopeo --version"
check_tool "oras"             "oras version"
check_tool "java"             "java --version"
check_tool "mvn"              "mvn -v"
check_tool "cdk"              "cdk --version"
check_tool "chainsaw"         "chainsaw version"

echo -e "\n✅ Verification complete.\n"

