// The module 'vscode' contains the VS Code extensibility API
// Import the module and reference it with the alias vscode in your code below
const vscode = require('vscode');
const dotran = require('./http');



/**
 * @param {vscode.ExtensionContext} context
 */
function activate(context) {

	// console.log('Congratulations, your extension "mytranslate" is now active!');

	let editor = vscode.window.activeTextEditor;
	let document = editor.document;
	let selection = editor.selection;
	
	let disposable = vscode.commands.registerCommand('extension.mytranslate', function () {

		let text = document.getText(selection);
		
		dotran.doTran(text,vscode.window.showInformationMessage, "en", "zh-CN");
		
		

	});

	context.subscriptions.push(disposable);
}
exports.activate = activate;

function deactivate() {}

module.exports = {
	activate,
	deactivate
}
