# Magento 2 on AWS with Terraform

## What this repository is

This repo creates an infrastructure to host Magento 2 application on AWS Thisinfrastructure consists of 2 servers: caching server and server which will host Magento application. The entry point to the infrastructure will be AWS load-balancer, which will be terminating SSL and taking care of correct routing. You will need to describe infrastructure as code using Terraform

## Pre Requisites
