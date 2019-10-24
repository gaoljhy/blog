
const http = require('http');

exports.doTran = function doTranslate(word, func ,sLag = "en", toLag = "zh-CN" ) {

    let path = "/translate_a/single?client=gtx&sl=" + sLag + "&tl=" + toLag + "&dt=t&q=" + word;

    let options = {
        host: 'translate.google.cn',
        port: 80,
        path: path,
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36'
        }
    };

    // 处理response conetxt的回调函数,这里执行所需要执行的后面步骤
    let callback = function (response) {
        // 不断更新数据
        let body = '';
        response.on('data', function (data) {
            body += data;
        });

        response.on('end', function () {
            // 数据接收完成
            // console.log(body);
            
            let result = body.split('"')[1];
            console.log("finish -", result);
            func(result);
            
        });
    }

    let req = http.request(options,callback);
    req.end();
}


// 请求链接
// http://translate.google.cn/translate_a/single?client=gtx&sl=en&tl=zh-CN&dt=t&q=google

// dt  
// t - 源text的翻译 • at - 会额外返回一些近义词 • ex - examples • ss - 如果翻译的是单个词，会返回与该词相关的动词、形容词、名词 • md - 如果翻译的是单个词，返回该词的定义  • rw - 组词 • bd • rm

// 链接：https://www.zhihu.com/question/47239748/answer/147563856
