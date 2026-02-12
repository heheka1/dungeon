<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/2000/svg"
    exclude-result-prefixes="xs math"
    version="3.0">
    <xsl:variable name="y-spacer" as="xs:integer" select="-5"/>
    
    <xsl:variable name="xml-tree" as="document-node()" select="doc('Chapter21-25TEST.xml')"/>
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="/">
    
    <svg viewBox="0 0 600 1000">
    
        <desc>SVG created from <xsl:apply-templates select="//title"/></desc>
    
    <g transform="translate(20 900)">
   
        <g class="Dialogue">
        <xsl:variable name="said" as="attribute()+" 
            select="descendant::said/@who"/>
        
   
    <xsl:variable name="sortedSaid" as="xs:string+" 
        select="$said => distinct-values() => sort()"/>
        
       
        
        
    <xsl:variable name="distinctSaid" as="xs:string+">
        <xsl:for-each select="$sortedSaid">
        <xsl:sort select="$xml-tree//said[@who=current()]//said => count()" 
       />
          <!--  order="descending"-->
        <xsl:value-of select="current()"/>
        </xsl:for-each>                   
    </xsl:variable>
   
        <xsl:variable name="countSaid" as="xs:integer" 
            select="descendant::said => count()"/>
        
        <xsl:variable name="colorIntensifier" select="245 div $sortedSaid => count()"/>
        <xsl:comment>Color intensifier factor: <xsl:value-of select="$colorIntensifier"/></xsl:comment>
        
        <xsl:comment>
                       Said: <xsl:value-of select="$said"/>
                      Sorted Said: <xsl:value-of select="$sortedSaid"/>
                       Counting All Saids: <xsl:value-of select="$countSaid"/>
                        Counting All Saids * y-spacer: <xsl:value-of select="$countSaid * $y-spacer"/>
                   </xsl:comment>
        
        <text x="0" y="-850" style="text-anchor: middle; font-size:1.5em;">Who Spoke the Most in Chapters 21-25
        of My Immortal?</text>
        
        <line id="allSaid" x1="0" x2="0" stroke-width="200" 
            y1="0" y2="{$countSaid*$y-spacer}" stroke="rgb(200,200,200)"/>
        
        <xsl:for-each select="$distinctSaid">
            <g class="Said">
                <xsl:variable name="saidType" select="current()"/>
                <xsl:variable name="saidPosition" select="position()"/>
                
           <xsl:comment>
            <xsl:value-of select="$saidType"/>: 
            Position <xsl:value-of select="$saidPosition"/>
            </xsl:comment>
                <xsl:variable name="currentSaid" as="element()+" 
                    select="$xml-tree//said[@who=$saidType]"/>
                <xsl:variable name="trueSaidcount" as="xs:integer"
                    select="$currentSaid//said => count()"/>
                <xsl:comment>
                     How many Saids here? <xsl:value-of select="$trueSaidcount"/>
                    </xsl:comment>
                <xsl:variable name="previousCounts" as="xs:integer+">
                    <xsl:choose>
                        <xsl:when test="$saidPosition gt 1">
                            <xsl:for-each select="$distinctSaid[position() lt $saidPosition]">
                                <xsl:value-of 
                                    select="$xml-tree//said[@who=current()]//said => count()"/>
                            </xsl:for-each>
                        </xsl:when> 
                        
                        <xsl:otherwise>
                            <xsl:value-of select="0"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <xsl:comment>
                All the previous counts: <xsl:value-of select="$previousCounts"/>
                </xsl:comment>
                
                <xsl:variable name="y-stacker" as="xs:integer" select="sum($previousCounts) * $y-spacer"/>
                <line x1="0" x2="0" y1="{$y-stacker}"
                    y2="{$y-stacker + $trueSaidcount * $y-spacer}" 
                    stroke-width="200" stroke="rgb({$colorIntensifier * position()},200,200)"/>
                <text x="200" y="{$y-stacker + ($trueSaidcount * $y-spacer div 2)}"
                    style="text-anchor: middle">
                    <xsl:value-of select="$saidType"/>: <xsl:value-of select="$trueSaidcount"/> Said
                </text>
            
            </g>
    </xsl:for-each>
    </g>
    </g>
    </svg>
    </xsl:template>
</xsl:stylesheet>