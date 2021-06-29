<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs t" version="2.0">

    <xsl:output indent="yes"/>

    <!-- generiert teiHeader -->
    <xsl:template match="t:TEI">
        <TEI xmlns="http://www.tei-c.org/ns/1.0" xml:lang="de">
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <title type="main">Schlagwortregister</title>
                        <title type="sub">Karl Wiesinger: Digitale Edition der Tagebücher</title>
                        <author>
                            <forename>Helmut</forename>
                            <surname>Neundlinger</surname>
                        </author>
                    </titleStmt>
                    <publicationStmt>
                        <publisher>
                            <orgName corresp="https://stifterhaus.at" ref="http://d-nb.info/gnd/1066114358"
                                >Adalbert-Stifter-Institut des Landes Oberösterreich</orgName>
                        </publisher>
                        <authority>
                            <orgName corresp="https://informationsmodellierung.uni-graz.at"
                                ref="http://d-nb.info/gnd/1137284463"> Zentrum für Informationsmodellierung -
                                Austrian Centre for Digital Humanities, Karl-Franzens-Universität Graz </orgName>
                        </authority>
                        <distributor>
                            <orgName ref="https://gams.uni-graz.at"> GAMS - Geisteswissenschaftliches Asset
                                Management System </orgName>
                        </distributor>
                        <availability>
                            <licence target="https://creativecommons.org/licenses/by-nc/4.0">Creative Commons
                                BY-NC 4.0</licence>
                        </availability>
                        <date when="2020">2020</date>
                        <pubPlace>Graz</pubPlace>
                        <idno type="PID">o:wiesinger.terms</idno>
                    </publicationStmt>
                    <sourceDesc>
                        <p>Schlagwortregister, born digital</p>
                    </sourceDesc>
                </fileDesc>
                <encodingDesc>
                    <projectDesc>
                        <ab>
                            <ref target="info:fedora/context:wiesinger" type="context">Karl Wiesinger: Digitale
                                Edition der Tagebücher (1961-1973)</ref>
                        </ab>
                        <p>Die digitale Edition der Tagebücher des Linzer Schriftstellers Karl Wiesinger stellt
                            ein zeit-, literatur- und lokalgeschichtlich singuläres Zeugnis bereit: Wiesingers
                            bislang unveröffentlichte Aufzeichnungen aus den Jahren 1961 bis 1973 dokumentieren
                            sein Werden als literarischer und politischer Außenseiter im österreichischen
                            Kulturbetrieb und geben auch Auskunft über den vom Kalten Krieg geprägten Alltag und
                            die gesellschaftliche Atmosphäre im Linz der Nachkriegsära. Die digitale Edition ist
                            mit umfassenden Informationen zu Leben und Werk des Autors sowie Kommentaren zu
                            zentralen Aspekten der Tagebücher ausgestattet und ermöglicht über das Personen-,
                            Orts-, Institutionen- und Schlagwortregister schwerpunktmäßige Recherchen bzw.
                            transversale Lektüren.</p>
                    </projectDesc>
                </encodingDesc>
            </teiHeader>
            <text>
                <body>
                    <xsl:apply-templates select="//t:table"/>
                </body>
            </text>
        </TEI>
    </xsl:template>

    <xsl:variable name="tagebuch_1961" select="document('1961-tei-pb.xml')"/>
    <xsl:variable name="tagebuch_1962" select="document('1962-tei-pb.xml')"/>
    <xsl:variable name="tagebuch_1963" select="document('1963-tei-pb.xml')"/>
    <xsl:variable name="tagebuch_1964" select="document('1964-tei-pb.xml')"/>
    <xsl:variable name="tagebuch_1965" select="document('1965-tei-pb.xml')"/>
    
    
    <xsl:variable name="tagebuch_1966" select="document('1966-tei-pb.xml')"/>
    <xsl:variable name="tagebuch_1967" select="document('1967-tei-pb.xml')"/>
    <xsl:variable name="tagebuch_1968" select="document('1968-tei-pb.xml')"/>
    <xsl:variable name="tagebuch_1969" select="document('1969-tei-pb.xml')"/>
    <xsl:variable name="tagebuch_1970" select="document('1970-tei-pb.xml')"/>
    <xsl:variable name="tagebuch_1971" select="document('1971-tei-pb.xml')"/>
    <xsl:variable name="tagebuch_1972" select="document('1972-tei-pb.xml')"/>
    <xsl:variable name="tagebuch_1973" select="document('1973-tei-pb.xml')"/>


    <xsl:template match="t:table">
        <list type="gloss">
            <xsl:apply-templates/>
        </list>
    </xsl:template>

    <xsl:template match="t:head"> </xsl:template>

    <!-- matcht die jeweiligen Zellen aus dem Oxgarage-Output und bringt sie in ein valides TEI-Format -->

    <xsl:template match="t:row">
        <xsl:for-each select=".">
            <item>
                <xsl:attribute name="xml:id">
                    <xsl:value-of select="t:cell[1]"/>
                </xsl:attribute>
                <term>
                    
                    <xsl:value-of select="t:cell[2]"/>
                    
                </term>
                <xsl:if test="t:cell[3]/t:ptr">
                    <idno source="https://wikipedia.org" type="URI">
                        <xsl:value-of select="t:cell[3]/t:ptr/@target"/>
                    </idno>
                    
                </xsl:if>
                <xsl:if test="t:cell[5] != ''">
                    <note>
                        <xsl:value-of select="t:cell[5]"/>
                        <!-- Zusatzinfo -->
                    </note>
                    
                </xsl:if>
               
                <!-- erstellt Index -->
                <linkGrp>
                    <xsl:for-each select=".">
                        <xsl:call-template name="index">
                            <xsl:with-param name="ID" select="t:cell[1]"/>
                        </xsl:call-template>
                    </xsl:for-each>

                </linkGrp>
            </item>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="index">
        
        <!-- ID aus der Personenliste -->
        <xsl:param name="ID"/>
        
        <!-- wenn ID aus Personenliste ID im jeweiligen Tagebuch matcht -->
        <xsl:if test="$tagebuch_1961//t:term/substring-after(@ref, '#') = $ID">
            <xsl:for-each
                select="$tagebuch_1961//t:term[substring-after(@ref, '#') = $ID]/preceding::t:pb[1]/@xml:id">
                <ptr>
                    <xsl:attribute name="target">
                        <xsl:value-of select="concat('http://gams.uni-graz.at/o:wiesinger.1961#', .)"/>
                    </xsl:attribute>
                    <xsl:attribute name="ana">
                        <xsl:value-of select="parent::t:pb/@n"/>
                    </xsl:attribute>
                    <xsl:attribute name="type">
                        <xsl:text>page</xsl:text>
                    </xsl:attribute>
                </ptr>
            </xsl:for-each>
            
            <!-- zählt das Vorkommen generell -->
            <!-- <xsl:text> (</xsl:text>
                <xsl:for-each-group select="$tagebuch_1961//t:term[@corresp = $ID]"
                    group-by="@corresp">
                    <xsl:sort select="current-grouping-key()"/>
                    <xsl:value-of select="count(current-group())"/>
                </xsl:for-each-group>
                <xsl:text>)</xsl:text>-->
            
        </xsl:if>
        
        <xsl:if test="$tagebuch_1962//t:term/substring-after(@ref, '#') = $ID">
            <xsl:for-each
                select="$tagebuch_1962//t:term[substring-after(@ref, '#') = $ID]/preceding::t:pb[1]/@xml:id">
                <ptr>
                    <xsl:attribute name="target">
                        <xsl:value-of select="concat('http://gams.uni-graz.at/o:wiesinger.1962#', .)"/>
                    </xsl:attribute>
                    <xsl:attribute name="ana">
                        <xsl:value-of select="parent::t:pb/@n"/>
                    </xsl:attribute>
                    <xsl:attribute name="type">
                        <xsl:text>page</xsl:text>
                    </xsl:attribute>
                </ptr>
            </xsl:for-each>
        </xsl:if>
        
        <xsl:if test="$tagebuch_1963//t:term/substring-after(@ref, '#') = $ID">
            <xsl:for-each
                select="$tagebuch_1963//t:term[substring-after(@ref, '#') = $ID]/preceding::t:pb[1]/@xml:id">
                <ptr>
                    <xsl:attribute name="target">
                        <xsl:value-of select="concat('http://gams.uni-graz.at/o:wiesinger.1963#', .)"/>
                        
                    </xsl:attribute>
                    <xsl:attribute name="ana">
                        <xsl:value-of select="parent::t:pb/@n"/>
                    </xsl:attribute>
                    <xsl:attribute name="type">
                        <xsl:text>page</xsl:text>
                    </xsl:attribute>
                </ptr>
            </xsl:for-each>
        </xsl:if>
        
        <xsl:if test="$tagebuch_1964//t:term/substring-after(@ref, '#') = $ID">
            <xsl:for-each
                select="$tagebuch_1964//t:term[substring-after(@ref, '#') = $ID]/preceding::t:pb[1]/@xml:id">
                <ptr>
                    <xsl:attribute name="target">
                        <xsl:value-of select="concat('http://gams.uni-graz.at/o:wiesinger.1964#', .)"/>
                        
                    </xsl:attribute>
                    <xsl:attribute name="ana">
                        <xsl:value-of select="parent::t:pb/@n"/>
                    </xsl:attribute>
                    <xsl:attribute name="type">
                        <xsl:text>page</xsl:text>
                    </xsl:attribute>
                </ptr>
            </xsl:for-each>
        </xsl:if>
        
        <xsl:if test="$tagebuch_1965//t:term/substring-after(@ref, '#') = $ID">
            <xsl:for-each
                select="$tagebuch_1965//t:term[substring-after(@ref, '#') = $ID]/preceding::t:pb[1]/@xml:id">
                <ptr>
                    <xsl:attribute name="target">
                        <xsl:value-of select="concat('http://gams.uni-graz.at/o:wiesinger.1965#', .)"/>
                        
                    </xsl:attribute>
                    <xsl:attribute name="ana">
                        <xsl:value-of select="parent::t:pb/@n"/>
                    </xsl:attribute>
                    <xsl:attribute name="type">
                        <xsl:text>page</xsl:text>
                    </xsl:attribute>
                </ptr>
            </xsl:for-each>
        </xsl:if>
        
        <xsl:if test="$tagebuch_1966//t:term/substring-after(@ref, '#') = $ID">
            <xsl:for-each
                select="$tagebuch_1966//t:term[substring-after(@ref, '#') = $ID]/preceding::t:pb[1]/@xml:id">
                <ptr>
                    <xsl:attribute name="target">
                        <xsl:value-of select="concat('http://gams.uni-graz.at/o:wiesinger.1966#', .)"/>
                        
                    </xsl:attribute>
                    <xsl:attribute name="ana">
                        <xsl:value-of select="parent::t:pb/@n"/>
                    </xsl:attribute>
                    <xsl:attribute name="type">
                        <xsl:text>page</xsl:text>
                    </xsl:attribute>
                </ptr>
            </xsl:for-each>
        </xsl:if>
        
        <xsl:if test="$tagebuch_1967//t:term/substring-after(@ref, '#') = $ID">
            <xsl:for-each
                select="$tagebuch_1967//t:term[substring-after(@ref, '#') = $ID]/preceding::t:pb[1]/@xml:id">
                <ptr>
                    <xsl:attribute name="target">
                        <xsl:value-of select="concat('http://gams.uni-graz.at/o:wiesinger.1967#', .)"/>
                        
                    </xsl:attribute>
                    <xsl:attribute name="ana">
                        <xsl:value-of select="parent::t:pb/@n"/>
                    </xsl:attribute>
                    <xsl:attribute name="type">
                        <xsl:text>page</xsl:text>
                    </xsl:attribute>
                </ptr>
            </xsl:for-each>
        </xsl:if>
        
        <xsl:if test="$tagebuch_1968//t:term/substring-after(@ref, '#') = $ID">
            <xsl:for-each
                select="$tagebuch_1968//t:term[substring-after(@ref, '#') = $ID]/preceding::t:pb[1]/@xml:id">
                <ptr>
                    <xsl:attribute name="target">
                        <xsl:value-of select="concat('http://gams.uni-graz.at/o:wiesinger.1968#', .)"/>
                        
                    </xsl:attribute>
                    <xsl:attribute name="ana">
                        <xsl:value-of select="parent::t:pb/@n"/>
                    </xsl:attribute>
                    <xsl:attribute name="type">
                        <xsl:text>page</xsl:text>
                    </xsl:attribute>
                </ptr>
            </xsl:for-each>
        </xsl:if>
        
        <xsl:if test="$tagebuch_1969//t:term/substring-after(@ref, '#') = $ID">
            <xsl:for-each
                select="$tagebuch_1969//t:term[substring-after(@ref, '#') = $ID]/preceding::t:pb[1]/@xml:id">
                <ptr>
                    <xsl:attribute name="target">
                        <xsl:value-of select="concat('http://gams.uni-graz.at/o:wiesinger.1969#', .)"/>
                        
                    </xsl:attribute>
                    <xsl:attribute name="ana">
                        <xsl:value-of select="parent::t:pb/@n"/>
                    </xsl:attribute>
                    <xsl:attribute name="type">
                        <xsl:text>page</xsl:text>
                    </xsl:attribute>
                </ptr>
            </xsl:for-each>
        </xsl:if>
        
        <xsl:if test="$tagebuch_1970//t:term/substring-after(@ref, '#') = $ID">
            <xsl:for-each
                select="$tagebuch_1970//t:term[substring-after(@ref, '#') = $ID]/preceding::t:pb[1]/@xml:id">
                <ptr>
                    <xsl:attribute name="target">
                        <xsl:value-of select="concat('http://gams.uni-graz.at/o:wiesinger.1970#', .)"/>
                        
                    </xsl:attribute>
                    <xsl:attribute name="ana">
                        <xsl:value-of select="parent::t:pb/@n"/>
                    </xsl:attribute>
                    <xsl:attribute name="type">
                        <xsl:text>page</xsl:text>
                    </xsl:attribute>
                </ptr>
            </xsl:for-each>
        </xsl:if>
        
        <xsl:if test="$tagebuch_1971//t:term/substring-after(@ref, '#') = $ID">
            <xsl:for-each
                select="$tagebuch_1971//t:term[substring-after(@ref, '#') = $ID]/preceding::t:pb[1]/@xml:id">
                <ptr>
                    <xsl:attribute name="target">
                        <xsl:value-of select="concat('http://gams.uni-graz.at/o:wiesinger.1971#', .)"/>
                        
                    </xsl:attribute>
                    <xsl:attribute name="ana">
                        <xsl:value-of select="parent::t:pb/@n"/>
                    </xsl:attribute>
                    <xsl:attribute name="type">
                        <xsl:text>page</xsl:text>
                    </xsl:attribute>
                </ptr>
            </xsl:for-each>
        </xsl:if>
        
        <xsl:if test="$tagebuch_1972//t:term/substring-after(@ref, '#') = $ID">
            <xsl:for-each
                select="$tagebuch_1972//t:term[substring-after(@ref, '#') = $ID]/preceding::t:pb[1]/@xml:id">
                <ptr>
                    <xsl:attribute name="target">
                        <xsl:value-of select="concat('http://gams.uni-graz.at/o:wiesinger.1972#', .)"/>
                        
                    </xsl:attribute>
                    <xsl:attribute name="ana">
                        <xsl:value-of select="parent::t:pb/@n"/>
                    </xsl:attribute>
                    <xsl:attribute name="type">
                        <xsl:text>page</xsl:text>
                    </xsl:attribute>
                </ptr>
            </xsl:for-each>
        </xsl:if>
        
        <xsl:if test="$tagebuch_1973//t:term/substring-after(@ref, '#') = $ID">
            <xsl:for-each
                select="$tagebuch_1973//t:term[substring-after(@ref, '#') = $ID]/preceding::t:pb[1]/@xml:id">
                <ptr>
                    <xsl:attribute name="target">
                        <xsl:value-of select="concat('http://gams.uni-graz.at/o:wiesinger.1973#', .)"/>
                        
                    </xsl:attribute>
                    <xsl:attribute name="ana">
                        <xsl:value-of select="parent::t:pb/@n"/>
                    </xsl:attribute>
                    <xsl:attribute name="type">
                        <xsl:text>page</xsl:text>
                    </xsl:attribute>
                </ptr>
            </xsl:for-each>
        </xsl:if>
        
    </xsl:template>
</xsl:stylesheet>
