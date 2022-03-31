<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
    <xsl:output method="xml" indent="no"/>

    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="modification">
      <xsl:element name="input">       
        <xsl:attribute name="id">EquipBehavior<xsl:value-of select="translate(./fieldpath/text(),'.','')"/></xsl:attribute>
        <xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
        <xsl:element name="name">EquipBehavior<xsl:value-of select="translate(./fieldpath/text(),'.','')"/></xsl:element>
        <xsl:element name="reloadfrom">EquipBehavior</xsl:element>
        <xsl:element name="loadvalue">ref=Behavior,^EquipBehavior^,Modification.<xsl:value-of select="./fieldpath"/></xsl:element>
        <xsl:element name="condition">
          <xsl:attribute name="input">EquipBehavior</xsl:attribute>
          <xsl:attribute name="empty">0</xsl:attribute>
        </xsl:element>
      </xsl:element>
    </xsl:template>

  <xsl:template match="entry[../modification[@percentage='true']]">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
      <xsl:for-each select="../modification">
        <xsl:element name="field">
          <xsl:attribute name="id">TooltipAppender_Text</xsl:attribute>
          <xsl:element name="index">ref=Button,^Button^,TooltipAppender#</xsl:element>
          <xsl:element name="stringid">EquipBehavior<xsl:value-of select="translate(./fieldpath/text(),'.','')"/>ref=Button,^Button^,Name</xsl:element>
          <xsl:element name="value">&lt;d ref = "Behavior,^EquipBehavior^,Modification.<xsl:value-of select="fieldpath"/> -1 * 100" precision="2"/&gt;% <xsl:value-of select="description"/></xsl:element>
          <xsl:element name ="condition">
            <xsl:attribute name="logic">not</xsl:attribute>
            <xsl:attribute name="input">EquipBehavior<xsl:value-of select="translate(./fieldpath/text(),'.','')"/></xsl:attribute>
            <xsl:attribute name ="value">ref=Behavior,CBehaviorBuff,Modification.<xsl:value-of select="fieldpath"/></xsl:attribute>
            <xsl:attribute name="operator">equal</xsl:attribute>
          </xsl:element>
        </xsl:element>
      </xsl:for-each>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="entry[not(../modification[@percentage='true'])]">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
      <xsl:for-each select="../modification">
        <xsl:element name="field">
          <xsl:attribute name="id">TooltipAppender_Text</xsl:attribute>
          <xsl:element name="index">ref=Button,^Button^,TooltipAppender#</xsl:element>
          <xsl:element name="stringid">EquipBehavior<xsl:value-of select="translate(./fieldpath/text(),'.','')"/>ref=Button,^Button^,Name</xsl:element>
          <xsl:element name="value">&lt;d ref = "Behavior,^EquipBehavior^,Modification.<xsl:value-of select="fieldpath"/>" precision="2"/&gt;% <xsl:value-of select="description"/></xsl:element>
          <xsl:element name ="condition">
            <xsl:attribute name="logic">not</xsl:attribute>
            <xsl:attribute name="input">EquipBehavior<xsl:value-of select="translate(./fieldpath/text(),'.','')"/></xsl:attribute>
            <xsl:attribute name ="value">ref=Behavior,CBehaviorBuff,Modification.<xsl:value-of select="fieldpath"/></xsl:attribute>
            <xsl:attribute name="operator">equal</xsl:attribute>
          </xsl:element>
        </xsl:element>
      </xsl:for-each>
    </xsl:copy>
  </xsl:template>
  
  </xsl:stylesheet>