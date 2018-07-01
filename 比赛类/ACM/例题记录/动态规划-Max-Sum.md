## Max Sum(1003)
Time Limit: 2000/1000 MS (Java/Others)    Memory Limit: 65536/32768 K (Java/Others)
Total Submission(s): 287197    Accepted Submission(s): 68203


### Problem Description
>Given a sequence a[1],a[2],a[3]......a[n], your job is to calculate the max sum of a sub-sequence. For example, given (6,-1,5,4,-7), the max sum in this sequence is 6 + (-1) + 5 + 4 = 14.
 

### Input
>The first line of the input contains an integer T(1<=T<=20) which means the number of test cases. Then T lines follow, each line starts with a number N(1<=N<=100000), then N integers followed(all the integers are between -1000 and 1000).
 

### Output
>For each test case, you should output two lines. The first line is "Case #:", # means the number of the test case. The second line contains three integers, the Max Sum in the sequence, the start position of the sub-sequence, the end position of the sub-sequence. If there are more than one result, output the first one. Output a blank line between two cases.
 

### Sample Input
```
2
5 6 -1 5 4 -7
7 0 6 -1 1 -6 7 -5
``` 

### Sample Output
```
Case 1:
14 1 4

Case 2:
7 1 6
```

---
## 动态规划

基本点：
1. 可 根据 当前的数组下标 ，建立当前的 `nowsum`
2. 当前的 `sum` 只能 加一个 大于`0`的才可以变得更大

想求最大和，必须求，目前所能达到的最大和

新开辟一个数组，存放当前`sum`

`sum`数组中，前一位小于`0` 的可以直接抛弃，以保证当前`sum`为最大

坑爹的是求开始位的位置

### 代码

```
#include<iostream>
#include<vector>

using namespace std;

vector<signed int> input , nowsum ;
int main(){
	int test ,cas = 1;
	cin >> test ;
	while(test--){
		//初始化
		int N = 0 ;
		input.clear();
		nowsum.clear();
		cin >> N ;
		input.resize(N,0);
		nowsum.resize(N,0);
		//输入
		for(int i = 0 ; i <input.size(); i++){
			cin >> input[i];
		}
		/*--------------------------*/
		//求每一位对应的的当前 sum
		nowsum[0]=input[0];
		for(int i = 1 ;i <input.size();i++){
			// 如果前一位小于0，舍弃
			if(nowsum[i-1]<0){
				nowsum[i] = input[i];
			}// 反之，加入到当前sum中
			else{
				nowsum[i] = nowsum[i-1]+input[i];
			}
			//cout << nowsum[i] <<" ";
		}
		//cout <<endl;
		// 求出当前 sum中最大的
		int max = nowsum[0]; 
		int endp = 0 ;
		int startp = 0 ,temp = -1;//位置的需要
		for(int i =0 ; i < nowsum.size();i++){
			if(nowsum[i] < 0){
				temp = i ;
			}
			if(max < nowsum[i]){
				max = nowsum[i];
				startp = temp +1;
				endp = i ;
				//考虑当下sum 为负
				if(startp == endp+1){
					startp -- ;
				}
				
			}
		}
		/*-----------------------------*/
		cout << "Case " << cas++ <<":"<<endl;
		cout << max << " " << startp+1 << " " << endp+1<< endl;
		if(test > 0 ){
			cout << endl;
		}
	}



	return 0 ;
}
```