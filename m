Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77ED3B14A7;
	Mon, 22 Jun 2026 13:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782133809; cv=none; b=nnXjg/S8bpiUpMgPbU/afBduV0v7deni96qcyrwj962z+R2N43FS1a2E1pNRQMx4h7aQ1LyWXUAwmNuMOdcyDuezJ/z6NeRM0CitBKGfNoxIEga4SEw+p/3lruE93Y281Lqx1+gnJ47YEZKgPXa9cm0n2CxdSyQPCGoj2CS7Wy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782133809; c=relaxed/simple;
	bh=SkJWOfCYcu/nP2t8JXwhq7xLmCHtDb6djA42F744RQI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=MVVloNSQmuLR45JvV15T6J2uZjFHlyazauK7u+vHgmYKx0OKWaYcJu8YGizx9PJ4mhcPROHpMCviFN5kCEWWTIr+O6QQ9k9pciFTrRBho1JmO0tUgJ9k7WSlVhdgZ+9itpA1uVvA8DlFGlVpAc7AnM2ti78a2MvQAcfgXoPR0dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECJC3f8A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECJC3f8A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCCC1F00A3D;
	Mon, 22 Jun 2026 13:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782133808;
	bh=ri3zuBy2reYJ3ctl13X4k/NJ+OzT/VrxVBI9z2UNsXg=;
	h=Date:From:To:Cc:Subject:References;
	b=ECJC3f8A3PjhrXzxPZ7VyVykMbBK02cyjuFOb7vZun9WRpo3rsqQQ0nnNXUweIDFN
	 XfOwrRNmEFHoAVr82WrbnKVo2IWgC2M+4ZWxA934plTh3cdqKkoBcOBOnygAkCg+pc
	 3lvvp4KSbiY6YLDseYDCyG6XCraqeT6F46qwKOy4l5weVI+iIpogIDKfjaoMvoFZp4
	 R9zd//L2ybxZ3vsTN385sWMWOD8IvP7FDNNSbRIgsAZy4N4jo6zjRKYSpasfXOtOX8
	 EY7m1YUqSPdL+G2H1JkxxGnBuN1zf9mnvvO6ERMV7fewQU+lO44t+AMARfku80WZXy
	 OiUZsxNmsfCZA==
Received: from rostedt by gandalf with local (Exim 4.99.3)
	(envelope-from <rostedt@kernel.org>)
	id 1wbeQ1-000000022gG-3xAd;
	Mon, 22 Jun 2026 09:10:29 -0400
Message-ID: <20260622131029.816825024@kernel.org>
User-Agent: quilt/0.69
Date: Mon, 22 Jun 2026 09:07:41 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 John Ogness <john.ogness@linutronix.de>,
 Thomas Gleixner <tglx@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Julia Lawall <julia.lawall@inria.fr>,
 Yury Norov <yury.norov@gmail.com>
Subject: [PATCH v2 2/2] tracing: Remove trace_printk.h from kernel.h
References: <20260622130739.375198646@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

There have been complaints about trace_printk.h causing more build time
for being in kernel.h. Move it out of kernel.h and place it in the headers
and C files that use it.

Link: https://lore.kernel.org/all/CAHk-=wikCBeVFjVXiY4o-oepdbjAoir5+TcAgtL12c4u1TpZLQ@mail.gmail.com/

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
Changes since v1: https://patch.msgid.link/20260621093811.168514984@kernel.org

- Just remove trace_printk.h and fix up all the places that need it.

 arch/powerpc/kvm/book3s_xics.c         | 1 +
 drivers/gpu/drm/i915/gt/intel_gtt.h    | 1 +
 drivers/gpu/drm/i915/i915_gem.h        | 1 +
 drivers/hwtracing/stm/dummy_stm.c      | 4 ++++
 drivers/infiniband/hw/hfi1/trace_dbg.h | 1 +
 drivers/usb/early/xhci-dbc.c           | 1 +
 fs/ext4/inline.c                       | 1 +
 include/linux/ftrace.h                 | 2 ++
 include/linux/kernel.h                 | 1 -
 include/linux/sunrpc/debug.h           | 1 +
 include/linux/trace_printk.h           | 5 +++--
 kernel/trace/ring_buffer_benchmark.c   | 1 +
 samples/fprobe/fprobe_example.c        | 1 +
 samples/ftrace/ftrace-direct-too.c     | 1 -
 samples/trace_printk/trace-printk.c    | 1 +
 15 files changed, 19 insertions(+), 4 deletions(-)

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
index 1da8fb61c09e..f490052e8964 100644
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
index 38528ffdc0b3..784f9af7ccba 100644
--- a/drivers/hwtracing/stm/dummy_stm.c
+++ b/drivers/hwtracing/stm/dummy_stm.c
@@ -14,6 +14,10 @@
 #include <linux/stm.h>
 #include <uapi/linux/stm.h>
 
+#ifdef DEBUG
+#include <linux/trace_printk.h>
+#endif
+
 static ssize_t notrace
 dummy_stm_packet(struct stm_data *stm_data, unsigned int master,
 		 unsigned int channel, unsigned int packet, unsigned int flags,
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
index 8045e4ff270c..0eff4a0c6a6c 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -934,6 +934,7 @@ static int ext4_da_convert_inline_data_to_extent(struct address_space *mapping,
 }
 
 #ifdef INLINE_DIR_DEBUG
+#include <linux/trace_printk.h>
 void ext4_show_inline_dir(struct inode *dir, struct buffer_head *bh,
 			  void *inline_start, int inline_size)
 {
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 02bc5027523a..b5336a81e619 100644
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
index e5570a16cbb1..e87a40fbd152 100644
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
diff --git a/kernel/trace/ring_buffer_benchmark.c b/kernel/trace/ring_buffer_benchmark.c
index 593e3b59e42e..2bb25caebb75 100644
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


