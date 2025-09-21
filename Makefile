

<<<<<<< HEAD
# Makefile (static library + client_static)
=======
# Makefile: static + dynamic library support
>>>>>>> dynamic-build
CC := gcc
SRCDIR := src
INCDIR := include
OBJDIR := obj
LIBDIR := lib
BINDIR := bin
<<<<<<< HEAD
CFLAGS := -Wall -Wextra -g -I$(INCDIR)
=======

CFLAGS := -Wall -Wextra -g -I$(INCDIR)
PICFLAGS := -fPIC

# library module sources (string + file modules)
LIB_SRCS := $(SRCDIR)/mystrfunctions.c $(SRCDIR)/myfilefunctions.c
LIB_OBJS := $(patsubst $(SRCDIR)/%.c,$(OBJDIR)/%.o,$(LIB_SRCS))
LIB_PIC_OBJS := $(patsubst $(SRCDIR)/%.c,$(OBJDIR)/%.pic.o,$(LIB_SRCS))

# main
MAIN_SRC := $(SRCDIR)/main.c
MAIN_OBJ := $(OBJDIR)/main.o

STATIC_LIB := $(LIBDIR)/libmyutils.a
SHARED_LIB := $(LIBDIR)/libmyutils.so

TARGET_STATIC := $(BINDIR)/client_static
TARGET_DYNAMIC := $(BINDIR)/client_dynamic

.PHONY: all dirs  static shared client_static client_dynamic clean

all: static shared client_static client_dynamic


# Compile normal objects (for static)
$(OBJDIR)/%.o: $(SRCDIR)/%.c | dirs
	$(CC) $(CFLAGS) -c $< -o $@

# Compile PIC objects (for shared)
$(OBJDIR)/%.pic.o: $(SRCDIR)/%.c | dirs
	$(CC) $(CFLAGS) $(PICFLAGS) -c $< -o $@

# main object
$(MAIN_OBJ): $(MAIN_SRC) | dirs
	$(CC) $(CFLAGS) -c $(MAIN_SRC) -o $(MAIN_OBJ)

# static library
static: $(STATIC_LIB)

$(STATIC_LIB): $(LIB_OBJS) | dirs
	ar rcs $@ $(LIB_OBJS)
	ranlib $@ || true

# shared library (position independent)
shared: $(SHARED_LIB)

$(SHARED_LIB): $(LIB_PIC_OBJS) | dirs
	$(CC) -shared -o $@ $(LIB_PIC_OBJS)

# link static client
client_static: $(MAIN_OBJ) $(STATIC_LIB)
	$(CC) $(CFLAGS) $(MAIN_OBJ) $(STATIC_LIB) -o $(TARGET_STATIC)

# link dynamic client (linker will record needed SONAME)
client_dynamic: $(MAIN_OBJ) $(SHARED_LIB)
	# link against shared library (use -L ... -lmyutils or full path)
	$(CC) $(CFLAGS) $(MAIN_OBJ) -L$(LIBDIR) -lmyutils -o $(TARGET_DYNAMIC)
>>>>>>> dynamic-build

# Library sources (module files)
LIB_SRCS := $(SRCDIR)/mystrfunctions.c $(SRCDIR)/myfilefunctions.c
LIB_OBJS := $(patsubst $(SRCDIR)/%.c,$(OBJDIR)/%.o,$(LIB_SRCS))

# Main program
MAIN_SRC := $(SRCDIR)/main.c
MAIN_OBJ := $(OBJDIR)/main.o

STATIC_LIB := $(LIBDIR)/libmyutils.a
TARGET_STATIC := $(BINDIR)/client_static

.PHONY: all clean dirs static lib client_static

all: static client_static

# compile library object files
$(OBJDIR)/%.o: $(SRCDIR)/%.c | dirs
	$(CC) $(CFLAGS) -c $< -o $@

# create static library
static: $(STATIC_LIB)

$(STATIC_LIB): $(LIB_OBJS) | dirs
	@echo "Creating static library $@"
	ar rcs $@ $(LIB_OBJS)
	# ranlib is safe to run for compatibility on some systems
	ranlib $@ || true

# compile main object
$(MAIN_OBJ): $(MAIN_SRC) | dirs
	$(CC) $(CFLAGS) -c $(MAIN_SRC) -o $(MAIN_OBJ)

# link the static client (link against the .a)
client_static: $(MAIN_OBJ) $(STATIC_LIB) | dirs
	@echo "Linking $(TARGET_STATIC) with $(STATIC_LIB)"
	# link using the static archive (full path avoids -L ordering issues)
	$(CC) $(CFLAGS) $(MAIN_OBJ) $(STATIC_LIB) -o $(TARGET_STATIC)

# Clean build artifacts (keeps source)
clean:
<<<<<<< HEAD
	rm -rf $(OBJDIR)/*.o  sample_input.txt
=======
	rm -rf $(OBJDIR)/*.o $(OBJDIR)/*.pic.o  sample_input.txt

>>>>>>> dynamic-build
