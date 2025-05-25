#include "pe.hpp"


PE::PE(unsigned int peso) : currentValue(0), receivedValue(0), weight(peso), outputCalculated(0), outputCurrent(0) {}


 void PE::setCurrentValue(int value)
{
    currentValue = value; //iniciar el nuevo dato
}


void PE::setReceivedValue(int value)
{
    receivedValue = value; //iniciar el nuevo dato recibido de arriba
}   


int PE::sendCalculated()
{
    return (currentValue * weight) + receivedValue;
}

int PE::sendCurrent()
{
    return currentValue;
}

void PE::cycle()
{
    outputCalculated = sendCalculated();
    outputCurrent = sendCurrent();
}