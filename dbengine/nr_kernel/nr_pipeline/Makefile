# Make file for the nr_preprocessing module
# It calls the CMakelists.txt file in the same directory

EXT_NAME = nr_pipeline

NEURDBPATH ?= /code/neurdb-dev

.PHONY: all cmake buildext install clean

all: cmake buildext

build:
	mkdir -p build
	cd build && cmake -DCMAKE_BUILD_TYPE=Release ..

debug: builddbg buildextdbg

builddbg:
	mkdir -p build
	cd build && cmake -DCMAKE_BUILD_TYPE=Debug ..

buildextdbg: buildext
buildext: build
	cd build; make -j; cd ..

install: buildext
	cd build; make install; cd ..
	cp $(EXT_NAME).control $(NEURDBPATH)/psql/share/postgresql/extension
	cp sql/nr_pipeline--1.0.0.sql $(NEURDBPATH)/psql/share/postgresql/extension
	# only works when in psql/lib/postgresql
	rm -f $(NEURDBPATH)/psql/lib/$(EXT_NAME).so
	rm -f $(NEURDBPATH)/psql/lib/postgresql/$(EXT_NAME).so
	cp build/$(EXT_NAME).so $(NEURDBPATH)/psql/lib
	cp build/$(EXT_NAME).so $(NEURDBPATH)/psql/lib/postgresql

clean:
	rm -rf build
