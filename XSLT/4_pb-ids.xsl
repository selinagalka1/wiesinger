<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs t" version="2.0">
    
    <!-- versieht Tagebuchseiten mit xml:ids -->
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="//t:pb">
        <xsl:for-each select=".">
            <pb>
                <xsl:attribute name="n">
                    <xsl:value-of select="@n"/>
                </xsl:attribute>
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="'T1973'"/>
                    <xsl:text>.</xsl:text>
                    <xsl:number format="1" level="any"/>
                </xsl:attribute>
            </pb>
        </xsl:for-each>
        
    </xsl:template>
    

    
</xsl:stylesheet>
