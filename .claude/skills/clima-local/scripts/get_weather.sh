#!/usr/bin/env bash
# Consulta el clima actual de Santiago, Chile vía wttr.in (texto plano, sin API key).
# Uso: get_weather.sh

set -euo pipefail

CIUDAD_URL="Santiago"

curl -fsS "https://wttr.in/${CIUDAD_URL}?format=3&lang=es" \
  || curl -fsS "https://wttr.in/${CIUDAD_URL}?format=3"
