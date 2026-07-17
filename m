Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17FF3E6DE3
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Jul 2026 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784293564; cv=none; b=dq4wuXVMV+Pjga9E8sxVV09I99364hCVzf457vGvXD2iUC7QjbjIxBEY5pg8qyNXr8VdcI/Q0LVmKhIzVf9+NpXZUGyZEDQeMeA+MuVYyP42BzmXzHULzysKSwhmSlZ8SIbVEOJGh+gScG9FWrJ5v7LUlquuZhcOALRZuJkBW1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784293564; c=relaxed/simple;
	bh=VzFZN7zkXZafCAxmduqjsB434NPBXO3a9Es9wEA/9Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HYmHtCWKV8KgPe0N15qb7qxHydvbHKYeFaYkbWsJlPVcK3rFEmpmk5bXhSfiPiyBWMJPmE7imEKiwqF4f5eVJr8t8AaEJIN77mo5DMURcH1pbRbfOtu9q8Vw6XmWOhOnH/AB9PU/UCGEZOM9HWzTXdDyYOhEVHexQE69X4LzOkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ada7Icpn; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ada7Icpn"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3811f512167so8024173a91.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Jul 2026 06:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784293562; x=1784898362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gLUXizPmm8lFk+lVj4kGKhusb/cUxotlJSZc5i0VZQA=;
        b=ada7IcpnkGVsqhB/TlkBnKLL+5bJV8WIIvV0hO583H5onfkTo01xleJ4Ii/+401AcJ
         DY9dhhJlHq0u9XqwUIYWl2FcCGjnrPbGTF8P0dUECZcGQStv8CmYj/QSx18G14sgahSg
         NKeFuke9QB7rJdHztqi+55IRJ5mhHF7ySSXshQ89YH4wP1dtp1gjT8JzC/ACeUzrWA40
         XGQVIh+szyQeDAjXsx3miu/KJHXlHpj43v2cfxsB+8A5shWgKvjDNiFugqhTabPtnkmI
         5gFcPrX3nKld6X1+rhz3uUhURc+5uSYYpn4ikRtQ2MBE72enr6KCddvFa7AgWpqnFfFr
         6S0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784293562; x=1784898362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gLUXizPmm8lFk+lVj4kGKhusb/cUxotlJSZc5i0VZQA=;
        b=ao/Gq1wADq+zXeqVK7Sf1/Rdm5HI4c26VsE32ZJ+NS3N22XRJ7kWenGN8VQcQ1dcxB
         J1pZM033PunLwOUzJ/7TbW4MjiBUGCoDnoABqIOYFRlO7LDtrYGCcLiPj+TkUZQXTIS0
         fjOqstAxpcwc4KNFp+gvXWkSa5dvFXr3Ih7GoMbE/hcgKH7s1ZIu+cu4ml0fF+CZTKzT
         65v9TZufDLZa1W5p30gi1YdmHdqEvP7kNrOF69pRDF7R7/7SpSJpTtoeAyNjoIarwlXo
         Kspklxg1EqSIvEFw9Fw5gDZtVrNBzJZEzTlo9IQuFnCSFmEz/RZkx/+2npfz6M8l0fBe
         zUIQ==
X-Forwarded-Encrypted: i=1; AHgh+RrhIT6OdHh7F3pxAnq3Q4MgNRUf+pISFhtdQ4XeHscepGA92Www6lelnKy4mLHGXdljCtq714uYjcNmi6/wu9YkAGI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0M2FffbBX369vULO9E4xyMeVy6rtT+Suzpls2yWZyuffv4Dyj
	2/NULw7hrCA7vvEz95LCSVuVurJ0gHiajW9oiR9bekNFxl3U3jDhPFg7
X-Gm-Gg: AfdE7cmNwI1WnG21mprTvUPC1MvRtIs4dvsgzdveUnXUq1bjmzpAIaEpUjVwGdrFnOP
	BHAA33w6W5kB5qVCdi/geLA3d8W5+WK6g9PnvBOyMfJbVjf7BKMrRWrGZ6bQ9Iy3gM4pa8YcweU
	gnWq9wtT/fQucAnJeEFfNPayn7mp6+ANOfDO0fmspTSCjBuuxeTQTIJ+hLhyaynogCL6RrSxioh
	8WruLMZ20Q7WdBccfKWZZvrDhJEsGpO+OUqtLYyxE1F0eESi3tOdrqW0/wuJ28x/cpIUEiLljXu
	JlWRy/JtJloFJHx6A6zwwkItXcZSx0V4mdRykB6YCNAGUZxWCTfa26lnjvonRfkHB21OAv9iRBV
	Nr24zLgjrIvwk6qHm+ngBHyngRfTOznyorvdyi7Epf6/0IM9N1WG4SiPS5aAKgjPHMWQ0XVCoMu
	QBFw==
