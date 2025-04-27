### 🧩 Option 2: **Use a fresh machine or VM**

If this server is meant to be a DC and host AD CS, best practice is:

- Promote to DC first.
- Then install the AD CS role.
```{
    "Version": "2008-10-17",
    "Id": "PolicyForCloudFrontPrivateContent",
    "Statement": [
        {
            "Sid": "AllowCloudFrontServicePrincipal",
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudfront.amazonaws.com"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::google-crl/*",
            "Condition": {
                "StringEquals": {
                    "AWS:SourceArn": "arn:aws:cloudfront::853973692277:distribution/E242KS03XULPTB"
                }
            }
        },
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "acm-pca.amazonaws.com"
            },
            "Action": [
                "s3:PutObject",
                "s3:PutObjectAcl",
                "s3:GetBucketAcl",
                "s3:GetBucketLocation"
            ],
            "Resource": [
                "arn:aws:s3:::google-crl/*",
                "arn:aws:s3:::google-crl"
            ],
            "Condition": {
                "StringEquals": {
                    "aws:SourceAccount": "853973692277"
                }
            }
        }
    ]
}
```


```


<Objs Version="1.1.0.1" xmlns="http://schemas.microsoft.com/powershell/2004/04">
  <Obj RefId="0">
    <TN RefId="0">
      <T>System.Collections.ObjectModel.Collection`1[[System.Management.Automation.PSObject, System.Management.Automation, Version=3.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35]]</T>
      <T>System.Object</T>
    </TN>
    <LST>
      <Obj RefId="1">
        <TN RefId="1">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_Web_Server</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_Web_Server</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_Web_Server</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">2</I32>
          <Obj N="__ClassMetadata" RefId="2">
            <TN RefId="2">
              <T>System.Collections.ArrayList</T>
              <T>System.Object</T>
            </TN>
            <LST>
              <Obj RefId="3">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                  <S N="MiXml">&lt;CLASS NAME="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="locale" TYPE="sint32" TOSUBCLASS="false"&gt;&lt;VALUE&gt;1033&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
              <Obj RefId="4">
                <MS>
                  <S N="ClassName">ServerComponent_Web_Server</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120605672</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_Web_Server" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;Web-Server&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="5">
        <TN RefId="3">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_Web_WebServer</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_Web_WebServer</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_Web_WebServer</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">140</I32>
          <Obj N="__ClassMetadata" RefId="6">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="7">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="8">
                <MS>
                  <S N="ClassName">ServerComponent_Web_WebServer</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120593192</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_Web_WebServer" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;Web-WebServer&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="9">
        <TN RefId="4">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_Web_Common_Http</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_Web_Common_Http</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_Web_Common_Http</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">141</I32>
          <Obj N="__ClassMetadata" RefId="10">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="11">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="12">
                <MS>
                  <S N="ClassName">ServerComponent_Web_Common_Http</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120598392</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_Web_Common_Http" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;Web-Common-Http&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="13">
        <TN RefId="5">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_Web_Security</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_Web_Security</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_Web_Security</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">162</I32>
          <Obj N="__ClassMetadata" RefId="14">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="15">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="16">
                <MS>
                  <S N="ClassName">ServerComponent_Web_Security</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120599432</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_Web_Security" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;Web-Security&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="17">
        <TN RefId="6">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_Web_Filtering</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_Web_Filtering</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_Web_Filtering</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">169</I32>
          <Obj N="__ClassMetadata" RefId="18">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="19">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="20">
                <MS>
                  <S N="ClassName">ServerComponent_Web_Filtering</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120592152</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_Web_Filtering" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;Web-Filtering&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="21">
        <TN RefId="7">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_Web_Static_Content</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_Web_Static_Content</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_Web_Static_Content</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">142</I32>
          <Obj N="__ClassMetadata" RefId="22">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="23">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="24">
                <MS>
                  <S N="ClassName">ServerComponent_Web_Static_Content</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120852152</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_Web_Static_Content" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;Web-Static-Content&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="25">
        <TN RefId="8">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_Web_Default_Doc</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_Web_Default_Doc</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_Web_Default_Doc</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">143</I32>
          <Obj N="__ClassMetadata" RefId="26">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="27">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="28">
                <MS>
                  <S N="ClassName">ServerComponent_Web_Default_Doc</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120847992</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_Web_Default_Doc" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;Web-Default-Doc&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="29">
        <TN RefId="9">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_Web_Dir_Browsing</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_Web_Dir_Browsing</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_Web_Dir_Browsing</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">144</I32>
          <Obj N="__ClassMetadata" RefId="30">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="31">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="32">
                <MS>
                  <S N="ClassName">ServerComponent_Web_Dir_Browsing</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120850072</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_Web_Dir_Browsing" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;Web-Dir-Browsing&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="33">
        <TN RefId="10">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_Web_Http_Errors</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_Web_Http_Errors</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_Web_Http_Errors</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">145</I32>
          <Obj N="__ClassMetadata" RefId="34">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="35">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="36">
                <MS>
                  <S N="ClassName">ServerComponent_Web_Http_Errors</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120844872</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_Web_Http_Errors" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;Web-Http-Errors&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="37">
        <TN RefId="11">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_Web_Http_Redirect</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_Web_Http_Redirect</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_Web_Http_Redirect</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">146</I32>
          <Obj N="__ClassMetadata" RefId="38">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="39">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="40">
                <MS>
                  <S N="ClassName">ServerComponent_Web_Http_Redirect</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120843832</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_Web_Http_Redirect" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;Web-Http-Redirect&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="41">
        <TN RefId="12">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_Web_App_Dev</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_Web_App_Dev</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_Web_App_Dev</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">147</I32>
          <Obj N="__ClassMetadata" RefId="42">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="43">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="44">
                <MS>
                  <S N="ClassName">ServerComponent_Web_App_Dev</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120849032</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_Web_App_Dev" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;Web-App-Dev&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="45">
        <TN RefId="13">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_Web_Net_Ext45</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_Web_Net_Ext45</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_Web_Net_Ext45</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">414</I32>
          <Obj N="__ClassMetadata" RefId="46">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="47">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="48">
                <MS>
                  <S N="ClassName">ServerComponent_Web_Net_Ext45</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120835512</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_Web_Net_Ext45" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;Web-Net-Ext45&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="49">
        <TN RefId="14">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_Web_ISAPI_Ext</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_Web_ISAPI_Ext</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_Web_ISAPI_Ext</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">152</I32>
          <Obj N="__ClassMetadata" RefId="50">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="51">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="52">
                <MS>
                  <S N="ClassName">ServerComponent_Web_ISAPI_Ext</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120826152</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_Web_ISAPI_Ext" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;Web-ISAPI-Ext&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="53">
        <TN RefId="15">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_Web_ISAPI_Filter</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_Web_ISAPI_Filter</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_Web_ISAPI_Filter</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">153</I32>
          <Obj N="__ClassMetadata" RefId="54">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="55">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="56">
                <MS>
                  <S N="ClassName">ServerComponent_Web_ISAPI_Filter</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120829272</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_Web_ISAPI_Filter" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;Web-ISAPI-Filter&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="57">
        <TN RefId="16">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_Web_Asp_Net45</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_Web_Asp_Net45</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_Web_Asp_Net45</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">413</I32>
          <Obj N="__ClassMetadata" RefId="58">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="59">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="60">
                <MS>
                  <S N="ClassName">ServerComponent_Web_Asp_Net45</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120827192</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_Web_Asp_Net45" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;Web-Asp-Net45&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="61">
        <TN RefId="17">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_Web_ASP</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_Web_ASP</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_Web_ASP</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">150</I32>
          <Obj N="__ClassMetadata" RefId="62">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="63">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="64">
                <MS>
                  <S N="ClassName">ServerComponent_Web_ASP</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120837592</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_Web_ASP" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;Web-ASP&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="65">
        <TN RefId="18">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_Web_Health</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_Web_Health</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_Web_Health</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">155</I32>
          <Obj N="__ClassMetadata" RefId="66">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="67">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="68">
                <MS>
                  <S N="ClassName">ServerComponent_Web_Health</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120810552</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_Web_Health" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;Web-Health&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="69">
        <TN RefId="19">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_Web_Http_Logging</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_Web_Http_Logging</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_Web_Http_Logging</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">156</I32>
          <Obj N="__ClassMetadata" RefId="70">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="71">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="72">
                <MS>
                  <S N="ClassName">ServerComponent_Web_Http_Logging</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120809512</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_Web_Http_Logging" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;Web-Http-Logging&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="73">
        <TN RefId="20">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_Web_Log_Libraries</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_Web_Log_Libraries</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_Web_Log_Libraries</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">157</I32>
          <Obj N="__ClassMetadata" RefId="74">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="75">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="76">
                <MS>
                  <S N="ClassName">ServerComponent_Web_Log_Libraries</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120807432</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_Web_Log_Libraries" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;Web-Log-Libraries&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="77">
        <TN RefId="21">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_Web_Request_Monitor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_Web_Request_Monitor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_Web_Request_Monitor</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">158</I32>
          <Obj N="__ClassMetadata" RefId="78">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="79">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="80">
                <MS>
                  <S N="ClassName">ServerComponent_Web_Request_Monitor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120808472</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_Web_Request_Monitor" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;Web-Request-Monitor&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="81">
        <TN RefId="22">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_Web_Http_Tracing</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_Web_Http_Tracing</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_Web_Http_Tracing</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">159</I32>
          <Obj N="__ClassMetadata" RefId="82">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="83">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="84">
                <MS>
                  <S N="ClassName">ServerComponent_Web_Http_Tracing</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120805352</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_Web_Http_Tracing" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;Web-Http-Tracing&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="85">
        <TN RefId="23">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_Web_Windows_Auth</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_Web_Windows_Auth</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_Web_Windows_Auth</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">164</I32>
          <Obj N="__ClassMetadata" RefId="86">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="87">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="88">
                <MS>
                  <S N="ClassName">ServerComponent_Web_Windows_Auth</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120801192</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_Web_Windows_Auth" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;Web-Windows-Auth&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="89">
        <TN RefId="24">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_Web_Client_Auth</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_Web_Client_Auth</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_Web_Client_Auth</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">166</I32>
          <Obj N="__ClassMetadata" RefId="90">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="91">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="92">
                <MS>
                  <S N="ClassName">ServerComponent_Web_Client_Auth</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120790792</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_Web_Client_Auth" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;Web-Client-Auth&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="93">
        <TN RefId="25">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_Web_Cert_Auth</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_Web_Cert_Auth</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_Web_Cert_Auth</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">167</I32>
          <Obj N="__ClassMetadata" RefId="94">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="95">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="96">
                <MS>
                  <S N="ClassName">ServerComponent_Web_Cert_Auth</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120794952</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_Web_Cert_Auth" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;Web-Cert-Auth&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="97">
        <TN RefId="26">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_Web_Performance</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_Web_Performance</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_Web_Performance</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">171</I32>
          <Obj N="__ClassMetadata" RefId="98">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="99">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="100">
                <MS>
                  <S N="ClassName">ServerComponent_Web_Performance</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120786632</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_Web_Performance" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;Web-Performance&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="101">
        <TN RefId="27">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_Web_Stat_Compression</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_Web_Stat_Compression</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_Web_Stat_Compression</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">172</I32>
          <Obj N="__ClassMetadata" RefId="102">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="103">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="104">
                <MS>
                  <S N="ClassName">ServerComponent_Web_Stat_Compression</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120776232</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_Web_Stat_Compression" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;Web-Stat-Compression&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="105">
        <TN RefId="28">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_Web_Mgmt_Tools</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_Web_Mgmt_Tools</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_Web_Mgmt_Tools</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">174</I32>
          <Obj N="__ClassMetadata" RefId="106">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="107">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="108">
                <MS>
                  <S N="ClassName">ServerComponent_Web_Mgmt_Tools</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120768952</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_Web_Mgmt_Tools" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;Web-Mgmt-Tools&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="109">
        <TN RefId="29">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_Web_Mgmt_Console</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_Web_Mgmt_Console</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_Web_Mgmt_Console</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">175</I32>
          <Obj N="__ClassMetadata" RefId="110">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="111">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="112">
                <MS>
                  <S N="ClassName">ServerComponent_Web_Mgmt_Console</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120773112</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_Web_Mgmt_Console" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;Web-Mgmt-Console&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="113">
        <TN RefId="30">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_Web_Scripting_Tools</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_Web_Scripting_Tools</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_Web_Scripting_Tools</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">176</I32>
          <Obj N="__ClassMetadata" RefId="114">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="115">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="116">
                <MS>
                  <S N="ClassName">ServerComponent_Web_Scripting_Tools</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120767912</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_Web_Scripting_Tools" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;Web-Scripting-Tools&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="117">
        <TN RefId="31">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_Web_Mgmt_Compat</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_Web_Mgmt_Compat</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_Web_Mgmt_Compat</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">178</I32>
          <Obj N="__ClassMetadata" RefId="118">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="119">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="120">
                <MS>
                  <S N="ClassName">ServerComponent_Web_Mgmt_Compat</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120756472</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_Web_Mgmt_Compat" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;Web-Mgmt-Compat&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="121">
        <TN RefId="32">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_Web_Metabase</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_Web_Metabase</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_Web_Metabase</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">179</I32>
          <Obj N="__ClassMetadata" RefId="122">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="123">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="124">
                <MS>
                  <S N="ClassName">ServerComponent_Web_Metabase</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120762712</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_Web_Metabase" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;Web-Metabase&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="125">
        <TN RefId="33">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_WAS</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_WAS</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_WAS</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">41</I32>
          <Obj N="__ClassMetadata" RefId="126">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="127">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="128">
                <MS>
                  <S N="ClassName">ServerComponent_WAS</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120752312</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_WAS" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;WAS&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="129">
        <TN RefId="34">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_WAS_Process_Model</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_WAS_Process_Model</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_WAS_Process_Model</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">219</I32>
          <Obj N="__ClassMetadata" RefId="130">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="131">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="132">
                <MS>
                  <S N="ClassName">ServerComponent_WAS_Process_Model</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120764792</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_WAS_Process_Model" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;WAS-Process-Model&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="133">
        <TN RefId="35">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_WAS_Config_APIs</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_WAS_Config_APIs</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_WAS_Config_APIs</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">217</I32>
          <Obj N="__ClassMetadata" RefId="134">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="135">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="136">
                <MS>
                  <S N="ClassName">ServerComponent_WAS_Config_APIs</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120734632</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_WAS_Config_APIs" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;WAS-Config-APIs&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="137">
        <TN RefId="36">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_NET_WCF_HTTP_Activation45</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_NET_WCF_HTTP_Activation45</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_NET_WCF_HTTP_Activation45</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">421</I32>
          <Obj N="__ClassMetadata" RefId="138">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="139">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="140">
                <MS>
                  <S N="ClassName">ServerComponent_NET_WCF_HTTP_Activation45</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120730472</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_NET_WCF_HTTP_Activation45" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;4.5.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;NET-WCF-HTTP-Activation45&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="141">
        <TN RefId="37">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_AD_Certificate</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_AD_Certificate</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_AD_Certificate</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">16</I32>
          <Obj N="__ClassMetadata" RefId="142">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="143">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="144">
                <MS>
                  <S N="ClassName">ServerComponent_AD_Certificate</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120704472</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_AD_Certificate" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;8.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;AD-Certificate&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="145">
        <TN RefId="38">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_ADCS_Cert_Authority</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_ADCS_Cert_Authority</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_ADCS_Cert_Authority</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">200</I32>
          <Obj N="__ClassMetadata" RefId="146">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="147">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="148">
                <MS>
                  <S N="ClassName">ServerComponent_ADCS_Cert_Authority</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120716952</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_ADCS_Cert_Authority" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;ADCS-Cert-Authority&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="149">
        <TN RefId="39">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_ADCS_Online_Cert</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_ADCS_Online_Cert</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_ADCS_Online_Cert</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">202</I32>
          <Obj N="__ClassMetadata" RefId="150">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="151">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="152">
                <MS>
                  <S N="ClassName">ServerComponent_ADCS_Online_Cert</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120719032</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_ADCS_Online_Cert" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;ADCS-Online-Cert&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="153">
        <TN RefId="40">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_ADCS_Web_Enrollment</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_ADCS_Web_Enrollment</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_ADCS_Web_Enrollment</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">201</I32>
          <Obj N="__ClassMetadata" RefId="154">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="155">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="156">
                <MS>
                  <S N="ClassName">ServerComponent_ADCS_Web_Enrollment</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120717992</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_ADCS_Web_Enrollment" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;ADCS-Web-Enrollment&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="157">
        <TN RefId="41">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_ADCS_Enroll_Web_Pol</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_ADCS_Enroll_Web_Pol</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_ADCS_Enroll_Web_Pol</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">319</I32>
          <Obj N="__ClassMetadata" RefId="158">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="159">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="160">
                <MS>
                  <S N="ClassName">ServerComponent_ADCS_Enroll_Web_Pol</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120696152</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_ADCS_Enroll_Web_Pol" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;ADCS-Enroll-Web-Pol&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="161">
        <TN RefId="42">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_ADCS_Enroll_Web_Svc</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_ADCS_Enroll_Web_Svc</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_ADCS_Enroll_Web_Svc</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">318</I32>
          <Obj N="__ClassMetadata" RefId="162">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="163">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="164">
                <MS>
                  <S N="ClassName">ServerComponent_ADCS_Enroll_Web_Svc</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120689912</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_ADCS_Enroll_Web_Svc" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;ADCS-Enroll-Web-Svc&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="165">
        <TN RefId="43">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_NET_Framework_45_ASPNET</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_NET_Framework_45_ASPNET</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_NET_Framework_45_ASPNET</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">429</I32>
          <Obj N="__ClassMetadata" RefId="166">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="167">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="168">
                <MS>
                  <S N="ClassName">ServerComponent_NET_Framework_45_ASPNET</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-123468888</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_NET_Framework_45_ASPNET" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;4.5.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;NET-Framework-45-ASPNET&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="169">
        <TN RefId="44">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_RSAT_AD_PowerShell</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_RSAT_AD_PowerShell</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_RSAT_AD_PowerShell</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">331</I32>
          <Obj N="__ClassMetadata" RefId="170">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="171">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="172">
                <MS>
                  <S N="ClassName">ServerComponent_RSAT_AD_PowerShell</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-123465768</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_RSAT_AD_PowerShell" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;RSAT-AD-PowerShell&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="173">
        <TN RefId="45">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_RSAT_AD_AdminCenter</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_RSAT_AD_AdminCenter</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_RSAT_AD_AdminCenter</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">330</I32>
          <Obj N="__ClassMetadata" RefId="174">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="175">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="176">
                <MS>
                  <S N="ClassName">ServerComponent_RSAT_AD_AdminCenter</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-123461608</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_RSAT_AD_AdminCenter" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;RSAT-AD-AdminCenter&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="177">
        <TN RefId="46">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_AD_Domain_Services</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_AD_Domain_Services</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_AD_Domain_Services</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">10</I32>
          <Obj N="__ClassMetadata" RefId="178">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="179">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="180">
                <MS>
                  <S N="ClassName">ServerComponent_AD_Domain_Services</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-123460568</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_AD_Domain_Services" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;8.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;AD-Domain-Services&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="181">
        <TN RefId="47">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_RSAT</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_RSAT</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_RSAT</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">67</I32>
          <Obj N="__ClassMetadata" RefId="182">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="183">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="184">
                <MS>
                  <S N="ClassName">ServerComponent_RSAT</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-123031016</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_RSAT" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;8.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;RSAT&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="185">
        <TN RefId="48">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_RSAT_Role_Tools</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_RSAT_Role_Tools</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_RSAT_Role_Tools</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">256</I32>
          <Obj N="__ClassMetadata" RefId="186">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="187">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="188">
                <MS>
                  <S N="ClassName">ServerComponent_RSAT_Role_Tools</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-123020616</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_RSAT_Role_Tools" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;8.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;RSAT-Role-Tools&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="189">
        <TN RefId="49">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_RSAT_AD_Tools</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_RSAT_AD_Tools</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_RSAT_AD_Tools</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">329</I32>
          <Obj N="__ClassMetadata" RefId="190">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="191">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="192">
                <MS>
                  <S N="ClassName">ServerComponent_RSAT_AD_Tools</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-123001896</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_RSAT_AD_Tools" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;RSAT-AD-Tools&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="193">
        <TN RefId="50">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_RSAT_ADDS</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_RSAT_ADDS</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_RSAT_ADDS</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">257</I32>
          <Obj N="__ClassMetadata" RefId="194">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="195">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="196">
                <MS>
                  <S N="ClassName">ServerComponent_RSAT_ADDS</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-123017496</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_RSAT_ADDS" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;RSAT-ADDS&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="197">
        <TN RefId="51">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_RSAT_ADDS_Tools</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_RSAT_ADDS_Tools</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_RSAT_ADDS_Tools</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">299</I32>
          <Obj N="__ClassMetadata" RefId="198">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="199">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="200">
                <MS>
                  <S N="ClassName">ServerComponent_RSAT_ADDS_Tools</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-123015416</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_RSAT_ADDS_Tools" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;RSAT-ADDS-Tools&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="201">
        <TN RefId="52">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_GPMC</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_GPMC</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_GPMC</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">69</I32>
          <Obj N="__ClassMetadata" RefId="202">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="203">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="204">
                <MS>
                  <S N="ClassName">ServerComponent_GPMC</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-122863080</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_GPMC" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;10.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;GPMC&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="205">
        <TN RefId="53">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_RSAT_ADCS</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_RSAT_ADCS</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_RSAT_ADCS</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">259</I32>
          <Obj N="__ClassMetadata" RefId="206">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="207">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="208">
                <MS>
                  <S N="ClassName">ServerComponent_RSAT_ADCS</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-122807960</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_RSAT_ADCS" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;8.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;RSAT-ADCS&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="209">
        <TN RefId="54">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_RSAT_ADCS_Mgmt</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_RSAT_ADCS_Mgmt</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_RSAT_ADCS_Mgmt</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">292</I32>
          <Obj N="__ClassMetadata" RefId="210">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="211">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="212">
                <MS>
                  <S N="ClassName">ServerComponent_RSAT_ADCS_Mgmt</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-122804840</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_RSAT_ADCS_Mgmt" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;RSAT-ADCS-Mgmt&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
      <Obj RefId="213">
        <TN RefId="55">
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/ServerComponent_RSAT_Online_Responder</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ROOT/Microsoft/Windows/ServerManager/MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#ServerComponent_RSAT_Online_Responder</T>
          <T>Microsoft.Management.Infrastructure.CimInstance#MSFT_ServerManagerServerComponentDescriptor</T>
          <T>Microsoft.Management.Infrastructure.CimInstance</T>
          <T>System.Object</T>
        </TN>
        <ToString>ServerComponent_RSAT_Online_Responder</ToString>
        <Props>
          <S N="PSComputerName">EC2AMAZ-4BOUK56</S>
        </Props>
        <MS>
          <I32 N="NumericId">293</I32>
          <Obj N="__ClassMetadata" RefId="214">
            <TNRef RefId="2" />
            <LST>
              <Obj RefId="215">
                <MS>
                  <S N="ClassName">MSFT_ServerManagerServerComponentDescriptor</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-120653512</I32>
                </MS>
              </Obj>
              <Obj RefId="216">
                <MS>
                  <S N="ClassName">ServerComponent_RSAT_Online_Responder</S>
                  <S N="Namespace">ROOT/Microsoft/Windows/ServerManager</S>
                  <S N="ServerName">EC2AMAZ-4BOUK56</S>
                  <I32 N="Hash">-122805880</I32>
                  <S N="MiXml">&lt;CLASS NAME="ServerComponent_RSAT_Online_Responder" SUPERCLASS="MSFT_ServerManagerServerComponentDescriptor"&gt;&lt;QUALIFIER NAME="dynamic" TYPE="boolean"&gt;&lt;VALUE&gt;true&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="provider" TYPE="string"&gt;&lt;VALUE&gt;deploymentprovider&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="ClassVersion" TYPE="string"&gt;&lt;VALUE&gt;0.0.0&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;QUALIFIER NAME="DisplayName" TYPE="string" TRANSLATABLE="true"&gt;&lt;VALUE&gt;RSAT-Online-Responder&lt;/VALUE&gt;&lt;/QUALIFIER&gt;&lt;/CLASS&gt;</S>
                </MS>
              </Obj>
            </LST>
          </Obj>
        </MS>
      </Obj>
    </LST>
  </Obj>
</Objs>
```