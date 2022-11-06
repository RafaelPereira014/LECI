.PHONY: clean cleanall

CPPFLAGS=-Wall -Wno-write-strings -ggdb -pthread -Iinclude
LDFLAGS = -pthread
SYMBOLS=-DEXIT_POLICY            # -DEXCEPTION_POLICY or -DEXIT_POLICY

TARGET = urgency

OBJS=pfifo.o

all:	$(TARGET) 

%.o: %.cpp settings.h
	$(CXX) $(SYMBOLS) $(CPPFLAGS) -c $<


clean:
	rm -fv *.o core

cleanall: clean
	rm -f $(TARGET)

urgency: $(OBJS) urgency.o thread.o utils.o
	$(CXX) -o $@ $^ $(LDFLAGS)

