#!/bin/sh


oc new-project coolstore-catalog

oc apply -f coolstore-catalog-app.yaml -n coolstore-catalog
oc apply -f coolstore-catalog-db.yaml -n coolstore-catalog


oc label dc/catalog-database app.openshift.io/runtime=postgresql --overwrite -n coolstore-catalog 
oc label dc/catalog-springboot app.openshift.io/runtime=spring-boot --overwrite -n coolstore-catalog 
oc label dc/catalog-database app.kubernetes.io/part-of=coolstore --overwrite -n coolstore-catalog 
oc label dc/catalog-springboot app.kubernetes.io/part-of=coolstore --overwrite -n coolstore-catalog 
oc annotate dc/catalog-springboot app.openshift.io/connects-to=catalog-database --overwrite -n coolstore-catalog 



