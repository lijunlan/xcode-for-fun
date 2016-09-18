//
//  main.cpp
//  RelationLCS
//
//  Created by SDLL18 on 14-8-29.
//  Copyright (c) 2014年 SDLL18. All rights reserved.
//

#include<stdio.h>
#include<string.h>
int main()
{
    int i,j,aLength,bLength,max,h,k,z,f[104][104];   h=z=0;
    char a[100]={"acbac"};
    char b[100]={"acaccbabb"};
        aLength=strlen(a);
        bLength=strlen(b);
        for(i=0;i<=aLength;i++)
        {
            for(j=0;j<=bLength;j++)
                f[i][j]=0;
        }
        max=0;
        for(i=1;i<=aLength;i++)
        {
            for(j=1;j<=bLength;j++)
            {
                if(a[i-1]==b[j-1])
                {
                    f[i][j]=f[i-1][j-1]+1;
                    if(f[i][j]>max)
                    {
                        max=f[i][j];         /*只记录最大的那个，比原来的大就变成大的*/
                        h=i-1;               /*记录在 a字符串 连续的最后一位字符的下标*/
                    }
                }
            }
        }
        if(max!=0)
        {
            printf("%d ",max);
            for(k=1;k<=max;k++)
                printf("%c",a[h-max+k]);     /*h为记录的下标 max总的长度 h-max+k从第一个往后移*/
            printf("\n");
        }
        else
         printf("0\n");
return 0;
}
