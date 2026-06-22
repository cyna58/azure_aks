#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INGRESS_NS="ingress"
MONITORING_NS="monitoring"
POE_NS="poe"

mkdir -p /tmp/aks

echo "=============================="
echo "  HELM REPOS"
echo "=============================="

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add jetstack https://charts.jetstack.io
helm repo add poe-woc https://cyna58.github.io/helm_charts

helm repo update

echo "=============================="
echo "  CERT-MANAGER"
echo "=============================="

helm upgrade --install cert-manager jetstack/cert-manager --namespace cert-manager --create-namespace --set installCRDs=true

echo "=============================="
echo "  ISSUER (CERT-MANAGER)"
echo "=============================="
kubectl apply -f "${SCRIPT_DIR}/issuer.yaml"

echo "=============================="
echo "  INGRESS-NGINX"
echo "=============================="

helm upgrade --install external ingress-nginx/ingress-nginx --namespace $INGRESS_NS --create-namespace -f "${SCRIPT_DIR}/ingress_controller.yaml"

echo "=============================="
echo "  WAIT FOR INGRESS IP"
echo "=============================="

INGRESS_IP=""

while true; do
  INGRESS_IP=$(kubectl get svc -n $INGRESS_NS external-ingress-nginx-controller -o jsonpath='{.status.loadBalancer.ingress[0].ip}' 2>/dev/null || true)

  if [[ -n "$INGRESS_IP" ]]; then
    break
  fi

  echo "Waiting for ingress IP..."
  sleep 5
done

echo "Ingress IP: $INGRESS_IP"

DOMAIN="${INGRESS_IP}.nip.io"
echo "Using domain: $DOMAIN"

echo "Waiting for 15 seconds to ensure ingress is fully ready..."
sleep 15

echo "=============================="
echo "  POE APPLICATION (HELM)"
echo "=============================="

helm upgrade --install poe-wheel-of-choice poe-woc/poe-woc --namespace $POE_NS --create-namespace --version 0.1.0



echo "=============================="
echo "  POE INGRESS (TLS)"
echo "=============================="

cat "${SCRIPT_DIR}/ingress_tls.yaml" | sed "s/134.112.14.81.nip.io/${DOMAIN}/g" > /tmp/aks/ingress_tls.yaml |  kubectl apply -n $POE_NS -f /tmp/aks/ingress_tls.yaml

echo "=============================="
echo "  MONITORING (PROMETHEUS STACK)"
echo "=============================="



sed "s/134.112.14.81.nip.io/${DOMAIN}/g" "${SCRIPT_DIR}/monitoring.yaml" > /tmp/aks/monitoring.yaml

helm upgrade --install monitoring prometheus-community/kube-prometheus-stack --namespace $MONITORING_NS --create-namespace -f /tmp/aks/monitoring.yaml --version 86.3.2


echo "=============================="
echo "  DONE"
echo "=============================="

echo ""
echo "URLs:"
echo "Grafana: https://grafana.${DOMAIN}"
echo "POE:     https://poe.${DOMAIN}"
echo ""
echo "Grafana credentials: $(kubectl get secret --namespace monitoring -l app.kubernetes.io/component=admin-secret -o jsonpath="{.items[0].data.admin-password}" | base64 --decode ; echo)"  