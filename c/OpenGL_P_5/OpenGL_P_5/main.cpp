//
//  main.cpp
//  OpenGL_P_5
//
//  Created by SDLL18 on 14-5-25.
//  Copyright (c) 2014年 SDLL18. All rights reserved.
//

//
//  main.c
//  openGLTest
//
//  Created by SDLL18 on 14-5-25.
//  Copyright (c) 2014年 SDLL18. All rights reserved.
//

#include <math.h>
#include <OpenGL/gl.h>
#include <OpenGL/glu.h>
#include <GLUT/glut.h>
#include <stdio.h>
#include <time.h>


static int shoulder = -30, elbow = 30,finger1 =65,finger2=-55,finger3=-50,finger4=-45,finger5=-40,finger11=-50,finger21=45,finger31=45,finger41=45,finger51=45;
static float angle = 0.0;
static bool bSphere = false;

#define testposition();  glColor3f(0.4,0.4,0.4);

GLint SCREEN_WIDTH=0;
GLint SCREEN_HEIGHT=0;
GLint windowWidth=600;
GLint windowHeight=600;
clock_t t;

GLfloat light_position[] = {0,2.0f,2.0f,0};
GLfloat light_color[] = {0.77f,0.77f,0.77f,1};
GLfloat light_color1[] = {0.25f,0.25f,0.25f,1};

GLfloat ma[] = {0.25,0.25,0.25,1.0};
GLfloat md[] = {0.4,0.4,0.4,1.0};
GLfloat ms[] = {0.77,0.77,0.77,1.0};
GLfloat msh = 76.8;

void init(void)
{
    glClearColor (0.0, 0.0, 0.0, 0.0);
    glShadeModel (GL_SMOOTH);
}


void Reshape (int w, int h)
{
    glViewport (0, 0, (GLsizei) w, (GLsizei) h);
    glMatrixMode (GL_PROJECTION);
    glLoadIdentity ();
    gluPerspective(65.0, (GLfloat) w/(GLfloat) h, 5.0, 10.0);
    glMatrixMode(GL_MODELVIEW);
}

