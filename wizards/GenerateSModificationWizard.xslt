<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="wizard-fields">
    <xsl:element name="wizard">
      <xsl:for-each select="./wizard-field">
        <xsl:variable name="related-field">
          <xsl:copy-of select="document('model.xml')/descendant::Field[./@name = @name]"/>
        </xsl:variable>
          <xsl:choose>
            <!--field is not an array in any way-->
            <xsl:when test="not($related-field/@array) or $related-field/@array = false">
              <xsl:element name="input">
                <xsl:attribute name="id"><xsl:value-of select="@name"/>
              </xsl:attribute>
              <xsl:attribute name="type">
                <xsl:value-of select="$related-field/@type"/>
              </xsl:attribute>
              </xsl:element>
            </xsl:when>
          </xsl:choose>
      </xsl:for-each>
      <xsl:element name="entry">
        <xsl:attribute name="catalog">Behavior</xsl:attribute>
        <xsl:attribute name="type">CBehavior</xsl:attribute>

        <xsl:for-each select="./wizard-field">
          <xsl:element name="field">

          </xsl:element>
        </xsl:for-each>
      </xsl:element>
    </xsl:element>
  </xsl:template>
</xsl:stylesheet>
