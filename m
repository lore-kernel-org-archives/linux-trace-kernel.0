Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3B0531607
	for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Oct 2026 17:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792083830; cv=none; b=BEhbyqhAK9vRBzbKZ8MBiqg///RUB7omhra1HRbDocssLmWyfmZjketn6T9yc3FSLJLdgGOuKEGDqOWUXa5vCIub3P5YB1xAgqwrd76q4YG10Xs3mWpEICuXp/EKUTFGtlXG5I38NKmmtsxaNryEU8x/TCGWzK9GKMQ6oW4qz4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792083830; c=relaxed/simple;
	bh=uPGqEDojyLJ4T9lfhZu3FypxrnNQ+CjJPyPFqWS7JIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uBZt6fA8bljuklGqYHWVqPjREto3u6/GYQu99wXeA47GysfL1fOryxmyQ2e+ponMmcY15z4dfUMBXhedoYLmMiXaroP85bwgjudKa/JHNPClgJEzfv5w/PZEEKwLgk8CiSVOUqeSWUEhA+1Gp3xhmoieTRUj19T/2XUwNZDJxrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxB+EJ4z; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxB+EJ4z"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a19cba5c14so50454655e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Oct 2026 10:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792083816; x=1792688616; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VwDK8PbStx/46m4LXZ7crOznWAwX4elJ79EUXp9Hzwc=;
        b=SxB+EJ4zRjGpanQRkd16ZLbIvOFYIxuFe6JL4B4h5/EsrQps/Uq9PiAhFUqsj2V1kn
         D4/KE34TqQP5vjfJLtM+zBM0B+vmXHlh0/AyC+O9KTR0ExBkvGz3r7xfyr58E5fCHD6J
         NisGQX/wELSI/mO/32DC0lgs0PKtpWEV9Ey3PSukTOspMKGN0dO9F/RDAjbV4PzQmfRq
         J1xfBNY7A5XvE0cZu1FgS5F7xSjXBV1py0CaVGgYY3kirGQdNF25eslunESoCqC6+G83
         Y6JJyt51Wc0/Djnz6pup0Vwx0ySE2D049thFC8YSpq9qVcpD0JZl87WTTkID8rgp9cLU
         TZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792083816; x=1792688616;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=VwDK8PbStx/46m4LXZ7crOznWAwX4elJ79EUXp9Hzwc=;
        b=PaajCg1OPO8VQNNxSZpr6AHZPyI5myMX+RHFzhTWkr4WFaCY+3s21u2Pgzd+DKGwiK
         75g1zJIl9I0Twjhb/o4lOhUjdEdckHjUzVBCTUOPt1svpev1otIDfhv2WyHsu4SPrqYP
         Na9P/ILav2V56gUcwYLtVsbF191sOFYjoUvo3cNWM2Kiq8x9m4DplMAWoDsQGhtrPVM2
         VWekmcgE/Du7kPr+mTWTZLKFGBn4IoqHviNGsvQ5wWh+CG/s+49xPqf7oZX1MJ+3F5YX
         +YWQPxSnknYj+iTf56ocua5DsejIEYhBTYffyvQ5UQGY0wjbOxGddewZ5GmP4MaXKJqV
         q+KQ==
X-Forwarded-Encrypted: i=1; AKwUvByW8On37JJY6ur9sYb431nLUyKne/itC9qXnp3rxFaGjuu7jtmToHhAk3nC4WCRySgtEZU//9OGy7dCAHBvitbro4M=@vger.kernel.org
X-Gm-Message-State: AFq9FYJSorRmgrBod+oSY3pHGKBw0S4f1hKtf/QbyrBj8gZUlDjaBID6
	Ojqyme3W7WMw+2y0ouCuvir8+JiOK0rFjC1KWadzDh8MDW2XYdXXynmS
X-Gm-Gg: AYBFou3iK1FJ4i/z/cp6+yq0+FPeUb9YFcpE4cf7r5uol1NA/NLs9J7PlcdZ09hydFM
	2BwGiWYIXyc6YX8KetF3ZsE+8wmhtBD6ReuI/kUU3/XQbj/wPg3Y32d/Sfxt/qqBN887M07Z2Y1
	UAXIJCimTLYbRhp/SDjCafio9HcDRws7//+pf5sfwtTLTMzQcC+WYWPK6VN5CRAb9o2GB8NYZ4b
	4+VhO19QTq/cAdCJ4eYstgXDFInuREQAgGZ02CEK24gKMkcxWWcLHmUpg8ebNLzG+89W9GSkAb6
	OU+uX4ImnVMMIfwUQg6NLJ3K0xBOUix4ckanFVVlQAgU6uYmfCw05MDCFTMw5B+xhRnSYmlAId9
	A7AHTqtPF+oUXrZXoFMvw+tunQTOsLavnU183ly3pBoLZd09s6peK9qkn3dac3fh/xsEIrV++by
	tJ99uuvt0wk3P+f43cDnGomVp5bqQUqe+UDlP0T3NJRswU/HKIrQjv2OpGWpoDc7FVUz1t6iA1m
	O0luOR7gBOqgFv2+bHJ6Px+kFNIdR+8
