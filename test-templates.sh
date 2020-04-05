#!/bin/bash

set -eu

cluster_name="test-cluster"
aws_account="xxx"

echo "Lint Test"
echo ""
helm lint wonderchart

echo ""
aws eks update-kubeconfig --name ${cluster_name} --region eu-central-1
kubectl config use-context arn:aws:eks:eu-central-1:${aws_account}:cluster/${cluster_name}

echo ""
echo ""
echo "Testing basic template structure"
echo ""
helm upgrade -i test-template wonderchart -f test/values.yaml --debug --dry-run
echo ""


echo ""
echo ""
echo "#### Deploying Test Chart ####"
echo ""
helm upgrade -i test-template wonderchart -f test/values.yaml
echo ""
