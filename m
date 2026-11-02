Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793651049;
	b=IZLwEV1xupB9OJsJqUAQRQE0EF6GfZ7EB730is/haIP5YweWIKPyJV15Tgwj3qaoa9qx
	 jbTON8oLdzkJvnxeCI3eRPDNOidVtEfugd3g6qTQL8VfUkv7WlqjOmXdeQ4EywSARtkdr
	 r8KajWWfeeewrnEuC9aVVAz0SPNHQDjlBknljHVzTPlSe83o8EFZzDlyjdgTqYGd6UY2U
	 6FEbkasyyd+zaGA/EXWP+2/f7HTfG2ClVBoZa3C8rQYEjiu/ay0pqRKVchZmSoq5eGwpc
	 8xnq0Mytdh34DLRpokbff2vyWW17kOwx2n/BtyCDKOqx07THNohGJUARoc1OekHJfZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793651049;
	h=Received:DKIM-Signature:Received:Message-ID:User-Agent:Date:From:To:
	 Cc:Subject:References:MIME-Version:Content-Type;
	bh=kGaBSFfygp2KLF/FbPT03oFZs85ctzjg+xo56SHnGDU=;
	b=tFDkPhjY3WhmNGm8PlJ749OkIt68ySok8q0rIci/151Cqnkk/jGg2ObYFacp5TH3514T
	 RdC7Rp4UpHx++ZTry38ag+GjKMDg6uHz08m/xWgy9RRhVws2+o22yMCsKvz5vclXhtj+W
	 PgLJSOEdrbE8lNrno8+VH6g5K4osDF5CB3LGe4MnenMDPmbliqZiOz9kd5LW3x4MYsDTZ
	 7j0wpiGI+8hsYFG9+jmv38Gh8B5aslqFsQW/gCqOhIPqIDtu+qL/GxCOC1acy5z4J37LR
	 pN3X5wQT4HdOc/D05olsXAqP42u8usWNlFcWPQARTtMf/6G8CBk2KrEAPFpJimTIf+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jvVu9QQ4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD81E606A331;
	Mon,  2 Nov 2026 20:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jvVu9QQ4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0CB1F00A18;
	Mon,  2 Nov 2026 20:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793651048;
	bh=kGaBSFfygp2KLF/FbPT03oFZs85ctzjg+xo56SHnGDU=;
	h=Date:From:To:Cc:Subject:References;
	b=jvVu9QQ449o5laOD3+8lFEGLFdbgl4ZfRYfwX91U2ufiNz5tGLsNthPmQZGBA4TG+
	 8zQ6H5cr9TiRkn1cDE9anic8efHmviygxTLwLcIBMfWUXArYhSlyWBdQL96eOLgHHe
	 gXbr0eNM+79CqBoKe9DHN+QI35fmjm/nQvMVMtPMlruYGqGGfK3FfD4idjLsuBnk8k
	 Kqi94ir2gaUjEAkHtqXnDcHDWWeb1YeopXP4xkQ1zt8syPofAPHbLGPBNy1A1Nxq71
	 gBS4ZizHypuBQi2FkXCMzOtdU5iXREHR6ZKS29j7gticjzNjUq/LHyiVH3h/XMY4QB
	 9hXcl0s/nd/VQ==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xNyZb-0000000DJtu-3sgI;
	Mon, 02 Nov 2026 15:24:07 -0500
Message-ID: <20261102202407.732929894@kernel.org>
User-Agent: quilt/0.69
Date: Mon, 02 Nov 2026 15:23:23 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Yury Norov <yury.norov@gmail.com>,
 Yury Norov <ynorov@nvidia.com>
Subject: [PATCH 3/3] tracing: Remove trace_printk.h from kernel.h
References: <20261102202320.574701415@kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

There have been complaints about trace_printk.h causing more build time
for being in kernel.h if it changes. There is also an effort to clean up
kernel.h to have it not include unneeded header files. Move trace_printk.h
out of kernel.h and place it in the headers and C files that use it.

Link: https://lore.kernel.org/all/CAHk-=wikCBeVFjVXiY4o-oepdbjAoir5+TcAgtL12c4u1TpZLQ@mail.gmail.com/

