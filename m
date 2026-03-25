Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAC73A543C;
	Wed, 25 Mar 2026 10:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774433204; cv=none; b=IZIvib3Jx77APf2EaoC1CBlCKFVzwOkOwPjPtAJbfwW+fjuceJ0Dn70+EcampFFYvJJUekwuySRhIxYY2LVYqJvLtu/z4EHAMPkMSWMQagIrB1/X3EGhsXIpODeH9lnzRsgXVK3jv8huPPVcUb+plYAecHHrAMaluoHFaSpEbPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774433204; c=relaxed/simple;
	bh=gqstBkE5KpEtHYJXxjJXNFib5hjXrHq5i5zqeAS3WbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=M4smCmR8JszJ5yHMkCShRIav7Q8Oe6/fcpFpQqcSW9gKLKWKzhRQfj5o4w2huAqKZ3QpmT3mvNUQ4Hl3NmTU5TX68Ca9EdWw+zGqv8KIEXcxVpOtAGaEODhKlKH+e43D4EWC6HcwqGbe2fPqeM9nrUkeJtGN3U7qUmaU1wqb2mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=deWkSt+X; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="deWkSt+X"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=7iT+5Op9dAVieVaBzZ4GUWxsOw/gXfMUawtngVu1qjA=; b=deWkSt+XfCx8NU/LPrqt9WvHsr
	acqnPRZFWBkDdteA6YRs1UZXPOYvmlPfUASi984MM15pXj6BsyBw8bJ3yZkJfIjSjgmI7mFxVZuzq
	DhrTWDwb/n8WVvoicK7q5mIdv9bUAhvpjNzVQ7lWPGkJ9SebmjvRtZJMXcEHBzN0HjVknuoQwQCsY
	7vA6euqs2wQZVq5GAyfULM3uRttt5l9BbZe/9FS4NDlhRj/cQ+Wt29J4Pqg2yoAlqVIZER/NFwaPn
	FDbPZ+ajLh8UBESwPyolUWENXDNM3fBqCrPmTjYM4uLK4J4U8IPDzUrjrk661rO2RIiYkL6J8QGPE
	//GTNkog==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w5L8E-008zyK-3A; Wed, 25 Mar 2026 10:06:33 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 25 Mar 2026 03:05:38 -0700
Subject: [PATCH v2] bootconfig: Apply early options from embedded config
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260325-early_bootconfig-v2-1-6b05a36fbfb5@debian.org>
X-B4-Tracking: v=1; b=H4sIAHKzw2kC/2XNSwqDMBSF4a2EOzYlDxXqqPsoUmK80VtKUpJUK
 pK9Fy0ddXjg5zsbJIyECTq2QcSFEgUPHVMVAzsbPyGnEToGSqhWaKU5mvhYb0MI2QbvaOIKna0
 bcTZOj1AxeEZ09D7Ia//d6TXc0ebd2YuZUg5xPT4XuXc/vv7nF8kll1ZgqxrjnGgvIw5k/CnEC
 fpSygcAnWK0wwAAAA==
