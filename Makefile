
COMP      := c++ -std=c++14 -Wall
OUTDIR    := .
INCDIR    := -I. -I/usr/local/include
LIBDIR    := -L/usr/local/lib
LIBS      := -lglfw -lGLEW -framework OpenGL

# all *cpp files
SRCFILES  := $(wildcard *.cpp)
DEPFILES  := $(patsubst %.cpp, $(OUTDIR)/%.d, $(SRCFILES))
OBJS      := $(patsubst %.d, %.o, $(DEPFILES))

# main files
EXEFILES  := $(patsubst %.cpp, $(OUTDIR)/%.out, $(SRCFILES))

all: $(EXEFILES) $(OBJS)
	@echo > /dev/null

# Resolve dependencies automatically.
-include $(DEPFILES)

%.out: %.o
	@echo "Updating: $@ ..."
	@$(COMP) -o $@ $^ $(INCDIR) $(LIBDIR) $(LIBS)

$(OUTDIR)/%.o: %.cpp
	@echo "Updating: $@ ..."
	@$(COMP) -MD -MP -c $< -o $@ $(INCDIR)

partialClean:
	rm -f $(OUTDIR)/*.o $(OUTDIR)/*.d

clean:
	rm -f $(OUTDIR)/*.out $(OUTDIR)/*.o $(OUTDIR)/*.d
