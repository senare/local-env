# Multipass 

[Install Multipass](https://canonical.com/multipass/install)

check your arch 

```bash
# could work ?
arch

# could also work ?
uname -m
```

look for clues as arm64, x86_64 etc ...

NOTE: since I am running ARM (M4 mac i.e. arm64) I never tested the AMD version ...

# create
Select your environment yaml file (XXX) 
```bash
multipass launch --name pfn-cdk \
    --cpus 4 \
    --memory 8G \
    --disk 30G \
    --cloud-init pfn-cdk-XXX.yaml
```

# mount files

```bash
multipass mount  /Users/mannil/pfn/projects pfn-cdk:/home/ubuntu/projects
```

# shell

```bash
multipass shell pfn-cdk
```

# stop

```bash
multipass stop pfn-cdk
```

# delete

```bash
multipass delete pfn-cdk
```


# cleanup

```bash
multipass purge
```
       
---

## aws-vault Configuration

```bash
aws-vault add <profile>

#example
aws-vault add mannil
```

## AWS Configuration

Create or edit `~/.aws/config`:

example for profile/user mannil
```text
[default]
region = us-east-1
output = json

[profile mannil]

[profile pfn-developer]
role_arn = arn:aws:iam::660937123284:role/pfn-developer
source_profile = mannil
mfa_serial = arn:aws:iam::740910365980:mfa/mannil

[profile pfn-ops-sysadmin]
role_arn = arn:aws:iam::660937123284:role/pfn-ops-sysadmin
source_profile = mannil
mfa_serial = arn:aws:iam::740910365980:mfa/mannil

[profile pfn-test-sysadmin]
role_arn = arn:aws:iam::537618593536:role/pfn-test-sysadmin
source_profile = mannil
mfa_serial = arn:aws:iam::740910365980:mfa/mannil
```

----

# Find the cluster

Check correct user/account
```bash
aws sts get-caller-identity
```

Assume role
```bash
aws-vault exec  pfn-test-sysadmin -- bash
```
response ...
```yaml
{
    "UserId": "AROAX2LEQW4ALPVROYAHU:1760001999405075145",
    "Account": "537618593536",
    "Arn": "arn:aws:sts::537618593536:assumed-role/pfn-test-sysadmin/1760001999405075145"
}
```

List EKS
```bash
aws eks list-clusters
```
response ...
```yaml
{
    "clusters": [   
        "EksClusterFAB68BDB-e4756888270248f2bf9b6d3efe257d13"
    ]
}
```

Describe cluster
```bash
aws eks describe-cluster --name EksClusterFAB68BDB-e4756888270248f2bf9b6d3efe257d13
```

# Access cluster 

We should be allowed to fecth credentials using ...
```bash
aws eks update-kubeconfig --name EksClusterFAB68BDB-e4756888270248f2bf9b6d3efe257d13
```


... we didn't grant any one access so only 'stack' got access i.e. 


```bash 
aws cloudformation describe-stacks --stack-name PfnEksStack --query "Stacks[0].RoleARN" --output text
  
  arn:aws:iam::537618593536:role/cdk-hnb659fds-cfn-exec-role-537618593536-eu-central-1
```

redeploy and try again ?

mvn compile
cdk synth
cdk deploy
