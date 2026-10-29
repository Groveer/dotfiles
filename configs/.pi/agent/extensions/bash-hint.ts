import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

/**
 * pi's built-in bash tool snippet advertises "ls, grep, find, etc.", which pushes the
 * model to shell-search instead of the fff tools. pi has no setting for the snippet or
 * its guidelines, but `before_agent_start` exposes them mutably, so rewrite both here.
 */
// export default function (pi: ExtensionAPI) {
//   pi.on("before_agent_start", (event) => {
//     const options = event.systemPromptOptions;
//
//     options.toolSnippets.bash =
//       "Execute bash commands (git, build, pipelines, scripts; not for file search)";
//
//     options.toolGuidelines.bash = [
//       ...(options.toolGuidelines.bash ?? []),
//       "Search files with the dedicated tools (ffgrep for contents, fffind for paths), not with bash grep/rg/find.",
//     ];
//   });
// }

export default function (pi: ExtensionAPI) {
  pi.on("before_agent_start", (event) => {
    event.systemPromptOptions.toolSnippets.bash =
      "Execute bash commands (git, rg, fd/fd-find, etc.)";
  });
}
