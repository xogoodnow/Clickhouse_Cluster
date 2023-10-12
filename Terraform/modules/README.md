## What does main.tf do
* Creates ssh keys 
* Creates servers according to specification in the module
* Creates volumes for each Clickhouse node according to specification
* Runs the ansible to set up the Clickhouse cluster

> **Note**
> Remember to add terraform.tfvars
> 
