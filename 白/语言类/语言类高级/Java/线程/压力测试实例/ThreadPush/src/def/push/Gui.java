package def.push;

import java.util.Scanner;

/**
 * 获取用户输入
 */

public class Gui {
	Scanner input = new Scanner(System.in);

	String getUrl() {
		System.out.println("Please input Url:");
		return (input.nextLine());

	}

	String getMethod(){
		System.out.println("Please input Method:");
		return (input.next());

	}

	Integer getTnum() {
		System.out.println("Please input Thread-Num:");
		return (input.nextInt());

	}

	String getCookie() {
		System.out.println("Please input Cookie:");
		String str = input.next();
		String str2 = input.nextLine();
		return (str+str2);

	}

	String getUserAgent() {
		System.out.println("Please input User-Agent:");
		
		return (input.nextLine());

	}

	String getRefere() {
		System.out.println("Please input Refere:");
		
		return (input.nextLine());
	}

	String getPostParamater() {
		System.out.println("Please input Post Paramter:");
		return (input.nextLine());
	}
}
