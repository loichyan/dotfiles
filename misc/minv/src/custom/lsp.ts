import { MINV } from "minv";

function disable_formatting(this: void, client: any) {
  client.server_capabilities.documentFormattingProvider = false;
}

export function setup_lsp(this: void, minv: MINV) {
  minv.update_preset({
    lspconfig: {
      servers: {
        $merge: {
          sumneko_lua: {},
          rust_analyzer: {
            settings: {
              "rust-analyzer": {
                checkOnSave: {
                  command: "clippy",
                },
              },
            },
          },
          taplo: {},
          clangd: {},
          tsserver: {
            on_attach(this: void, client: any) {
              disable_formatting(client);
            },
          },
          cssls: {
            on_attach(this: void, client: any) {
              disable_formatting(client);
            },
          },
          rnix: {},
        },
      },
    },
    null_ls_sources: {
      formatters: {
        $merge: {
          prettierd: {},
          stylua: {},
        },
      },
    },
  });
}
