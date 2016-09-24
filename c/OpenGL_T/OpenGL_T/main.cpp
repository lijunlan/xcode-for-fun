//
//  main.cpp
//  OpenGL_T
//
//  Created by SDLL18 on 14-5-27.
//  Copyright (c) 2014年 SDLL18. All rights reserved.
//

#include <math.h>
#include <OpenGL/gl.h>
#include <OpenGL/glu.h>
#include <GLUT/glut.h>
#include <stdio.h>

GLint SCREEN_WIDTH=0;
GLint SCREEN_HEIGHT=0;
GLint windowWidth=600;
GLint windowHeight=600;

typedef struct TriangleH{
    GLfloat a[3];
    GLfloat b[3];
    GLfloat c[3];
}TriangleT;

TriangleT x={{0,1.5,0},{0,0,1},{1,0,0}};
TriangleT y={{0,-1.5,0},{-1,0,0},{0,0,-1}};
TriangleT z={{0,-1.5,0},{-1,0,0},{0,0,1}};
TriangleT w={{0,1.5,0},{1,0,0},{0,0,-1}};

TriangleT x2={{0,-1.5,0},{1,0,0},{0,0,1}};
TriangleT y2={{0,-1.5,0},{1,0,0},{0,0,-1}};
TriangleT z2={{0,1.5,0},{0,0,-1},{-1,0,0}};
TriangleT w2={{0,1.5,0},{-1,0,0},{0,0,1}};

GLfloat lx=0.0;
GLfloat ly=0.0;
GLfloat lz=0.0;
int mx,my;
bool mflag = false;

GLfloat light_position[] = {0,2.0f,-1.0f,0};
GLfloat light_color[] = {0.8f,0.5f,0.0f,1};
GLfloat light_color1[] = {1.0f,1.0f,1.0f,1};

GLfloat ma[] = {0.25,0.25,0.25,1.0};
GLfloat md[] = {0.4,0.4,0.4,1.0};
GLfloat ms[] = {0.77,0.77,0.77,1.0};
GLfloat msh = 76.8;

#define MIDDLE(a,b,c){\
c[0]=(a[0]+b[0])/2;\
c[1]=(a[1]+b[1])/2;\
c[2]=(a[2]+b[2])/2;\
}

#define TRANS(a,b){\
b[0]=a[0];\
b[1]=a[1];\
b[2]=a[2];\
}

void Normalize(GLfloat *n){
    GLfloat size;
    size = (n[0]*n[0]+n[1]*n[1]+n[2]*n[2]);
    size = sqrt(size);
    if(size==0)return;
    n[0]/=size;
    n[1]/=size;
    n[2]/=size;
}

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
    gluPerspective(65.0, (GLfloat) w/(GLfloat) h, 1.0, 20.0);
    glMatrixMode(GL_MODELVIEW);
}

void Idle(void){
    glutPostRedisplay();
}

void Display(){
    
    glClear(GL_COLOR_BUFFER_BIT);
    glLoadIdentity();
    glLightfv(GL_LIGHT0, GL_POSITION, light_position);
    glLightfv(GL_LIGHT0, GL_DIFFUSE, light_color1);
    glLightfv(GL_LIGHT0, GL_SPECULAR, light_color);
    glLightfv(GL_LIGHT0, GL_AMBIENT, light_color);
    glEnable(GL_LIGHTING);
    glEnable(GL_LIGHT0);
    glLightModeli(GL_LIGHT_MODEL_TWO_SIDE , GL_FALSE);
    glEnable(GL_CULL_FACE);
    glEnable(GL_DEPTH_TEST);
    glMaterialfv(GL_FRONT, GL_AMBIENT, ma);
    glMaterialfv(GL_FRONT, GL_DIFFUSE, md);
    glMaterialfv(GL_FRONT, GL_SPECULAR, ms);
    glMaterialf(GL_FRONT, GL_SHININESS, msh);
    
    gluLookAt (0.0, 0.0, 10.0, 0.0, 0.0, 0.0, 0.0, 1.0, 0.0);
    glPushMatrix();
    glScalef(2.0, 2.0, 2.0);
    glRotatef(lx, 0.0, 1.0, 0);
    glRotatef(ly, 1.0, 0.0, 0);
    glPolygonMode(GL_FRONT,GL_FILL);
    
     glutSolidTeapot(1.0);
    
    glPopMatrix();
    
    glutSwapBuffers();
}

void Mouse(int button,int state,int x,int y){
	if(button==GLUT_LEFT_BUTTON){
		if(state==GLUT_DOWN){
            mx = x;
            my = y;
            mflag = true;
		}
		if(state==GLUT_UP){
			mx = -0xfffff;
			my = -0xfffff;
			mflag = false;
		}
	}
}

void MouseMove(int x,int y){
	if(mflag){
		lx += x-mx;
        ly += y-my;
		mx = x;
		my = y;
	}
}

void KeyBoard(int key,int x,int y){
	switch (key)
	{
        case GLUT_KEY_UP:
            ly+=2;
            break;
        case GLUT_KEY_DOWN:
            ly-=2;
            break;
        case GLUT_KEY_LEFT:
            lx+=2;
            break;
        case GLUT_KEY_RIGHT:
            lx-=2;
            break;
        default:
            break;
	}
}


int main(int argc, char* argv[])
{
    glutInit (&argc, argv);                         // Initialize GLUT.
    glutInitDisplayMode (GLUT_DOUBLE | GLUT_RGB);   // Set display mode.
	SCREEN_WIDTH=glutGet(GLUT_SCREEN_WIDTH);
	SCREEN_HEIGHT=glutGet(GLUT_SCREEN_HEIGHT);
    glutInitWindowPosition((SCREEN_WIDTH-windowWidth)/2,(SCREEN_HEIGHT-windowHeight)/2);
    glutInitWindowSize(windowWidth,windowHeight);
    glutCreateWindow ("Project6"); // Create display window.
	init ();
	glutIdleFunc(Idle);
    glutDisplayFunc(Display);
    glutReshapeFunc(Reshape);
    glutMouseFunc(Mouse);
    glutMotionFunc(MouseMove);
    glutSpecialFunc(KeyBoard);
    glutMainLoop();
}

