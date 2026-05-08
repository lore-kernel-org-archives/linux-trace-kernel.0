Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE4B3ECBD9;
	Fri,  8 May 2026 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778248521; cv=none; b=mWVCERghIJXTgp7/1r2Jg2pC4rTV5QRRXJyKR/0OAV6499wtmiQJ+Yfv28ttAPIpFHmzwr4ngXMtohac+t8i7sy44HHexbsIUSbemLgylxJLDAfjkqra6QF82N/smYOzVkHG+i8N4wFhO8xpf6HfkwloSv21O6qm2l5tS1sX76s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778248521; c=relaxed/simple;
	bh=kkoecny74LJgIgW/5iYUoKlLrxrKczIRJI0NZCuYMvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bd3YBdZt8LG/M6udZYNwnMYnJoDVLMp9B7MEexELWbyxc9Vkpd+AX5VE4svEO28oiA8J5/kHVkGQgzwn3zT2CgECU8/Lr29BfEGNXEhtLLcbliW5AXzdTvW8EtyX8hgNOTMEik27CAvb6O9cahDuPTMRRh4QBA2SuiNqe0M+D9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=pY+v9y9q; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="pY+v9y9q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=aj5Cqtcox71U+5h2OKpnOPAsf5akZe9A3AXzSGqFRAU=; b=pY+v9y9qPsgTMURV61FVKfqDPn
	mnRitVeQHHC6YYqcfq+GwweelsRxONkuCtV6AVnz3HbdXwqpBroEHCo7P58VVy4N/Rxtp4AkTy77m
	d6Nd9E6fGuwbSqNSpbFB74Wg0d3zAt8cqFDidebXV6N1QdNBUYRfOZd9ySfV4WXTpe6YGshE/D4Nb
	reT0m8Tx+FMserG6TnfaIKE2Ud3q73R2boasLPWYT23HH8oI6ggyvv605pJevuW2tkGQQoXaKFEsD
	v2uB5F04IkFnhG+4JuchJS65WhupAgOdhVxCAb+9t0KopeIv4ElHYIUhu14QGuGL/tVNR2mXl8h5S
	Upzl3azQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wLLfi-005Bwx-09;
	Fri, 08 May 2026 13:55:18 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 08 May 2026 06:55:04 -0700
Subject: [PATCH 2/2] tools/bootconfig: render kernel.* subtree as cmdline
 string with -C
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-bootconfig_using_tools-v1-2-1132219aa773@debian.org>
References: <20260508-bootconfig_using_tools-v1-0-1132219aa773@debian.org>
In-Reply-To: <20260508-bootconfig_using_tools-v1-0-1132219aa773@debian.org>
To: Masami Hiramatsu <mhiramat@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 paulmck@kernel.org, oss@malat.biz, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=4156; i=leitao@debian.org;
 h=from:subject:message-id; bh=kkoecny74LJgIgW/5iYUoKlLrxrKczIRJI0NZCuYMvw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp/es6Hins7PbaRWzUEXLRC/s7oKBZAd1R1TqQl
 NXGIbkIByeJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaf3rOgAKCRA1o5Of/Hh3
 bW18D/9Buv9UK84uL/xh8UNncW3OLrCebOXPTgHiAAFnzVNTF4egKYLaxk3pXeVk9WgTr5tvKvT
 9J3zgGByizFU36GX/KFiuVcVo8tQuTxR7eYed7wfiPQYdhPDA2MBKoc+pfnW8ph3mWo8e+xjYf4
 3AvwcV8GAoS8d1y4wc2WsB08P+1uLlXVpzDmFMDfhlGuDaQcb3Xtfu53vKBoB3nvy5BurUAx3aS
 csjrJ/kzx682SLw/IrIgUUzEIGEsgmySC735QXkIUNKW2Tk4gRdhUfaZDc7zs9SdgWct8Pq2FTT
 ypEJqaDCAcbLN+CENwO/BIarUMHYt1xH8peavIrOvbyxdjfyEnz9alWpFqVekbqSOl3U58sOU91
 WLh7LhincaJKDhHnmP+YnlU4Uwwq5j2zOSJJFcTGF9vZX3UM1l8RAB+L0whOc/mU/ypeAarJU3a
 FGu21iGD+a4sQtBw73K7unTiNg5pFtgFiTZgUrXX5Q53nqcOGom6IzP/tidE6bG4PLrPepOIGKb
 r8HMJYBFRkThm+euu1KsN+2xZf1rsuR7k1vygrtTOPY2EYjOSM5qBm6WNwlgWzhuCKgTXYvVyjl
 K6uOkJkVhQL8Ax2/tqswyp/AK+ICAd/n2L4Qfk7tZVo8/XrncKbqPT7YkyykTIu+IEFSW81Ol3m
 k2351mmTYo3Mg6g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Add a -C option that finds the "kernel" subtree of a bootconfig file
