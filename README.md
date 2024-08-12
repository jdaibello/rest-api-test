# rest-api-test

## Requirements

- Node 14
- Postgres 11

## How to Start the API

1. Clone repo: git clone <https://github.com/jdaibello/rest-api-test>

2. Install Dependencies: npm install

3. Setup the database postgres 11

4. Run SQL file database/create.sql

5. Setup Environment variables: DB_USER, DB_PASSWORD, DB_HOST, DB_PORT, DB_NAME

6. Run the server: node server/server.js

## How to Test the API

1. Use Postman

2. Follow the test

```txt
GET https://<yourname>.com/posts
POST https://yoururl.com/posts
{
    "title" : "Post",
    "content" : "Post content"
}
PUT https://yoururl.com/posts/1
{
    "title" : "Edited post",
    "content" : "Edited post content"
}
DELETE https://yoururl.com/posts/1
```

## How to start the API via Docker Compose

1. Use Docker Compose

```bash
docker-compose up -d --build
```

## How to start the API via local Kubernetes cluster

1. Use kubectl port-forward

```bash
kubectl --kubeconfig /Users/<username>/_work/rest-api-test/terraform/k8s/.kube/config.yaml port-forward svc/rest-api-test 3000:3000 -n rest-api-test-sandbox-ns
```

Obs: Because the Docker Compose is using the same ports of the local Kubernetes cluster services, you should use only one at a time
