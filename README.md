# openstack

1. Create the infrastructure in AWS

    All the following steps will be performed from an AWS Cloud9 terminal with enough privileges (AdministratorAccess will work):
    ```
    git clone https://github.com/academiaonline/openstack --single-branch -b main
    location=openstack/etc/aws/microstack.yaml
    aws cloudformation create-stack --stack-name openstack-$( date +%s ) --template-body file://$location --capabilities CAPABILITY_NAMED_IAM
    ```

