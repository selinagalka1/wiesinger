<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs t" version="2.0">

    <xsl:output indent="yes"/>

    <!-- Anonymisierungsliste.xlsx muss mit oxgarage nach TEI/XML transformiert werden, 
        der Output dann mit anonym.xsl in eine besser verarbeitbare Liste (anonym.xml). Die wird hier eingelesen.-->

    <xsl:variable name="anonymization" select="document('anonym.xml')//t:list"/>
    
    <xsl:strip-space elements="t:hi"/>

    <!-- Template, das den teiHeader generiert. PID und Titel müssen bei Transformation angepasst werden -->

    <xsl:template match="/">
        <TEI xmlns="http://www.tei-c.org/ns/1.0">
            <teiHeader xml:lang="de">
                <fileDesc>
                    <titleStmt>
                        <title type="main">Tagebuch von 1973</title>
                        <author ref="http://d-nb.info/gnd/119308649">
                            <forename>Karl</forename>
                            <surname>Wiesinger</surname>
                        </author>
                    </titleStmt>
                    <publicationStmt>
                        <publisher>
                            <orgName corresp="https://stifterhaus.at"
                                ref="http://d-nb.info/gnd/1066114358">Adalbert-Stifter-Institut des
                                Landes Oberösterreich</orgName>
                        </publisher>
                        <authority>
                            <orgName corresp="https://informationsmodellierung.uni-graz.at"
                                ref="http://d-nb.info/gnd/1137284463">Zentrum für
                                Informationsmodellierung - Austrian Centre for Digital Humanities,
                                Karl-Franzens-Universität Graz</orgName>
                        </authority>
                        <distributor>
                            <orgName ref="https://gams.uni-graz.at">GAMS - Geisteswissenschaftliches
                                Asset Management System</orgName>
                        </distributor>
                        <availability>
                            <licence target="https://creativecommons.org/licenses/by-nc/4.0"
                                >Creative Commons BY-NC 4.0</licence>
                        </availability>
                        <date when="2020">2020</date>
                        <pubPlace>Graz</pubPlace>
                        <idno type="PID">o:wiesinger.1973</idno>
                    </publicationStmt>
                    <seriesStmt>
                        <title ref="gams.uni-graz.at/wiesinger">Digitale Edition der Tagebücher Karl
                            Wiesingers</title>
                        <respStmt>
                            <resp>Projektleitung</resp>
                            <persName>
                                <forename>Helmut</forename>
                                <surname>Neundlinger</surname>
                            </persName>
                        </respStmt>
                        <respStmt xml:id="editor">
                            <resp>Editor, Annotationen</resp>
                            <persName>
                                <forename>Helmut</forename>
                                <surname>Neundlinger</surname>
                            </persName>
                        </respStmt>
                        <respStmt>
                            <resp>Datenmodellierung</resp>
                            <persName>
                                <forename>Selina</forename>
                                <surname>Galka</surname>
                            </persName>
                        </respStmt>
                    </seriesStmt>
                    <sourceDesc>
                        <msDesc>
                            <msIdentifier>
                                <country>Österreich</country>
                                <region>Oberösterreich</region>
                                <settlement>Linz</settlement>
                                <institution>Adalbert-Stifter-Haus Linz</institution>
                            </msIdentifier>
                            <msContents>
                                <textLang mainLang="de"/>
                            </msContents>
                            <history>
                                <origin>
                                    <origPlace>TODO</origPlace>
                                    <origDate when="1973">1973</origDate>
                                </origin>
                                <provenance>Karl Wiesingers Nachlass wurde nach seinem Tod von
                                    seiner Nichte an das Adalbert-Stifter-Institut übergeben.
                                </provenance>
                            </history>
                        </msDesc>
                    </sourceDesc>
                </fileDesc>
                <encodingDesc>
                    <editorialDecl>
                        <correction>
                            <p>Die Orthographie des Originals ist weitgehend erhalten,
                                offensichtliche Tippfehler wurden korrigiert.</p>
                            <p>Aus personenschutzrechtlichen Gründen wurden Anonymisierungen bzw.
                                Streichungen vorgenommen. Dies betrifft Passagen, in denen intime
                                Handlungen dargestellt werden, explizite Beleidigungen,
                                Beschimpfungen sowie von Wiesinger wiedergegebene Aussagen von
                                Dritten, deren tatsächlicher Inhalt nicht mehr überprüft werden
                                kann. </p>
                        </correction>
                        <normalization>
                            <p>Datumsangaben wurden vom Editor normalisiert.</p>
                        </normalization>
                    </editorialDecl>
                    <projectDesc>
                        <ab>
                            <ref target="info:fedora/context:wiesinger" type="context">Tagebücher von Karl Wiesinger</ref>
                        </ab>
                        <p>Die digitale Edition der Tagebücher des Linzer Schriftstellers
                            Karl Wiesinger stellt ein zeit-, literatur- und
                            lokalgeschichtlich singuläres Zeugnis bereit: Wiesingers
                            bislang unveröffentlichte Aufzeichnungen aus den Jahren 1961
                            bis 1973 dokumentieren sein Werden als literarischer und
                            politischer Außenseiter im österreichischen Kulturbetrieb
                            und geben auch Auskunft über den vom Kalten Krieg geprägten
                            Alltag und die gesellschaftliche Atmosphäre im Linz der
                            Nachkriegsära. Die digitale Edition ist mit umfassenden
                            Informationen zu Leben und Werk des Autors sowie Kommentaren
                            zu zentralen Aspekten der Tagebücher ausgestattet und
                            ermöglicht über das Personen-, Orts-, Institutionen- und
                            Schlagwortregister schwerpunktmäßige Recherchen bzw.
                            transversale Lektüren.</p>
                    </projectDesc>
                </encodingDesc>
            </teiHeader>
            <text xml:lang="de">
                <body>
                    <xsl:apply-templates/>
                </body>
            </text>
        </TEI>
    </xsl:template>

    <!-- Template, das den Oxgarage-teiHeader eliminiert -->

    <xsl:template match="t:teiHeader"/>


    <!-- wenn ein p-Element das Attribut "Thema" enthält, wird daraus ein Segement generiert. Die Themen-ID kommt in ein corresp-Attribut. 
        Die #T müssen nach der Transformation mit einem Regulären Ausdruck aus dem Fließtext eliminiert werden. 
        Falls der Text im Element p "###" enthält, handelt es sich um eine editorische Auslassung, die in <gap> ausgegeben wird-->

    <xsl:template match="t:p">
        <xsl:choose>
            <xsl:when test="contains(@rend, 'Thema')">
                <p>
                    <seg type="topic">
                        <xsl:attribute name="corresp">
                            <xsl:value-of select="concat('#T', substring-after(., '#T'))"/>
                        </xsl:attribute>
                        <xsl:apply-templates/>
                    </seg>
                </p>
            </xsl:when>
            <!--  <xsl:when test="contains(., '###')">
                <gap reason="anonymization">
                    <desc>[...]</desc>
                </gap>
            </xsl:when>-->
            <xsl:otherwise>
                <p>
                    <xsl:apply-templates/>
                </p>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <xsl:template match="t:seg">
        <xsl:choose>
            <xsl:when test="contains(@rend, 'italic')">
                <hi>
                    <xsl:attribute name="rend">
                        <xsl:text>italic</xsl:text>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </hi>
            </xsl:when>

            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>

        </xsl:choose>
    </xsl:template>

    <!-- matcht alle unterschiedlichen Auszeichnungen im rend-Attribut von hi (wenn es "Person" enthält, kommt der Text in ein persName-Element etc.). 
        Der Text nach "#" wird als ID in das Attribut corresp eingefügt. 
        Die unterschiedlich ausgeführten Datumsangaben werden mit Regexausdrücken normalisiert und in ein @when-iso übernommen. 
        Hier muss allerdings noch Tag mit Monat ausgetauschert werden (das fertige Dokument soll nochmals transformiert werden, mit substring()).
        ACHTUNG: HIER MUSS BEI DER TRANSFORMATION DAS JEWEILIGE JAHR DES TAGEBUCHS EINGEFÜGT WERDEN! -->

    <xsl:template match="t:hi">
        <xsl:if test="contains(@rend, 'Person')">
            <persName>
                <xsl:call-template name="text_and_id"/>
            </persName>
        </xsl:if>
        <xsl:if test="contains(@rend, 'Ort')">
            <placeName>
                <xsl:call-template name="text_and_id"/>
            </placeName>
        </xsl:if>
        <xsl:if test="contains(@rend, 'Schlagwort')">
            <xsl:choose>
                <xsl:when test="child::t:seg[@rend = 'italic']">
                    <hi rend="italic">
                        <term>
                            <xsl:call-template name="text_and_id"/>
                        </term>
                    </hi>
                </xsl:when>
                <xsl:otherwise>
                    <term>
                        <xsl:call-template name="text_and_id"/>
                    </term>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>

        <xsl:if test="contains(@rend, 'Institution')">
            <orgName>
                <xsl:call-template name="text_and_id"/>
            </orgName>
        </xsl:if>

        <!-- es kommen komische ELemente mit, die müssen abgefangen werden -->
        <xsl:if test="contains(@rend, 'Fließtext')">
            <xsl:value-of select="."/>
        </xsl:if>

        <xsl:if test="contains(@rend, 'Datumsangabe')">
            <date>
                <xsl:attribute name="when-iso">

                    <xsl:copy>
                        <xsl:analyze-string select="normalize-space(.)" regex="^\d\d.\d\d$"
                            flags="x">
                            <xsl:matching-substring>
                                <xsl:value-of
                                    select="concat('1973-', substring-before(., '.'), '-', substring-before(substring-after(., '.'), '.'))"
                                />
                            </xsl:matching-substring>
                        </xsl:analyze-string>
                        <xsl:analyze-string select="normalize-space(.)" regex="^\d.\d$" flags="x">
                            <xsl:matching-substring>
                                <xsl:value-of
                                    select="concat('1973-', '0', substring-before(., '.'), '-', '0', substring-before(substring-after(., '.'), '.'))"
                                />
                            </xsl:matching-substring>
                        </xsl:analyze-string>
                        <xsl:analyze-string select="normalize-space(.)" regex="^\d\d.\d.$" flags="x">
                            <xsl:matching-substring>
                                <xsl:value-of
                                    select="concat('1973-', substring-before(., '.'), '-', '0', substring-before(substring-after(., '.'), '.'))"
                                />
                            </xsl:matching-substring>
                        </xsl:analyze-string>
                        <xsl:analyze-string select="normalize-space(.)" regex="^\d.\d.$" flags="x">
                            <xsl:matching-substring>
                                <xsl:value-of
                                    select="concat('1973-', '0', substring-before(., '.'), '-', '0', substring-before(substring-after(., '.'), '.'))"
                                />
                            </xsl:matching-substring>
                        </xsl:analyze-string>
                        <xsl:analyze-string select="normalize-space(.)" regex="^\d.\d\d$" flags="x">
                            <xsl:matching-substring>
                                <xsl:value-of
                                    select="concat('1973-', '0', substring-before(., '.'), '-', '0', substring-before(substring-after(., '.'), '.'))"
                                />
                            </xsl:matching-substring>
                        </xsl:analyze-string>
                        <xsl:analyze-string select="normalize-space(.)" regex="^\d.\d\d.$" flags="x">
                            <xsl:matching-substring>
                                <xsl:value-of
                                    select="concat('1973-', '0', substring-before(., '.'), '-', substring-before(substring-after(., '.'), '.'))"
                                />
                            </xsl:matching-substring>
                        </xsl:analyze-string>
                        <xsl:analyze-string select="normalize-space(.)" regex="^\d\d.\d\d.$"
                            flags="x">
                            <xsl:matching-substring>
                                <xsl:value-of
                                    select="concat('1973-', substring-before(., '.'), '-', substring-before(substring-after(., '.'), '.'))"
                                />
                            </xsl:matching-substring>
                        </xsl:analyze-string>
                    </xsl:copy>
                </xsl:attribute>
                <xsl:apply-templates/>
            </date>
        </xsl:if>
        <xsl:if test="contains(@rend, 'Schwärzung/Anonymisierung')">
            <persName type="anonymization">
                <xsl:for-each select=".">
                    <xsl:call-template name="anonymization">
                        <xsl:with-param name="ID" select="substring-after(., '#')"/>
                    </xsl:call-template>
                </xsl:for-each>

            </persName>
        </xsl:if>
        <xsl:if test="contains(@rend, 'Thema')">
            <seg type="topic">
                <xsl:attribute name="corresp">
                    <xsl:value-of select="concat('#T', substring-after(., '#T'))"/>
                </xsl:attribute>
                <xsl:apply-templates/>
            </seg>
        </xsl:if>
        <xsl:if test="contains(@rend, 'italic')">
            <hi>
                <xsl:attribute name="rend">
                    <xsl:text>italic</xsl:text>
                </xsl:attribute>
                <xsl:apply-templates/>
            </hi>
        </xsl:if>
    </xsl:template>

    <xsl:template match="//t:hi[@style]">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="//t:lb">
        <lb> </lb>
        <xsl:apply-templates/>
    </xsl:template>

    <!-- Seitenangaben kommen in ein pb-Element mit einer eindeutigen xml:id-->
    <xsl:template match="//t:span">
        <pb>
            <xsl:attribute name="n">
                <xsl:value-of select="."/>
            </xsl:attribute>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="'T1973'"/>
                <xsl:text>.</xsl:text>
                <xsl:number format="1" level="any"/>
            </xsl:attribute>
        </pb>
    </xsl:template>

    <xsl:template match="//t:gap">
        <gap reason="deleted" resp="#editor">
            <desc>[...]</desc>
        </gap>
    </xsl:template>


    <!-- das Template nimmt die Zahl der nach der Raute, die Idee, und schmeißt es in ein @ref. 
        Der Text vor der Raute ist der Personenname, Ortsname etc. und wird als Text im jeweiligen Tag ausgegeben (vgl. oben). -->

    <xsl:template name="text_and_id">
        <xsl:attribute name="ref">
            <xsl:choose>
                <xsl:when test="contains(., 'I')">
                    <xsl:value-of
                        select="concat('https://gams.uni-graz.at/o:wiesinger.institutions#', substring-after(., '#'))"
                    />
                </xsl:when>
                <xsl:when test="contains(., 'P')">
                    <xsl:value-of
                        select="concat('https://gams.uni-graz.at/o:wiesinger.persons#', substring-after(., '#'))"
                    />
                </xsl:when>
                <xsl:when test="contains(., 'S')">
                    <xsl:value-of
                        select="concat('https://gams.uni-graz.at/o:wiesinger.terms#', substring-after(., '#'))"
                    />
                </xsl:when>
                <xsl:when test="contains(., 'G')">
                    <xsl:value-of
                        select="concat('https://gams.uni-graz.at/o:wiesinger.places#', substring-after(., '#'))"
                    />
                </xsl:when>
            </xsl:choose>
        </xsl:attribute>
        <xsl:value-of select="substring-before(., '#')"/>
    </xsl:template>


    <xsl:template name="anonymization">

        <xsl:param name="ID"/>

        <xsl:if test="$anonymization//t:item/@xml:id = $ID">
            <xsl:value-of select="$anonymization//t:item[@xml:id = $ID]/t:anonym"/>

        </xsl:if>

    </xsl:template>


</xsl:stylesheet>
