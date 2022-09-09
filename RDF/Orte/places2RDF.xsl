<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:wiesinger="https://gams.uni-graz.at/o:wiesinger.ontology#"
    xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns:dcterms="http://purl.org/dc/terms/" 
    xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:schema="https://schema.org/"
    xmlns:foaf="http://xmlns.com/foaf/0.1/" xmlns:gams="https://gams.uni-graz.at/o:gams-ontology#"
    xmlns:void="http://rdfs.org/ns/void#" exclude-result-prefixes="xs" version="2.0">
    
    <!-- Dieses Stylsheet transformiert das TEI-Dokument "Ortsregister" aus der Digitalen Edition Karl Wiesingers nach RDF -->

    <xsl:output indent="yes"/>

    <xsl:variable name="pid">
        <xsl:value-of select="//t:idno[@type = 'PID']"/>
    </xsl:variable>

    <xsl:variable name="BASE_URL" select="'https://gams.uni-graz.at/'"/>

    <xsl:template match="/">
        <rdf:RDF>
            <xsl:if test="//t:publicationStmt/t:idno[@type = 'PID']">
                <void:Dataset
                    rdf:about="{concat($BASE_URL, //t:publicationStmt/t:idno[@type = 'PID'])}">
                    <xsl:if test="//t:fileDesc/t:titleStmt/t:title">
                        <dcterms:title>
                            <xsl:value-of select="//t:fileDesc/t:titleStmt/t:title"/>
                        </dcterms:title>
                    </xsl:if>
                    <dc:relation>https://gams.uni-graz.at/context:wiesinger</dc:relation>
                    <dc:creator>Karl Wiesinger</dc:creator>
                    <dc:contributor>Galka, Selina</dc:contributor>
                    <dc:description>Die digitale Edition der Tagebücher des Linzer Schriftstellers
                        Karl Wiesinger stellt ein zeit-, literatur- und lokalgeschichtlich
                        singuläres Zeugnis bereit: Wiesingers bislang unveröffentlichte
                        Aufzeichnungen aus den Jahren 1961 bis 1973 dokumentieren sein Werden als
                        literarischer und politischer Außenseiter im österreichischen Kulturbetrieb
                        und geben auch Auskunft über den vom Kalten Krieg geprägten Alltag und die
                        gesellschaftliche Atmosphäre im Linz der Nachkriegsära. Die digitale Edition
                        ist mit umfassenden Informationen zu Leben und Werk des Autors sowie
                        Kommentaren zu zentralen Aspekten der Tagebücher ausgestattet und ermöglicht
                        über das Personen-, Orts-, Institutionen- und Schlagwortregister
                        schwerpunktmäßige Recherchen bzw. transversale Lektüren.</dc:description>
                    <dc:language>de</dc:language>
                    <dc:publisher>Institut Zentrum für Informationsmodellierung, Universität Graz </dc:publisher>
                    <dc:rights>Creative Commons BY 4.0</dc:rights>
                    <dc:rights>https://creativecommons.org/licenses/by/4.0</dc:rights>
                    <void:feature rdf:resource="http://www.w3.org/ns/formats/RDF_XML"/>
                    <void:vocabulary rdf:resource="https://gams.uni-graz.at/o:wiesinger.ontology#"/>
                    <void:vocabulary rdf:resource="https://gams.uni-graz.at/o:gams-ontology#"/>
                </void:Dataset>
            </xsl:if>

            <xsl:apply-templates select="//t:place"/>

        </rdf:RDF>
    </xsl:template>

    <xsl:template match="//t:place">
        <xsl:for-each select=".">
            <schema:Place>
                <xsl:attribute name="rdf:about">
                    <xsl:value-of select="concat('https://gams.uni-graz.at/', $pid, '#', @xml:id)"/>
                </xsl:attribute>
                <schema:name>
                    <xsl:value-of select="t:placeName"/>
                </schema:name>

                <xsl:for-each select="t:idno">
                    <xsl:if test="contains(@source, 'geonames')">
                        <schema:identifier>
                            <xsl:attribute name="rdf:resource">
                                <xsl:value-of select="."/>
                            </xsl:attribute>
                        </schema:identifier>
                    </xsl:if>
                </xsl:for-each>
                <xsl:for-each select="t:note">
                    <wiesinger:note>
                        <xsl:value-of select="."/>
                    </wiesinger:note>
                </xsl:for-each>
                <gams:isPartOf rdf:resource="https://gams.uni-graz.at/o:wiesinger.places"/>
                <gams:isMemberOfCollection rdf:resource="https://gams.uni-graz.at/context:wiesinger"
                />
            </schema:Place>

        </xsl:for-each>
    </xsl:template>




</xsl:stylesheet>
