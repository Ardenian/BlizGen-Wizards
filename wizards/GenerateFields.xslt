<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  <xsl:output method="xml" indent="yes"/>

  <!--Using EditorData/EditorCategories.xml to get needed fields-->

  <xsl:template match="EditorCategories">
    <xsl:element name="fields">
      <xsl:apply-templates select="@* | node()"/>
    </xsl:element>
  </xsl:template>

  <xsl:template match="@* | node()">
    <xsl:apply-templates select="@* | node()"/>
  </xsl:template>

  <xsl:template match="fieldVal[starts-with(@path, 'CBehaviorBuff_Modification_')]">
    <xsl:element name="field">
      <xsl:attribute name="name">
        <xsl:value-of select="substring-after(@path, 'CBehaviorBuff_Modification_')"/>
      </xsl:attribute>
      <xsl:attribute name="category">
        <xsl:value-of select="./value/text()"/>
      </xsl:attribute>
    </xsl:element>
  </xsl:template>



</xsl:stylesheet>
