Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3001A49DBB6
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 15:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790262949; cv=none; b=mymP5/KXVWt0//6BOO3VO5N7lP1CG+hJc/2ekNOmOL8f8tkQh2nX9v7Xwrf6PcJAS/Z82APWV1r+OsJotf8NUl2sdMkL4rkTic0gjtOe5u3iFw3SSV6am50LqrlSFuq7U6MPFH3MVLXn5B4KUgF+cnVdYgjSrSy+Xx1sBUgH3D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790262949; c=relaxed/simple;
	bh=EKGu/YNz/Y7Su/Py1AF/c0JjS1K1+FhCsnHRcD6212k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JZfgt3K9/DlCJQ1axSSLYeu8/mn9ZihxIL+NjuLFvqw7CD5fWGTR8OO64lzelu35Pc+ZIq0mk6HMr4EWyfjEv82VKJqeanFb0gMJRb/tHGQbUZUV4brqbOgGgaQA7T1V6pbRK+dAK7EPcoD11SompsgOj2sUNTv1w60uiGeotDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHpEtmmg; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHpEtmmg"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f63546c3so1773294f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 08:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790262943; x=1790867743; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=K5qhWC1RezqgUxSYoHlPtRL/UlEjuJcpyuDmW9yQF/c=;
        b=fHpEtmmgR5MkYdYpdyZAbVzFzk0vS5NxJFys69ezISOAlFXvnnBivgqVODATCxYlUA
         Zz92KqcU7YM2WntUhb89SY1BtwFaDdAaa0Zuv9jhDXxXI9ySqaMhOWG9ia3RNNU0XNBK
         TH3vjn/+o5/DuFxGDlpSL28DLGFd93CRhp5D28POag/GYhMK9wZ6SVWTNRJ0v7EElMbj
         qH7drTmMP0epIoIWxXdTHUy7dsoZAEgMgx/wNliSAhjxvzweSKnp6qBtI0o/DF3hBO0Q
         eMm0nFCAqJIn18eITXOyuaQGul4JKTi6J6vPqZg3XVdd7+hlVLw/Mh4ny37m3FSX1V0k
         V0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790262943; x=1790867743;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=K5qhWC1RezqgUxSYoHlPtRL/UlEjuJcpyuDmW9yQF/c=;
        b=xwf0dcHEaO7mYHEpXbMAvtQUDjtU2hVwAWC1qzJ3ouolM7GPvw1xfNMJ7n+qTZPuXE
         4ui61TS3LBRlVG1QT9nBV+TSgwt1XToSAbYqgbAZHvzHnkPxZxSwtqWlP24fkxajtzPy
         dHwbClv6QzX/KG+Kr1EVYe/r1FMPOwxxK5kVUqIsvNKiJ4b8jcVCPtGszIBq+1KD4Xae
         4mVGa50DmpJKwEapzm0eM2c6BbpMljBo/BOFQWPabkvOV0HYh9bSwb5HTr8e+zLzdVxd
         kmKWkWlmXn6VVHMZE0vUK8f2ha3Mtnr+EiLbsK/p/Ly3bR2Ia49ZbYYJG7J8Jlbi2SM7
         uAGQ==
X-Forwarded-Encrypted: i=1; AKwUvByfVDnoeWA9FxC5uoy8Dhz7Sy0IzoBR2jC6E+D//UUYY9+h4F9X+Dh59PHWgpiNW+5hzkHybEeSrZS8iL1u6MEvHWM=@vger.kernel.org
X-Gm-Message-State: AFuF++mCys5S1wmjS87LpFI+NKSRu4Nqey6DIqhTuLYvNTZ14J7m9m4s
	V2D5/Xzp5w12Ky6xQsvX7qK977+oF005vqXahV4snT5b374/mDqVJwKX
