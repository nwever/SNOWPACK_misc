# Compiler
CXX = gcc

# Compiler flags
CXXFLAGS = -I $(METEOIO_DIR)/include -O3 -march=native -Wall -Wextra -fno-strict-aliasing

# Linker flags
LDFLAGS = -L $(METEOIO_DIR)/lib -lmeteoio -lstdc++ -lm

# Target executable name
TARGET = horizons

# Source files
SRCS = horizons.cc

# Object files
OBJS = $(SRCS:.cc=.o)

# Default rule to build the executable
$(TARGET): $(OBJS)
	$(CXX) -o $(TARGET) $(OBJS) $(LDFLAGS)

# Rule to compile .cc to .o
%.o: %.cc
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Clean rule to remove compiled files
clean:
	rm -f $(TARGET) $(OBJS)
