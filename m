Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41D44E3779;
	Thu,  3 Sep 2026 15:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449001; cv=none; b=UP5nICITX1FGcEFPZgEEU+795G7FjYfiNQrcGbrl5GTFfs7JgxXWI2Hkyi8Ou2NSJ+NoZN+tDc5QT/7k1yGOBY3CjO1K3mBcRiweNZ8QYB/feZRA1lnFZn1W6nVUIWr2gMf6EANNSVnQpILXr1o3ASEo7ubY2uABmg/E9ijur2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449001; c=relaxed/simple;
	bh=o2+jE7zMGV521nI3uzRtLApGCI55D68YCg4DPbBy104=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jWF37EpX7oavJUFbJ+BiucE+0Tv56q2jOu6+r2hDeEZxfjE144Lrsr9tL2cccXF5sfZe7vh4qnsigehqgSPExuq8psaTGVDeTFvG8dUDa6yeeurd+0nrsaSXbJAogHhaXTAK5LLOkz647spCrvHguxC87hgSNbdOkYdMzRd9Qb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dj/wJPv8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dj/wJPv8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9251F00A3E;
	Thu,  3 Sep 2026 15:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788448998;
	bh=XkCXKilCOc9Ih+HiuXfcOSyP8S6gCoctHhMqE3KtinY=;
	h=From:To:Cc:Subject:Date;
	b=Dj/wJPv8N4PcTP5EXHvhHOrZN+YatDBBir29FpcnTVGSNXzos7H5BozqwqSpPp4Be
	 hISsQBdHlxiaRCDJ/am+kcC4hqnuNRx3uBwibdKg1YgvImdJT8fPipKyAGeMBTv9Qp
	 T+4dahwF+Fo3ohhsMSmgyGr0U5GM97QGwGgh8iDeiVNKkEKnFx3irIn0lH8iurtTKF
	 4FxhsFoBdNNsgdoJoHVyzGmAFimQbQhzUWGbRDc1BBUISRKGMHjfyNbhZeBnDn3aDd
	 iyg8F6Dwdhu54zAAFw+DRbz7z9Et5/bZIfaKYJjr+GQlql9Cn5y9K9nJAxUB98vp3I
	 c4ndTNmUazfqA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Breno Leitao <leitao@debian.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3] bootconfig: Skip printing early params to cmdline from bootconfig
Date: Fri,  4 Sep 2026 00:23:15 +0900
Message-ID: <178844899530.263905.7707547252181797215.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
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
Changes in v3:
 - Add xbc_snprint_cmdline_filter() for filter support.
 - Fix param matching for dual early/late params (e.g. console=) and
   module parameters so they are not incorrectly dropped.
 - Print warning for skipped parameter.
---
 include/linux/bootconfig.h |   10 +++++-
 init/main.c                |   73 ++++++++++++++++++++++++++++++++++++++++----
 lib/bootconfig.c           |   16 +++++++---
 3 files changed, 87 insertions(+), 12 deletions(-)

diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index deda507500da..1f929034d42f 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -266,7 +266,15 @@ int __init xbc_node_compose_key_after(struct xbc_node *root,
 			struct xbc_node *node, char *buf, size_t size);
 
 /* Render key/value pairs under @root as a flat cmdline string */
-int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root);
+typedef bool (*xbc_cmdline_filter_fn)(struct xbc_node *node, const char *key, void *data);
+
+int __init xbc_snprint_cmdline_filter(char *buf, size_t size, struct xbc_node *root,
+				      xbc_cmdline_filter_fn filter, void *data);
+
+static inline int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root)
+{
+	return xbc_snprint_cmdline_filter(buf, size, root, NULL, NULL);
+}
 
 /**
  * xbc_node_compose_key() - Compose full key string of the XBC node
diff --git a/init/main.c b/init/main.c
index 2613d3f9b3ce..aaee5625e123 100644
--- a/init/main.c
+++ b/init/main.c
@@ -325,9 +325,64 @@ static void * __init get_boot_config_from_initrd(size_t *_size)
 
 #ifdef CONFIG_BOOT_CONFIG
 
+/* Check if a parameter name matches an obs_kernel_param entry */
+static bool __init match_obs_param(const char *param, const char *pattern)
+{
+	size_t n = strlen(pattern);
+
+	if (n > 0 && pattern[n - 1] == '=')
+		return parameqn(param, pattern, n - 1) && param[n - 1] == '\0';
+
+	return parameq(param, pattern);
+}
+
+/* Return true if the given param is only defined by early_param(). */
+static bool __init is_early_only_param(const char *param)
+{
+	const struct obs_kernel_param *p;
+	const struct kernel_param *kp;
+	bool has_early = false;
+
+	/* If handled by a regular module_param, it is not early-only */
+	for (kp = __start___param; kp < __stop___param; kp++) {
+		if (parameq(param, kp->name))
+			return false;
+	}
+
+	/* Check __setup / early_param table */
+	for (p = __setup_start; p < __setup_end; p++) {
+		if (match_obs_param(param, p->str)) {
+			if (!p->early)
+				return false;
+			has_early = true;
+		}
+	}
+	return has_early;
+}
+
+struct xbc_filter_data {
+	bool warn;
+};
+
+static bool __init xbc_kernel_param_filter(struct xbc_node *node,
+					   const char *key, void *data)
+{
+	struct xbc_filter_data *fdata = data;
+
+	if (is_early_only_param(key)) {
+		if (fdata && fdata->warn)
+			pr_warn("bootconfig: early_param 'kernel.%s' cannot be applied from bootconfig, skipping\n",
+				key);
+		return false;
+	}
+	return true;
+}
+
 /* Make an extra command line under given key word */
