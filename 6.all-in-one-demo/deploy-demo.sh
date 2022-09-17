#!/bin/sh

NAMESPACE='ztest'

#oc new-project $NAMESPACE

### Inventory ###

oc label deployment.apps/inventory-database app.openshift.io/runtime=postgresql --overwrite  -n $NAMESPACE
oc label deployment.apps/inventory-database app.kubernetes.io/part-of=inventory --overwrite  -n $NAMESPACE

oc label deployment.apps/inventory app.openshift.io/runtime=quarkus --overwrite  -n $NAMESPACE
oc label deployment.apps/inventory app.kubernetes.io/part-of=inventory --overwrite  -n $NAMESPACE

oc annotate deployment.apps/inventory app.openshift.io/connects-to=inventory-database  -n $NAMESPACE


### Catalog ###
oc label dc/catalog-database app.openshift.io/runtime=postgresql --overwrite -n $NAMESPACE
oc label deployment.apps/catalog-service app.openshift.io/runtime=spring-boot --overwrite -n $NAMESPACE
oc label dc/catalog-database app.kubernetes.io/part-of=catalog --overwrite -n $NAMESPACE
oc label deployment.apps/catalog-service app.kubernetes.io/part-of=catalog --overwrite -n $NAMESPACE
oc annotate deployment.apps/catalog-service app.openshift.io/connects-to=catalog-database -n $NAMESPACE

#oc set env deployment.apps/catalog-service  --env=inventory.url='inventory.$NAMESPACE.svc.cluster.local:8080' --overwrite=true -n coolstore-shop


### Coolstore ###
oc apply -f role-secret.yaml -n $NAMESPACE
oc apply -f coolstore-microservices-db.yaml -n $NAMESPACE
oc apply -f coolstore-microservices-app.yaml -n $NAMESPACE
oc label deployment.apps/coolstore-postgresql app.openshift.io/runtime=postgresql --overwrite -n $NAMESPACE
oc label deployment.apps/coolstore app.openshift.io/runtime=jboss --overwrite -n $NAMESPACE
oc label deployment.apps/coolstore-postgresql app.kubernetes.io/part-of=coolstore --overwrite -n $NAMESPACE
oc label deployment.apps/coolstore app.kubernetes.io/part-of=coolstore --overwrite -n $NAMESPACE
oc annotate deployment.apps/coolstore app.openshift.io/connects-to=coolstore-postgresql -n $NAMESPACE

CATALOG_BASE_URL="https://$(oc get route.route.openshift.io/catalog-service -n $NAMESPACE -o 'jsonpath={.spec.host}')/services/products"
oc set env deployment.apps/coolstore --env=CATALOG_BASE_URL=$CATALOG_BASE_URL --overwrite=true -n $NAMESPACE

### 
oc annotate deployment.apps/coolstore app.openshift.io/connects-to=catalog-service,coolstore-postgresql --overwrite -n $NAMESPACE
oc annotate deployment.apps/catalog-service app.openshift.io/connects-to=inventory,catalog-database --overwrite -n $NAMESPACE














