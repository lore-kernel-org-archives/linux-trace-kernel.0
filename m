Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4976368287;
	Wed, 11 Mar 2026 01:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773192752; cv=none; b=Cg7dW04Mh1XfrfagQzWJwR7i6EFBcg2M3PSc30OwfYiKDg6J9X3D8OpacdHzA1T/AtiiGodc6v4R4gJwJgYEA6MbiDQRKnlPe9Fr8xHsE3vocJMImcFjJsbQJ3PRHOtWM6g02mnHl374/fA6+2B2epBrQPW7UltAh54mcG454SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773192752; c=relaxed/simple;
	bh=UiDXzri1KFHRkt1208LSzwrao1oxJBMaTRv4ukCmc38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OdytWLG14+hmOaaTOzB85b8JpY5rkHp85AvwbvIgFTYUAc/5moKj6ZgvpQLgbqEgBlJEHfb/FZegV48/+LcSNktu9Z7hU0Of0uoJbRzE5lkeyuxx8YH0cK9FzqJtGQjM76XMTEcw2d6nE3b9xgTBoRvHp9c9ZRRo5ujvKDc89So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdJXTc8g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdJXTc8g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3935C19423;
	Wed, 11 Mar 2026 01:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773192751;
	bh=UiDXzri1KFHRkt1208LSzwrao1oxJBMaTRv4ukCmc38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qdJXTc8g4lPwqubwL2ol87ZTF6akLqYHdRyu9CiLhgJU3J0MEUKXeYJq3RvA1Y9U8
	 /SQtN6X/DmZ/eUJrlVS+Nb6Yv/MGHQDcG85bucg8cQTBFeny9nSVBjOtq1yP8IFb0u
	 YJY2dJhqdsAkxFXEPmmWKcvW8rRqyQiOR91JmimJUOkQgRbFJzzDdPXX1y1U0AcD0B
	 GM9wXbsDpu0L0tcqUcErEbdXwZ5uwR+nSglMCYUBWd9kmtkrbGd4HKHid7xpfMqgBO
	 GjjL76XUeqo7dA6s9oxlMDaTqYRTqIHrQjigf3j1UEvUJ1L9o9+8l5pt29PBYn1vPc
	 W4p5y0YpTWMFQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Ian Rogers <irogers@google.com>
Subject: [PATCH v9 2/4] ring-buffer: Flush and stop persistent ring buffer on panic
Date: Wed, 11 Mar 2026 10:32:29 +0900
Message-ID:  <177319274904.130641.3303707869402603363.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To:  <177319273059.130641.10882692460536780093.stgit@mhiramat.tok.corp.google.com>
References:  <177319273059.130641.10882692460536780093.stgit@mhiramat.tok.corp.google.com>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

On real hardware, panic and machine reboot may not flush hardware cache
to memory. This means the persistent ring buffer, which relies on a
coherent state of memory, may not have its events written to the buffer
and they may be lost. Moreover, there may be inconsistency with the
counters which are used for validation of the integrity of the
persistent ring buffer which may cause all data to be discarded.

To avoid this issue, stop recording of the ring buffer on panic and
flush the cache of the ring buffer's memory.

Fixes: e645535a954a ("tracing: Add option to use memmapped memory for trace boot instance")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v9:
   - Fix typo of & to &&.
   - Fix typo of "Generic"
 Changes in v6:
   - Introduce asm/ring_buffer.h for arch_ring_buffer_flush_range().
   - Use flush_cache_vmap() instead of flush_cache_all().
 Changes in v5:
   - Use ring_buffer_record_off() instead of ring_buffer_record_disable().
   - Use flush_cache_all() to ensure flush all cache.
 Changes in v3:
   - update patch description.
