#!/bin/sh


oc new-project coolstore-microservices



oc apply -f role-secret.yaml -n coolstore-microservices
oc apply -f coolstore-microservices-db.yaml -n coolstore-microservices
oc apply -f coolstore-microservices-app.yaml -n coolstore-microservices


oc label dc/coolstore-postgresql app.openshift.io/runtime=postgresql --overwrite -n coolstore-microservices 
oc label dc/coolstore app.openshift.io/runtime=jboss --overwrite -n coolstore-microservices 
oc label dc/coolstore-postgresql app.kubernetes.io/part-of=coolstore --overwrite -n coolstore-microservices 
oc label dc/coolstore app.kubernetes.io/part-of=coolstore --overwrite -n coolstore-microservices 
oc annotate dc/coolstore app.openshift.io/connects-to=coolstore-postgresql --overwrite -n coolstore-microservices 


CATALOG_BASE_URL="http://$(oc get route.route.openshift.io/catalog-springboot -n coolstore-catalog -o 'jsonpath={.spec.host}')/services/products"
oc set env dc/coolstore --env=CATALOG_BASE_URL=$CATALOG_BASE_URL --overwrite=true -n coolstore-microservices