X-Received: by 2002:a05:600c:5493:b0:4a1:78da:d271 with SMTP id 5b1f17b1804b1-4a18e4ee976mr429328155e9.30.1792083815973;
        Thu, 15 Oct 2026 10:03:35 -0700 (PDT)
Received: from [127.0.1.1] (89-65-152-218.dynamic.play.pl. [89.65.152.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bd777fsm18247430f8f.57.2026.10.15.10.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 10:03:34 -0700 (PDT)
From: Roman 'Hedin' Storozhenko <romeusmeister@gmail.com>
Date: Thu, 15 Oct 2026 19:03:20 +0200
Subject: [PATCH v3] riscv: mm: Trace TLB flush requests
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-tlb_tracepoint-v3-1-eef305a3bb63@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XM0QqDIBiG4VsJj+dQs+V2tPsYY5j+1Q+VoSIb0
 b3POgrGDr8PnnchATxCILdiIR4SBnRTHuWpIKbXUwcUbd5EMHFhSlxpHJpX9NrA7HCKVEnJWaW
 bil0FyWj20OJ7Dz6eefcYovOfvZ/49v5NJU45ta3VYKGGWvJ7N2oczsaNZEslceAl++EicyiNU
 kZI21bNka/r+gUemBzY6wAAAA==
X-Change-ID: 20260829-tlb_tracepoint-844105ab5092
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jisheng Zhang <jszhang@kernel.org>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, 
 Roman 'Hedin' Storozhenko <romeusmeister@gmail.com>
X-Mailer: b4 0.14.3

Make RISC-V TLB flush requests observable together with the
architecture-specific context available when the request reaches the
RISC-V implementation.

The generic tlb:tlb_flush event describes TLB flush activity using
architecture-independent reason and page-count information. At the
RISC-V implementation level, additional request context is available,
including the invalidation range and stride, ASID, target CPU mask, and
the requested invalidation scope.

This information is useful for debugging and workload analysis. The
target CPU mask can show the address-space CPU footprint involved in an
invalidation, while the range and stride distinguish requests operating
on different mapping granularities. Recording the ASID and requested
scope makes it possible to correlate those requests with other MM,
scheduler, IPI, and firmware activity.

Add riscv_tlb:riscv_tlb_flush_request in flush_tlb_all() and
__flush_tlb_range(). Record start, size, stride, the hardware-visible
ASID, whether a specific mm is associated with the request, the target
CPU mask and its weight, and the requested scope.

Record the complete target mask in addition to its weight because CPU
identity cannot be reconstructed from a count and is useful when
correlating TLB invalidations with per-CPU activity.

The event describes the semantic invalidation request before it is
dispatched. It intentionally does not record whether a remote request is
implemented through SBI RFENCE or Linux cross-CPU coordination, since
that choice is effectively established during system initialization
rather than selected independently for each request.

Tested on QEMU virt with OpenSBI using local and shared-mm
mprotect()/munmap() workloads. These exercised single, range, and
address-space invalidation requests with different target CPU masks.

Also tested on QEMU virt with APLIC+IMSIC. A MADV_PAGEOUT reclaim
workload was used to exercise mm-independent global flushes. All scope
values (single, range, address-space, and all) were observed.

Signed-off-by: Roman 'Hedin' Storozhenko <romeusmeister@gmail.com>
---
Add a RISC-V tracepoint for observing TLB invalidation requests as they
reach the architecture-specific implementation.

The generic tlb:tlb_flush event describes TLB flush activity using
architecture-independent reason and page-count information. At the
RISC-V implementation level, additional request context is available,
including the invalidation range and stride, ASID, target CPU mask, and
derived request scope.

The tracepoint is intended to make RISC-V TLB invalidation activity
easier to correlate with MM, scheduler, IPI, and firmware activity. For
mm-associated invalidations, the target CPU mask can show the
address-space CPU footprint involved in the request, while the range and
stride distinguish requests operating on different mapping
granularities.

The event describes the semantic invalidation request before it is
dispatched. It intentionally does not report whether a remote request is
implemented through SBI RFENCE or Linux cross-CPU coordination, since
that choice is effectively established during system initialization
rather than selected independently for each request.

The patch was tested on QEMU virt with OpenSBI using local and shared-mm
mprotect()/munmap() workloads. These exercised single, range, and
address-space invalidation requests with different target CPU masks.

It was also tested on QEMU virt with APLIC+IMSIC. A MADV_PAGEOUT reclaim
workload was used to exercise mm-independent global flushes. All derived
request scope values -- single, range, address-space, and all -- were
observed.
---
Changes in v3:
- Rebase on current RISC-V for-next.
- Thanks to Jisheng Zhang for pointing out that SBI RFENCE versus Linux
  cross-CPU coordination is effectively a system-wide choice established
  during initialization rather than a per-request decision.
- Drop the local/SBI RFENCE/cross-CPU path field.
- Rename the event from riscv_tlb_flush_path to
  riscv_tlb_flush_request and refocus it on the semantic TLB
  invalidation request.
- Emit one request event independently of the mechanism subsequently
  used to perform the invalidation.
- Address checkpatch.pl --strict alignment issues.
- Link to v2: https://lore.kernel.org/r/20260830-tlb_tracepoint-v2-1-e3c88c24df5b@gmail.com

Changes in v2:
- Use trace_call__riscv_tlb_flush_path() after the explicit
  trace_riscv_tlb_flush_path_enabled() check to avoid a second
  tracepoint static-key test, as suggested by Steven Rostedt.
- Link to v1: https://lore.kernel.org/r/20260829-tlb_tracepoint-v1-1-dfdaede7e741@gmail.com
---
 arch/riscv/mm/tlbflush.c         | 54 ++++++++++++++++++++----
 include/trace/events/riscv_tlb.h | 90 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 137 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 962db300a166..0e7c8088de5e 100644
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
@@ -47,7 +50,9 @@ static void local_flush_tlb_range_threshold_asid(unsigned long start,
 }
 
 static inline void local_flush_tlb_range_asid(unsigned long start,
-		unsigned long size, unsigned long stride, unsigned long asid)
+					      unsigned long size,
+					      unsigned long stride,
+					      unsigned long asid)
 {
 	if (size <= stride)
 		local_flush_tlb_page_asid(start, asid);
@@ -63,6 +68,32 @@ void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
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
+riscv_tlb_trace_flush_request(const struct cpumask *cmask, unsigned long start,
+			      unsigned long size, unsigned long stride,
+			      unsigned long asid, bool has_mm)
+{
+	enum riscv_tlb_flush_scope scope;
+
+	if (!trace_riscv_tlb_flush_request_enabled())
+		return;
+
+	scope = riscv_tlb_get_flush_scope(size, stride, has_mm);
+	trace_call__riscv_tlb_flush_request(start, size, stride, asid, has_mm,
+					    cmask, scope);
+}
+
 static void __ipi_flush_tlb_all(void *info)
 {
 	local_flush_tlb_all();
@@ -70,12 +101,18 @@ static void __ipi_flush_tlb_all(void *info)
 
 void flush_tlb_all(void)
 {
-	if (num_online_cpus() < 2)
+	riscv_tlb_trace_flush_request(cpu_online_mask, 0,
+				      FLUSH_TLB_MAX_SIZE, 0,
+				   FLUSH_TLB_NO_ASID, false);
+
+	if (num_online_cpus() < 2) {
 		local_flush_tlb_all();
-	else if (riscv_use_sbi_for_rfence())
-		sbi_remote_sfence_vma_asid(NULL, 0, FLUSH_TLB_MAX_SIZE, FLUSH_TLB_NO_ASID);
-	else
+	} else if (riscv_use_sbi_for_rfence()) {
+		sbi_remote_sfence_vma_asid(NULL, 0, FLUSH_TLB_MAX_SIZE,
+					   FLUSH_TLB_NO_ASID);
+	} else {
 		on_each_cpu(__ipi_flush_tlb_all, NULL, 1);
+	}
 }
 
 struct flush_tlb_range_data {
@@ -105,6 +142,8 @@ static void __flush_tlb_range(struct mm_struct *mm,
 
 	cpu = get_cpu();
 
+	riscv_tlb_trace_flush_request(cmask, start, size, stride, asid, !!mm);
+
 	/* Check if the TLB flush needs to be sent to other CPUs. */
 	if (cpumask_any_but(cmask, cpu) >= nr_cpu_ids) {
 		local_flush_tlb_range_asid(start, size, stride, asid);
@@ -185,7 +224,7 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
-			unsigned long end)
+			 unsigned long end)
 {
 	__flush_tlb_range(vma->vm_mm, mm_cpumask(vma->vm_mm),
 			  start, end - start, PMD_SIZE);
@@ -205,7 +244,8 @@ bool arch_tlbbatch_should_defer(struct mm_struct *mm)
 }
 
 void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
-		struct mm_struct *mm, unsigned long start, unsigned long end)
+			       struct mm_struct *mm, unsigned long start,
+			       unsigned long end)
 {
 	cpumask_or(&batch->cpumask, &batch->cpumask, mm_cpumask(mm));
 	mmu_notifier_arch_invalidate_secondary_tlbs(mm, start, end);
diff --git a/include/trace/events/riscv_tlb.h b/include/trace/events/riscv_tlb.h
new file mode 100644
index 000000000000..f289480a2c0e
--- /dev/null
+++ b/include/trace/events/riscv_tlb.h
@@ -0,0 +1,90 @@
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
+#endif /* _TRACE_RISCV_TLB_ENUMS */
+
+TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_SCOPE_SINGLE);
+TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_SCOPE_RANGE);
+TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_SCOPE_ADDRESS_SPACE);
+TRACE_DEFINE_ENUM(RISCV_TLB_FLUSH_SCOPE_ALL);
+
+#define show_riscv_tlb_flush_scope(scope) \
+	__print_symbolic(scope, \
+		{ RISCV_TLB_FLUSH_SCOPE_SINGLE,        "single" }, \
+		{ RISCV_TLB_FLUSH_SCOPE_RANGE,         "range" }, \
+		{ RISCV_TLB_FLUSH_SCOPE_ADDRESS_SPACE, "address-space" }, \
+		{ RISCV_TLB_FLUSH_SCOPE_ALL,           "all" })
+
+/*
+ * Record the invalidation request received by the RISC-V architecture code
+ *
+ * The target CPU mask represents the CPUs Linux intends to cover for the
+ * request. It can be correlated with per-CPU activity, but does not describe
+ * which harts ultimately performed an invalidation.
+ *
+ * The ASID is hardware-visible and may be reused. It must not be treated as a
+ * persistent identifier for an mm.
+ *
+ * The stride describes the invalidation granularity supplied to the RISC-V
+ * implementation.
+ *
+ * The event records the invalidation request before it is dispatched. It does
+ * not describe the mechanism used to execute the request.
+ *
+ */
+TRACE_EVENT(riscv_tlb_flush_request,
+	    TP_PROTO(unsigned long start, unsigned long size,
+		     unsigned long stride, unsigned long asid, bool has_mm,
+		     const struct cpumask *cmask,
+		     enum riscv_tlb_flush_scope scope),
+
+	TP_ARGS(start, size, stride, asid, has_mm, cmask, scope),
+
+	TP_STRUCT__entry(__field(unsigned long, start)
+		__field(unsigned long, size)
+		__field(unsigned long, stride)
+		__field(unsigned long, asid)
+		__field(bool, has_mm)
+		__field(unsigned int, target_mask_weight)
+		__cpumask(target_cpus)
+		__field(u8, scope)
+	),
+
+	TP_fast_assign(__entry->start = start;
+		__entry->size = size;
+		__entry->stride = stride;
+		__entry->asid = asid;
+		__entry->has_mm = has_mm;
+		__entry->target_mask_weight = cpumask_weight(cmask);
+		__assign_cpumask(target_cpus, cpumask_bits(cmask));
+		__entry->scope = scope;
+	),
+
+	TP_printk("start=%#lx size=%#lx stride=%#lx asid=%#lx has_mm=%d target_mask_weight=%u target_cpus=%s scope=%s",
+		  __entry->start, __entry->size, __entry->stride,
+		  __entry->asid, __entry->has_mm,
+		  __entry->target_mask_weight, __get_cpumask(target_cpus),
+		  show_riscv_tlb_flush_scope(__entry->scope))
+);
+
+#endif /* _TRACE_RISCV_TLB_H */
+
+/* This part must be outside protection. */
+#include <trace/define_trace.h>

---
base-commit: a5ae1bf65cee84bcc121d659e7e22a767853f5f5
change-id: 20260829-tlb_tracepoint-844105ab5092

Best regards,
-- 
Roman 'Hedin' Storozhenko <romeusmeister@gmail.com>

