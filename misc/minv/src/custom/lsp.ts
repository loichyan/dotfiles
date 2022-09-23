import { MINV } from "minv";

function disable_formatting(this: void, client: any) {
  client.resolved_capabilities.document_formatting = false;
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
                experimental: {
                  procAttrMacros: true,
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
