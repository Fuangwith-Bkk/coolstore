# coolstore
![UI](images/coolstore-ui.png)

## Monolith 
Monolithic architecture 1 app and 1 database for whole coolstore shop.

[Steps to deploy](1.coolstore-monolith/README.md)

![monolith](images/monolith-project.png)

## Microservices
Breaking the monolithic architecture to 
- Inventory service developed by Quarkus (2.coolstore-inventory)
- Catalog service developed by Spring-Boot (3.coolstore-catalog)
- Frontend (4.coolstore-microservices)

[Step to deploy](4.coolstore-microservices/README.md)

![projects](images/microservices-projects.png)

## Microservices All-in-one
Deploy microservices app in single project. (5.coolstore-all-in-one)
![All-in-one](images/all-in-one-topology.png)