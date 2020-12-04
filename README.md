# API Connect on Cloud Devops pipeline



Create a new Toolchain with these Tools

- GitHub Enterprise Whitewater
- Delivery Pipeline
 
 ![alt](img/toolchain.png)
 

## Configure Github
-----
Repository type: <exiting or new>
Repository URL: https://github.com/fdut/apiconcloud-devops

Check or not :

- Enable GitHub Issues
- Track deployment of code changes


## Configure pipeline
-----

## Stage : Publish Product

### Input

Input Settings :

Input Type : **Git Repository**


Git repository: **apiconcloud-devops**

Git URL : **https://github.com/fdut/apiconcloud-devops**

Branch **Master**


Stage Trigger --

**Run jobs only when this stage is run manually**

### Job

Title : **Publish to Sandbox**

Builder Type (Build) : **npm**

Build script

```
scripts/publish_to_sandbox.sh
```

![Publish](img/stage-publish.jpg)

### Environment properties

```
(secure property)
- apikey : **.............................**
```

(optional to replace apic.properties values)
```
(Text property)
- apiserver
- catalog
- org 
```
 
![Publish](img/environment-variable.jpg)
