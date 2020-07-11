#include "Pipe.h"
#include "Manager.h"
#include <iostream>
#include <thread>

using namespace std;


int main()
{
	srand(time_t(NULL));



	Pipe p;
	bool isConnect = p.connect();

	string ans;
	while (!isConnect)
	{
		cout << "cant connect to graphics" << endl;
		cout << "Do you try to connect again or exit? (0-try again, 1-exit)" << endl;
		cin >> ans;

		if (ans == "0")
		{
			cout << "trying connect again.." << endl;
			Sleep(5000);
			isConnect = p.connect();
		}
		else
		{
			p.close();
			return 0;
		}
	}

	Manager mgr(p);

	mgr.playGame();

	p.close();
	return 0;
}