---
 arch/alpha/include/asm/Kbuild        |    1 +
 arch/arc/include/asm/Kbuild          |    1 +
 arch/arm/include/asm/Kbuild          |    1 +
 arch/arm64/include/asm/ring_buffer.h |   10 ++++++++++
 arch/csky/include/asm/Kbuild         |    1 +
 arch/hexagon/include/asm/Kbuild      |    1 +
 arch/loongarch/include/asm/Kbuild    |    1 +
 arch/m68k/include/asm/Kbuild         |    1 +
 arch/microblaze/include/asm/Kbuild   |    1 +
 arch/mips/include/asm/Kbuild         |    1 +
 arch/nios2/include/asm/Kbuild        |    1 +
 arch/openrisc/include/asm/Kbuild     |    1 +
 arch/parisc/include/asm/Kbuild       |    1 +
 arch/powerpc/include/asm/Kbuild      |    1 +
 arch/riscv/include/asm/Kbuild        |    1 +
 arch/s390/include/asm/Kbuild         |    1 +
 arch/sh/include/asm/Kbuild           |    1 +
 arch/sparc/include/asm/Kbuild        |    1 +
 arch/um/include/asm/Kbuild           |    1 +
 arch/x86/include/asm/Kbuild          |    1 +
 arch/xtensa/include/asm/Kbuild       |    1 +
 include/asm-generic/ring_buffer.h    |   13 +++++++++++++
 kernel/trace/ring_buffer.c           |   22 ++++++++++++++++++++++
 23 files changed, 65 insertions(+)
 create mode 100644 arch/arm64/include/asm/ring_buffer.h
 create mode 100644 include/asm-generic/ring_buffer.h

diff --git a/arch/alpha/include/asm/Kbuild b/arch/alpha/include/asm/Kbuild
index 483965c5a4de..b154b4e3dfa8 100644
--- a/arch/alpha/include/asm/Kbuild
+++ b/arch/alpha/include/asm/Kbuild
@@ -5,4 +5,5 @@ generic-y += agp.h
 generic-y += asm-offsets.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
+generic-y += ring_buffer.h
 generic-y += text-patching.h
diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild
index 4c69522e0328..483caacc6988 100644
--- a/arch/arc/include/asm/Kbuild
+++ b/arch/arc/include/asm/Kbuild
@@ -5,5 +5,6 @@ generic-y += extable.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
 generic-y += parport.h
+generic-y += ring_buffer.h
 generic-y += user.h
 generic-y += text-patching.h
diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index 03657ff8fbe3..decad5f2c826 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -3,6 +3,7 @@ generic-y += early_ioremap.h
 generic-y += extable.h
 generic-y += flat.h
 generic-y += parport.h
+generic-y += ring_buffer.h
 
 generated-y += mach-types.h
 generated-y += unistd-nr.h
diff --git a/arch/arm64/include/asm/ring_buffer.h b/arch/arm64/include/asm/ring_buffer.h
new file mode 100644
index 000000000000..62316c406888
--- /dev/null
+++ b/arch/arm64/include/asm/ring_buffer.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_ARM64_RING_BUFFER_H
+#define _ASM_ARM64_RING_BUFFER_H
+
+#include <asm/cacheflush.h>
+
+/* Flush D-cache on persistent ring buffer */
+#define arch_ring_buffer_flush_range(start, end)	dcache_clean_pop(start, end)
+
+#endif /* _ASM_ARM64_RING_BUFFER_H */
diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuild
index 3a5c7f6e5aac..7dca0c6cdc84 100644
--- a/arch/csky/include/asm/Kbuild
+++ b/arch/csky/include/asm/Kbuild
@@ -9,6 +9,7 @@ generic-y += qrwlock.h
 generic-y += qrwlock_types.h
 generic-y += qspinlock.h
 generic-y += parport.h
+generic-y += ring_buffer.h
 generic-y += user.h
 generic-y += vmlinux.lds.h
 generic-y += text-patching.h
diff --git a/arch/hexagon/include/asm/Kbuild b/arch/hexagon/include/asm/Kbuild
index 1efa1e993d4b..0f887d4238ed 100644
--- a/arch/hexagon/include/asm/Kbuild
+++ b/arch/hexagon/include/asm/Kbuild
@@ -5,4 +5,5 @@ generic-y += extable.h
 generic-y += iomap.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
+generic-y += ring_buffer.h
 generic-y += text-patching.h
diff --git a/arch/loongarch/include/asm/Kbuild b/arch/loongarch/include/asm/Kbuild
index 9034b583a88a..7e92957baf6a 100644
--- a/arch/loongarch/include/asm/Kbuild
+++ b/arch/loongarch/include/asm/Kbuild
@@ -10,5 +10,6 @@ generic-y += qrwlock.h
 generic-y += user.h
 generic-y += ioctl.h
 generic-y += mmzone.h
