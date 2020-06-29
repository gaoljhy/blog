> <https://fastapi.tiangolo.com/zh/tutorial/security/simple-oauth2/>

```python
from fastapi import Depends
from fastapi.security import OAuth2PasswordRequestForm
from fastapi_login.exceptions import InvalidCredentialsException

import uvicorn

from fastapi import FastAPI

SECRET = "your-secret-key"

app = FastAPI()

from fastapi_login import LoginManager
manager = LoginManager(SECRET, tokenUrl='/auth/token')

fake_db = {'johndoe@e.mail': {'password': 'hunter2'}}

@manager.user_loader
def load_user(email: str):  # could also be an asynchronous function
    user = fake_db.get(email)
    return user

@app.post('/auth/token')
def login(data: OAuth2PasswordRequestForm = Depends()):
    print(data)
    email = data.username
    password = data.password

    user = load_user(email)  # we are using the same function to retrieve the user
    if not user:
        raise InvalidCredentialsException  # you can also use your own HTTPException
    elif password != user['password']:
        raise InvalidCredentialsException

    access_token = manager.create_access_token(
        data=dict(sub=email)
    )
    return {'access_token': access_token, 'token_type': 'bearer'}

@app.get("/hello")   #  就是这里
def read_root(user=Depends(manager)):
    return {"Hello": "World","esvdgsjv":"wertghvqw3etghvbc"}

if __name__ == "__main__":
    uvicorn.run(app, host="127.0.0.1", port=8000)

```

> Token 放在 Head中,通过head获取