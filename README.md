"create aws resources using terraform"

It creates following AWS resources;

- 1 vpc,
- 1 public subnet,
- 1 prviate subnet,
- 1 Internet Gateway,
- 1 Security Group,
- 2 ec2 instances

Once you clone this repo, please execute follow commands

'''ssh-keygen -f dev-region-key-pair (on same location where you have above .tf files)
terraform init
terraform plan -out terraform.out
terraform apply -vars 'region=<region_name>'
In case of destroy
terraform destroy -vars 'region=<region_name>''''
