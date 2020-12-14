# exportProductCatalogue
Talend Job to export data from postgreSQL database to csv files. 

![alttext](https://github.com/myTalendProjects/Talend-exportProductCatalogue/blob/main/images/TalendJob.PNG?raw=true)


## Import and Build in Talend OpenStudio
This Talend project can be imported and build in Talned open studio for ESB.

![alttext](https://github.com/myTalendProjects/Talend-exportProductCatalogue/blob/main/images/ImportProject.PNG?raw=true)

## Prerequisites

### PostgreSQL database
In this project data in PostgreSQL databse is exported. 
A PostgreSQL database needs to be preconfigured. The database schema `(with sample data)` is included in [database-PostgreSQL](https://github.com/myTalendProjects/Talend-exportProductCatalogue/blob/main/database_PostgreSQL) directory.

### RESTful endpoint for partner information

It is assumed that part of the information `(i.e partner information)` to create export file is comming from RESTful API.
The expected Response is as below

![alttext](https://github.com/myTalendProjects/Talend-exportProductCatalogue/blob/main/images/partner-information.PNG?raw=true)

## Project configuration

Context variables needs to be congured according to the envirionment as mentioned below

| Context Variable | Description  |
| postgresHost | PostgreSQL database host IP| 
| postgresPort | PostgreSQL database port| 
| postgresUser | PostgreSQL database username| 
| postgresPass | PostgreSQL database password| 
| postgresDatabase | PostgreSQL database name| 
| partnerManagementEndPoint | RESTful Endpoint URL to fetch partner information| 
| partnerManagementPartnersRelativePath | Relative path for partner information url| 
| exportOutput | Export file path with file name| 

`Example Configuration`

![alttext](https://github.com/myTalendProjects/Talend-exportProductCatalogue/blob/main/images/Talend-context-Var.PNG?raw=true)


## Export Output

Exported file will be save in configured location.

![alttext](https://github.com/myTalendProjects/Talend-exportProductCatalogue/blob/main/images/Talend-exportFile.PNG?raw=true)

The content of the file will be like below

![alttext](https://github.com/myTalendProjects/Talend-exportProductCatalogue/blob/main/images/csvContent.PNG?raw=true)







