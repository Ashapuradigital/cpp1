CXX=g++
CXXFLAGS=-std=c++17 -g -pedantic -Wall -Wextra -Werror -fsanitize=address,undefined -fno-omit-frame-pointer
LDLIBS=


SRCS=schedule.cpp
DEPS=Process.cpp STCF.cpp
BINS=$(SRCS:%.cpp=%.exe)
OBJS=$(DEPS:%.cpp=%.o)


all: clean $(BINS)

%.o: %.cpp %.h
	$(CXX) $(CXXFLAGS) -c -o $@ $<

%.exe: %.cpp $(OBJS)
	$(CXX) $(CXXFLAGS) -o $(patsubst %.exe,%,$@) $^ $(LDLIBS)


.PHONY: clean test

clean:
	rm -f schedule out.trace ./test-files/cmd*.txt

test: all
	chmod u+x le3-tests.sh
	./le3-tests.sh

private_test: all
	chmod u+x le3_private_tests.sh
	./le3_private_tests.sh

