Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C051275B0F
	for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Dec 2025 17:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766682583; cv=none; b=mKRQsncW8Oj1HO/NWzRs6R8UyZXnBq5AeZKk2fguZT41SrlHNiCwkU1UBkgncsSVSJg0fZEJwqn3PFCnmMLxN6VHcoDRDbZfN083IVL/xrEd1IGRC8aofvk8kl3Np2CyM2ZcbQYVR/9FLBTyLMHk3Jdu6PvOnXmEOYygJYBwg/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766682583; c=relaxed/simple;
	bh=CIfmlGwzCZIirY0nQrbTWhHiOTEhqkYiVt4nX91mNpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LckZjeCxpJUge9yIkiJsiA3pfU0BM+Vr4KYDHc9/DbAjlSUw62omVA8YHJE79iCzmmap4Qx2fknXjhLrZUeJYgo5uiCHbZWgtPQGgY6pMwqNH/zO5U6naJW6peluHqSn2BK004dWR4f100yqLB+5StQZWQajzLyNdiuxNgU8mP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deFHmnPY; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deFHmnPY"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-641e9422473so5465073d50.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Dec 2025 09:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766682580; x=1767287380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o1XAl+rNLsSK7t9KsTmmNijZZcWjhCWFfFy06zE8YV0=;
        b=deFHmnPYQ2bmNAVehv0B3x+dJtiGULUc5aUF9cWB/TZ82UgbneG8d+z3z2HKxY+x9n
         fl5bh6FuipurtA+Rmztf513uhho8FSS7a5dwg4vvu7D6j0trCWpmqKbx1LmuOqnks2MI
         Q16WtYugEBDvE+69GkkZPVpgYsTuExtsalCVAWUvt+/8+1w0Y77E+YG8URDB6tFXayDZ
         /2qVrpFnhhbTKmWaPT6kuPbR/cnHD1onFjUwRRHTKGj8Aj6WVya7mQOCZI5zXmm/zkl2
         bd+DU44ZLmbpEdySN9pgoT3Uf1YFN51/2wTMzTeQBHmVwN3EJJbrtSjgwUPF+SDSoBM1
         tzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766682580; x=1767287380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o1XAl+rNLsSK7t9KsTmmNijZZcWjhCWFfFy06zE8YV0=;
        b=gCjxdkwdNDMEQ6bzWF2FF4SGU5iTQZGOaGgrKs7fFHPozqyBz24v8PhrAOBZpvFHfH
         5Y7lHgBTaWv6sUZVb5z4/sVZRIID3ThH/ARlwIc/QKGxi0iWl6CmywvNG9n3TMkzpPrw
         fSK6VgFPctAkw0w3j8JR+RYH/gXW4GAldDBcLkjfMcyho4DXUWCeJt8i5tXrb0M7A81I
         bwn2/ffXbCHYI237+4CoRCvMB8OoqrOuTZLMSdN8BoOib8gT4YQIed3kxkBcFD5X2fAP
         LUmI08g57xuxCWjkIcGKpUahW9kkSWPTwwAQW1MiR22BB47175W4h+dKUUO2iKHc/Oax
         LupQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjWY3jrWds7/HdaKtXo2OdUc6EgLgfZ1+ikCoPR3/lFp2XB6xCicgwtZLpXIq4P0Vfp/80ZeQL8WmjjTRpBGAinRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxo+X/q+vhhaB/GP3c4Dsu9Cg7kCmo9Q9VuKPpHKDIJbT0Zg6i
	Vz/U7weYeVko2yNV3Ll6qApnpGp3Y9Vy7ZYP+jTQc8LXHdgZDO1rYnwx
X-Gm-Gg: AY/fxX6xQAYE6WVvsPv3LnDnl1BPXtT8DQ7N0Um9FruIRzYlSmVeeaGX5Ft1YEIWrmX
	h98cfe2b3TNIINzu5CvNHUt88Wirj9Svh1tveYDRZXGM67q68Wwa9qCkwvQLMwDj30jZeRDqKc2
	arNHEUJRw2nKO68XsynXEq8PqHBqi6lJ9D4MS9NqWdo+6CxEZymYATXvjg7QVuTxtxiU4jjj+SB
	vH6pXiSqlgC6ZFdlwtHI/mkj6sV5372Hc5xXzI1IdW+UAShp5d8on7UdQCar3pYxFPVSBHXQ7Pv
	LRQ6Ujs819wu8TxUl7FRsvhE4HYBZArFMRPMEYQ2C39J6tRl3HYzAj2PbQxJbp3WTC1/+aIUWQ2
	L9SRLyq9Tvu/zaDyFE9rrjGL8S1lg5645+l7iGsg+6njT8zUWtPQZat9BhiMcg1RVnJuSRUVccz
	D52jwvmek=