Suggested-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Yury Norov <ynorov@nvidia.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/powerpc/kvm/book3s_xics.c         | 1 +
 drivers/gpu/drm/i915/gt/intel_gtt.h    | 1 +
 drivers/gpu/drm/i915/i915_gem.h        | 1 +
 drivers/hwtracing/stm/dummy_stm.c      | 1 +
 drivers/infiniband/hw/hfi1/trace_dbg.h | 1 +
 drivers/usb/early/xhci-dbc.c           | 1 +
 fs/ext4/inline.c                       | 1 +
 include/linux/ftrace.h                 | 2 ++
 include/linux/kernel.h                 | 1 -
 include/linux/sunrpc/debug.h           | 1 +
 include/linux/trace_printk.h           | 5 +++--
 include/trace/trace_events.h           | 2 ++
 kernel/trace/ring_buffer_benchmark.c   | 1 +
 samples/fprobe/fprobe_example.c        | 1 +
 samples/ftrace/ftrace-direct-too.c     | 1 -
 samples/trace_printk/trace-printk.c    | 1 +
 16 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_xics.c b/arch/powerpc/kvm/book3s_xics.c
index 74a44fa702b0..ef5eb596a56e 100644
--- a/arch/powerpc/kvm/book3s_xics.c
+++ b/arch/powerpc/kvm/book3s_xics.c
@@ -26,6 +26,7 @@
 #if 1
 #define XICS_DBG(fmt...) do { } while (0)
 #else
+#include <linux/trace_printk.h>
 #define XICS_DBG(fmt...) trace_printk(fmt)
 #endif
 
diff --git a/drivers/gpu/drm/i915/gt/intel_gtt.h b/drivers/gpu/drm/i915/gt/intel_gtt.h
index b54ee4f25af1..f6f223090760 100644
--- a/drivers/gpu/drm/i915/gt/intel_gtt.h
+++ b/drivers/gpu/drm/i915/gt/intel_gtt.h
@@ -35,6 +35,7 @@
 #define I915_GFP_ALLOW_FAIL (GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN)
 
 #if IS_ENABLED(CONFIG_DRM_I915_TRACE_GTT)
+#include <linux/trace_printk.h>
 #define GTT_TRACE(...) trace_printk(__VA_ARGS__)
 #else
 #define GTT_TRACE(...)
diff --git a/drivers/gpu/drm/i915/i915_gem.h b/drivers/gpu/drm/i915/i915_gem.h
index 5ec2ac13a5f0..a616ced060bf 100644
--- a/drivers/gpu/drm/i915/i915_gem.h
+++ b/drivers/gpu/drm/i915/i915_gem.h
@@ -117,6 +117,7 @@ int i915_gem_open(struct drm_i915_private *i915, struct drm_file *file);
 
 #if IS_ENABLED(CONFIG_DRM_I915_TRACE_GEM)
 #include <linux/trace_controls.h>
+#include <linux/trace_printk.h>
 #define GEM_TRACE(...) trace_printk(__VA_ARGS__)
 #define GEM_TRACE_ERR(...) do {						\
 	pr_err(__VA_ARGS__);						\
diff --git a/drivers/hwtracing/stm/dummy_stm.c b/drivers/hwtracing/stm/dummy_stm.c
index 38528ffdc0b3..7c5e48ebfb9f 100644
--- a/drivers/hwtracing/stm/dummy_stm.c
+++ b/drivers/hwtracing/stm/dummy_stm.c
@@ -8,6 +8,7 @@
  */
 
 #undef DEBUG
+#include <linux/trace_printk.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
diff --git a/drivers/infiniband/hw/hfi1/trace_dbg.h b/drivers/infiniband/hw/hfi1/trace_dbg.h
index 58304b91380f..30df5e246586 100644
--- a/drivers/infiniband/hw/hfi1/trace_dbg.h
+++ b/drivers/infiniband/hw/hfi1/trace_dbg.h
@@ -103,6 +103,7 @@ __hfi1_trace_def(IOCTL);
  */
 
 #ifdef HFI1_EARLY_DBG
