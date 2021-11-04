#!/bin/sh

oc new-project coolstore-inventory

oc apply -f coolstore-inventory-app.yaml -n coolstore-inventory
oc apply -f coolstore-inventory-db.yaml -n coolstore-inventory

oc label dc/inventory-database app.openshift.io/runtime=postgresql --overwrite  -n coolstore-inventory
oc label dc/inventory-database app.kubernetes.io/part-of=coolstore --overwrite  -n coolstore-inventory

oc label dc/inventory app.openshift.io/runtime=quarkus --overwrite  -n coolstore-inventory
oc label dc/inventory app.kubernetes.io/part-of=coolstore --overwrite  -n coolstore-inventory

oc annotate dc/inventory app.openshift.io/connects-to=inventory-database --overwrite  -n coolstore-inventory