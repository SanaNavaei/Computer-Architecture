#include <iostream>
#include <vector>

using namespace std;

int main()
{
        vector<int> numbers = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 20, 12, 13, 14, 15, 16, 17, 18, 19, 11};
        int maxx = numbers[0];
        int index = 0;
        for (int i = 0; i < 20; i++)
        {
                if (maxx < numbers[i])
                {
                        maxx = numbers[i];
                        index = i;
                }
        }
}
addi R1, R0, 1000 R1 < -1000 first address lw R5, 1000(R0)R5 < -numbers[0], R5 = maxx add R6, R0, R5 R6 < -maxx addi R7, R0, 0 R7 < -index addi R2, R0, 0 R2 < -i = 0 addi R3, R0, 20 R3 < -20 Loop : beq R2, R3, End_Loop lw R5, 0(R1)R5<-number[] with address R1 slt R4, R6, R5 if R5> R6 : R4 = 1(number > max) bayad swap konim beq R4, R0, After_if add R6, R5, R0 swaping done add R7, R2, R0 After_if : addi R1, R1, 4 run into next address of number addi R2, R2, 1 i++ j Loop End_loop : sw R6, 2000(R0)sw R7, 2004(R0)