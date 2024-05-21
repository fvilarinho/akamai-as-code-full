Getting Started
---------------

### Introduction
This is a demo project for education/training purposes of DevOps.
It automates (using **Terraform**) the provisioning of a static website using the following resources in Akamai 
Cloud Computing (former Linode) environment:
- **Object Storage**: S3 compliant object storage.

Please check the files `iac/linode*.tf` for more details.

It also do the the provisioning of the Akamai Edge resources that includes:
- **CP Code**: Identifier used for reporting and billing of the traffic. (Please check the file`iac/akamai-cpcode.tf` 
for more details).
- **Edge Hostname**: Hostname that will deliver the content of the website. (Please check the file 
`iac/akamai-edgehostname.tf` for more details).
- **Edge DNS entries**: All required DNS entries to validate the TLS certificate and also point to websiteto the Edge
Hostname. (Please check the file `iac/akamai-edgedns.tf` for more details).
- **Property**: Configuration that contains the delivery rules such as: caching, redirect, performance settings, etc. 
(Please check the file `iac/akamai-property.tf` for more details). 
- **Security**: Configuration that contains all security protections such as: Network Lists, DDoS, IP/GEO firewall, WAF, 
Bot Management, etc. (Please check the file `iac/akamai-security*.tf` for more details).

All the Terraform files use `variables` that are stored in the `iac/variables.tf`, `iac/general/settings.json`, 
`iac/dns/settings.json`, `iac/property/settings.json` and `iac/security/settings.json`.

The tokens and credentials must be defined in `iac/.credentials` file. Please follow the template 
`iac/.credentials.template`.

You can customize the provisioning by editing these files.  Use the template as base.

### Requirements
- [`Terraform 1.5.x`](https://www.terraform.io) - IaC automation tool.
- [`Akamai Cloud Computing account`](https://cloud.linode.com)
- `Any linux distribution with Kernel 5.x or later` or
- `MacOS - Catalina or later` or
- `MS-Windows 10 or later with WSL2`

### Workflow

The workflow will start automatically in every commit of changes in this project, starting the execution of a CI/CD 
pipeline configured in **Jenkins**. Please check this [repo](https://github.com/fvilarinho/cicdzerotohero) to see how to provision the CI/CD pipeline.

The provisioning state is stored in an **Object Storage** (that should be provisioned in advance). By default, it uses 
Akamai Cloud Computing, but you can use any other provider compatible with S3.

### Documentation

Follow the documentation below to know more about Akamai:

- [**Akamai Techdocs**](https://techdocs.akamai.com)
- [**How to create Akamai EdgeGrid credentials**](https://techdocs.akamai.com/developer/docs/make-your-first-api-call)
- [**How to create Akamai Cloud Computing credentials**](https://www.linode.com/docs/api)
- [**How to create an Akamai Cloud Computing Object Storage**](https://www.linode.com/docs/guides/platform/object-storage)
- [**List of Akamai Cloud Computing Regions**](https://www.linode.com/docs/api/regions/)
- [**Akamai Cloud Computing Documentation**](https://www.linode.com/docs/)

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