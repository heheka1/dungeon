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
    
    <g class="Reference String">
        <xsl:variable name="referenceString" as="attribute()+" 
            select="descendant::rs/@type"/>
        
   
    <xsl:variable name="sortedRs" as="xs:string+" 
        select="$referenceString => distinct-values()"/>
        
       
        
        
    <xsl:variable name="distinctRStag" as="xs:string+">
        <xsl:for-each select="$sortedRs">
        <xsl:sort select="$xml-tree//rs[@type=current()]//rs => count()" 
            order="descending"/>
        <xsl:value-of select="current()"/>
        </xsl:for-each>                   
    </xsl:variable>
   
        <xsl:variable name="countRS" as="xs:integer" 
            select="descendant::rs => count()"/>
        
        <xsl:variable name="colorIntensifier" select="255 div $sortedRs => count()"/>
        <xsl:comment>Color intensifier factor: <xsl:value-of select="$colorIntensifier"/></xsl:comment>
        
        <xsl:comment>
                       Reference String: <xsl:value-of select="$referenceString"/>
                      Sorted Reference String: <xsl:value-of select="$sortedRs"/>
                       Counting All Reference Strings: <xsl:value-of select="$countRS"/>
                        Counting All Reference Strings * y-spacer: <xsl:value-of select="$countRS * $y-spacer"/>
                   </xsl:comment>
        
        <text x="0" y="-850" style="text-anchor: middle; font-size:1.5em;">The Amount of Swearing and Fashion References in
            <xsl:value-of select="descendant::teiHeader//title"/>of My Immortal</text>
        
        <line id="allRS" x1="0" x2="0" stroke-width="200" 
            y1="0" y2="{$countRS*$y-spacer}" stroke="rgb(200,200,200)"/>
        
        <xsl:for-each select="$distinctRStag">
            <g class="reference">
                <xsl:variable name="RsType" select="current()"/>
                <xsl:variable name="RsPosition" select="position()"/>
                
           <xsl:comment>
            <xsl:value-of select="$RsType"/>: 
            Position <xsl:value-of select="$RsPosition"/>
            </xsl:comment>
                <xsl:variable name="currentRs" as="element()+" 
                    select="$xml-tree//rs[@type=$RsType]"/>
                <xsl:variable name="trueRScount" as="xs:integer"
                    select="$currentRs//rs => count()"/>
                <xsl:comment>
                     How many RS Types here? <xsl:value-of select="$trueRScount"/>
                    </xsl:comment>
                <xsl:variable name="previousCounts" as="xs:integer+">
                    <xsl:choose>
                        <xsl:when test="$RsPosition gt 1">
                            <xsl:for-each select="$distinctRStag[position() lt $RsPosition]">
                                <xsl:value-of 
                                    select="$xml-tree//rs[@type=current()]//rs => count()"/>
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
                    y2="{$y-stacker + $trueRScount * $y-spacer}" 
                    stroke-width="200" stroke="rgb({$colorIntensifier * position()},200,200)"/>
                <text x="200" y="{$y-stacker + ($trueRScount * $y-spacer div 2)}"
                    style="text-anchor: middle">
                    <xsl:value-of select="$RsType"/>: <xsl:value-of select="$trueRScount"/> References
                </text>
            
            </g>
    </xsl:for-each>
    </g>
    </g>
    </svg>
    </xsl:template>
</xsl:stylesheet>