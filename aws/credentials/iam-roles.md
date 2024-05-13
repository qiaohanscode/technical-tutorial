### Overview of using IAM roles
You can configure the AWS Command Line Interface (AWS CLI) to use an IAM role by defining a profile for the role in 
the `~/.aws/config` file.

The following example shows a role profile named `markeingadmin`. By running commands with `--profile marketingadmin`
(or specify it with `AWS_PROFILE` environment variable), the AWS CLI uses the credentials defined in a separate profile
`user1` to assume the role with the Amazon Resource Name (ARN) `arn:aws:iam::123456789012:role/marketingadminrole`.


`Note:` It means, the available permissions of `IAM Role ARN` will be determined by the permissions attached to 
the profile `user1`.

You can run any operations that are allowed by the permissions assigned to that role.
```
[profile marketingadmin]
role_arn = arn:aws:iam::123456789012:role/marketingadminrole
source_profile = user1
```
You can then specify a `source_profile` that points to a separate named profile that contins user credentials with 
permission to use the role. By using the profile `marketingadmin`, the `AWS CLI` automatically looks up the credentials
for the linked `user1` profile and uses them to request temporary credentials for the specified `IAM` role. the__CLI__
uses the `sts:AssumeRole` operaion in the background to accomplish this. Those temporary credentials are then used to 
run the requested `AWS CLI` command. The specified role must have attached `IAM` permission policies that allow the 
requested `AWS CLI` command to run. 

