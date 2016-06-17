use strict;
use warnings;
use Fl qw[:event :label :box :font];
my $window = Fl::Window->new(100, 100, 300, 180);
my $box = Fl::HtmlView->new(0,0, 300, 180);
warn $box;
$window->resizable($box);
$box->value(q{<a name="top"></a>
<!--
    Test the Fl_Help_View's ability to parse simple HTML.
-->
<H1>Simple HTML Tests</H1>
<UL>
    <LI> <a href="#Plain Test">Plain Text Test</A> </li>
    <LI> <a href="#Pre Test">PRE (preformatted Text) Test</A>
    <LI> <a href="#Headings">Heading Tests</A>
    <LI> <a href="#Lists">UL, OL, DL Lists</A>
    <LI> <a href="#Table">TABLE Tests</A>
    <LI> <a href="#Center">CENTER Tests</A>
    <LI> <a href="#HR">HR (Horizontal Rule) Tests</A>
    <LI> <a href="#Tabs">PRE Tab Indent Tests</A>
</UL>
<P>

<A NAME="Plain Test"></A>
<B>Plain text paragraphs</B> <a href="#top">^top</a><P>
    The licenses for most software are designed to take away your freedom to
    share and change it.  By contrast, the GNU General Public Licenses are
    intended to guarantee your freedom to share and change free software--to
    make sure the software is free for all its users.
    <P>
    This license, the Library General Public License, applies to some
    specially designated Free Software Foundation software, and to any
    other libraries whose authors decide to use it.  You can use it for
    your libraries, too.
    <P>
    <I>Italic content.</I> <B>Bold content</B> <BIG>Big content.</BIG>
    <SMALL>Small content.</SMALL> <U>Underline content.</U> <STRIKE>Strike out content.</STRIKE>
    <FONT COLOR=RED>Red font content.</FONT> <FONT COLOR=#ff8800>Orange #ff8800 font content.</FONT>
    <FONT COLOR=BLUE>Blue font content.</FONT>
    <P>
    <FONT FACE="Helvetica">This should be Helvetica. 0123456789</FONT><BR>
    <FONT FACE="Arial">This should be Arial. 0123456789</FONT><BR>
    <FONT FACE="Sans">This should be Sans. 0123456789</FONT><BR>
    <FONT FACE="Times">This should be Times. 0123456789</FONT><BR>
    <FONT FACE="Serif">This should be Serif. 0123456789</FONT><BR>
    <FONT FACE="Courier">This should be Courier. 0123456789</FONT><BR>
    <FONT FACE="Symbol">This should be Symbol. 0123456789</FONT>
<P>

<A NAME="Pre Test"></A>
<B>Preformatted paragraphs</B> <a href="#top">^top</a><PRE>
The following 2 paragraphs should be indented 4 spaces.

    The licenses for most software are designed to take away
    your freedom to share and change it.  By contrast, the
    GNU General Public Licenses are intended to guarantee your
    freedom to share and change free software -- to make sure
    the software is free for all its users.

    This license, the Library General Public License, applies to
    some specially designated Free Software Foundation software,
    and to any other libraries whose authors decide to use it.
    You can use it for your libraries, too.

The following 2 paragraphs should be indented 8 spaces.

        The licenses for most software are designed to take away
        your freedom to share and change it.  By contrast, the
        GNU General Public Licenses are intended to guarantee
        your freedom to share and change free software --
        to make sure the software is free for all its users.

        This license, the Library General Public License,
        applies to some specially designated Free Software
        Foundation software, and to any other libraries whose
        authors decide to use it.  You can use it for your
        libraries, too.

The following text content should all be indented 4 spaces.

    <I>Italic content.</I> <B>Bold content</B> <BIG>Big content.</BIG>
    <SMALL>Small content.</SMALL> <U>Underline content.</U> <STRIKE>Strike out content.</STRIKE>
    <FONT COLOR=RED>Red font content.</FONT> <FONT COLOR=#ff8800>Orange #ff8800 font content.</FONT>
    <FONT COLOR=BLUE>Blue font content.</FONT>
</PRE>
<P>

<A NAME="Headings"></A>
<B>Heading tests</B> <a href="#top">^top</a>
<H1>This is H1 text</H1>
<H2>This is H2 text</H2>
<H3>This is H3 text</H3>
<H4>This is H4 text</H4>
<H5>This is H5 text</H5>
<H6>This is H6 text</H6>
<P>

<A NAME="Lists"></A>
<B>UL tests</B> <a href="#top">^top</a>
<UL>
   This text should be indented in a UL.<BR>
   This should be a second line of indent.<P>
   <LI> First list item with default attributes</LI>
   <LI> Second list item</LI>
   <LI> Third list item</LI>
</UL>
End of UL. Starting an OL:
<OL>
   This text should be indented in an OL.<BR>
   This should be a second line of indent.<P>
   <LI> First list item with default attributes</LI>
   <LI> Second list item</LI>
   <LI> Third list item</LI>
</OL>
End of OL. Starting a DL:
<DL>
  A DL has been started. This should be a list of terms.
  Some browsers display the description indented right
  relative to the terms, though I don't think FLTK's does this.<P>
  <DT>First term</DT>
  <DD>Description of first term.</DD>
  <DT>Second term</DT>
  <DD>Description of second term goes here.</DD>
  <DT>Third term</DT>
  <DD>Description of third term goes here.</DD>
</DL>
End of DL.
<P>

<A NAME="Table"></A>
<B>Simple 2 Column Non-border Table, No Headings</B> <a href="#top">^top</a>
<TABLE>
  <TR>
    <TD>Column 1</TD>  <TD>Column 2</TD>
  </TR><TR>
    <TD>Aaa Aaa Aaa</TD>  <TD>Xxx Xxx Xxx</TD>
  </TR><TR>
    <TD>Bbb Bbb Bbb</TD>  <TD>Yyy Yyy Yyy</TD>
  </TR><TR>
    <TD>Ccc Ccc Ccc</TD>  <TD>Zzz Zzz Zzz</TD>
  </TR>
</TABLE>
<P>
<B>Simple 2 Column Bordered Table, No Headings</B>
<TABLE BORDER=1>
  <TR>
    <TD>Column 1</TD>  <TD>Column 2</TD>
  </TR><TR>
    <TD>Aaa Aaa Aaa</TD>  <TD>Xxx Xxx Xxx</TD>
  </TR><TR>
    <TD>Bbb Bbb Bbb</TD>  <TD>Yyy Yyy Yyy</TD>
  </TR><TR>
    <TD>Ccc Ccc Ccc</TD>  <TD>Zzz Zzz Zzz</TD>
  </TR>
</TABLE>
<P>
<B>Simple Two Column Table With Borders And Heading</B>
<TABLE BORDER=1>
  <TH>Table Heading</TH>
  <TR>
    <TD>Column 1</TD>  <TD>Column 2</TD>
  </TR><TR>
    <TD>Aaa Aaa Aaa</TD>  <TD>Xxx Xxx Xxx</TD>
  </TR><TR>
    <TD>Bbb Bbb Bbb</TD>  <TD>Yyy Yyy Yyy</TD>
  </TR><TR>
    <TD>Ccc Ccc Ccc</TD>  <TD>Zzz Zzz Zzz</TD>
  </TR>
</TABLE>
<P>
<B>Simple Bordered Table With Heading And 10 Cell Padding + Spacing</B>
<TABLE BORDER=1 CELLPADDING=10 CELLSPACING=10>
  <TH>Table Heading</TH>
  <TR>
    <TD>Column 1</TD>  <TD>Column 2</TD>
  </TR><TR>
    <TD>Aaa Aaa Aaa</TD>  <TD>Xxx Xxx Xxx</TD>
  </TR><TR>
    <TD>Bbb Bbb Bbb</TD>  <TD>Yyy Yyy Yyy</TD>
  </TR><TR>
    <TD>Ccc Ccc Ccc</TD>  <TD>Zzz Zzz Zzz</TD>
  </TR>
</TABLE>
<P>
<B>Simple Table Of Images, Two Columns, Three Rows</B>
<TABLE BORDER=1 CELLPADDING=10 CELLSPACING=10>
  <TH>Table Heading</TH>
  <TR>
    <TD>Column 1</TD>  <TD>Column 2</TD>
  </TR><TR>
    <TD><IMG SRC="../documentation/src/FL200.png"></TD>
    <TD>This is the FLTK logo</TD>
  </TR><TR>
    <TD><IMG SRC="../documentation/src/tiny.png"></TD>
    <TD>Tiny FLTK logo.</TD>
  </TR><TR>
    <TD><IMG SRC="../documentation/src/Fl_Value_Input.png"></TD>
    <TD>This is an image of Fl_Value_Input</TD>
  </TR><TR>
    <TD><IMG SRC="../documentation/src/Fl_Value_Output.png"></TD>
    <TD>This is an image of Fl_Value_Output</TD>
  </TR>
</TABLE>
<P>

<A NAME="Center"></A>
<B>Testing Centered Text And Image</B> <a href="#top">^top</a>
<center>This text should be centered. What follows is a line break.
<BR>
After the line break, still centered. What follows is a paragraph break.
<P>
This text should be in a paragraph break. This is paragraph #1 of 2.
<P>
This text should be in a paragraph break as well. This is paragraph #2 of 2.
<P>
What follows should be a centered image.<BR>
<IMG SRC="../documentation/src/FL200.png" /><BR>
That should be a centered image.
<P>
</center>
<P>

<a name="HR"></a>
<B>Testing Horizontal Line</B> <a href="#top">^top</a>
<HR>
This text should be between two horizontal lines.
<HR>
<P>
<A NAME="Tabs"></A>
<B>Preformatted Indent Test</B> <a href="#top">^top</a>
<PRE>
    This tests that tabs and space indenting work correctly.
    Each line should be one space right of the line preceding it
    unless otherwise specified:

0 Tab
 1 Space
  2 Space
   3 Space
    4 Space
     5 Space
      6 Space
       7 Space            __
        8 Space             |
    	4 Space + 1 Tab     |-- should all be
	1 Tab             __|   same indent level
	 1 Tab + 1 Space
	  1 Tab + 2 Space
	   1 Tab + 3 Space
	    1 Tab + 4 Space
	     1 Tab + 5 Space
	      1 Tab + 6 Space
	       1 Tab + 7 Space            __
	        1 Tab + 8 Space             |
    	        4 Space + 1 Tab + 8 Space   |-- should all be
		2 Tab                     __|   same indent level
		 2 Tab + 1 Space
		  2 Tab + 2 Space
		   2 Tab + 3 Space
		    ..
</PRE>
<b>bold</b> not bold <br /> <center><IMG ALT="..." SRC="sanko.png" WIDTH="100" HEIGHT="100" /></center>});
$window->end();
$window->show();
exit run();
