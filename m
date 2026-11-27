Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791055;
	b=GBdvsWsLNbSm5f8AB+cLiq/vaD0cxCC8umYp5HBd4B5v+qBNuBs69l99mwPb3VbDh+0B
	 XL1l9CEwZwW1Ct27/WB7YoZOikTW5tMjb6IF2WoFlBnyWZuByVHURVF6ZKeYRhTE1lEnu
	 enSTzhLXN+t5O9dmSOJXoZZKNoE4iJO+g3cVgJ8FSAsZlCHmWQW403MpPlj4rIojy2wu/
	 EFLMet3QmfuBWQeOS5gvg0DV19QRivqIcwVjch/h93izxA9vZe2X/qyqMdLGbdFnLY8Ss
	 70ZntuGlapPqTRbYCtOqZw3kxiGNBKXrDwtOdLT88x9n2+JnbqKzmdQ3a+1Po9NcjBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791055;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=IrVDsii1JVOpjs2e48kpePLg5m25U+wrVAxdhOnIiFY=;
	b=xBjeCCMj0R7Nhp1JBaCzGIiMOay8qqBSkbUh2Dqwl6NydWUW/yscedG2zjL/qyeEItbJ
	 tojPfBcMQc5GLyFO6EoMv57EJXUb2jRN0fVkVNTc144julw5B/19KS4knzh/ogmvC86kT
	 x3D2q7nuJQFQU0RHWAuizlTKUfdeo8XIT25CkrjiqgjzvStVMsKuavbVyjxtuypU5xo+o
	 X3wSR8bs5RBsIQGLTs2JkbwN4X4Fv6ywKSH7CoFDYiKPIMwWqTlymyCgkV/TheqZJcYny
	 MjaNoPGWGzUeUMGYpSzQwliVLOJnjJr72y6zjH8sn3IUCCNMohY4Xhastb33rfjb+1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=We8nHwte;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E17606A321;
	Fri, 27 Nov 2026 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=We8nHwte
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2C51F0089A;
	Fri, 27 Nov 2026 14:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795791055;
	bh=IrVDsii1JVOpjs2e48kpePLg5m25U+wrVAxdhOnIiFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=We8nHwteqUtxMC81QILBlfv4maEKnWA+dXlsu/sHXnziPRlRX7Ut6LaTFZKV0wZqF
	 +MiJ+wqU20pO29Qt4+djPoLkLpv5LUHybH02P9DUojaJ6vNI61kU/2T8vOMc3wgUzN
	 2NFUdave+Dn3vL4qQySXdfOfsCIN1kQBGDFEbaBKvwfJ1SBaczfp/eOnFwqupXMHPn
	 9ADYS/8HEQ7PvrAqTGCWNV+Qh6nVuS9UWUq2//NzLrgX8BZtYEdtdrnJpL7TBj71fq
	 flHjaIsO2iCK0SN0i5NryDhfqb/a1P3NYnqpG7mKlZAVFYld3LHnnG3GltSBqefjpJ
	 rcyL86nQO8YBg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: snambakam@microsoft.com, Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 1/5] bootconfig: Add multi-config ID helpers and xbc_init_configs() support
Date: Fri, 27 Nov 2026 14:46:15 +0000
Message-ID: <20261127144614.61194-2-mhiramat@kernel.org>
X-Mailer: UndineD 0.1
In-Reply-To: <20261127144614.61194-1-mhiramat@kernel.org>
References: <20261127144614.61194-1-mhiramat@kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

To allow bundling multiple bootconfig files in a single initrd (such as
in a Unified Kernel Image) and selecting a subset at boot, each attached
config needs an identifier and the parser must be able to merge multiple
selected configs into the XBC tree.

