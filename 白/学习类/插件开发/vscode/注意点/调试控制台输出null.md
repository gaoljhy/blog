# 调试控制台日志不可靠

vscode有一个很坑爹的地方，这里特别要注意，当require一个function进来并打印输出时，虽然打印在控制台显示为`null`，但其实是有值的，不知道的人很容易被误导，直接就是被这个现象骗了很久，切记切记！

```js
test-require-function.js：

function testRequireFunction(a, b) {
	console.log('进入testRequireFunction方法');
	console.log(a, b);
}
module.exports = testRequireFunction;
extension.js：

exports.activate = function(context) {
	const testFn = require('./test-require-function');
	console.log(testFn); // vscode的日志输出不可靠，这里竟然会打印null？！
	testFn(1, 2); // 1, 2
};
````

输出结果：

`null`


