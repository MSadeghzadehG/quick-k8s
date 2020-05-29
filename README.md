# quick-k8s
Aliases and commands for faster k8s use.

NEW: Auto-complete!

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

- #### ke: kubectl exec easy
```ke <pod/pods-name-pattern>```

Filter the pods that have names starts with input pattern and selects one of them randomly. then get the shell of selected pod using ```kubectl exec -it <selected pod> bash```.

- #### klogs: see logs of pods using just one command
```klogs <pods-name-pattern> [ any kubectl logs param/option ]```

Filter the pods that have name starts with input pattern and print the logs of them separated using ```kubectl logs <pod> $* --follow=false```.

- #### kbackup: take backup of your resources, especially if you can not commit them
```kbackup <resource type> <output format{default=yaml}>```

Create backup of given resource in ```K8S_BACKUP_DIR{default=~/.k8s_backups}``` with given format. e.g.

```~/.k8s_backups/<date>-<resource type>/<name>.backup```

```~/.k8s_backups/2020-05-29-secret/secret1.backup```   
