/*
 ============================================================================
 Name        : ����˷�.c
 Author      : dyq
 Version     :
 Copyright   : com.7k7k
 Description : Hello World in C, Ansi-style
 ============================================================================
 */

/**
 * ��Ŀ����
д���㷨����2��С��1000000000�����룬������

����˷�������123 * 45 = 1*4 +1*5 +2*4 +2*5 +3*4+3*5

����
 ����С��1000000000����

���
 ��������ж������ݣ�����ÿһ�����ݣ����Input�е�������������ĿҪ��ķ������������õ��Ľ����

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
