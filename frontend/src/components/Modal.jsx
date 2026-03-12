import { useEffect } from "react";

export default function Modal({ open, title, children, onClose }) {
  useEffect(() => {
    if (!open) return;
    const onKey = (e) => {
      if (e.key === "Escape") onClose?.();
    };
    window.addEventListener("keydown", onKey);
    return () => window.removeEventListener("keydown", onKey);
  }, [open, onClose]);

  if (!open) return null;

  return (
    <div className="modalOverlay" onMouseDown={() => onClose?.()}>
      <div className="modalCard" onMouseDown={(e) => e.stopPropagation()}>
        <div className="modalTop">
          <div className="modalTitle">{title}</div>

          {/* ✅ always-visible close button */}
          <button
            type="button"
            className="modalClose"
            onClick={() => onClose?.()}
            aria-label="Close"
          >
            ✕
          </button>
        </div>

        <div className="modalBody">{children}</div>
      </div>
    </div>
  );
}
