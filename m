Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791063;
	b=ZzoIJkxgQOmhzdbBxIEwaN2Lz4tp7swHtoMW/tYh5i0SB8xVo8djF/k+baD43jSVgcYB
	 wT3iii7VZXpEzsw2dzwJU+XWPnhvN9cVdPX/1CYrGo5UyraFiIYYpyae3NilLuu4T9BQV
	 9zESOM4lW2qcEjk/TCyCxXvWj0gJx8Q1IVhq3gTGuvpNdsG8j6GOY7wZTLXxXh7bWP1oY
	 Izr/NE8IfHPLA70EXTrVXRsDrlAwbRregBBo/xkY5+dBLPjTpmHnn9bl5j97mk4RyEegz
	 79Nrv3GEL4hPYkntLo3gOKy2VIEHeEArgnia9pEs3TcTd5J/o60i2CqVgT3oLEspVlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791063;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=mU/30650/bwhfEPPU/bfQEwRxUgVPROimkY3zqsbYnA=;
	b=lL9h5DK8TuoGMKzAXUjg+MK4bZd8myJT+zeK5oqZvyCfOt8BLsdcRF52dS5mclZ9PC1M
	 0k1C8iOJvQBoGMd0ouMzt+lgLwz09dUQr0R8/yikiDghe3JoT5Bj43tV2lctsnfhxDqFn
	 lCC9eRmvdZ/X/1yf+MlWJ6FoIY+YOsxVWIsh7bNUF3mftDws/3YLnauvtAK3ARiBdhnWU
	 kOy5ElGdW3gW6S6EnkpMT3MLG/ZqEY4vs470y0ouLMto+LfG8E6XcNxDmgfX/AZEut3rd
	 gxqe4Qe8M+iVWenCkpJJ4WVB6rqmSS8GQPQpi0krf3ohBuDgM3QGx9NrCWr6ouudblg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OYeIzLJS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80557606A31C;
	Fri, 27 Nov 2026 14:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OYeIzLJS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861AE1F0089C;
	Fri, 27 Nov 2026 14:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795791063;
	bh=mU/30650/bwhfEPPU/bfQEwRxUgVPROimkY3zqsbYnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OYeIzLJSF83eWbsDZvn58Yb5iUuNe0mrKd52MgexXX2nS4Zu5UD7T3G4pbvoEpLJs
	 OiV8yfs4t8ZouLwqpWPEMGHru55Y2/XoDD3ZgcWMjl7fynAhZAMzSyygVZUPz/4MVH
	 pIAxybtX72MK/eiWoedoc4VI7qynQa1ebNHbhzvF5cnZaqZRhAogwUd6+8JY4TWLQt
	 mxXhBbm6V+OOLAQvq902fMApbk0Lxz+iCdXIXVXMyr0/XIhU3NSNOd9gKGNbAeXSZo
	 A6eQnPf7+b947Qb71Pu9amt1tO+l9nlIMV494YzxNNfgw+2Y6cdqHc7fn/HL7Ca4B5
	 om+BlzKp6e6kw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: snambakam@microsoft.com, Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 2/5] bootconfig: Support stacked initrd bootconfigs and bootconfig= selection
Date: Fri, 27 Nov 2026 14:46:16 +0000
Message-ID: <20261127144614.61194-3-mhiramat@kernel.org>
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

Allow an initrd image to carry up to XBC_CONFIG_MAX (32) stacked
"#BOOTCONFIG" trailers and select which subset to load at boot via
bootconfig=[+][<sel>,...].

When peeling trailers backwards from initrd_end, populate a static
xbc_configs[XBC_CONFIG_MAX] array from the tail so entries land directly
in forward stack order (0 .. count - 1) without extra allocations. All
valid trailers are always stripped from initrd_end so initramfs
unpacking is unaffected even when bootconfig is not enabled or more than
XBC_CONFIG_MAX trailers are attached. If an individual block has a
malformed ID header or duplicates an earlier block's ID, only that block
is ignored so valid blocks (including block 0) can still load.

Define block 0 (the first block immediately after initramfs) as the
default bootconfig rather than the outermost trailer: this ensures that
appending optional debug/scenario overlays to an image does not alter
what bare "bootconfig" loads by default, and places the default config
first in stack-order merging so later overlays can override keys with
":=" or "+=".