Store each named block's identifier as an in-band first-line comment
("#BOOTCONFIG-ID: <id>\n") rather than changing the 20-byte trailer
footer, keeping checksum and size framing unchanged. Restrict IDs to
1..31 bytes matching [A-Za-z_][A-Za-z0-9_.-]* so leading digits remain
unambiguously reserved for 0-based index selection and "," / "+" remain
available for command-line list syntax. Track the ID length in
struct xbc_config so xbc_parse_id_header() never needs to mutate initrd
or rodata memory in place.

Because struct xbc_node stores a 15-bit offset into a single xbc_data
buffer, xbc_init_configs() pre-calculates the combined size of all
enabled configs (up to XBC_DATA_MAX) and allocates xbc_data once without
realloc. Each config slice is separated by a NUL byte and parsed with a
fresh last_parent and brace_index so comments, quotes, and unclosed
braces cannot bleed across files, while any parse error offset is mapped
back to the offending config index and file-local byte offset.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/bootconfig.h                  |  29 ++
 lib/bootconfig.c                            | 355 ++++++++++++++++++--
 tools/bootconfig/include/linux/bootconfig.h |   4 +
 tools/bootconfig/main.c                     |   2 -
 4 files changed, 356 insertions(+), 34 deletions(-)

diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index f745068c07cd..899cb7ac6b64 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -31,6 +31,21 @@ bool __init cmdline_has_extra_options(void);
 #define BOOTCONFIG_FOOTER_SIZE	\
 	(sizeof(uint32_t) * 2 + BOOTCONFIG_MAGIC_LEN)
 
+#define BOOTCONFIG_ID_PREFIX		"#BOOTCONFIG-ID: "
+#define BOOTCONFIG_ID_PREFIX_LEN	16
+/* Maximum length of bootconfig ID including NUL */
+#define BOOTCONFIG_ID_MAX		32
+/* Maximum number of stacked bootconfig files in initrd */
+#define XBC_CONFIG_MAX			32
+
+struct xbc_config {
+	const char *name;
+	size_t name_len;
+	const char *data;
+	size_t size;
+	bool enabled;
+};
+
 /**
  * xbc_calc_checksum() - Calculate checksum of bootconfig
  * @data: Bootconfig data.
@@ -322,6 +337,20 @@ static inline int __init xbc_node_compose_key(struct xbc_node *node,
 
 /* XBC node initializer */
 int __init xbc_init(const char *buf, size_t size, const char **emsg, int *epos);
+int __init xbc_init_configs(const struct xbc_config *cfgs, int count,
+			    const char **emsg, int *epos, int *err_idx);
+
+/* Multi-config ID and selection helpers */
+bool __init xbc_valid_id(const char *id, size_t len);
+int __init xbc_parse_id_header(const char *data, size_t size,
+			       struct xbc_config *cfg);
+int __init __xbc_enable_configs(struct xbc_config *cfgs, int count,
+				const char *spec, bool *seeded, bool warn);
+static inline int __init xbc_enable_configs(struct xbc_config *cfgs, int count,
+					    const char *spec, bool *seeded)
+{
+	return __xbc_enable_configs(cfgs, count, spec, seeded, true);
+}
 
 /* XBC node and size information */
 int __init xbc_get_info(int *node_size, size_t *data_size);
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 9ae9a215b1da..fe27e72c9ee5 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -1034,13 +1034,6 @@ static int __init xbc_verify_tree(void)
 	size_t len, wlen;
 	struct xbc_node *n, *m;
 
-	/* Brace closing */
-	if (brace_index) {
-		n = &xbc_nodes[open_brace[brace_index - 1]];
-		return xbc_parse_error("Brace is not closed",
-					xbc_node_get_data(n));
-	}
-
 	/* Empty tree */
 	if (xbc_node_num == 0) {
 		xbc_parse_error("Empty config", xbc_data);
@@ -1085,13 +1078,15 @@ static int __init xbc_verify_tree(void)
 }
 
 /* Need to setup xbc_data and xbc_nodes before call this. */
