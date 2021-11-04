#!/bin/sh

oc new-project coolstore-shop

oc apply -f coolstore-inventory-app.yaml -n coolstore-shop
oc apply -f coolstore-inventory-db.yaml -n coolstore-shop


### Inventory ###
oc label dc/inventory-database app.openshift.io/runtime=postgresql --overwrite  -n coolstore-shop
oc label dc/inventory-database app.kubernetes.io/part-of=inventory --overwrite  -n coolstore-shop

oc label dc/inventory app.openshift.io/runtime=quarkus --overwrite  -n coolstore-shop
oc label dc/inventory app.kubernetes.io/part-of=inventory --overwrite  -n coolstore-shop

oc annotate dc/inventory app.openshift.io/connects-to=inventory-database --overwrite  -n coolstore-shop


### Catalog ###
oc apply -f coolstore-catalog-app.yaml -n coolstore-shop
oc apply -f coolstore-catalog-db.yaml -n coolstore-shop


oc label dc/catalog-database app.openshift.io/runtime=postgresql --overwrite -n coolstore-shop 
oc label dc/catalog-springboot app.openshift.io/runtime=spring-boot --overwrite -n coolstore-shop 
oc label dc/catalog-database app.kubernetes.io/part-of=catalog --overwrite -n coolstore-shop 
oc label dc/catalog-springboot app.kubernetes.io/part-of=catalog --overwrite -n coolstore-shop 
oc annotate dc/catalog-springboot app.openshift.io/connects-to=catalog-database --overwrite -n coolstore-shop 


### Coolstore ###
oc apply -f role-secret.yaml -n coolstore-shop
oc apply -f coolstore-microservices-db.yaml -n coolstore-shop
oc apply -f coolstore-microservices-app.yaml -n coolstore-shop


oc label dc/coolstore-postgresql app.openshift.io/runtime=postgresql --overwrite -n coolstore-shop 
oc label dc/coolstore app.openshift.io/runtime=jboss --overwrite -n coolstore-shop 
oc label dc/coolstore-postgresql app.kubernetes.io/part-of=coolstore --overwrite -n coolstore-shop 
oc label dc/coolstore app.kubernetes.io/part-of=coolstore --overwrite -n coolstore-shop 
oc annotate dc/coolstore app.openshift.io/connects-to=coolstore-postgresql --overwrite -n coolstore-shop 


CATALOG_BASE_URL="http://$(oc get route.route.openshift.io/catalog-springboot -n coolstore-shop -o 'jsonpath={.spec.host}')//services/products"
oc set env dc/coolstore --env=CATALOG_BASE_URL=$CATALOG_BASE_URL --overwrite=true -n coolstore-shop


### 
oc annotate dc/coolstore app.openshift.io/connects-to=catalog-springboot --overwrite -n coolstore-shop 
oc annotate dc/catalog-springboot app.openshift.io/connects-to=inventory --overwrite -n coolstore-shop 
