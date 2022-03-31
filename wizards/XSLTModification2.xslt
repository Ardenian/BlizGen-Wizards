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
        <xsl:attribute name="id">EquipBehavior<xsl:value-of select="identifier"/></xsl:attribute>
        <xsl:choose>
          <xsl:when test="./@type">
            <xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute></xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="type">real32</xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:element name="name">EquipBehavior<xsl:value-of select="identifier"/></xsl:element>
        <xsl:element name="reloadfrom">EquipBehavior</xsl:element>
        <xsl:choose>
          <xsl:when test="./path">
            <xsl:element name="loadvalue">ref=Behavior,^EquipBehavior^,Modification.<xsl:value-of select="path"/></xsl:element>
          </xsl:when>
          <xsl:otherwise>
            <xsl:element name="loadvalue">ref=Behavior,^EquipBehavior^,Modification.<xsl:value-of select="identifier"/></xsl:element>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:element name="condition">
          <xsl:attribute name="input">EquipBehavior</xsl:attribute>
          <xsl:attribute name="empty">0</xsl:attribute>
        </xsl:element>
      </xsl:element>     
    </xsl:template>

  <xsl:template match="entry">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
      <xsl:for-each select="../modification">
        <xsl:element name="field">
          <xsl:attribute name="id">TooltipAppender_Text</xsl:attribute>
          <xsl:element name="index">ref=Button,^Button^,TooltipAppender#</xsl:element>
          <xsl:element name="stringid">EquipBehavior<xsl:value-of select="./identifier"/>ref=Button,^Button^,Name
          </xsl:element>
          <xsl:choose>
            <xsl:when test="./@percentage = 'true'">
              <xsl:choose>
                <xsl:when test="./path">
                  <xsl:element name="value">&lt;d ref = "Behavior,^EquipBehavior^,Modification.<xsl:value-of select="path"/> -1 * 100" precision="2"/&gt;% <xsl:value-of select="description"/>
                  </xsl:element>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:element name="value">&lt;d ref = "Behavior,^EquipBehavior^,Modification.<xsl:value-of select="identifier"/> -1 * 100" precision="2"/&gt;% <xsl:value-of select="description"/>
                  </xsl:element>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
              <xsl:element name="value">&lt;d ref = "Behavior,^EquipBehavior^,Modification.<xsl:value-of select="path"/>" precision="2"/&gt;% <xsl:value-of select="description"/></xsl:element>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:element name ="condition">
            <xsl:attribute name="logic">not</xsl:attribute>
            <xsl:attribute name="input">EquipBehavior<xsl:value-of select="identifier"/>
            </xsl:attribute>
            <xsl:choose>
              <xsl:when test="./path">
                <xsl:attribute name ="value">ref=Behavior,CBehaviorBuff,Modification.<xsl:value-of select="path"/>
                </xsl:attribute>
              </xsl:when>
              <xsl:otherwise>
                <xsl:attribute name ="value">ref=Behavior,CBehaviorBuff,Modification.<xsl:value-of select="identifier"/>
                </xsl:attribute>
              </xsl:otherwise>
            </xsl:choose>
            <xsl:attribute name="operator">equal</xsl:attribute>
          </xsl:element>
        </xsl:element>
      </xsl:for-each>
    </xsl:copy>
  </xsl:template>
  </xsl:stylesheet>