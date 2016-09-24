//
//  jpegTool.h
//  OpencvTest
//
//  Created by SDLL18 on 14-6-22.
//  Copyright (c) 2014年 SDLL18. All rights reserved.
//

#ifndef JPEG_TOOL_SDLL18
#define JPEG_TOOL_SDLL18
extern "C" {
#include "jpeglib.h"
}
#include <setjmp.h>

extern int image_width;		/* Number of columns in image */
extern int image_height;

struct my_error_mgr {
    struct jpeg_error_mgr pub;	/* "public" fields */
    
    jmp_buf setjmp_buffer;	/* for return to caller */
};

GLOBAL(void)
write_JPEG_file (char * filename, int quality,JSAMPLE *image_buffer/* Points to large array of R,G,B-order data */);

GLOBAL(int)
read_JPEG_file (char * filename,JSAMPLE* image_buffer);
#endif