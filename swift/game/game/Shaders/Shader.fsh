//
//  Shader.fsh
//  game
//
//  Created by SDLL18 on 14-6-27.
//  Copyright (c) 2014年 SDLL18. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
