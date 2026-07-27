---
name: clima-local
description: Consulta el clima actual (temperatura y condición) de Santiago, Chile usando wttr.in vía un script local, sin necesidad de API key ni búsqueda web. Úsalo cuando el usuario pida el clima o la temperatura, o invoque /clima-local.
---

# clima-local

Consulta el clima actual de Santiago, Chile ejecutando `scripts/get_weather.sh`, que llama a `wttr.in` (servicio público, sin API key) y devuelve una línea de texto en español con la condición y la temperatura.

## Uso

```bash
.claude/skills/clima-local/scripts/get_weather.sh
```

Ejecuta el script con Bash y reporta el resultado al usuario tal cual, traduciendo el ícono si hace falta. Si el comando falla (sin conexión, servicio caído), informa el error en vez de inventar datos.

## Notas

- No requiere configuración ni claves de API.
- La ciudad siempre es Santiago, Chile (fija en el script, no acepta parámetro).
- Para pronósticos extendidos, otras ciudades o datos más detallados, usa WebSearch en su lugar — este skill es solo para una consulta rápida del clima actual de Santiago.
