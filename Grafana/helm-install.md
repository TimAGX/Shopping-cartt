Install using Helm
Add helm repo
```bash
helm repo add grafana https://grafana.github.io/helm-charts
```

Update helm repo
```bash
helm repo update
```

Install helm
```bash
helm install grafana grafana/grafana
```

Expose Grafana Service
```bash
kubectl expose service grafana — type=NodePort — target-port=3000 — name=grafana-ext
```
