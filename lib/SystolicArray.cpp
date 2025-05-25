#include "SystolicArray.hpp"

SystolicArray::SystolicArray(const std::array<std::array<int, SIZE>, SIZE>& pesos) {
    for (int i = 0; i < SIZE; ++i)
        for (int j = 0; j < SIZE; ++j)
            pe_array[i][j] = PE(pesos[i][j]);
}

void SystolicArray::loadInput(int row, const std::vector<int>& data) {
    for (int val : data)
        input_queues[row].push(val);
}

void SystolicArray::clock_tick() {
    // Pasar el value de los PE de la columna izq con los siguientes valores
    for (int i = 0; i < SIZE; ++i) {
        if (!input_queues[i].empty()) {
            pe_array[i][0].setCurrentValue(input_queues[i].front());
            input_queues[i].pop();
        } else {
            pe_array[i][0].setCurrentValue(0); // o mantener el anterior
        }
    }

    // Ejecutar todos los PE
    for (int i = 0; i < SIZE; ++i)
        for (int j = 0; j < SIZE; ++j)
            pe_array[i][j].cycle();

    // Pasar los valores: currentValue a la derecha, resultado hacia abajo
    for (int i = 0; i < SIZE; ++i)
        for (int j = 0; j < SIZE; ++j) {
            if (j + 1 < SIZE)
                pe_array[i][j + 1].setCurrentValue(pe_array[i][j].sendCurrent());
            if (i + 1 < SIZE)
                pe_array[i + 1][j].setReceivedValue(pe_array[i][j].sendCalculated());
        }
}

int SystolicArray::get_output(int row, int col) {
    return pe_array[row][col].sendCalculated(); // resultado más reciente
}

bool SystolicArray::all_queues_empty() {
    for (auto& q : input_queues)
        if (!q.empty()) return false;
    return true;
}
