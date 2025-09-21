# BSDSF23M022-OS-A01
Private Repository for First OS Assignment

## Feature-2 Questions/Answers

### Q1. Explain the linking rule $(TARGET): $(OBJECTS) — how does it differ from linking against a library?

Answer : That rule means the final executable target depends directly on object files; the linker simply combines the object code into the executable. When linking against a library (static or dynamic), the target depends on the library file (e.g., libmyutils.a or -lmyutils) rather than individual object files; the linker either copies needed object code from the archive into the executable (static) or stores a runtime reference to a shared object (dynamic).


### Q2. What is a git tag and difference between simple & annotated tag?

Answer :  A git tag marks a specific commit as a release point. A lightweight (simple) tag is just a name referencing a commit. An annotated tag stores metadata (tagger, date, message) and is a full object in git — recommended for releases because it contains a message and signing capability.


### Q3. Purpose of creating a Release on GitHub & attaching binaries?

Answer :  A GitHub Release provides a human-readable release page and lets you attach compiled assets so users can download binaries (e.g., bin/client) without building from source. It’s how you distribute compiled versions and document what changed in that version.

## Feature-3 Questions/Answers

### Q1. Compare the Makefile from Part 2 and Part 3. What are the key differences in the variables and rules that enable the creation of a static library?

Answer : 
	Part2 compiled all .c files directly into one executable. Variables referenced source files and object files only.

	Part3 adds a LIBDIR and rules to build object files for the library modules, then archives them into lib/libmyutils.a using ar rcs. The final link rule links main.o with the archive (either via full .a path or -L -l flags). New rules: $(STATIC_LIB): $(LIB_OBJS) and a static target. This separates compilation (module → .o), archiving ( .o → .a) and final linking (main + .a → executable)

### Q2. What is the purpose of the ar command? Why is ranlib often used immediately after it? 

Answer :
	 ar creates an archive (.a) — essentially a simple container of object files. ar rcs libmyutils.a obj1.o obj2.o packs the objects.

	ranlib (or ar s/ar rcs on GNU) creates or updates the symbol index in the archive. The index speeds up the linker’s lookup of symbols when linking against the archive. On some systems ranlib is required; on others ar rcs already does the indexing.

### Q3. When you run nm on your client_static executable, are the symbols for functions like mystrlen present? What does this tell you about how static linking works? 

Answer : nm on lib/libmyutils.a shows the functions defined in the library (e.g., mystrlen). After linking statically, nm bin/client_static will show the definitions for the functions your program used — because the linker copied the required object code from the archive into the final executable. This demonstrates that static linking embeds library code into the executable (resulting in a larger binary and making the executable independent of external .so files at runtime).