void Display(void)
{
    glClear (GL_COLOR_BUFFER_BIT);
    
    glLoadIdentity ();             /* clear the matrix */
    
    GLfloat x = 6.0*sin(angle);
    GLfloat z = 6.0*cos(angle);
    
    glLightfv(GL_LIGHT0, GL_POSITION, light_position);
    glLightfv(GL_LIGHT0, GL_DIFFUSE, light_color1);
    glLightfv(GL_LIGHT0, GL_SPECULAR, light_color);
    glLightfv(GL_LIGHT0, GL_AMBIENT, light_color);
    glEnable(GL_LIGHTING);
    glEnable(GL_LIGHT0);
    glEnable(GL_CULL_FACE);
    glEnable(GL_DEPTH_TEST);
    glMaterialfv(GL_FRONT, GL_AMBIENT, ma);
    glMaterialfv(GL_FRONT, GL_DIFFUSE, md);
    glMaterialfv(GL_FRONT, GL_SPECULAR, ms);
    glMaterialf(GL_FRONT, GL_SHININESS, msh);

    gluLookAt (x, 6.0, z, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);
    
    //画球(固定)
    if(!bSphere){
        glPushMatrix();
        glTranslatef(-0.8f,3.5f,0);
    
        glutSolidSphere(0.5,10,10);
        glPopMatrix();
    }
    
    glPushMatrix();
    
    glTranslatef (-1.0, 0.0, 0.0);
    glRotatef ((GLfloat) shoulder, 0.0, 0.0, 1.0);
	testposition();//
    glTranslatef (1.0, 0.0, 0.0);
    testposition();//
    
    glPushMatrix();
    glScalef (2.0, 1.0, 1.0);
    glutSolidCube (1.0);
    glPopMatrix();
    
    glTranslatef (1.0, 0.0, 0.0);
    glRotatef ((GLfloat) elbow, 0.0, 0.0, 1.0);
    testposition();//
    glTranslatef (1.0, 0.0, 0.0);
    testposition();//
    
    glPushMatrix();
    glScalef (2.0, 1.0, 1.0);
    glutSolidCube (1.0);
    glPopMatrix();
    
    //下面画第一根指
    glPushMatrix();//保存到指跟位置之前的状态，即elbow立方体的中心位置。画第二根指时候需要。
    glTranslatef (1.0, 0.4, -0.2);
    glRotatef ((GLfloat) finger1, 0.0, 0.0, 1.0);// 指跟位置
    testposition();//
    glTranslatef (0.25, 0.0, 0.0);
    
    glPushMatrix();
    glScalef (0.5, 0.2, 0.2);
    glutSolidCube (1.0);
    glPopMatrix();
    
    glTranslatef (0.25, 0.0, 0.0);
    glRotatef ((GLfloat) finger11, 0.0, 0.0, 1.0);// 二节指跟位置
    testposition();//
    glTranslatef (0.25, 0.0, 0.0);
    
    testposition();//
    glPushMatrix();
    glScalef (0.5, 0.2, 0.2);
    glutSolidCube (1.0);
    glPopMatrix();
    
    glPopMatrix();
    //
    
    //下面画第二根指
    glPushMatrix();
    glTranslatef (1.0, -0.4, 0.3);
    glRotatef ((GLfloat) finger2, 0.0, 0.0, 1.0);// 指跟位置
    testposition();//
    glTranslatef (0.25, 0.0, 0.0);
    
    glPushMatrix();
    glScalef (0.5, 0.2, 0.2);
    glutSolidCube (1.0);
    glPopMatrix();
    
    glTranslatef (0.25, 0.0, 0.0);
    glRotatef ((GLfloat) finger21, 0.0, 0.0, 1.0);// 二节指跟位置
    testposition();//
    glTranslatef (0.25, 0.0, 0.0);
    
    testposition();//
    glPushMatrix();
    glScalef (0.5, 0.2, 0.2);
    glutSolidCube (1.0);
    glPopMatrix();
    
    glPopMatrix();
    
    //下面画第三根指
    glPushMatrix();
    glTranslatef (1.0, -0.4, 0.1);
    glRotatef ((GLfloat) finger3, 0.0, 0.0, 1.0);// 指跟位置
    testposition();//
    glTranslatef (0.25, 0.0, 0.0);
    
    glPushMatrix();
    glScalef (0.5, 0.2, 0.2);
    glutSolidCube (1.0);
    glPopMatrix();
    
    glTranslatef (0.25, 0.0, 0.0);
    glRotatef ((GLfloat) finger31, 0.0, 0.0, 1.0);// 二节指跟位置
    testposition();//
    glTranslatef (0.25, 0.0, 0.0);
    
    testposition();//
    glPushMatrix();
    glScalef (0.5, 0.2, 0.2);
    glutSolidCube (1.0);
    glPopMatrix();
    
    glPopMatrix();
    
    //下面画第四根指
    glPushMatrix();
    glTranslatef (1.0, -0.4, -0.1);
    glRotatef ((GLfloat) finger4, 0.0, 0.0, 1.0);// 指跟位置
    testposition();//
    glTranslatef (0.25, 0.0, 0.0);
    
    glPushMatrix();
    glScalef (0.5, 0.2, 0.2);
    glutSolidCube (1.0);
    glPopMatrix();
    
    glTranslatef (0.25, 0.0, 0.0);
    glRotatef ((GLfloat) finger41, 0.0, 0.0, 1.0);// 二节指跟位置
    testposition();//
    glTranslatef (0.25, 0.0, 0.0);
    
    testposition();//
    glPushMatrix();
    glScalef (0.5, 0.2, 0.2);
    glutSolidCube (1.0);
    glPopMatrix();
    
    glPopMatrix();
    
    //下面画第五根指
    glPushMatrix();
    glTranslatef (1.0, -0.4, -0.3);
    glRotatef ((GLfloat) finger5, 0.0, 0.0, 1.0);// 指跟位置
    testposition();//
    glTranslatef (0.25, 0.0, 0.0);
    
    glPushMatrix();
    glScalef (0.5, 0.2, 0.2);
    glutSolidCube (1.0);
    glPopMatrix();
    
    glTranslatef (0.25, 0.0, 0.0);
    glRotatef ((GLfloat) finger51, 0.0, 0.0, 1.0);// 二节指跟位置
    testposition();//
    glTranslatef (0.25, 0.0, 0.0);
    
    testposition();//
    
    glPushMatrix();
    glScalef (0.5, 0.2, 0.2);
    glutSolidCube (1.0);
    glPopMatrix();
    
    glPopMatrix();
    
    //画球(运动)
    if(bSphere)
    {
		glTranslatef(1.5f,0.0,0.0);
		glutSolidSphere(0.5,10,10);
    }
    glPopMatrix();
    glutSwapBuffers();
}