Note on command-line ABI: previously "bootconfig=" with an empty value
was treated the same as bare "bootconfig". With parameterized selection,
"bootconfig=" now clears any earlier "bootconfig=..." selection on the
command line (for example, overriding a UKI's built-in .cmdline), except
when CONFIG_BOOT_CONFIG_FORCE=y is set, which continues to force block 0
so the Kconfig's unconditional-bootconfig guarantee is preserved.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  10 +
 arch/x86/kernel/setup.c                       |   7 +-
 include/linux/bootconfig.h                    |   3 +
 init/main.c                                   | 261 +++++++++++++-----
 lib/bootconfig.c                              | 121 ++++++--
 5 files changed, 304 insertions(+), 98 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0b3c140babd9..b514ec59c810 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -652,8 +652,18 @@ Kernel parameters
 			Format: integer
 
 	bootconfig	[KNL,EARLY]
+	bootconfig=[+][<sel>][,<sel>...]
 			Extended command line options can be added to an initrd
 			and this will cause the kernel to look for it.
+			When multiple bootconfig files are attached to the
+			initrd, each <sel> may be a bootconfig <id>, a 0-based
+			<index>, or empty (selecting index 0, e.g.
+			"bootconfig=,debug"). Selected configs are merged in
+			initrd stack order. Bare "bootconfig" selects index 0;
+			leading "+" appends to a prior selection (or to index 0
+			if none preceded it); empty "bootconfig=" clears any
+			prior selection (unless CONFIG_BOOT_CONFIG_FORCE=y is
+			set, which forces index 0 when no config is selected).
 
 			See Documentation/admin-guide/bootconfig.rst
 
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 19fc8e1714e6..b92482f2216b 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -927,11 +927,10 @@ void __init setup_arch(char **cmdline_p)
 #ifdef CONFIG_CMDLINE_FROM_BOOTCONFIG
 	/*
 	 * Prepend the build-time-rendered embedded "kernel" keys here so
-	 * parse_early_param() below sees them, using the same opt-in as the
-	 * runtime parser, plus the build-time CONFIG_BOOT_CONFIG_FORCE.
+	 * parse_early_param() below sees them, using the same opt-in and
+	 * index 0 selection rule as the runtime parser.
 	 */
-	if (bootconfig_cmdline_requested(boot_command_line, NULL) ||
-	    IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE))
+	if (bootconfig_cmdline_requested(boot_command_line, NULL))
 		xbc_prepend_embedded_cmdline(boot_command_line,
 					     COMMAND_LINE_SIZE);
 #endif
diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index 899cb7ac6b64..9b7f77c18c90 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -371,6 +371,9 @@ static inline const char *xbc_get_embedded_bootconfig(size_t *size)
 /* Bootconfig opt-in detection, shared by setup_arch() and setup_boot_config() */
 #ifdef CONFIG_BOOT_CONFIG
 bool __init bootconfig_cmdline_requested(const char *boot_cmdline, int *end_offset);
+bool __init xbc_select_cmdline_configs(const char *boot_cmdline,
+				       struct xbc_config *cfgs, int count,
+				       int *end_offset);
 #endif
 
 /* Build-time-rendered bootconfig cmdline prepended in setup_arch() */
diff --git a/init/main.c b/init/main.c
index f14780345051..a539eb5b0cd1 100644
--- a/init/main.c
+++ b/init/main.c
@@ -266,80 +266,117 @@ static int __init loglevel(char *str)
 early_param("loglevel", loglevel);
 
 #ifdef CONFIG_BLK_DEV_INITRD
