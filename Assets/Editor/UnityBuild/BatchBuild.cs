using System.Linq;
using System;
using UnityEngine;
using UnityEditor;

namespace UnityBuild
{
    public class BatchBuild
    {
        public static void Build()
        {
            var scenes = EditorBuildSettings.scenes.Where(s => s.enabled).Select(s => s.path).ToArray();
            var args = Environment.GetCommandLineArgs();
            var buildTarget = BuildTarget.NoTarget;
            var outputPath = "";
            for (var i = 0; i < args.Length; i++)
            {
                if (args[i] == "-buildTarget")
                {
                    switch (args[i + 1])
                    {
                        case "Android":
                            buildTarget = BuildTarget.Android;
                            break;
                        case "iOS":
                            buildTarget = BuildTarget.iOS;
                            break;
                        case "Mac":
                            buildTarget = BuildTarget.StandaloneOSX;
                            break;
                        case "Windows":
                            buildTarget = BuildTarget.StandaloneWindows;
                            break;
                        case "WebGL":
                            buildTarget = BuildTarget.WebGL;
                            break;
                        default:
                            Debug.LogError($"{args[i + 1]} is not supported.");
                            EditorApplication.Exit(1);
                            break;
                    }
                }
                if (args[i] == "-outputPath")
                {
                    outputPath = args[i + 1];
                }
            }
            BuildPipeline.BuildPlayer(scenes, outputPath, buildTarget, BuildOptions.None);
        }
    }
}
