/*
 ============================================================================
 Name        : 特殊乘法.c
 Author      : dyq
 Version     :
 Copyright   : com.7k7k
 Description : Hello World in C, Ansi-style
 ============================================================================
 */

/**
 * 题目描述
写个算法，对2个小于1000000000的输入，求结果。

特殊乘法举例：123 * 45 = 1*4 +1*5 +2*4 +2*5 +3*4+3*5

输入
 两个小于1000000000的数

输出
 输入可能有多组数据，对于每一组数据，输出Input中的两个数按照题目要求的方法进行运算后得到的结果。

 *
 */
#include <stdio.h>
#include <stdlib.h>

int main(void) {
	int a[9],b[9];
	int i,j,k=100000000,cnt=0,sum=0;
	while(scanf("%d%d",&i,&j)!=EOF){
		cnt=0;
		sum=0;
		k=100000000;
		while(k!=0){
			a[cnt]=i/k;
			b[cnt]=j/k;
			i=i-a[cnt]*k;
			j=j-b[cnt]*k;
			k=k/10;
			cnt++;
		}

		for(cnt=8;cnt>=0;cnt--){
			if(a[cnt]!=0){
				for(k=8;k>=0;k--){
					if(b[k]==0){
						continue;
					}else{
						sum+=a[cnt]*b[k];
					}
				}
			}else{
				continue;
			}
		}

		printf("%d\n",sum);
	}
	system("pause");
	return EXIT_SUCCESS;
}
