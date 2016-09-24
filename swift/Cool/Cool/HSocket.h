//
//  HSocket.h
//  Cool
//
//  Created by SDLL18 on 15/1/22.
//  Copyright (c) 2015年 SDLL18. All rights reserved.
//

#ifndef __Cool__HSocket__
#define __Cool__HSocket__

#include <iostream>
#include <stdio.h>
#include <unistd.h>
#include <netdb.h>

#define CC_BREAK_IF(cond) if(cond) break

class HSocket {
    private :
    int socketHandle = 0;
    pthread_t threadHimi;
    public :
    int connect(const char* ip,unsigned short port);
    size_t send(const void* buffer,size_t length);
    size_t recv(void* buffer,size_t length);
    int threadStart();
    
};
#endif /* defined(__Cool__HSocket__) */
