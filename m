Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970EB333727;
	Mon, 30 Mar 2026 15:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774883080; cv=none; b=kS3WwUrDKcxMchWI4NutLQA6Da8Kar6SC9NIidjrsdNoKtPsHrBwfIzj7bdVQ50PJEiYjJ59cfZIRdaesIp0YQHYqYj3GE7PcoSGIxgWLe730LX3JXiYi5/GfYgUTZ3t8h0aCFxb3/fFn/PyPLcDDqz+Cd/uRZ0F+appFFaucUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774883080; c=relaxed/simple;
	bh=utft/jT/5Uf3Y/3tYz29MuMXqk4gH6p2izBHP9AMsco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7+dC432EvIGYsBeN9pLtNB/bKgLMFQmNe81WK3ZvI9WlnAhDKc9PFplcjzdJQvLZJ2kgjxcMCp4Qwen0PutUlWHCPt96vEMpkFSDmMCPHRPFCFsw9T5I9szA5JHzzkaa79eeUj18AQ5d07beCfi9b1hBKMfkTpQqMAnHaKTQ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=o17xX1bM; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="o17xX1bM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=S1m4QJOLmIukrx77lO00CBi/Eg4ZklDsW9se5USx8x4=; b=o17xX1bM9hFTETAc1WZeFy2SUX
	7w3RW2s0+ailEEtm7RO2Fp9egxP93WyGTId+bta6u50MVmZQm/VX0TnuftxWVnbkRyHeOyz9UkQ59
	2sYmOBd4J0xFUT5RI1Xy6GMVwmsHsgnMqULYbBIQ69rb2dtL3D6+hIhFx+PjS62zC3waF/Vt7oYMM
	yc30CwZiH+plou52jv6hHgmCyyWppsHMngZL7ibn97i3fB5Dn7CP+Cm+rX4So48cim9zkS1vYgf0Q
	rgBl3i7XakgrqlbIzQ19CVMC0EpSxQ1TO7jNOdU1TBoJMmd/sGD6sLbeIM8qv8gXdx/k/l6k+tQJH
	32QVKTQg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1w7EAH-001Wqv-32;
	Mon, 30 Mar 2026 15:04:28 +0000
Date: Mon, 30 Mar 2026 08:04:23 -0700
From: Breno Leitao <leitao@debian.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, oss@malat.biz, paulmck@kernel.org, rostedt@goodmis.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v2] bootconfig: Apply early options from embedded config
Message-ID: <acqJk-zbyjIiy6hJ@gmail.com>
References: <20260325-early_bootconfig-v2-1-6b05a36fbfb5@debian.org>
 <20260325232204.05edbb21c7602b6408ca007b@kernel.org>
 <acZPZ4XKy4QynznK@gmail.com>
 <20260327223744.f246150adc1671f7605a4f0a@kernel.org>
 <acpzhCBEPh-tKVqg@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acpzhCBEPh-tKVqg@gmail.com>
X-Debian-User: leitao

On Mon, Mar 30, 2026 at 06:15:17AM -0700, Breno Leitao wrote:
> On Fri, Mar 27, 2026 at 10:37:44PM +0900, Masami Hiramatsu wrote:
> > On Fri, 27 Mar 2026 03:06:41 -0700
> > Breno Leitao <leitao@debian.org> wrote:
>
> > > > To fix this, we need to change setup_arch() for each architecture so
> > > > that it calls this bootconfig_apply_early_params().
> > >
> > > Could we instead integrate this into parse_early_param() itself? That
> > > approach would avoid the need to modify each architecture individually.
> >
> > Ah, indeed.
>
> I investigated integrating bootconfig into parse_early_param() and hit a
> blocker: xbc_init() and xbc_make_cmdline() depend on memblock_alloc(), but on
> most architectures (x86, arm64, arm, s390, riscv) parse_early_param() is called
> from setup_arch() _before_ memblock is initialized.

That said, I'd like to propose a simpler approach as a first step:

1) Keep calling bootconfig_apply_early_params() from setup_boot_config().
   This is the least intrusive approach and expands bootconfig support to
   additional early boot parameters.

2) Document that architecture-specific early parameters might be ignored.
   If a parameter is consumed early enough (during setup_arch()), it will
   not see the bootconfig value.