X-Google-Smtp-Source: AGHT+IF5dw6Hn/h74MWwA/S32fJlIZPljCF5eWLqPxwzMP1ymLvblq4azH8quaPTvyBsylujcP8/wA==
X-Received: by 2002:a05:690c:6084:b0:787:badd:4c with SMTP id 00721157ae682-78fb3f520c6mr336407217b3.27.1766682579920;
        Thu, 25 Dec 2025 09:09:39 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:5a70:118b:3656:4527])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb4373819sm76520067b3.7.2025.12.25.09.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 09:09:39 -0800 (PST)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	David Laight <david.laight@runbox.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: [PATCH v4 7/7] kernel.h: drop trace_printk.h
Date: Thu, 25 Dec 2025 12:09:29 -0500
Message-ID: <20251225170930.1151781-8-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251225170930.1151781-1-yury.norov@gmail.com>
References: <20251225170930.1151781-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The trace_printk.h header is debugging-only by nature, but now it's
included by almost every compilation unit via kernel.h.

Removing trace_printk.h saves 1.5-2% of compilation time on my
Ubuntu-derived x86_64/localyesconfig.

There's ~30 files in the codebase, requiring trace_printk.h for
non-debugging reasons: mostly to disable tracing on panic or under
similar conditions. Include the header for those explicitly.

This implicitly decouples linux/kernel.h and linux/instruction_pointer.h
as well, because it has been isolated to trace_printk.h early in the
series.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 arch/powerpc/kvm/book3s_xics.c              | 1 +
 arch/powerpc/xmon/xmon.c                    | 1 +
 arch/s390/kernel/ipl.c                      | 1 +
 arch/s390/kernel/machine_kexec.c            | 1 +
 drivers/gpu/drm/i915/gt/intel_gtt.h         | 1 +
 drivers/gpu/drm/i915/i915_gem.h             | 1 +
 drivers/hwtracing/stm/dummy_stm.c           | 1 +
 drivers/infiniband/hw/hfi1/trace_dbg.h      | 1 +
 drivers/tty/sysrq.c                         | 1 +
 drivers/usb/early/xhci-dbc.c                | 1 +
 fs/ext4/inline.c                            | 1 +
 include/linux/kernel.h                      | 1 -
 include/linux/sunrpc/debug.h                | 1 +
 kernel/debug/debug_core.c                   | 1 +
 kernel/panic.c                              | 1 +
 kernel/rcu/rcu.h                            | 1 +
 kernel/rcu/rcutorture.c                     | 1 +
 kernel/trace/error_report-traces.c          | 1 +
 kernel/trace/ring_buffer_benchmark.c        | 1 +
 kernel/trace/trace.c                        | 1 +
 kernel/trace/trace_benchmark.c              | 1 +
 kernel/trace/trace_events_trigger.c         | 1 +
 kernel/trace/trace_functions.c              | 1 +
 kernel/trace/trace_printk.c                 | 1 +
 kernel/trace/trace_selftest.c               | 1 +
 lib/sys_info.c                              | 1 +
 samples/fprobe/fprobe_example.c             | 1 +
 samples/ftrace/ftrace-direct-modify.c       | 1 +
 samples/ftrace/ftrace-direct-multi-modify.c | 1 +
 samples/ftrace/ftrace-direct-multi.c        | 1 +
 samples/ftrace/ftrace-direct-too.c          | 1 +
 samples/ftrace/ftrace-direct.c              | 1 +
 samples/trace_printk/trace-printk.c         | 1 +
 sound/hda/common/sysfs.c                    | 1 +
 34 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_xics.c b/arch/powerpc/kvm/book3s_xics.c
index 589a8f257120..8f8cfc8648c6 100644
--- a/arch/powerpc/kvm/book3s_xics.c
+++ b/arch/powerpc/kvm/book3s_xics.c
@@ -20,6 +20,7 @@
 #include <asm/time.h>
 
 #include <linux/seq_file.h>
+#include <linux/trace_printk.h>
 
 #include "book3s_xics.h"
 
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index cb3a3244ae6f..f5cf6d807aeb 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -27,6 +27,7 @@
 #include <linux/highmem.h>
 #include <linux/security.h>
 #include <linux/debugfs.h>