-static int __init xbc_parse_tree(void)
+static int __init xbc_parse_tree(char *data, size_t size)
 {
 	char *p, *q;
 	int ret = 0, c;
+	struct xbc_node *n;
 
 	last_parent = NULL;
-	p = xbc_data;
+	brace_index = 0;
+	p = data;
 	do {
 		q = strpbrk(p, "{}=+;:\n#");
 		if (!q) {
@@ -1134,12 +1129,219 @@ static int __init xbc_parse_tree(void)
 	} while (!ret);
 
 	if (!ret) {
-		while (p < xbc_data + xbc_data_size - 1 && *p == '\0')
+		while (p < data + size && *p == '\0')
 			p++;
-		if (p < xbc_data + xbc_data_size - 1)
+		if (p < data + size)
 			ret = xbc_parse_error("Unexpected data after null character", p);
 	}
 
+	if (!ret && brace_index) {
+		n = &xbc_nodes[open_brace[brace_index - 1]];
+		ret = xbc_parse_error("Brace is not closed",
+				      xbc_node_get_data(n));
+	}
+
+	return ret;
+}
+
+/**
+ * xbc_valid_id() - Validate a bootconfig identifier string
+ * @id: Identifier string (not required to be NUL-terminated)
+ * @len: Length of @id in bytes
+ *
+ * A valid bootconfig ID has length 1..BOOTCONFIG_ID_MAX - 1, starts with an
+ * ASCII letter or underscore (digits are reserved for index numbers), and
+ * contains only ASCII letters, digits, '_', '-', or '.'.
+ *
+ * Return: true if @id is valid, false otherwise.
+ */
+bool __init xbc_valid_id(const char *id, size_t len)
+{
+	size_t i;
+
+	if (!id || len == 0 || len >= BOOTCONFIG_ID_MAX)
+		return false;
+
+	if (!(('a' <= id[0] && id[0] <= 'z') ||
+	      ('A' <= id[0] && id[0] <= 'Z') ||
+	      id[0] == '_'))
+		return false;
+
+	for (i = 1; i < len; i++) {
+		char c = id[i];
+
+		if (!(('a' <= c && c <= 'z') ||
+		      ('A' <= c && c <= 'Z') ||
+		      ('0' <= c && c <= '9') ||
+		      c == '_' || c == '-' || c == '.'))
+			return false;
+	}
+
+	return true;
+}
+
+/**
+ * xbc_parse_id_header() - Parse optional #BOOTCONFIG-ID header from a block
+ * @data: Bootconfig block buffer (may have trailing NUL padding)
+ * @size: Size of @data in bytes
+ * @cfg: Output descriptor to populate
+ *
+ * Strip trailing NUL padding from @data and check if line 1 starts with
+ * "#BOOTCONFIG-ID: <id>\n". If present, validate <id> and point @cfg->name
+ * at <id> with @cfg->name_len set, and @cfg->data past the newline.
+ * Otherwise set @cfg->name to "" (@cfg->name_len = 0) and @cfg->data to @data.
+ *
+ * Return: 0 on success, or -EINVAL if a malformed ID header is present.
+ */
+int __init xbc_parse_id_header(const char *data, size_t size,
+			       struct xbc_config *cfg)
+{
+	const char *id, *nl;
+
+	while (size > 0 && data[size - 1] == '\0')
+		size--;
+
+	cfg->enabled = false;
+	if (size >= BOOTCONFIG_ID_PREFIX_LEN &&
+	    !memcmp(data, BOOTCONFIG_ID_PREFIX, BOOTCONFIG_ID_PREFIX_LEN)) {
+		id = data + BOOTCONFIG_ID_PREFIX_LEN;
+		nl = memchr(id, '\n', size - BOOTCONFIG_ID_PREFIX_LEN);
+		if (!nl || !xbc_valid_id(id, nl - id))
+			return -EINVAL;
+		cfg->name = id;
+		cfg->name_len = nl - id;
+		cfg->data = nl + 1;
+		cfg->size = size - (size_t)(cfg->data - data);
+	} else {
+		cfg->name = "";
+		cfg->name_len = 0;
+		cfg->data = data;
+		cfg->size = size;
+	}
+
+	return 0;
+}
+
+static int __init xbc_parse_index(const char *p, size_t len)
+{
+	unsigned int idx = 0;
+	size_t i;
+
+	for (i = 0; i < len; i++) {
+		if (p[i] < '0' || p[i] > '9')
+			return -EINVAL;
+		idx = idx * 10 + (p[i] - '0');
+		if (idx >= XBC_CONFIG_MAX)
+			return -ERANGE;
+	}
+
+	return (int)idx;
+}
+
+/**
+ * __xbc_enable_configs() - Update enabled flags on bootconfig entries from spec
+ * @cfgs: Array of bootconfig descriptors
+ * @count: Number of entries in @cfgs
+ * @spec: Selection spec (NULL for default, "" to clear, "[+]<id_or_idx>,...")
+ * @seeded: Tracks whether a prior selection has already been applied
+ * @warn: If true, log pr_err() when a requested ID or index is not found
+ *
+ * Update @cfgs[i].enabled according to @spec:
+ * - NULL: clears all entries and enables @cfgs[0] (default).
+ * - "": clears all entries.
+ * - "+...": keeps existing enabled flags (seeding @cfgs[0] if !*@seeded),
+ *   then enables listed IDs/indices.
+ * - "<id_or_idx>,...": clears all entries, then enables listed IDs/indices.
+ *
+ * An empty comma-separated token selects @cfgs[0]. Numeric tokens select by
+ * 0-based index; identifier tokens match @cfgs[i].name.
+ *
+ * Return: 0 if all requested entries matched, or -ENOENT if any was missing.
+ */
+int __init __xbc_enable_configs(struct xbc_config *cfgs, int count,
+				const char *spec, bool *seeded, bool warn)
+{
+	const char *p, *comma;
+	int i, idx, ret = 0;
+	size_t len;
+
+	if (!spec) {
+		for (i = 0; i < count; i++)
+			cfgs[i].enabled = false;
+		if (count > 0)
+			cfgs[0].enabled = true;
+		if (seeded)
+			*seeded = true;
+		return 0;
+	}
+
+	if (*spec == '\0') {
+		for (i = 0; i < count; i++)
+			cfgs[i].enabled = false;
+		if (seeded)
+			*seeded = true;
+		return 0;
+	}
+
+	if (*spec == '+') {
+		spec++;
+		if ((!seeded || !*seeded) && count > 0)
+			cfgs[0].enabled = true;
+		if (seeded)
+			*seeded = true;
+		if (*spec == '\0')
+			return 0;
+	} else {
+		for (i = 0; i < count; i++)
+			cfgs[i].enabled = false;
+		if (seeded)
+			*seeded = true;
+	}
+
+	p = spec;
+	while (1) {
+		comma = strchr(p, ',');
+		len = comma ? (size_t)(comma - p) : strlen(p);
+		if (len == 0) {
+			if (count > 0) {
+				cfgs[0].enabled = true;
+			} else {
+				if (warn)
+					pr_err("bootconfig: default config not found\n");
+				ret = -ENOENT;
+			}
+		} else if (p[0] >= '0' && p[0] <= '9') {
+			idx = xbc_parse_index(p, len);
+			if (idx >= 0 && idx < count) {
+				cfgs[idx].enabled = true;
+			} else {
+				if (warn)
+					pr_err("bootconfig: '%.*s' not found\n",
+					       (int)len, p);
+				ret = -ENOENT;
+			}
+		} else {
+			bool matched = false;
+
+			for (i = 0; i < count; i++) {
+				if (cfgs[i].name_len == len &&
+				    !memcmp(cfgs[i].name, p, len)) {
+					cfgs[i].enabled = true;
+					matched = true;
+				}
+			}
+			if (!matched) {
+				if (warn)
+					pr_err("bootconfig: '%.*s' not found\n",
+					       (int)len, p);
+				ret = -ENOENT;
+			}
+		}
+		if (!comma)
+			break;
+		p = comma + 1;
+	}
+
 	return ret;
 }
 
@@ -1161,49 +1363,84 @@ void __init xbc_exit(void)
 	brace_index = 0;
 }
 