+generic-y += ring_buffer.h
 generic-y += statfs.h
 generic-y += text-patching.h
diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index b282e0dd8dc1..62543bf305ff 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -3,5 +3,6 @@ generated-y += syscall_table.h
 generic-y += extable.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
+generic-y += ring_buffer.h
 generic-y += spinlock.h
 generic-y += text-patching.h
diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
index 7178f990e8b3..0030309b47ad 100644
--- a/arch/microblaze/include/asm/Kbuild
+++ b/arch/microblaze/include/asm/Kbuild
@@ -5,6 +5,7 @@ generic-y += extable.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
 generic-y += parport.h
+generic-y += ring_buffer.h
 generic-y += syscalls.h
 generic-y += tlb.h
 generic-y += user.h
diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index 684569b2ecd6..9771c3d85074 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -12,5 +12,6 @@ generic-y += mcs_spinlock.h
 generic-y += parport.h
 generic-y += qrwlock.h
 generic-y += qspinlock.h
+generic-y += ring_buffer.h
 generic-y += user.h
 generic-y += text-patching.h
diff --git a/arch/nios2/include/asm/Kbuild b/arch/nios2/include/asm/Kbuild
index 28004301c236..0a2530964413 100644
--- a/arch/nios2/include/asm/Kbuild
+++ b/arch/nios2/include/asm/Kbuild
@@ -5,6 +5,7 @@ generic-y += cmpxchg.h
 generic-y += extable.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
+generic-y += ring_buffer.h
 generic-y += spinlock.h
 generic-y += user.h
 generic-y += text-patching.h
diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index cef49d60d74c..8aa34621702d 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -8,4 +8,5 @@ generic-y += spinlock_types.h
 generic-y += spinlock.h
 generic-y += qrwlock_types.h
 generic-y += qrwlock.h
+generic-y += ring_buffer.h
 generic-y += user.h
diff --git a/arch/parisc/include/asm/Kbuild b/arch/parisc/include/asm/Kbuild
index 4fb596d94c89..d48d158f7241 100644
--- a/arch/parisc/include/asm/Kbuild
+++ b/arch/parisc/include/asm/Kbuild
@@ -4,4 +4,5 @@ generated-y += syscall_table_64.h
 generic-y += agp.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
+generic-y += ring_buffer.h
 generic-y += user.h
diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
index 2e23533b67e3..805b5aeebb6f 100644
--- a/arch/powerpc/include/asm/Kbuild
+++ b/arch/powerpc/include/asm/Kbuild
@@ -5,4 +5,5 @@ generated-y += syscall_table_spu.h
 generic-y += agp.h
 generic-y += mcs_spinlock.h
 generic-y += qrwlock.h
+generic-y += ring_buffer.h
 generic-y += early_ioremap.h
diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index bd5fc9403295..7721b63642f4 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -14,5 +14,6 @@ generic-y += ticket_spinlock.h
 generic-y += qrwlock.h
 generic-y += qrwlock_types.h
 generic-y += qspinlock.h
+generic-y += ring_buffer.h
 generic-y += user.h
 generic-y += vmlinux.lds.h
diff --git a/arch/s390/include/asm/Kbuild b/arch/s390/include/asm/Kbuild
index 80bad7de7a04..0c1fc47c3ba0 100644
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -7,3 +7,4 @@ generated-y += unistd_nr.h
 generic-y += asm-offsets.h
 generic-y += mcs_spinlock.h
 generic-y += mmzone.h
+generic-y += ring_buffer.h
diff --git a/arch/sh/include/asm/Kbuild b/arch/sh/include/asm/Kbuild
index 4d3f10ed8275..f0403d3ee8ab 100644
--- a/arch/sh/include/asm/Kbuild
+++ b/arch/sh/include/asm/Kbuild
@@ -3,4 +3,5 @@ generated-y += syscall_table.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
 generic-y += parport.h
+generic-y += ring_buffer.h
 generic-y += text-patching.h
diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index 17ee8a273aa6..49c6bb326b75 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -4,4 +4,5 @@ generated-y += syscall_table_64.h
 generic-y += agp.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
+generic-y += ring_buffer.h
 generic-y += text-patching.h
diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index 1b9b82bbe322..2a1629ba8140 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -17,6 +17,7 @@ generic-y += module.lds.h
 generic-y += parport.h
 generic-y += percpu.h
 generic-y += preempt.h
+generic-y += ring_buffer.h
 generic-y += runtime-const.h
 generic-y += softirq_stack.h
 generic-y += switch_to.h
diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
index 4566000e15c4..078fd2c0d69d 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -14,3 +14,4 @@ generic-y += early_ioremap.h
 generic-y += fprobe.h
 generic-y += mcs_spinlock.h
 generic-y += mmzone.h
+generic-y += ring_buffer.h
diff --git a/arch/xtensa/include/asm/Kbuild b/arch/xtensa/include/asm/Kbuild
index 13fe45dea296..e57af619263a 100644
--- a/arch/xtensa/include/asm/Kbuild
+++ b/arch/xtensa/include/asm/Kbuild
@@ -6,5 +6,6 @@ generic-y += mcs_spinlock.h
 generic-y += parport.h
 generic-y += qrwlock.h
 generic-y += qspinlock.h
+generic-y += ring_buffer.h
 generic-y += user.h
 generic-y += text-patching.h
diff --git a/include/asm-generic/ring_buffer.h b/include/asm-generic/ring_buffer.h
new file mode 100644
index 000000000000..930d96571f23
--- /dev/null
+++ b/include/asm-generic/ring_buffer.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Generic arch dependent ring_buffer macros.
+ */
+#ifndef __ASM_GENERIC_RING_BUFFER_H__
+#define __ASM_GENERIC_RING_BUFFER_H__
+
+#include <linux/cacheflush.h>
+
+/* Flush cache on ring buffer range if needed */
+#define arch_ring_buffer_flush_range(start, end)	flush_cache_vmap(start, end)
+
+#endif /* __ASM_GENERIC_RING_BUFFER_H__ */
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 353a5aa1b612..9f4ee9e3803d 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6,6 +6,7 @@
  */
 #include <linux/sched/isolation.h>
 #include <linux/trace_recursion.h>
+#include <linux/panic_notifier.h>
 #include <linux/trace_events.h>
 #include <linux/ring_buffer.h>
 #include <linux/trace_clock.h>
@@ -30,6 +31,7 @@
 #include <linux/oom.h>
 #include <linux/mm.h>
 
+#include <asm/ring_buffer.h>
 #include <asm/local64.h>
 #include <asm/local.h>
 #include <asm/setup.h>
@@ -589,6 +591,7 @@ struct trace_buffer {
 
 	unsigned long			range_addr_start;
 	unsigned long			range_addr_end;
+	struct notifier_block		flush_nb;
 
 	struct ring_buffer_meta		*meta;
 
@@ -2471,6 +2474,16 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 	kfree(cpu_buffer);
 }
 
+/* Stop recording on a persistent buffer and flush cache if needed. */
+static int rb_flush_buffer_cb(struct notifier_block *nb, unsigned long event, void *data)
+{
+	struct trace_buffer *buffer = container_of(nb, struct trace_buffer, flush_nb);
+
+	ring_buffer_record_off(buffer);
+	arch_ring_buffer_flush_range(buffer->range_addr_start, buffer->range_addr_end);
+	return NOTIFY_DONE;
+}
+
 static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 					 int order, unsigned long start,
 					 unsigned long end,
@@ -2590,6 +2603,12 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 
 	mutex_init(&buffer->mutex);
 
+	/* Persistent ring buffer needs to flush cache before reboot. */
+	if (start && end) {
+		buffer->flush_nb.notifier_call = rb_flush_buffer_cb;
+		atomic_notifier_chain_register(&panic_notifier_list, &buffer->flush_nb);
+	}
+
 	return_ptr(buffer);
 
  fail_free_buffers:
@@ -2677,6 +2696,9 @@ ring_buffer_free(struct trace_buffer *buffer)
 {
 	int cpu;
 
+	if (buffer->range_addr_start && buffer->range_addr_end)
+		atomic_notifier_chain_unregister(&panic_notifier_list, &buffer->flush_nb);
+
 	cpuhp_state_remove_instance(CPUHP_TRACE_RB_PREPARE, &buffer->node);
 
 	irq_work_sync(&buffer->irq_work.work);

