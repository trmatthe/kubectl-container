# kubectl-container

These are the files used in my project to build a k8s-deployable container that 
builds a kubeconfig when scheduled, using a serviceaccount token assigned to the
Pod. The Pod serviceaccount RoleBindings control its API access rights.

It's basically docker/shell/k8s golfing to avoid publishing a kubeconfig

¯\\_(ツ)_/¯ 

Public domain license - feel free to do what you want with this.