+static size_t __init xbc_config_slice_size(const struct xbc_config *cfg)
+{
+	if (!cfg->enabled || !cfg->data || cfg->size == 0)
+		return 0;
+
+	return cfg->size + (cfg->data[cfg->size - 1] != '\0' ? 1 : 0);
+}
+
 /**
- * xbc_init() - Parse given XBC file and build XBC internal tree
- * @data: The boot config text original data
- * @size: The size of @data
+ * xbc_init_configs() - Parse enabled XBC configs and build XBC internal tree
+ * @cfgs: Array of bootconfig descriptors
+ * @count: Number of entries in @cfgs
  * @emsg: A pointer of const char * to store the error message
- * @epos: A pointer of int to store the error position
+ * @epos: A pointer of int to store the error position (local to failing config)
+ * @err_idx: If non-NULL, set to index in @cfgs of the failing config on error
  *
- * This parses the boot config text in @data. @size must be smaller
- * than XBC_DATA_MAX.
- * Return the number of stored nodes (>0) if succeeded, or -errno
- * if there is any error.
- * In error cases, @emsg will be updated with an error message and
- * @epos will be updated with the error position which is the byte offset
- * of @buf. If the error is not a parser error, @epos will be -1.
+ * Concatenate all enabled entries in @cfgs into a single buffer of at most
+ * XBC_DATA_MAX bytes and parse each slice into the XBC tree.
+ * Return the number of stored nodes (>0) if succeeded, or -errno on error.
  */
