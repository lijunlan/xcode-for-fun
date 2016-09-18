#include<fstream>
#include<vector>
#include <cstdlib>
using namespace std;
ifstream cin("input.txt");
ofstream cout("output.txt");
#define SIZE 8

int c =0;

double board[SIZE][SIZE];
vector<int> solution;

inline int sample(int up)
{
	return (int)(((double)rand()/(RAND_MAX+1))*up);
}

void put_cheese(int i,int j)
{
	board[i][j]=1;
	solution.push_back(j);
	c++;
}

void up_cheese(int i,int j)
{
	board[i][solution[i]] = 0;
	solution.pop_back();
}

bool check(int i,int j)
{
    
	for (int k=0;k!=SIZE;++k)
	{
		if (k!=i && board[k][j]==1)
			return false;
	}
	for (int k=0;k!=SIZE;++k)
	{
		if (i+k <SIZE && j+k<SIZE && board[i+k][j+k]==1) return false;
		if (i-k >=0 && j+k<SIZE && board[i-k][j+k]==1) return false;
		if (i-k >=0 && j-k >=0 && board[i-k][j-k]==1) return false;
		if (i+k <SIZE && j-k >=0 && board[i+k][j-k]==1) return false;
	}
	return true;
}

bool back_date(int i)
{
	if (i==SIZE)
		return true;
	for (int j=1;j!=SIZE;++j)
	{
		if (check(i,j))
		{
			put_cheese(i,j);
			if (back_date(i+1))
				return true;
			up_cheese(i,j);
		}
	}
	return false;
}


int sample_position(int i)
{
	vector<int> temp;
	for (int k=0;k!=SIZE;++k)
	{
		if (check(i,k))
			temp.push_back(k);
	}
	if (temp.size())
		return temp[sample((int)temp.size())];
	else return -1;
}

bool vagus(int step)
{
	for (int i=0;i!=step;++i)
	{
		int j =sample_position(i);
		if (j==-1)
			return false;
		put_cheese(i,j);
	}
	return true;
}

void clear()
{
	for (int i=0;i!=SIZE;++i)
		for (int j=0;j!=SIZE;++j)
			board[i][j] = 0;
	solution.clear();
}

void queens(int step)
{
	do
	{
		clear();
		while (!vagus(step)){};
	}
	while (!back_date(step));
}

int main()
{
    srand((unsigned int)time(0));
	queens(2);
    
	for (int i=0;i!=SIZE;++i)
	{
		for (int j=0;j!=SIZE;++j)
			cout <<board[i][j]<<" ";
		cout<<endl;
	}
	cout <<c<<endl;
}
