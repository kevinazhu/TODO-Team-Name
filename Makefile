CXXFLAGS=-std=c++0x -Wall -Werror
SRC_FILES=src/*.cpp nginx-configparser/config_parser.cc
GTEST_PATH=nginx-configparser/googletest/googletest
GMOCK_PATH=nginx-configparser/googletest/googlemock
TEST_FILES=test/*.cpp
COVERAGE_FLAGS=-fprofile-arcs -ftest-coverage

all: webserver 

webserver: $(SRC_FILES)
	g++ $(CXXFLAGS) -I$(BOOST_PATH) -I. $(SRC_FILES) -o webserver -lpthread -lboost_system \
	-L$(BOOST_PATH)

test: $(SRC_FILES) $(TEST_FILES)
	g++ $(CXXFLAGS) -I$(GTEST_PATH)/include -I./src $(GTEST_PATH)/src/gtest_main.cc test/server_test.cpp \
	src/server.cpp src/connection.cpp src/connection_manager.cpp src/request_handler.cpp src/reply.cpp \
	test/libgtest.a -o server_test -lpthread -lboost_system -L$(BOOST_PATH)

	g++ $(CXXFLAGS) -I$(GTEST_PATH)/include -I./src $(GTEST_PATH)/src/gtest_main.cc test/request_handler_test.cpp \
	src/reply.cpp src/request_handler.cpp test/libgtest.a -o request_handler_test -lpthread -lboost_system -L$(BOOST_PATH)

	g++ $(CXXFLAGS) -I$(GTEST_PATH)/include -I./src $(GTEST_PATH)/src/gtest_main.cc test/reply_test.cpp \
	src/reply.cpp src/request_handler.cpp test/libgtest.a -o reply_test -lpthread -lboost_system -L$(BOOST_PATH)
  
	g++ $(CXXFLAGS) -I$(GTEST_PATH)/include -I$(GMOCK_PATH)/include -I./src $(GTEST_PATH)/src/gtest_main.cc test/connection_test.cpp \
	src/connection.cpp src/connection_manager.cpp src/request_handler.cpp src/reply.cpp test/libgtest.a -o \
	connection_test -lpthread -lboost_system -L$(BOOST_PATH)

	g++ $(CXXFLAGS) -I$(GTEST_PATH)/include -I$(GMOCK_PATH)/include -I./src $(GTEST_PATH)/src/gtest_main.cc test/connection_manager_test.cpp \
	src/connection.cpp src/connection_manager.cpp src/request_handler.cpp src/reply.cpp test/libgtest.a -o \
	connection_manager_test -lpthread -lboost_system -L$(BOOST_PATH)

coverage: CXXFLAGS+=$(COVERAGE_FLAGS)
coverage: test
	./reply_test > reply_test_info; \
	./request_handler_test > request_handler_test_info; \
	./server_test > server_test_info; \
	./connection_test > connection_test_info; \
	./connection_manager_test > connection_manager_test_info; \
	\
	gcov -r reply.cpp > reply_coverage; \
	gcov -r request_handler.cpp > request_handler_coverage; \
	gcov -r server.cpp > server_coverage; \
	gcov -r connection.cpp > connection_coverage; \
	gcov -r connection_manager.cpp > connection_manager_coverage;
	

integration:
	./integration_test.sh

clean:
	rm -rf *.o webserver *_test *_info *_coverage *.gcov *.gcda *.gcno

dist:
	tar -czvf webserver.tar.gz *

.PHONY: all test clean