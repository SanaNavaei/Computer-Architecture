#include <iostream>
#include <vector>
using namespace std;
int main()
{
    vector<int> numbers = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 20, 12, 13, 14, 15, 16, 17, 18, 19, 11};
    int maxx = numbers[0];
    int max_index = 0;
    for (int i = 0; i < 20; i++)
    {
        if (maxx < numbers[i])
        {
            maxx = numbers[i];
            max_index = i;
        }
    }
}
