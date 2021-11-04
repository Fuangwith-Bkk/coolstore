
#!/bin/sh

oc new-project coolstore-monolith

oc apply -f role-secret.yaml -n coolstore-monolith
oc apply -f coolstore-monolith-db.yaml -n coolstore-monolith
oc apply -f coolstore-monolith-app.yaml -n coolstore-monolith


oc label dc/coolstore-postgresql app.openshift.io/runtime=postgresql --overwrite -n coolstore-monolith 
oc label dc/coolstore app.openshift.io/runtime=jboss --overwrite -n coolstore-monolith 
oc label dc/coolstore-postgresql app.kubernetes.io/part-of=coolstore --overwrite -n coolstore-monolith 
oc label dc/coolstore app.kubernetes.io/part-of=coolstore --overwrite -n coolstore-monolith 
oc annotate dc/coolstore app.openshift.io/connects-to=coolstore-postgresql --overwrite -n coolstore-monolith 


#oc annotate dc/coolstore app.openshift.io/vcs-uri=https://github.com/RedHat-Middleware-Workshops/cloud-native-workshop-v2m1-labs.git --overwrite -n coolstore-monolith 
#oc annotate dc/coolstore app.openshift.io/vcs-ref=ocp-4.7 --overwrite -n coolstore-monolith