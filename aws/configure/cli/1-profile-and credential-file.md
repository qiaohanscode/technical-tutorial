### Config and Credential files

For more details read [AWS CLI Configuration](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html).

The `config` and `credentials` files are organized into sections. Sections include `profiles`, `sso-sessions` 
and `services`. A section is a named collection of settings and continues until another section definition line is encountered. Multiple profiles and sections can be stored in the `config`and `credentials`files.

These files are plaintext files that use the following format:
- section names are enclosed in brackets `[]`, such as `[default]`, `[profile user1]`and `[sso-session]`.
- all entries in a section take the general form of `setting_name=value`.
- lines can be commented out by starting the line with a hash character `#`.

The __config__ and __credentials__ files contain the following section types:
- profile
- sso-session
- services

### Section type: profile
The __AWS CLI__ stores.

Depending on the file, profile section names use the following format:
- __Config file:__ `[default]` `[profile user1]`
- __Credentials file:__ `[default]` `[user1]`

`Note:` Do not use the word `profile` when creating an entry in the `credentials` file. 

#### IAM role
This example is for assuming an __IAM__ role. Profiles that use __IAM__ roles pull credentials from another profile and 
then apply __IAM__ role permissions. In the following examples, `default` is the source profile for credentials and `user1`
borrows the same credentials then assumes a new roe. For more information, 
see [Use an IAM role in the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-role.html).

#### Long-term credentials
`Note:` to avoid security risks, don't use __IAM__ users for authentication when developing purpose-built software or 
working with real data. Instead, use federation with an identity provider such as __AWS IAM Identity Center__.

This example is for the long-term credentials from __AWS Identity and Access Management__.

__Credentials file__
```
[default]
aws_access_key_id=AKIAIOSFODNN7EXAMPLE
aws_secret_access_key=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY

[user1]
aws_access_key_id=AKIAI44QH8DHBEXAMPLE
aws_secret_access_key=je7MtGbClwBF/2Zp9Utk/h3yCo8nvbEXAMPLEKEY
```
__Config file__
```
[default]
region=us-west-2
output=json

[profile user1]
region=us-east-1
output=text
```
For more information and additional authorization and credentials methods, 
see [Authenticate with IAM user credentials](https://docs.aws.amazon.com/cli/latest/userguide/cli-authentication-user.html).

### Where are configuration settings sotred?
The __AWS CLI__ stores sensitive credential information that you specify with `aws configure` in a local file named 
`credentials` in a folder named `.aws` in your home directory. The less sensitive configuration options that you specify 
with `aws configure` are stored in a local file named `config` also stored in the `.aws` folder in your home directory.

You can specify a non-default location for the files by setting the `AWS_CONFIG_FILE` and `AWS_SHARED_CREDENTIALS_FILE`
environment varialbes to another local path.

When you use a shared profile that specifies an __AWS Identity and Access Management (IAM)__ role, the __AWS CLI__ calls 
the __AWS STS AssumeRole__ operation to retrieve temporary credentials. These credentials are then stored 
(in `~/.aws/cli/cache`). Subsequent __AWS CLI__ commands use the cached temporary credentials until they expire, and at 
that point the __AWS CLI__ automatically refreshes the credentials.
### Using named profiles
If no profile is explicitly defined, the `default` profile is used. To use a named profile, add the option 
`--profile profile-name` to your command.
```
/* 
 lists all of your Amazon EC2 instances using the credentials and settings 
 defined in the user1 profile
*/
aws ec2 describe-instances --profile user1
```
Setting the `AWS_PROFILE` environment variable as the default profile which will be used for multiple commands.
```
export AWS_PROFILE=user1
```

### Set and view configuration settings

### aws configure
Run this commnd to quicky set and view your credentials, Region and output format.
```
$ aws configure --profile dev-int
AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
Default region name [None]: us-west-2
Default output format [None]: json
```

### aws configure set
Set any credentials or configuration settings using `aws configure set`.
```
aws configure set region us-west-2 --profile dev-int
```

### aws configure get 
retrieve any credentials or configuration settings you've set using `aws configure get`.
```
aws configure get region --profile dev-int
```
If the output is empty, the settings is not explicitly set and used the default value.

### List configuration data
```
aws configure list
```

### List all your profile names
```
aws configure list-profiles
```