3) Ensure that early bootconfig parameters don't overwrite the boot command
   line. For example, if the boot command line has foo=bar and bootconfig
   later has foo=baz, the command line value should take precedence.
   This prevents early boot code (in setup_arch()) from seeing a parameter
   value that will be changed later.


If that is OK, that is what I have right now:

commit dd6e00e41c381e5fef9d22dda02b104aa8f83101
Author: Breno Leitao <leitao@debian.org>
Date:   Mon Mar 30 06:50:28 2026 -0700

    bootconfig: Apply early options from embedded config
    
    Bootconfig currently cannot apply early kernel parameters. For example,
    the "mitigations=" parameter must be passed through traditional boot
    methods because bootconfig parsing happens after these early parameters
    need to be processed.
    
    Add bootconfig_apply_early_params() which walks all kernel.* keys in the
    parsed XBC tree and calls do_early_param() for each one. It is called
    from setup_boot_config() immediately after a successful xbc_init() on
    the embedded data, which happens before parse_early_param() runs in
    start_kernel().
    
    This allows early options such as:
    
      kernel.mitigations = off
    
    to be placed in the embedded bootconfig and take effect, without
    requiring them on the kernel command line.
    
    If the same parameter appears on both the kernel command line and in
    the embedded bootconfig, the command-line value takes precedence:
    bootconfig_apply_early_params() checks boot_command_line and skips
    any parameter already present there.
    
    Known limitations are documented:
    - Early options in initrd bootconfig are still silently ignored, as the
      initrd is only available after the early param window has closed.
    - Arch-specific early params consumed during setup_arch() (e.g. mem=,
      earlycon, noapic) may not take effect from bootconfig.
    
    Signed-off-by: Breno Leitao <leitao@debian.org>

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index f712758472d5c..6ed852a0c66d8 100644
--- a/Documentation/admin-guide/bootconfig.rst
+++ b/Documentation/admin-guide/bootconfig.rst
@@ -169,6 +169,15 @@ Boot Kernel With a Boot Config
 There are two options to boot the kernel with bootconfig: attaching the
 bootconfig to the initrd image or embedding it in the kernel itself.
 
+Early options (those registered with ``early_param()``) may only be
+specified in the embedded bootconfig, because the initrd is not yet
+available when early parameters are processed.
+
+Note that embedded bootconfig is parsed after ``setup_arch()``, so
+early options that are consumed during architecture initialization
+(e.g., ``mem=``, ``memmap=``, ``earlycon``, ``noapic``, ``nolapic``,
+``acpi=``, ``numa=``, ``iommu=``) may not take effect from bootconfig.
+
 Attaching a Boot Config to Initrd
 ---------------------------------
 
diff --git a/init/Kconfig b/init/Kconfig
index 7484cd703bc1a..34adcc1feb9b6 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1525,6 +1525,16 @@ config BOOT_CONFIG_EMBED
 	  image. But if the system doesn't support initrd, this option will
 	  help you by embedding a bootconfig file while building the kernel.
 
+	  Unlike bootconfig attached to initrd, the embedded bootconfig also
+	  supports early options (those registered with early_param()). Any
+	  kernel.* key in the embedded bootconfig is applied before
+	  parse_early_param() runs.  Early options in initrd bootconfig will
+	  not be applied.  Early options consumed during setup_arch() (e.g.
+	  mem=, memmap=, earlycon, noapic, acpi=, numa=, iommu=) may not
+	  take effect.  If the same early option
+	  appears in both bootconfig and the kernel command line, the
+	  command line value takes precedence.
+
 	  If unsure, say N.
 
 config BOOT_CONFIG_EMBED_FILE
