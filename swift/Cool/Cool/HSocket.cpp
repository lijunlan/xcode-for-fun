//
//  HSocket.cpp
//  Cool
//
//  Created by SDLL18 on 15/1/22.
//  Copyright (c) 2015年 SDLL18. All rights reserved.
//

#include "HSocket.h"

int HSocket::connect(const char *ip ,unsigned short port){
    struct sockaddr_in sa;
    struct hostent* hp;
    hp = gethostbyname(ip);
    if(!hp){
        return -1;
    }
    memset(&sa, 0, sizeof(sa));
    memcpy((char*)&sa.sin_addr, hp->h_addr, hp->h_length);
    sa.sin_family = hp->h_addrtype;
    sa.sin_port = htons(port);
    
    socketHandle = socket(sa.sin_family, SOCK_STREAM, 0);
    
    if(socketHandle < 0){
        printf( "failed to create socket\n" );
        return -1;
    }
    
    if(::connect(socketHandle, (sockaddr*)&sa, sizeof(sa)) < 0){
        printf( "failed to connect socket\n" );
        ::close(socketHandle);
        return -1;
    }
    return 0;
}

int HSocket::threadStart(){
    int errCode = 0;
    do{
        pthread_attr_t tAttr;
        errCode = pthread_attr_init(&tAttr);
        
        CC_BREAK_IF(errCode!=0);
        
        errCode = pthread_attr_setdetachstate(&tAttr, PTHREAD_CREATE_DETACHED);
        
        if (errCode!=0) {
            pthread_attr_destroy(&tAttr);
            break;
        }
        
        errCode = pthread_create(&threadHimi, &tAttr, NULL, this);
        
    }while(0);
    return errCode;
}

size_t HSocket::send(const void * buffer,size_t length){
    return ::send(socketHandle, buffer, length, 0);
}

size_t HSocket::recv(void* buffer,size_t length){
    return ::recv(socketHandle, buffer, length, 0);
}
