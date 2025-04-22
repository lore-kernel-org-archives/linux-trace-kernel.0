Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9AE296179;
	Tue, 22 Apr 2025 18:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745346931; cv=none; b=vBtVksNV7+qou2mov1X5H8G1IdMlK7OtkLJRstmgp+ZrHUwnXe9YbYo7Yw04HyipwX4+R5e5+hcsbxyR0bUYD0iOOT/QvZSPK/9+Vx21TLheZ2RUjdcGHjPsg3/HO3/ASX7eFUU77cm2jw7o7csdDx4wwYvqQMjrjxPdl2GN60k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745346931; c=relaxed/simple;
	bh=qJMQ/YdxbpuMLffInkxJPnf55MoP0hvxW+wRtlvozRk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=mgGTnsu6o20tAhr9bous8m8aMxWNa4QvTeqUYllRYmypqBlpdYv9eVLGxt4byqqttj01PZNWzkUiN3UzcsjA8XU3Hil+O7xb8M4rYe5vNLXxTWV724l+12VpgwuGM/k6MWurbK76HOR8mbAstdpagcTNBDD6W7bh1176rznUR2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8570BC4CEEB;
	Tue, 22 Apr 2025 18:35:31 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1u7IUl-0000000Fw9r-0G3p;
	Tue, 22 Apr 2025 14:37:23 -0400
Message-ID: <20250422183722.919601983@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 22 Apr 2025 14:34:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Jens Remus <jremus@linux.ibm.com>,
 x86@kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Indu Bhagat <indu.bhagat@oracle.com>,
 Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v5 6/6] x86/vdso: Enable sframe generation in VDSO
References: <20250422183439.895236512@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Josh Poimboeuf <jpoimboe@kernel.org>

Enable sframe generation in the VDSO library so kernel and user space
can unwind through it.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v4: https://lore.kernel.org/all/c93fbd53f01c2c86f747af27040ac11f16dee032.1737511963.git.jpoimboe@kernel.org/

- Changed #ifdef to include SFRAME config:
  #if defined(__x86_64__) && defined(CONFIG_AS_SFRAME)
  (Jens Remus)

- Fixed Makefile to use "ifeq" and not "#ifdef"
  (Jens Remus)

 arch/Kconfig                          |  3 +++
 arch/x86/entry/vdso/Makefile          | 10 +++++++---
 arch/x86/entry/vdso/vdso-layout.lds.S |  3 +++
 arch/x86/include/asm/dwarf2.h         |  5 ++++-
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index b0adb665041f..6e7d739e853b 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -435,6 +435,9 @@ config HAVE_HARDLOCKUP_DETECTOR_ARCH
 	  It uses the same command line parameters, and sysctl interface,
 	  as the generic hardlockup detectors.
 
+config AS_SFRAME
+	def_bool $(as-instr,.cfi_sections .sframe\n.cfi_startproc\n.cfi_endproc)
+
 config HAVE_PERF_REGS
 	bool
 	help
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 54d3e9774d62..3bab770337b3 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -47,13 +47,17 @@ quiet_cmd_vdso2c = VDSO2C  $@
 $(obj)/vdso-image-%.c: $(obj)/vdso%.so.dbg $(obj)/vdso%.so $(obj)/vdso2c FORCE
 	$(call if_changed,vdso2c)
 
+ifeq ($(CONFIG_AS_SFRAME),y)
+  SFRAME_CFLAGS := -Wa$(comma)-gsframe
+endif
+
 #
 # Don't omit frame pointers for ease of userspace debugging, but do
 # optimize sibling calls.
 #
 CFL := $(PROFILING) -mcmodel=small -fPIC -O2 -fasynchronous-unwind-tables -m64 \
        $(filter -g%,$(KBUILD_CFLAGS)) -fno-stack-protector \
-       -fno-omit-frame-pointer -foptimize-sibling-calls \
+       -fno-omit-frame-pointer $(SFRAME_CFLAGS) -foptimize-sibling-calls \
        -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
 
 ifdef CONFIG_MITIGATION_RETPOLINE
@@ -63,7 +67,7 @@ endif
 endif
 
 $(vobjs): KBUILD_CFLAGS := $(filter-out $(PADDING_CFLAGS) $(CC_FLAGS_LTO) $(CC_FLAGS_CFI) $(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
-$(vobjs): KBUILD_AFLAGS += -DBUILD_VDSO
+$(vobjs): KBUILD_AFLAGS += -DBUILD_VDSO $(SFRAME_CFLAGS)
 
 #
 # vDSO code runs in userspace and -pg doesn't help with profiling anyway.
@@ -104,7 +108,7 @@ $(obj)/%-x32.o: $(obj)/%.o FORCE
 
 targets += vdsox32.lds $(vobjx32s-y)
 
-$(obj)/%.so: OBJCOPYFLAGS := -S --remove-section __ex_table
+$(obj)/%.so: OBJCOPYFLAGS := -g --remove-section __ex_table
 $(obj)/%.so: $(obj)/%.so.dbg FORCE
 	$(call if_changed,objcopy)
 
diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso-layout.lds.S
index 60747905de2b..24b92687597b 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -59,6 +59,7 @@ SECTIONS
 	.eh_frame_hdr	: { *(.eh_frame_hdr) }		:text	:eh_frame_hdr
 	.eh_frame	: { KEEP (*(.eh_frame)) }	:text
 
+	.sframe		: { *(.sframe) }		:text	:sframe
 
 	/*
 	 * Text is well-separated from actual data: there's plenty of
@@ -87,6 +88,7 @@ SECTIONS
  * Very old versions of ld do not recognize this name token; use the constant.
  */
 #define PT_GNU_EH_FRAME	0x6474e550
+#define PT_GNU_SFRAME	0x6474e554
 
 /*
  * We must supply the ELF program headers explicitly to get just one
@@ -98,4 +100,5 @@ PHDRS
 	dynamic		PT_DYNAMIC	FLAGS(4);		/* PF_R */
 	note		PT_NOTE		FLAGS(4);		/* PF_R */
 	eh_frame_hdr	PT_GNU_EH_FRAME;
+	sframe		PT_GNU_SFRAME;
 }
diff --git a/arch/x86/include/asm/dwarf2.h b/arch/x86/include/asm/dwarf2.h
index 65d958ef1178..ce294e6c9017 100644
--- a/arch/x86/include/asm/dwarf2.h
+++ b/arch/x86/include/asm/dwarf2.h
@@ -12,8 +12,11 @@
 	 * For the vDSO, emit both runtime unwind information and debug
 	 * symbols for the .dbg file.
 	 */
-
+#if defined(__x86_64__) && defined(CONFIG_AS_SFRAME)
+	.cfi_sections .eh_frame, .debug_frame, .sframe
+#else
 	.cfi_sections .eh_frame, .debug_frame
+#endif
 
 #define CFI_STARTPROC		.cfi_startproc
 #define CFI_ENDPROC		.cfi_endproc
-- 
2.47.2