-static void * __init get_boot_config_from_initrd(size_t *_size)
+static int __init get_boot_config_from_initrd(struct xbc_config *cfgs,
+					      int max_cfgs, int *count)
 {
 	u32 size, raw_size, csum;
 	char *data;
 	u8 *hdr;
-	int i;
+	int i, total = 0;
 
-	if (!initrd_end || initrd_end < initrd_start ||
-	    initrd_end - initrd_start < BOOTCONFIG_FOOTER_SIZE)
-		return NULL;
-
-	data = (char *)initrd_end - BOOTCONFIG_MAGIC_LEN;
-	/*
-	 * Since Grub may align the size of initrd to 4, we must
-	 * check the preceding 3 bytes as well.
-	 */
-	for (i = 0; i < 4; i++) {
-		if (!memcmp(data, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN))
-			goto found;
-		data--;
-	}
-	return NULL;
+	if (count)
+		*count = 0;
 
+	while (initrd_end && initrd_end >= initrd_start &&
+	       initrd_end - initrd_start >= BOOTCONFIG_FOOTER_SIZE) {
+		data = (char *)initrd_end - BOOTCONFIG_MAGIC_LEN;
+		/*
+		 * Since Grub may align the size of initrd to 4, we must
+		 * check the preceding 3 bytes for the outermost trailer.
+		 */
+		if (total == 0) {
+			for (i = 0; i < 4; i++) {
+				if (!memcmp(data, BOOTCONFIG_MAGIC,
+					    BOOTCONFIG_MAGIC_LEN))
+					goto found;
+				data--;
+			}
+			break;
+		} else if (memcmp(data, BOOTCONFIG_MAGIC,
+				  BOOTCONFIG_MAGIC_LEN)) {
+			break;
+		}
 found:
-	hdr = (u8 *)(data - 8);
-	if ((unsigned long)hdr < initrd_start)
-		return NULL;
+		hdr = (u8 *)(data - 8);
+		if ((unsigned long)hdr < initrd_start)
+			break;
 
-	raw_size = get_unaligned_le32(hdr);
-	csum = get_unaligned_le32(hdr + 4);
+		raw_size = get_unaligned_le32(hdr);
+		csum = get_unaligned_le32(hdr + 4);
 
-	if (raw_size > XBC_DATA_MAX_PADDED) {
-		pr_err("bootconfig size %u is greater than max size %d\n",
-			raw_size, XBC_DATA_MAX);
-		return NULL;
-	}
+		if (raw_size > XBC_DATA_MAX_PADDED) {
+			pr_err("bootconfig size %u is greater than max size %d\n",
+			       raw_size, XBC_DATA_MAX);
+			break;
+		}
 
-	if (raw_size > ((unsigned long)hdr - initrd_start)) {
-		pr_err("bootconfig size %u is greater than initrd size %lu\n",
-			raw_size, initrd_end - initrd_start);
-		return NULL;
-	}
+		if (raw_size > ((unsigned long)hdr - initrd_start)) {
+			pr_err("bootconfig size %u is greater than initrd size %lu\n",
+			       raw_size, initrd_end - initrd_start);
+			break;
+		}
 
-	data = ((void *)hdr) - raw_size;
+		data = ((void *)hdr) - raw_size;
 
-	size = xbc_exclude_padding(data, raw_size);
-	if (size > XBC_DATA_MAX) {
-		pr_err("bootconfig size %u is greater than max size %d\n",
-			size, XBC_DATA_MAX);
-		return NULL;
-	}
+		size = xbc_exclude_padding(data, raw_size);
+		if (size > XBC_DATA_MAX) {
+			pr_err("bootconfig size %u is greater than max size %d\n",
+			       size, XBC_DATA_MAX);
+			break;
+		}
 
-	if (xbc_calc_checksum(data, raw_size) != csum) {
-		pr_err("bootconfig checksum failed\n");
-		return NULL;
+		if (xbc_calc_checksum(data, raw_size) != csum) {
+			pr_err("bootconfig checksum failed\n");
+			break;
+		}
+
+		/*
+		 * Remove bootconfig from initramfs/initrd. Since the initrd
+		 * memory (including the bootconfig) is freed with initrd_end,
+		 * save the original end to free the whole region later.
+		 */
+		if (!initrd_mem_end)
+			initrd_mem_end = initrd_end;
+		initrd_end = (unsigned long)data;
+		total++;
+
+#ifdef CONFIG_BOOT_CONFIG
+		if (cfgs && max_cfgs > 0) {
+			struct xbc_config *slot;
+
+			if (total <= max_cfgs) {
+				slot = &cfgs[max_cfgs - total];
+			} else {
+				memmove(&cfgs[1], &cfgs[0],
+					(max_cfgs - 1) * sizeof(*cfgs));
+				slot = &cfgs[0];
+			}
+			if (xbc_parse_id_header(data, size, slot) < 0) {
+				slot->name = "";
+				slot->name_len = 0;
+				slot->data = NULL;
+				slot->size = 0;
+				slot->enabled = false;
+			}
+		}
+#endif
 	}
 
-	/*
-	 * Remove bootconfig from initramfs/initrd. Since the initrd memory
-	 * (including the bootconfig) is freed with initrd_end, save the
-	 * original end to free the whole region later.
-	 */
-	if (!initrd_mem_end)
-		initrd_mem_end = initrd_end;
-	initrd_end = (unsigned long)data;
-	if (_size)
-		*_size = size;
+	if (!cfgs || total == 0)
+		return 0;
+
+	if (count)
+		*count = total > max_cfgs ? max_cfgs : total;
 
-	return data;
+	return total;
 }
 #else
-static void * __init get_boot_config_from_initrd(size_t *_size)
+static int __init get_boot_config_from_initrd(struct xbc_config *cfgs,
+					      int max_cfgs, int *count)
 {
-	return NULL;
+	if (count)
+		*count = 0;
+	return 0;
 }
 #endif
 
@@ -444,29 +481,92 @@ static int __init warn_bootconfig(char *str)
 	return 0;
 }
 