X-Received: by 2002:a17:90b:3bcd:b0:387:e0cb:c8e1 with SMTP id 98e67ed59e1d1-38e4b594dadmr2450658a91.42.1784293561881;
        Fri, 17 Jul 2026 06:06:01 -0700 (PDT)
Received: from localhost ([144.24.58.22])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1bb8a4sm7964292eec.14.2026.07.17.06.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 06:06:00 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Matthew Wilcox <willy@infradead.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Randy Dunlap <rdunlap@infradead.org>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [RFC PATCH v2 09/13] mm/kwatch: add probe lifecycle runtime
Date: Fri, 17 Jul 2026 09:05:44 -0400
Message-ID: <20260717130544.1903146-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717125023.1895892-1-wangjinchao600@gmail.com>
References: <20260717125023.1895892-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Open and close the watch window with a kretprobe on the target
function: the entry handler tracks per-task nesting depth and, when
the configured depth is reached, resolves the watch expression and
arms a watchpoint; the exit handler disarms it. An optional kprobe
at func_offset arms mid-function instead of at entry.

Functions running in a real NMI(-like) context are rejected once, at
function entry, by comparing the NMI nesting count against the one
NMI-like layer that int3-based kprobe delivery itself adds; a
companion kprobe with a post_handler pins the probe point so jump
optimization cannot change the delivery mechanism after it is
sampled. Rejections are counted and exposed to the control plane.

A global epoch versioning scheme invalidates stale per-task state
across reconfigurations, and a per-CPU mute flag keeps window
management quiet while a CPU rewrites its own debug registers.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kwatch/Makefile |   2 +-
 mm/kwatch/probe.c  | 275 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 276 insertions(+), 1 deletion(-)
 create mode 100644 mm/kwatch/probe.c

diff --git a/mm/kwatch/Makefile b/mm/kwatch/Makefile
index b2bc3003c89b..f04673cc5b1c 100644
--- a/mm/kwatch/Makefile
+++ b/mm/kwatch/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_KWATCH) += kwatch.o
 
