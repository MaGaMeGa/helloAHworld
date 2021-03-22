--- in progress / poc scripts --- 

Simple Arrowhead Framework example

The goal of the project is to demonstarte a simple setup of basic scenario.
Running the scripts will trigger the following actions: 
- install the neccesery dependencies, 
- configure the db, 
- pull the core systems codebase,  
- build the mandatory core systems, 
- start the core systems,
- generate consumer certificate,
- register consumer system,
- generate provider certificate,
- register provider system and service,
- create authorization rule for consumer-provider-service,
- cunsumer queries serviceregisty for orchestration endpoint,
- consumer queries orchestrator for service,
- consumer consumes provider service.

How to run the scripts:
(at the moment only for Linux Alpine OS)
- startup a fresh openrc enabled Alpine instance in VirtualBox
- run setup alpine
- check /etc/apk/repositories and if not in there add : ``` #http://dl-cdn.alpinelinux.org/alpine/edge/community ```
- check if git is working and if not type: ```apk add git ```
- go to /tmp and type : ``` cd /tmp && git clone https://github.com/MaGaMeGa/helloAHworld ```
- make a home directory for the arrowhead framework : ``` mkdir /home/ah ```
- copy cloned dirs to /home/ah : ``` cp -r /tmp/helloAHworld/os/alpine/* /home/ah ```
- go to home init : ```cd /home/init```
- start the init script : ```bash ./init.sh ```
- once the script finished start core systems : ```bash ./start_ah ```  
- wait till core systems initialize - type ```top ```  and wait till core systems memory usage goes below 20% 
- start the core systems tests: ```cd ../tests && ./run_tests ``` 
- once the core system tests finished, start client tests: ```cd clienttests && ./run_client_tests.sh ``` 