+static struct xbc_config xbc_configs[XBC_CONFIG_MAX] __initdata;
+
+static void __init drop_bad_boot_configs(struct xbc_config *cfgs, int count)
+{
+	int i, j;
+
+	for (i = 0; i < count; i++) {
+		if (!cfgs[i].data || !cfgs[i].name_len)
+			continue;
+		for (j = i + 1; j < count; j++) {
+			if (cfgs[j].data &&
+			    cfgs[j].name_len == cfgs[i].name_len &&
+			    !memcmp(cfgs[j].name, cfgs[i].name,
+				    cfgs[i].name_len)) {
+				cfgs[j].data = NULL;
+				cfgs[j].size = 0;
+			}
+		}
+	}
+}
+
+static void __init report_bad_boot_configs(const struct xbc_config *cfgs,
+					   int count, int total)
+{
+	int i;
+
+	if (total > XBC_CONFIG_MAX)
+		pr_err("bootconfig: too many bootconfigs in initrd (%d > %d), ignoring extra blocks\n",
+		       total, XBC_CONFIG_MAX);
+
+	for (i = 0; i < count; i++) {
+		if (cfgs[i].data)
+			continue;
+		if (cfgs[i].name_len)
+			pr_err("bootconfig: duplicate ID '%.*s' in block %d, ignored\n",
+			       (int)cfgs[i].name_len, cfgs[i].name, i);
+		else
+			pr_err("bootconfig: invalid ID header in block %d, ignored\n",
+			       i);
+	}
+}
+
 static void __init setup_boot_config(void)
 {
-	const char *msg, *data;
-	int pos, ret, offs;
+	const char *msg, *embed_data;
+	struct xbc_config *cfgs = NULL;
+	int pos, ret, offs, total, count = 0, err_idx = -1, i;
 	size_t size;
 	bool from_embedded = false;
+	bool any_enabled = false;
 
-	/* Cut out the bootconfig data even if we have no bootconfig option */
-	data = get_boot_config_from_initrd(&size);
-	/* If there is no bootconfig in initrd, try embedded one. */
-	if (!data) {
-		data = xbc_get_embedded_bootconfig(&size);
-		from_embedded = true;
+	/* Cut out all bootconfig trailers even if we have no bootconfig option */
+	total = get_boot_config_from_initrd(xbc_configs, XBC_CONFIG_MAX, &count);
+	if (count > 0) {
+		cfgs = &xbc_configs[XBC_CONFIG_MAX - count];
+	} else {
+		/* If there is no bootconfig in initrd, try embedded one. */
+		embed_data = xbc_get_embedded_bootconfig(&size);
+		if (embed_data) {
+			if (xbc_parse_id_header(embed_data, size,
+						&xbc_configs[0]) < 0) {
+				xbc_configs[0].name = "";
+				xbc_configs[0].name_len = 0;
+				xbc_configs[0].data = embed_data;
+				xbc_configs[0].size = size;
+				xbc_configs[0].enabled = false;
+			}
+			cfgs = &xbc_configs[0];
+			count = 1;
+			total = 1;
+			from_embedded = true;
+		}
 	}
 
-	bootconfig_found = bootconfig_cmdline_requested(boot_command_line, &offs);
+	if (count > 0)
+		drop_bad_boot_configs(cfgs, count);
+
+	bootconfig_found = xbc_select_cmdline_configs(boot_command_line,
+						      cfgs, count, &offs);
 	if (!(bootconfig_found || IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE)))
 		return;
 
 	/* Offset of the init arguments after a "--", located by the helper. */
 	initargs_offs = offs;
 
-	if (!data) {
+	if (!count) {
 		/* If user intended to use bootconfig, show an error level message */
 		if (bootconfig_found)
 			pr_err("'bootconfig' found on command line, but no bootconfig found\n");
@@ -475,16 +575,35 @@ static void __init setup_boot_config(void)
 		return;
 	}
 
-	ret = xbc_init(data, size, &msg, &pos);
+	report_bad_boot_configs(cfgs, count, total);
+
+	if (!bootconfig_found && IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE))
+		cfgs[0].enabled = true;
+
+	for (i = 0; i < count; i++) {
+		if (cfgs[i].enabled && cfgs[i].data) {
+			any_enabled = true;
+			break;
+		}
+	}
+	if (!any_enabled)
+		return;
+
+	ret = xbc_init_configs(cfgs, count, &msg, &pos, &err_idx);
 	if (ret < 0) {
-		if (pos < 0)
+		if (err_idx >= 0)
+			pr_err("Failed to parse bootconfig [%d%s%.*s]: %s at %d.\n",
+			       err_idx, cfgs[err_idx].name_len ? ":" : "",
+			       (int)cfgs[err_idx].name_len,
+			       cfgs[err_idx].name, msg, pos);
+		else if (pos < 0)
 			pr_err("Failed to init bootconfig: %s.\n", msg);
 		else
 			pr_err("Failed to parse bootconfig: %s at %d.\n",
-				msg, pos);
+			       msg, pos);
 	} else {
-		xbc_get_info(&ret, NULL);
-		pr_info("Load bootconfig: %ld bytes %d nodes\n", (long)size, ret);
+		xbc_get_info(&ret, &size);
+		pr_info("Load bootconfig: %zu bytes %d nodes\n", size, ret);
 		/*
 		 * keys starting with "kernel." are passed via cmdline. When
 		 * this bootconfig came from the embedded source and
@@ -519,7 +638,7 @@ static void __init exit_boot_config(void)
 static void __init setup_boot_config(void)
 {
 	/* Remove bootconfig data from initrd */
-	get_boot_config_from_initrd(NULL);
+	get_boot_config_from_initrd(NULL, 0, NULL);
 }
 
 static int __init warn_bootconfig(char *str)
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index fe27e72c9ee5..44177b7c0866 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -115,33 +115,54 @@ bool __init xbc_embedded_cmdline_applied(void)
 }
 #endif	/* CONFIG_CMDLINE_FROM_BOOTCONFIG */
 
