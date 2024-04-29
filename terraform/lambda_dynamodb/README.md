# Instruction

This is simple instruction of how to deploy the lambda function using terraform

## (1) Pre-requistic

You will need to have AWS account and prepare the credential document as following directory

```
vim ~/.aws/credentials
```

And make sure following is filled 
```
[default]
aws_access_key_id = YOUR_ACCESS_KEY_ID
aws_secret_access_key = YOUR_SECRET_ACCESS_KEY
```

## (2) Execution
Run following code to apply the lambda function to AWS
```
terraform init
terraform plan 
terraform apply
```
