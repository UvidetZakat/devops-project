# Мониторинг стек

## Установка (если всё удалится)

```bash
# Prometheus + Grafana
helm install prometheus prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  --create-namespace \
  --set grafana.adminPassword="admin123" \
  --set prometheus.prometheusSpec.storageSpec=null \
  --set alertmanager.alertmanagerSpec.storageSpec=null \
  --set grafana.persistence.enabled=false

# Loki + Promtail
helm install loki grafana/loki-stack \
  --namespace monitoring \
  --set grafana.enabled=false \
  --set promtail.enabled=true