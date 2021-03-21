#include <string>
#include <iostream>

int main()
{
	std::string path;
	std::cout << "Path example on Linux Ubuntu: /home/acos/text.txt\n\n";
	std::cout << "Please, input the path fully:\n";

	std::cin >> path;
	std::cout << "\nThank you! The length of your path is: " << path.size() << " chars.\n";

	return 0;
}
