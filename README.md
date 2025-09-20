# BSDSF23M022-OS-A01
Private Repository for First OS Assignment

## Feature-2 Questions/Answers

### Q1. Explain the linking rule $(TARGET): $(OBJECTS) — how does it differ from linking against a library?

Answer : That rule means the final executable target depends directly on object files; the linker simply combines the object code into the executable. When linking against a library (static or dynamic), the target depends on the library file (e.g., libmyutils.a or -lmyutils) rather than individual object files; the linker either copies needed object code from the archive into the executable (static) or stores a runtime reference to a shared object (dynamic).


### Q2. What is a git tag and difference between simple & annotated tag?

Answer :  A git tag marks a specific commit as a release point. A lightweight (simple) tag is just a name referencing a commit. An annotated tag stores metadata (tagger, date, message) and is a full object in git — recommended for releases because it contains a message and signing capability.


### Q3. Purpose of creating a Release on GitHub & attaching binaries?

Answer :  A GitHub Release provides a human-readable release page and lets you attach compiled assets so users can download binaries (e.g., bin/client) without building from source. It’s how you distribute compiled versions and document what changed in that version.





