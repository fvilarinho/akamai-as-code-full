Getting Started
---------------

### Introduction
This is a demo project for education/training purposes of DevOps.

It automates (using **Terraform**) the provisioning of a static website using the following resources in Akamai 
Connected Cloud (former Linode):
- **Object Storage**: S3 compliant object storage.

Please check the files `iac/linode*.tf` for more details.

Then, It starts the provisioning of the Akamai Intelligent Platform resources that includes:
- **CP Code**: Creates the identifier used for reporting and billing of the CDN traffic. (Please check the file 
`iac/akamai-cpcode.tf` for more details).
- **Edge Hostname**: Creates the CDN hostname that will receive the traffic of the website. (Please check the file
  `iac/akamai-edgehostname.tf` for more details).
- **Edge Certificate**: Creates the CDN TLS certificate used to enable HTTPs traffic of the website. (Please check the 
file `iac/akamai-cps.tf` for more details).
- **Edge DNS entries**: Creates all required DNS entries in the Edge DNS service to validate/point to the CDN
configuration. (Please check the file `iac/akamai-edgedns.tf` for more details).
- **Property**: Creates the CDN configuration containing all rules such as: caching, redirect, performance settings, 
etc. (Please check the file `iac/akamai-property.tf` for more details). 
- **Security**: Creates the Security configuration containing all protections such as: Network Lists, DDoS, IP/GEO firewall, WAF, 
Bot Management, etc. (Please check the file `iac/akamai-security*.tf` for more details).

All the Terraform files use `variables` that are stored in the `iac/variables.tf`, `iac/general/settings.json`, 
`iac/certificate/settings.json`, `iac/dns/settings.json`, `iac/property/settings.json` and 
`iac/security/settings.json`. 

You can change the attributes of the provisioning by editing these files. 

### Workflow

The workflow will start automatically in every commit of changes in this project, starting the execution of a CI/CD 
pipeline configured in **Jenkins**. Please check this [repo](https://github.com/fvilarinho/cicdzerotohero) to see how to 
provision the CI/CD pipeline.

The provisioning state is stored in the **Object Storage** (that should be provisioned in advance). By default, it uses 
Akamai Connected Cloud, but you can change to any provider you want.

### Documentation

Follow the documentation below to know more about Akamai:

- [**How to create Akamai EdgeGrid credentials**](https://techdocs.akamai.com/developer/docs/make-your-first-api-call)
- [**How to create Akamai Connected Cloud credentials**](https://www.linode.com/docs/api)
- [**How to create an Object Storage**](https://www.linode.com/docs/guides/platform/object-storage)
- [**List of Akamai Connected Cloud Regions**](https://www.linode.com/docs/api/regions/)
- [**Akamai Techdocs**](https://techdocs.akamai.com)
- [**Akamai Connected Cloud Documentation**](https://www.linode.com/docs/)

### Important notes
- **If any phase got errors or violations, the pipeline will stop.**
- **DON'T EXPOSE OR COMMIT ANY SENSITIVE DATA, SUCH AS CREDENTIALS, IN THE PROJECT.**

### Contact
**LinkedIn:**
- https://www.linkedin.com/in/fvilarinho

**e-Mail:**
- fvilarin@akamai.com
- fvilarinho@gmail.com
- fvilarinho@outlook.com
- me@vila.net.br

and that's all! Have fun!