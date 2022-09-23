export function setup(this: void) {
  const req = require as (this: void, mod: string) => AnyTbl;
  const npairs = req("nvim-autopairs");
  const cond = req("nvim-autopairs.conds");
  const Rule = req("nvim-autopairs.rule") as (
    this: void,
    ...args: any[]
  ) => any;
  npairs.setup({ check_ts: true });
  npairs.add_rules([
    Rule("<", ">")
      .with_pair(cond.none())
      .with_move(function (this: void, opts: any) {
        return opts.prev_char.match(">") != undefined;
      })
      .use_key(">"),
  ]);
}
