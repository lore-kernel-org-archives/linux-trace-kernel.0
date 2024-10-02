Received: from forwardcorp1d.mail.yandex.net (forwardcorp1d.mail.yandex.net [178.154.239.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8B01D0E19;
	Wed,  2 Oct 2024 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727885341; cv=none; b=RFUpVY1pM7i6B87ZxTW3BUj+TZAoEHe978iE+ngY5BQykNmlJFkaSSNDmoZBeWDJvtJHEnww+olJFjLZxMcmXwwTzTHy/BW3dVLDC6s4FY0zph2VXlTGBEu//aO8dD+3M/ggpgObYCjf6SUZnwN94g7v4jMi2O6an0+zWQQbv1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727885341; c=relaxed/simple;
	bh=jdoey+uksmyfcJ5iDcu5tqp2xlukBo0sMMs91TZYJco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qnkQyoXOp1Z2ij+ZDRcu1wodLclEeb0BDTVUciP0O6TKP+gHSK/Tfj1RlI3ek/RwEJCdsvOIaM75v4kS8Tlhws3WYmetMiSQIenwJmmxRptu4bGL7wG/AkBYiXmjte20uhody7/1Fmnf5DwUovynoisHbX4syRHYEZu0jpU0jD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.com; spf=pass smtp.mailfrom=yandex-team.com; dkim=pass (1024-bit key) header.d=yandex-team.com header.i=@yandex-team.com header.b=rISzUCre; arc=none smtp.client-ip=178.154.239.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.com header.i=@yandex-team.com header.b="rISzUCre"
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:b1cb:0:640:2a1e:0])
	by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id C8E5760A6D;
	Wed,  2 Oct 2024 19:08:55 +0300 (MSK)
Received: from dellarbn.yandex.net (unknown [10.214.35.248])
	by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id Z8emWD2IhiE0-NNW0FOgv;
	Wed, 02 Oct 2024 19:08:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
	s=default; t=1727885334;
	bh=FEwZkDU2VcUSP99EqMYuNuirJIt2aNspqQO+oi3JBZ0=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=rISzUCreiYPr5KO7sSHN36OWn/OE/1SW6J4qWdFjSKXFl/OmP3/AsvrO93oc/rfO3
	 E5TEW/kK1jsj+bzA3aigLi1L2TRjEmagB2KlDbxL85Ej/R71PObcT7q7wfbME/qBX8
	 269sah/PVLakog1l83ZOSHYhyBL6jgF+dNfxMlRE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net; dkim=pass header.i=@yandex-team.com
From: Andrey Ryabinin <arbn@yandex-team.com>
To: linux-kernel@vger.kernel.org
Cc: Alexander Graf <graf@amazon.com>,
	James Gowans <jgowans@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Eric Biederman <ebiederm@xmission.com>,
	kexec@lists.infradead.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	valesini@yandex-team.com,
	Andrey Ryabinin <arbn@yandex-team.com>
Subject: [RFC PATCH 2/7] kexec: Hack and abuse crashkernel for the kstate's migration stream
Date: Wed,  2 Oct 2024 18:07:17 +0200
Message-ID: <20241002160722.20025-3-arbn@yandex-team.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241002160722.20025-1-arbn@yandex-team.com>
References: <20241002160722.20025-1-arbn@yandex-team.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Yandex-Filter: 1

This is an early ugly hack just for now. Will be completely redone later.
This abuses crashkernel segment of memory for the kstate purposes to
save and restore object descriptions.

The proper solution probably would be using segments in ordinary kexec
mechanism, however since kstate requires such segments very late
(at reboot stage, not the load stage) some thought and work will be
required to make that happen. The KEXEC_FILE_MIGRATE/KEXEC_TYPE_MIGRATE flags
also likely won't be required.

Signed-off-by: Andrey Ryabinin <arbn@yandex-team.com>
---
 arch/x86/kernel/kexec-bzimage64.c  | 36 ++++++++++++++++++++++++++++++
 arch/x86/kernel/machine_kexec_64.c |  5 ++++-
 include/linux/kexec.h              |  6 +++--
 include/uapi/linux/kexec.h         |  2 ++
 kernel/crash_core.c                |  3 ++-
 kernel/kexec_core.c                | 10 ++++++++-
 kernel/kexec_file.c                | 15 +++++++++++--
 7 files changed, 70 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 68530fad05f74..71c82841e6b12 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -18,6 +18,7 @@
 #include <linux/mm.h>
 #include <linux/efi.h>
 #include <linux/random.h>
+#include <linux/vmalloc.h>
 
 #include <asm/bootparam.h>
 #include <asm/setup.h>
