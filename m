Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C012D9EFF;
	Wed,  1 Apr 2026 14:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775052180; cv=none; b=agkI65i0zp1kLS4VAgnPDFC7x0wGpd4HFWYcppQ8mY6FP4Mk2s+pqqbi/WC/pXfMEsPzRMzvzPLNJKW8jzfQttW4I4YIqo7AfYnDv+gkH6bqzTD8L3bMyWjQm/RnhEQQCcyhWBs8CTTOhGwcvBo7u/rbuhYhB+Pz2PFXOCBpY9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775052180; c=relaxed/simple;
	bh=Ec+Z5yJc4hEbQOdPH/k3oSFFekUyw8YlfWQUNvhd/uA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NYcF0V/SoOFSabyUESuzZcBfnOn+TeHJUFEY5tyMeVqGQjqwfPjaliywO7pow2JB9IyC46BNMOeK9rtHDj7meNBAqs8rLTaX7NCZzlchuFMSDjnxshl7SF1cqSGza9Bi9nO5RCOhAQoZBudeK0hYRjXQfFSnufuEq5qRlTmGVAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnffJurN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnffJurN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305A5C4CEF7;
	Wed,  1 Apr 2026 14:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775052179;
	bh=Ec+Z5yJc4hEbQOdPH/k3oSFFekUyw8YlfWQUNvhd/uA=;
	h=From:To:Cc:Subject:Date:From;
	b=bnffJurNg1swkgXlIw8D/cnPCHIQ4tiOMdYQAhCWL55au/LnR0SvOyC8DHrTMg3Qp
	 jCvJTUnPomcAKjPiuKWIVk4gXSXReVXQITSCaST0ZVzy4caUctLHwhCgd9W6qHWGSI
	 wXFmFcLMkQGRU8EnI4MhE4sldV3ZaOuitvlNgMceOY6iIMa4QNlIzOfLC7dMV803B8
	 29tf24Sojaxfl048Rd57Qsx2VYvV3b9+EXwizUKZGH6nwZ3BUz04jE09gsUXc91OE6
	 kAv/zwZogHMFH8OhjUDyJ87D9VPrIoqQXW2LVrkIQiK7sim5h+f9uY+AiqsBY0eNhp
	 eLdxQBS2Ft3WA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Breno Leitao <leitao@debian.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] bootconfig: Skip printing early params to cmdline from bootconfig
Date: Wed,  1 Apr 2026 23:02:55 +0900
Message-ID:  <177505217508.1807250.22866077077504564.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

If user configures `kernel.key` in bootconfig, the 'key' is shown
in kernel cmdline (/proc/cmdline) and kernel boot parameter
handler associated with 'key' is invoked. However, since the
bootconfig does not support the parameter defined with early_param,
those keys are shown in '/proc/cmdline' but not handled by kernel.

This could easily mislead users who expected to be able to specify
early parameters via the boot configuration, leading them to wonder
why it doesn't work.

Let's skip printing out early params to cmdline buffer, and warn
if there is such parameters in bootconfig.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 init/main.c |   30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/init/main.c b/init/main.c
index 1cb395dd94e4..095c497ea2df 100644
--- a/init/main.c
+++ b/init/main.c
@@ -324,10 +324,21 @@ static void * __init get_boot_config_from_initrd(size_t *_size)
 
 static char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
 
+static bool __init is_early_param(const char *param)
+{
+	const struct obs_kernel_param *p;
+
+	for (p = __setup_start; p < __setup_end; p++) {
+		if (p->early && parameq(param, p->str))
+			return true;
+	}
+	return false;
+}
+
 #define rest(dst, end) ((end) > (dst) ? (end) - (dst) : 0)
 
 static int __init xbc_snprint_cmdline(char *buf, size_t size,
-				      struct xbc_node *root)
+				      struct xbc_node *root, bool is_kernel)
 {
 	struct xbc_node *knode, *vnode;
 	char *end = buf + size;
@@ -340,6 +351,13 @@ static int __init xbc_snprint_cmdline(char *buf, size_t size,
 		if (ret < 0)
 			return ret;
 
+		/* We will skip early params because it is not applied. */
+		if (is_kernel && is_early_param(xbc_namebuf)) {
+			pr_warn_once("early_param(e.g. %s.%s) is not passed to cmdline from bootconfig\n",
+				     xbc_node_get_data(root), xbc_namebuf);
+			continue;
+		}
+
 		vnode = xbc_node_get_child(knode);
 		if (!vnode) {
 			ret = snprintf(buf, rest(buf, end), "%s ", xbc_namebuf);
@@ -368,7 +386,7 @@ static int __init xbc_snprint_cmdline(char *buf, size_t size,
 #undef rest
 
 /* Make an extra command line under given key word */
-static char * __init xbc_make_cmdline(const char *key)
+static char * __init xbc_make_cmdline(const char *key, bool is_kernel)
 {
 	struct xbc_node *root;
 	char *new_cmdline;
@@ -379,7 +397,7 @@ static char * __init xbc_make_cmdline(const char *key)
 		return NULL;
 
 	/* Count required buffer size */
-	len = xbc_snprint_cmdline(NULL, 0, root);
+	len = xbc_snprint_cmdline(NULL, 0, root, is_kernel);
 	if (len <= 0)
 		return NULL;
 
@@ -389,7 +407,7 @@ static char * __init xbc_make_cmdline(const char *key)
 		return NULL;
 	}
 
-	ret = xbc_snprint_cmdline(new_cmdline, len + 1, root);
+	ret = xbc_snprint_cmdline(new_cmdline, len + 1, root, is_kernel);
 	if (ret < 0 || ret > len) {
 		pr_err("Failed to print extra kernel cmdline.\n");
 		memblock_free(new_cmdline, len + 1);
@@ -465,9 +483,9 @@ static void __init setup_boot_config(void)
 		xbc_get_info(&ret, NULL);
 		pr_info("Load bootconfig: %ld bytes %d nodes\n", (long)size, ret);
 		/* keys starting with "kernel." are passed via cmdline */
-		extra_command_line = xbc_make_cmdline("kernel");
+		extra_command_line = xbc_make_cmdline("kernel", true);
 		/* Also, "init." keys are init arguments */
-		extra_init_args = xbc_make_cmdline("init");
+		extra_init_args = xbc_make_cmdline("init", false);
 	}
 	return;
 }

