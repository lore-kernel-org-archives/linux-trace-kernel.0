Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792430463;
	b=N82i7IJP5h4mc9+hitBf1bjW3gwey2ZS9k/SUEvIak0b4vKQSYkCt76o4saRkohIkPm3
	 gJ9u+k0wHhcP1OcoTJsVQ1eRcOYuawHApADY+1By7361tZoEXhQAlhYaE93pXr82jGCfU
	 JYcBivvMVKY+cr4RWzkfSo+XoCrN6ZQdjeptHGk4bf8f4an6uSs1u4HDGTGERj6IxbpaR
	 zclDATUBmJu36TI9J9YZDZ8h78Cfu/rLZDZHBnMMOD83dHXu9ttJjrrKRUXSni85JFNXa
	 tbASp5RiTanMYG8oxAhLRYHG1ztTlRKTyngXpKhav9xrYVCsuFce2TCcSxZFShh2HlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792430463;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=1aDSC/6caT0lwDDexiAxkoUQe1Pgm8dLFVDyR39TkOI=;
	b=m1sJlm2OnJB1dVMc/ylw8tO26h0leyhnVj5ct8Mf49hy/W1C3aZLVXT10uK92uyKxIdp
	 +wj5gRHG6dombRrRd4jJuCn6oOr58M+uc5HxrvhJMEzXNWsA8fV0UvUHHGKgLEz7sKae/
	 RCOflvsEkzxQ3ThZUbCU8hobo2A0NhBlQ2X+BiDMVi9q3v+wfpm46cbqSCB94XNQwfJMM
	 y3v8sdNsr51RXusAP2HK/WyDgt+6585tTNPHPvWGBz5a6ROs02ACJ44U3plm7nBmR8OWQ
	 ZgvlFUB9owWPSVv1du2QYJ4QQStiig7c+0gfRQK11pAjcaBUWgluqtmoFATB0W+Vx7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Xe0g+oq9;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB261606A31D
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 17:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB261606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Xe0g+oq9
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a1880e1bf1so21196075e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 10:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792430461; x=1793035261; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1aDSC/6caT0lwDDexiAxkoUQe1Pgm8dLFVDyR39TkOI=;
        b=Xe0g+oq9N/5iZCzzG26G0reCGdy//vq9233DRCM11WIcwNchnDkDUMCANQNLSU0QmE
         5R1maAI6a2UCLi6H7vc5MSmmgOR3o3FWaG+YiC6RbArCnI8k1bA0FIFJ00wRUiuvvMO8
         jL0hm1lpmq9/IaC3NfcGe+xymW4L5mKa314oKa663T8WMpNWGjmHEfPKc9uSNCWgcWrw
         eyqowTeITaxVeZZp5zfBh3Eaqy4URzt5QJc+GTcLB3FsSN1OlJ1z4MdbYTu+R/pkzhdz
         DypqJiTbaY1sRoWZoHx7CsIj6cjM3DxCAqcEZlgDkqOS+Gu+fW0SejaWjpDX/YzJvlSr
         GvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792430461; x=1793035261;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1aDSC/6caT0lwDDexiAxkoUQe1Pgm8dLFVDyR39TkOI=;
        b=Tkf457gWQeapxOsTtEBRpn6TZYpUOXijt2fCEe9fbkiZYI+cjbSF8Myq2ExwrAnREG
         5RS402pX5jlrFySXy7OmkiAjGwu373B48RZCkRh2lKuYOO4RgSPSgJj/RsnoshHp5PMY
         stc6yAlEjAlFfFInAW4flhnCGpya8m+oUqhM4sGjkfdCy2Dzxolu+hMxFq6PEPDftmAf
         XO0Yck9wPbv+bRRCSSWiHaFmRz24ynsg2eklsjQELFhsaIFvY6JK+HJnGPfIyJqTgmNo
         s2A/mDGkOhHsIccCwwGuNgeod0U2pMml9i6TSV2+pJzm7GM8TEJF/i4NQ8ORcZU5xSh1
         lBBg==
