CC = g++
CFLAGS = -std=c++11 -Wall

SRCS = person.cpp purchase.cpp employee.cpp customer.cpp company.cpp companydb.cpp
OBJS = $(SRCS:.cpp=.o)
EXEC = companydb

all: $(EXEC)

$(EXEC): $(OBJS)
	$(CC) $(CFLAGS) -o $(EXEC) $(OBJS)

%.o: %.cpp
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJS) $(EXEC)