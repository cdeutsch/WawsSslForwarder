using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.WindowsAzure;
using Microsoft.WindowsAzure.Diagnostics;
using Microsoft.WindowsAzure.ServiceRuntime;
using System.Diagnostics;
using System.IO;
using System.DirectoryServices;
using System.Threading;

namespace WebRole1
{
    public class WebRole : RoleEntryPoint
    {
        void RunCommandLineScript(string commandLine, string arguments, string logFileName)
        {
            Process P = new Process();
            P.StartInfo.FileName = commandLine;
            P.StartInfo.Arguments = arguments;
            P.StartInfo.CreateNoWindow = true;
            P.StartInfo.UseShellExecute = false;
            P.StartInfo.RedirectStandardOutput = true;
            P.StartInfo.WorkingDirectory = Path.GetDirectoryName(commandLine);
            P.Start();

            string outputText = P.StandardOutput.ReadToEnd();
            P.WaitForExit();

            File.AppendAllText(logFileName, outputText);
        }

        public override bool OnStart()
        {
            // For information on handling configuration changes
            // see the MSDN topic at http://go.microsoft.com/fwlink/?LinkId=166357.
            // RunCommandLineScript("setuparr.cmd", "", "c:\\setuparr.log");
            Thread.Sleep(120000); // 2 minutes should be enough for ARR to be setup
            RunCommandLineScript("configureforwarding.cmd", "", "c:\\configureforwarding.log");
            return base.OnStart();
        }
    }
}