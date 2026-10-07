import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

/** Hindsight tools kept declared to the model. The rest are registered but never activated. */
const KEEP = new Set([
  "hindsight_recall",
  "hindsight_retain",
  "hindsight_retain_global",
  "hindsight_status",
]);

export default function (pi: ExtensionAPI) {
  // ponytail: runs once per agent turn, cheap string filter. If another extension activates
  // hindsight later in the same before_agent_start pass, the trim lands one turn later.
  pi.on("before_agent_start", async () => {
    const active = pi.getActiveTools();
    if (!active.some((name) => name.startsWith("hindsight_"))) return;

    const trimmed = active.filter(
      (name) => !name.startsWith("hindsight_") || KEEP.has(name),
    );
    if (trimmed.length === active.length) return;

    pi.setActiveTools(trimmed);
  });
}
