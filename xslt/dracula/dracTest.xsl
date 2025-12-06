<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes"/>
   
    <!-- **************************************************************************-->
    <!-- 2025-11-21 ebb: This XSLT starter file is for the XSLT test in DIGIT 110. 
    Do not alter the stylesheet root element or the output line. 
    
   Your task is to transform the source XML document of Bram Stoker's novel Dracula into HTML with a 
   table of contents linked to a reading view, and styled with CSS. Your XSLT code needs to 
   * process one source XML file and output one valid and well-formed HTML file;
   * contain an HTML table  for the table of contents featuring:
        * each chapter heading
        * each chapter's distinct sorted people/characters mentioned: <person> 
        * each chapter's distinct sorted technologies mentioned: <tech>
     
   * contain internal links from the chapter headings in the table of contents to the chapter headings;
   * contain span elements in the reading view to stylize the persons and technologies mentioned. 
   * Prepare CSS to style your HTML. The XSLT should output the CSS link line to your CSS file accurately. 
   
   
    -->  
    <!-- **************************************************************************-->
   
    <xsl:template match="/">
        <html>
            <head>
                <title>Dracula</title>
                <link rel="stylesheet" type="text/css" href="vamp.css"/>
                <section id="contents"> 
                    <h2>Contents</h2>
                    <table> 
                      
                        <hr/>
                        <tr>
                            <xsl:apply-templates select="chapter" mode="toc"/>
                            <th>Chapter Number</th>
                            <th>Tech mentioned</th>
                            <th>Locations mentioned</th>
                        </tr>
                        <tr>
                            <xsl:apply-templates select="chapter" mode="toc"/>
                        <td>
                            <xsl:apply-templates select="chapTitle" mode="toc"/>
                        </td>
                            <td> <xsl:apply-templates select="tech" mode="toc"/></td>
                            
                            <td> <xsl:apply-templates select="loc" mode="toc"/></td>
                        </tr>
                        <!-- ebb: prepare the table of contents representing each descendant chapter heading,
                   Hint: use <xsl:apply-templates with @mode here.  -->   
                       
                    </table>
                </section>
            </head>
            <body>
                
                <h1 id="top"><xsl:apply-templates select="descendant::title"></xsl:apply-templates></h1>
                 <div>
                     <xsl:apply-templates select="descendant::chapter"></xsl:apply-templates>
                 </div>
                <p>
                      <xsl:apply-templates select="descendant::p"></xsl:apply-templates>  
                  </p>  
                
               
                
                <!--Reading view of the chapters here. -->
               
                    <!-- ebb: process the same descendant chapter heading elements here, but this time to start processing the reading view.  -->
                
            </body>
            
        </html>
    </xsl:template>
    
  
    
        <section id="readingView">
            <xsl:apply-templates/>
        </section>
    
    <xsl:template match="chapter">
        <div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <!--ebb: Continue writing template rules, some with @mode for the table of contents, and some without it for the reading view.  -->
    
    <xsl:template match="chapTitle">
        <h2>
            <xsl:apply-templates/>
        </h2>
    </xsl:template>
   
    
    <xsl:template match="p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    
    <xsl:template match="chapter" mode="toc"> 
        <tr>
            <td><xsl:apply-templates select="descendant::chapTitle ! normalize-space() => distinct-values() => sort() => string-join(',')"/></td>
            <td><xsl:apply-templates select="descendant::tech ! normalize-space() => distinct-values() => sort() => string-join(',')"/></td> 
            <td><xsl:apply-templates select="descendant::loc ! normalize-space() => distinct-values() => sort() => string-join(',')"/></td> 
        </tr>
    </xsl:template>
</xsl:stylesheet>