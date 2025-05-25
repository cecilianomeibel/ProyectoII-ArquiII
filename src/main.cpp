#include "SystolicArray.hpp"
#include "clk.hpp"
#include "shared.hpp"
#include <iostream>
#include <thread>

void systolic_thread(SystolicArray& array) {
    while (!finish) {
        std::unique_lock<std::mutex> lock(mtx);
        cv.wait(lock, [] { return ready; });

        array.clock_tick();

        if (array.all_queues_empty()) {
            finish = true;
        }

        ready = false;
    }
}

int main() {
    //Aca solo se definen los pesos de cada PE, se podria cambiar
    std::array<std::array<int, 4>, 4> pesos = {{
        {1, 2, 3, 4},
        {2, 2, 2, 2},
        {3, 3, 3, 3},
        {4, 4, 4, 4}
    }};

    SystolicArray array(pesos);

    // Se cargan directamente los datos 
    array.loadInput(0, {1, 42, 23, 12, 4, 6});
    array.loadInput(1, {31, 2, 53, 17, 45, 6});
    array.loadInput(2, {5, 10, 15});
    array.loadInput(3, {7, 8});

    std::thread clk_thread(run_clk);// Hilo para el reloj
    std::thread systolic(systolic_thread, std::ref(array));// Hilo para el Systolic Array

    systolic.join();
    clk_thread.join();

    std::cout << "Resultados:\n";
    for (int i = 0; i < 4; ++i){
        for (int j = 0; j < 4; ++j) {
            std::cout << "PE[" << i << "][" << j << "] result: " << array.get_output(i, j) << std::endl;
        }
    }

    return 0;
}
