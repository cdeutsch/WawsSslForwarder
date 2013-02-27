Windows Azure Web Sites SSL Forwarder
================

Many web site developers who need SSL support have voiced their need for SSL on Windows Azure Web Sites. Though SSL isn't released on WAWS yet, there is a known workaround that some site owners have implemented. This isn't a permanent fix, but rather a stopgap for customers who want the ease of development and deployment options available in WAWS. 

> **Note**: This solution is not intended as official guidance from Microsoft, nor intended to provide a permanent solution for the lack of SSL support on WAWS. This is an unsupported option, but one that can provide a temporary solution until SSL is supported by WAWS.

The workaround is to set up a Windows Azure Cloud Service that answers requests on a specific domain name, then reverse-proxies the requests back to a Windows Azure Web Site. 

A more detailed description of setting up this forwarding solution will follow. For now, here's a short tutorial in using this source code to provide an SSL front-end to a Windows Azure Web Site. 

1. Download the source code from this repository. In the Visual Studio 2012 solution contained in this repo, you'll find 3 projects:

	a. A Windows Azure Cloud Project

	b. A web site project that runs as a web role within the cloud project as a hosted service

	c. A web site project that can be deployed to WAWS

1. Create a self-signed certificate or obtain a certificate from a trusted provider. 
1. View the properties for the SSL certificate you intend on using and copy out the thumbprint.
1. In the **ServiceConfiguration.Local.config** and **ServiceConfiguration.Cloud.config** files, change the thumbprint to reflect that of the certificate you intend on using in your deployment. These files currently have **[YOUR SSL THUMBPRINT HERE]** as a placeholder. Overwrite this placeholder with your own thumbprint. 
1. Open the Web.config file from the **SSLForwarderRole** web project.
1. Replace any instance of the **sslforwarder.azurewebsites.net** string with the domain name you intend on using with your Windows Azure Web Site. 

	For example, if your domain name is **foo.azurewebsites.net**, you will want to find the code from the **Web.config** file that reads:

		<action type="Rewrite" url="https://sslforwarder.azurewebsites.net/{R:1}" />

	And change the code to read:

		<action type="Rewrite" url="https://foo.azurewebsites.net/{R:1}" />

1. Replace any instance of the **sslforwarder.cloudapp.net** string with the domain name you intend on using to service requests. 

	For example, if your Cloud Service will run at **foo.cloudapp.net**, you will want to find the code from the **Web.config** file that reads:

		<action type="Rewrite" value="{R:1}://sslforwarder.cloudapp.net/{R:2}" />

	And change the code to read:

		<action type="Rewrite" value="{R:1}://foo.cloudapp.net/{R:2}" />

	Similarly, if you plan on using a fully qualified domain name such as **foo.com** to answer requests, you will want to change the code from this:

		<action type="Rewrite" value="{R:1}://sslforwarder.cloudapp.net/{R:2}" />

	To this:

		<action type="Rewrite" value="{R:1}://www.foo.com/{R:2}" />

1. Log into the Windows Azure portal and create a new Cloud Service. If you have already created a Cloud Service to host the SSL forwarder service, open up the dashboard for the Cloud Service within the Windows Azure portal.
1. Click on the **Certificates** tab in the Cloud Service's dashboard
1. Upload the certificate you intend on using. 
1. Once the certificate is uploaded, verify that the thumbprint in the Windows Azure portal's Cloud Service configuration page matches the thumbprint you have pasted into your **ServiceConfiguration.*.config** files. 
1. Publish the cloud service from Visual Studio.


If you haven't already published your web site to Windows Azure Web Sites, you'll need to complete these last few steps to complete your deployment. 

1. Create a Web Site to host the site content you wish to host behind the SSL forwarding hosted service.
1. Download the publish settings file for that web site and publish your web site.
1. Publish the site content to Windows Azure Web Sites using Visual Studio or WebMatrix, or deploy the site's files using some other means (FTP, TFS, Git, etc)