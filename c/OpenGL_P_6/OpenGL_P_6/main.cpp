//
//  main.cpp
//  OpenGL_P_6
//
//  Created by SDLL18 on 14-5-26.
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

void SubdivideTriangle(TriangleT *p,int n){
    TriangleT up,lowleft,lowright,mid;
    
    if(n==0){
        glNormal3fv(p->a);glColor3f(0.8f,0.5f,0.0f);glVertex3fv(p->a);
        glNormal3fv(p->b);glColor3f(0.8f,0.5f,0.0f);glVertex3fv(p->b);
        glNormal3fv(p->c);glColor3f(0.8f,0.5f,0.0f);glVertex3fv(p->c);
        return;
    }
    
    up.a[0]=p->a[0];up.a[1]=p->a[1];up.a[2]=p->a[2];
    MIDDLE(p->a, p->b, up.b);
    Normalize(up.b);
    MIDDLE(p->a,p->c,up.c);
    Normalize(up.c);
    SubdivideTriangle(&up, n-1);
    
    lowleft.a[0]=up.b[0];lowleft.a[1]=up.b[1];lowleft.a[2]=up.b[2];
    lowleft.b[0]=p->b[0];lowleft.b[1]=p->b[1];lowleft.b[2]=p->b[2];
    MIDDLE(p->b,p->c, lowleft.c);
    Normalize(lowleft.c);
    SubdivideTriangle(&lowleft,n-1);
    
    lowright.a[0]=up.c[0];lowright.a[1]=up.c[1];lowright.a[2]=up.c[2];
    lowright.b[0]=lowleft.c[0];lowright.b[1]=lowleft.c[1];lowright.b[2]=lowleft.c[2];
    lowright.c[0]=p->c[0];lowright.c[1]=p->c[1];lowright.c[2]=p->c[2];
    SubdivideTriangle(&lowright, n-1);
    
    TRANS(up.b, mid.c);
    TRANS(up.c, mid.b);
    TRANS(lowleft.c,mid.a);
  //  MIDDLE(p->a, p->b, mid.c);Normalize(mid.c);
  //  MIDDLE(p->a, p->c, mid.b);Normalize(mid.b);
  //  MIDDLE(p->b, p->c, mid.a);Normalize(mid.a);
    SubdivideTriangle(&mid, n-1);
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
    int n = 5;
    
    glBegin(GL_TRIANGLES);
    SubdivideTriangle(&x, n);
 // SubdivideTriangle(&y, n);
 //   SubdivideTriangle(&z, n);
    SubdivideTriangle(&w, n);
    
 //   SubdivideTriangle(&x2, n);
 //   SubdivideTriangle(&y2, n);
    SubdivideTriangle(&z2, n);
    SubdivideTriangle(&w2, n);
    glEnd();
    
    glTranslatef(0.0f, -1.0f, 0);
    glColor3f(0.4,0.4,0.4);
    glPolygonMode(GL_FRONT_AND_BACK,GL_FILL);
    glutSolidCube(2.0);
    
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