+#include <linux/trace_printk.h>
 
 #include <asm/ptrace.h>
 #include <asm/smp.h>
diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index dcdc7e274848..55ac9c9eeb36 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -20,6 +20,7 @@
 #include <linux/gfp.h>
 #include <linux/crash_dump.h>
 #include <linux/debug_locks.h>
+#include <linux/trace_printk.h>
 #include <linux/vmalloc.h>
 #include <asm/asm-extable.h>
 #include <asm/machine.h>
diff --git a/arch/s390/kernel/machine_kexec.c b/arch/s390/kernel/machine_kexec.c
index baeb3dcfc1c8..668d8444b02b 100644
--- a/arch/s390/kernel/machine_kexec.c
+++ b/arch/s390/kernel/machine_kexec.c
@@ -14,6 +14,7 @@
 #include <linux/ftrace.h>
 #include <linux/debug_locks.h>
 #include <linux/cpufeature.h>
+#include <linux/trace_printk.h>
 #include <asm/guarded_storage.h>
 #include <asm/machine.h>
 #include <asm/pfault.h>
diff --git a/drivers/gpu/drm/i915/gt/intel_gtt.h b/drivers/gpu/drm/i915/gt/intel_gtt.h
index 9d3a3ad567a0..3f6d78a7ccea 100644
--- a/drivers/gpu/drm/i915/gt/intel_gtt.h
+++ b/drivers/gpu/drm/i915/gt/intel_gtt.h
@@ -22,6 +22,7 @@
 #include <linux/pagevec.h>
 #include <linux/scatterlist.h>
 #include <linux/workqueue.h>
+#include <linux/trace_printk.h>
 
 #include <drm/drm_mm.h>
 
diff --git a/drivers/gpu/drm/i915/i915_gem.h b/drivers/gpu/drm/i915/i915_gem.h
index 20b3cb29cfff..549fdeaf4508 100644
--- a/drivers/gpu/drm/i915/i915_gem.h
+++ b/drivers/gpu/drm/i915/i915_gem.h
@@ -27,6 +27,7 @@
 
 #include <linux/bug.h>
 #include <linux/types.h>
+#include <linux/trace_printk.h>
 
 #include <drm/drm_drv.h>
 
diff --git a/drivers/hwtracing/stm/dummy_stm.c b/drivers/hwtracing/stm/dummy_stm.c
index 38528ffdc0b3..8464401756f3 100644
--- a/drivers/hwtracing/stm/dummy_stm.c
+++ b/drivers/hwtracing/stm/dummy_stm.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/stm.h>
+#include <linux/trace_printk.h>
 #include <uapi/linux/stm.h>
 
 static ssize_t notrace
diff --git a/drivers/infiniband/hw/hfi1/trace_dbg.h b/drivers/infiniband/hw/hfi1/trace_dbg.h
index 58304b91380f..d7c08190d816 100644
--- a/drivers/infiniband/hw/hfi1/trace_dbg.h
+++ b/drivers/infiniband/hw/hfi1/trace_dbg.h
@@ -8,6 +8,7 @@
 
 #include <linux/tracepoint.h>
 #include <linux/trace_seq.h>
+#include <linux/trace_printk.h>
 
 #include "hfi.h"
 
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 1f78b0db3b25..72b2555c2bb8 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -51,6 +51,7 @@
 #include <linux/syscalls.h>
 #include <linux/of.h>
 #include <linux/rcupdate.h>
+#include <linux/trace_printk.h>
 
 #include <asm/ptrace.h>
 #include <asm/irq_regs.h>
diff --git a/drivers/usb/early/xhci-dbc.c b/drivers/usb/early/xhci-dbc.c
index 41118bba9197..dce1e2a3e180 100644
--- a/drivers/usb/early/xhci-dbc.c
+++ b/drivers/usb/early/xhci-dbc.c
@@ -22,6 +22,7 @@
 #include <linux/delay.h>
 #include <linux/kthread.h>
 #include <linux/usb/xhci-dbgp.h>
+#include <linux/trace_printk.h>
 
 #include "../host/xhci.h"
 #include "xhci-dbc.h"
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 1f6bc05593df..d15faa78eb07 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -9,6 +9,7 @@
 #include <linux/namei.h>
 #include <linux/iversion.h>
 #include <linux/sched/mm.h>
+#include <linux/trace_printk.h>
 
 #include "ext4_jbd2.h"
 #include "ext4.h"
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index a377335e01da..c48f7109bb2a 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -32,7 +32,6 @@
 #include <linux/build_bug.h>
 #include <linux/sprintf.h>
 #include <linux/static_call_types.h>
