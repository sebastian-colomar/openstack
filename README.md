# openstack

1. Create the infrastructure in AWS

    All the following steps will be performed from an AWS Cloud9 terminal with enough privileges (AdministratorAccess will work):
    ```
    git clone https://github.com/academiaonline/openstack --single-branch -b main
    location=openstack/etc/aws/microstack.yaml
    aws cloudformation create-stack --stack-name openstack-$( date +%s ) --template-body file://$location --capabilities CAPABILITY_NAMED_IAM
    ```
    
1. Check the default installation

    After the last step is finished you will have one (master) controller node and three (worker) compute nodes with a basic Openstack installation.
    The controller node is already initialized and you can access the (horizon) dashboard at this (default) URL:
    * HTTPS://OPENSTACK-DASHBOARD.SEBASTIAN-COLOMAR.COM
    * USERNAME: admin
    * PASSWORD: ???
    
    You will need to retrieve the password to access the dashboard.
    For that purpose you will open a Session Manager connection to the controller node in AWS (InstanceMaster1) and run the following command:
    ```
    sudo snap get microstack config.credentials.keystone-password
    ```

    There is currently only one node in the cluster.

1. Join more members to the Openstack cluster

    In order to add more members to the cluster please run the following command in the master node:
    ```
    sudo microstack add-compute
    ```
    Afterwards you will need to run the following command in each worker node:
    ```
    sudo microstack init --auto --compute --join <connection-string>
    ```