X-Change-ID: 20260323-early_bootconfig-2efc4509af3d
To: Masami Hiramatsu <mhiramat@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, oss@malat.biz, paulmck@kernel.org, 
 rostedt@goodmis.org, kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=6622; i=leitao@debian.org;
 h=from:subject:message-id; bh=gqstBkE5KpEtHYJXxjJXNFib5hjXrHq5i5zqeAS3WbM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpw7Ol/aODv43YbF3NF7hpBeFqgk9DslYiz4UIy
 MhWrJbdPi6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCacOzpQAKCRA1o5Of/Hh3
 bTroD/4kSbqG12CvIkzSKG6TCGRAUtwTIeEIwxt6PGr9DKxqp8jn3wsrSPI6x7X4UJ+EfX90Ecs
 xHChUpGjcltNROQuy9fakB3rmdNo1A165fbW/c1ls44WHQ25RwHuJwnvsp1B0zLTqxmINpAcjVi
 Cm30GmcpsA4CtNto57FDGB++B6LMBie8c2rHjtgSLAMqDZJgw4j3NrkWmadmLrnrBgucV7t7GIj
 f901oSx6JKCXJ3pPrkJc6fo3n/DNU+5sHkojXTNu00JnhDjHvw+4AljU5AWsPpa7g4i/UMGg87x
 As20YiQsD7SQMkism1dxvPwRUmLCvFgcDFd6iyUff0vrfZS49ohWsqO5BetKgmnNaw6zvM3NTwI
 Wd2Ht0lnMaUq5LGy/iecYPA1TiqrkF0Hi3qUIPI0/BUngZFTuA0PhYSIDLSoPqTRJ6qHgJjCVWd
 oNk5+9rDUY6BmTVYKuw5XKpc4uAZIHnKVXxsHxjPRW48gyCEE/TwNX4Gzr+iXLiznWh44Q3MKnw
 pGnoV5o3CZsaQ52FHyG5llY0npNvDRUDNo7/E/78mJv/F0ydTG2hBW38In1/O8bvTrDySA5ePAW
 hKZqejbLwYEs2mZj+17mKUyxe8TntdSH3LBKdi76ADUt4br2Ud9zFiXljIims0Tw+5c7ahxwFCk
 AaNQRSkCY9nKAQQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Bootconfig currently cannot be used to configure early kernel
parameters. For example, the "mitigations=" parameter must be passed
through traditional boot methods because bootconfig parsing happens
after these early parameters need to be processed.

This patch allows early options such as:

  kernel.mitigations = off

to be placed in the embedded bootconfig and take effect, without
requiring them to be on the kernel command line.

Add bootconfig_apply_early_params() which walks all kernel.* keys in the
parsed XBC tree and calls do_early_param() for each one. It is called
from setup_boot_config() immediately after a successful xbc_init() on
the embedded data, which happens before parse_early_param() runs in
start_kernel().

Early options in initrd bootconfig are still silently ignored, as the
initrd is only available after the early param window has closed.

Document this behaviour in both Kconfig and the admin guide.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Made val_buf static __initdata to keep 2KB off the stack
- Removed dead !val branch — xbc_node_find_next_key_value() returns "" for boolean keys, never NULL
- Added pr_warn + continue when strscpy truncates the value
- Link to v1: https://patch.msgid.link/20260324-early_bootconfig-v1-1-1c0e625aff06@debian.org
---
 Documentation/admin-guide/bootconfig.rst |  4 ++
 init/Kconfig                             |  6 +++
 init/main.c                              | 68 +++++++++++++++++++++++++++++++-
 3 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index f712758472d5c..e820f33d3ad16 100644
--- a/Documentation/admin-guide/bootconfig.rst
+++ b/Documentation/admin-guide/bootconfig.rst
@@ -169,6 +169,10 @@ Boot Kernel With a Boot Config
 There are two options to boot the kernel with bootconfig: attaching the
 bootconfig to the initrd image or embedding it in the kernel itself.
 
+Early options (those registered with ``early_param()``) may only be
+specified in the embedded bootconfig, because the initrd is not yet
+available when early parameters are processed.
+
 Attaching a Boot Config to Initrd
 ---------------------------------
 
diff --git a/init/Kconfig b/init/Kconfig
index 938fbe6a91e15..5e8057e73fe06 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1534,6 +1534,12 @@ config BOOT_CONFIG_EMBED
 	  image. But if the system doesn't support initrd, this option will
 	  help you by embedding a bootconfig file while building the kernel.
 
+	  Unlike bootconfig attached to initrd, the embedded bootconfig also
+	  supports early options (those registered with early_param()). Any
+	  kernel.* key in the embedded bootconfig is applied before
+	  parse_early_param() runs. Early options in initrd bootconfig will
+	  not be applied.
+
 	  If unsure, say N.
 
 config BOOT_CONFIG_EMBED_FILE