-#include <linux/trace_printk.h>
 #include <linux/util_macros.h>
 #include <linux/wordpart.h>
 
diff --git a/include/linux/sunrpc/debug.h b/include/linux/sunrpc/debug.h
index 891f6173c951..db2b572505f5 100644
--- a/include/linux/sunrpc/debug.h
+++ b/include/linux/sunrpc/debug.h
@@ -9,6 +9,7 @@
 #ifndef _LINUX_SUNRPC_DEBUG_H_
 #define _LINUX_SUNRPC_DEBUG_H_
 
+#include <linux/trace_printk.h>
 #include <uapi/linux/sunrpc/debug.h>
 
 /*
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 0b9495187fba..e9209afc78aa 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -53,6 +53,7 @@
 #include <linux/rcupdate.h>
 #include <linux/irq.h>
 #include <linux/security.h>
+#include <linux/trace_printk.h>
 
 #include <asm/cacheflush.h>
 #include <asm/byteorder.h>
diff --git a/kernel/panic.c b/kernel/panic.c
index 0d52210a9e2b..b9e1ff90c637 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -37,6 +37,7 @@
 #include <linux/context_tracking.h>
 #include <linux/seq_buf.h>
 #include <linux/sys_info.h>
+#include <linux/trace_printk.h>
 #include <trace/events/error_report.h>
 #include <asm/sections.h>
 
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 9cf01832a6c3..1c8f5765ba8b 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -12,6 +12,7 @@
 
 #include <linux/slab.h>
 #include <trace/events/rcu.h>
+#include <linux/trace_printk.h>
 
 /*
  * Grace-period counter management.
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 07e51974b06b..c2f859c20ca7 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -48,6 +48,7 @@
 #include <linux/tick.h>
 #include <linux/rcupdate_trace.h>
 #include <linux/nmi.h>
+#include <linux/trace_printk.h>
 
 #include "rcu.h"
 
diff --git a/kernel/trace/error_report-traces.c b/kernel/trace/error_report-traces.c
index f89792c25b11..6a3c59f39ea2 100644
--- a/kernel/trace/error_report-traces.c
+++ b/kernel/trace/error_report-traces.c
@@ -7,5 +7,6 @@
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/error_report.h>
+#include <linux/trace_printk.h>
 
 EXPORT_TRACEPOINT_SYMBOL_GPL(error_report_end);
diff --git a/kernel/trace/ring_buffer_benchmark.c b/kernel/trace/ring_buffer_benchmark.c
index 593e3b59e42e..b977ee0879c1 100644
--- a/kernel/trace/ring_buffer_benchmark.c
+++ b/kernel/trace/ring_buffer_benchmark.c
@@ -10,6 +10,7 @@
 #include <uapi/linux/sched/types.h>
 #include <linux/module.h>
 #include <linux/ktime.h>
+#include <linux/trace_printk.h>
 #include <asm/local.h>
 
 struct rb_page {
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 57f24e2cd19c..0684cc6b17c5 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -53,6 +53,7 @@
 #include <linux/sort.h>
 #include <linux/io.h> /* vmap_page_range() */
 #include <linux/fs_context.h>
+#include <linux/trace_printk.h>
 
 #include <asm/setup.h> /* COMMAND_LINE_SIZE */
 
diff --git a/kernel/trace/trace_benchmark.c b/kernel/trace/trace_benchmark.c
index e19c32f2a938..740b49c493db 100644
--- a/kernel/trace/trace_benchmark.c
+++ b/kernel/trace/trace_benchmark.c
@@ -3,6 +3,7 @@
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <linux/trace_clock.h>
+#include <linux/trace_printk.h>
 
 #define CREATE_TRACE_POINTS
 #include "trace_benchmark.h"
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 06b75bcfc7b8..1c1420a4c429 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -12,6 +12,7 @@
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/rculist.h>
+#include <linux/trace_printk.h>
 
 #include "trace.h"
 
diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index c12795c2fb39..ec725f8b2343 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -16,6 +16,7 @@
 #include <linux/ftrace.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
+#include <linux/trace_printk.h>
 
 #include "trace.h"
 
diff --git a/kernel/trace/trace_printk.c b/kernel/trace/trace_printk.c
index 29f6e95439b6..e49609c97496 100644
--- a/kernel/trace/trace_printk.c
+++ b/kernel/trace/trace_printk.c
@@ -16,6 +16,7 @@
 #include <linux/ctype.h>
 #include <linux/list.h>
 #include <linux/slab.h>