X-Forwarded-Encrypted: i=1; AKwUvByMgVM2VUlY6CNkoBY8uP0wIfbE5TbQv5lxWN2HGSQe/A0/kOHD2Ie41djEdJpBGALo3QzHmGRA/Egf0oQypQ2TDYg=@vger.kernel.org
X-Gm-Message-State: AFq9FYL2Nd96eD3Sevk85awzilTPWPaJPEuJij/5DwfK1Dc7/0L6dmUd
	HE/nJSgysaKo6wq//+2lwCDN2E+4+Fz2JgZIkO1qIOKHrFUT5WwzeM9w
X-Gm-Gg: AYBFou0SGu/6ntd4y0YMltXjMmfX4bu5MXU6LbUkDQl0mcFTRTmo4ymih5DZLNB8zWp
	MykiBF73lfvedLMRP4yRaG37RycrsfzcO57FN6S+TAxEe14vJdTSQ9rOASV3w/MrzWL9pc9AKqv
	2qT9rdYi+qBCcdsXGX4VM80YeY8SnUhScUhnhcnEuY6FrZMSVxORDCbNLle22c0rFhXNJoiDUVd
	BE8IgajeTxulm7HWe9gjp3ka9xSyJ8/McjrwFbJgHrXXjm+r84WXJBUGOErypi1TkmsLisGs2CR
	ptRZ83WG5nICNBIaep2Nu32wO93b8idAkLAuGE1Lrxo1KRtf4ZPsi/QymJUgygHeFlBhujXNISq
	qusFOvd8nw2if63PsSYnV0PZs7KserH8CXQQfbnwvHl/iE6OHuQ0imKoUwUSDBnxdMTLvfxbUS8
	2ita5toLLJ2B/+nS84uzWBqnxkz26z0AO1k0orRrXFEIHKofc24GhVY6eDGMBXj2g0OCnwtlM0c
	kYDpA+csiYxdpYI7ov342IAydzCDVwo
X-Received: by 2002:a05:600c:1909:b0:4a1:dbdd:d56b with SMTP id 5b1f17b1804b1-4a1dbddd68emr163879595e9.19.1792430460664;
        Mon, 19 Oct 2026 10:21:00 -0700 (PDT)
