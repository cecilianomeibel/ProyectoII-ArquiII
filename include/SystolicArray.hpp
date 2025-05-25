#ifndef SYSTOLIC_ARRAY_H
#define SYSTOLIC_ARRAY_H

#include "pe.hpp"
#include <array>
#include <queue>

class SystolicArray {
private:
    static const int SIZE = 4;
    std::array<std::array<PE, SIZE>, SIZE> pe_array; //matriz de PE's

    
    std::array<std::queue<int>, SIZE> input_queues; // Shift register de entrada para cada PE

public:
    SystolicArray(const std::array<std::array<int, SIZE>, SIZE>& pesos); //Definir pesos

    void loadInput(int row, const std::vector<int>& data); // carga datos a PE[row][0]
    void clock_tick(); // un ciclo de reloj
    int get_output(int row, int col); // leer resultado

    bool all_queues_empty(); // para saber si ya se acabaron los datos
};

#endif // SYSTOLIC_ARRAY_H
