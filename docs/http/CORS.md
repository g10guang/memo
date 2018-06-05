# CORS

Cross Origin Resource Sharing

- 简单请求
- 复杂请求

同源：

- protocol 协议
- domain 域名
- port 端口

以上三者之一不同，则构成跨域。

为了安全考虑浏览器会对**跨域**的**复杂请求**进行预检，与服务端进行验证后，再决定是否需要发送。

CORS 标准由响应组织产生，然后不同浏览器实现具体的标准，但是不同浏览器具体实现可能有微小差异。

## 不需要准守同源策略的情况

HTML 标签中的 src 属性。

```html
<img src="https://www.google.com.hk/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png" alt="">
```

```html
<script src="https://example.com/xyz.js"></script>
```

```html
<link rel="stylesheet" href="https://example.com/xyz.css">
```

猜想：由于 CDN 服务，所以对于以上静态资源的加载不需要准守同源策略。

## 简单请求

只允许的方法：

- GET
- POST
- HEAD

头部信息只允许是浏览器自带的头部（Connection、User-Agent），和少部分可以通过 JavaScript 脚本设置的头部（[允许 js 设置的头部](https://fetch.spec.whatwg.org/#cors-safelisted-request-header)，[不允许 js 设置的头部](https://fetch.spec.whatwg.org/#forbidden-header-name)）

Content-Type 只能是以下可选项：

- `application/x-www-form-urlencoded`
- `multipart/form-data`
- `text/plain`

No event listeners are registered on any XMLHttpRequestUpload object used in the request。

No ReadableStream object is used in the request.

如果 requester 需要读取某些头部信息，则需要 responser 设置相应的响应头字段。

## 需要预检的请求

不符合简单请求的请求都需要经过浏览器预检。

## CORS 跨域

假设浏览器访问的 `url:https://example.com/doc`，浏览器当前窗口的 `url:https://foo.bar/hello`，方法为 POST，JS 附带的头部为 `Hello: World`

浏览器进行预检时会向服务端发以下 HTTP 报文：

```http
OPTIONS /doc HTTP/1.1
Host: example.com
Origin: https://foo.bar
Access-Control-Request-Method: POST
Access-Control-Request-Headers: Hello
```

- `Host`：服务端的域名
- `Origin`：请求域
- `Access-Control-Request-Method`：需要预检的请求的方法
- `Access-Control-Request-Headers`：需要预检的请求使用了哪些不符合简单请求的头部字段

服务端响应 HTTP 包如下：

```http
HTTP/1.1 200 OK
Access-Control-Allow-Origin: https://foo.bar
Access-Control-Allow-Headers: Hello
Access-Control-Expose-Headers: HeaderJSCanRead, OtherHeader
Access-Control-Allow-Methods: POST
Access-Control-Allow-Credentials: true
Access-Control-Max-Age: 86400
```

- `Access-Control-Allow-Origin`：允许 CORS 的域
- `Access-Control-Allow-Headers`：需要预检的请求可以使用哪些不满足简单请求的头部字段
- `Access-Control-Expose-Headers`：响应头中的数据哪些头部字段暴露给 JS 读
- `Access-Control-Allow-Methods`：允许 CORS 的请求方法
- `Access-Control-Allow-Credentials`：是否允许请求携带 cookie，如果 `Access-Control-Allow-Origin: *` 则不允许携带 cookie。如果需要携带 cookie 还需要在 JS 代码中写某些声明 `invocation.withCredentials = true`
- `Access-Control-Max-Age`：该响应的有效时间

> 注意：以上的响应信息只是针对 https://example.com/doc 下的资源起作用。

如果使用 CORS + 重定向的时候可能会有某些意外情况。

## 其他跨域方法

1. 通过 Flash 插件发送请求，绕开浏览器的安全限制。
2. 在同域下搭建一个代理服务器，比如 `/proxy?url=https://example.com/doc`
3. JSONP，通过 `<script src="https://example.com/xxx.js?callback=callbackFunction"></script>` src 属性不需要遵守同源策略，加载脚本然后执行，最后执行 callbackFunction 回调函数

## 参考

- [CORS MDN](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS)
- [服务端 PHP 参考代码](https://developer.mozilla.org/en-US/docs/Web/HTTP/Server-Side_Access_Control)
- [廖雪峰 JS 教程-安全限制](https://www.liaoxuefeng.com/wiki/001434446689867b27157e896e74d51a89c25cc8b43bdb3000/001434499861493e7c35be5e0864769a2c06afb4754acc6000)