-static char * __init xbc_make_cmdline(const char *key)
+static char * __init xbc_make_cmdline(const char *key, bool is_kernel)
 {
+	struct xbc_filter_data fdata = { .warn = true };
+	xbc_cmdline_filter_fn filter = is_kernel ? xbc_kernel_param_filter : NULL;
 	struct xbc_node *root;
 	char *new_cmdline;
 	int ret, len = 0;
@@ -336,8 +391,12 @@ static char * __init xbc_make_cmdline(const char *key)
 	if (!root)
 		return NULL;
 
-	/* Count required buffer size */
-	len = xbc_snprint_cmdline(NULL, 0, root);
+	/*
+	 * Pass 1: Count required buffer size. Emit warnings for skipped early
+	 * params in this pass so they are logged even if all parameters under
+	 * @key are skipped and len becomes 0.
+	 */
+	len = xbc_snprint_cmdline_filter(NULL, 0, root, filter, &fdata);
 	if (len <= 0)
 		return NULL;
 
@@ -347,7 +406,9 @@ static char * __init xbc_make_cmdline(const char *key)
 		return NULL;
 	}
 
-	ret = xbc_snprint_cmdline(new_cmdline, len + 1, root);
+	/* Pass 2: Render into buffer with warnings suppressed */
+	fdata.warn = false;
+	ret = xbc_snprint_cmdline_filter(new_cmdline, len + 1, root, filter, &fdata);
 	if (ret < 0 || ret > len) {
 		pr_err("Failed to print extra kernel cmdline.\n");
 		memblock_free(new_cmdline, len + 1);
@@ -427,9 +488,9 @@ static void __init setup_boot_config(void)
 		 * before this series.
 		 */
 		if (!from_embedded || !xbc_embedded_cmdline_applied())
-			extra_command_line = xbc_make_cmdline("kernel");
+			extra_command_line = xbc_make_cmdline("kernel", true);
 		/* Also, "init." keys are init arguments */
-		extra_init_args = xbc_make_cmdline("init");
+		extra_init_args = xbc_make_cmdline("init", false);
 	}
 	return;
 }
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 89c88e359179..820f6cf28456 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -539,18 +539,21 @@ static char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
 #define rest(dst, end) ((end) > (dst) ? (end) - (dst) : 0)
 
 /**
- * xbc_snprint_cmdline() - Render bootconfig keys under @root as a cmdline string
+ * xbc_snprint_cmdline_filter() - Render bootconfig keys as cmdline string
  * @buf: Destination buffer (may be NULL when @size is 0 to query the length)
  * @size: Size of @buf in bytes
  * @root: Subtree root whose key=value pairs should be rendered
+ * @filter: Filter callback (returns true to include, false to skip; may be NULL)
+ * @data: Private context passed to @filter
  *
  * Walk all key/value pairs under @root and emit them as a space-separated
  * cmdline string into @buf. Values containing whitespace are quoted with
- * double quotes. Returns the number of bytes that would be written if @buf
- * were large enough (matching snprintf semantics), or a negative errno on
- * failure.
+ * double quotes. Keys for which @filter returns false are omitted.
+ * Returns the number of bytes that would be written if @buf were large enough
+ * (matching snprintf semantics), or a negative errno on failure.
  */
-int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root)
+int __init xbc_snprint_cmdline_filter(char *buf, size_t size, struct xbc_node *root,
+				      xbc_cmdline_filter_fn filter, void *data)
 {
 	struct xbc_node *knode, *vnode;
 	const char *val, *q;
@@ -582,6 +585,9 @@ int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root)
 		if (ret < 0)
 			return ret;
 
+		if (filter && !filter(knode, xbc_namebuf, data))
+			continue;
+
 		vnode = xbc_node_get_child(knode);
 		if (!vnode) {
 			ret = snprintf(buf ? buf + len : NULL, rest(len, size),

