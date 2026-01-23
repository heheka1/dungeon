<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xpath-default-namespace="http://www.tei-c.org/ns/1.0" 
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns="http://www.w3.org/1999/xhtml"
  version="3.0">
    
    <xsl:output method="xhtml" html-version="5" omit-xml-declaration="yes" 
        include-content-type="no" indent="yes"/>
    
    <xsl:variable name="immortalColl" as="document-node()+" 
        select="collection('../myImmortal/chapters/?select=*.xml')"/>
    
    <xsl:variable name="introFile" as="document-node()" select="doc('../myImmortal/chapters/introChapter1-2.xml')"/>
    <xsl:variable name="characterList" as="document-node()" select="doc('../myImmortal/characterList.xml')"/>
    <xsl:template match="/">
        <html>
          <head>
              
             
              <title>
                  <xsl:apply-templates select="descendant::title"></xsl:apply-templates>
                  
              </title>
              <link rel="stylesheet" href="style.css"/>
            
          </head>  
            <body>
               <div class="header"> <nav>
                    <a href="index.html">Home</a> | <a href="webCharacter.html">Character List</a> | <a href="myImmortal.html">Full Fanfiction</a> | <a href="markupStrat.html">Markup Strategy</a>
                    | <a href="https://github.com/heheka1/myImmortal">Github</a> 
                </nav></div>
                <h1>My Immortal, as edited by us!</h1>
                
                <h2>About this edition</h2>
                
          
       <section class="flex"> 
           
           <div class="reading-view">    
            <xsl:apply-templates select="$introFile//teiHeader//titleStmt" mode="top">
                   <xsl:sort select="(following::text/front//titlePart[1])/@n"/>
                </xsl:apply-templates>
                
                <!-- ebb: 2025-12-10: At this point, Knox and I realize that we have to control the sort order of 
                    <text> elements, NOT one thing on each file. So we need to plant an attribute on each text element
                    in the source files because there are MULTIPLE <text> elements. 
                    We will do this with a nice identity transformation so we don't go blind!
              -->
                
                <xsl:apply-templates select="$immortalColl//text">
                    <xsl:sort select="@n ! xs:integer(.)"/>
                </xsl:apply-templates>
                </div>
         \
               
               <iframe name="characterList" id="characterList" src="characterList.html"/>
               
          

       </section>
                
            </body>
        </html>
    </xsl:template>
    <xsl:template match="text">
        <section id="chap-{@n}" class="chapter">
            <xsl:apply-templates/>
        </section>
        
    </xsl:template>
    
    <xsl:template match="titleStmt" mode="top">
        
        <h3><xsl:text>Author: </xsl:text>
        <xsl:apply-templates select="author"/></h3>
        
        <h3>Editing and encoding by</h3>
        <ul>
            <xsl:apply-templates select="editor" mode="top"/>
        </ul>
        <p><xsl:apply-templates select="publicationStmt"/></p>
    </xsl:template>
    
    <xsl:template match="editor" mode="top">
        <li><xsl:apply-templates/></li>
    </xsl:template>
    
    <xsl:template match="teiHeader">
        <h1><xsl:apply-templates select="descendant::titleStmt"/></h1>
    </xsl:template>
    
    <xsl:template match="docTitle">
        <h2><xsl:apply-templates/></h2>
    </xsl:template>
    
    <xsl:template match="p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    <xsl:template match="name">
        <xsl:variable name="forename" select="$characterList//*[@xml:id = current()/@ref]//forename/@type"/>
        <xsl:variable name="surname" select="$characterList//*[@xml:id = current()/@ref]//surname/@type"/>
        <xsl:variable name="nickname" select="$characterList//*[@xml:id = current()/@ref]//addName[@type='nickname']"/>
        
        <xsl:variable name="tooltip">
        <xsl:choose>
            <xsl:when test="$characterList//*[@xml:id = current()/@ref]//addName[@type='nickname']">
                <xsl:value-of select="$forename || ' ' || $surname || ', nickname: ' ||  $nickname"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$forename || ' ' || $surname"/>
            </xsl:otherwise>
        </xsl:choose>
            
        </xsl:variable>
        
        <a href="characterList.html#{current()/@ref}" target="characterList"><span class="{name()}" 
            title="{$tooltip}">
            <!-- ebb: This outputs the name of the element <span class="name"> in this case. -->
        <xsl:apply-templates/>
        </span></a>
    </xsl:template>
    <xsl:template match="w">
        <span class="w"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="rs">
        <span class="rs"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="note">
        <span class="note"><xsl:apply-templates/></span>
    </xsl:template>
    
        <xsl:template match="said">
            <q>
                <xsl:apply-templates/>
            </q>
        </xsl:template>
   
       
    
</xsl:stylesheet>