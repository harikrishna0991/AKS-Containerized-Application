# CRUD API Helm Chart

This chart converts the existing Kubernetes application deployment into a reusable Helm deployment.

## Managed by this chart

- ConfigMap
- Deployment
- Service
- Optional Secret template

The namespace is created by Helm with `--create-namespace`.
The SQL connection Secret is expected to be created by CI/CD because the password must not be committed into `values.yaml`.

## Validate

```powershell
helm lint ./helm/crud-api
helm template crud-api ./helm/crud-api `
  --namespace crud-api `
  --set image.repository=<ACR_LOGIN_SERVER>/crud-api `
  --set image.tag=<IMAGE_TAG>
```

## First deployment

Create/update the existing SQL Secret before installing the chart, then:

```powershell
helm upgrade --install crud-api ./helm/crud-api `
  --namespace crud-api `
  --create-namespace `
  --set image.repository=<ACR_LOGIN_SERVER>/crud-api `
  --set image.tag=<IMAGE_TAG>
```

## Upgrade

```powershell
helm upgrade crud-api ./helm/crud-api `
  --namespace crud-api `
  --set image.repository=<ACR_LOGIN_SERVER>/crud-api `
  --set image.tag=<NEW_IMAGE_TAG>
```

## Rollback

```powershell
helm history crud-api -n crud-api
helm rollback crud-api <REVISION> -n crud-api
```

## Environment values

```powershell
helm upgrade --install crud-api ./helm/crud-api -n crud-api -f ./helm/crud-api/values-dev.yaml
helm upgrade --install crud-api ./helm/crud-api -n crud-api -f ./helm/crud-api/values-prod.yaml
```
