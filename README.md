# kubernetes-hands-on
Repo with Kubernetes demos, kubenertes patterns, kubernetes gitops


## Kubectl Configuration

```bash
aws eks update-kubeconfig --region eu-west-1 --name kubernetes-demo-cluster --profile outscope-tests

kubectl apply -f https://s3.us-west-2.amazonaws.com/amazon-eks/docs/eks-console-full-access.yaml
```

## Troubleshooting

```bash
kubectl run troubleshooting --image=praqma/network-multitool -i --tty -- sh
```

## Future

Implement Robo Shop With GitOps Principles
Use Flux (GitOps), Loadbalancer and cert manager controller, secrets

## Study

* Flux
* istio, Linkerd, consul, AWS App Mesh
* Envoy
* AWS DevOps Guru
* Knative, Calico
* https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/modules/iam-role-for-service-accounts-eks
* Admission controllers
* Admission webhooks
* Initializers
* PodPresets