-/* parse_args() callback: flag when the "bootconfig" parameter is present. */
-static int __init bootconfig_optin(char *param, char *val,
-				   const char *unused, void *arg)
+struct xbc_cmdline_select_ctx {
+	struct xbc_config *cfgs;
+	int count;
+	bool seen;
+	bool active;
+	bool warn;
+};
+
+/* parse_args() callback: track opt-in and update enabled bootconfig entries. */
+static int __init xbc_cmdline_select_cb(char *param, char *val,
+					const char *unused, void *arg)
 {
-	if (!strcmp(param, "bootconfig"))
-		*(bool *)arg = true;
+	struct xbc_cmdline_select_ctx *ctx = arg;
+
+	if (strcmp(param, "bootconfig"))
+		return 0;
+
+	if (!val) {
+		ctx->active = true;
+	} else if (*val == '\0') {
+		ctx->active = false;
+	} else if (*val == '+') {
+		if (!ctx->seen || val[1] != '\0')
+			ctx->active = true;
+	} else {
+		ctx->active = true;
+	}
+
+	if (ctx->cfgs)
+		__xbc_enable_configs(ctx->cfgs, ctx->count, val,
+				     &ctx->seen, ctx->warn);
+	else
+		ctx->seen = true;
+
 	return 0;
 }
 