+#include <linux/trace_printk.h>
 
 #include "trace.h"
 
diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index d88c44f1dfa5..b6aa5c92f079 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -6,6 +6,7 @@
 #include <linux/kthread.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/trace_printk.h>
 
 static inline int trace_valid_entry(struct trace_entry *entry)
 {
diff --git a/lib/sys_info.c b/lib/sys_info.c
index f32a06ec9ed4..7ded4e7f3671 100644
--- a/lib/sys_info.c
+++ b/lib/sys_info.c
@@ -10,6 +10,7 @@
 #include <linux/sched/debug.h>
 #include <linux/string.h>
 #include <linux/sysctl.h>
+#include <linux/trace_printk.h>
 
 #include <linux/sys_info.h>
 
diff --git a/samples/fprobe/fprobe_example.c b/samples/fprobe/fprobe_example.c
index bfe98ce826f3..dfebb1cefb2c 100644
--- a/samples/fprobe/fprobe_example.c
+++ b/samples/fprobe/fprobe_example.c
@@ -17,6 +17,7 @@
 #include <linux/fprobe.h>
 #include <linux/sched/debug.h>
 #include <linux/slab.h>
+#include <linux/trace_printk.h>
 
 #define BACKTRACE_DEPTH 16
 #define MAX_SYMBOL_LEN 4096
diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
index da3a9f2091f5..cb6989f52167 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -2,6 +2,7 @@
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <linux/ftrace.h>
+#include <linux/trace_printk.h>
 #if !defined(CONFIG_ARM64) && !defined(CONFIG_PPC32)
 #include <asm/asm-offsets.h>
 #endif
diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
index 8f7986d698d8..1b24d53c34c2 100644
--- a/samples/ftrace/ftrace-direct-multi-modify.c
+++ b/samples/ftrace/ftrace-direct-multi-modify.c
@@ -2,6 +2,7 @@
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <linux/ftrace.h>
+#include <linux/trace_printk.h>
 #if !defined(CONFIG_ARM64) && !defined(CONFIG_PPC32)
 #include <asm/asm-offsets.h>
 #endif
diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
index db326c81a27d..3c94ecdaf3d5 100644
--- a/samples/ftrace/ftrace-direct-multi.c
+++ b/samples/ftrace/ftrace-direct-multi.c
@@ -4,6 +4,7 @@
 #include <linux/mm.h> /* for handle_mm_fault() */
 #include <linux/ftrace.h>
 #include <linux/sched/stat.h>
+#include <linux/trace_printk.h>
 #if !defined(CONFIG_ARM64) && !defined(CONFIG_PPC32)
 #include <asm/asm-offsets.h>
 #endif
diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
index 3d0fa260332d..e4c26db202ce 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -3,6 +3,7 @@
 
 #include <linux/mm.h> /* for handle_mm_fault() */
 #include <linux/ftrace.h>
+#include <linux/trace_printk.h>
 #if !defined(CONFIG_ARM64) && !defined(CONFIG_PPC32)
 #include <asm/asm-offsets.h>
 #endif
diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
index 956834b0d19a..01f3512aec50 100644
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@ -3,6 +3,7 @@
 
 #include <linux/sched.h> /* for wake_up_process() */
 #include <linux/ftrace.h>
+#include <linux/trace_printk.h>
 #if !defined(CONFIG_ARM64) && !defined(CONFIG_PPC32)
 #include <asm/asm-offsets.h>
 #endif
diff --git a/samples/trace_printk/trace-printk.c b/samples/trace_printk/trace-printk.c
index cfc159580263..4fc58844aff1 100644
--- a/samples/trace_printk/trace-printk.c
+++ b/samples/trace_printk/trace-printk.c
@@ -2,6 +2,7 @@
 #include <linux/module.h>
 #include <linux/kthread.h>
 #include <linux/irq_work.h>
+#include <linux/trace_printk.h>
 
 /* Must not be static to force gcc to consider these non constant */
 char *trace_printk_test_global_str =
diff --git a/sound/hda/common/sysfs.c b/sound/hda/common/sysfs.c
index f8c8483fd5e5..ac382f7063dc 100644
--- a/sound/hda/common/sysfs.c
+++ b/sound/hda/common/sysfs.c
@@ -19,6 +19,7 @@
 #include "hda_local.h"
 #include <sound/hda_hwdep.h>
 #include <sound/minors.h>
+#include <linux/trace_printk.h>
 
 /* hint string pair */
 struct hda_hint {
-- 
2.43.0

