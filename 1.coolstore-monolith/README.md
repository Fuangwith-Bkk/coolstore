# Steps to deploy the Cool Store Shop monolitic architecture

```bash
  oc login -u <username> -p <password> <OpenShift API URL>
  cd 1.coolstore-monolith
  ./deploy.sh
```


## Files
- `role-secret.yaml`: YAML file for creating RoleBinding, ServiceAccount, and Secret
- `coolstore-monolith-db.yaml`: YAML file for deploying Postgresql database and creating Service of the database.
-  `coolstore-monolith-app.yaml`: YAML file for deploying the Cool Store application and creating Service and Route.
-  `deploy.sh`: shell script to deploy the application.

### Container Image
https://quay.io/repository/fuangwit/coolstore-monolith

---
[Back to homepage](https://github.com/Fuangwith-Bkk/coolstore)