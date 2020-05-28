# quick-k8s
Aliases and commands for faster k8s experience.

### How to Use
If you are using oh-my-zsh, You should just clone the repository and symlink your ```quick-k8s.sh``` file in the custom dir with ```.zsh``` extension. e.g.

```
ln -s quick-k8s.sh ~/.oh-my-zsh/custom/quick-k8s.zsh
```

### Aliases:
- ```k``` -> kubectl
- ```kd``` -> kubectl describe
- ```kswitch``` -> kubectl config use-context

### Commands:
- ```ke <pod/pods-name-pattern>```:
filter the pods that have names starts with input pattern and selects one of them randomly. then get the shell of selected pod using ```kubectl exec -it <selected pod> bash```.
- ```klogs <pods-name-pattern> [ any-kubectl-logs-param/option ]:
filter the pods that have name starts with input pattern and print the logs of them separated using ```kubectl logs <pod> $* --follow=false```.
