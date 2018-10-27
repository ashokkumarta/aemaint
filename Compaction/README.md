# AEM - Compaction Maintenance Job


## Need for performing compaction

For smooth and efficient running of AEM instances, it�s essential to do 
offline tar compaction periodically.  Not doing this periodically 
would load to 

+ Growing tar file size leading to disk space outage. 
+ It also has an impact on the performance
+ Running Tar Compaction after long gap might lead to the compaction 
process taking a long time to complete
+ Compaction process takes space and when run after a long gap, 
the available disk space not sufficient to complete the compaction process
+ Also not running compaction periodically might lead to repository corruption


## Approach

The most efficient compaction process for the tar repository is to use 
the oak-run tool. This requires AEM to be shutdown before the compaction is run. 


## About this tool

This tool is a set of scripts that 

+ Stops the AEM instance, waits till AEM is fully shutdown
+ Triggers the offline compaction process. This process has 3 steps
	+ Lists all the checkpoints in the repository and logs them for future reference
	+ Removes all the unreferenced checkpoints
	+ Performs the compaction operation
+ Starts the AEM instance, waits till the AEM is fully started and reports success


## Advantages

This tool automates the manual process of stopping, running the compaction process 
and starting the instance. 

The operations are asynchronous which requires grepping the process id or log file to 
identify if the operation is successful. 

Apart from running the full compaction on the repository, this process also check is 
the step is fully completed before reporting it as success and moving to the next step  

This helps when integrating with automatic scheduling systems like Jenkins 


## Using the tool

To run this tool

+ Copy this scripts to the server on which AEM is running
+ Download or copy oak-run jar into the same path
+ Invoke the aem-compaction-run.sh script passing to it the following parameters

```
	aem-host:  hostname on which AEM is running
	aem-port:  port on AEM is running
	admin-id:  AEM admin user id
	admin-passwd:  AEM admin password
	aem-crx-quickstart-path: The base path at which AEM is installed
```

Sample command 
`./aem-compaction-run.sh localhost 4503 admin admin /opt/aem/crx-quickstart`


## Other uses

The stop and start scripts can be used separately to shutdown or bring up the server.


## Notes

Where multiple AEM instances are deployed as shared nothing clones, 
compaction needs to be run on each instance

Schedule to run this compaction when there is minimal load on AEM. 

For larger deployments, this might require coordination to remove one instance at a time 
off the load balancer to perform compaction

Frequency for running compaction depends on the usage and repository growth pattern. 

Start with monthly frequency or at a trigger of 25% increase in repository size if the 
growth pattern cannot be predicted in advance


## Caution

>Based on the deployment configuration and usage of AEM, some additional steps might be 
required to be performed before running the compaction. 

>Validate your environment specific requirements before using this tool 

---
> Environment Tested on:  AEM6.1, RHEL5 
