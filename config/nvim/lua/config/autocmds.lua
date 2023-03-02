local rulers = {
  lua = 80,
  rust = 80,
}
return {
  { "@auto_resize", true },
  { "@highlight_yank", true },
  { "@quit", true },
  { "@rulers", true, offsets = rulers },
  { "@sync_time", true },
  { "@trim_spaces", true },
}
