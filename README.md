# kubernetes-hands-on
Repo with Kubernetes demos, kubenertes patterns, kubernetes gitops


## Kubectl Configuration

```bash
aws eks update-kubeconfig --region eu-west-1 --name kubernetes-demo-cluster --profile outscope-tests

kubectl apply -f https://s3.us-west-2.amazonaws.com/amazon-eks/docs/eks-console-full-access.yaml
```


## WIP

* Refactoring Terraform kubernetes code to use terraform-aws-eks module
