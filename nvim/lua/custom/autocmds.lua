local Util = require("deltavim.util")

Util.autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, "checktime")
return {
  {
    "@rulers",
    ft = {
      ["*"] = 80,
    },
  },
  { "@spell", false },
}
