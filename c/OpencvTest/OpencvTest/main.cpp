//
//  main.cpp
//  OpencvTest
//
//  Created by SDLL18 on 14-6-13.
//  Copyright (c) 2014年 SDLL18. All rights reserved.
//

#include <iostream>
#include <opencv/cv.h>
#include <opencv2/highgui/highgui_c.h>
#include "jpegTool.h"


using namespace std;

int NUM_FRAME = 100;//只处理前100帧，根据视频帧数可修改
int image_width = 1920;	/* Number of columns in image */
int image_height = 1080;
int fps = 30;
int codec = 0;


void Video_to_image(char* filename)
{
    printf("------------- video to image ... ----------------\n");
    //初始化一个视频文件捕捉器
    CvCapture* capture = cvCreateFileCapture(filename);
    //获取视频信息
    cvQueryFrame(capture);
    int frameH = (int) cvGetCaptureProperty(capture, CV_CAP_PROP_FRAME_HEIGHT);
    int frameW = (int) cvGetCaptureProperty(capture, CV_CAP_PROP_FRAME_WIDTH);
    fps = (int) cvGetCaptureProperty(capture, CV_CAP_PROP_FPS);
    int numFrames = (int) cvGetCaptureProperty(capture, CV_CAP_PROP_FRAME_COUNT);
    codec = (int) cvGetCaptureProperty(capture, CV_CAP_PROP_FOURCC);
    printf("tvideo height : %d\ntvideo width : %d\ntfps : %d\ntframe numbers : %d\ncodec : %d\n", frameH, frameW, fps, numFrames,codec);
    image_height = frameH;
    image_width = frameW;
    NUM_FRAME = numFrames;
    //定义和初始化变量
    int i = 0;
    IplImage* img = 0;
    char image_name[50];
   // cvNamedWindow( "mainWin", CV_WINDOW_AUTOSIZE );
    //读取和显示
    while(1)
    {
        
        img = cvQueryFrame(capture); //获取一帧图片
       // cvShowImage( "mainWin", img ); //将其显示
      //  char key = cvWaitKey(20);
        
        sprintf(image_name, "%s%d%s", "/Users/SDLL18/Desktop/test/image", ++i, ".jpg");//保存的图片名
        
        cvSaveImage( image_name, img);   //保存一帧图片
        
      //  printf("\b\b\b%d%s",i/NUM_FRAME/3,"%");
        if(i >= NUM_FRAME) break;
    }
    
    cvReleaseCapture(&capture);
//    cvDestroyWindow("mainWin");
}



void Image_compress(){
    char image_name[50];
    char image_name2[50];
    JSAMPLE *image_buffer;
    int i = 0;
    while(i<NUM_FRAME){
        sprintf(image_name,"%s%d%s","/Users/SDLL18/Desktop/test/image", ++i, ".jpg");
        sprintf(image_name2,"%s%d%s","/Users/SDLL18/Desktop/test/compressimage", i, ".jpg");
        read_JPEG_file(image_name, image_buffer);
        write_JPEG_file(image_name2, 80, image_buffer);
        if(image_buffer!=NULL)
            delete [] image_buffer;
     //   printf("\b\b\b%d%s",i/NUM_FRAME/3+33,"%");
    }
}

void Image_to_video()
{
    int i = 0;
    IplImage* img = 0;
    char image_name[50];
    printf("------------- image to video ... ----------------\n");
    //初始化视频编写器，参数根据实际视频文件修改
    CvVideoWriter *writer = 0;
    int isColor = 1;
    int frameW = image_width; // 744 for firewire cameras
    int frameH = image_height; // 480 for firewire cameras
    writer=cvCreateVideoWriter("/Users/SDLL18/Desktop/test/out.avi", -1 ,fps,cvSize(frameW,frameH),isColor);
    printf("tvideo height : %d\ntvideo width : %d\ntfps : %d\n", frameH, frameW, fps);
    //创建窗口
   // cvNamedWindow( "mainWin", CV_WINDOW_AUTOSIZE );
    while(i<NUM_FRAME)
    {
        sprintf(image_name, "%s%d%s", "/Users/SDLL18/Desktop/test/image", ++i, ".jpg");
        img = cvLoadImage(image_name);
        if(!img)
        {
            printf("Could not load image file...n");
            exit(0);
        }
      //  cvShowImage("mainWin", img);
      //  char key = cvWaitKey(20);
        cvWriteFrame(writer, img);
      //  printf("\b\b\b%d%s",i/NUM_FRAME/3+66,"%");
    }
    cvReleaseVideoWriter(&writer);
  //  cvDestroyWindow("mainWin");
}

int main(int argc, char *argv[])
{
    char* filename = "/Users/SDLL18/Desktop/test/t4l.mp4";
    Video_to_image(filename); //视频转图片
    Image_compress();
    Image_to_video();    //图片转视频
    return 0;
}