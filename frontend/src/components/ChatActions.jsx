import { useMemo } from "react";

export default function ChatActions({
  result,
  onWhy,
  onShowSteps,
  onFindTechnician,
  onUnlockPremium,
  onRestart,
}) {
  const type = result?.type || null;

  const buttons = useMemo(() => {
    if (!type) return [];

    const common = [{ id: "why", label: "💡 Why is this happening?", onClick: onWhy }];

    if (type === "free_fix") {
      return [
        ...common,
        { id: "steps", label: "🔧 Show basic steps", onClick: onShowSteps },
        { id: "restart", label: "🔁 Restart diagnosis", onClick: onRestart },
      ];
    }

    if (type === "refer_technician") {
      return [
        ...common,
        { id: "steps", label: "🔧 Show basic steps", onClick: onShowSteps },
        { id: "tech", label: "🧑‍🔧 Find a technician", onClick: onFindTechnician },
        { id: "restart", label: "🔁 Restart diagnosis", onClick: onRestart },
      ];
    }

    if (type === "premium_fix") {
      return [
        ...common,
        { id: "steps", label: "🔧 Show basic steps", onClick: onShowSteps },
        { id: "premium", label: "🔒 Unlock premium steps", onClick: onUnlockPremium },
        { id: "restart", label: "🔁 Restart diagnosis", onClick: onRestart },
      ];
    }

    return [...common, { id: "restart", label: "🔁 Restart diagnosis", onClick: onRestart }];
  }, [type, onWhy, onShowSteps, onFindTechnician, onUnlockPremium, onRestart]);

  if (!result) return null;

  return (
    <div className="chatActions inline">
      {buttons.map((b) => (
        <button key={b.id} className="btnAction" onClick={b.onClick}>
          {b.label}
        </button>
      ))}
    </div>
  );
}
