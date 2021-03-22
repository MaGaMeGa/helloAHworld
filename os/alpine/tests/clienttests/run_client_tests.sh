#!/bin/sh

## INIT 
## INIT --- 1 ---  DEFINE CLIENT SYSTEM NAMES
CONSUMER_SYSTEM_NAME="alpine1consumer"
PROVIDER_SYSTEM_NAME="alpine1provider"

## INIT --- 2 ---  DEFINE PROVIDED SERVICE NAME
PROVIDED_SERVICE="helloworld"

## STEP 0 --- INITIALIZE DIRECTORIES
mkdir $CONSUMER_SYSTEM_NAME
mkdir $PROVIDER_SYSTEM_NAME

## STEP 1 --- REQUEST A CERTIFICATE FOR THE CONSUMER SYSTEM
$PWD/clienttools/requestCertificate.sh $CONSUMER_SYSTEM_NAME  

## STEP 2 --- USE MANAGEMENT TOOL TO REGISTER SYSTEM 

## STEP 2 a --- GET NORMALIZED PUBLIC KEY 
## FOR AUTHINFO PARAM OF SYSTEM REGISTRATION
CONSUMER_AUTHINFO="$( cat $PWD/$CONSUMER_SYSTEM_NAME/$CONSUMER_SYSTEM_NAME.pub.authinfo)"

## STEP 2 b --- CALL MANAGEMENT TOOLS SYSTEM REGISTRATION
cd ./managementtool
$PWD/register_system.sh "${CONSUMER_SYSTEM_NAME}" "${CONSUMER_AUTHINFO}" 
cd ../

## STEP 3 --- REQUEST a CERTIFICATE FOR THE PROVIDER SYSTEM
$PWD/clienttools/requestCertificate.sh $PROVIDER_SYSTEM_NAME  

## STEP 4 --- REGISTER SERVICE / AND PROVIDER SYSTEM
cp $PWD/clienttools/register_service.sh $PWD/$PROVIDER_SYSTEM_NAME  
cp $PWD/clienttools/start_service.sh $PWD/$PROVIDER_SYSTEM_NAME  
cp $PWD/templates/register_service.request.template $PWD/$PROVIDER_SYSTEM_NAME  
cp $PWD/templates/server.template $PWD/$PROVIDER_SYSTEM_NAME  
cp $PWD/templates/provider.service.template $PWD/$PROVIDER_SYSTEM_NAME  
cp $PWD/templates/helloworld.content.template $PWD/$PROVIDER_SYSTEM_NAME  

cd $PWD/$PROVIDER_SYSTEM_NAME  
$PWD/start_service.sh "${PROVIDER_SYSTEM_NAME}" "${PROVIDED_SERVICE}"
$PWD/register_service.sh "${PROVIDER_SYSTEM_NAME}" "${PROVIDED_SERVICE}"
cd ../

## CREATE AUTHORIZATION POLICY
cd ./managementtool
$PWD/create_auth_policy.sh "${CONSUMER_SYSTEM_NAME}" "${PROVIDER_SYSTEM_NAME}" "${PROVIDED_SERVICE}"
cd ../

## AS CONSUMER -- QUERY SERVCIE_REGISTRY FOR ORCHESTRATION SERVICE

cp $PWD/clienttools/query_serviceregistry.sh $PWD/$CONSUMER_SYSTEM_NAME
cp $PWD/templates/sr_entry.request.template $PWD/$CONSUMER_SYSTEM_NAME

cd $PWD/$CONSUMER_SYSTEM_NAME

$PWD/query_serviceregistry.sh "${CONSUMER_SYSTEM_NAME}" "orchestration-service"
$PWD/start_orchestration.sh "${CONSUMER_SYSTEM_NAME}" "${PROVIDED_SERVICE}"

$PWD/consume_service.sh

cat $PWD/$PROVIDED_SERVICE
