## Checking Cloud-Init Build Logs in Multipass

When launching a Multipass instance with a `--cloud-init` file, you can inspect the provisioning status and logs directly inside the VM.

### 1. Connect to the instance

```bash
multipass shell <instance-name>
# Example:
# multipass shell pfn-cdk-adm
```

### 2. Check cloud-init status

```bash
sudo cloud-init status --long
```

This shows whether initialization has completed successfully or is still running.

### 3. View cloud-init logs

#### Main log (internal cloud-init operations)

```bash
sudo less /var/log/cloud-init.log
```

#### Output log (commands, installs, user-data output)

```bash
sudo less /var/log/cloud-init-output.log
```

> Tip: The `cloud-init-output.log` file is the best place to look for provisioning errors, such as failed package installs or script issues.
