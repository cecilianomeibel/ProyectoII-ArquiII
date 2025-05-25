#ifndef PE_H
#define PE_H

class PE
{

private:

    // Entradas del PE 
    int currentValue; //Valor que viene de izq
    int weight;//Peso del PE
    int receivedValue;//Valor que viene de arriba
    // Salida del PE
    int outputCalculated; //Valor que sale por abajo
    int outputCurrent; //Valor que sale por la derecha


public:

    PE(unsigned int peso = 0); // Constructor por defecto
    // Funcion para ejecutar el Dato
    //int execute(int num1, int num2, int num3);

    void setCurrentValue(int value); //iniciar el nuevo dato
    void setReceivedValue(int value); //iniciar el nuevo dato recibido de arriba
    
    // Funcion para enviar el Dato
    int sendCurrent();
    int sendCalculated();

    // Funcion de ejecucion
    void cycle();

};


#endif // PE_H