@@ -77,6 +78,11 @@ static int setup_cmdline(struct kimage *image, struct boot_params *params,
 		len = sprintf(cmdline_ptr,
 			"elfcorehdr=0x%lx ", image->elf_load_addr);
 	}
+	if (image->type == KEXEC_TYPE_MIGRATE) {
+		len = sprintf(cmdline_ptr,
+			"migrate_stream=0x0%llx ", crashk_res.start);
+	}
+
 	memcpy(cmdline_ptr + len, cmdline, cmdline_len);
 	cmdline_len += len;
 
@@ -389,6 +395,29 @@ static int bzImage64_probe(const char *buf, unsigned long len)
 	return ret;
 }
 
+static int load_migrate_segments(struct kimage *image)
+{
+	int ret;
+	struct kexec_buf kbuf = { .image = image, .buf_min = 0,
+				  .buf_max = ULONG_MAX, .top_down = false };
+
+	kbuf.bufsz = 4096;
+	kbuf.buffer = vzalloc(kbuf.bufsz);
+
+	kbuf.memsz = 8*1024*1024;
+
+	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
+	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
+	ret = kexec_add_buffer(&kbuf);
+	if (ret)
+		return ret;
+	image->mig_stream = kbuf.mem;
+	kexec_dprintk("kstate: Loaded mig_stream at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
+		      image->mig_stream, kbuf.bufsz, kbuf.memsz);
+
+	return ret;
+}
+
 static void *bzImage64_load(struct kimage *image, char *kernel,
 			    unsigned long kernel_len, char *initrd,
 			    unsigned long initrd_len, char *cmdline,
@@ -444,6 +473,13 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 	}
 #endif
 
+	if (image->type == KEXEC_TYPE_MIGRATE) {
+		ret = load_migrate_segments(image);
+		if (ret)
+			return ERR_PTR(ret);
+
+	}
+
 	/*
 	 * Load purgatory. For 64bit entry point, purgatory  code can be
 	 * anywhere.
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 9c9ac606893e9..edf6234b75baf 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -572,7 +572,10 @@ static void kexec_mark_crashkres(bool protect)
 	kexec_mark_range(crashk_low_res.start, crashk_low_res.end, protect);
 
 	/* Don't touch the control code page used in crash_kexec().*/
-	control = PFN_PHYS(page_to_pfn(kexec_crash_image->control_code_page));
+	if (kexec_image && kexec_image->type & KEXEC_TYPE_MIGRATE)
+		control = PFN_PHYS(page_to_pfn(kexec_image->control_code_page));
+	else if (kexec_crash_image)
+		control = PFN_PHYS(page_to_pfn(kexec_crash_image->control_code_page));
 	/* Control code page is located in the 2nd page. */
 	kexec_mark_range(crashk_res.start, control + PAGE_SIZE - 1, protect);
 	control += KEXEC_CONTROL_PAGE_SIZE;
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index f0e9f8eda7a3c..182ef76f21860 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -299,6 +299,7 @@ struct kimage {
 	unsigned long start;
 	struct page *control_code_page;
 	struct page *swap_page;
+	unsigned long mig_stream;
 	void *vmcoreinfo_data_copy; /* locates in the crash memory */
 
 	unsigned long nr_segments;
@@ -312,9 +313,10 @@ struct kimage {
 	unsigned long control_page;
 
 	/* Flags to indicate special processing */
-	unsigned int type : 1;
+	unsigned int type : 2;
 #define KEXEC_TYPE_DEFAULT 0
 #define KEXEC_TYPE_CRASH   1
+#define KEXEC_TYPE_MIGRATE 2
 	unsigned int preserve_context : 1;
 	/* If set, we are using file mode kexec syscall */
 	unsigned int file_mode:1;
@@ -401,7 +403,7 @@ bool kexec_load_permitted(int kexec_image_type);
 
 /* List of defined/legal kexec file flags */
 #define KEXEC_FILE_FLAGS	(KEXEC_FILE_UNLOAD | KEXEC_FILE_ON_CRASH | \
-				 KEXEC_FILE_NO_INITRAMFS | KEXEC_FILE_DEBUG)
+				 KEXEC_FILE_NO_INITRAMFS | KEXEC_FILE_DEBUG | KEXEC_FILE_MIGRATE)
 
 /* flag to track if kexec reboot is in progress */
 extern bool kexec_in_progress;
diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
index 5ae1741ea8ea0..454dc7c8a7d86 100644
--- a/include/uapi/linux/kexec.h
+++ b/include/uapi/linux/kexec.h
@@ -27,6 +27,8 @@
 #define KEXEC_FILE_ON_CRASH	0x00000002
 #define KEXEC_FILE_NO_INITRAMFS	0x00000004
 #define KEXEC_FILE_DEBUG	0x00000008