diff --git a/init/main.c b/init/main.c
index 453ac9dff2da0..14a04c283fa48 100644
--- a/init/main.c
+++ b/init/main.c
@@ -416,9 +416,64 @@ static int __init warn_bootconfig(char *str)
 	return 0;
 }
 
+/*
+ * do_early_param() is defined later in this file but called from
+ * bootconfig_apply_early_params() below, so we need a forward declaration.
+ */
+static int __init do_early_param(char *param, char *val,
+				 const char *unused, void *arg);
+
+/*
+ * bootconfig_apply_early_params - dispatch kernel.* keys from the embedded
+ * bootconfig as early_param() calls.
+ *
+ * early_param() handlers must run before most of the kernel initialises
+ * (e.g. before the GIC driver reads irqchip.gicv3_pseudo_nmi).  A bootconfig
+ * attached to the initrd arrives too late for this because the initrd is not
+ * mapped yet when early params are processed.  The embedded bootconfig lives
+ * in the kernel image itself (.init.data), so it is always reachable.
+ *
+ * This function is called from setup_boot_config() which runs in
+ * start_kernel() before parse_early_param(), making the timing correct.
+ */
+static void __init bootconfig_apply_early_params(void)
+{
+	static char val_buf[COMMAND_LINE_SIZE] __initdata;
+	struct xbc_node *knode, *root;
+	const char *val;
+	ssize_t ret;
+
+	root = xbc_find_node("kernel");
+	if (!root)
+		return;
+
+	/*
+	 * Keys that do not match any early_param() handler are silently
+	 * ignored — do_early_param() always returns 0.
+	 */
+	xbc_node_for_each_key_value(root, knode, val) {
+		if (xbc_node_compose_key_after(root, knode, xbc_namebuf, XBC_KEYLEN_MAX) < 0)
+			continue;
+
+		/*
+		 * We need to copy const char *val to a char pointer,
+		 * which is what do_early_param() need, given it might
+		 * call strsep(), strtok() later.
+		 */
+		ret = strscpy(val_buf, val, sizeof(val_buf));
+		if (ret < 0) {
+			pr_warn("ignoring bootconfig value '%s', too long\n",
+				xbc_namebuf);
+			continue;
+		}
+		do_early_param(xbc_namebuf, val_buf, NULL, NULL);
+	}
+}
+
 static void __init setup_boot_config(void)
 {
 	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
+	bool using_embedded = false;
 	const char *msg, *data;
 	int pos, ret;
 	size_t size;
@@ -427,8 +482,17 @@ static void __init setup_boot_config(void)
 	/* Cut out the bootconfig data even if we have no bootconfig option */
 	data = get_boot_config_from_initrd(&size);
 	/* If there is no bootconfig in initrd, try embedded one. */
-	if (!data)
+	if (!data) {
 		data = xbc_get_embedded_bootconfig(&size);
+		/*
+		 * Record that we are using the embedded config so that
+		 * bootconfig_apply_early_params() is called below.
+		 * When CONFIG_BOOT_CONFIG_EMBED is not set,
+		 * xbc_get_embedded_bootconfig() is a stub returning NULL, so
+		 * data is always NULL here and using_embedded stays false.
+		 */
+		using_embedded = data;
+	}
 
 	strscpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
 	err = parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
@@ -466,6 +530,8 @@ static void __init setup_boot_config(void)
 	} else {
 		xbc_get_info(&ret, NULL);
 		pr_info("Load bootconfig: %ld bytes %d nodes\n", (long)size, ret);
+		if (using_embedded)
+			bootconfig_apply_early_params();
 		/* keys starting with "kernel." are passed via cmdline */
 		extra_command_line = xbc_make_cmdline("kernel");
 		/* Also, "init." keys are init arguments */

---
base-commit: 785f0eb2f85decbe7c1ef9ae922931f0194ffc2e
change-id: 20260323-early_bootconfig-2efc4509af3d

Best regards,
--  
Breno Leitao <leitao@debian.org>

