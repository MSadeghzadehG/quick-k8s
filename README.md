# quick-k8s
Aliases and commands for faster k8s experience.

### Aliases:
- ```k``` -> kubectl
- ```kd``` -> kubectl describe
- ```kswitch``` -> kubectl config use-context

### Commands:
- ```ke <pod>```:
filter the pods that have names starts with ```<pod>``` and selects one of them randomly. then get the shell of selected pod using ```kubectl exec -it <selected pod> bash```.