+#define KEXEC_FILE_MIGRATE	0X00000010
+
 
 /* These values match the ELF architecture values.
  * Unless there is a good reason that should continue to be the case.
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index c1048893f4b68..87b9a52d60352 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -42,7 +42,8 @@ int kimage_crash_copy_vmcoreinfo(struct kimage *image)
 
 	if (!IS_ENABLED(CONFIG_CRASH_DUMP))
 		return 0;
-	if (image->type != KEXEC_TYPE_CRASH)
+	if (image->type != KEXEC_TYPE_CRASH &&
+	    image->type != KEXEC_TYPE_MIGRATE)
 		return 0;
 
 	/*
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index c0caa14880c3b..ca6283d21235e 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/fs.h>
 #include <linux/kexec.h>
+#include <linux/kstate.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/highmem.h>
@@ -196,7 +197,8 @@ int sanity_check_segment_list(struct kimage *image)
 	 * kernel could corrupt things.
 	 */
 
-	if (image->type == KEXEC_TYPE_CRASH) {
+	if (image->type == KEXEC_TYPE_CRASH ||
+	    image->type == KEXEC_TYPE_MIGRATE) {
 		for (i = 0; i < nr_segments; i++) {
 			unsigned long mstart, mend;
 
@@ -461,6 +463,7 @@ struct page *kimage_alloc_control_pages(struct kimage *image,
 		break;
 #ifdef CONFIG_CRASH_DUMP
 	case KEXEC_TYPE_CRASH:
+	case KEXEC_TYPE_MIGRATE:
 		pages = kimage_alloc_crash_control_pages(image, order);
 		break;
 #endif
@@ -859,6 +862,7 @@ int kimage_load_segment(struct kimage *image,
 		break;
 #ifdef CONFIG_CRASH_DUMP
 	case KEXEC_TYPE_CRASH:
+	case KEXEC_TYPE_MIGRATE:
 		result = kimage_load_crash_segment(image, segment);
 		break;
 #endif
@@ -1044,9 +1048,13 @@ int kernel_kexec(void)
 		 */
 		cpu_hotplug_enable();
 		pr_notice("Starting new kernel\n");
+		arch_kexec_unprotect_crashkres();
 		machine_shutdown();
 	}
 
+	if (kexec_image->type & KEXEC_TYPE_MIGRATE)
+		save_migrate_state(kexec_image->mig_stream);
+
 	kmsg_dump(KMSG_DUMP_SHUTDOWN);
 	machine_kexec(kexec_image);
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 3eedb8c226ad8..4a576db4141cd 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -293,6 +293,11 @@ kimage_file_alloc_init(struct kimage **rimage, int kernel_fd,
 	}
 #endif
 
+	if (flags & KEXEC_FILE_MIGRATE) {
+		image->control_page = crashk_res.start;
+		image->type = KEXEC_TYPE_MIGRATE;
+	}
+
 	ret = kimage_file_prepare_segments(image, kernel_fd, initrd_fd,
 					   cmdline_ptr, cmdline_len, flags);
 	if (ret)
@@ -360,6 +365,10 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 #endif
 		dest_image = &kexec_image;
 
+	if (image_type == KEXEC_TYPE_MIGRATE)
+		if (*dest_image)
+			arch_kexec_unprotect_crashkres();
+
 	if (flags & KEXEC_FILE_UNLOAD)
 		goto exchange;
 
@@ -428,7 +437,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	image = xchg(dest_image, image);
 out:
 #ifdef CONFIG_CRASH_DUMP
-	if ((flags & KEXEC_FILE_ON_CRASH) && kexec_crash_image)
+	if (((flags & KEXEC_FILE_ON_CRASH) && kexec_crash_image) ||
+	    ((flags & KEXEC_FILE_MIGRATE) && kexec_image))
 		arch_kexec_protect_crashkres();
 #endif
 
@@ -608,7 +618,8 @@ static int kexec_walk_resources(struct kexec_buf *kbuf,
 				int (*func)(struct resource *, void *))
 {
 #ifdef CONFIG_CRASH_DUMP
-	if (kbuf->image->type == KEXEC_TYPE_CRASH)
+	if (kbuf->image->type == KEXEC_TYPE_CRASH ||
+	    kbuf->image->type == KEXEC_TYPE_MIGRATE)
 		return walk_iomem_res_desc(crashk_res.desc,
 					   IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
 					   crashk_res.start, crashk_res.end,
-- 
2.45.2

