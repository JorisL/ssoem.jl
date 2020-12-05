all: ssoem.c 
	mkdir .build
	mkdir .build/soem
	mkdir .build/osal
	mkdir .build/osal/macosx
	mkdir .build/oshw
	mkdir .build/oshw/macosx
	cc  -Isoem -Iosal -Iosal/macosx -Ioshw/macosx -Wall -Wextra -Werror -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX11.0.sdk -o .build/soem/ethercatbase.c.o -c soem/ethercatbase.c
	cc  -Isoem -Iosal -Iosal/macosx -Ioshw/macosx -Wall -Wextra -Werror -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX11.0.sdk -o .build/soem/ethercatcoe.c.o -c soem/ethercatcoe.c
	cc  -Isoem -Iosal -Iosal/macosx -Ioshw/macosx -Wall -Wextra -Werror -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX11.0.sdk -o .build/soem/ethercatconfig.c.o -c soem/ethercatconfig.c
	cc  -Isoem -Iosal -Iosal/macosx -Ioshw/macosx -Wall -Wextra -Werror -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX11.0.sdk -o .build/soem/ethercatdc.c.o -c soem/ethercatdc.c
	cc  -Isoem -Iosal -Iosal/macosx -Ioshw/macosx -Wall -Wextra -Werror -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX11.0.sdk -o .build/soem/ethercateoe.c.o -c soem/ethercateoe.c
	cc  -Isoem -Iosal -Iosal/macosx -Ioshw/macosx -Wall -Wextra -Werror -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX11.0.sdk -o .build/soem/ethercatfoe.c.o -c soem/ethercatfoe.c
	cc  -Isoem -Iosal -Iosal/macosx -Ioshw/macosx -Wall -Wextra -Werror -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX11.0.sdk -o .build/soem/ethercatmain.c.o -c soem/ethercatmain.c
	cc  -Isoem -Iosal -Iosal/macosx -Ioshw/macosx -Wall -Wextra -Werror -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX11.0.sdk -o .build/soem/ethercatprint.c.o -c soem/ethercatprint.c
	cc  -Isoem -Iosal -Iosal/macosx -Ioshw/macosx -Wall -Wextra -Werror -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX11.0.sdk -o .build/soem/ethercatsoe.c.o -c soem/ethercatsoe.c
	cc  -Isoem -Iosal -Iosal/macosx -Ioshw/macosx -Wall -Wextra -Werror -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX11.0.sdk -o .build/osal/macosx/osal.c.o -c osal/macosx/osal.c
	cc  -Isoem -Iosal -Iosal/macosx -Ioshw/macosx -Wall -Wextra -Werror -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX11.0.sdk -o .build/oshw/macosx/nicdrv.c.o -c oshw/macosx/nicdrv.c
	cc  -Isoem -Iosal -Iosal/macosx -Ioshw/macosx -Wall -Wextra -Werror -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX11.0.sdk -o .build/oshw/macosx/oshw.c.o -c oshw/macosx/oshw.c
	ar qc libsoem.a .build/soem/ethercatbase.c.o .build/soem/ethercatcoe.c.o .build/soem/ethercatconfig.c.o .build/soem/ethercatdc.c.o .build/soem/ethercateoe.c.o .build/soem/ethercatfoe.c.o .build/soem/ethercatmain.c.o .build/soem/ethercatprint.c.o .build/soem/ethercatsoe.c.o .build/osal/macosx/osal.c.o .build/oshw/macosx/nicdrv.c.o .build/oshw/macosx/oshw.c.o
	cc -Isoem -Iosal -Iosal/macosx -Ioshw/macosx -Wall -Wextra -Werror -c ssoem.c
	cc  -Wall -Wextra -Werror -isysroot /Library/Developer/CommandLineTools/SDKs/MacOSX11.0.sdk -Wl,-search_paths_first -Wl,-headerpad_max_install_names ssoem.o -shared -o libssoem.so libsoem.a -lpthread -lpcap

clean: 
	$(RM) libsoem.a ssoem.o libssoem.so