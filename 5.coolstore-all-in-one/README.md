# Steps to deploy the Cool Store Shop microservices architecture

```bash
  oc login -u <username> -p <password> <OpenShift API URL>
  cd 5.coolstore-all-in-one
  ./deploy.sh
```

There are 3 projects (namespace) for each service:
## [coolstore-shop project]
### Files
- Folder `5.coolstore-all-in-one`
  - `coolstore-inventory-db.yaml`: YAML file for deploying Postgresql database and creating Service of the database.
  -  `coolstore-inventory-app.yaml`: YAML file for deploying the Cool Store application and creating Service and Route.
  - `coolstore-catalog-db.yaml`: YAML file for deploying Postgresql database and creating Service of the database.
  -  `coolstore-catalog-app.yaml`: YAML file for deploying the Cool Store application and creating Service and Route.
  - `coolstore-microservices-db.yaml`: YAML file for deploying Postgresql database and creating Service of the database.
  -  `coolstore-microservices-app.yaml`: YAML file for deploying the Cool Store application and creating Service and Route.
  -  `role-secret.yaml`: YAML for creating RoleBinding, Secret, and ServiceAccount
  -  `deploy.sh`: shell script to deploy all services.


### Container Images
- https://quay.io/repository/fuangwit/coolstore-inventory
- https://quay.io/repository/fuangwit/coolstore-catalog
- https://quay.io/repository/fuangwit/coolstore-microservices


---
[Back to homepage](https://github.com/Fuangwith-Bkk/coolstore)