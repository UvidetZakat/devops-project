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

  Доступ
Grafana: kubectl port-forward -n monitoring svc/prometheus-grafana 3000:80 → admin/admin123

Prometheus: kubectl port-forward -n monitoring svc/prometheus-kube-prometheus-prometheus 9090:9090

Loki: kubectl port-forward -n monitoring svc/loki 3100:3100