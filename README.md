# Deno sample app

## Prerequisite

Install [Deno](https://docs.deno.com/runtime/getting_started/installation/).

## Local run

deno cache --lock=deno.lock npm:hono

## Docker run

```
docker build . -t function-app
docker run -p 8000:8000 function-app
```

## Perf test

```
sudo snap install plow
plow http://localhost:8000/
```

Open [http://localhost:18888/](http://localhost:18888/) for Plow graphs
