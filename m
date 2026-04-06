Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA142F6910;
	Mon,  6 Apr 2026 07:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775461772; cv=none; b=BMAvxnrIoVKX3wM6s2G/kT77v4XOlpxrGqK1WCo4AiviDQlv98EIFf8ssxJe4hxEzUpKEZ72OxLOyDEOmQYrOL3HalZgm0CVjdNuTVUjYlbLeQuIwORVFN70Sig0Vw+Dblb2jskEI72ms8C+hlMG8nF66Nz9DtapzCWtbNr0Zjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775461772; c=relaxed/simple;
	bh=c1wohnAYUr/kKo0BuzI5Rs/exqBKrCrMDFkLHg8Yr90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cr5b1qTyEtMvFej2EL2RPVbFwRwn769xjyK5R0ton9slKi7r7tHcAnC1U5zbCh4BCgHl+krrWrDXtoRWINmanRGvwPvWq1uBj92mZ7F1rhD3gCRax7eEyKZjXw5P0/4N/4PcmDbBcxiCe91Fjzbq/7xxg1EVCLMAN/u3P9lO5wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KG8RSXmh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KG8RSXmh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4555DC4CEF7;
	Mon,  6 Apr 2026 07:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775461772;
	bh=c1wohnAYUr/kKo0BuzI5Rs/exqBKrCrMDFkLHg8Yr90=;
	h=From:To:Cc:Subject:Date:From;
	b=KG8RSXmh4snuIZ2xLk3GHj2OT9I528FuRRfYGerIIfgewfDabL7XV69Aznwlc5XZR
	 5AAHkzLLlsZhmQq3BJwlxqdpCs8t7Lk6sB2/HFq46lrQTcQh1FapISr1bfTOuX8PTU
	 aEEpuF/DSpLLDUuOXqLSy9/p6B17CjZt6Bn7ExWE14QI/kpXoAjEpxON4mHQ8Wpdpo
	 DgPYIyksPHx4Bw1u/1bDC00TdLj7f3zuuUYgOKgw7uq1qIg/cktY9ITo4wsCJmQnVH
	 I4fsCKh8yR3XtvsgO0oOoV0QgqyDChPs5WeoMVbvAyYSdXscjuWuECQMCAbECtLM9u
	 TGsaLNS51VScg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Breno Leitao <leitao@debian.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2] bootconfig: Skip printing early params to cmdline from bootconfig
Date: Mon,  6 Apr 2026 16:49:27 +0900
Message-ID:  <177546176716.129825.16538253643244984532.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
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
 Changes in v2:
  - Check if the parameter is defined only by early_param().
---
 init/main.c |   35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/init/main.c b/init/main.c
index 1cb395dd94e4..e4687c00e8fb 100644
--- a/init/main.c
+++ b/init/main.c
@@ -324,10 +324,26 @@ static void * __init get_boot_config_from_initrd(size_t *_size)
 
 static char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
 
+/* Return true if the given param is only defined by early_param(). */
+static bool __init is_early_only_param(const char *param)
+{
+	const struct obs_kernel_param *p;
+	bool ret = false;
+
+	for (p = __setup_start; p < __setup_end; p++) {
+		if (parameq(param, p->str)) {
+			if (!p->early)
+				return false;
+			ret = true;
+		}
+	}
+	return ret;
+}
+
 #define rest(dst, end) ((end) > (dst) ? (end) - (dst) : 0)
 
 static int __init xbc_snprint_cmdline(char *buf, size_t size,
-				      struct xbc_node *root)
+				      struct xbc_node *root, bool is_kernel)
 {
 	struct xbc_node *knode, *vnode;
 	char *end = buf + size;
@@ -340,6 +356,13 @@ static int __init xbc_snprint_cmdline(char *buf, size_t size,
 		if (ret < 0)
 			return ret;
 
+		/* We will skip early params because it is not applied. */
+		if (is_kernel && is_early_only_param(xbc_namebuf)) {
+			pr_warn_once("bootconfig: early_param(e.g. %s.%s) can not be handled.\n",
+				     xbc_node_get_data(root), xbc_namebuf);
+			continue;
+		}
+
 		vnode = xbc_node_get_child(knode);
 		if (!vnode) {
 			ret = snprintf(buf, rest(buf, end), "%s ", xbc_namebuf);
@@ -368,7 +391,7 @@ static int __init xbc_snprint_cmdline(char *buf, size_t size,
 #undef rest
 
 /* Make an extra command line under given key word */
-static char * __init xbc_make_cmdline(const char *key)
+static char * __init xbc_make_cmdline(const char *key, bool is_kernel)
 {
 	struct xbc_node *root;
 	char *new_cmdline;
@@ -379,7 +402,7 @@ static char * __init xbc_make_cmdline(const char *key)
 		return NULL;
 
 	/* Count required buffer size */
-	len = xbc_snprint_cmdline(NULL, 0, root);
+	len = xbc_snprint_cmdline(NULL, 0, root, is_kernel);
 	if (len <= 0)
 		return NULL;
 
@@ -389,7 +412,7 @@ static char * __init xbc_make_cmdline(const char *key)
 		return NULL;
 	}
 
-	ret = xbc_snprint_cmdline(new_cmdline, len + 1, root);
+	ret = xbc_snprint_cmdline(new_cmdline, len + 1, root, is_kernel);
 	if (ret < 0 || ret > len) {
 		pr_err("Failed to print extra kernel cmdline.\n");
 		memblock_free(new_cmdline, len + 1);
@@ -465,9 +488,9 @@ static void __init setup_boot_config(void)
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

