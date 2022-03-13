# EMacros.jcl
EMacros.jcl contains a group of IBM assembler routines commonly used by many
of my projects.  It is connected as a subproject to many of my projects.

There are 3 macros in this file  ESTART, ERETURN, EREGS.  These generate
the standard routine linkage plus additional "eye catcher" to help locate 
stuff in dumps.  In addition, an option is available to
specify an alternate entry point for PL/1 F programs.  ERETURN generates
a standard compatable return sequence.  EREGS defines the symbols R0 to
R15 as 0 to 15 for symbolic register reference.  Side benefit it the R#
will be in the xref.

Please see README.pdf for complete details.
==============================================================
