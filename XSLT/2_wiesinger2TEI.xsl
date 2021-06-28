<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs t" version="2.0">
    
  <!-- normalisiert Datum im when-iso-Attribut -->
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

    
    <xsl:template match="//t:body//t:date">
        <date>
        <xsl:attribute name="when-iso">
            <xsl:value-of select="concat(substring(@when-iso, 0,5), '-', substring(@when-iso, 9,10), '-', substring-before(substring-after(@when-iso, '-'), '-'))"></xsl:value-of>
        </xsl:attribute>
            <xsl:value-of select="."/>
        </date>
    </xsl:template>
    
</xsl:stylesheet>