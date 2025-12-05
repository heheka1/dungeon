<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0" 
    xmlns="http://www.w3.org/1999/xhtml">
    
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" 
        include-content-type="no" indent="yes"/>
    <xsl:template match="cover">
        <h1> <xsl:apply-templates select="title"/></h1>  
        <h2><xsl:apply-templates select="attribution"></xsl:apply-templates> </h2>
        <h3><xsl:apply-templates select="subtype"></xsl:apply-templates></h3>
    </xsl:template>
    <xsl:template match="/">
        
        <html>
          <head>
            
                
                  <title>
                      <xsl:apply-templates select="descendant::title"></xsl:apply-templates>
                  </title>
                  <link rel="stylesheet" href="skyrim.css"/>
          </head>  
            
            <body>
                <xsl:apply-templates select="descendant::body"/>
                <xsl:apply-templates select="descendant::cover"/>
              <h1> <xsl:apply-templates select="descendant::title">
            
              </xsl:apply-templates></h1>
            </body>
            
        </html>
    </xsl:template>
   
        <xsl:template match="paragraph">
            <p>
                <xsl:apply-templates/>
            </p>
        </xsl:template>
    <xsl:template match="QuestEvent | character | location">
   <span class="{name()}"> <xsl:apply-templates/>
   </span>
    </xsl:template>
</xsl:stylesheet>
    <!-- I'm not sure why but my css page is not being 
    processed when I try to out put anything. I've tried to 
    'command-o' it and still nothing is popping up -->
