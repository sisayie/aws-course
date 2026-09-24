ci-cd
====

## Project Structure
```
.
├── Dockerfile
├── README.md
├── app
│   ├── __init__.py
│   ├── routes.py
│   └── templates
│       └── test.html
├── infrastructure
│   └── template.yml
├── requirements.txt
└── tests
    └── test_app.py
```

## Deploying
1. Rename `.env-example` to `.env` and enter credentials in it.
2. Run `deploy.sh`

## Testing
If everything goes well, ECS and related AWS infrastructure will be created and the app will be deployed. Then you can obtain the public ip of the container from ECS as shown in the figure below:

![Get IP Address](images/ecr-task.png)

After that, you can enter the public ip, port number and endpoint to access the application as using `http://<publi-ip:port/endpoint>`, as shown in the example below:
![testing the app](images/ecr-task-test.png)

**Question:**

From where do you get the port number and endpoint? 

---
<!--
If you want to run test it locally before deploying, you can use `$python -m pytest` and you will get result similar to the following:

================ test session starts ================
platform linux -- Python 3.12.3, pytest-9.1.1, pluggy-1.6.0
rootdir: /home/user/ci-cd
plugins: anyio-4.12.1
collected 4 items                                                                                                                                                                  

tests/test_app.py ....                                                                                                                                                                  [100%]

================ 4 passed in 0.48s ================
```
-->