-kwatch-y := deref.o task_ctx.o hwbp.o
+kwatch-y := deref.o task_ctx.o hwbp.o probe.o
diff --git a/mm/kwatch/probe.c b/mm/kwatch/probe.c
new file mode 100644
index 000000000000..249aa50c9f78
--- /dev/null
+++ b/mm/kwatch/probe.c
@@ -0,0 +1,275 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/atomic.h>
+#include <linux/kprobes.h>
+#include <linux/kallsyms.h>
+#include <linux/percpu.h>
+#include <linux/preempt.h>
+#include <linux/sched.h>
+
+#include "kwatch.h"
+#define TRAMPOLINE_CHECK_DEPTH 16
+static DEFINE_PER_CPU(bool, kwatch_probe_cpu_muted);
+
+struct kwatch_probe_ctx {
+	struct kprobe kp;
+	struct kretprobe rp;
+	struct kprobe pin_kp;
+	const struct kwatch_config *cfg;
+	bool rp_via_int3;
+
+	u32 epoch;
+};
+
+static struct kwatch_probe_ctx kwatch_probe_ctx;
+static atomic_long_t kwatch_nmi_rejected;
+
+unsigned long kwatch_probe_nmi_rejected(void)
+{
+	return atomic_long_read(&kwatch_nmi_rejected);
+}
+
+/*
+ * True if the probed function itself runs in an NMI-like context.
+ * int3-based kprobe delivery adds one NMI-like layer of its own;
+ * delivery is pinned at registration so the subtraction stays exact.
+ */
+static bool kwatch_probed_ctx_in_nmi(bool via_int3)
+{
+	return (preempt_count() & NMI_MASK) > (via_int3 ? NMI_OFFSET : 0);
+}
+
+static void kwatch_pin_post_handler(struct kprobe *p, struct pt_regs *regs,
+				    unsigned long flags)
+{
+	/* a post_handler pins the probepoint: no jump optimization */
+}
+
+bool kwatch_probe_validate_hit(struct pt_regs *regs,
+			       struct task_struct *arm_tsk)
+{
+	struct kwatch_tsk_ctx *ctx = kwatch_tsk_ctx_get(false);
+	const struct kwatch_config *cfg = kwatch_probe_ctx.cfg;
+
+	if (unlikely(!ctx || !cfg))
+		return true;
+
+	if (arm_tsk != current || ctx->depth != cfg->depth + 1)
+		return true;
+
+	return false;
+}
+
+void kwatch_probe_mute(bool mute)
+{
+	__this_cpu_write(kwatch_probe_cpu_muted, mute);
+}
+
+static inline bool kwatch_probe_is_muted(void)
+{
+	return __this_cpu_read(kwatch_probe_cpu_muted);
+}
+
+enum kwatch_probe_position {
+	KWATCH_PROBE_POSITION_ENTRY,
+	KWATCH_PROBE_POSITION_ACTIVE,
+	KWATCH_PROBE_POSITION_EXIT
+};
+
+static bool kwatch_tsk_ctx_check(enum kwatch_probe_position pos)
+{
+	struct kwatch_tsk_ctx *ctx = kwatch_tsk_ctx_get(true);
+	u32 epoch;
+
+	if (unlikely(!ctx))
+		return false;
+
+	/* Pairs with smp_store_release() in kwatch_probe_start/stop() */
+	epoch = smp_load_acquire(&kwatch_probe_ctx.epoch);
+
+	if (unlikely(ctx->epoch != epoch))
+		kwatch_tsk_ctx_reset(ctx, epoch);
+
+	if (unlikely(!epoch)) {
+		/*
+		 * No active session (not yet published, or already stopped):
+		 * kwatch_tsk_ctx_get(true) above may have just claimed a slot
+		 * for current. Release it here, otherwise an entry that lands
+		 * in the register->epoch-publish window leaks the slot until
+		 * the pool is freed.
+		 */
+		kwatch_tsk_ctx_release(ctx);
+		return false;
+	}
+
+	switch (pos) {
+	case KWATCH_PROBE_POSITION_ENTRY:
+		ctx->depth++;
+		return true;
+	case KWATCH_PROBE_POSITION_ACTIVE:
+		return true;
+	case KWATCH_PROBE_POSITION_EXIT:
+		if (unlikely(ctx->depth == 0)) {
+			kwatch_tsk_ctx_put();
+			return false;
+		}
+
+		ctx->depth--;
+		if (ctx->depth == 0) {
+			kwatch_tsk_ctx_put();
+			return false;
+		}
+		return true;
+	}
+	return false;
+}
+
+static int kwatch_activate_handler(struct kprobe *p, struct pt_regs *regs)
+{
+	struct kwatch_tsk_ctx *ctx = kwatch_tsk_ctx_get(false);
+	unsigned long watch_addr;
+	u16 watch_len;
+
+	if (unlikely(!ctx))
+		return 0;
+
+	if (unlikely(kwatch_probe_is_muted()))
+		return 0;
+
+	if (unlikely(!kwatch_tsk_ctx_check(KWATCH_PROBE_POSITION_ACTIVE)))
+		return 0;
+
+	if (ctx->depth != kwatch_probe_ctx.cfg->depth + 1 || ctx->wp)
+		return 0;
+
+	if (kwatch_deref_resolve(kwatch_probe_ctx.cfg, regs, &watch_addr,
+				 &watch_len))
+		return 0;
+
+	if (kwatch_hwbp_get(&ctx->wp))
+		return 0;
+
+	kwatch_hwbp_arm(ctx->wp, watch_addr, watch_len);
+	return 0;
+}
+
+static int kwatch_lifecycle_entry(struct kretprobe_instance *ri,
+				  struct pt_regs *regs)
+{
+	/*
+	 * Single policy point: the target function's context is judged once
+	 * here. A rejected invocation never increments depth, so the offset
+	 * kprobe path inherits the verdict through the depth check.
+	 */
+	if (unlikely(kwatch_probed_ctx_in_nmi(kwatch_probe_ctx.rp_via_int3))) {
+		atomic_long_inc(&kwatch_nmi_rejected);
+		return 1; /* NMI context is unsupported: no window, no return hook */
+	}
+
+	if (!kwatch_tsk_ctx_check(KWATCH_PROBE_POSITION_ENTRY))
+		return 0;
+
+	if (kwatch_probe_ctx.cfg->func_offset == 0)
+		kwatch_activate_handler(NULL, regs);
+
+	return 0;
+}
+
+static int kwatch_lifecycle_exit(struct kretprobe_instance *ri,
+				 struct pt_regs *regs)
+{
+	struct kwatch_tsk_ctx *ctx = kwatch_tsk_ctx_get(false);
+
+	if (unlikely(!ctx))
+		return 0;
+
+	if (!kwatch_tsk_ctx_check(KWATCH_PROBE_POSITION_EXIT))
+		return 0;
+
+	if (ctx->depth == kwatch_probe_ctx.cfg->depth) {
+		struct kwatch_watchpoint *wp = xchg(&ctx->wp, NULL);
+
+		if (wp)
+			kwatch_hwbp_put(wp);
+	}
+
+	return 0;
+}
+
+int kwatch_probe_start(struct kwatch_config *cfg)
+{
+	static u32 next_epoch;
+	u32 current_epoch;
+	int ret;
+
+	/*
+	 * Lockless check to prevent concurrent starts. Strictly serialized
+	 * by the control plane mutex, but serves as a sanity check.
+	 */
+	if (smp_load_acquire(&kwatch_probe_ctx.epoch) != 0)
+		return -EBUSY;
+
+	memset(&kwatch_probe_ctx, 0, sizeof(kwatch_probe_ctx));
+	kwatch_probe_ctx.cfg = cfg;
+
+	/* Session-scoped, like arm_ipi_suppressed in kwatch_hwbp_prealloc() */
+	atomic_long_set(&kwatch_nmi_rejected, 0);
+
+	/*
+	 * Pin the entry probepoint before the kretprobe registers, so its
+	 * delivery (int3 vs ftrace) can never change under jump optimization.
+	 * register_kretprobe() clears kp.post_handler, hence the companion.
+	 */
+	kwatch_probe_ctx.pin_kp.symbol_name = cfg->func_name;
+	kwatch_probe_ctx.pin_kp.post_handler = kwatch_pin_post_handler;
+	ret = register_kprobe(&kwatch_probe_ctx.pin_kp);
+	if (ret < 0)
+		return ret;
+
+	kwatch_probe_ctx.rp.entry_handler = kwatch_lifecycle_entry;
+	kwatch_probe_ctx.rp.handler = kwatch_lifecycle_exit;
+	kwatch_probe_ctx.rp.kp.symbol_name = cfg->func_name;
+
+	ret = register_kretprobe(&kwatch_probe_ctx.rp);
+	if (ret < 0) {
+		unregister_kprobe(&kwatch_probe_ctx.pin_kp);
+		return ret;
+	}
+	kwatch_probe_ctx.rp_via_int3 = !kprobe_ftrace(&kwatch_probe_ctx.rp.kp);
+
+	if (cfg->func_offset) {
+		kwatch_probe_ctx.kp.symbol_name = cfg->func_name;
+		kwatch_probe_ctx.kp.offset = cfg->func_offset;
+		kwatch_probe_ctx.kp.pre_handler = kwatch_activate_handler;
+
+		ret = register_kprobe(&kwatch_probe_ctx.kp);
+		if (ret) {
+			unregister_kretprobe(&kwatch_probe_ctx.rp);
+			unregister_kprobe(&kwatch_probe_ctx.pin_kp);
+			return ret;
+		}
+	}
+
+	current_epoch = ++next_epoch;
+	if (unlikely(!current_epoch))
+		current_epoch = ++next_epoch;
+
+	/* Pairs with smp_load_acquire() in kwatch_tsk_ctx_check() */
+	smp_store_release(&kwatch_probe_ctx.epoch, current_epoch);
+
+	return 0;
+}
+
+void kwatch_probe_stop(void)
+{
+	if (!kwatch_probe_ctx.epoch)
+		return;
+
+	/* Pairs with smp_load_acquire() in kwatch_tsk_ctx_check() */
+	smp_store_release(&kwatch_probe_ctx.epoch, 0);
+
+	if (kwatch_probe_ctx.cfg->func_offset > 0)
+		unregister_kprobe(&kwatch_probe_ctx.kp);
+
+	unregister_kretprobe(&kwatch_probe_ctx.rp);
+	unregister_kprobe(&kwatch_probe_ctx.pin_kp);
+}
-- 
2.53.0

