#include <iostream>

int main()
{
    int x = -1;
    while (x < 2)
    {
        x++;
        switch (x) {
        case 0:
            std::cout << "1" << std::endl;
            break;
        case 1: 
            std::cout << "2" << std::endl;
            continue;
        }
        std::cout << x << std::endl;
    }
}