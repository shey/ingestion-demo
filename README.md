# README

## API
To post an alert, use:

```json
curl -X POST http://localhost:3000/api/alerts \
  -H "Content-Type: application/json" \
  -H "X-Api-Key: alert_app40ae5068ca80050eb9c3e85645274874cdef360e163819ee9b321c62da18313f" \
  -d '{
    "message": "High CPU usage on node-42",
    "service": "infra",
    "severity": "critical",
    "source": "prometheus",
    "environment": "production",
    "timestamp": "2025-07-28T21:43:00Z",
    "tags": ["cpu", "node-42", "threshold_exceeded"],
    "meta": {
      "host": "node-42.internal",
      "cpu_load": 97.6
    }
  }'
```

