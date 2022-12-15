<?xml version="1.0" encoding="UTF-8"?>
<!--
    Progetto esame-corso Codifica di testi 22-23
    Studente: Alessandro Belli,Lorenzo Cecio
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" version="1.0">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    <xsl:variable name="space"><![CDATA[&#32;]]></xsl:variable>
	<!--Costruzione pagina html, con menù di navigazione, main e footer-->
    <xsl:template match="/">
        <xsl:comment>
            Progetto esame Codifica di Testi
            Filename: cartoline.html
        </xsl:comment>
        <html>
            <head>
                <title>
                    <xsl:value-of select="//tei:titleStmt/tei:title"/>
                </title>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
                <script src="script.js"></script>
                <link rel="stylesheet" href="style.css"/>
            </head>
            <body>
                <header>
                    <a id="intro_link" href="#intro">Introduzione</a>
                 <!-- TODO JS BOTTONI PER ATTIVARE LA VISTA DELLE CARTOLINE -->
                    <a class="view" id="134">Cartolina 134</a>
                    <a class="view" id="155">Cartolina 155</a>
                    <a class="view" id="198">Cartolina 198</a>
                    <a id="about_link" href="#about">About</a>
                </header>
                <div id="intro"></div>
              	<main>
                    <div>
                        <h1>
                            <xsl:value-of select="//tei:titleStmt/tei:title"/>
                        </h1>
                        <p>
                            <strong>Provenienza cartoline:</strong>
                            <xsl:value-of select="/tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:bibl"/>
                            conservate al <xsl:value-of select="/tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:repository"/>,
                            <xsl:value-of select="/tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:settlement"/>,
                            <xsl:value-of select="/tei:teiCorpus/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:msIdentifier/tei:country"/>
                        </p>
                        <p id="legenda">
                            <strong id="simboli">Legenda dei simboli:</strong>
                            <br/>
                            - <strong>(-'parola'-)</strong> indica l'attributo 'reason' del tag 'gap', codificate secondo indicazioni TEI.
                            <br/>
                            - <strong>('parola'.)</strong> indica una parola abbreviata.
                            <br/>
                            - <strong>(!'parola'!)</strong> indica una parola non corretta in qualche modo.
                            <br/>
                            - <strong>(Alias: 'nome')</strong> indica l'alias di un nome.
                            <br/>
                            - <strong>['parola']</strong> indica una parola corretta o la forma estesa.
                            <br/>
                            - <strong>('<u>Lettere</u>')</strong> le lettere così formattate rappresentano una "decorazione" del testo.
                        </p>
                	</div>
                  <div class="c_holder visible" id="c134">
                        <xsl:apply-templates select="/tei:teiCorpus/tei:TEI[1]"/>
                  </div>
                  <div class="c_holder" id="c155">
                        <xsl:apply-templates select="/tei:teiCorpus/tei:TEI[2]"/>
                  </div>
                  <div class="c_holder" id="c198">
                        <xsl:apply-templates select="/tei:teiCorpus/tei:TEI[3]"/>
                  </div>
              	</main>
                <footer>
                	<div class="footer_text">
                        <p id="about">
                            <xsl:value-of select="//tei:editionStmt/tei:edition"/>
                            <xsl:apply-templates select="/tei:teiCorpus/tei:teiHeader/tei:fileDesc"/>
                        </p>
                    </div>
                </footer>
            </body>
        </html>
    </xsl:template>
  
	<!-- CARTOLINA -->
    <!-- Template per le cartoline OK-->
    <xsl:template match="/tei:teiCorpus/tei:TEI">
        <xsl:apply-templates select="tei:teiHeader"/>
        <div class="radio_holder">
            <input type="radio" class="radio_fronte">
                <xsl:attribute name="type">radio</xsl:attribute>
                <xsl:attribute name="id">
                    f_<xsl:value-of select="tei:facsimile/@xml:id"></xsl:value-of>
                </xsl:attribute>
                <xsl:attribute name="name"><xsl:value-of select="tei:facsimile/@xml:id"></xsl:value-of></xsl:attribute>
                <xsl:attribute name="checked">checked</xsl:attribute>
            </input>
            <xsl:element name="label">
                <xsl:attribute name="for">
                    f_<xsl:value-of select="tei:facsimile/@xml:id"></xsl:value-of>
                </xsl:attribute>
                Fronte
            </xsl:element>
            <input type="radio" class="radio_retro">
                <xsl:attribute name="type">radio</xsl:attribute>
                <xsl:attribute name="id">
                    r_<xsl:value-of select="tei:facsimile/@xml:id"></xsl:value-of>
                </xsl:attribute>
                <xsl:attribute name="name"><xsl:value-of select="tei:facsimile/@xml:id"></xsl:value-of></xsl:attribute>
            </input>
            <xsl:element name="label">
                <xsl:attribute name="for">
                    r_<xsl:value-of select="tei:facsimile/@xml:id"></xsl:value-of>
                </xsl:attribute>
                Retro
            </xsl:element>
        </div>
        <div class="f_r_holder">
            <xsl:attribute name="id">f_r_holder_<xsl:value-of select="tei:facsimile/@xml:id"/>
            </xsl:attribute>
            <xsl:apply-templates select="tei:text"/>
            <xsl:apply-templates select="tei:facsimile"/>
        </div>
    </xsl:template>

    <!-- Template Header cartolina OK -->
    <xsl:template match="tei:teiHeader">
        <div class="header_c">
            <h3>
                Titolo: <xsl:value-of select="tei:fileDesc/tei:sourceDesc/tei:bibl/tei:title"/>
            </h3>
            <xsl:choose> 
                    <xsl:when test="count(tei:fileDesc/tei:sourceDesc/tei:bibl/tei:publisher)>0">
                        <p><strong>Pubblicato da: </strong> <xsl:value-of select="tei:fileDesc/tei:sourceDesc/tei:bibl/tei:publisher"/> </p>
                </xsl:when>
                <xsl:otherwise>
                       <p>Non si conosce il publisher.</p> 
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose> 
                <xsl:when test="count(tei:fileDesc/tei:sourceDesc/tei:bibl/tei:pubPlace)>0">
                    <p><strong>Luogo di pubblicazione: </strong> <xsl:value-of select="tei:fileDesc/tei:sourceDesc/tei:bibl/tei:pubPlace"/> </p>
                </xsl:when>
                <xsl:otherwise>
                    <p> Non si conosce il luogo di pubblicazione. </p>
                </xsl:otherwise>
            </xsl:choose>
        </div>
    </xsl:template>

    <!-- Template facsimile cartolina OK-->
    <xsl:template match="tei:facsimile">
        <div class="img_c">
            <xsl:attribute name="id">img_<xsl:value-of select="@xml:id"/>
            </xsl:attribute>
            <xsl:apply-templates select="tei:surface"/>
        </div>
    </xsl:template>

    <!-- Template connesso al facsimile, serve ad estrarre le immagini e dati associati ad esse OK -->
    <xsl:template match="tei:surface">
        <xsl:element name="img">
            <xsl:attribute name="src">
                <xsl:value-of select="tei:graphic/@url"/>
            </xsl:attribute>
            <xsl:attribute name="alt">
                <xsl:value-of select="tei:graphic/@url"/>
            </xsl:attribute>
            <xsl:if test="position() = 1">
                <xsl:attribute name="class">visible</xsl:attribute>
            </xsl:if>
            <xsl:attribute name="id">
                <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
        </xsl:element>
    </xsl:template>

    <!-- Template text cartolina OK-->
    <xsl:template match="tei:text">
        <div class="text_c">
            <!-- Cartolina testo fronte -->
            <xsl:variable name="temp_id_info_fronte" select="tei:body/tei:div[1]/@facs"/>
            <xsl:variable name="final_id_info_fronte" select="substring-after($temp_id_info_fronte, '#')"/>
            <div class="text_fronte visible">
                <xsl:attribute name="id">
                    t_<xsl:value-of select="$final_id_info_fronte"/>
                </xsl:attribute>
                <div class="desc_fronte">
                    <h3>Fronte</h3>
                    <p>
                        <h5>Descrizione:</h5>
                        <xsl:value-of select="tei:body/tei:div[1]/tei:figure/tei:figDesc"/>
                    </p>
                    <br/>
                    <xsl:if test="count(tei:body/tei:div[1]/tei:figure/tei:head/tei:persName)>0">
                        <xsl:variable name="id_temp" select="tei:body/tei:div[1]/tei:figure/tei:head/tei:persName/@facs"/>
                        <xsl:variable name="id_firma" select="substring-after($id_temp, '#')"/>
                        <div class="stamp">
                          <xsl:attribute name="id">
                            <xsl:value-of select="$id_firma"/>
                          </xsl:attribute>
                            <p>
                              <h5>Opera:</h5>
                              <xsl:value-of select="tei:body/tei:div[1]/tei:figure/tei:head"/>
                            </p>
                        </div>
                    </xsl:if>
                    <xsl:if test="(count(tei:body/tei:div[1]/tei:figure/tei:note)>0) or (count(tei:body/tei:div[1]/tei:figure/tei:fw)>0)">
                        <div class="f_desc_note">
                            <xsl:apply-templates select="tei:body/tei:div[1]/tei:figure/tei:note"/>
                            <xsl:apply-templates select="tei:body/tei:div[1]/tei:figure/tei:fw"/>
                        </div>
                    </xsl:if>
                </div>
            </div>
            <!-- Cartolina testo retro -->
            <xsl:variable name="temp_id_info_retro" select="tei:body/tei:div[2]/@facs"/>
            <xsl:variable name="final_id_info_retro" select="substring-after($temp_id_info_retro, '#')"/>
            <div class="text_retro">
                <xsl:attribute name="id">
                    t_<xsl:value-of select="$final_id_info_retro"/>
                </xsl:attribute>
                <div class="desc_retro">
                    <h3>Retro</h3>
                    <xsl:apply-templates select="tei:body/tei:div[@type='retro']/tei:fw[1]"/>
                    <xsl:apply-templates select="tei:body/tei:div[@type='retro']/tei:div"/>
                </div>
            </div>
        </div>
    </xsl:template>

    <!-- Template per le note del fronte OK -->
    <xsl:template match="tei:body/tei:div[1]/tei:figure/tei:note">
        <xsl:variable name="temp_id" select="current()/@facs"/>
        <xsl:variable name="final_id" select="substring-after($temp_id, '#')"/>
        <div class="stamp">
            <xsl:attribute name="id">
                <xsl:value-of select="$final_id"/>
            </xsl:attribute>
            <p>
                <h5>Note:</h5>
                <xsl:value-of select="text()"/>
                <xsl:if test="$temp_id = '#f155_firma'">
                    Firma non leggibile
                </xsl:if>
            </p>
            <br/>
        </div>
    </xsl:template>

    <!-- Template per fw del fronte OK-->
    <xsl:template match="tei:body/tei:div[1]/tei:figure/tei:fw">
        <xsl:variable name="temp_id" select="current()/@facs"/>
        <xsl:variable name="final_id" select="substring-after($temp_id, '#')"/>
        <div class="stamp">
            <xsl:attribute name="id">
                <xsl:value-of select="$final_id"/>
            </xsl:attribute>
            <xsl:variable name="temp_id_fw_fronte" select="@facs"/>
            <xsl:variable name="final_id_fw_fronte" select="substring-after($temp_id_fw_fronte, '#')"/>
            <xsl:attribute name="id">
                <xsl:value-of select="$final_id_fw_fronte"/>
            </xsl:attribute>
            <p>
                <xsl:if test="@type='logo_cartolina'">
                    <h5>Logo:</h5>
                </xsl:if>
                <xsl:value-of select="text()"/>
                <xsl:apply-templates select="tei:unclear/child::node()"/>
            </p>
        </div>
        <br/>
    </xsl:template>

    <!-- Template message cartolina OK-->
    <xsl:template match="tei:body/tei:div[@type='retro']/tei:div[@type='message']">
        <xsl:variable name="temp_id" select="current()/@facs"/>
        <xsl:variable name="final_id" select="substring-after($temp_id, '#')"/>
        <div class="stamp">
            <xsl:attribute name="id">
                <xsl:value-of select="$final_id"/>
            </xsl:attribute>
            <p>
                <h5>Data e luogo messaggio:</h5>
                <xsl:apply-templates select="tei:opener"/>
            </p>
            <p>
                <h5>Omaggi e Firma:</h5>
                <xsl:apply-templates select="tei:closer"/>
            </p>
        </div>
    </xsl:template>

    <!-- Template per opener OK-->
    <xsl:template match="tei:opener">
        <xsl:choose>
            <xsl:when test="count(tei:placeName/tei:unclear)>0">
                    <xsl:apply-templates select="tei:placeName/tei:unclear"/>
                    <xsl:value-of select="tei:placeName/tei:unclear/following-sibling::text()"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="tei:placeName"/>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:value-of select="$space" disable-output-escaping="yes"/>
        <xsl:apply-templates select="tei:w"/>
        <xsl:value-of select="$space" disable-output-escaping="yes"/>
        <xsl:apply-templates select="tei:date/child::node()"/>
    </xsl:template>

    <!-- Template per closer OK-->
    <xsl:template match="tei:closer">
        <p>
            <xsl:apply-templates select="tei:salute"/>
        </p>
        <p>
            <xsl:apply-templates select="tei:signed"/>
        </p>
    </xsl:template>

    <!-- Template per salute OK-->
    <xsl:template match="tei:salute">
        <xsl:if test="count(tei:unclear[@reason='eccentric_ductus'])>0">
            -<xsl:apply-templates select="tei:unclear/child::node()"/>
        </xsl:if>
    </xsl:template>

    <!-- Template per signed OK-->
    <xsl:template match="tei:signed"> 
        <xsl:choose>
            <xsl:when test="count(tei:persName/tei:addName[@type='alias'])>0">
                -(Alias: <xsl:value-of select="tei:persName"/>)
            </xsl:when>
            <xsl:otherwise>
                -<xsl:value-of select="tei:persName"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Template destination cartolina OK-->
    <xsl:template match="tei:body/tei:div[@type='retro']/tei:div[@type='destination']">
      <div class="stamp_div">
        <p>
          <h5>Timbri e Francobolli:</h5>
          <xsl:apply-templates select="tei:p/tei:stamp"/>
        </p>
      </div>
      <div class="destination_div">
        <p>
          <strong>Destinazione:</strong>
          <br/>
          <xsl:apply-templates select="tei:p[2]/tei:address/tei:addrLine"/>
        </p>
      </div>
        <xsl:if test="count(following-sibling::tei:fw)>0">
            <div class="note_segni_div">
                <p>
                    <h5>Note e altri segni: </h5>
                    <xsl:apply-templates select="following-sibling::tei:fw"/>
                </p>
            </div>
        </xsl:if>
    </xsl:template>

    <!-- Template per i Timbro e francobolli OK-->
    <xsl:template match="tei:p/tei:stamp">
        <xsl:variable name="temp_id_stamp" select="@facs"/>
        <xsl:variable name="final_id_stamp" select="substring-after($temp_id_stamp, '#')"/>
        <div class="stamp">
            <xsl:attribute name="id">
                <xsl:value-of select="$final_id_stamp"/>
            </xsl:attribute>
            <p>
                <xsl:choose>
                    <xsl:when test="@type='postmark'">
                        <strong>Timbro:</strong>
                    </xsl:when>
                    <xsl:when test="@type='postage'">
                       <strong>Francobollo:</strong>
                        <br/>
                    </xsl:when>
                </xsl:choose>
                <xsl:value-of select="$space" disable-output-escaping="yes"/>
                <xsl:value-of select="text()"/>
                <xsl:apply-templates select="tei:unclear"/>
                <xsl:if test="count(tei:date)>0">
                    <br/>
                    <xsl:value-of select="$space" disable-output-escaping="yes"/>
                    <xsl:apply-templates select="tei:date/tei:unclear/child::node()"/>
                </xsl:if>
                <xsl:if test="count(tei:note)>0">
                    <br/>
                    <strong>Note:</strong>
                    <br/>
                    <xsl:value-of select="$space" disable-output-escaping="yes"/>
                    <xsl:apply-templates select="tei:note"/>
                </xsl:if>
            </p>
        </div>
        <br/>
    </xsl:template>

    <!-- Template per l'indirizzo -->
    <xsl:template match="tei:address/tei:addrLine">
        <xsl:choose>
            <xsl:when test="count(tei:choice)>0">
                <xsl:apply-templates select="tei:choice"/>
                <br/>
            </xsl:when>
            <xsl:when test="count(tei:persName)>0">
                <strong>Destinatario: </strong>
                <br/>
                <xsl:apply-templates select="tei:persName"/>
                <br/>
            </xsl:when>
            <xsl:when test="count(tei:hi)>0">
                <strong>Indirizzo:</strong>
                <br/>
                <u><xsl:value-of select="tei:hi[1]"/></u>
                <xsl:value-of select="tei:seg[1]"/>
                <xsl:value-of select="$space" disable-output-escaping="yes"/>
                <u><xsl:value-of select="tei:hi[2]"/></u>
                <xsl:value-of select="tei:seg[2]"/>
                <xsl:value-of select="$space" disable-output-escaping="yes"/>
                <xsl:apply-templates select="tei:unclear"/>
                <xsl:value-of select="$space" disable-output-escaping="yes"/>
                <br/>
                <xsl:value-of select="tei:num"/>
                <br/>
                <strong>Note:</strong>
                <br/>
                <xsl:value-of select="tei:note"/>
                <br/>
            </xsl:when>
            <xsl:when test="count(tei:placeName)>0">
                <strong>Luogo:</strong>
                <br/>
                <xsl:apply-templates select="tei:placeName"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <!-- Template per i front work OK-->
    <xsl:template match="tei:fw">
        <xsl:variable name="temp_id_stamp" select="@facs"/>
        <xsl:variable name="final_id_stamp" select="substring-after($temp_id_stamp, '#')"/>
        <div class="stamp">
            <xsl:attribute name="id">
                <xsl:value-of select="$final_id_stamp"/>
            </xsl:attribute>
            <p>
                <xsl:if test="@type='n_cartolina'">
                    <h5>Numero cartolina:</h5>
                </xsl:if>
                <xsl:value-of select="text()"/>
                <xsl:value-of select="tei:placeName"/>
                <br/>
            </p>
        </div>
    </xsl:template>

    <!-- VARIE -->

    <!-- Template per w -->
    <xsl:template match="tei:w">
        <xsl:value-of select="text()"/>
        <xsl:value-of select="tei:pc"/>
    </xsl:template>

    <!-- Template per choice -->
    <xsl:template match="tei:choice">
        <xsl:choose>
            <xsl:when test="count(tei:abbr/tei:hi)>0">
                ( '<u><xsl:value-of select="tei:abbr/tei:hi"/></u><xsl:value-of select="tei:abbr/tei:seg"/>' .)
            </xsl:when>
            <xsl:otherwise>
                ( '<xsl:value-of select="tei:abbr"/>' .)
            </xsl:otherwise>
        </xsl:choose>
        <xsl:value-of select="$space" disable-output-escaping="yes"/>
        [<xsl:value-of select="tei:expan"/>]
        <xsl:value-of select="$space" disable-output-escaping="yes"/>
    </xsl:template>

    <!-- Template per placeName -->
    <xsl:template match="tei:placeName">
        <xsl:if test="count(tei:hi)>0">
            <u><xsl:value-of select="tei:hi"/></u>
            <xsl:value-of select="tei:seg"/>
        </xsl:if>
        <xsl:value-of select="text()"/>
        <xsl:value-of select="$space" disable-output-escaping="yes"/>
    </xsl:template>

    <!-- Template per unclear -->
    <xsl:template match="tei:unclear">
        <br/>
        <xsl:value-of select="text()"/>
        <xsl:apply-templates select="child::node()"/>
    </xsl:template>

    <!-- Template per i child di unclear -->
    <xsl:template match="tei:unclear/child::node()">
        <xsl:choose>
            <xsl:when test="name() = 'hi'">
                <u><xsl:value-of select="text()"/></u>
            </xsl:when>
            <xsl:when test="name() = 'choice'">
                (! '<xsl:apply-templates select="tei:sic"/>' !)
                <xsl:value-of select="$space" disable-output-escaping="yes"/>
                [<xsl:value-of select="tei:corr"/>]
            </xsl:when>
            <xsl:when test="name() = 'num'">
                <xsl:value-of select="text()"/>
            </xsl:when>
            <xsl:when test="name() = 'seg'">
                <xsl:value-of select="text()"/>
            </xsl:when>
            <xsl:when test="name() = 'gap'">
                (- '<xsl:value-of select="@reason"/>' -)
            </xsl:when>
            <xsl:when test="name() = 'abbr'">
                <xsl:value-of select="text()"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <!-- Template per sic -->
    <xsl:template match="tei:sic">
        <xsl:choose>
            <xsl:when test="count(tei:hi)>0">
                <u><xsl:value-of select="tei:hi"/></u>
                <xsl:value-of select="tei:seg"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="text()"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Template per date child -->
    <xsl:template match="tei:date/child::node()">
        <xsl:choose>
            <xsl:when test="name() = 'pc'">
                <xsl:value-of select="text()"/>
            </xsl:when>
            <xsl:when test="name() = 'num'">
                <xsl:value-of select="text()"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>

    <!-- Template per persname -->
    <xsl:template match="tei:persName">
        <xsl:if test="count(tei:hi)>1">
            <u><xsl:value-of select="tei:hi[1]"/></u>
            <xsl:value-of select="tei:seg[1]"/>
            <xsl:value-of select="$space" disable-output-escaping="yes"/>
            <u><xsl:value-of select="tei:hi[2]"/></u>
            <xsl:value-of select="tei:seg[2]"/>
        </xsl:if>
        <xsl:value-of select="text()"/>
        <xsl:value-of select="$space" disable-output-escaping="yes"/>
    </xsl:template>

    <!-- FOOTER SITO -->

    <!--Configurazione footer con edizione e pubblicazione-->
    <xsl:template match="tei:teiHeader/tei:fileDesc">
        <div class="edizione">
            <xsl:apply-templates select="tei:editionStmt/tei:respStmt"/>
        </div>
        <div class="pubblicazione">
            <xsl:apply-templates select="tei:publicationStmt"/>
        </div>
    </xsl:template>
  
	<!--Template per respStmt -->
    <xsl:template match="tei:editionStmt/tei:respStmt">
        <p>
          <strong>
          	<xsl:value-of select="tei:resp"/>
          </strong>
        </p>
        <xsl:value-of select="$space" disable-output-escaping="yes"/>
        <xsl:for-each select="tei:name">
            <xsl:choose>
                <xsl:when test="position() != last()">
                    <xsl:choose>
                        <xsl:when test="not(normalize-space(text()))">
                            <xsl:variable name="temp_id">
                                <xsl:value-of select="@ref"/>
                            </xsl:variable>
                            <xsl:variable name="final_id">
                                <xsl:value-of select="substring-after($temp_id, '#')"/>
                            </xsl:variable>
                            <xsl:value-of select="//tei:name[@xml:id=$final_id]"/>,<xsl:value-of select="$space" disable-output-escaping="yes"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="text()"/>,<xsl:value-of select="$space" disable-output-escaping="yes"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="not(normalize-space(text()))">
                            <xsl:variable name="temp_id">
                                <xsl:value-of select="@ref"/>
                            </xsl:variable>
                            <xsl:variable name="final_id">
                                <xsl:value-of select="substring-after($temp_id, '#')"/>
                            </xsl:variable>
                            <xsl:value-of select="//tei:name[@xml:id=$final_id]"/>
                            <br/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="text()"/>
                            <br/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>

    <!--Template per la pubblicazione, estraggo l'editore, il distributore e la licensa-->
    <xsl:template match="tei:publicationStmt">
        <p>
            <strong>Editore: </strong>
            <xsl:value-of select="tei:publisher"/>
            <br/>
            <strong>Distribuito da: </strong>
            <xsl:value-of select="tei:distributor"/>
            <br/>
            <strong>Disponibilità: </strong> 
            <xsl:value-of select="tei:availability/tei:p"/>
            <br/>
        </p>
    </xsl:template>

</xsl:stylesheet>