+#include <linux/trace_printk.h>
 #define hfi1_dbg_early(fmt, ...) \
 	trace_printk(fmt, ##__VA_ARGS__)
 #else
diff --git a/drivers/usb/early/xhci-dbc.c b/drivers/usb/early/xhci-dbc.c
index 41118bba9197..955c73bd601f 100644
--- a/drivers/usb/early/xhci-dbc.c
+++ b/drivers/usb/early/xhci-dbc.c
@@ -30,6 +30,7 @@ static struct xdbc_state xdbc;
 static bool early_console_keep;
 
 #ifdef XDBC_TRACE
+#include <linux/trace_printk.h>
 #define	xdbc_trace	trace_printk
 #else
 static inline void xdbc_trace(const char *fmt, ...) { }
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index ceee69a66482..8af80d342ecd 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -943,6 +943,7 @@ static int ext4_da_convert_inline_data_to_extent(struct address_space *mapping,
 }
 
 #ifdef INLINE_DIR_DEBUG
+#include <linux/trace_printk.h>
 void ext4_show_inline_dir(struct inode *dir, struct buffer_head *bh,
 			  void *inline_start, int inline_size)
 {
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index b041d9142d2b..41b9bd82ed26 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -8,6 +8,8 @@
 #define _LINUX_FTRACE_H
 
 #include <linux/trace_recursion.h>
+#include <linux/trace_controls.h>
+#include <linux/trace_printk.h>
 #include <linux/trace_clock.h>
 #include <linux/jump_label.h>
 #include <linux/kallsyms.h>
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 4b11d1dc0a67..be890c00802a 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -31,7 +31,6 @@
 #include <linux/build_bug.h>
 #include <linux/sprintf.h>
 #include <linux/static_call_types.h>
-#include <linux/trace_printk.h>
 #include <linux/util_macros.h>
 #include <linux/wordpart.h>
 
diff --git a/include/linux/sunrpc/debug.h b/include/linux/sunrpc/debug.h
index ab61bed2f7af..7524f5d82fba 100644
--- a/include/linux/sunrpc/debug.h
+++ b/include/linux/sunrpc/debug.h
@@ -29,6 +29,7 @@ extern unsigned int		nlm_debug;
 # define ifdebug(fac)		if (unlikely(rpc_debug & RPCDBG_##fac))
 
 # if IS_ENABLED(CONFIG_SUNRPC_DEBUG_TRACE)
+#  include <linux/trace_printk.h>
 #  define __sunrpc_printk(fmt, ...)	trace_printk(fmt, ##__VA_ARGS__)
 # else
 #  define __sunrpc_printk(fmt, ...)	printk(KERN_DEFAULT fmt, ##__VA_ARGS__)
diff --git a/include/linux/trace_printk.h b/include/linux/trace_printk.h
index a488ea9e9f85..74ce4f8995c4 100644
--- a/include/linux/trace_printk.h
+++ b/include/linux/trace_printk.h
@@ -1,11 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _LINUX_TRACE_PRINTK_H
 #define _LINUX_TRACE_PRINTK_H
+#if !defined(__ASSEMBLY__) && !defined(__GENKSYMS__) && !defined(BUILD_VDSO)
 
-#include <linux/compiler_attributes.h>
 #include <linux/instruction_pointer.h>
 #include <linux/stddef.h>
 #include <linux/stringify.h>
+#include <linux/stdarg.h>
 
 #ifdef CONFIG_TRACING
 static inline __printf(1, 2)
@@ -147,5 +148,5 @@ ftrace_vprintk(const char *fmt, va_list ap)
 	return 0;
 }
 #endif /* CONFIG_TRACING */
-
+#endif /* !defined(__ASSEMBLY__) && !defined(__GENKSYMS__) && !defined(BUILD_VDSO) */
 #endif
diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 93011f800d0f..e53273cce141 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -18,7 +18,9 @@
  * in the structure.
  */
 
+#include <linux/trace_controls.h>
 #include <linux/trace_events.h>
+#include <linux/trace_printk.h>
 #include <linux/btf_ids.h>
 
 #ifndef TRACE_SYSTEM_VAR
diff --git a/kernel/trace/ring_buffer_benchmark.c b/kernel/trace/ring_buffer_benchmark.c
index c3d34c0e64e2..61df7861b025 100644
--- a/kernel/trace/ring_buffer_benchmark.c
+++ b/kernel/trace/ring_buffer_benchmark.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2009 Steven Rostedt <srostedt@redhat.com>
  */
 #include <linux/ring_buffer.h>
+#include <linux/trace_printk.h>
 #include <linux/completion.h>
 #include <linux/kthread.h>
 #include <uapi/linux/sched/types.h>
diff --git a/samples/fprobe/fprobe_example.c b/samples/fprobe/fprobe_example.c
index bfe98ce826f3..de81b9b4ca7d 100644
--- a/samples/fprobe/fprobe_example.c
+++ b/samples/fprobe/fprobe_example.c
@@ -12,6 +12,7 @@
 
 #define pr_fmt(fmt) "%s: " fmt, __func__
 
+#include <linux/trace_printk.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/fprobe.h>
diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
index bf2411aa6fd7..159190f4103f 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/module.h>
-
 #include <linux/mm.h> /* for handle_mm_fault() */
 #include <linux/ftrace.h>
 #if !defined(CONFIG_ARM64) && !defined(CONFIG_PPC32)
diff --git a/samples/trace_printk/trace-printk.c b/samples/trace_printk/trace-printk.c
index cfc159580263..ff37aeb8523e 100644
--- a/samples/trace_printk/trace-printk.c
+++ b/samples/trace_printk/trace-printk.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <linux/trace_printk.h>
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <linux/irq_work.h>
-- 
2.53.0
