<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="ISO-8859-1"/>

  <xsl:template match="/">
    <xsl:variable name="docName">
      <xsl:value-of select="ReportInfo/ReportInformation/Source"/>
    </xsl:variable>

    <xsl:variable name="docTag">
      <xsl:value-of select="ReportInfo/ReportInformation/Tag"/>
    </xsl:variable>

    <xsl:variable name="docType">
      <xsl:if test="$docTag = '1' or $docTag = '7' ">
        <xsl:value-of select="'FBDI'"/>
      </xsl:if>
      <xsl:if test="$docTag = '2'">
        <xsl:value-of select="'FBDI_Split'"/>
      </xsl:if>
      <xsl:if test="$docTag = '3'">
        <xsl:value-of select="'DBDI_Rep'"/>
      </xsl:if>
      <xsl:if test="$docTag = '9'">
        <xsl:value-of select="'DBDI_Rep_Native'"/>
      </xsl:if>
      <xsl:if test="$docTag = '4'">
        <xsl:value-of select="'DBDI_Scope'"/>
      </xsl:if>
      <xsl:if test="$docTag = '10'">
        <xsl:value-of select="'DBDI_Scope_Native'"/>
      </xsl:if>
    </xsl:variable>

    <xsl:variable name="packNum" select ="/ReportInfo/Children/ReportInfo[@Type='DocInfo' and @Name ='PackageNum']/ReportInformation/Source"/>
    <xsl:variable name="nbOfPack" select ="/ReportInfo/Children/ReportInfo[@Type='DocInfo' and @Name ='NbOfPackages']/ReportInformation/Source"/>
    <xsl:variable name="docRepName" select ="'./DBDIRepConversion'"/>
    <xsl:variable name="docGlobalName" select ="'./DBDIGlobalRepConversion.xml'"/>
    <xsl:variable name="docProcessReportName" select ="'../ProcessReport.xml'"/>
    <xsl:variable name="docGlobalNativeReportName" select ="'./NativeMigration.xml'"/>
    <xsl:variable name="docGlobalNativeRepMigName" select ="'./NativeGlobalRepConversion.xml'"/>

    <html>
      <head>
        <link rel="stylesheet" type="text/css" href="Data\ReportFBDI.css"/>
        <script id="scripttag" type="text/javascript" src="Data\ReportFBDI.js"></script>
      </head>
      <body bgcolor="White">
        <!--************************ Title of the html page *************************-->
        <div>
          <hr/>
          <table align="center">
            <tbody  id="title">
              <tr>
                <td>
                  <A name ="TopOfPage"/>
                  <img src="Data\3dslogo.png" align="middle"/>
                </td>
                <td class="styleTitle" valign="middle">
                  <!--<xsl:if test="count(/ReportInfo/ReportInformation/Details/Detail) > 1">
                    <xsl:value-of select="/ReportInfo/ReportInformation/Details/Detail[1]"/>
                  </xsl:if>-->
                  <xsl:value-of select="$docName"/>
                  <xsl:value-of select="ReportInfo/ReportVariable[@Name='Report']/@Value"/>
                  <xsl:if test="/ReportInfo/Children/ReportInfo[@Type='DocInfo' and @Name ='PackageNum']/ReportInformation/Source > 0">
                    (n°<xsl:value-of select="/ReportInfo/Children/ReportInfo[@Type='DocInfo' and @Name ='PackageNum']/ReportInformation/Source"/>)
                  </xsl:if>
                </td>
              </tr>
              <tr>
                <td align="center" colspan="2">
                  <xsl:choose>
                    <xsl:when test ="$docTag  &gt; 2 and $packNum>1">
                      <A>
                        <xsl:attribute name ="href">
                          <xsl:value-of select ="concat($docRepName,$packNum - 1,'.xml')"/>
                        </xsl:attribute>
                        <img src ="Data\Go_Left_expand.png" class="clickable" border ="0" id ="expandCollapseLeft">
                          <xsl:attribute name = "onmouseover" >toggle_Img_by_condition('expandCollapseLeft',"toggle")</xsl:attribute>
                          <xsl:attribute name = "onmouseout" >toggle_Img_by_condition('expandCollapseLeft',"toggle")</xsl:attribute>
                        </img>
                      </A>&#160;
                    </xsl:when>
                    <xsl:otherwise>
                      <img src ="Data\Go_Left_Off.png"/>&#160;
                    </xsl:otherwise>
                  </xsl:choose>
                  <xsl:choose>
                    <xsl:when test ="$docTag  &gt; 2 and ($packNum or $docTag = 4 or $docTag = 7 or $docTag = 10 or $docTag = 9)">
                      <A>
                        <xsl:attribute name ="href">
                          <xsl:if test ="$docTag = 3 or $docTag = 7">
                            <xsl:value-of select ="$docGlobalName"/>
                          </xsl:if>
                          <xsl:if test ="$docTag = 4">
                            <xsl:value-of select ="$docProcessReportName"/>
                          </xsl:if>
                          <xsl:if test ="$docTag = 10">
                            <xsl:value-of select ="$docGlobalNativeReportName"/>
                          </xsl:if>
                          <xsl:if test ="$docTag = 9">
                            <xsl:value-of select ="$docGlobalNativeRepMigName"/>
                          </xsl:if>
                        </xsl:attribute>
                        <img src ="Data\Go_Up_expand.png" class="clickable" border ="0" id ="expandCollapseUp">
                          <xsl:attribute name = "onmouseover" >toggle_Img_by_condition('expandCollapseUp',"toggle")</xsl:attribute>
                          <xsl:attribute name = "onmouseout" >toggle_Img_by_condition('expandCollapseUp',"toggle")</xsl:attribute>
                        </img>
                      </A>
                    </xsl:when>
                    <xsl:otherwise>
                      <img src ="Data\Go_Up_Off.png"/>
                    </xsl:otherwise>
                  </xsl:choose>&#160;
                  <xsl:choose>
                    <xsl:when test ="$docTag  &gt; 2 and $packNum &lt; $nbOfPack -1">
                      <A>
                        <xsl:attribute name ="href">
                          <xsl:value-of select ="concat($docRepName,$packNum + 1,'.xml')"/>
                        </xsl:attribute>
                        <img src ="Data\Go_Right_expand.png" class="clickable" border ="0" id ="expandCollapseRight">
                          <xsl:attribute name = "onmouseover" >toggle_Img_by_condition('expandCollapseRight',"toggle")</xsl:attribute>
                          <xsl:attribute name = "onmouseout" >toggle_Img_by_condition('expandCollapseRight',"toggle")</xsl:attribute>
                        </img>
                      </A>
                    </xsl:when>
                    <xsl:otherwise>
                      <img src ="Data\Go_Right_Off.png"/>
                    </xsl:otherwise>
                  </xsl:choose>

                </td>
              </tr>
            </tbody>
          </table>
          <hr/>
        </div>
        <div>
          <!--******************* Test report version compatibility ******************-->
          <xsl:if test="/ReportInfo/@Type != 'version1.0'">
            <p>Your version of the XSL file may not be compatible with this XML file.</p>
            <table border="1" cellspacing="0" cellpadding="3">
              <tr bgcolor="#FFCC66">
                <td>Document type</td>
                <td>Document version</td>
              </tr>
              <tr>
                <td>XSL</td>
                <td>version1.0</td>
              </tr>
              <tr>
                <td>XML</td>
                <td>
                  <xsl:value-of select="/ReportInfo/@Type"/>
                </td>
              </tr>
            </table>
          </xsl:if>
          <table align="center">
            <!-- ************** TransferInfos ************** -->
            <tr>
              <td>
                <table class="frame">
                  <th class="titleMode" colspan="5"  onmouseover="this.className='highlightTitleMode clickable';" onmouseout="this.className='titleMode clickable';"  width ="100%">
                    <xsl:attribute name="onclick">toggle_visibility_by_id('TransferInfosSection','plusminusTransferInfosSection')</xsl:attribute>
                    <xsl:value-of select = "ReportInfo/ReportVariable[@Name='ImportInformation']/@Value"/>
                    <img src="Data\Minus.gif">
                      <xsl:attribute name="id">plusminusTransferInfosSection</xsl:attribute>
                    </img>
                  </th>
                  <th >
                    <img src="Data/Time_info_expand.png" id ="expandCollapseTimeInfo" class ='clickable'>
                      <xsl:attribute name = "onmouseover" >toggle_Img_by_condition('expandCollapseTimeInfo',"toggle")</xsl:attribute>
                      <xsl:attribute name = "onmouseout" >toggle_visibility_by_condition('expandCollapseTimeInfo','TimeInfo',"expandSameStateOrToggle")</xsl:attribute>
                      <xsl:attribute name = "onclick" >
                        toggle_visibility('TimeInfo')
                        <!--toggle_visibility_by_condition('expandCollapseTimeInfo','expandCollapseTimeInfo',"expandSameStateOrToggle")-->
                      </xsl:attribute>
                    </img>
                  </th>
                  <tr>
                    <td colspan ="6">
                      <span id="TransferInfosSection" class="displayShow">
                        <xsl:call-template name="ImportInformation">
                          <xsl:with-param name="paramDocType" select="$docType"/>
                        </xsl:call-template>
                      </span>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>

            <!-- ************** Context Informations (FBDI ONLY) ************** -->
            <xsl:if test="//ReportInfo/Children/ReportInfo[@Type = 'context']">
              <tr>
                <td>
                  <table class="frame">
                    <tr>
                      <th class="titleMode" onmouseover="this.className='highlightTitleMode clickable';" onmouseout="this.className='titleMode clickable';">
                        <xsl:attribute name="onclick">toggle_visibility_by_id('ContextInformationSection','plusminusContextInformationSection')</xsl:attribute>
                        <xsl:value-of select = "ReportInfo/ReportVariable[@Name='ContextInformation']/@Value"/>
                        <img src="Data\Plus.gif" class="clickable">
                          <xsl:attribute name="id">plusminusContextInformationSection</xsl:attribute>
                        </img>
                      </th>

                    </tr>
                    <tr>
                      <td >
                        <span id="ContextInformationSection" class="displayHide">
                          <xsl:call-template name="ContextInformation"/>
                        </span>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </xsl:if>

            <!-- ************** Ssve Informations (FBDI ONLY) ************** -->
            <xsl:if test="//ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/ReportInfo[@Name = 'Save'][@Status = 'OK']">
              <xsl:if test ="starts-with($docType, 'FBDI') and not(starts-with($docType, 'FBDI_Split'))">
                <tr>
                  <td>
                    <table class="frame">
                      <tr>
                        <th class="titleMode" onmouseover="this.className='highlightTitleMode clickable';" onmouseout="this.className='titleMode clickable';">
                          <xsl:attribute name="onclick">toggle_visibility_by_id('SaveInformationSection','plusminusSaveInformationSection')</xsl:attribute>
                          <xsl:value-of select = "ReportInfo/ReportVariable[@Name='SaveInformation']/@Value"/>
                          <img src="Data\Plus.gif" class="clickable">
                            <xsl:attribute name="id">plusminusSaveInformationSection</xsl:attribute>
                          </img>
                        </th>

                      </tr>
                      <tr>
                        <td >
                          <span id="SaveInformationSection" class="displayHide">
                            <xsl:call-template name="SaveInformation"/>
                          </span>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </xsl:if>
            </xsl:if>

            <!-- ************** Details for the documents/representation ************** -->
            <tr>
              <td>

                <table class="frame">
                  <th class="titleMode"  colspan="5" onmouseover="this.className='highlightTitleMode clickable';" onmouseout="this.className='titleMode clickable';">
                    <xsl:attribute name="onclick">toggle_visibility_by_id('DetailsSection','plusminusDetailsSection')</xsl:attribute>
                    <xsl:choose>
                      <xsl:when test  = "starts-with($docType, 'FBDI_Split')">
                        <xsl:value-of select = "ReportInfo/ReportVariable[@Name='ScopeCompletiondocsandPackage']/@Value"/>
                      </xsl:when>
                      <xsl:otherwise>

                        <xsl:if test="starts-with($docType, 'FBDI')">
                          <xsl:value-of select = "ReportInfo/ReportVariable[@Name='Detailsfordocument']/@Value"/>
                        </xsl:if>
                        <xsl:if test="starts-with($docType, 'DBDI')">
                          <xsl:value-of select = "ReportInfo/ReportVariable[@Name='Detailsforrepresentation']/@Value"/>
                        </xsl:if>
                      </xsl:otherwise>
                    </xsl:choose>
                    <img src="Data\Plus.gif" class="clickable">
                      <xsl:attribute name="id">plusminusDetailsSection</xsl:attribute>
                    </img>
                  </th>
                  <tr>
                    <td>
                      <A name ="DetailSection"/>
                      <span id="DetailsSection" class="DisplayHide">
                        <xsl:call-template name="DetailInfo">
                          <xsl:with-param name="paramDocType" select="$docType"/>
                        </xsl:call-template>
                      </span>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>

            <!-- ************** Packages Details FBDI SPLIT ONLY ***** -->
            <xsl:if test="$docTag = '2'">
              <tr>
                <td>

                  <table class="frame">
                    <th class="titleMode"  onmouseover="this.className='highlightTitleMode clickable';" onmouseout="this.className='titleMode clickable';" width ="100%">
                      <xsl:attribute name="onclick">toggle_visibility_by_id('DetailsSectionPackage','plusminusDetailsSectionPack')</xsl:attribute>
                      <xsl:value-of select = "ReportInfo/ReportVariable[@Name='Detailsforthepackage']/@Value"/>
                      <img src="Data\Minus.gif" class="clickable">
                        <xsl:attribute name="id">plusminusDetailsSectionPack</xsl:attribute>
                      </img>
                    </th>


                    <tr>
                      <td >
                        <A name ="DetailSectionPackage"/>
                        <span id="DetailsSectionPackage" class="DisplayShow">
                          <xsl:call-template name="DetailInfoPackage">
                            <xsl:with-param name="paramDocType" select="$docType"/>
                          </xsl:call-template>
                        </span>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </xsl:if>
            <!-- ************** Versioning ************** -->
            <xsl:if test="//ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/ReportInfo[@Type = 'MigrationStep' and @Name= 'Conversion']/Children/ReportInfo[@Type='versioning']">
              <tr>
                <td>
                  <table class="frame">
                    <tr>
                      <th class="titleMode"  onmouseover="this.className='highlightTitleMode clickable';"
                      onmouseout="this.className='titleMode clickable';">
                        <xsl:attribute name="onclick">
                          toggle_visibility_by_id('VersioningInfoSection','plusminusVersioningInfoSection')
                        </xsl:attribute>
                        <xsl:value-of select = "ReportInfo/ReportVariable[@Name='RevisioningInformation']/@Value"/>
                        <img src="Data\Plus.gif" class="clickable">
                          <xsl:attribute name="id">plusminusVersioningInfoSection</xsl:attribute>
                        </img>
                      </th>
                    </tr>
                    <tr>
                      <td>
                        <A name ="versioningSection"/>
                        <span id="VersioningInfoSection" class="displayHide">
                          <!--xsl:call-template name="VersioningInfo"/-->
                          <!-- Fill the table with the xml content -->
                          <xsl:apply-templates select="//ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/ReportInfo[@Type = 'MigrationStep' and @Name= 'Conversion']/Children/ReportInfo[@Type='versioning']">
                          </xsl:apply-templates>
                        </span>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </xsl:if>
          </table>
        </div>
        <script language="javascript">
          var qsParm = getValue("name");
          var detailString = "Detail";
          if (qsParm != "" )
          {
          expand_detail_by_id(detailString.concat(qsParm));
          window.location.hash=qsParm;
          }
        </script>
      </body>

    </html>
  </xsl:template>

  <!--****************************************************************
					1.Section IMPORT Information
	**************************************************************** -->
  <xsl:template name="ImportInformation">
    <xsl:param name="paramDocType"/>

    <!-- Variables -->
    <xsl:variable name="ScopeStatus">
      <xsl:choose>
        <xsl:when test ="/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/ReportInfo[@Type = 'MigrationStep' and @Name= 'ScopeBuild']/@Status = 'WarningPriv' " >
          <xsl:value-of select="'OK'"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/ReportInfo[@Type = 'MigrationStep' and @Name= 'ScopeBuild']/@Status"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="ConversionStatus">
      <xsl:choose>
        <xsl:when test ="starts-with($paramDocType, 'FBDI') and not(/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/ReportInfo[@Type = 'MigrationStep' and @Name= 'Conversion']/@Status)" >
          <xsl:value-of select="'Interrupted'"/>
        </xsl:when>
        <xsl:when test ="/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/ReportInfo[@Type = 'MigrationStep' and @Name= 'Conversion']/@Status = 'WarningPriv' " >
          <xsl:value-of select="'OK'"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/ReportInfo[@Type = 'MigrationStep' and @Name= 'Conversion']/@Status"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="SaveStatus">
      <xsl:choose>
        <xsl:when test ="starts-with($paramDocType, 'FBDI') and not(/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/ReportInfo[@Type = 'MigrationStep' and @Name= 'Save']/@Status)" >
          <xsl:value-of select="'Interrupted'"/>
        </xsl:when>
        <xsl:when test ="/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/ReportInfo[@Type = 'MigrationStep' and @Name= 'Save']/@Status = 'WarningPriv' " >
          <xsl:value-of select="'OK'"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/ReportInfo[@Type = 'MigrationStep' and @Name= 'Save']/@Status"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="NbOfStatusInStepConversion" >
      <xsl:choose>
        <xsl:when test ="starts-with($paramDocType, 'DBDI_Scope')">
          <xsl:value-of select ="count(/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/
									ReportInfo[@Type = 'MigrationStep' and @Name= 'ScopeBuild']/Children/ReportInfo[@Type='StepInfo' and @Name='NbRepByStatus']/Children/
									ReportInfo[@Type='Status' and @Name !='WarningPriv'])"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select ="count(/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/
									ReportInfo[@Type = 'MigrationStep' and @Name= 'Conversion']/Children/ReportInfo[@Type='StepInfo' and @Name='NbRepByStatus']/Children/
									ReportInfo[@Type='Status' and @Name !='WarningPriv'])"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable >

    <xsl:variable name ="nbOfCreateV6Object">
      <xsl:if test ="/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/
														ReportInfo[@Type = 'MigrationStep' and @Name= 'Conversion']/Children/
																ReportInfo[@Type='StepInfo' and @Name='NbToCreate']">
        <xsl:value-of select ="/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/
														ReportInfo[@Type = 'MigrationStep' and @Name= 'Conversion']/Children/
																ReportInfo[@Type='StepInfo' and @Name='NbToCreate']/ReportInformation/Source/text() + 
													/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/
														ReportInfo[@Type = 'MigrationStep' and @Name= 'Conversion']/Children/
																ReportInfo[@Type='StepInfo' and @Name='NbToLoad']/ReportInformation/Source/text() +
													/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/
														ReportInfo[@Type = 'MigrationStep' and @Name= 'Conversion']/Children/
																ReportInfo[@Type='StepInfo' and @Name='NbOfLogged']/ReportInformation/Source/text()"/>
      </xsl:if>

    </xsl:variable>

    <!--****************************************************************
					1.1.	Section IMPORT Information: 
	**************************************************************** -->
    <table width ="100%">

      <!-- 1.1 AN3 : The Start , end and duration time (qd on clique sur l'horloge) -->
      <xsl:if test="/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']">
        <tr >
          <td id ="TimeInfo" class ="displayHide" align ="center" >
            <table class ="styleTimeInfo">
              <tr >
                <td align = "right">
                  <i>Start time :</i>
                </td>
                <td>
                  <i>
                    <xsl:choose>
                      <xsl:when test = "starts-with($paramDocType, 'FBDI_Split')" >
                        <xsl:value-of select="//ReportInfo[@Type = 'FbdiEngineStartTime']/ReportInformation/Details"/>
                      </xsl:when>
                      <xsl:when test = "starts-with($paramDocType, 'FBDI') and $ConversionStatus ='Interrupted'" >
                        <xsl:value-of select="/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/ReportInfo[@Type = 'MigrationStep' and @Name='ScopeBuild']
													/Children/ReportInfo[@Type = 'TimeInfo' and @Name= 'StartTime']/ReportInformation/Source"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/ReportInfo[@Type = 'TimeInfo' and @Name= 'StartTime']/ReportInformation/Source"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </i>
                  <br/>

                </td>
                <td width ="50">
                </td>

                <td align = "right" rowspan="2">
                  <i>Duration :</i>
                </td>
                <td rowspan="2">
                  <i>
                    <xsl:choose>
                      <xsl:when test = "starts-with($paramDocType, 'FBDI_Split')" >
                        <xsl:value-of select="//ReportInfo[@Type = 'FbdiEngineTotalTime']/ReportInformation/Details"/>
                      </xsl:when>
                      <xsl:when test = "starts-with($paramDocType, 'FBDI') and $ConversionStatus ='Interrupted'" >
                        <xsl:value-of select="/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/ReportInfo[@Type = 'MigrationStep' and @Name='ScopeBuild']
													/Children/ReportInfo[@Type = 'TimeInfo' and @Name= 'ExecutionTime']/ReportInformation/Source"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/ReportInfo[@Type = 'TimeInfo' and @Name= 'ExecutionTime']/ReportInformation/Source"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </i>

                </td>
              </tr>
              <tr >
                <td align = "right" >
                  <i>End time :</i>
                </td>
                <td>
                  <i>
                    <xsl:choose>
                      <xsl:when test = "starts-with($paramDocType, 'FBDI_Split')" >
                        <xsl:value-of select="//ReportInfo[@Type = 'FbdiEngineEndTime']/ReportInformation/Details"/>
                      </xsl:when>
                      <xsl:when test = "starts-with($paramDocType, 'FBDI') and $ConversionStatus ='Interrupted'" >
                        <xsl:value-of select="/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/ReportInfo[@Type = 'MigrationStep' and @Name='ScopeBuild']
													/Children/ReportInfo[@Type = 'TimeInfo' and @Name= 'EndTime']/ReportInformation/Source"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/ReportInfo[@Type = 'TimeInfo' and @Name= 'EndTime']/ReportInformation/Source"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </i>
                </td>
                <td/>
              </tr>
            </table>
          </td>
        </tr>
      </xsl:if>
      <!-- [Sec°Import].2 Affichage des informations sur le report: ligne commençant par  Report Name :-->
      <tr >
        <td align = "left" >
          <xsl:if test="/ReportInfo/ReportInformation/Details/Detail/text() != ''">
            <b>
              <xsl:value-of select = "ReportInfo/ReportVariable[@Name='ReportName']/@Value"/>
            </b> : <xsl:value-of select="/ReportInfo/ReportInformation/Details/Detail[last()]"/>
          </xsl:if>
          <xsl:if test="//ReportInfo/Children/ReportInfo[@Type = 'ReportTime']">
            <br></br>
            <b>Report Time</b> : <xsl:value-of select="//ReportInfo/Children/ReportInfo[@Type = 'ReportTime']/ReportInformation/Details/Detail"/>
          </xsl:if>

          <xsl:if test="//ReportInfo/Children/ReportInfo[@Type = 'VersionName' or @Type = 'UsedMachine']">
            <br></br>
            <b>3DEXPERIENCE Version</b>: <xsl:value-of select="//ReportInfo/Children/ReportInfo[@Type = 'VersionName']/ReportInformation/Details/Detail"/>
            <br/>
            <b>Client machine</b>: <xsl:value-of select="//ReportInfo/Children/ReportInfo[@Type = 'UsedMachine']/ReportInformation/Details/Detail"/>
          </xsl:if>
          <xsl:if test="starts-with($paramDocType, 'FBDI')">
            <!-- Display : # of files to import , CATIA Version and Client Machine -->
            <br/>
            <b>Input data size</b>: <xsl:value-of select="//ReportInfo/Children/ReportInfo[@Type = 'InputDataSize']/ReportInformation/Details/Detail"/>
          </xsl:if>
        </td>
      </tr>
      <!-- FIN 1.1.2 -->
      <xsl:if test="starts-with($paramDocType, 'FBDI_Split')">
        <tr class ="styleSetting">
          <td align = "left" >
            <i>
              <u>Split setting</u>
            </i>
            <xsl:if test="//ReportInfo[@Type = 'SplitMaxNumberOfDocuments']">
              <i>
                &#160;&#160;&#160;&#160;Content : <xsl:value-of select="//ReportInfo[@Type = 'SplitMaxNumberOfDocuments']/ReportInformation/Details"/> doc(s)
              </i>
            </xsl:if>
            <xsl:if test="//ReportInfo[@Type = 'SplitMaxSizeOfDocuments']">
              <i>
                &#160;&#160;&#160;&#160;Size : <xsl:value-of select="//ReportInfo[@Type = 'SplitMaxSizeOfDocuments']/ReportInformation/Details"/>
              </i>
            </xsl:if>
          </td>
        </tr>
      </xsl:if>
      <xsl:if test="starts-with($paramDocType, 'DBDI_Scope')">
        <tr class ="styleSetting">
          <td align = "left" >
            <i>
              <u>Split setting</u>
            </i>
            <xsl:if test="/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/ReportInfo[@Type = 'MigrationStep' and @Name = 'ScopeBuild']/
								Children/ReportInfo[@Type = 'StepInfo' and @Name = 'MaxNbOfDoc']/ReportInformation/Source != 'None'">
              <i>
                &#160;&#160;&#160;&#160;Content : <xsl:value-of select="/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/ReportInfo[@Type = 'MigrationStep' and @Name = 'ScopeBuild']/
								Children/ReportInfo[@Type = 'StepInfo' and @Name = 'MaxNbOfDoc']/ReportInformation/Source"/> rep
              </i>
            </xsl:if>
            <xsl:if test="/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/ReportInfo[@Type = 'MigrationStep' and @Name = 'ScopeBuild']/
								Children/ReportInfo[@Type = 'StepInfo' and @Name = 'MaxSizeOfDoc']/ReportInformation/Source != 'None'">
              <i>
                &#160;&#160;&#160;&#160;Size : <xsl:value-of select="/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/ReportInfo[@Type = 'MigrationStep' and @Name = 'ScopeBuild']/
								Children/ReportInfo[@Type = 'StepInfo' and @Name = 'MaxSizeOfDoc']/ReportInformation/Source"/> mb
              </i>
            </xsl:if>
          </td>
        </tr>
      </xsl:if>
      <!-- FIN 1.1(qd on clique sur l'horloge) -->
    </table>
    <br></br>

    <!--****************************************************************
					1.1.	Section IMPORT Information: Click sur l'horloge
	**************************************************************** -->
    <table align="center" >
      <tr>
        <td>
          <!-- Display graphic : source, arrow (with number of warnings/errors), destination -->
          <tr>
            <!-- ****************** Source Img and Info-->
            <td align="center" >
              <xsl:if test ="starts-with($paramDocType, 'DBDI_Scope')">
                <xsl:attribute name="rowspan">2</xsl:attribute>
              </xsl:if>
              <xsl:if test ="starts-with($paramDocType, 'FBDI')">
                <xsl:attribute name ="colspan">
                  <xsl:value-of select ="count(/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/
									ReportInfo[@Type = 'MigrationStep' and @Name= 'ScopeBuild']/Children/ReportInfo[@Type='StepInfo' and @Name='NbRepByStatus']/Children/
									ReportInfo[@Type='Status' and @Name !='WarningPriv'])"/>
                </xsl:attribute>
              </xsl:if>
              <br></br>
              <xsl:choose>
                <!-- ********** FBDI -->
                <xsl:when test="starts-with($paramDocType, 'FBDI')">
                  <img>
                    <xsl:choose>
                      <xsl:when test ="starts-with($paramDocType, 'FBDI_Split')">
                        <xsl:choose>
                          <xsl:when test ="$ScopeStatus = 'Error'">
                            <xsl:attribute name ="src">
                              Data/SB_Result_Err_expand.png
                            </xsl:attribute>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:attribute name ="src">
                              Data/SB_Result_expand.png
                            </xsl:attribute>
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:when>
                      <xsl:when test ="$ScopeStatus = 'Error'">
                        <xsl:attribute name ="src">
                          Data/SB_Step_Err_collapse.png
                        </xsl:attribute>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:attribute name ="src">
                          Data/SB_Step_expand.png
                        </xsl:attribute>
                      </xsl:otherwise>
                    </xsl:choose>
                    <xsl:attribute name = "id" >
                      <xsl:value-of select="concat('expandCollapseMainStepScopeBuild',$ScopeStatus)"/>
                    </xsl:attribute>
                    <xsl:attribute name = "onmouseover" >
                      toggle_Img_by_condition('<xsl:value-of select="concat('expandCollapseMainStepScopeBuild',$ScopeStatus)"/>',"toggle")
                    </xsl:attribute>
                    <xsl:attribute name = "onmouseout" >
                      toggle_visibility_by_condition('<xsl:value-of select="concat('expandCollapseMainStepScopeBuild',$ScopeStatus)"/>','plusminusScopeBuild',"expandSameStateOrToggle")
                    </xsl:attribute>
                    <xsl:attribute name = "class" >clickable</xsl:attribute>
                    <xsl:attribute name = "onclick">
                      toggle_visibility_by_id('summaryTableScopeBuildContent','plusminusScopeBuild')
                      toggle_visibility_by_condition('summaryTableScopeBuild','summaryTableScopeBuildContent',"showOrToggle")
                      toggle_visibility_by_condition('summaryTableScopeBuild','summaryTableScopeBuildContent',"hideOnly")
                      toggle_visibility_by_condition('<xsl:value-of select="concat('expandCollapseMainStepScopeBuild',$ScopeStatus)"/>','plusminusScopeBuild',"expandSameStateOrToggle")
                    </xsl:attribute>
                  </img>

                  <xsl:if test ="not(starts-with($paramDocType, 'FBDI_Split'))">
                    <br/>
                    <b class ="styleStepName">
                      <xsl:value-of select="/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/
													ReportInfo[@Type = 'MigrationStep' and @Name= 'ScopeBuild']/Children/
															ReportInfo[@Type='StepInfo' and @Name='Input'][1]/ReportInformation/Source/text()"/>
                    </b>
                  </xsl:if>

                  <table>
                    <xsl:if test ="starts-with($paramDocType, 'FBDI_Split')">
                      <tr>
                        <td align ="center">
                          <b class ="styleStepName">
                            <!--<xsl:attribute name="rowspan">-->
                            <xsl:value-of select="/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/
															ReportInfo[@Type = 'MigrationStep' and @Name= 'ScopeBuild']/Children/
																	ReportInfo[@Type='StepInfo' and @Name='Output']/ReportInformation/Source/text()"/>
                          </b>

                        </td>
                        <td align ="center">
                          <b class ="styleStepName">
                            <!--<xsl:attribute name="rowspan">-->
                            &#160;&#160;
                            <xsl:value-of select="/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/
															ReportInfo[@Type = 'MigrationStep' and @Name= 'ScopeBuild']/Children/
																	ReportInfo[@Type='StepInfo' and @Name='NbOfPackages']/ReportInformation/Source/text()"/>
                          </b>

                        </td>
                      </tr>

                    </xsl:if>
                    <!-- summaryTableContent-->
                    <xsl:call-template name="AddStepTitleRow">
                      <xsl:with-param name="strStepType" select="'ScopeBuild'"/>
                      <xsl:with-param name="strStepName" select="'Scope Completion'"/>
                      <xsl:with-param name ="strStepStatus" select ="$ScopeStatus"/>
                      <xsl:with-param name ="strDocType" select ="$paramDocType"/>

                    </xsl:call-template>
                  </table>
                  <br/>
                </xsl:when>
                <!-- ********** DBDI_SCOPE ONLY-->
                <xsl:when test="starts-with($paramDocType, 'DBDI_Scope')">
                  <img src= "Data/SB_Src.png">
                  </img>
                  <br/>
                  <b class ="styleStepName">
                    <xsl:value-of select="/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/
													ReportInfo[@Type = 'MigrationStep' and @Name= 'ScopeBuild']/Children/
															ReportInfo[@Type='StepInfo' and @Name='OutputQuery'][1]/ReportInformation/Source/text()"/>
                  </b>
                  <br/>
                  <br/>
                  <br/>
                </xsl:when>
                <xsl:otherwise>
                  <!-- ********* DBDI_REP  -->
                  <img src="Data/SB_Step_Done_expand.png">
                    <xsl:attribute name = "id" >
                      <xsl:value-of select="concat('expandCollapseMainStepScopeBuild',$ScopeStatus)"/>
                    </xsl:attribute>
                    <xsl:attribute name = "onmouseover" >
                      toggle_Img_by_condition('<xsl:value-of select="concat('expandCollapseMainStepScopeBuild',$ScopeStatus)"/>',"toggle")
                    </xsl:attribute>
                    <xsl:attribute name = "onmouseout" >
                      toggle_visibility_by_condition('<xsl:value-of select="concat('expandCollapseMainStepScopeBuild',$ScopeStatus)"/>','plusminusScopeBuild',"expandSameStateOrToggle")
                    </xsl:attribute>
                    <xsl:attribute name = "class" >clickable</xsl:attribute>
                    <xsl:attribute name = "onclick">
                      toggle_visibility_by_id('summaryTableScopeBuildContent','plusminusScopeBuild')
                      toggle_visibility('summaryTableScopeBuild')
                      toggle_visibility_by_condition('<xsl:value-of select="concat('expandCollapseMainStepScopeBuild',$ScopeStatus)"/>','plusminusScopeBuild',"expandSameStateOrToggle")
                    </xsl:attribute>
                  </img>
                  <br/>
                  <table>
                    <!-- summaryTableContent-->
                    <xsl:call-template name="AddStepTitleRow">
                      <xsl:with-param name="strStepType" select="'ScopeBuild'"/>
                      <xsl:with-param name="strStepName" select="'Scope Completion'"/>
                      <xsl:with-param name ="strStepStatus" select ="'OK'"/>
                      <xsl:with-param name ="strDocType" select ="$paramDocType"/>
                    </xsl:call-template>
                  </table>
                  <br/>
                </xsl:otherwise>
              </xsl:choose>
            </td>
            <!-- ****************** Transition arrow-->
            <td align="center">
              <xsl:if test ="starts-with($paramDocType, 'DBDI_Scope')">
                <xsl:attribute name="rowspan">2</xsl:attribute>
              </xsl:if>
              <xsl:choose>
                <xsl:when test ="not(starts-with($paramDocType, 'FBDI')) or (starts-with($paramDocType, 'FBDI')and ($ConversionStatus = 'Error' or $ConversionStatus = 'OK' or $ConversionStatus = 'Warning' ))">
                  <img src="Data/Transition_Arrow.png"/>
                </xsl:when>
                <xsl:otherwise>
                  <img src="Data/Transition_Stop.png"/>
                </xsl:otherwise>
              </xsl:choose>
            </td>
            <td align="center">
              <xsl:if test ="starts-with($paramDocType, 'DBDI_Scope')">
                <xsl:attribute name="rowspan">2</xsl:attribute>
              </xsl:if>
              <xsl:attribute name ="colspan">
                <xsl:value-of select ="$NbOfStatusInStepConversion"/>
              </xsl:attribute>
              <!-- ****************** Step status Name Img ****************** -->
              <xsl:choose>
                <!-- =========== DBDI Scope Report =========== -->
                <xsl:when test="starts-with($paramDocType, 'DBDI_Scope')">

                  <img>
                    <xsl:choose>
                      <!-- Affiche un ! rouge sur l'icône representant  l'etape du scope builder-->
                      <xsl:when test ="$ScopeStatus = 'Error'">
                        <xsl:attribute name ="src">
                          Data/SB_Step_Err_collapse.png
                        </xsl:attribute>
                      </xsl:when>
                      <xsl:when test ="$ScopeStatus = 'Warning'">
                        <xsl:attribute name ="src">
                          Data/SB_Step_Warning_collapse.png
                        </xsl:attribute>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:attribute name ="src">
                          Data/SB_Step_expand.png
                        </xsl:attribute>
                      </xsl:otherwise>
                    </xsl:choose>
                    <xsl:attribute name = "id" >
                      <xsl:value-of select="concat('expandCollapseMainStepScopeBuild',$ScopeStatus)"/>
                    </xsl:attribute>
                    <xsl:attribute name = "onmouseover" >
                      toggle_Img_by_condition('<xsl:value-of select="concat('expandCollapseMainStepScopeBuild',$ScopeStatus)"/>',"toggle")
                    </xsl:attribute>
                    <xsl:attribute name = "onmouseout" >
                      toggle_visibility_by_condition('<xsl:value-of select="concat('expandCollapseMainStepScopeBuild',$ScopeStatus)"/>','plusminusScopeBuild',"expandSameStateOrToggle")
                    </xsl:attribute>
                    <xsl:attribute name = "class" >clickable</xsl:attribute>
                    <xsl:attribute name = "onclick">
                      toggle_visibility_by_id('summaryTableScopeBuildContent','plusminusScopeBuild')
                      toggle_visibility_by_condition('summaryTableScopeBuild','summaryTableScopeBuildContent',"showOrToggle")
                      toggle_visibility_by_condition('summaryTableScopeBuild','summaryTableScopeBuildContent',"hideOnly")
                    </xsl:attribute>
                  </img>
                  <br/>
                  <table>
                    <!-- summaryTableContent-->
                    <xsl:call-template name="AddStepTitleRow">
                      <xsl:with-param name="strStepType" select="'ScopeBuild'"/>
                      <xsl:with-param name="strStepName" select="'Scope Builder'"/>
                      <xsl:with-param name ="strStepStatus" select ="$ScopeStatus"/>
                      <xsl:with-param name ="strDocType" select ="$paramDocType"/>
                    </xsl:call-template>
                  </table>
                </xsl:when>
                <xsl:otherwise>
                  <!-- =========== DBDI Scope Rep or other =========== -->
                  <img>
                    <xsl:choose>
                      <xsl:when test ="starts-with($paramDocType, 'FBDI_Split')">
                        <xsl:choose>
                          <xsl:when test ="$ConversionStatus = 'Error'">
                            <xsl:attribute name ="src">
                              Data/Split_Err_collapse.png
                            </xsl:attribute>
                          </xsl:when>
                          <xsl:when test ="$ConversionStatus = 'Interrupted' or $ConversionStatus = 'Skipped'">
                            <xsl:attribute name ="src">
                              Data/Split_NotExe.png
                            </xsl:attribute>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:attribute name ="src">
                              Data/Split_expand.png
                            </xsl:attribute>
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:when>
                      <xsl:when test ="$ConversionStatus = 'Error'">
                        <xsl:attribute name ="src">
                          Data/Convert_Step_Err_collapse.png
                        </xsl:attribute>
                      </xsl:when>
                      <xsl:when test ="$ConversionStatus = 'Interrupted' or $ConversionStatus = 'Skipped'">
                        <xsl:attribute name ="src">
                          Data/Convert_Step_NotExe.png
                        </xsl:attribute>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:attribute name ="src">
                          Data/Convert_Step_expand.png
                        </xsl:attribute>
                      </xsl:otherwise>
                    </xsl:choose>
                    <xsl:if test ="not(starts-with($paramDocType, 'FBDI_Split')) and ($ConversionStatus = 'Error' or $ConversionStatus = 'Warning')">
                      <xsl:attribute name = "id" >
                        <xsl:value-of select="concat('expandCollapseMainStepConversion',$ConversionStatus)"/>
                      </xsl:attribute>
                      <xsl:attribute name = "onmouseover" >
                        toggle_Img_by_condition('<xsl:value-of select="concat('expandCollapseMainStepConversion',$ConversionStatus)"/>',"toggle")
                      </xsl:attribute>
                      <xsl:attribute name = "onmouseout" >
                        toggle_visibility_by_condition('<xsl:value-of select="concat('expandCollapseMainStepConversion',$ConversionStatus)"/>','plusminusConversion',"expandSameStateOrToggle")
                      </xsl:attribute>
                      <xsl:attribute name = "class" >clickable</xsl:attribute>
                    </xsl:if>
                    <xsl:if test ="not(starts-with($paramDocType, 'FBDI_Split')) and $ConversionStatus != 'Interrupted' and not($ConversionStatus ='OK')" >
                      <xsl:attribute name = "onclick">
                        toggle_visibility_by_id('<xsl:value-of select="'summaryTableConversion'"/>','plusminusConversion')
                        toggle_visibility_by_condition('<xsl:value-of select="concat('expandCollapseMainStepConversion',$ConversionStatus)"/>','plusminusConversion',"expandSameStateOrToggle")
                      </xsl:attribute>
                    </xsl:if>
                  </img>
                  <table>
                    <tr>
                      <td align ="left">
                        <xsl:if test ="$ConversionStatus = 'Interrupted'">
                          <br/>
                        </xsl:if>
                        <b class ="styleStepName">
                          <xsl:if test ="not(starts-with($paramDocType, 'FBDI_Split'))">
                            <xsl:value-of select="/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/
														ReportInfo[@Type = 'MigrationStep' and @Name= 'Conversion']/Children/
																ReportInfo[@Type='StepInfo' and @Name='Input']/ReportInformation/Source/text()"/>
                          </xsl:if>
                          <xsl:if test ="starts-with($paramDocType, 'FBDI_Split')">
                            <xsl:value-of select="/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/
															ReportInfo[@Type = 'MigrationStep' and @Name= 'ScopeBuild']/Children/
																	ReportInfo[@Type='StepInfo' and @Name='NbOfPackages']/ReportInformation/Source/text()"/>
                          </xsl:if>
                        </b>
                      </td>
                      <td align ="right">
                        <b class ="styleStepName">
                          <xsl:if test ="$ConversionStatus != 'Error'">
                            <xsl:value-of select="$nbOfCreateV6Object"/>
                          </xsl:if>
                        </b>
                      </td>
                    </tr>
                    <!-- Conversion Title -->
                    <xsl:call-template name="AddStepTitleRow">
                      <xsl:with-param name="strStepType" select="'Conversion'"/>
                      <xsl:with-param name="strStepName" select="'Conversion'"/>
                      <xsl:with-param name ="strStepStatus" select ="$ConversionStatus"/>
                      <xsl:with-param name ="strDocType" select ="$paramDocType"/>
                    </xsl:call-template>
                  </table>
                </xsl:otherwise>
              </xsl:choose>

            </td>
            <!-- ****************** Transition arrow ****************** -->
            <td align="center">
              <xsl:if test ="starts-with($paramDocType, 'DBDI_Scope')">
                <xsl:attribute name="rowspan">2</xsl:attribute>
              </xsl:if>
              <xsl:choose>
                <xsl:when test="starts-with($paramDocType, 'DBDI_Scope')">
                  <img src="Data/Transition_Arrow.png"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:choose>
                    <xsl:when test ="$SaveStatus = 'Error' or $SaveStatus = 'OK' or $SaveStatus = 'Warning'">
                      <img src="Data/Transition_Arrow.png"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <img src="Data/Transition_Stop.png"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:otherwise>
              </xsl:choose>
            </td>
            <!-- ****************** Destination Img and Info ****************** -->
            <td align="center" >
              <xsl:if test ="starts-with($paramDocType, 'DBDI_Scope')">
                <xsl:attribute name="colspan">2</xsl:attribute>
              </xsl:if>
              <xsl:choose>
                <!-- =========== DBDI Scope Report =========== -->
                <xsl:when test="starts-with($paramDocType, 'DBDI_Scope')">
                  <img src="Data/SB_Result.png"/>
                  <br/>
                </xsl:when>
                <xsl:otherwise>
                  <!-- =========== DBDI Scope Rep or other =========== -->
                  <!--<xsl:if test ="$SaveStatus = 'OK' or $SaveStatus = 'Warning'">				-->
                  <xsl:if test ="not($SaveStatus = 'Interrupted' and starts-with($paramDocType, 'FBDI') )">
                    <br/>
                  </xsl:if>
                  <img>
                    <xsl:choose>
                      <xsl:when test ="$SaveStatus = 'Error'">
                        <xsl:attribute name ="src">
                          Data/Save_Step_Err_collapse.png
                        </xsl:attribute>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:choose>
                          <xsl:when test ="$SaveStatus = 'Interrupted' or $SaveStatus = 'Skipped'">
                            <xsl:attribute name ="src">
                              Data/Save_Step_NotExe.png
                            </xsl:attribute>
                          </xsl:when>
                          <xsl:otherwise>

                            <xsl:attribute name ="src">
                              Data/Save_Step_expand.png
                            </xsl:attribute>
                          </xsl:otherwise>
                        </xsl:choose>

                      </xsl:otherwise>
                    </xsl:choose>
                    <xsl:if test ="not(starts-with($paramDocType, 'FBDI_Split'))">
                      <xsl:attribute name = "id" >
                        <xsl:value-of select="concat('expandCollapseMainStepSave',$SaveStatus)"/>
                      </xsl:attribute>
                      <xsl:attribute name = "onmouseover" >
                        toggle_Img_by_condition('<xsl:value-of select="concat('expandCollapseMainStepSave',$SaveStatus)"/>',"toggle")
                      </xsl:attribute>
                      <xsl:attribute name = "onmouseout" >
                        toggle_visibility_by_condition('<xsl:value-of select="concat('expandCollapseMainStepSave',$SaveStatus)"/>','plusminusSave',"expandSameStateOrToggle")
                      </xsl:attribute>
                      <xsl:attribute name = "class" >clickable</xsl:attribute>
                      <xsl:attribute name = "onclick">
                        toggle_visibility_by_id('<xsl:value-of select="'summaryTableSave'"/>','plusminusSave')
                        toggle_visibility_by_condition('<xsl:value-of select="concat('expandCollapseMainStepSave',$SaveStatus)"/>','plusminusSave',"expandSameStateOrToggle")
                      </xsl:attribute>
                    </xsl:if>
                  </img>
                  <xsl:if test ="$SaveStatus = 'Interrupted' and starts-with($paramDocType, 'FBDI')">
                    <br/>
                    <br/>
                  </xsl:if>
                  <table>
                    <!-- Save Title -->
                    <xsl:call-template name="AddStepTitleRow">
                      <xsl:with-param name="strStepType" select="'Save'"/>
                      <xsl:with-param name="strStepName" select="'Save'"/>
                      <xsl:with-param name ="strStepStatus" select ="$SaveStatus"/>
                      <xsl:with-param name ="strDocType" select ="$paramDocType"/>
                    </xsl:call-template>
                  </table>

                </xsl:otherwise>
              </xsl:choose>
            </td>
          </tr>

          <!-- To correctly display the number of rep to migrate and the number of package -->
          <xsl:if test ="starts-with($paramDocType, 'DBDI_Scope')">
            <tr>
              <td align ="center">
                <b class ="styleStepName">
                  <!--<xsl:attribute name="rowspan">-->
                  <xsl:value-of select="/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/
										ReportInfo[@Type = 'MigrationStep' and @Name= 'ScopeBuild']/Children/
												ReportInfo[@Type='StepInfo' and @Name='Output']/ReportInformation/Source/text()"/>
                </b>
                <br/>
                <br/>
                <br/>
              </td>
              <td align ="center">
                <b class ="styleStepName">
                  <!--<xsl:attribute name="rowspan">-->
                  <xsl:value-of select="/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/
										ReportInfo[@Type = 'MigrationStep' and @Name= 'ScopeBuild']/Children/
												ReportInfo[@Type='StepInfo' and @Name='NbOfPackages']/ReportInformation/Source/text()"/>
                </b>
                <br/>
                <br/>
                <br/>
              </td>
            </tr>
          </xsl:if>

          <xsl:if test ="not(starts-with($paramDocType, 'FBDI_Split') )">
            <!-- Status by rep under each step. -->
            <tr>
              <!-- First Step : 
				 - Scope Builder report: None -> Input
				 - Rep Conversion/other report : Scope builder step
			-->
              <xsl:choose>
                <xsl:when test="starts-with($paramDocType, 'FBDI')">
                  <xsl:choose>
                    <!-- To manage the case where we have only 1 doc with a WarningPriv status.-->
                    <xsl:when test ="count(/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/
							ReportInfo[@Type = 'MigrationStep' and @Name= 'ScopeBuild']/Children/ReportInfo[@Type='StepInfo' and @Name='NbRepByStatus']//Children/ReportInfo[@Type='Status']) = 1">

                      <xsl:apply-templates select="/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/
							ReportInfo[@Type = 'MigrationStep' and @Name= 'ScopeBuild']/Children/ReportInfo[@Type='StepInfo' and @Name='NbRepByStatus']/Children/ReportInfo[@Type='Status']">
                        <xsl:with-param name="strStepType" select="'ScopeBuild'"/>
                        <xsl:with-param name="strDocType" select="$paramDocType"/>
                      </xsl:apply-templates>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:apply-templates select="/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/
								ReportInfo[@Type = 'MigrationStep' and @Name= 'ScopeBuild']/Children/ReportInfo[@Type='StepInfo' and @Name='NbRepByStatus']/Children/ReportInfo[@Type='Status' and @Name !='WarningPriv']">
                        <xsl:with-param name="strStepType" select="'ScopeBuild'"/>
                        <xsl:with-param name="strDocType" select="$paramDocType"/>
                      </xsl:apply-templates>
                    </xsl:otherwise>

                  </xsl:choose>


                </xsl:when>
                <xsl:otherwise>
                  <td align="center">
                    <xsl:if test="not(starts-with($paramDocType, 'DBDI_Scope'))">
                      <img src= "Data\Rep_Status_OK_Scope_expand.png"/>
                      <b class="styleOKScope">
                        <xsl:value-of select ="/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/
									ReportInfo[@Type = 'MigrationStep' and @Name= 'Conversion']/Children/ReportInfo[@Type='StepInfo' and @Name='Input']/ReportInformation/Source"/>
                      </b>
                    </xsl:if>
                  </td>
                </xsl:otherwise>
              </xsl:choose>
              <td/>
              <!-- For Visual effet : Below transition arrow space-->
              <!--***  Main Step : 
				 - Scope Builder report: Scope builder step
				 - Rep Conversion/other report : Conversion step
			-->
              <xsl:choose>
                <xsl:when test="starts-with($paramDocType, 'DBDI_Scope')">
                  <xsl:choose>
                    <!-- To manage the case where we have only 1 doc with a WarningPriv status.-->
                    <xsl:when test ="count(/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/
									ReportInfo[@Type = 'MigrationStep' and @Name= 'ScopeBuild']/Children/ReportInfo[@Type='StepInfo' and @Name='NbRepByStatus']/Children/ReportInfo[@Type='Status']) = 1">

                      <xsl:apply-templates select="/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/
									ReportInfo[@Type = 'MigrationStep' and @Name= 'ScopeBuild']/Children/ReportInfo[@Type='StepInfo' and @Name='NbRepByStatus']/Children/ReportInfo[@Type='Status']">
                        <xsl:with-param name="strStepType" select="'ScopeBuild'"/>
                        <xsl:with-param name="strDocType" select="$paramDocType"/>
                      </xsl:apply-templates>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:apply-templates select="/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/
									ReportInfo[@Type = 'MigrationStep' and @Name= 'ScopeBuild']/Children/ReportInfo[@Type='StepInfo' and @Name='NbRepByStatus']/Children/ReportInfo[@Type='Status' and @Name !='WarningPriv']">
                        <xsl:with-param name="strStepType" select="'ScopeBuild'"/>
                        <xsl:with-param name="strDocType" select="$paramDocType"/>
                      </xsl:apply-templates>
                    </xsl:otherwise>

                  </xsl:choose>

                </xsl:when>
                <xsl:when test="starts-with($paramDocType, 'FBDI') and $ConversionStatus = 'Interrupted' and $ScopeStatus != 'Error' ">
                  <td align = "left">
                    <img src = "Data\Rep_Status_Interrupted_Expand.png"></img>
                    <b class ="styleInterrupted">
                      <xsl:value-of select ="/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/
							ReportInfo[@Type = 'MigrationStep' and @Name= 'ScopeBuild']/Children/ReportInfo[@Type='StepInfo' and @Name='Output']/ReportInformation/Source"/>
                    </b>
                  </td>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:choose>
                    <!-- To manage the case where we have only 1 doc with a WarningPriv status.-->
                    <xsl:when test ="count(/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/
									ReportInfo[@Type = 'MigrationStep' and @Name= 'Conversion']/Children/ReportInfo[@Type='StepInfo' and @Name='NbRepByStatus']/Children/ReportInfo[@Type='Status']) = 1">

                      <xsl:apply-templates select="/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/
							ReportInfo[@Type = 'MigrationStep' and @Name= 'Conversion']/Children/ReportInfo[@Type='StepInfo' and @Name='NbRepByStatus']/Children/ReportInfo[@Type='Status']">
                        <xsl:with-param name="strStepType" select="'Conversion'"/>
                        <xsl:with-param name="strDocType" select="$paramDocType"/>
                      </xsl:apply-templates>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:apply-templates select="/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/
							ReportInfo[@Type = 'MigrationStep' and @Name= 'Conversion']/Children/ReportInfo[@Type='StepInfo' and @Name='NbRepByStatus']/Children/ReportInfo[@Type='Status' and @Name !='WarningPriv']">
                        <xsl:with-param name="strStepType" select="'Conversion'"/>
                        <xsl:with-param name="strDocType" select="$paramDocType"/>
                      </xsl:apply-templates>
                    </xsl:otherwise>

                  </xsl:choose>

                </xsl:otherwise>
              </xsl:choose>
              <td/>
              <!-- For Visual effet : Below transition arrow space-->
              <!-- *** Last Step : 
				 - Scope Builder report: None -> Output
				 - Rep Conversion/other report : Save Step
			-->
              <td align="center">
                <xsl:if test="not(starts-with($paramDocType, 'DBDI_Scope')) and $SaveStatus != 'Interrupted' and $SaveStatus != 'Skipped'">
                  <xsl:choose>
                    <xsl:when test =" $SaveStatus  = 'OK'">
                      <img src= "Data\Rep_Status_OK_expand.png" title="Save successful"/>
                      <b class="styleOK" title="Number of V6 objects created">
                        <xsl:value-of select ="$nbOfCreateV6Object"/>
                      </b>
                    </xsl:when>
                    <xsl:when test =" starts-with($SaveStatus,'Warning') or starts-with($SaveStatus,'Error')">
                      <img>
                        <xsl:attribute name = "onmouseover" >
                          toggle_Img_by_condition("<xsl:value-of select="concat('expandCollapseStepSave',$SaveStatus)"/>","toggle")
                        </xsl:attribute>
                        <xsl:attribute name = "onmouseout" >
                          toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseStepSave',$SaveStatus)"/>",'<xsl:value-of select="concat('expandCollapseTitleSave',$SaveStatus)"/>',"expandSameStateOrToggle")
                        </xsl:attribute>
                        <xsl:attribute name="id">
                          <xsl:value-of select="concat('expandCollapseStepSave',$SaveStatus)"/>
                        </xsl:attribute>
                        <xsl:attribute name="onclick">
                          toggle_visibility_by_condition('<xsl:value-of select="concat('summaryTable','Save')"/>','<xsl:value-of select="concat('summaryTable','Save')"/>','showOrToggle')
                          toggle_visibility_by_condition('<xsl:value-of select="concat('plusminus','Save')"/>','summaryTableSave','showOrToggle')
                          toggle_visibility_by_condition("<xsl:value-of select="concat('summaryTableTitleSave',$SaveStatus)"/>",'summaryTableSave','showOrToggle')
                          toggle_visibility_by_id('<xsl:value-of select="concat('summaryTableDetailSave',$SaveStatus)"/>','<xsl:value-of select="concat('expandCollapseTitleSave',$SaveStatus)"/>')
                          toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseStepSave',$SaveStatus)"/>",'<xsl:value-of select="concat('expandCollapseTitleSave',$SaveStatus)"/>',"expandSameStateOrToggle")
                          toggle_Img_by_condition('<xsl:value-of select="concat('expandCollapseMainStepSave',$SaveStatus)"/>',"showOnly")
                        </xsl:attribute>
                        <xsl:attribute name="class">clickable</xsl:attribute>
                        <xsl:if test=" starts-with($SaveStatus,'Warning')">
                          <xsl:attribute name = "src" >Data\Rep_Status_Warning_collapse.png</xsl:attribute>
                          <xsl:attribute name = "title" >Warning during save step</xsl:attribute>
                          <b class="styleWarning" title="Number of V6 objects created">
                            <xsl:value-of select ="$nbOfCreateV6Object"/>
                          </b>
                        </xsl:if>
                        <xsl:if test=" starts-with($SaveStatus,'Error')">
                          <xsl:attribute name = "src" >Data\Rep_Status_Error_collapse.png</xsl:attribute>
                          <xsl:attribute name = "title">Error during save step</xsl:attribute>
                          <b class="styleError" title="Number of V6 objects">
                            <xsl:value-of select ="$nbOfCreateV6Object"/>
                          </b>
                        </xsl:if>
                      </img>
                    </xsl:when>
                    <xsl:otherwise>
                      <img src= "Data\Rep_Status_Interrupted_expand.png" title="Interrupted"/>
                      <b class="styleInterrupted" title="Number of V6 objects">
                        <xsl:value-of select ="$nbOfCreateV6Object"/>
                      </b>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:if>
              </td>
            </tr>
          </xsl:if>
        </td>
      </tr>
    </table>

    <!-- Display warning/error views (table with the warning/error details) -->
    <br/>
    <table align="left" width = "100%">
      <tr>
        <!-- -SCOPE BUILDER -->
        <td>
          <xsl:apply-templates select="/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/
							ReportInfo[@Type = 'MigrationStep' and @Name= 'ScopeBuild']/Children/ReportInfo[@Type='StepInfo' and @Name='Content']"/>
        </td>
      </tr>
      <xsl:if test ="starts-with($paramDocType, 'FBDI') or (starts-with($paramDocType, 'DBDI_Scope') and( $ScopeStatus = 'Error' or $ScopeStatus = 'Warning')) or (starts-with($paramDocType, 'DBDI_Rep') and( $ScopeStatus = 'Error' or $ScopeStatus = 'Warning'))">
        <tr>
          <td>
            <xsl:call-template name="CreateTableForStep">
              <xsl:with-param name="stepType" select="'ScopeBuild'"/>
              <xsl:with-param name="docType" select="$paramDocType"/>
              <xsl:with-param name ="attributV6List" select ="/ReportInfo/Children/ReportInfo[@Type='document'][1]/Children/ReportInfo[@Type='DocInfo' and @Name='AttrV5TreeMask'][1]/Children/ReportInfo"/>
            </xsl:call-template>
          </td>
        </tr>
      </xsl:if>

      <xsl:if test="not(starts-with($paramDocType, 'FBDI_Split'))">
        <tr>
          <td>
            <!-- -CONVERSION -->
            <xsl:call-template name="CreateTableForStep">
              <xsl:with-param name="stepType" select="'Conversion'"/>
              <xsl:with-param name="docType" select="$paramDocType"/>
              <xsl:with-param name ="attributV6List" select ="/ReportInfo/Children/ReportInfo[@Type='document'][1]/Children/ReportInfo[@Type='DocInfo' and @Name='AttrV6TreeMask'][1]/Children/ReportInfo"/>
            </xsl:call-template>
          </td>
        </tr>
        <tr>
          <td>
            <!-- -SAVE -->
            <xsl:call-template name="CreateTableForStep">
              <xsl:with-param name="stepType" select="'Save'"/>
              <xsl:with-param name="docType" select="$paramDocType"/>
              <xsl:with-param name ="attributV6List" select ="/ReportInfo/Children/ReportInfo[@Type='document'][1]/Children/ReportInfo[@Type='DocInfo' and @Name='AttrV6TreeMask'][1]/Children/ReportInfo"/>
            </xsl:call-template>
          </td>
        </tr>
      </xsl:if>
    </table>
  </xsl:template>

  <!--****************************************************************
					Section CONTEXT Information
	**************************************************************** -->
  <xsl:template name="ContextInformation">
    <table border="1" cellspacing="1" cellpadding="3" align="center" class="objectFBDITable">
      <th class = "defaultMode">Options</th>
      <th class = "defaultMode">Value</th>
      <xsl:for-each select="//ReportInfo/Children/ReportInfo[@Type = 'ExecutionMode']">
        <tr >
          <td class="defaultMode">
            <xsl:value-of select="ReportInformation/Source"/>
          </td>
          <td class="defaultMode">
            <xsl:value-of select="ReportInformation/Details/Detail"/>
          </td>
        </tr>
      </xsl:for-each>
      <xsl:for-each select="//ReportInfo/Children/ReportInfo[@Type = 'CheckMode']">
        <tr >
          <td class="defaultMode">
            <xsl:value-of select="ReportInformation/Source"/>
          </td>
          <td class="defaultMode">
            <xsl:value-of select="ReportInformation/Details/Detail"/>
          </td>
        </tr>
      </xsl:for-each>
      <!--************** To remove after FBDI_InternalDS_ReplaceEvolution208 removal **************-->
      <xsl:for-each select="//ReportInfo/Children/ReportInfo[@Type = 'SimilarDocumentsOptions']">
        <tr>
          <td class="defaultMode">
            <xsl:value-of select="ReportInformation/Source"/>
          </td>
          <td class="defaultMode">
            <xsl:value-of select="ReportInformation/Details/Detail"/>
          </td>
        </tr>
      </xsl:for-each>
      <!--************** End of To remove after FBDI_InternalDS_ReplaceEvolution208 removal **************-->
      <xsl:for-each select="//ReportInfo/Children/ReportInfo[@Type = 'SimilarDocumentsOptionsTitle']">
        <tr>
          <td class="defaultMode">
            <xsl:value-of select="ReportInformation/Source"/>
            <br />
            <xsl:for-each select="//ReportInfo/Children/ReportInfo[@Type = 'NewerSimilarDocOption']">
              <xsl:value-of select="ReportInformation/Source"/>
            </xsl:for-each>
            <br />
            <xsl:for-each select="//ReportInfo/Children/ReportInfo[@Type = 'IdenticalSimilarDocOption']">
              <xsl:value-of select="ReportInformation/Source"/>
            </xsl:for-each>
            <br />
            <xsl:for-each select="//ReportInfo/Children/ReportInfo[@Type = 'OlderSimilarDocOption']">
              <xsl:value-of select="ReportInformation/Source"/>
            </xsl:for-each>
          </td>
          <td class="defaultMode">
            <br />
            <xsl:for-each select="//ReportInfo/Children/ReportInfo[@Type = 'NewerSimilarDocOption']">
              <xsl:value-of select="ReportInformation/Details/Detail"/>
            </xsl:for-each>
            <br />
            <xsl:for-each select="//ReportInfo/Children/ReportInfo[@Type = 'IdenticalSimilarDocOption']">
              <xsl:value-of select="ReportInformation/Details/Detail"/>
            </xsl:for-each>
            <br />
            <xsl:for-each select="//ReportInfo/Children/ReportInfo[@Type = 'OlderSimilarDocOption']">
              <xsl:value-of select="ReportInformation/Details/Detail"/>
            </xsl:for-each>
          </td>
        </tr>
      </xsl:for-each>
      <xsl:for-each select="//ReportInfo/Children/ReportInfo[@Type = 'MainMappingEnvironment']">
        <tr>
          <td class="defaultMode">
            <xsl:value-of select="ReportInformation/Source"/>
          </td>
          <td class="defaultMode">
            <xsl:value-of select="ReportInformation/Details/Detail"/>
          </td>
        </tr>
      </xsl:for-each>
      <xsl:for-each select="//ReportInfo/Children/ReportInfo[@Type = 'MappingEnvironmentFriends']">
        <tr>
          <td class="defaultMode">
            <xsl:value-of select="ReportInformation/Source"/>
          </td>
          <td class="defaultMode">
            <xsl:for-each select="ReportInformation/Details/Detail">
              <xsl:apply-templates/>
              <br />
            </xsl:for-each>
          </td>
        </tr>
      </xsl:for-each>
      <xsl:for-each select="//ReportInfo/Children/ReportInfo[@Type = 'IsolationMode']">
        <tr>
          <td class="defaultMode">

            <xsl:value-of select="ReportInformation/Source"/>
          </td>
          <td class="defaultMode">
            <xsl:value-of select="ReportInformation/Details/Detail"/>
          </td>
        </tr>
      </xsl:for-each>
      <xsl:for-each select="//ReportInfo/Children/ReportInfo[@Type = 'LightMode']">
        <tr>
          <td class="defaultMode">

            <xsl:value-of select="ReportInformation/Source"/>
          </td>
          <td class="defaultMode">
            <xsl:value-of select="ReportInformation/Details/Detail"/>
          </td>
        </tr>
      </xsl:for-each>
      <xsl:for-each select="//ReportInfo/Children/ReportInfo[@Type = 'V5NativeMode']">
        <tr>
          <td class="defaultMode">
            <xsl:value-of select="ReportInformation/Source"/>
          </td>
          <td class="defaultMode">
            <xsl:value-of select="ReportInformation/Details/Detail"/>
          </td>
        </tr>
      </xsl:for-each>
      <xsl:for-each select="//ReportInfo/Children/ReportInfo[@Type = 'Versioning']">
        <tr>
          <td class="defaultMode">

            <xsl:value-of select="ReportInformation/Source"/>
          </td>
          <td class="defaultMode">
            <xsl:value-of select="ReportInformation/Details/Detail"/>
          </td>
        </tr>
      </xsl:for-each>
      <xsl:for-each select="//ReportInfo/Children/ReportInfo[@Type = 'EnvtVariables']">
        <tr>
          <td class="defaultMode">
            <xsl:value-of select="ReportInformation/Source"/>
          </td>
          <td class="defaultMode">
            <xsl:for-each select="ReportInformation/Details/Detail">
              <xsl:apply-templates/>
              <br />
            </xsl:for-each>
          </td>
        </tr>
      </xsl:for-each>
      <xsl:for-each select="//ReportInfo/Children/ReportInfo[@Type = 'ImportApplication']">
        <tr>
          <td class="defaultMode">
            <xsl:value-of select="ReportInformation/Source"/>
          </td>
          <td class="defaultMode">
            <xsl:for-each select="ReportInformation/Details/Detail">
              <xsl:apply-templates/>
              <br />
            </xsl:for-each>
          </td>
        </tr>
      </xsl:for-each>
      <xsl:for-each select="//ReportInfo/Children/ReportInfo[@Type = 'DesignerWorkspace']">
        <tr>
          <td class="defaultMode">
            <xsl:value-of select="ReportInformation/Source"/>
          </td>
          <td class="defaultMode">
            <xsl:value-of select="ReportInformation/Details/Detail"/>
          </td>
        </tr>
      </xsl:for-each>
      <!--Rows specific to Split-->
      <xsl:for-each select="//ReportInfo/Children/ReportInfo[@Type = 'SplitImportMode']">
        <tr>
          <td class="defaultMode">
            <xsl:value-of select="ReportInformation/Source"/>
          </td>
          <td class="defaultMode">
            <xsl:value-of select="ReportInformation/Details/Detail"/>
          </td>
        </tr>
      </xsl:for-each>
      <xsl:for-each select="//ReportInfo/Children/ReportInfo[@Type = 'SplitMaxNumberOfDocuments']">
        <tr>
          <td class="defaultMode">
            <xsl:value-of select="ReportInformation/Source"/>
          </td>
          <td class="defaultMode">
            <xsl:value-of select="ReportInformation/Details/Detail"/>
          </td>
        </tr>
      </xsl:for-each>
      <xsl:for-each select="//ReportInfo/Children/ReportInfo[@Type = 'SplitMaxSizeOfDocuments']">
        <tr>
          <td class="defaultMode">
            <xsl:value-of select="ReportInformation/Source"/>
          </td>
          <td class="defaultMode">
            <xsl:value-of select="ReportInformation/Details/Detail"/>
          </td>
        </tr>
      </xsl:for-each>
      <!--End of Rows specific to Split-->
    </table>
  </xsl:template>

  <!--****************************************************************
					Save DETAILS Information
	**************************************************************** -->

  <xsl:template name="SaveInformation">

    <table border="1" cellspacing="1" cellpadding="3" align="center" class="objectFBDITable">
      <th class = "defaultMode">Roots</th>
      <th class = "defaultMode">
        <xsl:value-of select = "//ReportInfo/Children/ReportInfo/Children/ReportInfo/Children/ReportInfo[@Type = 'AttributeName']"/>
      </th>
      <xsl:for-each select="//ReportInfo/Children/ReportInfo/Children/ReportInfo/Children/ReportInfo[@Type = 'Attribute']">
        <tr >
          <td class ="defaultMode" align="center">
            <xsl:value-of select="@Name"/>
          </td>
          <td class="defaultMode" align="center">
            <xsl:value-of select="ReportInformation/Source"/>
          </td>
        </tr>
      </xsl:for-each>
    </table>
  </xsl:template>
  <!--****************************************************************
					Section DETAILS Information
	**************************************************************** -->
  <xsl:template name="DetailInfo">
    <xsl:param name="paramDocType"/>

    <!-- Variable-->
    <xsl:variable name="AttributV5List" select ="/ReportInfo/Children/ReportInfo[@Type='document']/Children/ReportInfo[@Type='DocInfo' and @Name='AttrV5TreeMask']
													/Children/ReportInfo[@Type='Attribut'][not(./@Name = preceding::ReportInfo[@Type='Attribut']/@Name)]"/>
    <xsl:variable name="AttributV6List" select ="/ReportInfo/Children/ReportInfo[@Type='document'][1]/Children/ReportInfo[@Type='DocInfo' and @Name='AttrV6TreeMask'][1]/Children/ReportInfo"/>

    <xsl:variable name ="nbOfAttribut">
      <xsl:choose>
        <xsl:when test ="starts-with($paramDocType, 'DBDI_Scope_Native')">
          <xsl:value-of select ="count($AttributV6List)"/>
        </xsl:when>
        <xsl:when test ="starts-with($paramDocType, 'DBDI_Scope')">
          <xsl:value-of select ="count($AttributV5List)+1"/>
        </xsl:when>
        <xsl:when test ="starts-with($paramDocType, 'DBDI_Rep')">
          <xsl:value-of select ="count($AttributV6List)"/>
        </xsl:when>
        <xsl:otherwise>2</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name ="V5inV6Certified">
      <xsl:choose>
        <xsl:when test="/ReportInfo/Children/ReportInfo[@Type='document']/Children/ReportInfo[@Type='DocInfo' and @Name='V5inV6Certified']">
          <xsl:value-of select="'Certified'"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="'NotCertified'"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>



    <!-- Expand options -->
    <xsl:if test ="not(starts-with($paramDocType, 'DBDI_Scope')) 
				or (
						count(//ReportInfo[@Type='MigrationProcess']/Children/descendant::ReportInfo[@Type='RaisedMsg' and @Status != 'OK' and @Status != 'Interrupted'])  > 0
					or	count(//ReportInfo[@Type='DocInfo' and @Name ='IndexOfPointingRep']) > 0
					or	count(//ReportInfo[@Type='DocInfo' and @Name ='IndexOfPointedRep']) > 0
											)">
      <xsl:call-template name="createExpandCollapse">
        <xsl:with-param name ="strDocType" select="$paramDocType"/>
      </xsl:call-template>
    </xsl:if>

    <br/>

    <!-- Details table -->
    <table cellspacing="1" cellpadding="3" align="center" class="objectFBDITable">
      <!-- Here we manage 2 distincts way of display the data: With or without scope level -->
      <xsl:choose>
        <xsl:when test="/ReportInfo/Children/ReportInfo[@Type='document']/Children/ReportInfo[@Type='DocInfo' and @Name='ScopeLevel']">
          <!-- Table header -->
          <!-- For the Expand/Collapse icon -->
          <th/>
          <xsl:if test="starts-with($paramDocType ,'DBDI_Scope') or starts-with($paramDocType, 'FBDI')">
            <th class="defaultMode">Scope Level</th>
          </xsl:if>
          <th class="defaultMode">Execution Mode</th>
          <xsl:choose>
            <xsl:when test="starts-with($paramDocType ,'DBDI_Scope')">
              <th class="defaultMode">Package n°</th>
              <th class="defaultMode">Scope build status</th>
              <th class="defaultMode">Type</th>
            </xsl:when>
            <xsl:when test="starts-with($paramDocType, 'FBDI_Split')">
              <th class="defaultMode">Package n°</th>
              <th class="defaultMode">Scope build status</th>
            </xsl:when>
            <xsl:when test="starts-with($paramDocType ,'FBDI')">
              <th class="defaultMode">Status</th>
            </xsl:when>
            <xsl:otherwise>
              <th class="defaultMode">Conversion status</th>
            </xsl:otherwise>
          </xsl:choose>
          <!-- Representation/Document title-->
          <th class="defaultMode">
            <xsl:attribute name="colspan">
              <xsl:value-of select="$nbOfAttribut"/>
            </xsl:attribute>
            <xsl:if test="starts-with($paramDocType, 'FBDI')">Document</xsl:if>
            <xsl:if test="starts-with($paramDocType, 'DBDI')">Representation</xsl:if>
          </th>
          <!-- For DBDI report, title level 2 row such as the name of the attributs defined by the mask tree -->
          <xsl:if test ="starts-with($paramDocType, 'DBDI')" >
            <tr>
              <td/>
              <xsl:choose>
                <xsl:when test="starts-with($paramDocType ,'DBDI_Scope')">
                  <td class ="unUsedTitleCell">&#160;</td>
                  <!--td class ="defaultModeLesserTitle"><b>Scope level</b></td-->
                  <td class ="unUsedTitleCell">&#160;</td>
                  <td class ="unUsedTitleCell">&#160;</td>
                  <td class ="unUsedTitleCell">&#160;</td>
                  <td class ="unUsedTitleCell">&#160;</td>
                  <xsl:for-each select ="$AttributV5List">
                    <td class ="defaultModeLesserTitle">
                      <b>
                        <xsl:value-of select="@Name"/>
                      </b>
                    </td>
                  </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                  <td class ="unUsedTitleCell">&#160;</td>
                  <td class ="unUsedTitleCell">&#160;</td>
                  <xsl:for-each select ="$AttributV6List">
                    <td class ="defaultModeLesserTitle">
                      <b>
                        <xsl:value-of select="@Name"/>
                      </b>
                    </td>
                  </xsl:for-each>
                </xsl:otherwise>
              </xsl:choose>
            </tr>
          </xsl:if>
        </xsl:when>
        <xsl:otherwise>
          <!-- Table header -->
          <th/>
          <!-- Representation/Document title-->
          <th class="defaultMode">
            <xsl:attribute name="colspan">
              <xsl:value-of select="$nbOfAttribut"/>
            </xsl:attribute>
            <xsl:if test="starts-with($paramDocType, 'FBDI')">Document</xsl:if>
            <xsl:if test="starts-with($paramDocType, 'DBDI')">Representation</xsl:if>
          </th>

          <th class="defaultMode">Execution Mode</th>
          <xsl:if test="starts-with($V5inV6Certified, 'Certified')">
            <th class="defaultMode">V5in3DEXPERIENCE Certified</th>
          </xsl:if>
          <xsl:choose>
            <xsl:when test="starts-with($paramDocType ,'DBDI_Scope')  or starts-with($paramDocType, 'FBDI_Split')">
              <th class="defaultMode">Package n°</th>
              <th class="defaultMode">Scope build status</th>
            </xsl:when>
            <xsl:when test="starts-with($paramDocType ,'FBDI')">
              <th class="defaultMode">Status</th>
            </xsl:when>
            <xsl:otherwise>
              <th class="defaultMode">Conversion status</th>
            </xsl:otherwise>
          </xsl:choose>

          <!-- For DBDI report, title level 2 row such as the name of the attributs defined by the mask tree -->
          <xsl:if test ="starts-with($paramDocType, 'DBDI')" >
            <tr>
              <td/>
              <xsl:choose>
                <xsl:when test="starts-with($paramDocType ,'DBDI_Scope_Native')">
                  
                  <xsl:for-each select ="$AttributV6List">
                    <td class ="defaultModeLesserTitle">
                      <b>
                        <xsl:value-of select="@Name"/>
                      </b>
                    </td>
                  </xsl:for-each>
                  <td class ="unUsedTitleCell">&#160;</td>
                </xsl:when>
                <xsl:when test="starts-with($paramDocType ,'DBDI_Scope')">
                  <td class ="unUsedTitleCell">&#160;</td>
                  <xsl:for-each select ="$AttributV5List">
                    <td class ="defaultModeLesserTitle">
                      <b>
                        <xsl:value-of select="@Name"/>
                      </b>
                    </td>
                  </xsl:for-each>
                  <td class ="unUsedTitleCell">&#160;</td>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:for-each select ="$AttributV6List">
                    <td class ="defaultModeLesserTitle">
                      <b>
                        <xsl:value-of select="@Name"/>
                      </b>
                    </td>
                  </xsl:for-each>
                </xsl:otherwise>
              </xsl:choose>
              <td class ="unUsedTitleCell">&#160;</td>
              <td class ="unUsedTitleCell">&#160;</td>
            </tr>
          </xsl:if>
        </xsl:otherwise>
      </xsl:choose>

      <!-- Fill the table with the xml content -->
      <xsl:apply-templates select="/ReportInfo/Children/ReportInfo[@Type='document']">
        <xsl:with-param name="docType" select="$paramDocType"/>
        <xsl:with-param name="reportName" select="//ReportInfo/ReportInformation/Details/Detail"/>
        <xsl:with-param name="nbOfAttribut" select="$nbOfAttribut"/>
        <xsl:with-param name="V5inV6Certified" select="$V5inV6Certified"/>
      </xsl:apply-templates>
    </table>
  </xsl:template>

  <!--****************************************************************
	  Function : loop on the queue package
	**************************************************************** -->
  <xsl:template name="for.loop">
    <xsl:param name="i" />
    <xsl:param name="count" />

    <!--begin_: Line_by_Line_Output -->
    <xsl:if test="$i &lt;= $count">
      <tr>
        <td/>
        <td class="queuedPackage" align ="center">
          <xsl:value-of select="$i"/>
        </td>
        <td class="queuedPackage" align ="center">-</td>
        <td class="queuedPackage" align ="center">-</td>
        <td class="queuedPackage" align ="center">-</td>
        <td class="queuedPackage" align ="center">-</td>
        <td class="queuedPackage" align ="center">-</td>
      </tr>
    </xsl:if>

    <!--begin_: RepeatTheLoopUntilFinished-->
    <xsl:if test="$i &lt;= $count">
      <xsl:call-template name="for.loop">
        <xsl:with-param name="i">
          <xsl:value-of select="$i + 1"/>
        </xsl:with-param>
        <xsl:with-param name="count">
          <xsl:value-of select="$count"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>


  <!--******************************************************************************************
	 TEMPLATE pour traiter les details des documents: Nom du document, Execution mode, Status 
	 Correspond aux documents 
	******************************************************************************************-->

  <!--****************************************************************
	  FOR DETAIL SECTION : Affiche les lignes principales correspondant a chaque documents 
	  (nom, statut, mode d import etc.)	
	**************************************************************** -->
  <!--[/ReportInfo/Children/ReportInfo] template -->
  <xsl:template match="/ReportInfo/Children/ReportInfo">
    <xsl:param name="docType"/>
    <xsl:param name="reportName"/>
    <xsl:param name="nbOfAttribut"/>
    <xsl:param name="V5inV6Certified"/>


    <!-- [/ReportInfo/Children/ReportInfo] template : ZONE VARIABLE-->
    <xsl:variable name ="docPath" select="ReportInformation/Source"/>
    <xsl:variable name ="docName">
      <xsl:call-template name='strip-path'>
        <xsl:with-param name='path' select='$docPath' />
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name ="detailStatus">
      <xsl:choose>
        <xsl:when test="@Status = 'Unknown'">
          <xsl:value-of select="Error"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:choose>
            <xsl:when test = "@Status = 'WarningPriv' " >
              <xsl:value-of select="'OK'"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="@Status"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name ="migrationTagNumber" select ="./LinkInformation/MigrationTagName"/>


    <xsl:variable name ="migrationTagStr" select ="concat('Document_',$migrationTagNumber)"/>
    <xsl:variable name ="detailId" select ="concat('Detail',$migrationTagStr)"/>
    <xsl:variable name ="detailName" select="concat('detail',$detailStatus,./LinkInformation/MigrationTagName)"/>
    <xsl:variable name ="expandCollapseName" select="concat('expandCollapseDetail',$migrationTagStr)"/>

    <xsl:variable name ="detailString" select="	ReportInformation/Details"/>

    <xsl:variable name ="stepName">
      <xsl:choose>
        <xsl:when test="starts-with($docType, 'DBDI_Scope')" >ScopeBuild</xsl:when>
        <xsl:otherwise>Conversion</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="AttributV5List" select ="./Children/ReportInfo[@Type='DocInfo' and @Name='AttrV5TreeMask']/Children/ReportInfo[@Type='Attribut']"/>
    <xsl:variable name="AttributV6List" select ="./Children/ReportInfo[@Type='DocInfo' and @Name='AttrV6TreeMask']/Children/ReportInfo[@Type='Attribut']"/>
    <!--xsl:variable name="AttributGlobalList" select="/ReportInfo/Children/ReportInfo[@Type='document']/Children/ReportInfo[@Type='DocInfo' and @Name='AttrV5TreeMask']/Children/ReportInfo[@Type='Attribut']/@Name
				[not(. = preceding::ReportInfo[@Type='DocInfo' and @Name='AttrV5TreeMask']/Children/ReportInfo[@Type='Attribut']/@Name)]"/-->

    <!--****************************************************************
	  If in FBDI split mode, in the report of each individual package, no need to add pointing-pointed information	
	**************************************************************** -->
    <xsl:variable name ="isPointedBy" select ="(./Children/ReportInfo[@Type='DocInfo' and @Name ='IndexOfPointingRep'][1] ) and (not (starts-with($docType, 'FBDI') and (/ReportInfo
                  /Children/ReportInfo[@Type = 'DocInfo' and @Name='PackageNum'])))"/>
    <xsl:variable name ="isPointing" select ="(./Children/ReportInfo[@Type='DocInfo' and @Name ='IndexOfPointedRep'][1] ) and (not (starts-with($docType, 'FBDI') and (/ReportInfo
                  /Children/ReportInfo[@Type = 'DocInfo' and @Name='PackageNum'])))"/>
    <xsl:variable name ="isWarning">
      <xsl:value-of select ="count(./Children/ReportInfo[@Type='MigrationProcess']/Children
											/descendant::ReportInfo[@Type='RaisedMsg' and @Status ='Warning'  and not(@View = '1')])"/>
    </xsl:variable>
    <xsl:variable name ="isError">
      <xsl:value-of select ="count(./Children/ReportInfo[@Type='MigrationProcess']/Children
											/descendant::ReportInfo[@Type='RaisedMsg' and @Status ='Error'  and not(@View = '1')])"/>
    </xsl:variable>
    <xsl:variable name ="labelName" select="./Children/ReportInfo[@Type='DocInfo' and @Name='ScopeLevel']/ReportInformation/Source"/>

    <!-- [/ReportInfo/Children/ReportInfo] template : FIN ZONE VARIABLE-->

    <!-- Display the main information about the document import : name of document, its status, its execution mode, etc. -->
    <label>
      <xsl:attribute name="name">
        <xsl:value-of select="$labelName"/>
      </xsl:attribute>
      <!-- [/ReportInfo/Children/ReportInfo] template/[ROW 1]: display row 1 -->
      <tr>
        <A>
          <xsl:attribute name="name">
            <xsl:value-of select="$migrationTagStr"/>
          </xsl:attribute>
        </A>
        <!-- [/ReportInfo/Children/ReportInfo] template/[ROW 1]/[EXPAND ARROW]: display expand arrow-->
        <xsl:choose>
          <xsl:when test="not(starts-with($docType, 'DBDI_Scope')) or ($isPointedBy or $isPointing or $isWarning>0 or $isError>0)">
            <xsl:choose>
              <xsl:when test="starts-with($docType ,'DBDI_Scope')">
                <td class ="clickable">
                  <xsl:attribute name="onclick">
                    toggle_visibility_by_id("<xsl:value-of select="$detailId"/>","<xsl:value-of select="$expandCollapseName"/>")
                    <xsl:if test ="$isPointedBy">
                      toggle_visibility_by_condition("<xsl:value-of select="concat('detailPointed By',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseTitlePointed By',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseDetailPointed By',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                    </xsl:if>
                    <xsl:if test ="$isPointing">
                      toggle_visibility_by_condition("<xsl:value-of select="concat('detailPointing',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseTitlePointing',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseDetailPointing',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                    </xsl:if>
                    <xsl:if test ="$isWarning >0 ">
                      <!--toggle_visibility_by_condition("<xsl:value-of select="$detailTitleWarning"/>","<xsl:value-of select="$detailId"/>","showOrToggle")	-->
                      toggle_visibility_by_condition("<xsl:value-of select="concat('detailWarning',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseTitleWarning',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseDetailWarning',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                    </xsl:if>
                    <xsl:if test ="$isError > 0">
                      <!--toggle_visibility_by_condition("<xsl:value-of select="$detailTitleError"/>","<xsl:value-of select="$detailId"/>","showOrToggle")	-->
                      toggle_visibility_by_condition("<xsl:value-of select="concat('detailError',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseTitleError',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseDetailError',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                    </xsl:if>
                  </xsl:attribute>
                  <img src="Data\expandArrow.png">
                    <xsl:attribute name="id">
                      <xsl:value-of select="$expandCollapseName"/>
                    </xsl:attribute>
                  </img>
                </td>
              </xsl:when>
              <xsl:otherwise>
                <td class ="clickable">
                  <xsl:attribute name="onclick">
                    toggle_visibility_by_id("<xsl:value-of select="$detailId"/>","<xsl:value-of select="$expandCollapseName"/>")
                    <xsl:if test ="$isWarning >0 ">
                      toggle_visibility_by_condition("<xsl:value-of select="concat('detailWarning',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseTitleWarning',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseDetailWarning',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                    </xsl:if>
                    <xsl:if test ="$isError > 0">
                      toggle_visibility_by_condition("<xsl:value-of select="concat('detailError',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseTitleError',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseDetailError',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                    </xsl:if>
                  </xsl:attribute>
                  <img src="Data\expandArrow.png">
                    <xsl:attribute name="id">
                      <xsl:value-of select="$expandCollapseName"/>
                    </xsl:attribute>
                  </img>
                </td>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>
            <td/>
          </xsl:otherwise>
        </xsl:choose>
        <!-- END [/ReportInfo/Children/ReportInfo] template /[ROW 1]/[EXPAND ARROW]-->

        <!-- [/ReportInfo/Children/ReportInfo] template /[ROW 1]/[SCOPE LEVEL]: display scopelevel or initialscope -->
        <xsl:if test="starts-with($docType, 'DBDI_Scope') or starts-with($docType, 'FBDI')" >
          <xsl:choose>
            <xsl:when test = "./Children/ReportInfo[@Type='DocInfo' and @Name='InitialScope'] and not(./Children/ReportInfo[@Type='DocInfo' and @Name='ScopeLevel'])">
              <td class="defaultMode " align="center">
                <!-- InitialScope if in ScopeBuilder -->
                <img src="Data/SB_Initial.png" title="Initial Scope"/>
              </td>
            </xsl:when>
            <xsl:when test = "./Children/ReportInfo[@Type='DocInfo' and @Name='ScopeLevel']">
              <td class="defaultMode " align="center">
                <!-- InitialScope if in ScopeBuilder -->
                <xsl:value-of  select="./Children/ReportInfo[@Type='DocInfo' and @Name='ScopeLevel']/ReportInformation/Source" />
              </td>
            </xsl:when>
			<xsl:when test="starts-with($docType, 'DBDI_Scope_Native')">			
			</xsl:when>
            <xsl:otherwise>
              <td class="defaultMode" align ="center">
                &#160;
              </td>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>
        <!-- END[/ReportInfo/Children/ReportInfo] template /[ROW 1]/[SCOPE LEVEL]-->

        <!--  Gestion de l'affichage du scope level et du réordonnancement des colonnes : -->
        <xsl:if test="./Children/ReportInfo[@Type='DocInfo' and @Name='ScopeLevel']">
          <!-- [/ReportInfo/Children/ReportInfo] template /[ROW 1]/[IMPORT MODE]: display Import mode -->
          <td class="defaultModeHighlight" align="center">
            <table>
              <tr>
                <td class="defaultModeHighlight2" align="center">
                  <xsl:choose>
                    <xsl:when test ="./Children/ReportInfo[@Type='DocInfo' and @Name ='ExecutionMode']">
                      <xsl:value-of select="./Children/ReportInfo[@Type='DocInfo' and @Name ='ExecutionMode']/ReportInformation/Details/Detail"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:choose>
                        <xsl:when test ="../ReportInfo[@Type='document' and @Status ='Skipped']">NoImport</xsl:when>
                        <xsl:otherwise>&#160;</xsl:otherwise>
                      </xsl:choose>
                    </xsl:otherwise>
                  </xsl:choose>
                </td>
              </tr>
              <tr>
                <td  class="pointingModeLesserTitle2" align="center">
                  <xsl:attribute name="title">
                    <xsl:value-of select="./Children/ReportInfo[@Type='DocInfo' and @Name ='WhyThisChoice']/ReportInformation/Details/Detail"/>
                  </xsl:attribute>
                  <i>
                    <xsl:value-of select="./Children/ReportInfo[@Type='DocInfo' and @Name ='WhyThisChoice']/ReportInformation/Source"/>
                  </i>
                </td>
              </tr>
            </table>
          </td>
          <!-- END[/ReportInfo/Children/ReportInfo] template /[ROW 1]/[IMPORT MODE] -->

          <!-- [/ReportInfo/Children/ReportInfo] template /[ROW 1]/[PACKAGE NUMBERS-IMPORTSTATUS]:
					Package numbers (Split mode only)
					and Import status.
				-->

          <xsl:if test="starts-with($docType, 'DBDI_Scope') or starts-with($docType, 'FBDI_Split')">
            <!-- Package Number-->
            <td class="defaultMode" align ="center">
              <xsl:value-of select="./LinkInformation/MigrationReportName"/>
            </td>
          </xsl:if>

          <!-- Pointing/Pointed RepImport Status-->
          <xsl:apply-templates select="./Children/ReportInfo[@Type='MigrationProcess']">
            <xsl:with-param name ="migrationTagNb" select ="./LinkInformation/MigrationTagName"/>
          </xsl:apply-templates>
          <!-- rep type-->
          <xsl:if test="starts-with($docType, 'DBDI_Scope')">
            <td class="defaultMode" align ="center">
              <xsl:value-of select="./Children/ReportInfo[@Type='DocInfo' and @Name ='RepType']/ReportInformation/Source"/>
            </td>
          </xsl:if>
          <!-- END[/ReportInfo/Children/ReportInfo] template /[ROW 1]/[PACKAGE NUMBERS-IMPORTSTATUS] -->
        </xsl:if>
        <!-- Document/Rep name -->
        <xsl:choose>
          <xsl:when test="starts-with($docType ,'DBDI_Scope_Native')">
            <xsl:for-each select ="$AttributV6List">
              <td  align ="center" class="defaultMode">
                <xsl:if test="./Children/ReportInfo[@Type='DocInfo' and @Name='SourceIdent']/ReportInformation/Source or $isPointedBy or $isPointing or $isWarning >0 or $isError > 0">
                  <xsl:attribute name="class">
                    defaultMode clickable
                  </xsl:attribute>
                  <!--<xsl:if test="position() =1">-->
                  <!--<xsl:attribute name = "onmouseover" >this.className='defaultMode clickable';</xsl:attribute>			-->
                  <!--<xsl:attribute name = "onmouseout" >this.className='defaultMode ';</xsl:attribute>	-->
                  <xsl:attribute name="onclick">
                    toggle_visibility_by_id("<xsl:value-of select="$detailId"/>","<xsl:value-of select="$expandCollapseName"/>")
                    <xsl:if test ="$isPointedBy">
                      <!--toggle_visibility_by_condition("<xsl:value-of select="$detailTitlePointedBy"/>","<xsl:value-of select="$detailId"/>","showOrToggle")	-->
                      toggle_visibility_by_condition("<xsl:value-of select="concat('detailPointed By',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseTitlePointed By',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseDetailPointed By',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                    </xsl:if>
                    <xsl:if test ="$isPointing">
                      <!--toggle_visibility_by_condition("<xsl:value-of select="$detailTitlePointing"/>","<xsl:value-of select="$detailId"/>","showOrToggle")	-->
                      toggle_visibility_by_condition("<xsl:value-of select="concat('detailPointing',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseTitlePointing',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseDetailPointing',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                    </xsl:if>
                    <xsl:if test ="$isWarning >0 ">
                      <!--toggle_visibility_by_condition("<xsl:value-of select="$detailTitleWarning"/>","<xsl:value-of select="$detailId"/>","showOrToggle")	-->
                      toggle_visibility_by_condition("<xsl:value-of select="concat('detailWarning',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseTitleWarning',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseDetailWarning',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                    </xsl:if>
                    <xsl:if test ="$isError > 0">
                      <!--toggle_visibility_by_condition("<xsl:value-of select="$detailTitleError"/>","<xsl:value-of select="$detailId"/>","showOrToggle")	-->
                      toggle_visibility_by_condition("<xsl:value-of select="concat('detailError',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseTitleError',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseDetailError',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                    </xsl:if>
                  </xsl:attribute>
                  <!--xsl:attribute name="class"> defaultMode clickable</xsl:attribute>-->
                  <!--</xsl:if>	-->
                </xsl:if>
                <xsl:value-of select="./ReportInformation/Source"/>
                <xsl:if test = "string-length(ReportInformation/Source/text()) = 0">
                  &#160;
                </xsl:if>
              </td>
            </xsl:for-each>
            <xsl:if test =" not(count($AttributV6List) = $nbOfAttribut) ">
              <td  align ="center" class="defaultMode">
                <xsl:if test="./Children/ReportInfo[@Type='DocInfo' and @Name='SourceIdent']/ReportInformation/Source or $isPointedBy or $isPointing or $isWarning >0 or $isError > 0">
                  <xsl:attribute name="class">
                    defaultMode clickable
                  </xsl:attribute>
                  <xsl:attribute name="onclick">
                    toggle_visibility_by_id("<xsl:value-of select="$detailId"/>","<xsl:value-of select="$expandCollapseName"/>")
                    <xsl:if test ="$isPointedBy">
                      toggle_visibility_by_condition("<xsl:value-of select="concat('detailPointed By',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseTitlePointed By',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseDetailPointed By',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                    </xsl:if>
                    <xsl:if test ="$isPointing">
                      toggle_visibility_by_condition("<xsl:value-of select="concat('detailPointing',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseTitlePointing',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseDetailPointing',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                    </xsl:if>
                    <xsl:if test ="$isWarning >0 ">
                      toggle_visibility_by_condition("<xsl:value-of select="concat('detailWarning',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseTitleWarning',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseDetailWarning',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                    </xsl:if>
                    <xsl:if test ="$isError > 0">
                      toggle_visibility_by_condition("<xsl:value-of select="concat('detailError',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseTitleError',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseDetailError',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                    </xsl:if>
                  </xsl:attribute>
                </xsl:if>
                &#160;
              </td>
            </xsl:if>
          </xsl:when>
          <xsl:when test="starts-with($docType ,'DBDI_Scope')">
            <xsl:for-each select ="$AttributV5List">
              <td  align ="center" class="defaultMode">
                <xsl:if test="./Children/ReportInfo[@Type='DocInfo' and @Name='SourceIdent']/ReportInformation/Source or $isPointedBy or $isPointing or $isWarning >0 or $isError > 0">
                  <xsl:attribute name="class">
                    defaultMode clickable
                  </xsl:attribute>
                  <!--<xsl:if test="position() =1">-->
                  <!--<xsl:attribute name = "onmouseover" >this.className='defaultMode clickable';</xsl:attribute>			-->
                  <!--<xsl:attribute name = "onmouseout" >this.className='defaultMode ';</xsl:attribute>	-->
                  <xsl:attribute name="onclick">
                    toggle_visibility_by_id("<xsl:value-of select="$detailId"/>","<xsl:value-of select="$expandCollapseName"/>")
                    <xsl:if test ="$isPointedBy">
                      <!--toggle_visibility_by_condition("<xsl:value-of select="$detailTitlePointedBy"/>","<xsl:value-of select="$detailId"/>","showOrToggle")	-->
                      toggle_visibility_by_condition("<xsl:value-of select="concat('detailPointed By',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseTitlePointed By',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseDetailPointed By',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                    </xsl:if>
                    <xsl:if test ="$isPointing">
                      <!--toggle_visibility_by_condition("<xsl:value-of select="$detailTitlePointing"/>","<xsl:value-of select="$detailId"/>","showOrToggle")	-->
                      toggle_visibility_by_condition("<xsl:value-of select="concat('detailPointing',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseTitlePointing',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseDetailPointing',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                    </xsl:if>
                    <xsl:if test ="$isWarning >0 ">
                      <!--toggle_visibility_by_condition("<xsl:value-of select="$detailTitleWarning"/>","<xsl:value-of select="$detailId"/>","showOrToggle")	-->
                      toggle_visibility_by_condition("<xsl:value-of select="concat('detailWarning',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseTitleWarning',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseDetailWarning',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                    </xsl:if>
                    <xsl:if test ="$isError > 0">
                      <!--toggle_visibility_by_condition("<xsl:value-of select="$detailTitleError"/>","<xsl:value-of select="$detailId"/>","showOrToggle")	-->
                      toggle_visibility_by_condition("<xsl:value-of select="concat('detailError',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseTitleError',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseDetailError',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                    </xsl:if>
                  </xsl:attribute>
                  <!--xsl:attribute name="class"> defaultMode clickable</xsl:attribute>-->
                  <!--</xsl:if>	-->
                </xsl:if>
                <xsl:value-of select="./ReportInformation/Source"/>
                <xsl:if test = "string-length(ReportInformation/Source/text()) = 0">
                  &#160;
                </xsl:if>
              </td>
            </xsl:for-each>
            <xsl:if test =" not(count($AttributV5List)+1 = $nbOfAttribut) ">
              <td  align ="center" class="defaultMode">
                <xsl:if test="./Children/ReportInfo[@Type='DocInfo' and @Name='SourceIdent']/ReportInformation/Source or $isPointedBy or $isPointing or $isWarning >0 or $isError > 0">
                  <xsl:attribute name="class">
                    defaultMode clickable
                  </xsl:attribute>
                  <xsl:attribute name="onclick">
                    toggle_visibility_by_id("<xsl:value-of select="$detailId"/>","<xsl:value-of select="$expandCollapseName"/>")
                    <xsl:if test ="$isPointedBy">
                      toggle_visibility_by_condition("<xsl:value-of select="concat('detailPointed By',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseTitlePointed By',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseDetailPointed By',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                    </xsl:if>
                    <xsl:if test ="$isPointing">
                      toggle_visibility_by_condition("<xsl:value-of select="concat('detailPointing',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseTitlePointing',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseDetailPointing',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                    </xsl:if>
                    <xsl:if test ="$isWarning >0 ">
                      toggle_visibility_by_condition("<xsl:value-of select="concat('detailWarning',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseTitleWarning',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseDetailWarning',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                    </xsl:if>
                    <xsl:if test ="$isError > 0">
                      toggle_visibility_by_condition("<xsl:value-of select="concat('detailError',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseTitleError',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                      toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseDetailError',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                    </xsl:if>
                  </xsl:attribute>
                </xsl:if>
                &#160;
              </td>
            </xsl:if>
          </xsl:when>
          <xsl:when test="starts-with($docType ,'DBDI_Rep')">
            <xsl:for-each select ="$AttributV6List">
              <td class="defaultMode clickable">
                <xsl:if test="position() =1">
                  <!--<xsl:attribute name = "onmouseover" >this.className='clickable';</xsl:attribute>							-->
                  <!--	<xsl:attribute name = "onmouseout" >this.className='defaultMode ';</xsl:attribute>		-->
                </xsl:if>
                <xsl:attribute name="onclick">
                  toggle_visibility_by_id("<xsl:value-of select="$detailId"/>","<xsl:value-of select="$expandCollapseName"/>")
                  <xsl:if test ="$isWarning >0 ">
                    <!--toggle_visibility_by_condition("<xsl:value-of select="$detailTitleWarning"/>","<xsl:value-of select="$detailId"/>","showOrToggle")	-->
                    toggle_visibility_by_condition("<xsl:value-of select="concat('detailWarning',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                    toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseTitleWarning',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                    toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseDetailWarning',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                  </xsl:if>
                  <xsl:if test ="$isError > 0">
                    <!--toggle_visibility_by_condition("<xsl:value-of select="$detailTitleError"/>","<xsl:value-of select="$detailId"/>","showOrToggle")	-->
                    toggle_visibility_by_condition("<xsl:value-of select="concat('detailError',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                    toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseTitleError',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                    toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseDetailError',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                  </xsl:if>
                </xsl:attribute>
                <xsl:attribute name="class"> defaultMode clickable</xsl:attribute>
                <xsl:value-of select="./ReportInformation/Source"/>
                <xsl:if test = "string-length(./ReportInformation/Source/text()) = 0">
                  &#160;
                </xsl:if>
              </td>
            </xsl:for-each>
          </xsl:when>
          <xsl:otherwise>
            <td class="defaultMode clickable">
              <xsl:attribute name="onclick">
                toggle_visibility_by_id("<xsl:value-of select="$detailId"/>","<xsl:value-of select="$expandCollapseName"/>")
                <xsl:if test ="$isPointedBy">
                  <!--toggle_visibility_by_condition("<xsl:value-of select="$detailTitlePointedBy"/>","<xsl:value-of select="$detailId"/>","showOrToggle")	-->
                  toggle_visibility_by_condition("<xsl:value-of select="concat('detailPointed By',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                  toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseTitlePointed By',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                  toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseDetailPointed By',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                </xsl:if>
                <xsl:if test ="$isPointing">
                  <!--toggle_visibility_by_condition("<xsl:value-of select="$detailTitlePointing"/>","<xsl:value-of select="$detailId"/>","showOrToggle")	-->
                  toggle_visibility_by_condition("<xsl:value-of select="concat('detailPointing',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                  toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseTitlePointing',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                  toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseDetailPointing',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                </xsl:if>
                <xsl:if test ="$isWarning >0 ">
                  <!--toggle_visibility_by_condition("<xsl:value-of select="$detailTitleWarning"/>","<xsl:value-of select="$detailId"/>","showOrToggle")	-->
                  toggle_visibility_by_condition("<xsl:value-of select="concat('detailWarning',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                  toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseTitleWarning',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                  toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseDetailWarning',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                </xsl:if>
                <xsl:if test ="$isError > 0">
                  <!--toggle_visibility_by_condition("<xsl:value-of select="$detailTitleError"/>","<xsl:value-of select="$detailId"/>","showOrToggle")	-->
                  toggle_visibility_by_condition("<xsl:value-of select="concat('detailError',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                  toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseTitleError',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                  toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseDetailError',$migrationTagNumber)"/>","<xsl:value-of select="$detailId"/>","hideOnly")
                </xsl:if>
              </xsl:attribute>
              <xsl:attribute name="class"> defaultMode clickable</xsl:attribute>
              <xsl:value-of select="$docName"/>
            </td>
          </xsl:otherwise>
        </xsl:choose>


        <!--/span-->
        <!--  Gestion de l'affichage du scope level et du réordonnancement des colonnes : -->
        <xsl:if test="not(./Children/ReportInfo[@Type='DocInfo' and @Name='ScopeLevel'])">
          <!-- Import mode -->
          <td class="defaultModeHighlight" align ="center">
            <table>
              <tr>
                <td class="defaultModeHighlight2" align="center">
                  <xsl:choose>
                    <xsl:when test ="./Children/ReportInfo[@Type='DocInfo' and @Name ='ExecutionMode']">
                      <xsl:value-of select="./Children/ReportInfo[@Type='DocInfo' and @Name ='ExecutionMode']/ReportInformation/Details/Detail"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:choose>
                        <xsl:when test ="../ReportInfo[@Type='document' and @Status ='Skipped']">NoImport</xsl:when>
                        <xsl:otherwise>&#160;</xsl:otherwise>
                      </xsl:choose>
                    </xsl:otherwise>
                  </xsl:choose>
                </td>
              </tr>
              <xsl:if test="./Children/ReportInfo[@Type='DocInfo' and @Name ='WhyThisChoice']/ReportInformation/Source">
                <tr>
                  <td  class="pointingModeLesserTitle2" align="center">
                    <xsl:attribute name="title">
                      <xsl:value-of select="./Children/ReportInfo[@Type='DocInfo' and @Name ='WhyThisChoice']/ReportInformation/Details/Detail"/>
                    </xsl:attribute>
                    <i>
                      <xsl:value-of select="./Children/ReportInfo[@Type='DocInfo' and @Name ='WhyThisChoice']/ReportInformation/Source"/>
                    </i>
                  </td>
                </tr>
              </xsl:if>
            </table>
          </td>

          <xsl:if test="starts-with($V5inV6Certified, 'Certified')" >
            <td class="defaultModeHighlight" align ="center">
              <table>
                <tr>
                  <td class="defaultModeHighlight2" align="center">
                    <xsl:choose>
                      <xsl:when test ="./Children/ReportInfo[@Type='DocInfo' and @Name ='V5inV6Certified']">
                        <xsl:value-of select="./Children/ReportInfo[@Type='DocInfo' and @Name ='V5inV6Certified']/ReportInformation/Details/Detail"/>
                      </xsl:when>
                      <xsl:otherwise>&#160; -- &#160;</xsl:otherwise>

                    </xsl:choose>
                  </td>
                </tr>
              </table>
            </td>
          </xsl:if>
          <!-- 
					Package numbers (Split mode only)
					and Import status.
				-->
          <xsl:if test="starts-with($docType, 'DBDI_Scope') or starts-with($docType, 'FBDI_Split')">
            <!-- Package Number-->
            <td class="defaultMode" align ="center">
              <xsl:value-of select="./LinkInformation/MigrationReportName"/>
            </td>
          </xsl:if>
          <!-- Pointing/Pointed RepImport Status-->
          <xsl:apply-templates select="./Children/ReportInfo[@Type='MigrationProcess']">
            <xsl:with-param name ="migrationTagNb" select ="./LinkInformation/MigrationTagName"/>
          </xsl:apply-templates>
        </xsl:if>
      </tr>
    </label>

    <label>
      <xsl:attribute name="name">
        <xsl:value-of select="$labelName"/>
      </xsl:attribute>
      <!-- Display the detail V5 attr etc.  -->
      <tr>
        <td/>
        <xsl:if test = "starts-with($docType, 'FBDI')">
          <td/>
        </xsl:if>
        <td>
          <xsl:if test = "starts-with($docType, 'DBDI')">
            <xsl:attribute name = "colspan">
              <xsl:value-of select ="$nbOfAttribut"/>
            </xsl:attribute>
          </xsl:if>
          <span class="displayHide">
            <xsl:if test="not(starts-with($docType, 'DBDI_Scope')) or ( $isPointedBy or $isPointing or $isWarning>0 or $isError>0)">
              <xsl:attribute name="id">
                <xsl:value-of select="$detailId"/>
              </xsl:attribute>
              <!--<xsl:attribute name="name"><xsl:value-of select="$detailName"/></xsl:attribute>-->
              <xsl:attribute name="class">
                <xsl:value-of select="concat($detailName,' displayHide')"/>
              </xsl:attribute>
            </xsl:if>
            <table align="left" width="100%">

              <!-- 
							For FBDI  : Display the doc path plus its main details.
							For DBDI : Display the doc import details and a link to the TE report.
						-->
              <xsl:if test=" $isError > 0 and ./Children/ReportInfo[@Type='DocInfo' and @Name='SourceIdent']/ReportInformation/Source">
                <tr>
                  <td width="10" align="left" valign="top">
                    <img src="Data\TableDetailArrow.png" />
                  </td>
                  <td class="defaultModeDetail" >
                    <xsl:if test="starts-with($docType, 'DBDI_Rep')">
                      <xsl:attribute name ="colspan">2</xsl:attribute>
                    </xsl:if>
                    Source identifier :<pre>
                      <xsl:value-of select="./Children/ReportInfo[@Type='DocInfo' and @Name='SourceIdent']/ReportInformation/Source"/>
                    </pre>
                  </td>
                </tr>
              </xsl:if>
              <tr>
                <td width="10" align="left" valign="top">
                  <xsl:if test="( not(starts-with($docType, 'DBDI_Scope') ) and $isError = 0) or (starts-with($docType, 'FBDI'))">
                    <img src="Data\TableDetailArrow.png" />
                  </xsl:if>
                </td>
                <!-- FBDI Only-->
                <xsl:if test="starts-with($docType, 'FBDI')">
                  <td class="defaultModeDetail">
                    <xsl:value-of select="$docPath"/>
                  </td>
                </xsl:if>

                <xsl:if test="starts-with($docType, 'DBDI_Rep')">
                  <td class="defaultModeDetail">
                    Document type : <xsl:value-of select="./Children/ReportInfo[@Type='DocInfo' and @Name='LateType']/ReportInformation/Source"/>
                    <xsl:for-each select="./Children/ReportInfo[@Type='DocInfo' and @Name ='AttrV5TreeMask']/Children/ReportInfo[@Type = 'Attribut']">
                      <br/>
                      V5 Rep [ <xsl:value-of select="./@Name"/> ] : <xsl:value-of select="./ReportInformation/Source"/>
                    </xsl:for-each>
                  </td>
                </xsl:if>

                <!-- DBDI only -->
                <!-- Link to the split report where the document has been imported.-->
                <xsl:if test="starts-with($docType, 'DBDI_Rep') and LinkInformation/TEReportName != 'TransactionReport_0'">
                  <!-- VARIABLE -->
                  <xsl:variable name ="TEReport">
                    <xsl:value-of select="LinkInformation/TEReportName"/>
                  </xsl:variable>
                  <xsl:variable name ="TEObject">
                    <xsl:value-of select="LinkInformation/TETagName"/>
                  </xsl:variable>
                  <A>
                    <xsl:attribute name="href">
                      <xsl:value-of select ="concat('../',$TEReport,'.xml#',$TEObject)"/>
                    </xsl:attribute>
                    <td class="defaultModeDetail styleAction" onmouseover="this.className='highlightDefaultMode clickable';"
                      onmouseout="this.className='defaultModeDetail styleAction';" align ="center" width ="150">
                      <a href = "{concat('../',$TEReport,'.xml#',$TEObject)}">
                        <u>Metadata Information </u>
                      </a>
                      <img src="Data\goToDetailAction.png"/>
                    </td>
                  </A>
                </xsl:if>
              </tr>

              <!-- Add the table  concerning the Pointing and the pointed doc -->
              <xsl:if test ="$isPointedBy or $isPointing">
                <tr>
                  <td/>
                  <!-- Blank td (Column of the expand collapse button)-->
                  <td>
                    <!--<xsl:attribute name = "colspan">							
											<xsl:value-of select ="$nbOfAttribut"/>
										</xsl:attribute>-->

                    <!-- Table for Rep pointing the current rep -->
                    <xsl:choose>
                      <xsl:when test="starts-with($docType,'DBDI_Scope_Native')">
                        <!--SSU1 for native scopebuilder report -->
                        <xsl:if test ="./Children/ReportInfo[@Type='DocInfo' and @Name ='IndexOfPointingRep'][1]">
                          <xsl:call-template  name="CreatePointingPointedTable">
                            <xsl:with-param name="docType" select ="$docType"/>
                            <xsl:with-param name="nbOfAttribut" select ="$nbOfAttribut"/>
                            <xsl:with-param name ="strTableType" select ="'Pointed By'"/>
                            <xsl:with-param name ="strTableTypeNew" select ="'Pointed_by'"/>
                            <xsl:with-param name ="attributV5List" select ="$AttributV6List"/>
                            <xsl:with-param name ="reportInfoPointedPointingRep" select ="./Children/ReportInfo[@Type='DocInfo' and @Name ='IndexOfPointingRep']/ReportInformation"/>
                            <xsl:with-param name ="migrationTagNb" select ="./LinkInformation/MigrationTagName"/>

                          </xsl:call-template>
                        </xsl:if>

                        <!-- Table for pointed Rep -->
                        <xsl:if test ="./Children/ReportInfo[@Type='DocInfo' and @Name ='IndexOfPointedRep'][1]">
                          <xsl:call-template  name="CreatePointingPointedTable">
                            <xsl:with-param name="docType" select ="$docType"/>
                            <xsl:with-param name="nbOfAttribut" select ="$nbOfAttribut"/>
                            <xsl:with-param name ="strTableType" select ="'Pointing'"/>
                            <xsl:with-param name ="strTableTypeNew" select ="'Pointing'"/>
                            <xsl:with-param name ="attributV5List" select ="$AttributV6List"/>
                            <xsl:with-param name ="reportInfoPointedPointingRep" select ="./Children/ReportInfo[@Type='DocInfo' and @Name ='IndexOfPointedRep']/ReportInformation"/>
                            <xsl:with-param name ="migrationTagNb" select ="./LinkInformation/MigrationTagName"/>
                          </xsl:call-template>
                        </xsl:if>
                      </xsl:when>

                      <xsl:otherwise>
                        <xsl:if test ="./Children/ReportInfo[@Type='DocInfo' and @Name ='IndexOfPointingRep'][1]">
                          <xsl:call-template  name="CreatePointingPointedTable">
                            <xsl:with-param name="docType" select ="$docType"/>
                            <xsl:with-param name="nbOfAttribut" select ="$nbOfAttribut"/>
                            <xsl:with-param name ="strTableType" select ="'Pointed By'"/>
                            <xsl:with-param name ="strTableTypeNew" select ="'Pointed_by'"/>
                            <xsl:with-param name ="attributV5List" select ="$AttributV5List"/>
                            <xsl:with-param name ="reportInfoPointedPointingRep" select ="./Children/ReportInfo[@Type='DocInfo' and @Name ='IndexOfPointingRep']/ReportInformation"/>
                            <xsl:with-param name ="migrationTagNb" select ="./LinkInformation/MigrationTagName"/>

                          </xsl:call-template>
                        </xsl:if>

                        <!-- Table for pointed Rep -->
                        <xsl:if test ="./Children/ReportInfo[@Type='DocInfo' and @Name ='IndexOfPointedRep'][1]">
                          <xsl:call-template  name="CreatePointingPointedTable">
                            <xsl:with-param name="docType" select ="$docType"/>
                            <xsl:with-param name="nbOfAttribut" select ="$nbOfAttribut"/>
                            <xsl:with-param name ="strTableType" select ="'Pointing'"/>
                            <xsl:with-param name ="strTableTypeNew" select ="'Pointing'"/>
                            <xsl:with-param name ="attributV5List" select ="$AttributV5List"/>
                            <xsl:with-param name ="reportInfoPointedPointingRep" select ="./Children/ReportInfo[@Type='DocInfo' and @Name ='IndexOfPointedRep']/ReportInformation"/>
                            <xsl:with-param name ="migrationTagNb" select ="./LinkInformation/MigrationTagName"/>
                          </xsl:call-template>
                        </xsl:if>
                      </xsl:otherwise>
                    </xsl:choose>
                  </td>
                </tr>
              </xsl:if>

              <!-- Add the table  concerning the warning and error for doc  -->



              <xsl:if test ="$isWarning >0 or $isError > 0">
                <tr>
                  <td/>
                  <!-- Blank td (Column of the expand collapse button)-->
                  <td>
                    <xsl:attribute name = "colspan">
                      <xsl:value-of select ="$nbOfAttribut"/>
                    </xsl:attribute>

                    <xsl:if test ="$isWarning>0">
                      <xsl:call-template name ='CreateWarningErrorTableForDetail'>
                        <!-- <xsl:param name ="nbOfAttribut"/>-->
                        <xsl:with-param name ="strTableType"  select ="'Warning'"/>
                        <!-- <xsl:param name ="attributV5List"/> -->
                        <xsl:with-param name ="docToProcess" select ="./Children/ReportInfo[@Type='MigrationProcess']/Children
																/descendant::ReportInfo[@Type='RaisedMsg' and @Status ='Warning'  and not(@View = '1')] " />
                        <xsl:with-param  name ="migrationTagNb" select ="./LinkInformation/MigrationTagName"/>
                      </xsl:call-template >
                    </xsl:if>

                    <xsl:if test ="$isError>0">
                      <xsl:call-template name ='CreateWarningErrorTableForDetail'>
                        <!-- <xsl:param name ="nbOfAttribut"/>-->
                        <xsl:with-param name ="strTableType"  select ="'Error'"/>
                        <!-- <xsl:param name ="attributV5List"/> -->
                        <xsl:with-param name ="docToProcess" select ="./Children/ReportInfo[@Type='MigrationProcess']/Children
																/descendant::ReportInfo[@Type='RaisedMsg' and @Status ='Error'  and not(@View = '1')] " />
                        <xsl:with-param  name ="migrationTagNb" select ="./LinkInformation/MigrationTagName"/>
                      </xsl:call-template >
                    </xsl:if>

                  </td>
                </tr>
              </xsl:if>
              <tr>
                <td align ="right" colspan="3">
                  <A href="#TopOfPage">
                    <img src ="Data/JumpUp.png" border="0" class="clickable"/>
                  </A>
                </td>
              </tr>
            </table>
          </span>
        </td>
      </tr>
    </label>


  </xsl:template>

  <xsl:template match="ReportInfo">
    <xsl:if test="@Type = 'InputDataSize'">
      <xsl:apply-templates select="Detail"/>
    </xsl:if>
    <xsl:apply-templates select="ReportInformation"/>
    <xsl:apply-templates select="Children"/>
  </xsl:template>

  <!--****************************************************************
	  Affiche les details de chaque document avec les bonnes indentations.
	**************************************************************** -->
  <xsl:template match="//Report[@Type !='StepInfo']/ReportInformation">
    <xsl:variable name="Indentation">
      <xsl:number value="count(ancestor::ReportInfo)-3" format="1"/>
    </xsl:variable>

    <xsl:variable name="CouleurLigne">
      <xsl:if test="$Indentation = 0">detailIndentLv1</xsl:if>
      <xsl:if test="$Indentation = 1">detailIndentLv2</xsl:if>
      <xsl:if test="$Indentation = 2">detailIndentLv3</xsl:if>
      <xsl:if test="$Indentation = 3">detailIndentLv4</xsl:if>
      <xsl:if test="$Indentation = 4">detailIndentLv5</xsl:if>
      <xsl:if test="$Indentation >= 5">detailIndentLv6</xsl:if>
    </xsl:variable>

    <xsl:variable name="Retrait">
      <xsl:if test="$Indentation >= 2">&#160;&#160;&#160;&#160;&#160;</xsl:if>
      <xsl:if test="$Indentation >= 3">&#160;&#160;&#160;&#160;&#160;</xsl:if>
      <xsl:if test="$Indentation >= 4">&#160;&#160;&#160;&#160;&#160;</xsl:if>
      <xsl:if test="$Indentation >= 5">&#160;&#160;&#160;&#160;&#160;</xsl:if>
      <xsl:if test="$Indentation >= 6">&#160;&#160;&#160;&#160;&#160;</xsl:if>
      <xsl:if test="$Indentation >= 7">&#160;&#160;&#160;&#160;&#160;</xsl:if>
    </xsl:variable>

    <xsl:variable name="LineStatus" select ="../@Status"/>

    <xsl:variable name="TypeOfLine">
      <xsl:choose>
        <xsl:when test="$LineStatus = 'OK'">
          <xsl:value-of select="$CouleurLigne"/>
        </xsl:when>
        <xsl:when test="$LineStatus = 'WarningPriv'">
          <xsl:value-of select="'CouleurLigne'"/>
        </xsl:when>
        <xsl:when test="$LineStatus = 'Warning'">
          <xsl:value-of select="'WarningMode'"/>
        </xsl:when>
        <xsl:when test="$LineStatus = 'Error'">
          <xsl:value-of select="'ErrorMode'"/>
        </xsl:when>
        <xsl:when test="$LineStatus = 'Unknown'">
          <xsl:value-of select="'ErrorMode'"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$CouleurLigne"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:if test="Source != 'Execution Mode'">
      <tr>
        <td width="10" align="left">
        </td>
        <td width="20" align="left">
        </td>
        <td>
          <xsl:attribute name="class">
            <xsl:value-of select="$TypeOfLine"/>
          </xsl:attribute>
          <xsl:value-of select="$Retrait"/>
          <xsl:if test="$Indentation != 0">
            <!--Ajout d'une icone devant les infos
					<img border="0" src="LastFileTransparent.gif"/>-->
            <img src="Data\TableDetailArrow.png" />&#160;&#160;
            <!--<xsl:value-of select="Source"/>&#160;&#160;-->
          </xsl:if>
          <xsl:value-of select="Source"/>
        </td>
        <td>
          <xsl:attribute name="class">
            <xsl:value-of select="$TypeOfLine"/>
          </xsl:attribute>
          <xsl:apply-templates select="Details"/>
        </td>
        <td align ="center">
          <xsl:attribute name="class">
            <xsl:value-of select="$TypeOfLine"/>
          </xsl:attribute>
          <xsl:apply-templates select="$LineStatus"/>&#160;&#160;<xsl:value-of select="Tag"/>
        </td>
      </tr>

    </xsl:if>
  </xsl:template>

  <xsl:template match="Children">
    <xsl:apply-templates select="ReportInfo"/>
  </xsl:template>

  <xsl:template match="Details">
    <br/>
    <xsl:apply-templates select="Detail"/>
  </xsl:template>

  <xsl:template match="Detail">
    <xsl:apply-templates/>
    <br/>
  </xsl:template>


  <!--****************************************************************
	  Function : Renvoie le nom du fichier à partir d'un path 
	**************************************************************** -->
  <xsl:template name='strip-path'>
    <xsl:param name='path' />
    <xsl:choose>
      <xsl:when test='contains($path, "\")'>
        <xsl:call-template name='strip-path'>
          <xsl:with-param name='path' select='substring-after($path, "\")' />
        </xsl:call-template>
      </xsl:when>
      <xsl:when test='contains($path, "/")'>
        <xsl:call-template name='strip-path'>
          <xsl:with-param name='path' select='substring-after($path, "/")' />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select='$path' />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- ****************************************************************
		 FOR IMPORT SECTION, Title formating of each step.
		****************************************************************-->
  <xsl:template name ='AddStepTitleRow'>
    <xsl:param name ='strStepType'/>
    <xsl:param name ='strStepName'/>
    <xsl:param name ='strStepStatus'/>
    <xsl:param name ='strDocType'/>

    <xsl:variable name ="styleStepName">
      <xsl:choose>
        <xsl:when test ="$strStepStatus = 'Interrupted' or ($strStepStatus = 'Skipped') " >
          styleStepNameNotExec
        </xsl:when>
        <xsl:otherwise>
          styleStepName
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name ="styleStepTableId">
      <xsl:value-of select="concat('summaryTable',$strStepType)"/>
    </xsl:variable>
    <tr>
      <td>
        <!-- Content-->
        <xsl:if test="$strStepName = 'Conversion' or ($strStepType = 'ScopeBuild' and starts-with($strDocType, 'FBDI_Split')) ">
          <xsl:attribute name = "colspan">2</xsl:attribute>
        </xsl:if>
        <b>
          <xsl:attribute name = "class">
            <xsl:value-of select="$styleStepName"/> styleNoWrap
          </xsl:attribute>
          <xsl:if test ="($strStepType ='ScopeBuild' or not(starts-with($strDocType, 'FBDI_Split')) ) and $strStepStatus != 'Interrupted' and (not($strStepStatus ='OK' and $strStepType !='ScopeBuild')  and $strStepStatus != 'Skipped')" >
            <xsl:attribute name = "onmouseover">
              this.className='styleStepNameHighlight clickable styleNoWrap'
            </xsl:attribute>
            <xsl:attribute name = "onmouseout">
              this.className='styleStepName clickable styleNoWrap'
            </xsl:attribute>
            <xsl:attribute name = "onclick">
              <xsl:choose>
                <xsl:when test ="$strStepType = 'ScopeBuild'">
                  toggle_visibility_by_id('summaryTableScopeBuildContent','<xsl:value-of select="concat('plusminus',$strStepType)"/>')
                  toggle_visibility_by_condition('summaryTableScopeBuild','summaryTableScopeBuildContent',"showOrToggle")
                  toggle_visibility_by_condition('summaryTableScopeBuild','summaryTableScopeBuildContent',"hideOnly")
                </xsl:when>
                <xsl:otherwise>
                  toggle_visibility_by_id('<xsl:value-of select="$styleStepTableId"/>','<xsl:value-of select="concat('plusminus',$strStepType)"/>')
                </xsl:otherwise>
              </xsl:choose>
              toggle_Img_by_condition('<xsl:value-of select="concat('expandCollapseMainStep',$strStepType,$strStepStatus)"/>',"toggle")
            </xsl:attribute>
          </xsl:if>
          <xsl:value-of select="$strStepName"/>
        </b>
        <xsl:choose>
          <xsl:when test ="$strStepStatus != 'Interrupted'" >
            <xsl:if test ="($strStepType ='ScopeBuild' or not(starts-with($strDocType, 'FBDI_Split')) ) and not($strStepStatus ='OK' and $strStepType !='ScopeBuild') and $strStepStatus != 'Skipped'" >
              <img class="clickable">
                <xsl:attribute name ="src">
                  <xsl:choose>
                    <xsl:when test ="$strStepStatus = 'Error'">
                      Data\Minus.gif
                    </xsl:when>
                    <xsl:otherwise>
                      Data\Plus.gif
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:attribute>
                <xsl:attribute name = "id">
                  <xsl:value-of select="concat('plusminus',$strStepType)"/>
                </xsl:attribute>
                <xsl:attribute name = "onclick">
                  <xsl:choose>
                    <xsl:when test ="$strStepType = 'ScopeBuild'">
                      toggle_visibility_by_id('summaryTableScopeBuildContent','<xsl:value-of select="concat('plusminus',$strStepType)"/>')
                      toggle_visibility_by_condition('summaryTableScopeBuild','summaryTableScopeBuildContent',"showOrToggle")
                      toggle_visibility_by_condition('summaryTableScopeBuild','summaryTableScopeBuildContent',"hideOnly")
                    </xsl:when>
                    <xsl:otherwise>
                      toggle_visibility_by_id('<xsl:value-of select="concat('summaryTable',$strStepType)"/>','<xsl:value-of select="concat('plusminus',$strStepType)"/>')
                    </xsl:otherwise>
                  </xsl:choose>


                  toggle_Img_by_condition('<xsl:value-of select="concat('expandCollapseMainStep',$strStepType,$strStepStatus)"/>',"toggle")
                </xsl:attribute>
              </img>
            </xsl:if>
            <br/>
            <xsl:if test ="not(starts-with($strDocType, 'FBDI_Split')) and not($strStepStatus = 'Skipped')">
              <i class="styleStepName">
                <xsl:value-of select="/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/
											ReportInfo[@Type = 'MigrationStep' and @Name= $strStepType]/Children/
													ReportInfo[@Type='TimeInfo' and @Name='ExecutionTime']/ReportInformation/Source/text()"/>
              </i>
            </xsl:if>
            <xsl:if test ="$strStepStatus = 'Skipped' and $strStepName = 'Save' ">
              <br/>
            </xsl:if>
          </xsl:when>
          <xsl:otherwise>
            <br/>
            <br/>
          </xsl:otherwise>
        </xsl:choose>
      </td>
    </tr>
  </xsl:template>


  <!-- ****************************************************************
		FOR DETAIL SECTION , DBDI_SCOPE, Create the pointing pointed table 
		****************************************************************-->
  <xsl:template name ='CreatePointingPointedTable'>
    <xsl:param name="docType"/>
    <xsl:param name ="nbOfAttribut"/>
    <xsl:param name ="strTableType"/>
    <xsl:param name ="strTableTypeNew"/>
    <xsl:param name ="attributV5List"/>
    <xsl:param name ="reportInfoPointedPointingRep"/>
    <xsl:param name ="migrationTagNb"/>


    <xsl:variable name ="detailDescTableId" select ="concat('DetailDocument_',$migrationTagNb)" />
    <xsl:variable name ="titleTableId" select ="concat('title',$strTableType,$migrationTagNb)" />
    <xsl:variable name ="detailTableId" select ="concat('detail',$strTableType,$migrationTagNb)" />
    <xsl:variable name ="titleTableIdImg" select ="concat('expandCollapseTitle',$strTableType,$migrationTagNb)" />
    <xsl:variable name ="detailTableIdImg" select ="concat('expandCollapseDetail',$strTableType,$migrationTagNb)" />
    <!--  -->
    <!--<span class ="displayHide">
			<xsl:attribute name="id">
				<xsl:value-of select="concat('title',$strTableType,$migrationTagNb)"/>
			</xsl:attribute>-->
    <table class ="objectFBDITable" width="100%">
      <th width="30" class ="clickable">
        <xsl:attribute name="onclick">
          <!--toggle_visibility_by_condition("<xsl:value-of select="$titleTableId"/>","<xsl:value-of select="$detailDescTableId"/>","showOrToggle")						-->
          toggle_visibility_by_id("<xsl:value-of select="$detailTableId"/>","<xsl:value-of select="$titleTableIdImg"/>")
          toggle_Img_by_condition("<xsl:value-of select="$detailTableIdImg"/>","toggle")
        </xsl:attribute>
        <img src="Data\expandArrow.png">
          <xsl:attribute name="id">
            <xsl:value-of select="$titleTableIdImg"/>
          </xsl:attribute>
        </img>
      </th>
      <th class ="pointingMode clickable">
        <xsl:attribute name="onclick">
          <!--toggle_visibility_by_condition("<xsl:value-of select="$titleTableId"/>","<xsl:value-of select="$detailDescTableId"/>","showOrToggle")						-->
          toggle_visibility_by_id("<xsl:value-of select="$detailTableId"/>","<xsl:value-of select="$titleTableIdImg"/>")
          toggle_Img_by_condition("<xsl:value-of select="$detailTableIdImg"/>","toggle")
        </xsl:attribute>
        <xsl:if test ="starts-with($docType, 'DBDI')">
          <xsl:attribute name = "colspan">
            <xsl:value-of select= "$nbOfAttribut" />
          </xsl:attribute>
        </xsl:if>
        &#160;&#160;
        <img>
          <xsl:attribute name ="src">
            <xsl:value-of select="concat('Data\SB_',$strTableTypeNew,'_Title.png')"/>
          </xsl:attribute>
        </img>
        &#160;
        <xsl:choose>
          <xsl:when test = "$strTableType = 'Pointing'">
            Points
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select= "$strTableType" />
          </xsl:otherwise>
        </xsl:choose>
        &#160;&#160;
      </th>
      <tr>
        <td/>
        <td>
          <xsl:if test ="starts-with($docType, 'DBDI')">
            <xsl:attribute name = "colspan">
              <xsl:value-of select= "$nbOfAttribut" />
            </xsl:attribute>
          </xsl:if>
          <!-- For DBDI report, title level 2 row such as the name of the attributs defined by the mask tree -->
          <span class ="detaildisplayHide">
            <xsl:attribute name="id">
              <xsl:value-of select="concat('detail',$strTableType,$migrationTagNb)"/>
            </xsl:attribute>
            <table class ="objectFBDITable" align = "left" width="100%">
              <xsl:if test ="starts-with($docType, 'DBDI')">
                <tr>
                  <xsl:for-each select ="$attributV5List">
                    <td class ="pointingModeLesserTitle">
                      <b>
                        <xsl:value-of select="@Name"/>
                      </b>
                    </td>
                  </xsl:for-each>
                </tr>
              </xsl:if>
              <!-- InfoAbout the rep pointing this rep. -->
              <xsl:for-each select ="$reportInfoPointedPointingRep">
                <xsl:variable name="indexRep" select = "./Source"/>
                <xsl:variable name="docPointPath" select = "/ReportInfo/Children/ReportInfo[@Type='document'][./LinkInformation/MigrationTagName/text() = $indexRep]
													/ReportInformation/Source"/>
                <tr>
                  <xsl:choose>
                    <xsl:when test ="starts-with($docType, 'DBDI_Scope_Native')">
                      <xsl:for-each select ="/ReportInfo/Children/ReportInfo[@Type='document'][./LinkInformation/MigrationTagName/text() = $indexRep]
														/Children/ReportInfo[@Type = 'DocInfo' and @Name='AttrV6TreeMask']/Children/ReportInfo[@Type='Attribut']">
                        <td class ="pointingMode">
                          <xsl:value-of select="./ReportInformation/Source"/>
                          <xsl:if test = "string-length(./ReportInformation/Source/text()) = 0">
                            &#160;
                          </xsl:if>
                        </td>
                      </xsl:for-each>
                    </xsl:when>
                    <xsl:when test ="starts-with($docType, 'DBDI')">
                      <xsl:for-each select ="/ReportInfo/Children/ReportInfo[@Type='document'][./LinkInformation/MigrationTagName/text() = $indexRep]
														/Children/ReportInfo[@Type = 'DocInfo' and @Name='AttrV5TreeMask']/Children/ReportInfo[@Type='Attribut']">
                        <td class ="pointingMode">
                          <xsl:value-of select="./ReportInformation/Source"/>
                          <xsl:if test = "string-length(./ReportInformation/Source/text()) = 0">
                            &#160;
                          </xsl:if>
                        </td>
                      </xsl:for-each>
                    </xsl:when>
                  </xsl:choose>
                  <xsl:if test ="starts-with($docType, 'FBDI')">
                    <td class ="pointingMode">
                      <xsl:call-template name='strip-path'>
                        <xsl:with-param name='path' select='$docPointPath' />
                      </xsl:call-template>

                    </td>
                  </xsl:if>
                </tr>
              </xsl:for-each>
            </table>
          </span>
        </td>
      </tr>
    </table>
    <!--</span>						-->
  </xsl:template>

  <!-- ****************************************************************
		FOR DETAIL SECTION ,  Create warning error table
		****************************************************************-->
  <xsl:template name ='CreateWarningErrorTableForDetail'>
    <!-- <xsl:param name ="nbOfAttribut"/>-->
    <xsl:param name ="strTableType"/>
    <!-- <xsl:param name ="attributV5List"/> -->
    <xsl:param name ="docToProcess"/>
    <xsl:param name ="migrationTagNb"/>


    <xsl:variable name ="detailDescTableId" select ="concat('DetailDocument_',$migrationTagNb)" />
    <xsl:variable name ="titleTableId" select ="concat('title',$strTableType,$migrationTagNb)" />
    <xsl:variable name ="detailTableId" select ="concat('detail',$strTableType,$migrationTagNb)" />
    <xsl:variable name ="titleTableIdImg" select ="concat('expandCollapseTitle',$strTableType,$migrationTagNb)" />
    <xsl:variable name ="detailTableIdImg" select ="concat('expandCollapseDetail',$strTableType,$migrationTagNb)" />

    <xsl:variable name ="rowStyle" select ="concat($strTableType,'Mode')" />

    <!--<span class ="displayHide">
			<xsl:attribute name="id">
				<xsl:value-of select="concat('title',$strTableType,$migrationTagNb)"/>
			</xsl:attribute>-->
    <table class ="objectFBDITable" width="100%">
      <th width="30" class ="clickable">
        <xsl:attribute name="onclick">
          toggle_visibility_by_condition("<xsl:value-of select="$titleTableId"/>","<xsl:value-of select="$detailDescTableId"/>","showOrToggle")
          toggle_visibility_by_id("<xsl:value-of select="$detailTableId"/>","<xsl:value-of select="$titleTableIdImg"/>")
          toggle_Img_by_condition("<xsl:value-of select="$detailTableIdImg"/>","toggle")
        </xsl:attribute>
        <img src="Data\expandArrow.png">
          <xsl:attribute name="id">
            <xsl:value-of select="$titleTableIdImg"/>
          </xsl:attribute>
        </img>
      </th>
      <th >
        <xsl:attribute name ="class">
          <xsl:value-of select ="$rowStyle"/> clickable
        </xsl:attribute>
        <xsl:attribute name="onclick">
          toggle_visibility_by_condition("<xsl:value-of select="$titleTableId"/>","<xsl:value-of select="$detailDescTableId"/>","showOrToggle")
          toggle_visibility_by_id("<xsl:value-of select="$detailTableId"/>","<xsl:value-of select="$titleTableIdImg"/>")
          toggle_Img_by_condition("<xsl:value-of select="$detailTableIdImg"/>","toggle")
        </xsl:attribute>
        &#160;&#160;
        <xsl:value-of select= "$strTableType" />&#160;&#160;
      </th>
      <tr>
        <td/>
        <td>
          <span class ="detaildisplayHide">
            <xsl:attribute name="id">
              <xsl:value-of select="concat('detail',$strTableType,$migrationTagNb)"/>
            </xsl:attribute>
            <table class ="objectFBDITable" align = "left" width="100%">
              <th>
                <xsl:attribute name="class">
                  <xsl:value-of select="$rowStyle"/>
                </xsl:attribute>#
              </th>
              <th>
                <xsl:attribute name ="class">
                  <xsl:value-of select ="$rowStyle"/>
                </xsl:attribute>
                Code
              </th>
              <th>
                <xsl:attribute name ="class">
                  <xsl:value-of select ="$rowStyle"/>
                </xsl:attribute>
                Description
              </th>
              <th>
                <xsl:attribute name ="class">
                  <xsl:value-of select ="$rowStyle"/>
                </xsl:attribute>
                Detail
              </th>
              <xsl:for-each select ="$docToProcess">
                <xsl:variable name ="CurrentIdOfRaisedMsg">
                  <xsl:value-of select ="./@Number"/>
                </xsl:variable>
                <xsl:variable name ="infraCode">
                  <xsl:value-of select ="./ReportInformation/Tag/Code"/>
                </xsl:variable>
                <xsl:variable name ="CurrentSource">
                  <xsl:value-of select ="./ReportInformation/Source"/>
                </xsl:variable>
                <xsl:variable name ="nbOfSameSource">
                  <xsl:value-of select="count(./following-sibling::ReportInfo[@Type ='RaisedMsg'][./ReportInformation/Source = $CurrentSource])
													+ count(./preceding-sibling::ReportInfo[@Type ='RaisedMsg'][./ReportInformation/Source = $CurrentSource])"/>
                </xsl:variable>
                <!-- L78 If there are no details, no need to display same information several times -->
                <xsl:if test="count(./ReportInformation/Details/Detail) = 0 and $nbOfSameSource &gt; 0">
                  <xsl:choose>
                    <xsl:when test="./preceding-sibling::ReportInfo[@Type='RaisedMsg'and @Number != $CurrentIdOfRaisedMsg][./ReportInformation/Tag/Code = $infraCode]"/>
                    <xsl:otherwise>
                      <xsl:variable name ="nbOfRaisedMessage">
                        <xsl:value-of select="count(./following-sibling::ReportInfo[@Type ='RaisedMsg'][./ReportInformation/Tag/Code = $infraCode])+1"/>
                      </xsl:variable>
                      <tr>
                        <td>
                          <xsl:attribute name ="class">
                            <xsl:value-of select ="$rowStyle"/>
                          </xsl:attribute>
                          <xsl:value-of select="$nbOfRaisedMessage"/>
                        </td>
                        <td>
                          <xsl:attribute name ="class">
                            <xsl:value-of select ="$rowStyle"/>
                          </xsl:attribute>
                          <xsl:if test="@View = '1'">
                            <b>Private</b>&#160;
                          </xsl:if>
                          <xsl:value-of select = "./ReportInformation/Tag/Code"/>
                        </td>
                        <td>
                          <xsl:attribute name ="class">
                            <xsl:value-of select ="$rowStyle"/>
                          </xsl:attribute>
                          <xsl:value-of select = "./ReportInformation/Source"/>
                        </td>
                        <td>
                          <xsl:attribute name ="class">
                            <xsl:value-of select ="$rowStyle"/>
                          </xsl:attribute>
                        </td>
                      </tr>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:if>
                <xsl:if test="count(./ReportInformation/Details/Detail) > 0 or (count(./ReportInformation/Details/Detail) = 0 and $nbOfSameSource = 0)">
                  <tr>
                    <td>
                      <xsl:attribute name ="class">
                        <xsl:value-of select ="$rowStyle"/>
                      </xsl:attribute>1
                    </td>
                    <td>
                      <xsl:attribute name ="class">
                        <xsl:value-of select ="$rowStyle"/>
                      </xsl:attribute>
                      <xsl:if test="@View = '1'">
                        <b>Private</b>&#160;
                      </xsl:if>
                      <xsl:value-of select = "./ReportInformation/Tag/Code"/>
                    </td>
                    <td>
                      <xsl:attribute name ="class">
                        <xsl:value-of select ="$rowStyle"/>
                      </xsl:attribute>
                      <xsl:value-of select = "./ReportInformation/Source"/>
                    </td>
                    <td>
                      <xsl:attribute name ="class">
                        <xsl:value-of select ="$rowStyle"/>
                      </xsl:attribute>
                      <xsl:apply-templates select="./ReportInformation/Details"/>
                    </td>
                  </tr>
                </xsl:if>
              </xsl:for-each>
            </table>
          </span>
        </td>
      </tr>
    </table>
    <!--</span>						-->
  </xsl:template>

  <!--****************************************************************
	  IMPORT section : Add the line corresponding to the number of found warning, 
	  errors etc.
	  Used in the IMPORT section and located between the source and 
	  destination images.
	**************************************************************** -->
  <xsl:template match="//ReportInfo[@Type='StepInfo' and @Name='NbRepByStatus']/Children/ReportInfo[@Type='Status']">
    <xsl:param name ='strStepType'/>
    <xsl:param name ='strDocType'/>
    <xsl:variable name="status">
      <xsl:choose>
        <xsl:when test = "@Name =  'WarningPriv'">
          <xsl:value-of  select="'OK'"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of  select="@Name"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="hasPrivateWarning">
      <xsl:choose>
        <xsl:when test ="@Name = 'WarningPriv'">
          0
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of  select="count(../ReportInfo[@Type ='Status' and @Name='WarningPriv'])"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="rowStyle">
      <xsl:value-of select="concat('style',$status)"/>
    </xsl:variable>
    <xsl:variable name="summaryTableId">
      <xsl:value-of select="concat('summaryTable',$strStepType)"/>
    </xsl:variable>
    <xsl:variable name="titleTableId">
      <xsl:value-of select="concat('summaryTableTitle',$strStepType,$status)"/>
    </xsl:variable>
    <xsl:variable name="titleTableIcon">
      <xsl:value-of select="concat('expandCollapseTitle',$strStepType,$status)"/>
    </xsl:variable>
    <xsl:variable name="detailTableId">
      <xsl:value-of select="concat('summaryTableDetail',$strStepType,$status)"/>
    </xsl:variable>
    <xsl:variable name="detailTableIcon">
      <xsl:value-of select="concat('expandCollapseStep',$strStepType,$status)"/>
    </xsl:variable>

    <td align = "left">
      <img>
        <xsl:choose>
          <xsl:when test ="$status = 'Error'">
            <xsl:attribute name ="src">
              <xsl:value-of select="concat('Data\Rep_Status_',$status,'_collapse.png')"/>
            </xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name ="src">
              <xsl:value-of select="concat('Data\Rep_Status_',$status,'_expand.png')"/>
            </xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:if test ="$status ='Warning' or $status = 'Error'">
          <xsl:attribute name = "onmouseover" >
            toggle_Img_by_condition("<xsl:value-of select="$detailTableIcon"/>","toggle")
          </xsl:attribute>
          <xsl:attribute name = "onmouseout" >
            toggle_visibility_by_condition("<xsl:value-of select="$detailTableIcon"/>",'<xsl:value-of select="$titleTableIcon"/>',"expandSameStateOrToggle")
          </xsl:attribute>
          <xsl:attribute name="id">
            <xsl:value-of select="$detailTableIcon"/>
          </xsl:attribute>
          <xsl:attribute name="onclick">
            <xsl:choose>
              <xsl:when test ="$strStepType = 'ScopeBuild'">
                toggle_visibility_by_condition('summaryTableScopeBuildContent','summaryTableScopeBuildContent','showOrToggle')
                toggle_visibility_by_condition('summaryTableScopeBuild','summaryTableScopeBuildContent',"showOrToggle")
              </xsl:when>
              <xsl:otherwise>
                toggle_visibility_by_condition('<xsl:value-of select="$summaryTableId"/>','<xsl:value-of select="$summaryTableId"/>','showOrToggle')
              </xsl:otherwise>
            </xsl:choose>


            toggle_visibility_by_condition('<xsl:value-of select="concat('plusminus',$strStepType)"/>','<xsl:value-of select="$summaryTableId"/>','showOrToggle')
            toggle_visibility_by_condition("<xsl:value-of select="$titleTableId"/>",'<xsl:value-of select="$summaryTableId"/>','showOrToggle')
            toggle_visibility_by_id('<xsl:value-of select="$detailTableId"/>','<xsl:value-of select="$titleTableIcon"/>')
            toggle_visibility_by_condition("<xsl:value-of select="$detailTableIcon"/>",'<xsl:value-of select="$titleTableIcon"/>',"expandSameStateOrToggle")
            toggle_Img_by_condition('<xsl:value-of select="concat('expandCollapseMainStep',$strStepType,$status)"/>',"showOnly")
          </xsl:attribute>
          <xsl:attribute name="class">clickable</xsl:attribute>
        </xsl:if>
      </img>
      <b>
        <xsl:attribute name="class">
          <xsl:value-of select="$rowStyle"/>
        </xsl:attribute>
        <xsl:choose>
          <xsl:when test = "$status = 'OK' and $hasPrivateWarning > 0" >
            <xsl:value-of select ="../ReportInfo[@Type ='Status' and @Name='WarningPriv']/ReportInformation/Source + ./ReportInformation/Source"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select ="./ReportInformation/Source"/>
          </xsl:otherwise>
        </xsl:choose>

      </b>
    </td>
  </xsl:template>


  <!-- ****************************************************************
		FOR DETAIL : Add the Doc STATUS in the detail section
	**************************************************************** -->
  <xsl:template match ="//ReportInfo[@Type ='MigrationProcess']">
    <xsl:param name ="migrationTagNb"/>
    <xsl:variable name="status">
      <xsl:choose>
        <!-- FOR FBDI REPORT when saved interactively after the graph builder. We need to change the OK doc status to Interrupted -->
        <xsl:when test ="/ReportInfo/ReportInformation/Tag/Code = '1'
									and not(/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/ReportInfo[@Type = 'MigrationStep' and @Name= 'Conversion']/@Status) 
									and /ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/ReportInfo[@Type = 'MigrationStep' and @Name= 'ScopeBuild']/@Status != 'Error' 
									and @Status = 'OK'">
          <xsl:value-of  select="'Interrupted'"/>
        </xsl:when>
        <xsl:when test = "@Status = 'WarningPriv'">
          <xsl:value-of  select="'OK'"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of  select="../../@Status"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="docStatusStyle">
      <xsl:choose>
        <xsl:when test="@Status = 'OK'">defaultModeOK</xsl:when>
        <xsl:when test="@Status = 'Warning'">defaultModeWarning</xsl:when>
        <xsl:when test="@Status = 'Error'">defaultModeError</xsl:when>
        <xsl:otherwise>defaultModeSkipInterrupted</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name ="iconNamePointedBy" select = "concat('expandCollapseDetailPointed By',$migrationTagNb)"/>
    <xsl:variable name ="iconNamePointing" select = "concat('expandCollapseDetailPointing',$migrationTagNb)"/>
    <xsl:variable name ="detailDescTableId" select ="concat('DetailDocument_',$migrationTagNb)" />
    <xsl:variable name ="detailDescTableIcon" select ="concat('expandCollapseDetailDocument_',$migrationTagNb)" />

    <xsl:variable name ="tableDetailIcon" select ="concat('expandCollapseDetail',$status,$migrationTagNb)" />
    <xsl:variable name ="tableTitleIcon" select ="concat('expandCollapseTitle',$status,$migrationTagNb)" />

    <xsl:variable name="docTag">
      <xsl:value-of select="/ReportInfo/ReportInformation/Tag"/>
    </xsl:variable>

    <td  align ="center">
      <xsl:attribute name ="class">
        <xsl:value-of select ="$docStatusStyle"/>
      </xsl:attribute>
      <!-- Pointing information -->
      <xsl:choose>
        <xsl:when test ="( ../ReportInfo[@Type='DocInfo' and @Name = 'IndexOfPointingRep'] ) and (not (($docTag = '1' or $docTag = '7') and /ReportInfo
                  /Children/ReportInfo[@Type = 'DocInfo' and @Name='PackageNum']))">
          <img src ="Data/expand_SB_PointedBy.png">
            <xsl:attribute name="onclick">
              toggle_visibility_by_condition("<xsl:value-of select="$detailDescTableId"/>","<xsl:value-of select="$detailDescTableId"/>","showOrToggle")
              toggle_visibility_by_id("<xsl:value-of select="concat('detailPointed By',$migrationTagNb)"/>","<xsl:value-of select="concat('expandCollapseTitlePointed By',$migrationTagNb)"/>")
              toggle_Img_by_condition("<xsl:value-of select="$iconNamePointedBy"/>","toggle")
              toggle_Img_by_condition("<xsl:value-of select="$detailDescTableIcon"/>","showOnly")

            </xsl:attribute>
            <xsl:attribute name="class">clickable</xsl:attribute>
            <xsl:attribute name="id">
              <xsl:value-of select="$iconNamePointedBy"/>
            </xsl:attribute>
          </img>

          <!-- &#160;-->

        </xsl:when>
        <xsl:otherwise>
          <img src ="Data/SB_None.png"/>
        </xsl:otherwise>
      </xsl:choose>

      <!-- Status -->
      <img>
        <xsl:attribute name ="src">
          <xsl:value-of select="concat('Data\Rep_Status_',$status,'_expand.png')"/>
        </xsl:attribute>
        <xsl:if test ="$status = 'Error' or $status = 'Warning'">
          <xsl:attribute name ="id">
            <xsl:value-of select ="concat('expandCollapseDetail',$status,$migrationTagNb)"/>
          </xsl:attribute>
          <xsl:attribute name="class">clickable</xsl:attribute>
          <xsl:attribute name = "onmouseover" >
            toggle_Img_by_condition("<xsl:value-of select="$tableDetailIcon"/>","toggle")
          </xsl:attribute>
          <xsl:attribute name = "onmouseout" >
            toggle_visibility_by_condition("<xsl:value-of select="$tableDetailIcon"/>",'<xsl:value-of select="$tableTitleIcon"/>',"expandSameStateOrToggle")
          </xsl:attribute>
          <xsl:attribute name="onclick">
            toggle_visibility_by_condition("<xsl:value-of select="$detailDescTableId"/>","<xsl:value-of select="$detailDescTableId"/>","showOrToggle")
            toggle_visibility_by_id("<xsl:value-of select="concat('detail',$status,$migrationTagNb)"/>","<xsl:value-of select="$tableTitleIcon"/>")
            toggle_Img_by_condition("<xsl:value-of select="$tableDetailIcon"/>","toggle")
            toggle_Img_by_condition("<xsl:value-of select="$detailDescTableIcon"/>","showOnly")
          </xsl:attribute>
        </xsl:if>
      </img>
      <!-- Pointed information -->
      <xsl:choose>
        <xsl:when test =" ( ../ReportInfo[@Type='DocInfo' and @Name = 'IndexOfPointedRep'] ) and (not ( ($docTag = '1' or $docTag = '7') and /ReportInfo
                  /Children/ReportInfo[@Type = 'DocInfo' and @Name='PackageNum']))">

          <!--&#160;-->

          <img src ="Data/expand_SB_Pointing.png">
            <xsl:attribute name="onclick">
              toggle_visibility_by_condition("<xsl:value-of select="$detailDescTableId"/>","<xsl:value-of select="$detailDescTableId"/>","showOrToggle")
              toggle_visibility_by_id("<xsl:value-of select="concat('detailPointing',$migrationTagNb)"/>","<xsl:value-of select="concat('expandCollapseTitlePointing',$migrationTagNb)"/>")
              toggle_Img_by_condition("<xsl:value-of select="$iconNamePointing"/>","toggle")
              toggle_Img_by_condition("<xsl:value-of select="$detailDescTableIcon"/>","showOnly")
            </xsl:attribute>
            <xsl:attribute name="class">clickable</xsl:attribute>
            <xsl:attribute name="id">
              <xsl:value-of select="$iconNamePointing"/>
            </xsl:attribute>
          </img>
        </xsl:when>
        <xsl:otherwise>
          <img src ="Data/SB_None.png"/>
        </xsl:otherwise>
      </xsl:choose>
    </td>
  </xsl:template>

  <!--****************************************************************
	  FOR IMPORT SECTION Create Content table for the scope
	**************************************************************** -->
  <xsl:template match="//ReportInfo[@Type='StepInfo' and @Name ='Content']">
    <span>
      <xsl:attribute name ="class">
        <xsl:choose>
          <xsl:when test ="/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/ReportInfo[@Type = 'MigrationStep' and @Name= 'ScopeBuild']/@Status != 'Error'">
            displayHide
          </xsl:when>
          <xsl:otherwise>
            displayShow
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
      <xsl:attribute name="id">
        <xsl:value-of select="'summaryTableScopeBuildContent'"/>
      </xsl:attribute>
      &#160;&#160;
      <b class ="styleStepTableName">
        &#160;Scope Completion&#160;<img src="Data\Step_Sml_ScopeBuild.png"/>&#160;
      </b>
      <table align ="left">
        <tr>
          <td>
            <!-- Just to align with the other table (conversion/save )-->
            <table cellspacing="1" cellpadding="3" align="left" class="objectFBDITable" witdh="100%">
              <!-- Column title definitions -->
              <th width="30"/>
              <th class ="defaultMode" >Type</th>
              <th class ="defaultMode">#</th>

              <!--  Main row for the content -->
              <xsl:for-each select="./Children/ReportInfo[@Type='LateType']">
                <tr>
                  <td/>
                  <td class ="defaultMode">
                    <xsl:value-of select="@Name"/>
                  </td>
                  <td align ="center" class ="defaultMode" >
                    <xsl:value-of select="./ReportInformation/Source"/>
                  </td>
                </tr>
              </xsl:for-each>
            </table>
          </td>
        </tr>
      </table>
    </span>
  </xsl:template>

  <!--****************************************************************
	  FOR IMPORT SECTION Create table for the conversion or save step 
	**************************************************************** -->
  <xsl:template name="CreateTableForStep">

    <!-- AN3 -->
    <xsl:param name ="stepType"/>
    <xsl:param name ="docType"/>
    <xsl:param name ="attributV6List"/>

    <xsl:variable name ="stepStatus" >
      <xsl:choose>
        <xsl:when test = "/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/ReportInfo[@Type='MigrationStep' and @Name = $stepType]/@Status = 'WarningPriv'" >
          <xsl:value-of select ="'OK'"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select ="/ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/ReportInfo[@Type='MigrationStep' and @Name = $stepType]/@Status"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>


    <!-- Test if need to create the table or not -->
    <xsl:if test ="$stepStatus= 'Warning' or $stepStatus = 'Error'">
      <span>
        <xsl:attribute name ="class">
          <xsl:choose>
            <xsl:when test ="$stepStatus != 'Error'">
              displayHide
            </xsl:when>
            <xsl:otherwise>
              displayShow
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="id">
          <xsl:value-of select="concat('summaryTable',$stepType)"/>
        </xsl:attribute>
        <table align="left" >
          <xsl:if test ="$stepType !='ScopeBuild'">
            <th align ="left">
              &#160;&#160;
              <b class ="styleStepTableName">
                &#160;
                <xsl:value-of select="$stepType"/>&#160;
                <img>
                  <xsl:attribute name ="src">
                    <xsl:value-of select ="concat('Data\Step_Sml_',$stepType,'.png')"/>
                  </xsl:attribute>
                </img>&#160;
              </b>
            </th>
          </xsl:if>
          <tr>
            <td>
              <!-- WARNING Table -->
              <xsl:call-template name ="createAnomalyTable">
                <xsl:with-param name="nbOfAnomaly" select = "count(/ReportInfo/Children/ReportInfo[@Type='document']/Children/ReportInfo[@Type='MigrationProcess']
									/Children/ReportInfo[@Type='MigrationStep' and @Name=$stepType]
									/Children/descendant-or-self::ReportInfo[contains(@Type,'RaisedMsg') and @Status = 'Warning' and not(@View = '1')])"/>
                <xsl:with-param name="stepType" select = "$stepType"/>
                <xsl:with-param name="docType" select = "$docType"/>
                <xsl:with-param name="typeOfTable" select = "'Warning'"/>
                <xsl:with-param name ="attributV6List" select = "$attributV6List"/>
                <xsl:with-param name ="raisedMesssageToProcess" select ="/ReportInfo/Children/ReportInfo[@Type='document']/Children/ReportInfo[@Type='MigrationProcess']
									/Children/ReportInfo[@Type='MigrationStep' and @Name=$stepType]
									/Children/descendant-or-self::ReportInfo[@Type='RaisedMsg' and @Status = 'Warning' and not(@View = '1')]
									[not(./ReportInformation/Tag/Code = preceding::ReportInfo[@Type='RaisedMsg' and @Status = 'Warning' and not(@View = '1')]/ReportInformation/Tag/Code)]
								| 
									/ReportInfo/Children/ReportInfo[@Type='document']/Children/ReportInfo[@Type='MigrationProcess']
									/Children/ReportInfo[@Type='MigrationStep' and @Name=$stepType]
									/Children/descendant-or-self::ReportInfo[@Type ='IdOfRaisedMsg' and starts-with(@Status, 'Warning') and not(@View = '1')]
											[not(./ReportInformation/Source = preceding::ReportInfo[@Type= 'IdOfRaisedMsg' and starts-with(@Status, 'Warning')]/ReportInformation/Source)]
											[ (./@Name = //ReportInfo[@Type='RaisedMsg' and not(@View='1')]/@Number)]
									"/>
              </xsl:call-template>
              <!-- Error Table -->
              <xsl:call-template name ="createAnomalyTable">
                <xsl:with-param name="nbOfAnomaly" select = "count(/ReportInfo/Children/ReportInfo[@Type='document']/Children/ReportInfo[@Type='MigrationProcess']
									/Children/ReportInfo[@Type='MigrationStep' and @Name=$stepType]
									/Children/descendant-or-self::ReportInfo[contains(@Type,'RaisedMsg')  and @Status = 'Error' and not(@View = '1') ])"/>
                <xsl:with-param name="stepType" select = "$stepType"/>
                <xsl:with-param name="docType" select = "$docType"/>
                <xsl:with-param name="typeOfTable" select = "'Error'"/>
                <xsl:with-param name ="attributV6List" select = "$attributV6List"/>
                <xsl:with-param name ="raisedMesssageToProcess" select ="/ReportInfo/Children/ReportInfo[@Type='document']/Children/ReportInfo[@Type='MigrationProcess']
									/Children/ReportInfo[@Type='MigrationStep' and @Name=$stepType]
									/Children/descendant-or-self::ReportInfo[@Type='RaisedMsg' and @Status = 'Error' and not(@View = '1')]
									[not(./ReportInformation/Tag/Code = preceding::ReportInfo[@Type='RaisedMsg' and @Status = 'Error' and not(@View = '1')]/ReportInformation/Tag/Code)]
																			| 
									/ReportInfo/Children/ReportInfo[@Type='document']/Children/ReportInfo[@Type='MigrationProcess']
									/Children/ReportInfo[@Type='MigrationStep' and @Name=$stepType]
									/Children/descendant-or-self::ReportInfo[@Type ='IdOfRaisedMsg' and starts-with(@Status, 'Error') and not(@View = '1')]
											[not(./ReportInformation/Source = preceding::ReportInfo[@Type= 'IdOfRaisedMsg' and starts-with(@Status, 'Error')]/ReportInformation/Source)]
											[ (./@Name = //ReportInfo[@Type='RaisedMsg' and not(@View='1')]/@Number)]
									
									"/>
              </xsl:call-template>
            </td>
          </tr>
        </table>
      </span>
    </xsl:if>
  </xsl:template>


  <!--****************************************************************
	  FOR IMPORT SECTION : Create the anomaly table (warning or error)	  
	**************************************************************** -->
  <xsl:template name="createAnomalyTable">
    <xsl:param name="nbOfAnomaly"/>
    <xsl:param name="stepType"/>
    <xsl:param name="typeOfTable"/>
    <xsl:param name="docType"/>
    <xsl:param name="attributV6List"/>
    <xsl:param name ="raisedMesssageToProcess"/>

    <!-- VARIABLES -->
    <xsl:variable name="rowStyle">
      <xsl:value-of select="concat($typeOfTable,'Mode')"/>
    </xsl:variable>

    <xsl:variable name="highlightStyle">
      <xsl:value-of select="concat('highlight',$rowStyle)"/>
    </xsl:variable>

    <xsl:variable name="rowStyleDetail">
      <xsl:value-of select="concat($rowStyle,'Detail')"/>
    </xsl:variable>


    <xsl:variable name="globalMsg" select ="/ReportInfo/Children/ReportInfo[@Type='MigrationProcess']/Children
											/ReportInfo[@Type='MigrationStep' and @Name=$stepType]
											/Children/descendant-or-self::ReportInfo[@Type='RaisedMsg' and @Status = $typeOfTable and not(@View = '1')]
											[not(./ReportInformation/Tag/Code = preceding::ReportInfo[@Type='RaisedMsg' and @Status =$typeOfTable and not(@View = '1')]/ReportInformation/Tag/Code)]"/>
    <xsl:variable name ="nbGlobalAnamaly">
      <xsl:value-of select ="count($globalMsg)"/>
    </xsl:variable>
    <xsl:variable name="titleTableId">
      <xsl:value-of select="concat('summaryTableTitle',$stepType,$typeOfTable)"/>
    </xsl:variable>
    <xsl:variable name="titleTableIcon">
      <xsl:value-of select="concat('expandCollapseTitle',$stepType,$typeOfTable)"/>
    </xsl:variable>
    <xsl:variable name="detailTableId">
      <xsl:value-of select="concat('summaryTableDetail',$stepType,$typeOfTable)"/>
    </xsl:variable>
    <!--	<xsl:variable name="detailTableIcon">
		<xsl:value-of select="concat('expandCollapseDetail',$stepType,$typeOfTable)"/>
    </xsl:variable>		-->

    <xsl:variable name="imgArrowName">
      <xsl:choose>
        <xsl:when test ="$typeOfTable ='Warning'">
          <xsl:value-of select="'expandArrow.png'"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="'collapseArrow.png'"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:if test = "count($raisedMesssageToProcess) or $nbGlobalAnamaly > 0">
      <span >
        <xsl:attribute name="id">
          <xsl:value-of select="$titleTableId"/>
        </xsl:attribute>

        <table class="objectFBDITable" >
          <th width ="30" class ="clickable">
            <img >
              <xsl:attribute name ="src">
                <xsl:value-of select ="concat('Data\',$imgArrowName)"/>
              </xsl:attribute>
              <xsl:attribute name="id">
                <xsl:value-of select="$titleTableIcon"/>
              </xsl:attribute>
              <xsl:attribute name="onclick">
                toggle_visibility_by_id("<xsl:value-of select="$detailTableId"/>","<xsl:value-of select="$titleTableIcon"/>")
                toggle_Img_by_condition("<xsl:value-of select="concat('expandCollapseStep',$stepType,$typeOfTable)"/>","toggle")
              </xsl:attribute>
            </img>
          </th>
          <th align = "center"  width ="350">
            <xsl:attribute name="class">
              <xsl:value-of select="concat($rowStyle, ' clickable')"/>
            </xsl:attribute>
            <xsl:attribute name="onclick">
              toggle_visibility_by_id("<xsl:value-of select="$detailTableId"/>","<xsl:value-of select="$titleTableIcon"/>")
              toggle_Img_by_condition("<xsl:value-of select="concat('expandCollapseStep',$stepType,$typeOfTable)"/>","toggle")
            </xsl:attribute>
            <xsl:value-of select="$typeOfTable"/>
            <xsl:if test ="($nbOfAnomaly+ $nbGlobalAnamaly) > 1">
              s&#160;(<xsl:value-of select="$nbOfAnomaly + $nbGlobalAnamaly"/>)
            </xsl:if>
          </th>
          <tr>
            <td/>
            <td >
              <span>
                <xsl:if test ="$typeOfTable ='Warning'">
                  <xsl:attribute name="class">displayHide</xsl:attribute>
                </xsl:if>
                <xsl:attribute name="id">
                  <xsl:value-of select="$detailTableId"/>
                </xsl:attribute>
                <!-- Create the table for warning / error -->
                <table cellspacing="1" cellpadding="3" align="left" class="objectFBDITable"  witdh="100%" >
                  <!-- Check for "global" error-->
                  <xsl:if test ="count($globalMsg) > 0 " >
                    <tr>
                    </tr>
                    <tr>
                    </tr>
                    <tr>
                      <th colspan ="5" align ="left">
                        <xsl:attribute name="class">
                          <xsl:value-of select="$rowStyle"/>
                        </xsl:attribute>
                        &#160;&#160;&#160;Global <xsl:value-of select="$typeOfTable"/>s
                      </th>
                    </tr>
                    <tr>
                      <th >
                        <xsl:attribute name="class">
                          <xsl:value-of select="$rowStyle"/>
                        </xsl:attribute>#
                      </th>
                      <th>
                        <xsl:attribute name="class">
                          <xsl:value-of select="$rowStyle"/>
                        </xsl:attribute>code
                      </th>
                      <th>
                        <xsl:attribute name="class">
                          <xsl:value-of select="$rowStyle"/>
                        </xsl:attribute>Description
                      </th>

                      <th>
                        <xsl:attribute name="class">
                          <xsl:value-of select="$rowStyle"/>
                        </xsl:attribute>Detail
                      </th>

                    </tr>
                    <xsl:for-each select ="$globalMsg">
                      <tr>
                        <td  align ="center" >
                          <!-- Number of raised message -->
                          <xsl:attribute name="class">
                            <xsl:value-of select="$rowStyle"/>
                          </xsl:attribute>
                          1
                        </td>
                        <td>
                          <!-- INFRA CODE -->
                          <xsl:attribute name="class">
                            <xsl:value-of select="$rowStyle"/> styleNoWrap
                          </xsl:attribute>
                          <xsl:value-of select="./ReportInformation/Tag/Code"/>
                        </td>
                        <td >
                          <!-- Brief description -->
                          <xsl:attribute name="class">
                            <xsl:value-of select="$rowStyle"/>
                          </xsl:attribute>
                          <xsl:value-of select="./ReportInformation/Source"/>
                        </td>
                        <td >
                          <xsl:attribute name="class">
                            <xsl:value-of select="$rowStyle"/>
                          </xsl:attribute>
                          <xsl:apply-templates select="./ReportInformation/Details"/>&#160;
                        </td>
                      </tr>
                    </xsl:for-each>
                  </xsl:if>
                  <xsl:if test = "count($raisedMesssageToProcess) ">
                    <!-- Column title definitions -->
                    <tr/>
                    <tr/>
                    <tr>
                      <th colspan ="5" align ="left">
                        <xsl:attribute name="class">
                          <xsl:value-of select="$rowStyle"/>
                        </xsl:attribute>
                        &#160;&#160;&#160;Document&#160;<xsl:value-of select="$typeOfTable"/>s
                      </th>
                    </tr>
                    <!-- Column title definitions -->
                    <th >
                      <xsl:attribute name="title">Number of errors/warnings</xsl:attribute>
                      <xsl:attribute name="class">
                        <xsl:value-of select="$rowStyle"/>
                      </xsl:attribute>#
                    </th>
                    <th>
                      <xsl:attribute name="class">
                        <xsl:value-of select="$rowStyle"/>
                      </xsl:attribute>code
                    </th>
                    <th>
                      <xsl:if test ="count($globalMsg) > 0 " >
                        <xsl:attribute name="colspan">
                          <xsl:value-of select="3"/>
                        </xsl:attribute>
                        <xsl:attribute name="width">
                          <xsl:value-of select="'100%'"/>
                        </xsl:attribute>
                      </xsl:if>
                      <xsl:attribute name="class">
                        <xsl:value-of select="$rowStyle"/>
                      </xsl:attribute>Description
                    </th>
                  </xsl:if>
                  <!--  Main row for the content -->
                  <!-- Select distinct raised Messages for a given step -->
                  <xsl:for-each select="$raisedMesssageToProcess">
                    <xsl:variable name ="CurrentIdOfRaisedMsg">
                      <xsl:choose>
                        <xsl:when test ="@Type = 'IdOfRaisedMsg'">
                          <xsl:value-of select ="@Name"/>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:value-of select ="@Number"/>
                        </xsl:otherwise>
                      </xsl:choose>
                    </xsl:variable>
                    <xsl:variable name ="infraCode">
                      <xsl:choose>
                        <xsl:when test ="@Type = 'IdOfRaisedMsg'">
                          <xsl:value-of select ="//ReportInfo[@Type='RaisedMsg' and @Number = $CurrentIdOfRaisedMsg and starts-with(@Status, $typeOfTable)]/ReportInformation/Tag/Code"/>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:value-of select ="./ReportInformation/Tag/Code"/>
                        </xsl:otherwise>
                      </xsl:choose>
                    </xsl:variable>
                    <xsl:variable name ="source">
                      <xsl:choose>
                        <xsl:when test ="@Type = 'IdOfRaisedMsg'">
                          <xsl:value-of select ="//ReportInfo[@Type='RaisedMsg' and @Number = $CurrentIdOfRaisedMsg and starts-with(@Status, $typeOfTable) ]/ReportInformation/Source	"/>
                        </xsl:when>
                        <xsl:otherwise>
                          <xsl:value-of select ="./ReportInformation/Source"/>
                        </xsl:otherwise>
                      </xsl:choose>
                    </xsl:variable>


                    <xsl:variable name ="expandCollapseName" select="concat('expandCollapse',$typeOfTable,$infraCode)"/>
                    <xsl:variable name ="importDetailName" select="concat('importDetail',$typeOfTable,$infraCode)"/>
                    <xsl:variable name ="nbOfRaisedMessage">
                      <xsl:value-of select="count(/descendant-or-self::ReportInfo[@Type ='RaisedMsg' and starts-with(@Status, $typeOfTable)][./ReportInformation/Tag/Code = $infraCode])"/>
                    </xsl:variable>


                    <!-- =================== Row with the info about the distinct raised msg -->
                    <tr >
                      <xsl:attribute name="onclick">
                        toggle_visibility_by_id("<xsl:value-of select="$importDetailName"/>","<xsl:value-of select="$expandCollapseName"/>")
                      </xsl:attribute>
                      <xsl:attribute name="class">
                        clickable
                      </xsl:attribute>
                      <td  align ="center" >
                        <!-- Number of raised message -->
                        <xsl:attribute name="class">
                          <xsl:value-of select="$rowStyle"/>
                        </xsl:attribute>
                        <xsl:choose>
                          <xsl:when test ="$nbOfRaisedMessage > 1">
                            <xsl:value-of select="$nbOfRaisedMessage"/>
                          </xsl:when>
                          <xsl:otherwise>1</xsl:otherwise>
                        </xsl:choose>

                      </td>
                      <td>
                        <!-- INFRA CODE -->
                        <xsl:attribute name="class">
                          <xsl:value-of select="$rowStyle"/> styleNoWrap
                        </xsl:attribute>
                        <xsl:attribute name="onmouseover">
                          this.className='<xsl:value-of select="$highlightStyle"/> styleNoWrap'
                        </xsl:attribute>
                        <xsl:attribute name="onmouseout">
                          this.className= '<xsl:value-of select="$rowStyle"/> styleNoWrap'
                        </xsl:attribute>
                        <img src="Data\expandArrow.png">
                          <xsl:attribute name="id">
                            <xsl:value-of select="$expandCollapseName"/>
                          </xsl:attribute>
                        </img>
                        &#160;
                        <xsl:value-of select="$infraCode"/>
                        <xsl:if test ="$infraCode=''">
                          <i>missing</i>
                        </xsl:if>
                      </td>
                      <td >
                        <!-- Brief description -->
                        <xsl:if test ="count($globalMsg) > 0 " >
                          <xsl:attribute name="colspan">
                            <xsl:value-of select="3"/>
                          </xsl:attribute>
                        </xsl:if>
                        <xsl:attribute name="class">
                          <xsl:value-of select="$rowStyle"/>
                        </xsl:attribute>
                        <xsl:value-of select="$source"/>
                        <xsl:if test ="$nbOfRaisedMessage > 1">
                          &#160;<i>
                            <b>...</b>
                          </i>
                        </xsl:if>
                      </td>
                    </tr>
                    <!-- ===================  Details of the warning/error -->
                    <tr>
                      <td>
                        <xsl:attribute name ="colspan">
                          <xsl:choose>
                            <xsl:when test="count($globalMsg) > 0">
                              4
                            </xsl:when>
                            <xsl:otherwise>
                              3
                            </xsl:otherwise>
                          </xsl:choose>
                        </xsl:attribute>
                        <span class ="displayHide">
                          <xsl:attribute name="id">
                            <xsl:value-of select="$importDetailName"/>
                          </xsl:attribute>
                          <table align="left" width= "100%">
                            <!-- Column title definitions  HEADER-->
                            <th width ="10">
                              <img src="Data\TableDetailArrow.png" />
                            </th>
                            <th width= "30" >
                              <xsl:attribute name="class">
                                <xsl:value-of select="'detailMode'"/>
                              </xsl:attribute>#
                            </th>
                            <th class ="defaultMode">
                              <xsl:attribute name="class">
                                <xsl:value-of select="'detailMode'"/>
                              </xsl:attribute>
                              <xsl:choose>
                                <xsl:when test="starts-with($docType, 'DBDI')">
                                  <xsl:attribute name="colspan">
                                    <xsl:value-of select="count($attributV6List)"/>
                                  </xsl:attribute>
                                  Representation
                                </xsl:when>
                                <xsl:otherwise>
                                  Document
                                </xsl:otherwise>
                              </xsl:choose>
                            </th>
                            <xsl:if test="$nbOfRaisedMessage > 0">
                              <th>
                                <xsl:attribute name="class">
                                  <xsl:value-of select="'detailMode'"/>
                                </xsl:attribute>Description
                              </th>
                            </xsl:if>
                            <th>
                              <xsl:attribute name="class">
                                <xsl:value-of select="'detailMode'"/>
                              </xsl:attribute>Detail
                            </th>

                            <xsl:if test="starts-with($docType, 'DBDI')">
                              <!-- Second level of title -->
                              <tr>
                                <td/>
                                <td class ="unUsedDetailTitleCell">&#160; </td>
                                <xsl:for-each select="$attributV6List">
                                  <td class ="detailModeTitleLevel2">
                                    <xsl:value-of select="@Name"/>
                                  </td>
                                </xsl:for-each>
                                <xsl:if test="$nbOfRaisedMessage > 0">
                                  <td class ="unUsedDetailTitleCell">&#160; </td>
                                </xsl:if>
                                <td class ="unUsedDetailTitleCell">&#160; </td>
                              </tr>
                            </xsl:if>

                            <!-- ===================Display the detail for each raised message by document -->
                            <xsl:for-each select="/descendant-or-self::ReportInfo[@Type ='document'][./descendant::ReportInfo[@Type='RaisedMsg' and starts-with(@Status, $typeOfTable)]/ReportInformation/Tag/Code = $infraCode]">
                              <xsl:variable name ="nbOfMsgInCurrentDoc" select="count(./descendant::ReportInfo[@Type='RaisedMsg' and starts-with(@Status, $typeOfTable)][./ReportInformation/Tag/Code = $infraCode])"/>
                              <xsl:variable name ="oneRaisedMsgNumber" select="./descendant::ReportInfo[@Type='RaisedMsg' and starts-with(@Status, $typeOfTable)][./ReportInformation/Tag/Code = $infraCode]
												[not(./ReportInformation/Tag/Code = preceding-sibling::ReportInfo[@Type='RaisedMsg' and starts-with(@Status, $typeOfTable)]/ReportInformation/Tag/Code)]/@Number"/>
                              <xsl:variable name ="migrationTagNb">
                                <xsl:value-of select ="./LinkInformation/MigrationTagName"/>
                              </xsl:variable>
                              <xsl:variable name ="migrationTagName">
                                <xsl:value-of select ="concat('Document_',./LinkInformation/MigrationTagName)"/>
                              </xsl:variable>
                              <xsl:variable name ="detailTagName" select="concat('Detail',$migrationTagName)"/>
                              <xsl:variable name ="attrListName">
                                <xsl:choose>
                                  <xsl:when test="$stepType ='ScopeBuild'" >
                                    <xsl:value-of select ="'AttrV5TreeMask'"/>
                                  </xsl:when>
                                  <xsl:otherwise>
                                    <xsl:value-of select ="'AttrV6TreeMask'"/>
                                  </xsl:otherwise>
                                </xsl:choose>
                              </xsl:variable>
                              <xsl:variable name="HasDetail" select="count(./descendant::ReportInfo[@Type='RaisedMsg' and starts-with(@Status, $typeOfTable)][./ReportInformation/Tag/Code = $infraCode][./ReportInformation/Details/Detail])"/>
                              <xsl:variable name ="CurrentSource">
                                <xsl:value-of select ="./descendant::ReportInfo[@Type='RaisedMsg' and starts-with(@Status, $typeOfTable) and @Number = $oneRaisedMsgNumber]/ReportInformation/Source"/>
                              </xsl:variable>
                              <xsl:variable name ="nbOfSameSource">
                                <xsl:value-of select="count(./descendant::ReportInfo[@Type ='RaisedMsg' and starts-with(@Status, $typeOfTable)][./ReportInformation/Source = $CurrentSource])"/>
                              </xsl:variable>
                              <xsl:variable name ="realRowSpan">
                                <xsl:choose>
                                  <xsl:when test="$HasDetail = 0 and $nbOfSameSource &gt; 1" >1</xsl:when>
                                  <xsl:otherwise>
                                    <xsl:value-of select ="$nbOfMsgInCurrentDoc"/>
                                  </xsl:otherwise>
                                </xsl:choose>
                              </xsl:variable>
                              <tr>
                                <!--********** Empty cell (Arrow detail image)-->
                                <td>
                                  <xsl:attribute name="rowspan">
                                    <xsl:value-of select="$realRowSpan"/>
                                  </xsl:attribute>
                                </td>
                                <!--**********  Number of occurence for the raised message in this doc/rep -->
                                <td align = "center" >
                                  <xsl:attribute name="rowspan">
                                    <xsl:value-of select="$realRowSpan"/>
                                  </xsl:attribute>
                                  <xsl:attribute name="class">
                                    <xsl:value-of select="$rowStyleDetail"/>
                                  </xsl:attribute>
                                  <xsl:value-of select="$nbOfMsgInCurrentDoc"/>
                                </td>
                                <!--**********  Mask Tree attribut or doc path name -->
                                <xsl:choose>
                                  <xsl:when test="starts-with($docType, 'DBDI')">
                                    <!-- Mask tree attribut-->
                                    <xsl:for-each select="./Children/ReportInfo[@Type ='DocInfo' and @Name = $attrListName]/Children/ReportInfo[@Type='Attribut']">
                                      <A>
                                        <xsl:attribute name="href">
                                          #<xsl:value-of select="$migrationTagName"/>
                                        </xsl:attribute>
                                        <td>

                                          <xsl:attribute name="class">
                                            <xsl:value-of select="$rowStyleDetail"/>  clickable'
                                          </xsl:attribute>

                                          <xsl:attribute name="onmouseover">
                                            this.className='<xsl:value-of select="$rowStyle"/> clickable'
                                          </xsl:attribute>
                                          <xsl:attribute name="onmouseout">
                                            this.className= '<xsl:value-of select="$rowStyleDetail"/> clickable'
                                          </xsl:attribute>
                                          <xsl:attribute name="onclick">
                                            expand_detail_by_id("<xsl:value-of select="$detailTagName"/>")
                                            toggle_visibility_by_condition("<xsl:value-of select="concat('detail',$typeOfTable,$migrationTagNb)"/>","<xsl:value-of select="$detailTagName"/>","showOrToggle")
                                            toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseTitle',$typeOfTable,$migrationTagNb)"/>","<xsl:value-of select="$detailTagName"/>","showOrToggle")
                                            toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseDetail',$typeOfTable,$migrationTagNb)"/>","<xsl:value-of select="$detailTagName"/>","showOrToggle")
                                          </xsl:attribute>
                                          <xsl:attribute name="rowspan">
                                            <xsl:value-of select="$realRowSpan"/>
                                          </xsl:attribute>
                                          <xsl:value-of select="./ReportInformation/Source"/>
                                          <xsl:if test = "string-length(./ReportInformation/Source/text()) = 0">
                                            &#160;
                                          </xsl:if>

                                        </td>
                                      </A>
                                    </xsl:for-each>
                                  </xsl:when>
                                  <xsl:otherwise>
                                    <A>
                                      <xsl:attribute name="href">
                                        #<xsl:value-of select="$migrationTagName"/>
                                      </xsl:attribute>
                                      <td >
                                        <xsl:attribute name="class">
                                          <xsl:value-of select="$rowStyleDetail"/>  clickable'
                                        </xsl:attribute>

                                        <xsl:attribute name="onmouseover">
                                          this.className='<xsl:value-of select="$rowStyle"/> clickable'
                                        </xsl:attribute>
                                        <xsl:attribute name="onmouseout">
                                          this.className= '<xsl:value-of select="$rowStyleDetail"/> clickable'
                                        </xsl:attribute>
                                        <xsl:attribute name="onclick">
                                          expand_detail_by_id("<xsl:value-of select="$detailTagName"/>")
                                          toggle_visibility_by_condition("<xsl:value-of select="concat('detail',$typeOfTable,$migrationTagNb)"/>","<xsl:value-of select="$detailTagName"/>","showOrToggle")
                                          toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseTitle',$typeOfTable,$migrationTagNb)"/>","<xsl:value-of select="$detailTagName"/>","showOrToggle")
                                          toggle_visibility_by_condition("<xsl:value-of select="concat('expandCollapseDetail',$typeOfTable,$migrationTagNb)"/>","<xsl:value-of select="$detailTagName"/>","showOrToggle")
                                        </xsl:attribute>
                                        <xsl:attribute name="rowspan">
                                          <xsl:value-of select="$realRowSpan"/>
                                        </xsl:attribute>
                                        <xsl:value-of select="./ReportInformation/Source"/>
                                      </td>
                                    </A>
                                  </xsl:otherwise>
                                </xsl:choose>
                                <!--**********  Description  -->
                                <xsl:if test="$nbOfRaisedMessage > 0">
                                  <td>
                                    <xsl:attribute name="class">
                                      <xsl:value-of select="$rowStyleDetail"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="./descendant::ReportInfo[@Type='RaisedMsg' and @Number = $oneRaisedMsgNumber]/ReportInformation/Source"/>&#160;
                                  </td>
                                </xsl:if>
                                <!--**********  Details  -->
                                <td >
                                  <xsl:attribute name="class">
                                    <xsl:value-of select="$rowStyleDetail"/>
                                  </xsl:attribute>
                                  <xsl:apply-templates select="./descendant::ReportInfo[@Type='RaisedMsg' and @Number = $oneRaisedMsgNumber]/ReportInformation/Details"/>		&#160;
                                </td>
                              </tr>
                              <!--**********  Loops for the raised number, description and details of all the other raised messages
															having the same infra code as the current message, for the current document.-->
                              <xsl:if test="$nbOfMsgInCurrentDoc &gt; 1">
                                <xsl:variable name ="currentDesc" select="./descendant::ReportInfo[@Type='RaisedMsg' and @Number = $oneRaisedMsgNumber]/ReportInformation/Source"/>
                                <xsl:for-each select="./descendant::ReportInfo[@Type='RaisedMsg' and @Number != $oneRaisedMsgNumber][./ReportInformation/Tag/Code = $infraCode]">
                                  <xsl:variable name ="nextDesc" select="./ReportInformation/Source"/>
                                  <xsl:if test="($HasDetail = 0 and $currentDesc != $nextDesc) or ($HasDetail &gt; 0)">
                                    <tr>
                                      <xsl:if test="$nbOfRaisedMessage > 0">
                                        <td>
                                          <!--**********  Description   in same doc  -->
                                          <xsl:attribute name="class">
                                            <xsl:value-of select="$rowStyleDetail"/>
                                          </xsl:attribute>
                                          <xsl:value-of select="./ReportInformation/Source"/>	&#160;
                                        </td>
                                      </xsl:if>
                                      <!--**********  Details   in same doc  -->
                                      <td >
                                        <xsl:attribute name="class">
                                          <xsl:value-of select="$rowStyleDetail"/>
                                        </xsl:attribute>
                                        <xsl:apply-templates select="./ReportInformation/Details"/>	&#160;
                                      </td>
                                    </tr>
                                  </xsl:if>
                                </xsl:for-each>
                              </xsl:if>
                            </xsl:for-each>
                          </table>
                        </span>
                      </td>
                    </tr>

                  </xsl:for-each>
                </table>
              </span>
            </td>
          </tr>
        </table>
      </span>
    </xsl:if>
  </xsl:template>

  <!--****************************************************************
	  Create the expands collapse  buttons :(ALL , WARNING , ERROR)
	  Appears in the document details information.
	**************************************************************** -->
  <xsl:template name="createExpandCollapse">
    <xsl:param name="strDocType"/>
    <xsl:variable name="docErrorExist" select ="count(/ReportInfo/Children/ReportInfo[@Type='MigrationProcess']
								/descendant::ReportInfo[@Type='StepInfo'  and @Name='NbRepByStatus']/Children
								/ReportInfo[@Type ='Status' and @Name='Error'])"/>
    <xsl:variable name="docWngExist" select ="count(/ReportInfo/Children/ReportInfo[@Type='MigrationProcess']
								/descendant::ReportInfo[@Type='StepInfo'  and @Name='NbRepByStatus']/Children
								/ReportInfo[@Type ='Status' and @Name='Warning'])"/>

    <table class = "objectFBDITable">
      <tr>
        <xsl:if test="count(/ReportInfo/Children/ReportInfo[@Type='document']) > 1">
          <td> Expand/Collapse : </td>
          <xsl:call-template name="createExpandCollapseTable">
            <xsl:with-param name="typeOfExpand" select="'ALL'"/>
            <xsl:with-param name="strDocType" select="$strDocType"/>
          </xsl:call-template>
          <xsl:if test="$docWngExist > 0">
            <xsl:call-template name="createExpandCollapseTable">
              <xsl:with-param name="typeOfExpand" select="'Warning'"/>
            </xsl:call-template>
          </xsl:if>
          <xsl:if test="($docErrorExist)> 0">
            <xsl:call-template name="createExpandCollapseTable">
              <xsl:with-param name="typeOfExpand" select="'Error'"/>
            </xsl:call-template>
          </xsl:if>
        </xsl:if>
        <!--  Display the combo box for level filter -->
        <xsl:if test="starts-with($strDocType, 'DBDI_Scope') and /ReportInfo/Children/ReportInfo[@Type='document']
								/Children/ReportInfo[@Type='DocInfo' and @Name='ScopeLevel']">
          <td align ="right" width="100">Level Filter:</td>
          <td class="level_1" >
            <xsl:variable name="unique-list" select="/ReportInfo/Children/ReportInfo[@Type='document']/Children/ReportInfo[@Type='DocInfo' and @Name='ScopeLevel']/ReportInformation/Source
				[not(./text() = preceding::ReportInfo[@Type='DocInfo' and @Name='ScopeLevel']/ReportInformation/Source)]
				" />
            <select id="comment_type" name="comment_type">
              <option value="ALL" selected="true">ALL</option>
              <xsl:for-each select="$unique-list">
                <xsl:sort  order="ascending" data-type="text" />
                <option value="{.}">
                  <xsl:value-of select="." />
                </option>
              </xsl:for-each>
            </select>
            &#160;
            <input type="button" value="Apply">
              <xsl:attribute name="onclick">
                toggle_visibility_by_labelname('comment_type')
              </xsl:attribute>
            </input>
          </td>
        </xsl:if>
      </tr>
    </table>
  </xsl:template>

  <xsl:template name="createExpandCollapseTable">
    <xsl:param name="typeOfExpand"/>
    <xsl:param name="strDocType"/>

    <xsl:variable name="imgNameExpand">
      <xsl:value-of select="concat('expandCollapse',$typeOfExpand,'X')"/>
    </xsl:variable>

    <xsl:variable name="imgNameCollapse">
      <xsl:value-of select="concat('expandCollapse',$typeOfExpand,'C')"/>
    </xsl:variable>

    <xsl:variable name="filterString">
      <xsl:choose>
        <xsl:when test="$typeOfExpand = 'ALL'">
          <xsl:value-of select="'detail'"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="concat('detail',$typeOfExpand)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <td class ="styleAction" width = "80" align ="right">
      <xsl:value-of select="$typeOfExpand"/>
    </td>
    <td align ="center" class="clickable" onmouseover="this.className='highlightFilterMode clickable';" onmouseout="this.className='clickable';">
      <xsl:attribute name="onclick">
        toggle_visibility_by_classname_fexp('<xsl:value-of select="$filterString"/>','<xsl:value-of select="$imgNameExpand"/>')
        <!--	toggleImageOnClick("1001","Data\\TableDetailArrow1.jpg") -->
        <xsl:if test="$typeOfExpand = 'ALL'">
          <xsl:for-each select="/ReportInfo/Children/ReportInfo/LinkInformation">



            <xsl:variable name="MigrationTabN">
              <xsl:value-of select="./MigrationTagName"/>
            </xsl:variable>

            toggle_Img_by_condition('<xsl:value-of select="concat('expandCollapseTitle','Pointed By',$MigrationTabN)"/>',"showOnly")
            toggle_Img_by_condition('<xsl:value-of select="concat('expandCollapseTitle','Pointing',$MigrationTabN)"/>',"showOnly")
            toggle_Img_by_condition('<xsl:value-of select="concat('expandCollapseTitle','Warning',$MigrationTabN)"/>',"showOnly")


          </xsl:for-each>
        </xsl:if>
        <xsl:if test="$typeOfExpand = 'Warning'">
          <xsl:for-each select="/ReportInfo/Children/ReportInfo/LinkInformation">



            <xsl:variable name="MigrationTabN">
              <xsl:value-of select="./MigrationTagName"/>
            </xsl:variable>


            toggle_visibility_by_condition('<xsl:value-of select="concat('detailWarning',$MigrationTabN)"/>','<xsl:value-of select="concat('detailWarning',$MigrationTabN)"/>',"showOrToggle")
            toggle_Img_by_condition('<xsl:value-of select="concat('expandCollapseTitle','Warning',$MigrationTabN)"/>',"showOnly")
            toggle_Img_by_condition('<xsl:value-of select="concat('expandCollapseDetail','Warning',$MigrationTabN)"/>',"showOnly")

          </xsl:for-each>
        </xsl:if>

      </xsl:attribute>
      <img src="Data\expandArrow.png" class="clickable">
        <xsl:attribute name="id">
          <xsl:value-of select="$imgNameExpand"/>
        </xsl:attribute>
      </img>
    </td>
    <td align ="center" class="clickable" onmouseover="this.className='highlightFilterMode clickable';" onmouseout="this.className='clickable';">
      <xsl:attribute name="onclick">
        toggle_visibility_by_classname_fexp('<xsl:value-of select="$filterString"/>','<xsl:value-of select="$imgNameCollapse"/>')
        <xsl:if test="$typeOfExpand = 'ALL'">
          <xsl:for-each select="/ReportInfo/Children/ReportInfo/LinkInformation">



            <xsl:variable name="MigrationTabNb">
              <xsl:value-of select="./MigrationTagName"/>
            </xsl:variable>

            toggle_Img_by_condition('<xsl:value-of select="concat('expandCollapseTitle','Pointed By',$MigrationTabNb)"/>',"hideOnly")
            toggle_Img_by_condition("<xsl:value-of select="concat('expandCollapseTitle','Pointing',$MigrationTabNb)"/>","hideOnly")
            toggle_Img_by_condition('<xsl:value-of select="concat('expandCollapseTitle','Warning',$MigrationTabNb)"/>',"hideOnly")

          </xsl:for-each>
        </xsl:if>

        <xsl:if test="$typeOfExpand = 'Warning'">
          <xsl:for-each select="/ReportInfo/Children/ReportInfo/LinkInformation">



            <xsl:variable name="MigrationTabN">
              <xsl:value-of select="./MigrationTagName"/>
            </xsl:variable>


            toggle_visibility_by_condition('<xsl:value-of select="concat('detailWarning',$MigrationTabN)"/>','<xsl:value-of select="concat('detailWarning',$MigrationTabN)"/>',"hideOnly")
            toggle_Img_by_condition('<xsl:value-of select="concat('expandCollapseTitle','Warning',$MigrationTabN)"/>',"hideOnly")
            toggle_Img_by_condition('<xsl:value-of select="concat('expandCollapseDetail','Warning',$MigrationTabN)"/>',"hideOnly")

          </xsl:for-each>
        </xsl:if>

      </xsl:attribute>
      <img src="Data\collapseArrow.png" class="clickable">
        <xsl:attribute name="id">
          <xsl:value-of select="$imgNameCollapse"/>
        </xsl:attribute>
      </img>
    </td>
  </xsl:template>


  <!--****************************************************************
					Section DETAILS Package Information
	**************************************************************** -->
  <xsl:template name="DetailInfoPackage">
    <xsl:param name="paramDocType"/>
    <xsl:variable name ="attrV6List" select ="/descendant::ReportInfo[@Type='document'][1]/Children
					/ReportInfo[@Type='DocInfo' and @Name ='AttrV6TreeMask']/Children
					/ReportInfo[@Type='Attribut']"/>
    <xsl:variable name ="docNameWithReport" select ="substring-before(/ReportInfo/ReportInformation/Details/Detail,'_Report.xml')"/>


    <!-- Details table -->

    <table align="center">

      <xsl:if test ="not(starts-with($paramDocType, 'FBDI_Split'))">
        <!-- AN3 : The Start , end and duration time  -->
        <tr >
          <td id ="TimeInfo" class ="displayHide" align ="right" >
            <table class ="styleTimeInfo">
              <tr >
                <td align = "right">
                  <i>Start time :</i>
                </td>
                <td>
                  <i>
                    <xsl:value-of select="/ReportInfo/Children/ReportInfo[@Type = 'TimeInfo' and @Name= 'StartTime']/ReportInformation/Source"/>
                  </i>
                  <br/>

                </td>
                <xsl:if test ="/ReportInfo/Children/ReportInfo[@Type = 'TimeInfo' and @Name= 'ConvertDuration']">
                  <td width ="50"></td>
                  <td/>
                  <td/>
                </xsl:if>

              </tr>
              <xsl:if test ="/ReportInfo/Children/ReportInfo[@Type = 'TimeInfo' and @Name= 'EndTime']">
                <tr >
                  <td align = "right" >
                    <i>End time :</i>
                  </td>
                  <td>
                    <i>
                      <xsl:value-of select="/ReportInfo/Children/ReportInfo[@Type = 'TimeInfo' and @Name= 'EndTime']/ReportInformation/Source"/>
                    </i>
                    <br/>
                  </td>
                  <xsl:if test ="/ReportInfo/Children/ReportInfo[@Type = 'TimeInfo' and @Name= 'ExecutionTime']">
                    <td/>
                    <td align = "right" >
                      <i>
                        <b>Duration :</b>
                      </i>
                    </td>
                    <td >
                      <i>
                        <b>
                          <xsl:value-of select="/ReportInfo/Children/ReportInfo[@Type = 'TimeInfo' and @Name= 'ExecutionTime']/ReportInformation/Source"/>
                        </b>
                      </i>
                    </td>
                  </xsl:if>
                </tr>
              </xsl:if>
              <xsl:if test ="/ReportInfo/Children/ReportInfo[@Type = 'TimeInfo' and @Name= 'ConvertDuration']">
                <tr>
                  <td/>
                  <td/>
                  <td/>
                  <td align = "right">
                    <i>Convert :</i>
                  </td>
                  <td>
                    <i>
                      <xsl:value-of select="/ReportInfo/Children/ReportInfo[@Type = 'TimeInfo' and @Name= 'ConvertDuration']/ReportInformation/Source"/>
                    </i>
                    <br/>

                  </td>
                </tr>
              </xsl:if>
              <xsl:if test ="/ReportInfo/Children/ReportInfo[@Type = 'TimeInfo' and @Name= 'SaveDuration']">
                <tr>
                  <td/>
                  <td/>
                  <td/>
                  <td align = "right">
                    <i>Save :</i>
                  </td>
                  <td>
                    <i>
                      <xsl:value-of select="/ReportInfo/Children/ReportInfo[@Type = 'TimeInfo' and @Name= 'SaveDuration']/ReportInformation/Source"/>
                    </i>
                    <br/>

                  </td>
                </tr>
              </xsl:if>

            </table>
          </td>
        </tr>
      </xsl:if>
    </table>
    <table cellspacing="1" cellpadding="3" align="center" class="objectFBDITable" >
      <!-- Table header -->
      <th/>
      <th class ="defaultmode">Package</th>
      <th class ="defaultmode">Content</th>
      <th class ="defaultmode">Scope</th>
      <th class ="defaultmode">Conversion</th>
      <th class ="defaultmode">Save</th>
      <th class ="defaultmode">TimeInfo</th>

      <!-- Show the packages that were already done or ongoing -->
      <xsl:for-each select="/ReportInfo/Children/ReportInfo[@Type='Package']">
        <xsl:variable name ="docErrorConversionStep" select ="./Children/ReportInfo[@Type='document' and @Status='Error' and not(@View = '1')]"/>

        <xsl:variable name ="globalErrorConversionStep" select ="./Children/ReportInfo[@Type='MigrationProcess']
														/Children/ReportInfo[@Type='MigrationStep' and @Name='Conversion']
														/descendant::ReportInfo[@Type='RaisedMsg' and @Status='Error' and not(@View = '1') ]"/>
        <xsl:variable name ="globalErrorSaveStep" select ="./Children/ReportInfo[@Type='MigrationProcess']
														/Children/ReportInfo[@Type='MigrationStep' and @Name='Save']
														/descendant::ReportInfo[@Type='RaisedMsg' and @Status='Error' and not(@View = '1')]"/>
        <!-- Variable -->
        <xsl:variable name ="packageStatus" select="./@Status"/>
        <xsl:variable name ="packageNumber" select="./@Name"/>
        <xsl:variable name ="packReportPath" select ="concat('./PackageDir',$packageNumber,'/',$docNameWithReport,$packageNumber,'_Report.xml')"/>
        <xsl:variable name ="styleCell">
          <xsl:choose>
            <xsl:when test ="$packageStatus !='Unknown'">
              <xsl:value-of select="'defaultModeGlobal'"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="'defaultMode'"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:choose>
          <xsl:when test ="./Children/ReportInfo[@Type ='PackInfo' and @Name ='Launched']">
            <!-- Start of the row -->
            <tr>
              <xsl:choose>
                <xsl:when test ="$packageStatus !='Unknown'">
                  <td/>
                </xsl:when>
                <xsl:otherwise>
                  <td>
                    <img src ="Data/Package_Go.png"/>
                  </td>
                </xsl:otherwise>
              </xsl:choose>


              <!-- Package Number -->
              <A >
                <xsl:attribute name="id">
                  <xsl:value-of select ="$packageNumber"/>
                </xsl:attribute>

                <xsl:if test ="$packageStatus !='Unknown'">
                  <xsl:attribute name="href">
                    <xsl:choose>
                      <xsl:when test ="starts-with($paramDocType, 'FBDI_Split')">
                        <xsl:value-of select ="$packReportPath"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:choose>
                          <xsl:when test ="/ReportInfo/Children/ReportInfo[@Type='Info' and @Name='NbOfPackages']/ReportInformation/Source > 1">
                            <xsl:value-of select ="concat('./DBDIRepConversion',$packageNumber,'.xml')"/>
                          </xsl:when>
                          <xsl:otherwise>
                            <xsl:value-of select ="'./DBDIRepConversion.xml'"/>
                          </xsl:otherwise>
                        </xsl:choose>
                      </xsl:otherwise>
                    </xsl:choose>

                  </xsl:attribute>
                </xsl:if>
                <td align ="center">
                  <xsl:if test="$packageStatus !='Unknown'">
                    <xsl:attribute name="onclick">
                      Change_Document_By_id("<xsl:value-of select ="$packageNumber"/>")
                    </xsl:attribute>
                  </xsl:if>
                  <xsl:if test="$packageStatus ='Unknown'">
                    <xsl:attribute name="title">Unknown Error. Go to HTML Report in package directory for more detail</xsl:attribute>
                  </xsl:if>
                  <xsl:if test ="$packageStatus !='Unknown'">
                    <xsl:attribute name="onmouseover">
                      this.className='highlightDefaultMode clickable'
                    </xsl:attribute>
                    <xsl:attribute name="onmouseout">
                      this.className= '<xsl:value-of select="$styleCell"/> clickable'
                    </xsl:attribute>
                  </xsl:if>
                  <xsl:attribute name="class">
                    <xsl:if test ="$packageStatus !='Unknown'">
                      <xsl:value-of select="$styleCell"/>
                    </xsl:if>
                    <xsl:if test ="$packageStatus ='Unknown'">
                      <xsl:value-of select="'defaultModeRedTitle'"/>
                    </xsl:if>
                  </xsl:attribute>
                  <xsl:choose>
                    <xsl:when test ="$packageStatus !='Unknown'">
                      <u class="styleAction">
                        <xsl:value-of select="$packageNumber"/>
                      </u>
                    </xsl:when>
                    <xsl:otherwise>
                      <b class="styleAction" >
                        <xsl:value-of select="$packageNumber"/>
                      </b>

                    </xsl:otherwise>
                  </xsl:choose>

                </td>
              </A>
              <!-- Content -->
              <td >
                <xsl:attribute name="class">
                  <xsl:value-of select="$styleCell"/>
                </xsl:attribute>
                <xsl:for-each select ="./Children/ReportInfo[@Type ='PackInfo' and @Name='Content']/Children/ReportInfo[@Type='LateType']">
                  <xsl:value-of select="./ReportInformation/Source"/>&#160;<xsl:value-of select="./@Name"/>
                  <br/>
                </xsl:for-each>
              </td>
              <!-- ScopeBuilder Status -->
              <xsl:call-template name ="AddPackageStepStatus">
                <xsl:with-param name = "styleCell" select="$styleCell"/>
                <xsl:with-param name = "packageStatus" select="$packageStatus"/>
                <xsl:with-param name = "stepStatus" select="./Children/ReportInfo[@Type='MigrationProcess']/Children
												/ReportInfo[@Type='MigrationStep' and @Name ='ScopeBuild']/@Status"/>
                <xsl:with-param name = "packNum" select="$packageNumber"/>
              </xsl:call-template>
              <!-- Conversion Status -->
              <xsl:call-template name ="AddPackageStepStatus">
                <xsl:with-param name = "styleCell" select="$styleCell"/>
                <xsl:with-param name = "packageStatus" select="$packageStatus"/>
                <xsl:with-param name = "stepStatus" select="./Children/ReportInfo[@Type='MigrationProcess']/Children
												/ReportInfo[@Type='MigrationStep' and @Name ='Conversion']/@Status"/>
                <xsl:with-param name = "packNum" select="$packageNumber"/>
              </xsl:call-template>
              <!-- Save Status -->
              <xsl:call-template name ="AddPackageStepStatus">
                <xsl:with-param name = "styleCell" select="$styleCell"/>
                <xsl:with-param name = "packageStatus" select="$packageStatus"/>
                <xsl:with-param name = "stepStatus" select="./Children/ReportInfo[@Type='MigrationProcess']/Children
												/ReportInfo[@Type='MigrationStep' and @Name ='Save']/@Status"/>
                <xsl:with-param name = "packNum" select="$packageNumber"/>
              </xsl:call-template>


              <!-- Time Info  -->
              <td  >
                <xsl:attribute name="class">
                  <xsl:value-of select="$styleCell"/>
                </xsl:attribute>
                <xsl:if test ="$packageStatus !='Unknown' ">
                  Start : <xsl:value-of select="./Children/ReportInfo[@Type='MigrationProcess']/Children/ReportInfo[@Type='TimeInfo' and @Name='StartTime']/ReportInformation/Source"/>
                  <br/>
                  Duration : <xsl:value-of select="./Children/ReportInfo[@Type='MigrationProcess']/Children/ReportInfo[@Type='TimeInfo' and @Name='ExecutionTime']/ReportInformation/Source"/>
                </xsl:if>
                <xsl:if test ="$packageStatus ='Unknown' ">
                  -
                </xsl:if>
              </td>
            </tr>

            <!-- Add the detail for failing conversion or Save -->
            <xsl:if test ="./Children/ReportInfo[@Type='MigrationProcess']/@Status = 'Error'">
              <tr>
                <td/>
                <td colspan ="5" >
                  <span class ="displayHide">
                    <xsl:attribute name="id">
                      <xsl:value-of select="concat('packageDetail',$packageNumber)"/>
                    </xsl:attribute>
                    <!-- Error linked to a document-->

                    <xsl:if test ="count($docErrorConversionStep) > 0">
                      <table cellspacing="1" cellpadding="3" class="objectFBDITable" width="100%">
                        <!-- Conversion Error-->
                        <!-- If there reportinfo of type document, this means that the conversion failed.-->
                        <th/>
                        <th class ="detailmode">
                          <xsl:attribute name ="colspan">
                            <xsl:value-of select="count($attrV6List)"/>
                          </xsl:attribute>
                          Representation
                        </th>
                        <tr>
                          <td/>
                          <xsl:for-each select ="$attrV6List">
                            <td class="detailModeTitleLevel2">
                              <xsl:value-of select ="./@Name" />
                            </td>
                          </xsl:for-each>
                        </tr>
                        <!-- Go trough all the document to list theirs errors-->
                        <xsl:for-each select="$docErrorConversionStep">
                          <xsl:variable name ="detailDocErrorId" select="concat('packageDetailPack',$packageNumber,'Doc',./LinkInformation/MigrationTagName)"/>
                          <xsl:variable name ="detailDocErrorIcon" select="concat('expandCollapse',$packageNumber,'Doc',./LinkInformation/MigrationTagName)"/>
                          <tr class ="clickable">
                            <xsl:attribute name ="onclick">
                              toggle_visibility_by_id('<xsl:value-of select="$detailDocErrorId"/>','<xsl:value-of select="$detailDocErrorIcon"/>')
                            </xsl:attribute>
                            <td width="45">
                              <img src="Data/Rep_Status_Error_collapse.png">
                                <xsl:attribute name = "id">
                                  <xsl:value-of select="$detailDocErrorIcon"/>
                                </xsl:attribute>
                              </img>
                            </td>
                            <xsl:for-each select ="./Children/ReportInfo[@Type ='DocInfo' and @Name ='AttrV6TreeMask']/Children/ReportInfo[@Type ='Attribut']">
                              <td class="detailIndentLv1">
                                <xsl:value-of select ="./ReportInformation/Source" />&#160;
                              </td>
                            </xsl:for-each>
                          </tr>
                          <tr>
                            <!-- Detail of the document : Error table -->
                            <td/>
                            <td>
                              <xsl:attribute name = "colspan">
                                <xsl:value-of select="count($attrV6List)"/>
                              </xsl:attribute>
                              <span >
                                <xsl:attribute name="id">
                                  <xsl:value-of select="$detailDocErrorId"/>
                                </xsl:attribute>
                                <!-- Create the error table by document -->
                                <table cellspacing="1" cellpadding="3" class="objectFBDITable" width="100%">
                                  <!-- Header -->


                                  <tr>
                                    <td width="10" align="left" valign="top">
                                      <img src="Data\TableDetailArrow.png" />
                                    </td>
                                    <td class="detailIndentLv1" colspan ="3">
                                      Source identifier :<pre>
                                        <xsl:value-of select="./Children/ReportInfo[@Type='DocInfo' and @Name='SourceIdent']/ReportInformation/Source"/>
                                      </pre>
                                    </td>
                                  </tr>
                                  <tr></tr>
                                  <th/>
                                  <th class ="ErrorMode">Error code</th>
                                  <th class ="ErrorMode">Description</th>
                                  <th class ="ErrorMode">Detail</th>
                                  <!-- List all the error for a document-->
                                  <xsl:for-each select ="./descendant::ReportInfo[@Type='RaisedMsg' and @Status ='Error']
														[not(./ReportInformation/Tag/Code = ./preceding-sibling::ReportInfo[@Type='RaisedMsg' and @Status = 'Error']/ReportInformation/Tag/Code)]">
                                    <xsl:variable name ="currentInfra" select="./ReportInformation/Tag/Code" />
                                    <tr>
                                      <td/>
                                      <td class="ErrorMode">
                                        <xsl:value-of select="$currentInfra"/>
                                      </td>
                                      <td class="ErrorMode">
                                        <xsl:value-of select="./ReportInformation/Source"/>
                                      </td>
                                      <td class="ErrorMode">
                                        <xsl:value-of select="./ReportInformation/Details"/>
                                      </td>
                                    </tr>
                                  </xsl:for-each>
                                </table>
                              </span>
                            </td>
                          </tr>
                        </xsl:for-each>
                      </table>
                      <br/>
                    </xsl:if>
                    <!-- Other error-->
                    <xsl:if test ="count($globalErrorConversionStep) > 0">
                      <table cellspacing="1" cellpadding="3" class="objectFBDITable" width="100%">
                        <th/>
                        <th class ="detailmode" colspan ="2">Global</th>
                        <tr>
                          <th/>
                          <th class ="ErrorMode">Error code</th>
                          <th class ="ErrorMode">Description</th>
                        </tr>
                        <xsl:for-each select="$globalErrorConversionStep">
                          <tr>
                            <td width="45">
                              <img src="Data/Rep_Status_Error_collapse.png"></img>
                            </td>
                            <td class="ErrorMode">
                              <xsl:value-of select ="./ReportInformation/Tag/Code" />&#160;
                            </td>
                            <td class="ErrorMode">
                              <xsl:value-of select ="./ReportInformation/Source" />&#160;
                            </td>
                          </tr>
                        </xsl:for-each>
                      </table>
                    </xsl:if>
                    <!-- Save error-->
                    <xsl:if test ="count($globalErrorSaveStep) > 0">
                      <table cellspacing="1" cellpadding="3" class="objectFBDITable" width="100%">
                        <th/>
                        <th class ="detailmode" colspan ="2">Global</th>
                        <tr>
                          <th/>
                          <th class ="ErrorMode">Error code</th>
                          <th class ="ErrorMode">Description</th>
                        </tr>
                        <xsl:for-each select="$globalErrorSaveStep">
                          <tr>
                            <td width="45">
                              <img src="Data/Rep_Status_Error_collapse.png"></img>
                            </td>
                            <td class="ErrorMode">
                              <xsl:value-of select ="./ReportInformation/Tag/Code" />&#160;
                            </td>
                            <td class="ErrorMode">
                              <xsl:value-of select ="./ReportInformation/Source" />&#160;
                            </td>
                          </tr>
                        </xsl:for-each>
                      </table>
                    </xsl:if>
                  </span>
                </td>


              </tr>
            </xsl:if>
          </xsl:when>
          <xsl:otherwise>
            <tr>
              <td/>
              <td class="queuedPackage" align ="center">
                <xsl:value-of select="$packageNumber"/>
              </td>
              <td class="queuedPackage" align ="center">-</td>
              <td class="queuedPackage" align ="center">-</td>
              <td class="queuedPackage" align ="center">-</td>
              <td class="queuedPackage" align ="center">-</td>
              <td class="queuedPackage" align ="center">-</td>
            </tr>
          </xsl:otherwise>

        </xsl:choose>


      </xsl:for-each>

    </table>
  </xsl:template>

  <!--****************************************************************
	  Function : Add the package status for the different step
	**************************************************************** -->
  <xsl:template name ="AddPackageStepStatus">
    <xsl:param name = "styleCell"/>
    <xsl:param name = "packageStatus"/>
    <xsl:param name = "stepStatus"/>
    <xsl:param name = "packNum"/>
    <xsl:variable name ="ImageSRC">
      <xsl:choose>
        <xsl:when test ="$stepStatus = 'WarningPriv'">
          <xsl:value-of select ="concat('Data/Package_Status_OK','.png')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select ="concat('Data/Package_Status_',$stepStatus,'.png')"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="$packageStatus !='Unknown' and $stepStatus != 'Unknown' ">
        <xsl:if test ="$stepStatus ='Error'">
          <td  width = "80" align = "center">
            <xsl:attribute name="class">
              <xsl:value-of select="$styleCell"/>
            </xsl:attribute>

            <img >
              <xsl:attribute name="src">
                <xsl:value-of select ="$ImageSRC"/>
              </xsl:attribute>
            </img>
          </td>
        </xsl:if>
        <xsl:if test ="$stepStatus !='Error'">
          <td  width = "80" align = "center">
            <xsl:attribute name="class">
              <xsl:value-of select="$styleCell"/>
            </xsl:attribute>
            <img >
              <xsl:attribute name="src">
                <xsl:value-of select ="$ImageSRC"/>
              </xsl:attribute>
            </img>
            <xsl:if test ="$stepStatus ='Error'">&#160;&#160;&#160;&#160;</xsl:if>
          </td>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <td  width = "80" align = "center">
          <xsl:attribute name="class">
            <xsl:value-of select="$styleCell"/>
          </xsl:attribute>
          -
        </td>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!--****************************************************************
					Section versioning Information
	**************************************************************** -->
  <xsl:template match="//ReportInfo/Children/ReportInfo[@Type = 'MigrationProcess']/Children/ReportInfo[@Type = 'MigrationStep' 
  and @Name= 'Conversion']/Children/ReportInfo[@Type='versioning']">
    <table border="1" cellspacing="1" cellpadding="3" align="center" class="objectFBDITable" >
      <th class="detailMode">Revisioned Components</th>
      <th class="detailMode">Description</th>
      <xsl:for-each select="./Children/ReportInfo">
        <tr>
          <td>
            <xsl:value-of select="ReportInformation/Source"/>
          </td>
          <td>
            <xsl:apply-templates select="ReportInformation/Details"/>
          </td>
        </tr>
      </xsl:for-each>
    </table>
  </xsl:template>

</xsl:stylesheet>