-int __init xbc_init(const char *data, size_t size, const char **emsg, int *epos)
+int __init xbc_init_configs(const struct xbc_config *cfgs, int count,
+			    const char **emsg, int *epos, int *err_idx)
 {
-	int ret;
+	size_t total_size = 0, slice_size;
+	int i, ret = 0;
+	char *dst;
 
 	if (epos)
 		*epos = -1;
+	if (err_idx)
+		*err_idx = -1;
 
 	if (xbc_data) {
 		if (emsg)
 			*emsg = "Bootconfig is already initialized";
 		return -EBUSY;
 	}
-	if (size > XBC_DATA_MAX || size == 0) {
+
+	for (i = 0; i < count; i++) {
+		if (!cfgs[i].enabled || !cfgs[i].data || cfgs[i].size == 0)
+			continue;
+		if (cfgs[i].size > XBC_DATA_MAX) {
+			if (emsg)
+				*emsg = "Config data is too big";
+			return -ERANGE;
+		}
+		slice_size = xbc_config_slice_size(&cfgs[i]);
+		if (slice_size > XBC_DATA_MAX - total_size) {
+			if (emsg)
+				*emsg = "Config data is too big";
+			return -ERANGE;
+		}
+		total_size += slice_size;
+	}
+
+	if (total_size == 0) {
 		if (emsg)
-			*emsg = size ? "Config data is too big" :
-				"Config data is empty";
+			*emsg = "Config data is empty";
 		return -ERANGE;
 	}
 
-	xbc_data = xbc_alloc_mem(size + 1);
+	xbc_data = xbc_alloc_mem(total_size);
 	if (!xbc_data) {
 		if (emsg)
 			*emsg = "Failed to allocate bootconfig data";
 		return -ENOMEM;
 	}
-	memcpy(xbc_data, data, size);
-	xbc_data[size] = '\0';
-	xbc_data_size = size + 1;
+
+	dst = xbc_data;
+	for (i = 0; i < count; i++) {
+		slice_size = xbc_config_slice_size(&cfgs[i]);
+		if (!slice_size)
+			continue;
+		memcpy(dst, cfgs[i].data, cfgs[i].size);
+		dst[slice_size - 1] = '\0';
+		dst += slice_size;
+	}
+	xbc_data_size = total_size;
 
 	xbc_nodes = xbc_alloc_mem(sizeof(struct xbc_node) * XBC_NODE_MAX);
 	if (!xbc_nodes) {
@@ -1213,7 +1450,17 @@ int __init xbc_init(const char *data, size_t size, const char **emsg, int *epos)
 		return -ENOMEM;
 	}
 
-	ret = xbc_parse_tree();
+	dst = xbc_data;
+	for (i = 0; i < count; i++) {
+		slice_size = xbc_config_slice_size(&cfgs[i]);
+		if (!slice_size)
+			continue;
+		ret = xbc_parse_tree(dst, cfgs[i].size);
+		if (ret < 0)
+			break;
+		dst += slice_size;
+	}
+
 	if (!ret)
 		ret = xbc_verify_tree();
 #ifndef __KERNEL__
@@ -1222,6 +1469,23 @@ int __init xbc_init(const char *data, size_t size, const char **emsg, int *epos)
 #endif
 
 	if (ret < 0) {
+		if (xbc_err_pos >= 0) {
+			size_t off = 0;
+
+			for (i = 0; i < count; i++) {
+				slice_size = xbc_config_slice_size(&cfgs[i]);
+				if (!slice_size)
+					continue;
+				if ((size_t)xbc_err_pos >= off &&
+				    (size_t)xbc_err_pos < off + slice_size) {
+					if (err_idx)
+						*err_idx = i;
+					xbc_err_pos -= (int)off;
+					break;
+				}
+				off += slice_size;
+			}
+		}
 		if (epos)
 			*epos = xbc_err_pos;
 		if (emsg)
@@ -1233,3 +1497,30 @@ int __init xbc_init(const char *data, size_t size, const char **emsg, int *epos)
 
 	return ret;
 }
+
+/**
+ * xbc_init() - Parse given XBC file and build XBC internal tree
+ * @data: The boot config text original data
+ * @size: The size of @data
+ * @emsg: A pointer of const char * to store the error message
+ * @epos: A pointer of int to store the error position
+ *
+ * This parses the boot config text in @data. @size must be smaller
+ * than XBC_DATA_MAX.
+ * Return the number of stored nodes (>0) if succeeded, or -errno
+ * if there is any error.
+ * In error cases, @emsg will be updated with an error message and
+ * @epos will be updated with the error position which is the byte offset
+ * of @buf. If the error is not a parser error, @epos will be -1.
+ */
+int __init xbc_init(const char *data, size_t size, const char **emsg, int *epos)
+{
+	struct xbc_config cfg = {
+		.name = "",
+		.data = data,
+		.size = size,
+		.enabled = true,
+	};
+
+	return xbc_init_configs(&cfg, 1, emsg, epos, NULL);
+}
diff --git a/tools/bootconfig/include/linux/bootconfig.h b/tools/bootconfig/include/linux/bootconfig.h
index 6784296a0692..ac26cf8cbf8b 100644
--- a/tools/bootconfig/include/linux/bootconfig.h
+++ b/tools/bootconfig/include/linux/bootconfig.h
@@ -49,6 +49,10 @@ static inline char *strim(char *s)
 #define __init
 #define __initdata
 
+#ifndef pr_err
+#define pr_err(fmt, ...) fprintf(stderr, fmt, ##__VA_ARGS__)
+#endif
+
 #include "../../../../include/linux/bootconfig.h"
 
 #endif
diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index c85e58fcb6b0..6f68e02f6385 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -15,8 +15,6 @@
 
 #include <linux/bootconfig.h>
 
-#define pr_err(fmt, ...) fprintf(stderr, fmt, ##__VA_ARGS__)
-
 static void show_xbc_error(const char *data, const char *msg, int pos)
 {
 	int lin = 1, col, i;
-- 
2.43.0

