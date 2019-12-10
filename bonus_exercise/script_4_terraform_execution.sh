#!/bin/bash
cd /tmp
git clone https://github.com/anvesh14/adp-mkpl-test-ramaswamy.git
cd /tmp/adp-mkpl-test-ramaswamy/bonus_exercise
terraform validate 
terraform init /tmp/adp-mkpl-test-ramaswamy/bonus_exercise
terraform plan -out output.logs
aws s3 cp output.logs s3://adp-mkpl-test/terraform_logs
terraform apply output.logs
