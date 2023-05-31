return {
  s("clg", fmt("console.log(('{}'))", {i(1, "")})),
	s("psf", fmt("{1} {2} {3} {4} {{}}", { c(1, { t("public"), t("private"), }), c(2, { t(""), t("static")}), i(3, ""), i(4, "") })),
}
