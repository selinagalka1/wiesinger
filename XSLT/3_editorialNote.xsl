<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs t" version="2.0">
    
    
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="//t:seg">
        <ref type="editorialNote">
            <xsl:attribute name="target">
                <xsl:value-of select="concat('http://gams.uni-graz.at/context:wiesinger?mode=kommentar', @corresp)"/>
            </xsl:attribute>
            <xsl:apply-templates></xsl:apply-templates>
        </ref>
    </xsl:template>
    
</xsl:stylesheet>