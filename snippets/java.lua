return {
	s("sout", {
		t('System.out.println("'),
		i(1, ""),
		t('");'),
	}),
	s("sysout", {
		t('System.out.println("'),
		i(1, ""),
		t('");'),
	}),
	s("psvm", {
		t({ "public static void main(String[] args) {", "\t" }),
		i(1, ""),
		t({ "", "}" }),
	}),
	s("c", {
		t("class "),
		i(1, ""),
		t({ " {", "\t" }),
		i(2, ""),
		t({ "", "}" }),
	}),
	s("psf", fmt("{1} {2} {3} {4} {{}}", { c(1, { t("public"), t("private"), }), c(2, { t(""), t("static")}), i(3, ""), i(4, "") })),
}
