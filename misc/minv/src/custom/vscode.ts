import { MINV } from "minv";

export function setup_vscode(this: void, minv: MINV) {
  if (vim.g.vscode != undefined) {
    minv.update_keybindings({
      "normal.extra": {
        $merge: {
          "<C-k>": {
            cmd() {
              (
                (vim as any).fn.VSCodeNotify as (
                  this: void,
                  ...args: any[]
                ) => void
              )("keyboard-quickfix.openQuickFix");
            },
          },
        },
      },
    });
  }
}
