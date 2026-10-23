Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792738219;
	b=R8JB2q6HzvsQg8x6eoKpZqdKPfCb+OZ7cjx3n/ou9Vmw1TOGDAtHjU4J3Z2VEM6lrgzt
	 DxB3POpFG42UR4pQ7PShrsOJ1iJOjTzPzoE4FtDswwp7nOEW2FCbO0ju0EnyOCdehVnSq
	 8ImwYv0bUuqtYzsmUBVVhaZnaxRtSVEubzW01Fj1lOK3tRtgGroiz9FosSxTbZcKeqZC/
	 VnF3LJQr0gcGAiGYym2ozDfs6aIr1BuKxRE37LOnqHJ9D5DD3junbIyhZxyWaFUtar9eU
	 lDVWngJuOapGIiqD1Wpf7GJVVCinAxNGz9fk14bNQgDpTUfwzFj8MAUBr7KvRTs//4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792738219;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=IJtGzgfWqoSEgO1BTldpOla097U3Cjbi2x4nl/UVvkE=;
	b=bdl78Q/nFdRWJ/+1MYVf7EQ46qJycK4scHEiRLj2DT9OcxNtYjcjkRFX+JNr1bVDB8AI
	 lmG/3OyfZmVdfSbl28FOHEiiUiz1KPT8/C3HDKAdd+6OSt3ZbQtJUj//K3c81wki8P8AV
	 J+DOU6q/tRX0Hp+hDzQ6PyXEtMfKLtQyzJNtGJC+Y5BWhavlLxBJd/abR99t+PDc+tbcT
	 eLp3T2ECGnKydnXZOAdXxEY15Fa3ID2lC4sAwH+NdKY9vCM2zTj8DJEd/ztsV3Mmt6kPb
	 s/qz9EAEkmDABoaOsdQTm/4KFN+MgHO9G7iXqkvqxw4HgnHkW1xqM2e56Gd3X9LU5JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jCyF73as;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460D0606A322
	for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Oct 2026 06:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 460D0606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jCyF73as
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792738217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IJtGzgfWqoSEgO1BTldpOla097U3Cjbi2x4nl/UVvkE=;
	b=jCyF73asT+hK0bNzWd13BMfFKUB4X22fEmTNTnX/U3cW+Po2S2Tm6jKdMb06aWPSdOtNk1
	EoUlPhFe8x9zcVGeOJLdf323Pq+wEtSvUx2+sri91p6EFs/ti0bsQRP/Y3Zc3/IkC5q5Lz
	mTxxmq0B+QuyG8RHCy9A8GSNAYY/ftE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-D3jZG0TXM3m9vthW8TrvNg-1; Fri,
 23 Oct 2026 02:49:57 -0400
X-MC-Unique: D3jZG0TXM3m9vthW8TrvNg-1
X-Mimecast-MFC-AGG-ID: D3jZG0TXM3m9vthW8TrvNg_1792738195
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 275BA1955D9C;
	Fri, 23 Oct 2026 06:49:54 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.42])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 57D851956095;
	Fri, 23 Oct 2026 06:49:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>
Cc: soc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Mark Rutland <mark.rutland@arm.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v5 06/13] arm: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
Date: Fri, 23 Oct 2026 08:48:43 +0200
Message-ID: <20261023064908.66707-7-thuth@redhat.com>
In-Reply-To: <20261023064908.66707-1-thuth@redhat.com>
References: <20261023064908.66707-1-thuth@redhat.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: Tq3YIbstKGax774GLRhfaDQLF-xcHPMGZmKA3GCC3KY_1792738195
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

While the GCC and Clang compilers already define __ASSEMBLER__
automatically when compiling assembly code, __ASSEMBLY__ is a
macro that only gets defined by the Makefiles in the kernel.
This can be very confusing when switching between userspace
and kernelspace coding, or when dealing with uapi headers that
rather should use __ASSEMBLER__ instead. So let's standardize now
on the __ASSEMBLER__ macro that is provided by the compilers.