X-Gm-Gg: AYBFou0nHDt+cKipF7ifGnFB7WtpzbJcQEyFJIO+UFaQf3R2mB6FBK/pFLrdHxjPwkF
	LYdlCu6sZDhEviyKv2hjmyQ7ePEh2UXOPlGhHCsDEaOcut5X4/RQQR0Kg93I5+x06FghYVDZ9z3
	RUyt7s1SEhgSPuBV1jlL3i/wRtlU4MNZV1e3cOf4bgwloRxrjFe9wy5x1W4+lSikQhiUbjtgIof
	QDBIjejasnLaPxxH6u5rjqb/9W+iWm/iVs+fhUKFVJi0y6fVs5vF/YD3bXCnRGO/4WpNFiq6pU2
	FIHpdLZi5cYKuspjkl1SKZg+2LJfgV/9mg74o6AdsY2sWvC0yFzS+lHEyOO6okd9NakpPX7qXCx
	RIlBKudOCKc+hgbqFFaiRQlaR8HaRodlwU/iDnzJSXAlNNxwJ+e1tAn0Uvi0hpAE2z6bGdj76o/
	UoXj/eMNq3qBgRu4W9zVz1OIgfzQG7T+z9vfBQ0JMpaxV7YNHZFh5bsN+wpEe+4t9DTPCJKh1zF
	rEoi4fBHlC+PxKpuOTvrY7tWzKedF4=
X-Received: by 2002:a5d:5f07:0:b0:485:8c16:5ef6 with SMTP id ffacd0b85a97d-48871874b3cmr5321696f8f.48.1790262942854;
        Thu, 24 Sep 2026 08:15:42 -0700 (PDT)