and prints it as a flat, space-separated cmdline string by calling the
shared xbc_snprint_cmdline() renderer. An empty or absent kernel.*
subtree produces empty output and exits successfully.

This lets the kernel build embed a bootconfig file as a plain cmdline
string at build time, so embedded bootconfig values can reach
parse_early_param() during architecture setup without parsing the
bootconfig at runtime.

The renderer is intentionally limited to the kernel.* subtree: that is
the only thing the kernel build needs to embed; init.* and other
subtrees keep going through the runtime parser.

Example of this new mode:
	# cat /tmp/test.bconf
	kernel {
		foo = bar
		baz = "hello world"
		arr = 1, 2
	}
	init.foo = nope

	# ./tools/bootconfig/bootconfig -C /tmp/test.bconf
	foo=bar baz="hello world" arr=1 arr=2 %

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/bootconfig/main.c | 60 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 8 deletions(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 643f707b8f1da..e1bfab044fbcb 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -286,7 +286,41 @@ static int init_xbc_with_error(char *buf, int len)
 	return ret;
 }
 
-static int show_xbc(const char *path, bool list)
+static int show_xbc_kernel_cmdline(void)
+{
+	struct xbc_node *root;
+	char *buf = NULL;
+	int len, ret;
+
+	root = xbc_find_node("kernel");
+	if (!root)
+		return 0;	/* no kernel.* keys: emit empty output */
+
+	len = xbc_snprint_cmdline(NULL, 0, root);
+	if (len < 0) {
+		pr_err("Failed to size cmdline output: %d\n", len);
+		return len;
+	}
+	if (len == 0)
+		return 0;
+
+	buf = malloc(len + 1);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = xbc_snprint_cmdline(buf, len + 1, root);
+	if (ret < 0) {
+		pr_err("Failed to render cmdline output: %d\n", ret);
+		free(buf);
+		return ret;
+	}
+
+	fputs(buf, stdout);
+	free(buf);
+	return 0;
+}
+
+static int show_xbc(const char *path, bool list, bool render_cmdline)
 {
 	int ret, fd;
 	char *buf = NULL;
@@ -322,11 +356,14 @@ static int show_xbc(const char *path, bool list)
 		if (init_xbc_with_error(buf, ret) < 0)
 			goto out;
 	}
-	if (list)
+	if (render_cmdline)
+		ret = show_xbc_kernel_cmdline();
+	else if (list)
 		xbc_show_list();
 	else
 		xbc_show_compact_tree();
-	ret = 0;
+	if (ret > 0)
+		ret = 0;
 out:
 	free(buf);
 
@@ -486,7 +523,10 @@ static int usage(void)
 		" Options:\n"
 		"		-a <config>: Apply boot config to initrd\n"
 		"		-d : Delete boot config file from initrd\n"
-		"		-l : list boot config in initrd or file\n\n"
+		"		-l : list boot config in initrd or file\n"
+		"		-C : render the kernel.* subtree as a flat cmdline\n"
+		"		     string (suitable for embedding in a kernel image)\n"
+		"		     and print it to stdout\n\n"
 		" If no option is given, show the bootconfig in the given file.\n");
 	return -1;
 }
@@ -495,10 +535,11 @@ int main(int argc, char **argv)
 {
 	char *path = NULL;
 	char *apply = NULL;
+	bool render_cmdline = false;
 	bool delete = false, list = false;
 	int opt;
 
-	while ((opt = getopt(argc, argv, "hda:l")) != -1) {
+	while ((opt = getopt(argc, argv, "hda:lC")) != -1) {
 		switch (opt) {
 		case 'd':
 			delete = true;
@@ -509,14 +550,17 @@ int main(int argc, char **argv)
 		case 'l':
 			list = true;
 			break;
+		case 'C':
+			render_cmdline = true;
+			break;
 		case 'h':
 		default:
 			return usage();
 		}
 	}
 
-	if ((apply && delete) || (delete && list) || (apply && list)) {
-		pr_err("Error: You can give one of -a, -d or -l at once.\n");
+	if ((!!apply + !!delete + !!list + !!render_cmdline) > 1) {
+		pr_err("Error: You can give one of -a, -d, -l or -C at once.\n");
 		return usage();
 	}
 
@@ -532,5 +576,5 @@ int main(int argc, char **argv)
 	else if (delete)
 		return delete_xbc(path);
 
-	return show_xbc(path, list);
+	return show_xbc(path, list, render_cmdline);
 }

-- 
2.53.0-Meta