This is a completely mechanical patch (done with a simple "sed -i"
statement).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/arm/include/asm/assembler.h                 |  2 +-
 arch/arm/include/asm/barrier.h                   |  4 ++--
 arch/arm/include/asm/cache.h                     |  2 +-
 arch/arm/include/asm/cp15.h                      |  4 ++--
 arch/arm/include/asm/cputype.h                   |  4 ++--
 arch/arm/include/asm/current.h                   |  4 ++--
 arch/arm/include/asm/delay.h                     |  4 ++--
 arch/arm/include/asm/domain.h                    |  8 ++++----
 arch/arm/include/asm/fpstate.h                   |  2 +-
 arch/arm/include/asm/ftrace.h                    |  6 +++---
 arch/arm/include/asm/hardware/cache-l2x0.h       |  4 ++--
 arch/arm/include/asm/hardware/dec21285.h         |  2 +-
 arch/arm/include/asm/hardware/ioc.h              |  2 +-
 arch/arm/include/asm/hardware/iomd.h             |  4 ++--
 arch/arm/include/asm/hardware/memc.h             |  2 +-
 arch/arm/include/asm/hwcap.h                     |  2 +-
 arch/arm/include/asm/irq.h                       |  2 +-
 arch/arm/include/asm/kexec.h                     |  4 ++--
 arch/arm/include/asm/kgdb.h                      |  4 ++--
 arch/arm/include/asm/linkage.h                   |  4 ++--
 arch/arm/include/asm/mach/arch.h                 |  2 +-
 arch/arm/include/asm/mcpm.h                      |  4 ++--
 arch/arm/include/asm/memory.h                    |  4 ++--
 arch/arm/include/asm/mpu.h                       |  4 ++--
 arch/arm/include/asm/opcodes.h                   | 12 ++++++------
 arch/arm/include/asm/page.h                      |  4 ++--
 arch/arm/include/asm/pgtable-2level.h            |  4 ++--
 arch/arm/include/asm/pgtable-3level.h            |  4 ++--
 arch/arm/include/asm/pgtable-nommu.h             |  4 ++--
 arch/arm/include/asm/pgtable.h                   |  8 ++++----
 arch/arm/include/asm/probes.h                    |  4 ++--
 arch/arm/include/asm/proc-fns.h                  |  4 ++--
 arch/arm/include/asm/ptrace.h                    |  4 ++--
 arch/arm/include/asm/system_info.h               |  4 ++--
 arch/arm/include/asm/system_misc.h               |  4 ++--
 arch/arm/include/asm/thread_info.h               |  2 +-
 arch/arm/include/asm/thread_notify.h             |  2 +-
 arch/arm/include/asm/tlbflush.h                  | 10 +++++-----
 arch/arm/include/asm/tls.h                       |  4 ++--
 arch/arm/include/asm/unified.h                   |  6 +++---
 arch/arm/include/asm/unwind.h                    |  4 ++--
 arch/arm/include/asm/v7m.h                       |  4 ++--
 arch/arm/include/asm/vdso.h                      |  4 ++--
 arch/arm/include/asm/vdso/cp15.h                 |  4 ++--
 arch/arm/include/asm/vdso/gettimeofday.h         |  4 ++--
 arch/arm/include/asm/vdso/processor.h            |  4 ++--
 arch/arm/include/asm/vfp.h                       |  2 +-
 arch/arm/include/asm/virt.h                      |  4 ++--
 arch/arm/mach-footbridge/include/mach/hardware.h |  2 +-
 arch/arm/mach-sa1100/include/mach/bitfield.h     |  2 +-
 arch/arm/mach-sa1100/include/mach/hardware.h     |  2 +-
 arch/arm/tools/gen-mach-types                    |  2 +-
 52 files changed, 101 insertions(+), 101 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index d33c1e24e00b3..0f1f3b907825e 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -13,7 +13,7 @@
 #ifndef __ASM_ASSEMBLER_H__
 #define __ASM_ASSEMBLER_H__
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #error "Only include this from assembly code"
 #endif
 
diff --git a/arch/arm/include/asm/barrier.h b/arch/arm/include/asm/barrier.h
index 83ae97c049d9b..af3516cfa8dcd 100644
--- a/arch/arm/include/asm/barrier.h
+++ b/arch/arm/include/asm/barrier.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_BARRIER_H
 #define __ASM_BARRIER_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define nop() __asm__ __volatile__("mov\tr0,r0\t@ nop\n\t");
 
