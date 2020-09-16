# CI Explanation

## Beschreibung
Das Ziel ist am Ende einen funktionieres Deployment mit Dendrite und einer WebGui zu haben um den Chat zu verwenden.

Dazu wurden Kubernetes Deployments und Services beschrieben im Ordner `k8s` und ein Script `myCIscript.sh` erstellt.


# Verwendung
- Ausführen des Scripts `myCIscript
- die beiden Services verfügbar machen, mit Minikube `minikube service dendrite-service`
- Element aufrufen und dort die Adresse für Dendrite eingeben.


# Einschränkungen
Es wird nur SQlite3 verwendet und kein . Also keine Produktionsreife Umgebung.
Das Erstellen von den Secrets braucht evtl. noch einen Schritt.