Received: from [127.0.1.1] (89-65-152-218.dynamic.play.pl. [89.65.152.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886848636asm15040931f8f.6.2026.09.24.08.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:15:42 -0700 (PDT)
From: Roman 'Hedin' Storozhenko <romeusmeister@gmail.com>
Date: Thu, 24 Sep 2026 17:15:21 +0200
Subject: [PATCH RESEND v2] riscv: mm: Trace TLB flush path selection
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-tlb_tracepoint-v2-1-4e3e78ef5cdb@gmail.com>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, 
 Roman 'Hedin' Storozhenko <romeusmeister@gmail.com>
X-Mailer: b4 0.13.0

Make RISC-V TLB flush path selection observable. Record whether Linux
handles an invalidation locally, delegates it to SBI RFENCE, or executes
it through a cross-CPU call, so MM activity can be correlated with the
RISC-V, firmware, or Linux cross-CPU path carrying the request.

The generic tlb:tlb_flush event describes TLB flush activity using
architecture-independent reason and page-count information. The RISC-V
implementation subsequently selects between local invalidation, SBI
RFENCE, and Linux cross-CPU coordination, with additional
architecture-specific request context available at that point.

Making this selection observable is useful when debugging RISC-V TLB
shootdowns. When a remote invalidation is observed to be slow, the
selected path determines whether to investigate SBI firmware and
platform handling or Linux cross-CPU and IPI handling. An unexpectedly
broad target mask can reveal an unintended address-space CPU footprint,
while the range and stride distinguish invalidation requests with
different mapping granularities.

Place the event in the RISC-V implementation because the local, SBI
RFENCE, or cross-CPU choice is made there, and SBI RFENCE and the
invalidation stride are RISC-V-specific semantics rather than properties
of the generic MM flush request.

Add riscv_tlb:riscv_tlb_flush_path in flush_tlb_all() and
__flush_tlb_range(). Record start, size, stride, the hardware-visible
ASID, whether a specific mm is associated with the request, the target
CPU mask and its weight, the requested scope, and the selected path.

Record the complete target mask in addition to its weight because CPU
identity cannot be reconstructed from a count and is needed to correlate
the request with per-CPU scheduler, IPI, and firmware activity.

The event records the invalidation request and the path selected by Linux
before the operation is dispatched. In particular, selecting the SBI
RFENCE path means that Linux delegated the request to firmware; the event
does not describe the implementation or outcome of that delegated
operation.

Tested on QEMU virt with OpenSBI using local and shared-mm
mprotect()/munmap() workloads. Local requests reported path=local,
while remote requests reported path=sbi-rfence and were followed by the
existing riscv:sbi_call RFENCE event.

The cross-CPU-call path was tested with QEMU virt using APLIC+IMSIC.
A MADV_PAGEOUT reclaim workload was used to exercise mm-independent
global flushes. All reported path values (local, sbi-rfence and
cross-cpu-call) and scope values (single, range, address-space and all)
were observed.

Signed-off-by: Roman 'Hedin' Storozhenko <romeusmeister@gmail.com>
---
Add a RISC-V tracepoint for observing the path selected by Linux for TLB
invalidation requests: local invalidation, SBI RFENCE, or Linux
cross-CPU coordination.

The tracepoint is intended to make RISC-V TLB shootdown behavior easier
to correlate with MM activity, CPU targeting, SBI calls, and IPI
handling. The patch records the invalidation request context and the
Linux path-selection decision before the operation is dispatched.

The patch was tested on QEMU virt with both the SBI RFENCE path and an
APLIC+IMSIC configuration. Local, SBI RFENCE, and cross-CPU-call paths
were exercised. All reported scope values -- single, range,
address-space, and all -- were also observed.
---
Changes in v2:
- Use trace_call__riscv_tlb_flush_path() after the explicit
  trace_riscv_tlb_flush_path_enabled() check to avoid a second
  tracepoint static-key test, as suggested by Steven Rostedt.
- Link to v1: https://lore.kernel.org/r/20260829-tlb_tracepoint-v1-1-dfdaede7e741@gmail.com
---
 arch/riscv/mm/tlbflush.c         |  60 +++++++++++++++++++--
 include/trace/events/riscv_tlb.h | 113 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 169 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 962db300a166..cefce9364bd2 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -9,6 +9,9 @@
 #include <asm/mmu_context.h>
 #include <asm/cpufeature.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/riscv_tlb.h>
+
 #define has_svinval()	riscv_has_extension_unlikely(RISCV_ISA_EXT_SVINVAL)
 
 /*
@@ -63,6 +66,33 @@ void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
 	local_flush_tlb_range_asid(start, end - start, PAGE_SIZE, FLUSH_TLB_NO_ASID);
 }
 
+static enum riscv_tlb_flush_scope
+riscv_tlb_get_flush_scope(unsigned long size, unsigned long stride, bool has_mm)
+{
+	if (size == FLUSH_TLB_MAX_SIZE)
+		return has_mm ? RISCV_TLB_FLUSH_SCOPE_ADDRESS_SPACE :
+			RISCV_TLB_FLUSH_SCOPE_ALL;
+
+	return size <= stride ? RISCV_TLB_FLUSH_SCOPE_SINGLE :
+		RISCV_TLB_FLUSH_SCOPE_RANGE;
+}
+
+static __always_inline void
+riscv_tlb_trace_flush_path(const struct cpumask *cmask, unsigned long start,
+			   unsigned long size, unsigned long stride,
+			   unsigned long asid, bool has_mm,
+			   enum riscv_tlb_flush_path path)
+{
+	enum riscv_tlb_flush_scope scope;
+
+	if (!trace_riscv_tlb_flush_path_enabled())
+		return;
+
+	scope = riscv_tlb_get_flush_scope(size, stride, has_mm);
+	trace_call__riscv_tlb_flush_path(start, size, stride, asid, has_mm,
+			 cmask, scope, path);
+}
+
 static void __ipi_flush_tlb_all(void *info)
 {
 	local_flush_tlb_all();
@@ -70,12 +100,26 @@ static void __ipi_flush_tlb_all(void *info)
 
 void flush_tlb_all(void)
 {
-	if (num_online_cpus() < 2)
+	if (num_online_cpus() < 2) {
+		riscv_tlb_trace_flush_path(cpu_online_mask, 0,
+					   FLUSH_TLB_MAX_SIZE, 0,
+					   FLUSH_TLB_NO_ASID, false,
+					   RISCV_TLB_FLUSH_PATH_LOCAL);
 		local_flush_tlb_all();
-	else if (riscv_use_sbi_for_rfence())
-		sbi_remote_sfence_vma_asid(NULL, 0, FLUSH_TLB_MAX_SIZE, FLUSH_TLB_NO_ASID);
-	else
+	} else if (riscv_use_sbi_for_rfence()) {
+		riscv_tlb_trace_flush_path(cpu_online_mask, 0,
+					   FLUSH_TLB_MAX_SIZE, 0,
+					   FLUSH_TLB_NO_ASID, false,
+					   RISCV_TLB_FLUSH_PATH_SBI_RFENCE);
+		sbi_remote_sfence_vma_asid(NULL, 0, FLUSH_TLB_MAX_SIZE,
+					   FLUSH_TLB_NO_ASID);
+	} else {
+		riscv_tlb_trace_flush_path(cpu_online_mask, 0,
+					   FLUSH_TLB_MAX_SIZE, 0,
+					   FLUSH_TLB_NO_ASID, false,
+					   RISCV_TLB_FLUSH_PATH_CROSS_CPU_CALL);
 		on_each_cpu(__ipi_flush_tlb_all, NULL, 1);
+	}
 }
 
 struct flush_tlb_range_data {
@@ -107,12 +151,20 @@ static void __flush_tlb_range(struct mm_struct *mm,
 
 	/* Check if the TLB flush needs to be sent to other CPUs. */
 	if (cpumask_any_but(cmask, cpu) >= nr_cpu_ids) {
+		riscv_tlb_trace_flush_path(cmask, start, size, stride, asid,
+					   !!mm, RISCV_TLB_FLUSH_PATH_LOCAL);
 		local_flush_tlb_range_asid(start, size, stride, asid);
 	} else if (riscv_use_sbi_for_rfence()) {
+		riscv_tlb_trace_flush_path(cmask, start, size, stride, asid,
+					   !!mm, RISCV_TLB_FLUSH_PATH_SBI_RFENCE);
 		sbi_remote_sfence_vma_asid(cmask, start, size, asid);
 	} else {
 		struct flush_tlb_range_data ftd;
 
+		riscv_tlb_trace_flush_path(cmask, start, size, stride, asid,
+					   !!mm,
+					   RISCV_TLB_FLUSH_PATH_CROSS_CPU_CALL);
+
 		ftd.asid = asid;
 		ftd.start = start;
 		ftd.size = size;
diff --git a/include/trace/events/riscv_tlb.h b/include/trace/events/riscv_tlb.h
new file mode 100644
index 000000000000..3eff171ec54f
--- /dev/null
+++ b/include/trace/events/riscv_tlb.h
@@ -0,0 +1,113 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM riscv_tlb
+
+#if !defined(_TRACE_RISCV_TLB_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_RISCV_TLB_H
+
+#include <linux/cpumask.h>
+#include <linux/tracepoint.h>
+
+#ifndef _TRACE_RISCV_TLB_ENUMS
+#define _TRACE_RISCV_TLB_ENUMS
+
+enum riscv_tlb_flush_scope {
+	RISCV_TLB_FLUSH_SCOPE_SINGLE,
+	RISCV_TLB_FLUSH_SCOPE_RANGE,
+	RISCV_TLB_FLUSH_SCOPE_ADDRESS_SPACE,
+	RISCV_TLB_FLUSH_SCOPE_ALL,
+};
+
+enum riscv_tlb_flush_path {
+	RISCV_TLB_FLUSH_PATH_LOCAL,
+	RISCV_TLB_FLUSH_PATH_SBI_RFENCE,
+	RISCV_TLB_FLUSH_PATH_CROSS_CPU_CALL,
+};
+
+#endif /* _TRACE_RISCV_TLB_ENUMS */
+
+TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_SCOPE_SINGLE);
+TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_SCOPE_RANGE);
+TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_SCOPE_ADDRESS_SPACE);
+TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_SCOPE_ALL);
+
+TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_PATH_LOCAL);
+TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_PATH_SBI_RFENCE);
+TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_PATH_CROSS_CPU_CALL);
+
+#define show_riscv_tlb_flush_scope(scope) \
+	__print_symbolic(scope, \
+		{ RISCV_TLB_FLUSH_SCOPE_SINGLE,        "single" }, \
+		{ RISCV_TLB_FLUSH_SCOPE_RANGE,         "range" }, \
+		{ RISCV_TLB_FLUSH_SCOPE_ADDRESS_SPACE, "address-space" }, \
+		{ RISCV_TLB_FLUSH_SCOPE_ALL,           "all" })
+
+#define show_riscv_tlb_flush_path(path) \
+	__print_symbolic(path, \
+		{ RISCV_TLB_FLUSH_PATH_LOCAL,          "local" }, \
+		{ RISCV_TLB_FLUSH_PATH_SBI_RFENCE,     "sbi-rfence" }, \
+		{ RISCV_TLB_FLUSH_PATH_CROSS_CPU_CALL, "cross-cpu-call" })
+
+/*
+ * Record the invalidation request received by the RISC-V architecture code
+ * and the path selected by Linux.
+ *
+ * The target CPU mask represents the CPUs Linux intends to cover for the
+ * request. It can be correlated with per-CPU activity, but does not describe
+ * which harts ultimately performed an invalidation.
+ *
+ * The ASID is hardware-visible and may be reused. It must not be treated as a
+ * persistent identifier for an mm.
+ *
+ * The stride describes the invalidation granularity supplied to the RISC-V
+ * implementation. SBI RFENCE receives start, size and ASID, but not stride.
+ *
+ * The event is emitted at path selection time. For SBI RFENCE, it records
+ * delegation of the request to firmware; firmware processing after that
+ * point is outside the event's scope.
+ */
+TRACE_EVENT(riscv_tlb_flush_path,
+	TP_PROTO(unsigned long start, unsigned long size,
+		 unsigned long stride, unsigned long asid, bool has_mm,
+		 const struct cpumask *cmask,
+		 enum riscv_tlb_flush_scope scope,
+		 enum riscv_tlb_flush_path path),
+
+	TP_ARGS(start, size, stride, asid, has_mm, cmask, scope, path),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, start)
+		__field(unsigned long, size)
+		__field(unsigned long, stride)
+		__field(unsigned long, asid)
+		__field(bool, has_mm)
+		__field(unsigned int, target_mask_weight)
+		__cpumask(target_cpus)
+		__field(u8, scope)
+		__field(u8, path)
+	),
+
+	TP_fast_assign(
+		__entry->start = start;
+		__entry->size = size;
+		__entry->stride = stride;
+		__entry->asid = asid;
+		__entry->has_mm = has_mm;
+		__entry->target_mask_weight = cpumask_weight(cmask);
+		__assign_cpumask(target_cpus, cpumask_bits(cmask));
+		__entry->scope = scope;
+		__entry->path = path;
+	),
+
+	TP_printk("start=%#lx size=%#lx stride=%#lx asid=%#lx has_mm=%d target_mask_weight=%u target_cpus=%s scope=%s path=%s",
+		  __entry->start, __entry->size, __entry->stride,
+		  __entry->asid, __entry->has_mm,
+		  __entry->target_mask_weight, __get_cpumask(target_cpus),
+		  show_riscv_tlb_flush_scope(__entry->scope),
+		  show_riscv_tlb_flush_path(__entry->path))
+);
+
+#endif /* _TRACE_RISCV_TLB_H */
+
+/* This part must be outside protection. */
+#include <trace/define_trace.h>

---
base-commit: 77ae27fd98f3b548797c9f22c10ab5cf1c4ada53
change-id: 20260829-tlb_tracepoint-844105ab5092

Best regards,
-- 
Roman 'Hedin' Storozhenko <romeusmeister@gmail.com>

