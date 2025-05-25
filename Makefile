CXX = g++
CXXFLAGS = -std=c++17 -Iinclude -Wall -pthread
SRC_DIR = src
LIB_DIR = lib
BIN_DIR = bin

SRCS = $(wildcard $(SRC_DIR)/*.cpp) $(wildcard $(LIB_DIR)/*.cpp)
OBJS = $(SRCS:.cpp=.o)
TARGET = $(BIN_DIR)/systolic_sim

all: $(TARGET)

$(TARGET): $(SRCS)
	@mkdir -p $(BIN_DIR)
	$(CXX) $(CXXFLAGS) -o $@ $^

clean:
	rm -f $(TARGET)
	rm -f $(SRC_DIR)/*.o $(LIB_DIR)/*.o

run: all
	./$(TARGET)