-/**
- * bootconfig_cmdline_requested() - Was "bootconfig" passed on the cmdline?
- * @boot_cmdline: kernel command line to inspect (not modified)
- * @end_offset: if non-NULL, set to the offset of the init arguments that
- *		follow a "--" separator, or 0 when there is none
- *
- * Parse a private copy of @boot_cmdline (parse_args() is destructive) and
- * report whether "bootconfig" is present before the "--" separator.
- * setup_arch() uses this to gate prepending the build-time embedded cmdline;
- * setup_boot_config() uses it for the runtime opt-in and to locate the init
- * arguments via @end_offset. Sharing one parser keeps the early and late
- * paths agreeing on what counts as opt-in. CONFIG_BOOT_CONFIG_FORCE is not
- * folded in here; callers apply it where they need it.
- */
-bool __init bootconfig_cmdline_requested(const char *boot_cmdline, int *end_offset)
+static bool __init xbc_parse_cmdline_bootconfig(const char *boot_cmdline,
+						struct xbc_config *cfgs,
+						int count, int *end_offset,
+						bool warn)
 {
 	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
-	bool found = false;
+	struct xbc_cmdline_select_ctx ctx = {
+		.cfgs = cfgs,
+		.count = count,
+		.warn = warn,
+	};
 	char *err;
 
 	if (end_offset)
@@ -149,7 +170,7 @@ bool __init bootconfig_cmdline_requested(const char *boot_cmdline, int *end_offs
 
 	strscpy(tmp_cmdline, boot_cmdline, COMMAND_LINE_SIZE);
 	err = parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0,
-			 &found, bootconfig_optin);
+			 &ctx, xbc_cmdline_select_cb);
 	if (IS_ERR(err))
 		return false;
 
@@ -157,7 +178,61 @@ bool __init bootconfig_cmdline_requested(const char *boot_cmdline, int *end_offs
 	if (end_offset && err)
 		*end_offset = err - tmp_cmdline;
 
-	return found;
+	return ctx.active;
+}
+
+/**
+ * bootconfig_cmdline_requested() - Should embedded bootconfig cmdline apply?
+ * @boot_cmdline: kernel command line to inspect (not modified)
+ * @end_offset: if non-NULL, set to the offset of the init arguments that
+ *		follow a "--" separator, or 0 when there is none
+ *
+ * Parse a private copy of @boot_cmdline (parse_args() is destructive) and
+ * report whether the default (index 0 / embedded) bootconfig is selected
+ * before the "--" separator, or forced by CONFIG_BOOT_CONFIG_FORCE when no
+ * active selection overrides it. setup_arch() uses this to gate prepending
+ * the build-time embedded cmdline, matching setup_boot_config()'s runtime
+ * selection rule.
+ */
+bool __init bootconfig_cmdline_requested(const char *boot_cmdline, int *end_offset)
+{
+	struct xbc_config emb = { .name = "", .name_len = 0, .enabled = false };
+	const char *data;
+	size_t size;
+	bool active;
+
+	data = xbc_get_embedded_bootconfig(&size);
+	if (data && xbc_parse_id_header(data, size, &emb) < 0) {
+		emb.name = "";
+		emb.name_len = 0;
+	}
+
+	active = xbc_parse_cmdline_bootconfig(boot_cmdline, &emb, 1,
+					      end_offset, false);
+	if (IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE) && !active)
+		return true;
+
+	return active && emb.enabled;
+}
+
+/**
+ * xbc_select_cmdline_configs() - Select bootconfig entries from cmdline
+ * @boot_cmdline: kernel command line to inspect (not modified)
+ * @cfgs: array of bootconfig descriptors from initrd or embedded fallback
+ * @count: number of entries in @cfgs
+ * @end_offset: if non-NULL, set to the offset of init arguments after "--"
+ *
+ * Evaluate all "bootconfig" parameters before "--" left-to-right and update
+ * @cfgs[i].enabled accordingly.
+ *
+ * Return: true if bootconfig remains active after parsing @boot_cmdline.
+ */
+bool __init xbc_select_cmdline_configs(const char *boot_cmdline,
+				       struct xbc_config *cfgs, int count,
+				       int *end_offset)
+{
+	return xbc_parse_cmdline_bootconfig(boot_cmdline, cfgs, count,
+					    end_offset, true);
 }
 
 #endif	/* __KERNEL__ */
-- 
2.43.0

