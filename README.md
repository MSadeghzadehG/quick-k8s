# quick-k8s
Some shortcut commands for using kubectl faster and easier. I've found these commands useful in my experiences with k8s, I hope it will be for ohters too.

Feel free to fork and create your own. making PRs is also welcome.

NEW: Auto-complete on commands!

### Commands:

- #### ke: get shell from a random pod of your deployment
```ke <pod/deployment-name-pattern>```

Filters the pods that have names match the input pattern and then select one of them randomly. finally, it gets the shell using ```kubectl exec -it <selected pod> bash```.

- #### klogs: monitor all pods of your deployment, using just one command
```klogs <deployment-name-pattern> [ any kubectl logs param/option ]```

Filters the pods that have names match the input pattern and print the logs of them separated, using ```kubectl logs <pod> $* --follow=false```.

- #### kbackup: take backup of your resources especially if you can not commit them, such as secrets and configmaps
```kbackup <resource type> <output format{default=yaml}>```

Creates a backup of given resource in ```K8S_BACKUP_DIR{default=~/.k8s_backups}``` with given format. e.g.

```~/.k8s_backups/<date>-<resource type>/<name>.backup```

```~/.k8s_backups/2020-05-29-secret/secret1.backup```   

### Aliases:
Also I've selected some aliases that I think are handier. like:
- ```k``` -> kubectl
- ```kd``` -> kubectl describe
- ```kswitch``` -> kubectl config use-context

### How to Use
If you are using oh-my-zsh, You should just clone the repository and then symlink your ```quick-k8s.sh``` file in the custom dir with ```.zsh``` extension. e.g.

```
ln -s /<path-to-repo>/quick-k8s.sh ~/.oh-my-zsh/custom/quick-k8s.zsh
```