Received: from [127.0.1.1] (89-65-152-218.dynamic.play.pl. [89.65.152.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2c1e0e6sm9644465e9.0.2026.10.19.10.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 10:20:59 -0700 (PDT)
From: Roman 'Hedin' Storozhenko <romeusmeister@gmail.com>
Date: Mon, 19 Oct 2026 19:20:51 +0200
Subject: [PATCH v7] riscv: mm: Trace TLB flush requests
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-tlb_tracepoint-v7-1-4cc3e99d387a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33PTWrDMBCG4asErasizejPXfUeJRTJGiWCxA6yM
 Q3Bd6+cRXFt2uU38LwwDzZQyTSwt8ODFZrykPuuDvtyYO3ZdyfiOdbNQIARDho+XsLnWHxLtz5
 3I3dKSaF90KIBVtGtUMpfz+DHse5zHsa+3J/9SS7XP1OT5JLHFD1FsmSVfD9dfb68tv2VLakJV
 hzFjkPlhK1zLaiYdNhy/OFSSL3juHBKWL/BEAxuufqfq8oToPMQokuWtlyvud1xXTlok4LGBr1
 NW27W3O24qVwqZY0C66z4xed5/gZFLFsV5wEAAA==
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
architecture-specific context available when the request reaches
the RISC-V implementation.

The generic tlb:tlb_flush event provides reason and page-count
information. At the RISC-V implementation level, additional
context is available, including the invalidation range and stride,
ASID, target CPU mask, and invalidation scope.

This context is useful for debugging and workload analysis. The
target CPU mask shows the address-space CPU footprint involved in
an invalidation, while range and stride distinguish requests at
different mapping granularities. The ASID and scope help correlate
requests with MM, scheduler, IPI, and firmware activity.

Add riscv_tlb:riscv_tlb_flush_request in flush_tlb_all() and
__flush_tlb_range(). Record start, size, stride, ASID (or the
no-ASID sentinel), whether an mm is associated with the request,
the target CPU mask and its weight, and the derived scope.

Record the complete target mask because CPU identity cannot be
reconstructed from a count. Calculate its weight from the recorded
bitmap so both fields agree even if mm_cpumask() changes during
recording.

The event describes an invalidation request before dispatch. It
does not report whether a remote flush uses SBI RFENCE or Linux
cross-CPU coordination, since that choice is effectively established
during initialization rather than made for each request.

The address field (start) may contain kernel virtual addresses
for flushes involving kernel mappings. Require perf tracepoint
permissions even for counting-only events, since perf filters
could otherwise reveal address information through event counts.

Tested on QEMU virt with OpenSBI using local and shared-mm
mprotect()/munmap() workloads, exercising single, range, and
address-space invalidations. A MADV_PAGEOUT reclaim workload
exercised global flushes. All four scope values were observed.

Confirmed that trace-cmd records the event and that perf can count
it with sufficient privileges. With perf_event_paranoid=0,
unprivileged attempts to count the event using perf were denied,
as intended.

Tested local and shared-mm invalidations with
CONFIG_UBSAN_ALIGNMENT=y on QEMU virt without tracepoint-related
alignment warnings.

Built with and without CONFIG_PERF_EVENTS.

Signed-off-by: Roman 'Hedin' Storozhenko <romeusmeister@gmail.com>
---
Add a RISC-V tracepoint for observing TLB invalidation requests
before they are dispatched by the architecture-specific
implementation.

The generic tlb:tlb_flush event describes TLB flush activity using
reason and page-count information. The RISC-V event records
additional context, including the invalidation range and stride,
ASID, target CPU mask and its weight, and derived request scope.

This context helps correlate TLB invalidation activity with MM,
scheduler, IPI, and firmware activity. The event describes the
request rather than the execution backend. SBI RFENCE versus Linux
cross-CPU coordination is effectively determined at initialization
rather than selected independently for each request.

The target CPU mask weight is derived from the recorded bitmap to
keep both fields consistent under concurrent mm_cpumask() updates.
Since the address field (start) may contain kernel virtual
addresses, the event requires perf tracepoint permissions even
for counting-only access.

Tested on QEMU virt with OpenSBI using local and shared-mm
mprotect()/munmap() workloads. A MADV_PAGEOUT reclaim workload
on QEMU virt with APLIC+IMSIC exercised global flushes. All four
scope values -- single, range, address-space, and all -- were
observed.

Confirmed trace-cmd recording and privileged perf counting.
With perf_event_paranoid=0, unprivileged attempts to count the
event using perf were denied, as intended. The kernel was built
with and without CONFIG_PERF_EVENTS.

Tested local and shared-mm invalidations with
CONFIG_UBSAN_ALIGNMENT=y on QEMU virt without tracepoint-related
alignment warnings.
---
Changes in v7:
- Rename the tracepoint header to asm/tlb_trace.h to make its
  purpose explicit, as suggested by Steven Rostedt.
- Link to v6: https://lore.kernel.org/r/20261018-tlb_tracepoint-v6-1-14476427870f@gmail.com

Changes in v6:
- Change the scope field from u8 to u32 to ensure the dynamic
  CPU mask is properly aligned for bitmap operations.
- Verify local and shared-mm TLB flush tracing with
  CONFIG_UBSAN_ALIGNMENT=y on QEMU virt.
- Link to v5: https://lore.kernel.org/r/20261017-tlb_tracepoint-v5-1-256fb5393a7f@gmail.com

Changes in v5:
- Move the architecture-specific trace event definition under
  arch/riscv/, as requested by Steven Rostedt.
- Calculate target_mask_weight from the recorded CPU mask to
  keep both fields consistent under concurrent updates.
- Require perf tracepoint permissions for counting-only access,
  since the event may expose kernel virtual addresses.
- Link to v4: https://lore.kernel.org/r/20261015-tlb_tracepoint-v4-1-f238a2bd8f7e@gmail.com

Changes in v4:
- Drop unrelated whitespace-only changes in arch/riscv/mm/tlbflush.c.
- Link to v3: https://lore.kernel.org/all/20261015-tlb_tracepoint-v3-1-eef305a3bb63@gmail.com/

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
 arch/riscv/include/asm/tlb_trace.h | 103 +++++++++++++++++++++++++++++++++++++
 arch/riscv/mm/tlbflush.c           |  45 ++++++++++++++--
 2 files changed, 144 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/tlb_trace.h b/arch/riscv/include/asm/tlb_trace.h
new file mode 100644
index 000000000000..60b48eb0d355
--- /dev/null
+++ b/arch/riscv/include/asm/tlb_trace.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM riscv_tlb
+
+#if !defined(_TRACE_RISCV_TLB_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_RISCV_TLB_TRACE_H
+
+#include <linux/cpumask.h>
+#include <linux/tracepoint.h>
+#include <linux/perf_event.h>
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
+		__field(u32, scope)
+	),
+
+	TP_fast_assign(__entry->start = start;
+		__entry->size = size;
+		__entry->stride = stride;
+		__entry->asid = asid;
+		__entry->has_mm = has_mm;
+		__assign_cpumask(target_cpus, cpumask_bits(cmask));
+		__entry->target_mask_weight = cpumask_weight((const struct cpumask *)
+						     __get_cpumask(target_cpus));
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
+#ifdef CONFIG_PERF_EVENTS
+TRACE_EVENT_PERF_PERM(riscv_tlb_flush_request,
+		      perf_allow_tracepoint());
+#endif
+
+#endif /* _TRACE_RISCV_TLB_TRACE_H */
+
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+
+#define TRACE_INCLUDE_PATH asm
+#define TRACE_INCLUDE_FILE tlb_trace
+
+/* This part must be outside protection. */
+#include <trace/define_trace.h>
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 962db300a166..9dcb07fb3ac0 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -9,6 +9,9 @@
 #include <asm/mmu_context.h>
 #include <asm/cpufeature.h>
 
+#define CREATE_TRACE_POINTS
+#include <asm/tlb_trace.h>
+
 #define has_svinval()	riscv_has_extension_unlikely(RISCV_ISA_EXT_SVINVAL)
 
 /*
@@ -63,6 +66,32 @@ void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
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
@@ -70,12 +99,18 @@ static void __ipi_flush_tlb_all(void *info)
 
 void flush_tlb_all(void)
 {
-	if (num_online_cpus() < 2)
+	riscv_tlb_trace_flush_request(cpu_online_mask, 0,
+				      FLUSH_TLB_MAX_SIZE, 0,
+				      FLUSH_TLB_NO_ASID, false);
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
@@ -105,6 +140,8 @@ static void __flush_tlb_range(struct mm_struct *mm,
 
 	cpu = get_cpu();
 
+	riscv_tlb_trace_flush_request(cmask, start, size, stride, asid, !!mm);
+
 	/* Check if the TLB flush needs to be sent to other CPUs. */
 	if (cpumask_any_but(cmask, cpu) >= nr_cpu_ids) {
 		local_flush_tlb_range_asid(start, size, stride, asid);

---
base-commit: a5ae1bf65cee84bcc121d659e7e22a767853f5f5
change-id: 20260829-tlb_tracepoint-844105ab5092

Best regards,
-- 
Roman 'Hedin' Storozhenko <romeusmeister@gmail.com>

