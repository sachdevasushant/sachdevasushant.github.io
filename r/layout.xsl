<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output
   method="html"
   version="4.0"
   indent="yes"
   doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"
   doctype-public="-//W3C//DTD XHTML 1.1//EN"
   media-type="text/html"
   omit-xml-declaration="yes"
   />

  <xsl:template match="document">
    <html xmlns="http://www.w3.org/1999/xhtml"  xml:lang="en-GB">      
      <head>
	<meta http-equiv="Content-Type" content="text/xhtml; charset=utf-8" />
	<meta http-equiv="Content-Language" content="en-GB" />
	<meta name="author" content="Rajsekar Manokaran" />
	<meta name="abstract" content="My home page." />
	<meta name="description" content="Seriously! My home page." />
	<meta name="keywords" content="home page, rajsekar, manokaran, princeton"/>
	<meta name="distribution" content="global" />
	<meta name="revisit-after" content="1 days" />	
	<meta name="copyright" content="All content (c) Rajsekar Manokaran" />

	<link rel="stylesheet" href="support/style.css" type="text/css" media="screen" />
 	<script src="support/ASCIIMathML.js" type="text/javascript"></script> 
 	<script type="text/javascript">
	  <![CDATA[
	  function toggle(targetId) {
	  var target = document.getElementById(targetId);
	  if (target.style.display == "block"){
	  target.style.display="none";
	  } else {
	  target.style.display="block";
	  }
	  }]]>
	</script>
	<title>Rajsekar Manokaran's home page</title>



      </head>

      <body>
	<div class="content">
	<div class="header">
	</div>
	<div class="main">
	<xsl:apply-templates/>  
	</div>
	<div class="footer">
	</div>
	</div>

      </body>
    </html>
  </xsl:template>



  <!-- A somewhat useful section tag, similar to in latex -->
  <xsl:template match="section">
    <div class="section">
      <h1><xsl:value-of select="@title"/></h1>
      <xsl:apply-templates/>
    </div>
  </xsl:template>


  
  <!-- Tags for a bulleted list -->
  <xsl:template match="list">
    <ul>
      <xsl:apply-templates/>
    </ul>
  </xsl:template>

  <xsl:template match="item">
    <li><h3><xsl:value-of select="@title"/></h3></li>
    <div><xsl:apply-templates /></div>
  </xsl:template>

  <!-- tags related to publications -->
  <xsl:template match="publications">
    <div class="publications">
	<xsl:for-each select="paper">
	  <xsl:sort select="year" order="descending"/>

	  <a>
	    <xsl:attribute name="name">
	      <xsl:value-of select="@id"/>
	    </xsl:attribute>
	  </a>

	  <h3 class="title"> <xsl:apply-templates select="title"/> </h3>
	  with <xsl:apply-templates select="coauthors"/>
	  <br/> <xsl:apply-templates select="conf"/> 
	  <xsl:apply-templates select="abstract"/>

	  <xsl:for-each select="filelink">
	    <a>
	      <xsl:attribute name="href">
		<xsl:apply-templates/>
	      </xsl:attribute>
	      (<xsl:value-of select="@type"/>)
	    </a>
	  </xsl:for-each>

	</xsl:for-each>
    </div>
  </xsl:template>

  <xsl:template match="abstract">
    <br/>
    <a>
      <xsl:attribute name="href">javascript:toggle('abs<xsl:value-of select="../@id"/>')</xsl:attribute>
      (abstract)
    </a>
    <br/>
    <div class="abstract">
      <xsl:attribute name="id">abs<xsl:value-of select="../@id"/></xsl:attribute>
      <xsl:attribute name="style">display: none</xsl:attribute>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="paper/title">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="paper/coauthors">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="authors">
  </xsl:template>

  <xsl:template match="author">
    <xsl:apply-templates select="/document/authors/person[@name=current()/@name]"/>
  </xsl:template>

  <!-- A useful <wiki> tag -->
  <xsl:template match="wiki">
    <a>
      <xsl:attribute name="href">http://en.wikipedia.org/wiki/<xsl:apply-templates/></xsl:attribute>
      <xsl:apply-templates/>
    </a>
  </xsl:template>


  <!-- A useful <google> tag that googles and goes to the relevant page automatically-->
  <xsl:template match="google">
    <a>
      <xsl:attribute name="href">http://www.google.com/search?q=<xsl:apply-templates/><![CDATA[&gfns=1&sourceid=navclient]]></xsl:attribute>
      <xsl:apply-templates/>
    </a>
  </xsl:template>


  <!-- The very useful identity tag -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>

