--- in progress / poc scripts --- 

# Simple Arrowhead Framework example

The goal of the project is to demonstarte a simple setup and running a basic scenario.<br />
***
## The scenario:<br />
  - Given the mandatory core systems (service registry, authorization, orchestrator ) are present and functioning correctly,<br />
   And provider system B present and registered in the service registry as a provider of HelloWorld service <br />
   And in the authorization system a valid authorization policy present,<br />
    for the consumer system A to consume the HelloWorld service form the provider system B <br />
   And the consumer know the address and port of the service registry <br />
  - When the consumer system A want to consume the HelloWorld service, <br />
  - Then the cunsumer system A query the service registy for the orchestration service endpoint<br />
  And the cunsumer system A receives the orchestration endpoint details <br />
  And the cunsumer system A send an orchestration request for the HelloWorld service endpoint to the orchetration endpoint<br />
  And the cunsumer system A receives the HelloWorld service endpoint details<br />
  And the cunsumer system A send a HelloWorld service request to the HelloWorld service endpoint <br />
  And the cunsumer system A receives a HelloWorld service response <br />
***
## How to run?
- Follow the [installation step instructions ](https://github.com/MaGaMeGa/helloAHworld/blob/main/os/docs/installation_steps.md) to set up and start the pre configured environment
- Once the enviroment is up type the following to the terminal and press enter/return : <br /> ```cd /home/ah/tests/clienttests && ./run_client_tests.sh ``` 

## What is going on?

- Diagram of the general steps in the process [HERE](https://github.com/MaGaMeGa/helloAHworld/blob/main/os/docs/client_test_steps.txt)
- General sequence diagram [HERE](https://github.com/MaGaMeGa/helloAHworld/blob/main/os/docs/client_test_sequence_overview.txt)
- Detailed sequence diagram of steps [COMMING SOON ...]
