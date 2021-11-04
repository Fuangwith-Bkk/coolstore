# Steps to deploy the Cool Store Shop microservices architecture

```bash
  oc login -u <username> -p <password> <OpenShift API URL>
  cd 2.coolstore-inventory
  ./deploy.sh
  cd ..
  cd 3.coolstore-catalog
  ./deploy.sh
  cd ..
  cd 4.coolstore-microservices
  ./deploy.sh
```

There are 3 projects (namespace) for each service:
## [coolstore-inventory project]
### Files
- Folder `2.coolstore-inventory`
  - `coolstore-inventory-db.yaml`: YAML file for deploying Postgresql database and creating Service of the database.
  -  `coolstore-inventory-app.yaml`: YAML file for deploying the Cool Store application and creating Service and Route.
  -  `deploy.sh`: shell script to deploy the inventory services.

## [coolstore-catalog project]
### Files
- Folder `3.coolstore-catalog`
  - `coolstore-catalog-db.yaml`: YAML file for deploying Postgresql database and creating Service of the database.
  -  `coolstore-catalog-app.yaml`: YAML file for deploying the Cool Store application and creating Service and Route.
  -  `deploy.sh`: shell script to deploy the catalog services.

## [coolstore-microservices project]
### Files
- Folder `4.coolstore-microservices`
  - `coolstore-microservices-db.yaml`: YAML file for deploying Postgresql database and creating Service of the database.
  -  `coolstore-microservices-app.yaml`: YAML file for deploying the Cool Store application and creating Service and Route.
  -  `role-secret.yaml`: YAML for creating RoleBinding, Secret, and ServiceAccount
  -  `deploy.sh`: shell script to deploy the catalog services.



### Container Image
https://quay.io/repository/fuangwit/coolstore-inventory

https://quay.io/repository/fuangwit/coolstore-catalog

https://quay.io/repository/fuangwit/coolstore-microservices


---
[Back to homepage](https://github.com/Fuangwith-Bkk/coolstore)