@@ -99,5 +99,5 @@ static inline unsigned long array_index_mask_nospec(unsigned long idx,
 
 #include <asm-generic/barrier.h>
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 #endif /* __ASM_BARRIER_H */
diff --git a/arch/arm/include/asm/cache.h b/arch/arm/include/asm/cache.h
index ecbc100d22a56..38a38a53badc9 100644
--- a/arch/arm/include/asm/cache.h
+++ b/arch/arm/include/asm/cache.h
@@ -26,7 +26,7 @@
 
 #define __read_mostly __section(".data..read_mostly")
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #ifdef CONFIG_ARCH_HAS_CACHE_LINE_SIZE
 int cache_line_size(void);
 #endif
diff --git a/arch/arm/include/asm/cp15.h b/arch/arm/include/asm/cp15.h
index a54230e656479..603a33c4bf572 100644
--- a/arch/arm/include/asm/cp15.h
+++ b/arch/arm/include/asm/cp15.h
@@ -40,7 +40,7 @@
 #define CR_AFE	(1 << 29)	/* Access flag enable			*/
 #define CR_TE	(1 << 30)	/* Thumb exception enable		*/
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #if __LINUX_ARM_ARCH__ >= 4
 #define vectors_high()	(get_cr() & CR_V)
@@ -117,6 +117,6 @@ static inline unsigned long get_cr(void)
 
 #endif /* ifdef CONFIG_CPU_CP15 / else */
 
-#endif /* ifndef __ASSEMBLY__ */
+#endif /* ifndef __ASSEMBLER__ */
 
 #endif
diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index 0163c3e78a67f..4b2832e14c3e1 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -109,7 +109,7 @@
 /* Qualcomm implemented cores */
 #define ARM_CPU_PART_SCORPION		0x510002d0
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/stringify.h>
 #include <linux/kernel.h>
@@ -343,6 +343,6 @@ static inline int __attribute_const__ cpuid_feature_extract_field(u32 features,
 #define cpuid_feature_extract(reg, field) \
 	cpuid_feature_extract_field(read_cpuid_ext(reg), field)
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif
diff --git a/arch/arm/include/asm/current.h b/arch/arm/include/asm/current.h
index 5225cb1c803b1..12968d3cdc269 100644
--- a/arch/arm/include/asm/current.h
+++ b/arch/arm/include/asm/current.h
@@ -7,7 +7,7 @@
 #ifndef _ASM_ARM_CURRENT_H
 #define _ASM_ARM_CURRENT_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <asm/insn.h>
 
 struct task_struct;
@@ -60,6 +60,6 @@ static __always_inline __attribute_const__ struct task_struct *get_current(void)
 
 #define current get_current()
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_ARM_CURRENT_H */
diff --git a/arch/arm/include/asm/delay.h b/arch/arm/include/asm/delay.h
index d2231deb90fa5..43200c56b5eea 100644
--- a/arch/arm/include/asm/delay.h
+++ b/arch/arm/include/asm/delay.h
@@ -41,7 +41,7 @@
 #define UDELAY_MULT	UL(2147 * HZ + 483648 * HZ / 1000000)
 #define UDELAY_SHIFT	31
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct delay_timer {
 	unsigned long (*read_current_timer)(void);
@@ -93,7 +93,7 @@ extern void __loop_const_udelay(unsigned long);
 /* Delay-loop timer registration. */
 extern void register_current_timer_delay(const struct delay_timer *timer);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* defined(_ARM_DELAY_H) */
 
diff --git a/arch/arm/include/asm/domain.h b/arch/arm/include/asm/domain.h
index f91c2a72b9dc6..35c53e2542df4 100644
--- a/arch/arm/include/asm/domain.h
+++ b/arch/arm/include/asm/domain.h
@@ -7,7 +7,7 @@
 #ifndef __ASM_PROC_DOMAIN_H
 #define __ASM_PROC_DOMAIN_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/thread_info.h>
 #include <asm/barrier.h>
 #endif
@@ -62,7 +62,7 @@
 #define DACR_UACCESS_ENABLE	\
 	(__DACR_DEFAULT | domain_val(DOMAIN_USER, DOMAIN_CLIENT))
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifdef CONFIG_CPU_CP15_MMU
 static __always_inline unsigned int get_domain(void)
@@ -107,7 +107,7 @@ static __always_inline void set_domain(unsigned int val)
 #define TUSERCOND(instr, cond)	#instr #cond
 #endif
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 
 /*
  * Generate the T (user) versions of the LDR/STR and related
@@ -119,6 +119,6 @@ static __always_inline void set_domain(unsigned int val)
 #define TUSER(instr)	instr
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* !__ASM_PROC_DOMAIN_H */
diff --git a/arch/arm/include/asm/fpstate.h b/arch/arm/include/asm/fpstate.h
index e29d9c7a52388..2b4469e151851 100644
--- a/arch/arm/include/asm/fpstate.h
+++ b/arch/arm/include/asm/fpstate.h
@@ -9,7 +9,7 @@
 #define __ASM_ARM_FPSTATE_H
 
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * VFP storage area has:
diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
index 5be3ddc96a503..9675ede04f09c 100644
--- a/arch/arm/include/asm/ftrace.h
+++ b/arch/arm/include/asm/ftrace.h
@@ -12,7 +12,7 @@
 #define MCOUNT_ADDR		((unsigned long)(__gnu_mcount_nc))
 #define MCOUNT_INSN_SIZE	4 /* sizeof mcount call */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern void __gnu_mcount_nc(void);
 
 #ifdef CONFIG_DYNAMIC_FTRACE
@@ -33,7 +33,7 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #if defined(CONFIG_FRAME_POINTER) && !defined(CONFIG_ARM_UNWIND)
 /*
@@ -79,6 +79,6 @@ void prepare_ftrace_return(unsigned long *parent, unsigned long self,
 			   unsigned long frame_pointer,
 			   unsigned long stack_pointer);
 
-#endif /* ifndef __ASSEMBLY__ */
+#endif /* ifndef __ASSEMBLER__ */
 
 #endif /* _ASM_ARM_FTRACE */
diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
index 5a7ee70f561c9..2c9568768ad73 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -147,7 +147,7 @@
 
 #define L2X0_WAY_SIZE_SHIFT		3
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern void __init l2x0_init(void __iomem *base, u32 aux_val, u32 aux_mask);
 #if defined(CONFIG_CACHE_L2X0) && defined(CONFIG_OF)
 extern int l2x0_of_init(u32 aux_val, u32 aux_mask);
@@ -187,6 +187,6 @@ struct l2x0_regs {
 
 extern struct l2x0_regs l2x0_saved_regs;
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif
diff --git a/arch/arm/include/asm/hardware/dec21285.h b/arch/arm/include/asm/hardware/dec21285.h
index 894f2a635cbbd..bf722733bbb6f 100644
--- a/arch/arm/include/asm/hardware/dec21285.h
+++ b/arch/arm/include/asm/hardware/dec21285.h
@@ -15,7 +15,7 @@
 #define DC21285_PCI_IO			0x7c000000
 #define DC21285_PCI_MEM			0x80000000
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <mach/hardware.h>
 #define DC21285_IO(x)		((volatile unsigned long *)(ARMCSR_BASE+(x)))
 #else
diff --git a/arch/arm/include/asm/hardware/ioc.h b/arch/arm/include/asm/hardware/ioc.h
index 6edd27fcd0483..bd4f66591026b 100644
--- a/arch/arm/include/asm/hardware/ioc.h
+++ b/arch/arm/include/asm/hardware/ioc.h
@@ -10,7 +10,7 @@
 #ifndef __ASMARM_HARDWARE_IOC_H
 #define __ASMARM_HARDWARE_IOC_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * We use __raw_base variants here so that we give the compiler the
diff --git a/arch/arm/include/asm/hardware/iomd.h b/arch/arm/include/asm/hardware/iomd.h
index 53006ba5350f0..9b8a289f4db63 100644
--- a/arch/arm/include/asm/hardware/iomd.h
+++ b/arch/arm/include/asm/hardware/iomd.h
@@ -11,7 +11,7 @@
 #define __ASMARM_HARDWARE_IOMD_H
 
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * We use __raw_base variants here so that we give the compiler the
@@ -167,7 +167,7 @@
 #define VDMA_START	IOMD_VIDSTART
 #define VDMA_END	IOMD_VIDEND
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern unsigned int vram_half_sam;
 #define video_set_dma(start,end,offset)				\
 do {								\
diff --git a/arch/arm/include/asm/hardware/memc.h b/arch/arm/include/asm/hardware/memc.h
index 1d4ebe0a9678f..8b1865cb564ec 100644
--- a/arch/arm/include/asm/hardware/memc.h
+++ b/arch/arm/include/asm/hardware/memc.h
@@ -10,7 +10,7 @@
 #define VDMA_START	1
 #define VDMA_END	2
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern void memc_write(unsigned int reg, unsigned long val);
 
 #define video_set_dma(start,end,offset)				\
diff --git a/arch/arm/include/asm/hwcap.h b/arch/arm/include/asm/hwcap.h
index e31d9f1b8549b..d5b5ebaad011b 100644
--- a/arch/arm/include/asm/hwcap.h
+++ b/arch/arm/include/asm/hwcap.h
@@ -4,7 +4,7 @@
 
 #include <uapi/asm/hwcap.h>
 
-#if !defined(__ASSEMBLY__)
+#if !defined(__ASSEMBLER__)
 /*
  * This yields a mask that user programs can use to figure out what
  * instruction set this cpu supports.
diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
index 26c1d2ced4ce1..7c8f826071162 100644
--- a/arch/arm/include/asm/irq.h
+++ b/arch/arm/include/asm/irq.h
@@ -22,7 +22,7 @@
 #define NO_IRQ	((unsigned int)(-1))
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 struct irqaction;
 struct pt_regs;
 
diff --git a/arch/arm/include/asm/kexec.h b/arch/arm/include/asm/kexec.h
index a8287e7ab9d41..8488f4b611402 100644
--- a/arch/arm/include/asm/kexec.h
+++ b/arch/arm/include/asm/kexec.h
@@ -16,7 +16,7 @@
 #define KEXEC_ARM_ATAGS_OFFSET  0x1000
 #define KEXEC_ARM_ZIMAGE_OFFSET 0x8000
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define ARCH_HAS_KIMAGE_ARCH
 struct kimage_arch {
@@ -78,6 +78,6 @@ static inline struct page *boot_pfn_to_page(unsigned long boot_pfn)
 }
 #define boot_pfn_to_page boot_pfn_to_page
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ARM_KEXEC_H */
diff --git a/arch/arm/include/asm/kgdb.h b/arch/arm/include/asm/kgdb.h
index 8de1100d10674..1b7c65935976f 100644
--- a/arch/arm/include/asm/kgdb.h
+++ b/arch/arm/include/asm/kgdb.h
@@ -39,7 +39,7 @@
 #define KGDB_COMPILED_BREAK	0xe7ffdeff
 #define CACHE_FLUSH_IS_SAFE	1
 
-#ifndef	__ASSEMBLY__
+#ifndef	__ASSEMBLER__
 
 static inline void arch_kgdb_breakpoint(void)
 {
@@ -49,7 +49,7 @@ static inline void arch_kgdb_breakpoint(void)
 extern void kgdb_handle_bus_error(void);
 extern int kgdb_fault_expected;
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 /*
  * From Kevin Hilman:
diff --git a/arch/arm/include/asm/linkage.h b/arch/arm/include/asm/linkage.h
index bba992f5d7a80..7be126af3b102 100644
--- a/arch/arm/include/asm/linkage.h
+++ b/arch/arm/include/asm/linkage.h
@@ -9,7 +9,7 @@
   .type name, %function; \
   END(name)
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 /*
  * Variants of SYM_TYPED_START/SYM_TYPED_FUNC_START that align the
@@ -36,6 +36,6 @@
 #define SYM_TYPED_FUNC_START_ALIGNED(name, align)	\
 	SYM_TYPED_START_ALIGNED(name, SYM_L_GLOBAL, align)
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif
diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 2b18a258204d7..ce0137aee0845 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -7,7 +7,7 @@
 
 #include <linux/types.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/reboot.h>
 
 struct tag;
diff --git a/arch/arm/include/asm/mcpm.h b/arch/arm/include/asm/mcpm.h
index 755c97de348c3..743f68f89337e 100644
--- a/arch/arm/include/asm/mcpm.h
+++ b/arch/arm/include/asm/mcpm.h
@@ -24,7 +24,7 @@
 #define MAX_NR_CLUSTERS		2
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/types.h>
 #include <asm/cacheflush.h>
@@ -307,7 +307,7 @@ struct sync_struct {
 #include <asm/asm-offsets.h>
 #define __CACHE_WRITEBACK_GRANULE CACHE_WRITEBACK_GRANULE
 
-#endif /* ! __ASSEMBLY__ */
+#endif /* ! __ASSEMBLER__ */
 
 /* Definitions for mcpm_sync_struct */
 #define CPU_DOWN		0x11
diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index e25749bfbf90b..e11b4241ce178 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -98,7 +98,7 @@
 
 #else /* CONFIG_MMU */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern unsigned long setup_vectors_base(void);
 extern unsigned long vectors_base;
 #define VECTORS_BASE		vectors_base
@@ -155,7 +155,7 @@ extern unsigned long vectors_base;
  */
 #define PLAT_PHYS_OFFSET	UL(CONFIG_PHYS_OFFSET)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * Physical start and end address of the kernel sections. These addresses are
diff --git a/arch/arm/include/asm/mpu.h b/arch/arm/include/asm/mpu.h
index 5e088c83d3d8e..6058788a85730 100644
--- a/arch/arm/include/asm/mpu.h
+++ b/arch/arm/include/asm/mpu.h
@@ -91,7 +91,7 @@
 #define PMSAv7_DATA_SIDE	0
 #define PMSAv7_INSTR_SIDE	1
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct mpu_rgn {
 	/* Assume same attributes for d/i-side  */
@@ -128,6 +128,6 @@ static inline void pmsav7_setup(void) {};
 static inline void pmsav8_setup(void) {};
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif
diff --git a/arch/arm/include/asm/opcodes.h b/arch/arm/include/asm/opcodes.h
index 38e3eabff5c3f..c2e3ed5157cf3 100644
--- a/arch/arm/include/asm/opcodes.h
+++ b/arch/arm/include/asm/opcodes.h
@@ -6,7 +6,7 @@
 #ifndef __ASM_ARM_OPCODES_H
 #define __ASM_ARM_OPCODES_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/linkage.h>
 extern asmlinkage unsigned int arm_check_condition(u32 opcode, u32 psr);
 #endif
@@ -71,7 +71,7 @@ extern asmlinkage unsigned int arm_check_condition(u32 opcode, u32 psr);
  * involving inline assembler.  For .S files, the normal __opcode_*() macros
  * should do the right thing.
  */
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 
 #define ___opcode_swab32(x) ___asm_opcode_swab32(x)
 #define ___opcode_swab16(x) ___asm_opcode_swab16(x)
@@ -80,7 +80,7 @@ extern asmlinkage unsigned int arm_check_condition(u32 opcode, u32 psr);
 #define ___opcode_identity32(x) ___asm_opcode_identity32(x)
 #define ___opcode_identity16(x) ___asm_opcode_identity16(x)
 
-#else /* ! __ASSEMBLY__ */
+#else /* ! __ASSEMBLER__ */
 
 #include <linux/types.h>
 #include <linux/swab.h>
@@ -92,7 +92,7 @@ extern asmlinkage unsigned int arm_check_condition(u32 opcode, u32 psr);
 #define ___opcode_identity32(x) ((u32)(x))
 #define ___opcode_identity16(x) ((u16)(x))
 
-#endif /* ! __ASSEMBLY__ */
+#endif /* ! __ASSEMBLER__ */
 
 
 #ifdef CONFIG_CPU_ENDIAN_BE8
@@ -111,7 +111,7 @@ extern asmlinkage unsigned int arm_check_condition(u32 opcode, u32 psr);
 #define ___asm_opcode_to_mem_arm(x) ___asm_opcode_identity32(x)
 #define ___asm_opcode_to_mem_thumb16(x) ___asm_opcode_identity16(x)
 #ifdef CONFIG_CPU_ENDIAN_BE32
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /*
  * On BE32 systems, using 32-bit accesses to store Thumb instructions will not
  * work in all cases, due to alignment constraints.  For now, a correct
@@ -219,7 +219,7 @@ extern __u32 __opcode_to_mem_thumb32(__u32);
 #endif
 
 /* Helpers for the helpers.  Don't use these directly. */
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #define ___inst_arm(x) .long x
 #define ___inst_thumb16(x) .short x
 #define ___inst_thumb32(first, second) .short first, second
diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
index fa4c1225dde57..be24b6ba62869 100644
--- a/arch/arm/include/asm/page.h
+++ b/arch/arm/include/asm/page.h
@@ -9,7 +9,7 @@
 
 #include <vdso/page.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifndef CONFIG_MMU
 
@@ -180,7 +180,7 @@ extern int pfn_valid(unsigned long);
 #define pfn_valid pfn_valid
 #endif
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #include <asm/memory.h>
 
diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index 7e1c08fdd0294..17d8e982689ec 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -168,7 +168,7 @@
 #define L_PTE_MT_VECTORS	(_AT(pteval_t, 0x0f) << 2)	/* 1111 */
 #define L_PTE_MT_MASK		(_AT(pteval_t, 0x0f) << 2)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * The "pud_xxx()" functions here are trivial when the pmd is folded into
@@ -235,6 +235,6 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
  */
 #define pmd_hugewillfault(pmd)	(0)
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_PGTABLE_2LEVEL_H */
diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index 7b71a3d414b72..5b17ebef203ea 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -109,7 +109,7 @@
  */
 #define L_PGD_SWAPPER		(_AT(pgdval_t, 1) << 55)	/* swapper_pg_dir entry */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define pud_none(pud)		(!pud_val(pud))
 #define pud_bad(pud)		(!(pud_val(pud) & PUD_TABLE_BIT))
@@ -245,6 +245,6 @@ static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 	flush_pmd_entry(pmdp);
 }
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_PGTABLE_3LEVEL_H */
diff --git a/arch/arm/include/asm/pgtable-nommu.h b/arch/arm/include/asm/pgtable-nommu.h
index 61480d096054d..a8bca82198381 100644
--- a/arch/arm/include/asm/pgtable-nommu.h
+++ b/arch/arm/include/asm/pgtable-nommu.h
@@ -8,7 +8,7 @@
 #ifndef _ASMARM_PGTABLE_NOMMU_H
 #define _ASMARM_PGTABLE_NOMMU_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/slab.h>
 #include <asm/processor.h>
@@ -84,6 +84,6 @@ extern unsigned int kobjsize(const void *objp);
 #define v6_user_fns	(0)
 #define xscale_mc_user_fns (0)
 
-#endif /*__ASSEMBLY__*/
+#endif /*__ASSEMBLER__*/
 
 #endif /* _ASMARM_PGTABLE_H */
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 982795cf45637..fe96852f0e739 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -43,7 +43,7 @@
 
 #define LIBRARY_TEXT_START	0x0c000000
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern void __pte_error(const char *file, int line, pte_t);
 extern void __pmd_error(const char *file, int line, pmd_t);
 extern void __pgd_error(const char *file, int line, pgd_t);
@@ -126,7 +126,7 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 	__pgprot_modify(prot, L_PTE_MT_MASK, L_PTE_MT_UNCACHED | L_PTE_XN)
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /*
  * The table below defines the page protection levels that we insert into our
@@ -137,7 +137,7 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
  *  3) write implies read permissions
  */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 
@@ -320,7 +320,7 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
 #define HAVE_ARCH_UNMAPPED_AREA
 #define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* CONFIG_MMU */
 
diff --git a/arch/arm/include/asm/probes.h b/arch/arm/include/asm/probes.h
index ebbd9ec95d21c..0d5067e7f51a9 100644
--- a/arch/arm/include/asm/probes.h
+++ b/arch/arm/include/asm/probes.h
@@ -11,7 +11,7 @@
 #ifndef _ASM_PROBES_H
 #define _ASM_PROBES_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 typedef u32 probes_opcode_t;
 
@@ -37,7 +37,7 @@ struct arch_probes_insn {
 	bool				kprobe_direct_exec;
 };
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /*
  * We assume one instruction can consume at most 64 bytes stack, which is
diff --git a/arch/arm/include/asm/proc-fns.h b/arch/arm/include/asm/proc-fns.h
index b4986a23d8528..fd72f5fac6602 100644
--- a/arch/arm/include/asm/proc-fns.h
+++ b/arch/arm/include/asm/proc-fns.h
@@ -13,7 +13,7 @@
 #include <asm/glue-proc.h>
 #include <asm/page.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct mm_struct;
 
@@ -196,6 +196,6 @@ static inline void cpu_set_ttbcr(unsigned int ttbcr)
 
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* __KERNEL__ */
 #endif /* __ASM_PROCFNS_H */
diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
index 6eb311fb2da06..de3378a8845ec 100644
--- a/arch/arm/include/asm/ptrace.h
+++ b/arch/arm/include/asm/ptrace.h
@@ -9,7 +9,7 @@
 
 #include <uapi/asm/ptrace.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/bitfield.h>
 #include <linux/types.h>
 
@@ -198,5 +198,5 @@ static inline unsigned long it_advance(unsigned long cpsr)
 int syscall_trace_enter(struct pt_regs *regs);
 void syscall_trace_exit(struct pt_regs *regs);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif
diff --git a/arch/arm/include/asm/system_info.h b/arch/arm/include/asm/system_info.h
index ef7fdb588b5fe..3a872ec5d4e2e 100644
--- a/arch/arm/include/asm/system_info.h
+++ b/arch/arm/include/asm/system_info.h
@@ -14,7 +14,7 @@
 #define CPU_ARCH_ARMv7		9
 #define CPU_ARCH_ARMv7M		10
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /* information about the system we're running on */
 extern unsigned int system_rev;
@@ -25,6 +25,6 @@ extern unsigned int mem_fclk_21285;
 
 extern int __pure cpu_architecture(void);
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* __ASM_ARM_SYSTEM_INFO_H */
diff --git a/arch/arm/include/asm/system_misc.h b/arch/arm/include/asm/system_misc.h
index 98b37340376bc..8f9f7e833c013 100644
--- a/arch/arm/include/asm/system_misc.h
+++ b/arch/arm/include/asm/system_misc.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_ARM_SYSTEM_MISC_H
 #define __ASM_ARM_SYSTEM_MISC_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/compiler.h>
 #include <linux/linkage.h>
@@ -37,6 +37,6 @@ static inline void harden_branch_predictor(void)
 
 extern unsigned int user_debug;
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* __ASM_ARM_SYSTEM_MISC_H */
diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 943ffcf069d29..186fd662b1c62 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -33,7 +33,7 @@
 
 #define OVERFLOW_STACK_SIZE	SZ_4K
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct task_struct;
 
diff --git a/arch/arm/include/asm/thread_notify.h b/arch/arm/include/asm/thread_notify.h
index 1c1542e2ed634..eac8fc4837651 100644
--- a/arch/arm/include/asm/thread_notify.h
+++ b/arch/arm/include/asm/thread_notify.h
@@ -9,7 +9,7 @@
 
 #ifdef __KERNEL__
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/notifier.h>
 #include <asm/thread_info.h>
diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index 38c6e4a2a0b60..3eb0b3fa6cc9c 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -7,7 +7,7 @@
 #ifndef _ASMARM_TLBFLUSH_H
 #define _ASMARM_TLBFLUSH_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 # include <linux/mm_types.h>
 #endif
 
@@ -200,7 +200,7 @@
 #error Unknown TLB model
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/sched.h>
 
@@ -641,7 +641,7 @@ static inline void update_mmu_cache_range(struct vm_fault *vmf,
 
 #elif defined(CONFIG_SMP)	/* !CONFIG_MMU */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 static inline void local_flush_tlb_all(void)									{ }
 static inline void local_flush_tlb_mm(struct mm_struct *mm)							{ }
 static inline void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)			{ }
@@ -657,11 +657,11 @@ extern void flush_tlb_kernel_page(unsigned long kaddr);
 extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long start, unsigned long end);
 extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
 extern void flush_bp_all(void);
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #ifdef CONFIG_ARM_ERRATA_798181
 extern void erratum_a15_798181_init(void);
 #else
diff --git a/arch/arm/include/asm/tls.h b/arch/arm/include/asm/tls.h
index 3dcd0f71a0dae..9b09775e20931 100644
--- a/arch/arm/include/asm/tls.h
+++ b/arch/arm/include/asm/tls.h
@@ -5,7 +5,7 @@
 #include <linux/compiler.h>
 #include <asm/thread_info.h>
 
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #include <asm/asm-offsets.h>
 	.macro switch_tls_none, base, tp, tpuser, tmp1, tmp2
 	.endm
@@ -68,7 +68,7 @@ ALT_UP_B(.L0_\@)
 #define switch_tls	switch_tls_software
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 static inline void set_tls(unsigned long val)
 {
diff --git a/arch/arm/include/asm/unified.h b/arch/arm/include/asm/unified.h
index ce9689118dbb9..2cdeafb6afb63 100644
--- a/arch/arm/include/asm/unified.h
+++ b/arch/arm/include/asm/unified.h
@@ -8,7 +8,7 @@
 #ifndef __ASM_UNIFIED_H
 #define __ASM_UNIFIED_H
 
-#if defined(__ASSEMBLY__)
+#if defined(__ASSEMBLER__)
 	.syntax unified
 #else
 __asm__(".syntax unified");
@@ -29,7 +29,7 @@ __asm__(".syntax unified");
 
 #define ARM(x...)
 #define THUMB(x...)	x
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #define W(instr)	instr.w
 #else
 #define WASM(instr)	#instr ".w"
@@ -42,7 +42,7 @@ __asm__(".syntax unified");
 
 #define ARM(x...)	x
 #define THUMB(x...)
-#ifdef __ASSEMBLY__
+#ifdef __ASSEMBLER__
 #define W(instr)	instr
 #else
 #define WASM(instr)	#instr
diff --git a/arch/arm/include/asm/unwind.h b/arch/arm/include/asm/unwind.h
index d60b09a5acfc3..071c89b1b4099 100644
--- a/arch/arm/include/asm/unwind.h
+++ b/arch/arm/include/asm/unwind.h
@@ -8,7 +8,7 @@
 #ifndef __ASM_UNWIND_H
 #define __ASM_UNWIND_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /* Unwind reason code according the the ARM EABI documents */
 enum unwind_reason_code {
@@ -44,7 +44,7 @@ void __aeabi_unwind_cpp_pr0(void);
 void __aeabi_unwind_cpp_pr1(void);
 void __aeabi_unwind_cpp_pr2(void);
 
-#endif	/* !__ASSEMBLY__ */
+#endif	/* !__ASSEMBLER__ */
 
 #ifdef CONFIG_ARM_UNWIND
 #define UNWIND(code...)		code
diff --git a/arch/arm/include/asm/v7m.h b/arch/arm/include/asm/v7m.h
index 4512f7e1918f0..b334f8009a505 100644
--- a/arch/arm/include/asm/v7m.h
+++ b/arch/arm/include/asm/v7m.h
@@ -89,10 +89,10 @@
 #define	V7M_SCB_DCCISW		0x274	/* D-cache clean and invalidate by set-way */
 #define	V7M_SCB_BPIALL		0x278	/* D-cache clean and invalidate by set-way */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 enum reboot_mode;
 
 void armv7m_restart(enum reboot_mode mode, const char *cmd);
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
diff --git a/arch/arm/include/asm/vdso.h b/arch/arm/include/asm/vdso.h
index 88364a6727ffc..93a7338cd3057 100644
--- a/arch/arm/include/asm/vdso.h
+++ b/arch/arm/include/asm/vdso.h
@@ -6,7 +6,7 @@
 
 #define __VDSO_PAGES	4
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 struct mm_struct;
 
@@ -26,7 +26,7 @@ static inline void arm_install_vdso(struct mm_struct *mm, unsigned long addr)
 
 #endif /* CONFIG_VDSO */
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* __KERNEL__ */
 
diff --git a/arch/arm/include/asm/vdso/cp15.h b/arch/arm/include/asm/vdso/cp15.h
index bed16fa1865e9..f5dea30743765 100644
--- a/arch/arm/include/asm/vdso/cp15.h
+++ b/arch/arm/include/asm/vdso/cp15.h
@@ -5,7 +5,7 @@
 #ifndef __ASM_VDSO_CP15_H
 #define __ASM_VDSO_CP15_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifdef CONFIG_CPU_CP15
 
@@ -33,6 +33,6 @@
 
 #endif /* CONFIG_CPU_CP15 */
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* __ASM_VDSO_CP15_H */
diff --git a/arch/arm/include/asm/vdso/gettimeofday.h b/arch/arm/include/asm/vdso/gettimeofday.h
index 26da5d8621cc9..c8e461a37bde9 100644
--- a/arch/arm/include/asm/vdso/gettimeofday.h
+++ b/arch/arm/include/asm/vdso/gettimeofday.h
@@ -5,7 +5,7 @@
 #ifndef __ASM_VDSO_GETTIMEOFDAY_H
 #define __ASM_VDSO_GETTIMEOFDAY_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm/barrier.h>
 #include <asm/errno.h>
@@ -137,6 +137,6 @@ static __always_inline u64 __arch_get_hw_counter(int clock_mode,
 #endif
 }
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/arm/include/asm/vdso/processor.h b/arch/arm/include/asm/vdso/processor.h
index 45efb3ff511c9..b24304f248b71 100644
--- a/arch/arm/include/asm/vdso/processor.h
+++ b/arch/arm/include/asm/vdso/processor.h
@@ -5,7 +5,7 @@
 #ifndef __ASM_VDSO_PROCESSOR_H
 #define __ASM_VDSO_PROCESSOR_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #if __LINUX_ARM_ARCH__ == 6 || defined(CONFIG_ARM_ERRATA_754327)
 #define cpu_relax()						\
@@ -17,6 +17,6 @@
 #define cpu_relax()			barrier()
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* __ASM_VDSO_PROCESSOR_H */
diff --git a/arch/arm/include/asm/vfp.h b/arch/arm/include/asm/vfp.h
index 85ccc422d4d0b..94171e09bda0b 100644
--- a/arch/arm/include/asm/vfp.h
+++ b/arch/arm/include/asm/vfp.h
@@ -90,7 +90,7 @@
 #define VFPOPDESC_UNUSED_MASK	(0xFF << VFPOPDESC_UNUSED_BIT)
 #define VFPOPDESC_OPDESC_MASK	(~(VFPOPDESC_LENGTH_MASK | VFPOPDESC_UNUSED_MASK))
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 void vfp_disable(void);
 #endif
 
diff --git a/arch/arm/include/asm/virt.h b/arch/arm/include/asm/virt.h
index dd9697b2bde80..719a08fa6a29b 100644
--- a/arch/arm/include/asm/virt.h
+++ b/arch/arm/include/asm/virt.h
@@ -15,7 +15,7 @@
  */
 #define BOOT_CPU_MODE_MISMATCH	PSR_N_BIT
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <asm/cacheflush.h>
 
 #ifdef CONFIG_ARM_VIRT_EXT
@@ -74,7 +74,7 @@ static inline bool is_kernel_in_hyp_mode(void)
 #define HVC_SET_VECTORS 0
 #define HVC_SOFT_RESTART 1
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #define HVC_STUB_ERR	0xbadca11
 
diff --git a/arch/arm/mach-footbridge/include/mach/hardware.h b/arch/arm/mach-footbridge/include/mach/hardware.h
index 985ad3a956712..5391848d8c8cc 100644
--- a/arch/arm/mach-footbridge/include/mach/hardware.h
+++ b/arch/arm/mach-footbridge/include/mach/hardware.h
@@ -79,7 +79,7 @@
 #define CPLD_UNMUTE		2
 #define CPLD_FLASH_WR_ENABLE	1
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern raw_spinlock_t nw_gpio_lock;
 extern void nw_gpio_modify_op(unsigned int mask, unsigned int set);
 extern void nw_gpio_modify_io(unsigned int mask, unsigned int in);
diff --git a/arch/arm/mach-sa1100/include/mach/bitfield.h b/arch/arm/mach-sa1100/include/mach/bitfield.h
index f1f0e3387d9c6..e786bf730b31c 100644
--- a/arch/arm/mach-sa1100/include/mach/bitfield.h
+++ b/arch/arm/mach-sa1100/include/mach/bitfield.h
@@ -15,7 +15,7 @@
 #ifndef __BITFIELD_H
 #define __BITFIELD_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #define UData(Data)	((unsigned long) (Data))
 #else
 #define UData(Data)	(Data)
diff --git a/arch/arm/mach-sa1100/include/mach/hardware.h b/arch/arm/mach-sa1100/include/mach/hardware.h
index 6f2dbdc286632..350e2665ca495 100644
--- a/arch/arm/mach-sa1100/include/mach/hardware.h
+++ b/arch/arm/mach-sa1100/include/mach/hardware.h
@@ -39,7 +39,7 @@
 
 #define __MREG(x)	IOMEM(io_p2v(x))
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 # define __REG(x)	(*((volatile unsigned long __iomem *)io_p2v(x)))
 # define __PREG(x)	(io_v2p((unsigned long)&(x)))
diff --git a/arch/arm/tools/gen-mach-types b/arch/arm/tools/gen-mach-types
index cbe1c33bb8710..6ad8f055ba6b5 100644
--- a/arch/arm/tools/gen-mach-types
+++ b/arch/arm/tools/gen-mach-types
@@ -29,7 +29,7 @@ END	{
 	  printf(" */\n\n");
 	  printf("#ifndef __ASM_ARM_MACH_TYPE_H\n");
 	  printf("#define __ASM_ARM_MACH_TYPE_H\n\n");
-	  printf("#ifndef __ASSEMBLY__\n");
+	  printf("#ifndef __ASSEMBLER__\n");
 	  printf("/* The type of machine we're running on */\n");
 	  printf("extern unsigned int __machine_arch_type;\n");
 	  printf("#endif\n\n");
-- 
2.56.0

