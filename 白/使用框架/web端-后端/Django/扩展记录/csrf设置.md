csrf 设置
========

错误信息

```html
Forbidden (403)
CSRF verification failed. Request aborted.

Help
Reason given for failure:

    CSRF token missing or incorrect.
```

1. 添加 `csrf` 模块到 `setting.py`

    ```python
    MIDDLEWARE_CLASSES = (
        'django.middleware.common.CommonMiddleware',
        'django.contrib.sessions.middleware.SessionMiddleware',
        'django.middleware.csrf.CsrfViewMiddleware',#确认存在
        'django.contrib.auth.middleware.AuthenticationMiddleware',
        'django.contrib.messages.middleware.MessageMiddleware',
        # Uncomment the next line for simple clickjacking protection:
        # 'django.middleware.clickjacking.XFrameOptionsMiddleware',
    )
    ```

2. html中的form添加模板标签

    在`<form> </form>`内部 添加
    `{% csrf_token %}`

3. 将 `view` 函数中返回的`request`重新设置
    ```python
    def finsh(HttpRequest):
        return render(
            HttpRequest,
            template_name="finish.html"

        )
    ```
    换成
    ```python
    def finsh(request):
    request = HttpRequest()
    return render(
        request,
        template_name="finish.html"

    )
    ```
> 本质原理是 返回的新页面带有 之前`post`提交的参数