diff --git a/init/main.c b/init/main.c
index 1cb395dd94e43..487fe86ab5c09 100644
--- a/init/main.c
+++ b/init/main.c
@@ -414,10 +414,112 @@ static int __init warn_bootconfig(char *str)
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
+ * Check if a parameter name appears on the kernel command line.
+ * Returns true if the parameter was explicitly passed by the bootloader.
+ */
+static bool __init cmdline_has_param(const char *param)
+{
+	const char *p = boot_command_line;
+	int len = strlen(param);
+
+	while ((p = strstr(p, param)) != NULL) {
+		/* Check it's a whole-word match: preceded by space/start */
+		if (p != boot_command_line && *(p - 1) != ' ') {
+			p += len;
+			continue;
+		}
+		/* Followed by =, space, or end of string */
+		if (p[len] == '=' || p[len] == ' ' || p[len] == '\0')
+			return true;
+		p += len;
+	}
+	return false;
+}
+
+/*
+ * bootconfig_apply_early_params - apply kernel.* keys from the embedded
+ * bootconfig as early_param() calls.
+ *
+ * early_param() handlers run before most of the kernel initialises.
+ * A bootconfig attached to initrd arrives too late because the initrd is
+ * not mapped when early params are processed.  The embedded bootconfig
+ * lives in the kernel image itself (.init.data), so it is always
+ * reachable.
+ *
+ * Called from setup_boot_config() which runs before parse_early_param()
+ * in start_kernel(), but after setup_arch().  Arch-specific early params
+ * parsed during setup_arch() will not see bootconfig values.
+ */
+static void __init bootconfig_apply_early_params(void)
+{
+	struct xbc_node *knode, *vnode, *root;
+	const char *val;
+	char *val_copy;
+
+	root = xbc_find_node("kernel");
+	if (!root)
+		return;
+
+	xbc_node_for_each_key_value(root, knode, val) {
+		if (xbc_node_compose_key_after(root, knode,
+					       xbc_namebuf,
+					       XBC_KEYLEN_MAX) < 0)
+			continue;
+
+		/* Command-line values take precedence over bootconfig */
+		if (cmdline_has_param(xbc_namebuf)) {
+			pr_info("bootconfig: skipping '%s', already on command line\n",
+				xbc_namebuf);
+			continue;
+		}
+
+		/* Boolean key with no value — pass NULL like parse_args() */
+		if (!xbc_node_get_child(knode)) {
+			do_early_param(xbc_namebuf, NULL, NULL, NULL);
+			continue;
+		}
+
+		/*
+		 * Iterate array values: "foo = bar, buz" becomes two
+		 * calls: do_early_param("foo", "bar") and
+		 * do_early_param("foo", "buz").
+		 */
+		vnode = xbc_node_get_child(knode);
+		xbc_array_for_each_value(vnode, val) {
+			/*
+			 * Some early_param handlers save the pointer to
+			 * val, so each value needs its own persistent
+			 * copy.  memblock is available here since we run
+			 * after setup_arch().  These allocations are
+			 * intentionally never freed because the handlers
+			 * may retain references indefinitely.
+			 */
+			val_copy = memblock_alloc(strlen(val) + 1,
+						  SMP_CACHE_BYTES);
+			if (!val_copy) {
+				pr_err("Failed to allocate bootconfig value for '%s'\n",
+				       xbc_namebuf);
+				continue;
+			}
+			strcpy(val_copy, val);
+			do_early_param(xbc_namebuf, val_copy, NULL, NULL);
+		}
+	}
+}
+
 static void __init setup_boot_config(void)
 {
 	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
 	const char *msg, *data;
+	bool embedded = false;
 	int pos, ret;
 	size_t size;
 	char *err;
@@ -425,8 +527,11 @@ static void __init setup_boot_config(void)
 	/* Cut out the bootconfig data even if we have no bootconfig option */
 	data = get_boot_config_from_initrd(&size);
 	/* If there is no bootconfig in initrd, try embedded one. */
-	if (!data)
+	if (!data) {
 		data = xbc_get_embedded_bootconfig(&size);
+		/* tag we have embedded data */
+		embedded = !!data;
+	}
 
 	strscpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
 	err = parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
@@ -464,6 +569,8 @@ static void __init setup_boot_config(void)
 	} else {
 		xbc_get_info(&ret, NULL);
 		pr_info("Load bootconfig: %ld bytes %d nodes\n", (long)size, ret);
+		if (embedded)
+			bootconfig_apply_early_params();
 		/* keys starting with "kernel." are passed via cmdline */
 		extra_command_line = xbc_make_cmdline("kernel");
 		/* Also, "init." keys are init arguments */
