import * as minv from "minv";
import { setup_plugins } from "./plugins";
import { setup_lsp } from "./lsp";
import { setup_vscode } from "./vscode";

export function setup(this: void) {
  minv.setup((minv) => {
    const not_vscode = vim.g.vscode == undefined;
    vim.env["http_proxy"] = vim.env["MY_HTTP_PROXY"];
    vim.env["HTTP_PROXY"] = vim.env["MY_HTTP_PROXY"];
    vim.env["https_proxy"] = vim.env["MY_HTTP_PROXY"];
    vim.env["HTTPS_PROXY"] = vim.env["MY_HTTP_PROXY"];
    // Extend plugins.
    setup_plugins(minv);
    // Extend lsp.
    setup_lsp(minv);
    // VS Code settings.
    setup_vscode(minv);
    // Disable some autocmds.
    const au = minv.autocmds;
    au.auto_resize.enable = not_vscode;
    au.close.enable = not_vscode;
    au.format_on_save.enable = not_vscode;
    au.trim_spaces.enable = not_vscode;
    au.ruler.enable = not_vscode;
    au.ruler.offsets = {
      rust: 80,
    };
    minv.settings.o.clipboard = "";
  });
}
