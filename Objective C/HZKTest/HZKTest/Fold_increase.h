#include <stdio.h>

struct Result{
      int nPt;
      float days[100];
      float mean[100];
      float sig1[100];
      float sig2[100];
      float indays[100];
      float folds[100];
    int nD;
};


struct Result Fold_increase(float MaxP, float PercSig, int Nsample,const char *DataTitle, int nData, float *d, float *folds)
{
     
      struct Result R;
      float Result_day[15]={20,25,30,35,40,45,50,55,60,65,70,75,80,85,90};
      float Result_mean[15] = {17.3,20.6,23.3,25.8,28.1,30.2,32.1,33.9,35.7,37.3,38.9,40.4,41.9,43.3,44.6};
      float Result_1sigma[15] = {16.7,19.9,22.6,25.0,27.1,29.1,31.0,32.8,34.4,36.0,37.6,39.0,40.4,41.8,43.1};
      float Result_2sigma[15] = {16.2,19.2,21.8,24.1,26.2,28.1,29.9,31.6,33.2,34.8,36.2,37.6,39.0,40.3,41.6};
      
      R.nPt = 15;
      
      printf("\nIn Fold_increase subroutine\n");
      printf("MaxP,PercSig,Nsample,DataTitle,nData= %f, %f, %d, %s, %d\n",MaxP,PercSig,Nsample,DataTitle,nData);
      printf("\t   days    \t       folds\n");
      for (int i=0; i<nData;i=i+1) {
            printf(" %15.3f     %15.3f\n",d[i],folds[i]);
          R.indays[i] = d[i];
          R.folds[i] = folds[i];
      }
    
    R.nD = nData;
    
      for (int i=0; i<R.nPt; i=i+1){
            R.days[i] = Result_day[i];
            R.mean[i] = Result_mean[i];
            R.sig1[i] = Result_1sigma[i];
            R.sig2[i] = Result_2sigma[i];
      }
    
      return R;

}
