This folder has some example makefiles illustrating how I use the build helpers in my own projects.

This system is designed for a specific folder structure.  For best results use this format:

Big Project/
   > SubProject/
       > src/
           > Source1.cpp
           > Source2.cpp
       > include/
           > Source1.h
           > Source2.h

When specifying the source list, the makefiles assume you are listing files in src/
This can be changed by changing $(SOURCE_DIR) or by editing buildpublic.make, buildprivate.make, or buildexample.make

To use the visual studio property sheets simply open the property manager, expand one of your projects so you see folders for Debug and Release properties.  Right click on the folders
and select Add Property Sheet.  These sheets act as new default values for many of the settings in a project.  If you have already saved your project with certain settings you have to delete
those settings for the property sheets to do their job.  See the example visual studio project files


When a project gets built certain folders are created.  For example, if the example above is a build with buildpublic, after building the folder structure will be

Big Project/
   > bin/
       > Linux-glibc-2.5-x86-64/
	       > Release/
		        > example
   > SubProject/
       > build/
	       > Linux-glibc-2.5-x86-64/
		       > Source1.D
			   > Source2.D
		       > Release/
			       > Source1.o
				   > Source2.o
       > src/
           > Source1.cpp
           > Source2.cpp
       > include/
           > Source1.h
           > Source2.h
		   
		   