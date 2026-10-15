Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015523E49F8
	for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Oct 2026 17:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792085596; cv=none; b=pjXlwjilD8RqBBAxXTY/JvqMZq/yjmNwS81+kT7JClL5d7u6FKxHx3X0WVd2h1TLPcXMo/UHlAN5McEwcvCV1uOs0BFQM/TQjU58+1njh6uJSwMpAC3GXCWqe44TI3x6MTU0KlDs7gQ9dZHntaarwSN1mrzPUMXutvYeKdbudJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792085596; c=relaxed/simple;
	bh=EbtRbYfkzqxftsj1ATwAI8L/trBV2EEvYWnj/6D2xAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=n2iqGlxFJu6XviNkRmenNWjzVTSnZvOLaprTniB53lBQzaBDSFgSdddHjcWPjHsZqdDZcXHqjCsa3YIHFKRIe+XbsWyCppUqi0A+7BFod8tn4UR+VLHaYpMZ7Gqm4DbflnxvhkAIxfQp2hO/27xS8M7EO4NogbM1l5Ee1o1/ElY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VksCnDbP; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VksCnDbP"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1ad2e2391so24490945e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Oct 2026 10:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792085580; x=1792690380; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hfS4i/rzUhR1QpD5vU/ZKJA86E8V1d35N5VskjSOuTw=;
        b=VksCnDbPiLtPpHpDWcP+3ISYEB9GznRR3VbClLplrAv4lIKtLiADO2F+zPA6jPnXEu
         HLoG+tDDEynKDQyTgt6HgsBdyWuI1jD4Y7Ln/DvUf643ThTVvQ0uGy4XTH/VOxLhNL7K
         MbUU1iCGwtHgrF/i6RJoEQIuv5v7RAYCWH8aE+WZEMTUPNHujBHT2YWSQfnW5nDju5ig
         bJQRU7nt9Xu3IveYKWHxH6wUjz35n5XTPWUcHPDwZAxQlk2jqp5MY7I7j21D6fCHQp8R
         MhpxFeS7KqDPaxNZ2XuXwL4FkuEUCxGCHgVjtz7I5pIdepBXCy+zO1noYvdKpmIG1FUn
         VVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792085580; x=1792690380;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=hfS4i/rzUhR1QpD5vU/ZKJA86E8V1d35N5VskjSOuTw=;
        b=YXSI8XvljY16HKyTjCRko+fPsHZT4NUOa6BdTIV/Fq4oU20XrilZrGntG7+qXgpQSo
         HJnLgY4EmalFezHGs3hgDX5WCEYu0GROF/+5d9rdNrePHVy16FS3u4IcIMQTmWM3kbct
         rk8+fiq+FYxVR9EvvhK6Gf7Pm1ffkYHGbGV+sWdDgr1IGxBnz8TB547kFSKgvgiop5zV
         UQ+j+o/3T95rV52teya5nEyhGwYcIJGdQYVkIZWpqHl6g5F19nntqQ2oNGSmVM3oLbzi
         XR2oevquymB7ed6DWWW7DbF3nzCpQnoJTrlS/HdyjABQsq1SQna8n55N9dTDjUmM6qj9
         6hqw==
X-Forwarded-Encrypted: i=1; AKwUvBwpC5CWt8eEqSkbG5n2HdJ/TiMlt0wmwDuxqD8p95+5H65021mNX45AcqKLemg1OqTuV42JBCx2z95aC8Xp4kzUUzM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLCSg0TkpkoEKVG8m+LsJ/KZC193COuEsA20NKwJiqQZMPC9tty
	XVQdvf3XJz4PbBxwxt4cFuu1Wap1w37kg90n7ppNWz47fpiIDaS0tTWx
X-Gm-Gg: AYBFou0B4RzfgBF0SGb9F6sPgEYhKtIma8LRkv3y8J4jzR0khZSTqbJH0/f4XDlpijE
	kkckO+1e8JtosZcJ+Ky+1c5pQRH42FhyHeg2IzrL9Ck+HZn+DSObLCqjdqc3sEju4xys2HtwZTy
	xSk6FZUjdWz3WVOQRhIFpvSBl0wQnGt8FkCnqNDP27nnJBTm9CzgU4bf0DNBxobGVUW8V6ZUb59
	tHDQpuMxxb7i4PtVjNtUFdBCnr9t/WqeWbehVQsyFr1HRD5rrVhrhWER2ko65Puwz05YUMVvkem
	gjClue91Xaoqi7+dVFuwU+f4OVbyAvtzYZmUPc5wlMfxyxNa5oxxdQw60T0hD+ESiSK4uFbxQOp
	jEfi3NSkgyLVOs28GM+Mf/8GDmBcwo7X2VtHvHryGfrqpLhIB7K9fz06yT0AnaVTzH5uEipdLhn
	doJae/9krSHMNvmLRbYAoUylhcVk+4oLs9p9XuZrBHk9lxRK6HqOhzbqUwaqX5AO+mDwsE1sWIg
	O2U0dUfiZTGbPfJjUh7Ry/ztreKyrlXZoGksok3n8h9
X-Received: by 2002:a05:600c:5493:b0:4a1:78da:d271 with SMTP id 5b1f17b1804b1-4a18e4ee976mr431273625e9.30.1792085579586;
        Thu, 15 Oct 2026 10:32:59 -0700 (PDT)
Received: from [127.0.1.1] (89-65-152-218.dynamic.play.pl. [89.65.152.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0aaabc3sm20283060f8f.16.2026.10.15.10.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 10:32:58 -0700 (PDT)
From: Roman 'Hedin' Storozhenko <romeusmeister@gmail.com>
Date: Thu, 15 Oct 2026 19:32:34 +0200
Subject: [PATCH v4] riscv: mm: Trace TLB flush requests
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-tlb_tracepoint-v4-1-f238a2bd8f7e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XPSwqDMBSF4a1Ixk3JU21H3UcpJY+rBtRIItIi7
 r3RQZFKh+fC98OdUYTgIKJrNqMAk4vO92mIU4ZMo/oasLNpI0ZYTkp2wWOrn2NQBgbv+hGXQlA
 ilZbkwlBCQ4DKvbbg/ZF24+Low3vrT3S9/k1NFFNsK6vAQgGFoLe6U649G9+hNTWxHefkwFniw
 E1ZGiZsJfUv519OCZUHzlcOFU/fcK1zvufLsnwAr0DJPSoBAAA=
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
 arch/riscv/mm/tlbflush.c         | 45 ++++++++++++++++++--
 include/trace/events/riscv_tlb.h | 90 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 131 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 962db300a166..81b2bcf01039 100644
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
@@ -105,6 +140,8 @@ static void __flush_tlb_range(struct mm_struct *mm,
 
 	cpu = get_cpu();
 
+	riscv_tlb_trace_flush_request(cmask, start, size, stride, asid, !!mm);
+
 	/* Check if the TLB flush needs to be sent to other CPUs. */
 	if (cpumask_any_but(cmask, cpu) >= nr_cpu_ids) {
 		local_flush_tlb_range_asid(start, size, stride, asid);
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