bool NeedDisplay(){
	clock_t temp = clock();
	if(temp - t>=17){t= temp;return true;}
	else return false;
}

void renew(){
    bSphere = false;
    shoulder = -30;
    elbow = 30;
    finger1 =65;
    finger2=-55;
    finger3=-50;
    finger4=-45;
    finger5=-40;
    finger11=-50;
    finger21=45;
    finger31=45;
    finger41=45;
    finger51=45;
}

void dealit(){
    if(!bSphere){
        elbow = (elbow + 2) % 360;
        if(elbow>80)elbow = 80;
        shoulder = (shoulder + 2)%360;
        if (shoulder>40)shoulder = 40;
    
        if(shoulder==40&&elbow==80){
            //第一节手指
            finger1 = (finger1 + 1)%360;
            if(finger1>45)finger1 = 45;
            finger2 = (finger2 + 1)%360;
            if(finger2>-15)finger2 = -15;
            finger3 = (finger3 + 1)%360;
            if(finger3>-15)finger3 = -15;
            finger4 = (finger4 + 1)%360;
            if(finger4>-15)finger4 = -15;
            finger5 = (finger5 + 1)%360;
            if(finger5>-15)finger5 = -15;
        
            //第二节手指
            finger11 = (finger11 - 1)%360;
            if(finger11<-65)finger11 = -65;
            finger21 = (finger21 + 1)%360;
            if(finger21>40)finger21 = 40;
            finger31 = (finger31 + 1)%360;
            if(finger31>40)finger31 = 40;
            finger41 = (finger41 + 1)%360;
            if(finger41>40)finger41 = 40;
            finger51 = (finger51 + 1)%360;
            if(finger51>40)finger51 = 40;
            if(finger1==45&&finger2==-15&&finger3==-15&&finger4==-15&&finger5==-15&&finger11==-65&&finger21==40&&finger31==40&&finger41==40&&finger51==40){
                bSphere = true;
            }
        }
    }
    else{
        elbow = (elbow - 2)%360;
        if(elbow<30)elbow = 30;
        shoulder = (shoulder-2)%360;
        if(shoulder<-30)shoulder = -30;
        
        if(elbow==30&&shoulder==-30){
            renew();
        }
    }
}

void Idle(void){
	if(NeedDisplay()){dealit();glutPostRedisplay();}
}

int main(int argc, char** argv)
{
	glutInit (&argc, argv);                         // Initialize GLUT.
    glutInitDisplayMode (GLUT_DOUBLE | GLUT_RGB);   // Set display mode.
	SCREEN_WIDTH=glutGet(GLUT_SCREEN_WIDTH);
	SCREEN_HEIGHT=glutGet(GLUT_SCREEN_HEIGHT);
    glutInitWindowPosition((SCREEN_WIDTH-windowWidth)/2,(SCREEN_HEIGHT-windowHeight)/2);
    glutInitWindowSize(windowWidth,windowHeight);
    glutCreateWindow ("Project5_b"); // Create display window.
	init ();
	glutIdleFunc(Idle);
    glutDisplayFunc(Display); 
    glutReshapeFunc(Reshape);
    glutMainLoop();
    return 0;
}


