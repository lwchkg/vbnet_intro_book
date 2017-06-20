<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:outline="http://wkhtmltopdf.org/outline"
                xmlns:foo="whatever"
                xmlns="http://www.w3.org/1999/xhtml">
  <xsl:output doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
              doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>

  <!-- Do not enter file:// because wkhtmltopdf rejects it. -->
  <xsl:variable name="current_dir" select="'%url_current_dir%'" />
  <xsl:variable name="summary" select="document(concat($current_dir, '/SUMMARY.xhtml'))" />
  <xsl:variable name="toc_str" select="$summary//h1" />

  <xsl:template match="outline:outline">
    <html>
      <head>
        <title><xsl:value-of select="$toc_str/text()"/></title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link rel="stylesheet" href="{$current_dir}/wk_toc.css"/>
      </head>
      <body>
        <h1><xsl:value-of select="$toc_str"/></h1>
        <ul class="toc"><xsl:apply-templates select="outline:item[@link!=''][position()>1]/outline:item"/></ul>
      </body>
    </html>
  </xsl:template>

  <xsl:function name="foo:filterpagenumber" as="xs:string">
    <xsl:param name="str1" as="xs:string"/>
    <xsl:choose>
      <xsl:when test="matches($str1, '.')">
        <xsl:value-of select="substring-after($str1, '.')"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$str1"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <xsl:function name="foo:removesectionnumber" as="xs:string">
    <xsl:param name="title" as="xs:string"/>
    <xsl:param name="section_no" as="xs:string"/>
    <xsl:choose>
      <xsl:when test="starts-with($title, $section_no)">
        <xsl:value-of select="normalize-space(substring-after($title, $section_no))"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$title"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <xsl:template match="outline:item">
    <xsl:if test="@title!=''">
      <xsl:variable name="section_no_raw" select="subsequence($summary//span[@class='inner'],position(),1)/span"/>
      <!-- Filter the first part of the raw section number because that is unused in a single-part book. -->
      <xsl:variable name="section_no" select="foo:filterpagenumber($section_no_raw)"/>
      <li class="{concat('level-', count(tokenize($section_no, '\.')))}">
        <span class="content"><a>
          <xsl:if test="@link">
            <xsl:attribute name="href"><xsl:value-of select="@link"/></xsl:attribute>
          </xsl:if>
          <xsl:if test="@backLink">
            <xsl:attribute name="name"><xsl:value-of select="@backLink"/></xsl:attribute>
          </xsl:if>

          <!-- Replace the tags below with the following to add chapter number
          <xsl:if test="compare(@title, 'Glossary') != 0">
            <xsl:if test="not(contains($section_no, '.'))">Chapter </xsl:if>
            <xsl:value-of select="$section_no" />
            <span class="sep"></span>
          </xsl:if>
          <xsl:value-of select="foo:removesectionnumber(@title, $section_no)" />
          -->
          
          <!-- Replace triple &nbsp; with span -->
          <xsl:for-each select="tokenize(@title, '&#160;&#160;&#160;')">
            <xsl:if test="position() > 1"><span class="sep"></span></xsl:if>
            <xsl:value-of select="."/>
          </xsl:for-each>
        </a></span>
        <span class="page-number"> <xsl:value-of select="@page" /> </span>
      </li>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
