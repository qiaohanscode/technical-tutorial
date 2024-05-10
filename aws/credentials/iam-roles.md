### Overview of using IAM roles
You can configure the AWS Command Line Interface (AWS CLI) to use an IAM role by defining a profile for the role in 
the `~/.aws/config` file.

The following example shows a role profile named `markeingadmin`. By running comands with `--profile marketingadmin` 
(or specify it with `AWS_PROFILE` environment variable), the AWS CLI uses the credentials defined in a separate profile
`user1` to assume the role with the Amazon Resource Name (ARN) `arn:aws:iam::123456789012:role/marketingadminrole`. 
You can run any operations that are allowed by the permissions assigned to that role.
```
[profile marketingadmin]
role_arn = arn:aws:iam::123456789012:role/marketingadminrole
source_profile = user1
```
You can then specify a `source_profile` that points to a separate named profile that contins user credentials with 
permission to use the role.

