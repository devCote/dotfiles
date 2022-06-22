local ls = require"luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local fmt = require("luasnip.extras.fmt").fmt
local m = require("luasnip.extras").m
local lambda = require("luasnip.extras").l

ls.add_snippets("javascript", {
	s("rfc", {
		t("const "), i(1, "name"),
    t(" = ("), i(2, "{ ...props }"),
    t({") => {", "", "  return ( <div>"}), i(3, ""),
    t({"</div> )", "", "}"})
	})
})


