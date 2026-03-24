Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5283D366046;
	Tue, 24 Mar 2026 12:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774356781; cv=none; b=fpYU5evYOSG+m4B3j2bRxQwB2xJA/H0+QdTxnZmlK6na95pu6SCiD8izEHwbPLzrJLF4jZz9LcMUQVKqTkVVJQlbafR59Rwlu2BH31zJNJHUtkru7fhFufvSr9wHuLTFNkzUugSVS4H/erloe2ZW/8Ig3+S9yQV0MQdscHcT+q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774356781; c=relaxed/simple;
	bh=hMHfyhuZ/LGtkXe5f9H+RQyLAe34IsVFvYnBUUwvH/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gq4Bguam7HFvr3AXKprpcHC/DFfMv9sxs/HpXxmk9E7GL1yKIR4VSi4odWYhVJZu+4TvHQZyC79LrtlI0lrMOHrvyR+fhtBpQlitRwdpG587cyKQmM6xvP3Gn6yxfr6cJ+YbmFjdcj/tzbaHShA2K+n/AFr2mOyJAavw5jCsmgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=uuI5QZn+; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="uuI5QZn+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=9zFa1KDhUeszsD2HvlXQ2UZcTHj1u0HIeIKpOr+cxPA=; b=uuI5QZn+ZVYON10UqiuwtQyD5b
	3jtZ+qIgDUpU2FwQMLbahJaLxxKJCdkYjdSv5uNvW1WyKXD64LAUA2AtiU9Od4BVdzcX4xK5Eqe6j
	jKiGVhFCl8eGhXvLcGu6BaQMcEES/cId4A9YIz3Frt/HEldJcSg/m7zY0v/xHO1ShkZ8hs/S64ASd
	gSghAogCserrLTc/nlE4TDFwZ/tfrouOKZWOt3m+azX/tVO8+1xkrrY4XrJp54s/q5JRVAV7lLy8R
	FU+z41FneFwEXBkTgJEI5UUIuJVMHtz+p3XQE7ZnznkDZBsAsy8OklZi52uhSdea8sE5PzweswRNk
	yVb3j6KQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w51FX-008JWM-HL; Tue, 24 Mar 2026 12:52:46 +0000
From: Breno Leitao <leitao@debian.org>
Date: Tue, 24 Mar 2026 05:52:33 -0700
Subject: [PATCH] bootconfig: Apply early options from embedded config
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260324-early_bootconfig-v1-1-1c0e625aff06@debian.org>
X-B4-Tracking: v=1; b=H4sIABGJwmkC/yXM0QqCMBQG4Fc5/NcO1qZCe5WImPNMT8QWm0Uiv
 nuUl9/Nt6FyEa5wtKHwW6rkBEenhhBmnyZWMsIRjDa9tsYq9uWx3oacl5BTlEkZjqHt9NlHO6I
 hPAtH+fzLy/VwfQ13Dsvvwb5/ASuf4fF0AAAA
X-Change-ID: 20260323-early_bootconfig-2efc4509af3d
To: Masami Hiramatsu <mhiramat@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, oss@malat.biz, paulmck@kernel.org, 
 rostedt@goodmis.org, kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=6125; i=leitao@debian.org;
 h=from:subject:message-id; bh=hMHfyhuZ/LGtkXe5f9H+RQyLAe34IsVFvYnBUUwvH/A=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpwokZvln8UJbR7zTZLs/LUeiV/7t+/ew1EWlzA
 rq3Ve2JtSiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCacKJGQAKCRA1o5Of/Hh3
 bUjhD/9HHpayrdoIa6qp9nVuDWWIk3M0m5pKtFIZnxkuA+aaokFfTgdjh4Q1vITbIO2HL830k8J
 9uz0rojlKWqYIQ+ds1HPxo5NyE54QhzktVZMrYzpbxyaRNPXThwnizzDFvoe3I5tWeAEVFDrChM
 nqSa8YagihKm3hMUqCvIV0y5i6rpcUGdsGOtmFTXhsZmU62cNxqGxZdFk/Q0+vD6SDgrCSCVk0k
 97lNUVrQ422XkAunqtO8/7xGDoO3u6iKsPgCq2Pt4PtVkvtPmoVksZCbYznl66pIBDvE+UbdSE2
 7fP8joTyBH/kplhpbYHAoJz1gKoASbyVaOyXKlcWTiCCiUCwPTUmYop/kaSKDVwRXjejjnNTrKx
 rVyyQN3s5imKACjgv1H8FzyDVz+9VJvRwS8aqnb0NZjJCv+3Aa6qJE57a7djOczd3HZ1JejArM9
 T4xrSGELmgM7woqmtkhaoDcPX4zMo7OU+hyXQn/4l4aI9cQlwjlB85+4uO9ihtr9xpj9AN+O7Qj
 SLAzNtQFhzK5cdQvvjAdipVRYQh6qZF8ZlnyTU65upXCVcrqRNEgynoyr4jvif/TSjSYhksM3vX
 B+1WPbLE0tiBmoMokDXNLhuEHR9Hb8qFlOeMWlB9H23yf2y+ebxs5hE2ACY1Sww6debKs6Scz+3
 O5ZprEVvJRwfePw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Right not is impossible to set early parameters in bootconfig, which
limits the usage of bootconfig to some critical parameters.

Add bootconfig_apply_early_params() which walks all kernel.* keys in the
parsed XBC tree and calls do_early_param() for each one. It is called
from setup_boot_config() immediately after a successful xbc_init() on
the embedded data, which happens before parse_early_param() runs in
start_kernel().

This allows early options such as:

  kernel.mitigations = off
  kernel.irqchip.gicv3_pseudo_nmi = 1

to be placed in the embedded bootconfig and take effect, without
requiring them to be on the kernel command line.

Early options in initrd bootconfig are still silently ignored, as the
initrd is only available after the early param window has closed.

Document this behaviour in both Kconfig and the admin guide.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 Documentation/admin-guide/bootconfig.rst |  4 ++
 init/Kconfig                             |  6 +++
 init/main.c                              | 67 +++++++++++++++++++++++++++++++-
 3 files changed, 76 insertions(+), 1 deletion(-)

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
index 453ac9dff2da0..eba42b2351d47 100644
--- a/init/main.c
+++ b/init/main.c
@@ -416,9 +416,63 @@ static int __init warn_bootconfig(char *str)
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
+	char val_buf[COMMAND_LINE_SIZE];
+	struct xbc_node *knode, *root;
+	const char *val;
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
+		if (!val) {
+			do_early_param(xbc_namebuf, NULL, NULL, NULL);
+			continue;
+		}
+
+		/*
+		 * We need to copy const char *val to a char pointer,
+		 * which is what do_early_param() need, given it might
+		 * call strsep(), strtok() later.
+		 */
+		strscpy(val_buf, val, sizeof(val_buf));
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
@@ -427,8 +481,17 @@ static void __init setup_boot_config(void)
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
@@ -466,6 +529,8 @@ static void __init setup_boot_config(void)
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

