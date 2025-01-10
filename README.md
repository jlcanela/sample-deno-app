# Deno sample app

## Prerequisite

Install [Deno](https://docs.deno.com/runtime/getting_started/installation/).

## Local run

deno cache --lock=deno.lock npm:hono

## Docker run

```
docker build -f infra/docker/Dockerfile -t function-app .
docker run -p 8000:8000 function-app
```

## Perf test

```
sudo snap install plow
plow http://localhost:8000/
```

Open [http://localhost:18888/](http://localhost:18888/) for Plow graphs

## Deploy to Azure

Set **AZURE_CREDENTIALS** with the result of the following command:
```bash
az ad sp create-for-rbac --name "myApp" --role contributor \
    --scopes /subscriptions/<subscription-id>/resourceGroups/<resource-group> --sdk-auth
```

It should be like the following: 
```json
{
    "clientId": "<client-id>",
    "clientSecret": "<client-secret>",
    "subscriptionId": "<subscription-id>",
    "tenantId": "<tenant-id>"
}
```

Set **READ_PACKAGE_PAT** with a "New Token (classic)" with scope 'read:packages'

Run the deploy-azure workflow or run the following command:
```
 az deployment group create \
          --resource-group ResourceGroupDev \
          --name deploy-dev \
          --template-file infra/bicep/deployment.bicep \
          --parameters \
              hashSecret=${{ secrets.HASH_SECRET }} \
              jwtSecret=${{ secrets.JWT_SECRET }} \
              databaseUrl=${{ secrets.DATABASE_URL }} \
              registryPassword=${{ secrets.READ_PACKAGE_PAT }} \
              imageUrl='ghcr.io/${{ github.repository }}:latest' \
          --no-wait
```

## Undeploy from Azure

Run locally 
```
az deployment group create \
    --mode Complete \
    --resource-group <resource-group> \
    --template-file delete.bicep \
    --no-wait
```

The file '.github/workflows/undeploy-azure.yml' is provided but would require either admin or owner rights. 
```
az role assignment create --assignee "<service-principal-id>" \
    --role "Owner" \
    --scope "/subscriptions/<subscription-id>/resourceGroups/<resource-group>"
```
