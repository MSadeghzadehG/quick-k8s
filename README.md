# quick-k8s
Aliases and commands for faster k8s experience.

### How to Use
If you are using oh-my-zsh, You should just clone the repository and symlink your ```quick-k8s.sh``` file in the custom dir with ```.zsh``` extension. e.g.

```
ln -s /<path-to-repo>/quick-k8s.sh ~/.oh-my-zsh/custom/quick-k8s.zsh
```

### Aliases:
- ```k``` -> kubectl
- ```kd``` -> kubectl describe
- ```kswitch``` -> kubectl config use-context

### Commands:
- ```ke <pod>```:
filter the pods that have names starts with ```<pod>``` and selects one of them randomly. then get the shell of selected pod using ```kubectl exec -it <selected pod> bash```.
