Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9975B3E3176
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Aug 2026 06:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787033467; cv=none; b=nmi4GWKhPC9QPo/IoMcZOmHNF2d1bL17mM61s1/LH3Q2B0pRiM8QXLauf+iGVnr8Iyg28iRxJJ8nvpDhC5xpPE66zCjlVa+gc1Q4/8O5oQ8UjKwgmy+BpEO7bV3vz80yyGjhp7fSZtG/x1PU5AOnuGCPtcqpOzGbfz+5wlEXPsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787033467; c=relaxed/simple;
	bh=mZKFwQauANDJ1gHu+gg8RedjLenlA7e9YJ8y+FF2WoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZHRGv6zY5weoX+am7vXNjbMoApCt4R+4Xif79W/mNLNxvVKhYoYlC1ENdPZvqF8pevacsxHzUy7JNMzTadNaU6lGjQ9SeL7MCBdJQjkDbA2bX7MKEYn1/A9p9nNDM4dh4g1HTWEzSQSc2lkdZP088YvNp49JPeo5dBFQelaX0Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/fDfup6; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/fDfup6"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-381b831d535so5845734a91.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 23:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787033465; x=1787638265; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PFTkBKzl9DDztkv9Ak+eApuO538I5zXX6YMBdyPiC24=;
        b=M/fDfup6yb5Ul3kWAVU5gN/854XlbjmxUj/vwLrIZ/S0C1NeLvdSG80xWbO6Vz0oAC
         SjoR9flU7n/TN2phwHYB3lACBPlM3KS3Kwev4+lfpmlez+vZPg1853ZJryEaNh2qLltf
         A1+pINquqFwjaLEEBDpmUN5/I5Zb95kZKnf4WYurJwed3qc6tgpBLgTl/bTf3UuBqR+m
         L1MB8cvYYpS9d5uw8sUBX06r2Ky8Bl0lU8YLaoLgnrxo4cNk4M7dj78BTZaIcOqix4Wu
         bwh2x6a4VZhD/qVfxBLtV1Kms88fiLPgUqmY0tGoF1tql9JFxo4nykvptKvMXs8i6rry
         BiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787033465; x=1787638265;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PFTkBKzl9DDztkv9Ak+eApuO538I5zXX6YMBdyPiC24=;
        b=UOkZ4zGLIZoOeNb7856qqkSQZpi91+xXoSyL9pR2R8HODUGD24j1IwzALvBnSjMmI0
         xc4EamqXQhsdK67mX9tz4hJkmSTDg89dJ5L5AZ5kMVShPNq8egkr+MrKYMKhX0dcOMTG
         ru17XeA17WNmx+Mk/IGQYFld4lkLXFJa2SrKDOdin0w9nFO9tfkSGe+jpfofTvIaZgDk
         /NIqW1OnCJTP88kHEBXe1NfYaGFzvAhXfdfuuM+8qf6YxkDd+If34YkX874cWldm/Fqx
         X8oR+aV4gSyiUVBmAhUbJTgf50YAM4qpLNlpAcNB6ThEtH1z0Y/fn7YHQ5zFR0wA9SkU
         5yNQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpqr+Z04cD1yljOQrevrNKC8QVTW0v2OurwRk1Z8sJhCyXg8CQbb3n0PUEVPNMsCSxPrVv2jDvsk0z2Uy5+VjI2raM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIMFjxArUO9YdlTAkXyQ7mHVeoZ2CrlvtCC98HPVaVYqvAPOX6
	Ap/5uvzr7upsSR/b45ld952J7ozjFayi71Jaid5iun0u5B430xj3DHW+cNmyJC/a
X-Gm-Gg: AR+sD10qylqdmIHvSUAY8nVR+Kzzw31s2pGDNvyQLsNXtFt8GP5hl8YafQk83fZu0VD
	xeCbaI+Vx/DzECdA9dsse/u98uL7tt4mSO8FXp7w1RgXDgmolf8qWABJgQ+e9PJq0zjg+VOYIkK
	cZT5G27PFR/5xYZdlWKY8bziMpqn7g1tqbfQ/d4UdyuWxg8uMenqDH/eSXCLpwBy0sonfXHuXKq
	r51me4sY1s0tuxio1Pgs3HilpMOyBmPOUFD2HN97N3Jo0ypEJiu8F+PNtW6NRt8AQK7qGe65Nnh
	PXMpTdoiv0u3GHdQo2tyimBomIhhji153kbIdWlzj8y2aaf5XON/1sl8TkFwX06Ksz4YJ0SIQYq
	v3uAr+v3Ipxo9irJXB9iMYbCPgE3atlAm8XF0I19jn+OkaFg8fn/EN/UqbzhM8Es7cdAk1mw3id
	qLrKLpfl1kIUraaSbLcYQnNlymIbrHqBxPXi39WqOiDLVzenJEU/i0V3RfATBOyH9U5RGDmnqTv
	qALtIQ=
X-Received: by 2002:a17:90a:ec83:b0:381:e74f:8a6a with SMTP id 98e67ed59e1d1-3933b8c1041mr33609337a91.16.1787033464444;
        Mon, 17 Aug 2026 23:11:04 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3954d38bf94sm4633942a91.9.2026.08.17.23.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 23:11:04 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
X-Google-Original-From: Kunwu Chan <kunwu.chan@linux.dev>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	shuah@kernel.org,
	lianux.mm@gmail.com,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [RFC PATCH 3/7] mm/damon/perf: add debugfs statistics interface
Date: Tue, 18 Aug 2026 14:10:27 +0800
Message-ID: <20260818061031.827057-4-kunwu.chan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818061031.827057-1-kunwu.chan@linux.dev>
References: <20260818061031.827057-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lian Wang <lianux.mm@gmail.com>

Expose the aggregated per-CPU counters and the global event-stage in a
debug-only debugfs perf_stats file.  The format is explicitly unstable;
tracepoints are the stable diagnostic interface.

Co-developed-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Lian Wang <lianux.mm@gmail.com>
---
 mm/damon/perf/Makefile  |   2 +-
 mm/damon/perf/debugfs.c | 142 ++++++++++++++++++++++++++++++++++++++++
 mm/damon/perf/stats.c   |   2 +-
 3 files changed, 144 insertions(+), 2 deletions(-)
 create mode 100644 mm/damon/perf/debugfs.c

diff --git a/mm/damon/perf/Makefile b/mm/damon/perf/Makefile
index 5c46d3da7ef8..150cbaa875fa 100644
--- a/mm/damon/perf/Makefile
+++ b/mm/damon/perf/Makefile
@@ -2,4 +2,4 @@
 
 # Observability: per-CPU counters, tracepoints, debugfs perf_stats
 obj-$(CONFIG_DAMON_PERF_OBSERVE)	+= damon-perf.o
-damon-perf-objs			:= stats.o
+damon-perf-objs			:= stats.o debugfs.o
diff --git a/mm/damon/perf/debugfs.c b/mm/damon/perf/debugfs.c
new file mode 100644
index 000000000000..c54dd7644ac3
--- /dev/null
+++ b/mm/damon/perf/debugfs.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DAMON Perf Observability — debugfs Interface
+ *
+ * Exposes one file under /sys/kernel/debug/damon/:
+ *
+ *   perf_stats — per-CPU pipeline statistics in tabular form
+ *
+ * DEBUG ONLY — format may change without notice; do not parse in
+ * scripts.  For stable diagnostics, use the tracepoints under
+ *   /sys/kernel/debug/tracing/events/damon/
+ */
+
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+
+#include "perf.h"
+
+static struct dentry *damon_debugfs_dir;
+
+/*
+ * perf_stats
+ */
+
+static const char *state_name(int s)
+{
+	switch (s) {
+	case DAMON_PERF_STATE_UNINIT:	return "UNINIT";
+	case DAMON_PERF_STATE_CREATED:	return "CREATED";
+	case DAMON_PERF_STATE_BOUND:	return "BOUND";
+	case DAMON_PERF_STATE_ENABLED:	return "ENABLED";
+	case DAMON_PERF_STATE_RUNNING:	return "RUNNING";
+	case DAMON_PERF_STATE_ERROR:	return "ERROR";
+	default:			return "?";
+	}
+}
+
+static int perf_stats_show(struct seq_file *m, void *v)
+{
+	struct damon_perf_stats agg, st;
+	int cpu;
+	bool first = true;
+
+	damon_perf_stats_aggregate(&agg);
+
+	seq_puts(m, "    --------------  ----------\n");
+	seq_puts(m, "    Counter          Value\n");
+	seq_puts(m, "    --------------  ----------\n");
+
+#define STAT_ROW(label, field) \
+	seq_printf(m, "    %-12s   %8llu\n", label, agg.field)
+
+	STAT_ROW("callback",    callback);
+	STAT_ROW("valid",       sample_valid);
+	STAT_ROW("null",        sample_null);
+	STAT_ROW("addr_zero",   sample_addr_zero);
+	STAT_ROW("kernel",      sample_kernel);
+	STAT_ROW("inv_phys",    sample_invalid_phys);
+	STAT_ROW("enqueue",     enqueue);
+	STAT_ROW("dequeue",     dequeue);
+	STAT_ROW("overflow",    overflow);
+	STAT_ROW("ring_peak",   ring_peak);
+	STAT_ROW("match",       match);
+	STAT_ROW("miss_tgid",   miss_tgid);
+	STAT_ROW("miss_region", miss_region);
+	STAT_ROW("miss_bound",  miss_boundary);
+	STAT_ROW("update",      update);
+
+#undef STAT_ROW
+
+	seq_puts(m, "    --------------  ----------\n\n");
+
+	/* Per-CPU breakdown */
+	cpus_read_lock();
+	for_each_online_cpu(cpu) {
+		damon_perf_stats_snapshot(cpu, &st);
+
+		/* Skip truly idle CPUs */
+		if (st.cpu_state == DAMON_PERF_STATE_UNINIT &&
+		    !st.callback && !st.enqueue && !st.dequeue)
+			continue;
+
+		if (first) {
+			seq_puts(m, "  Per-CPU (non-zero / non-UNINIT):\n");
+			first = false;
+		}
+
+		seq_printf(m, "  CPU%02d: st=%-7s cb=%llu enq=%llu deq=%llu ovf=%llu match=%llu tgid=%llu noreg=%llu bound=%llu upd=%llu\n",
+			cpu, state_name(st.cpu_state),
+			st.callback, st.enqueue, st.dequeue,
+			st.overflow, st.match,
+			st.miss_tgid, st.miss_region, st.miss_boundary,
+			st.update);
+	}
+	cpus_read_unlock();
+
+	return 0;
+}
+
+static int perf_stats_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, perf_stats_show, NULL);
+}
+
+static const struct file_operations perf_stats_fops = {
+	.open		= perf_stats_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+/*
+ * Init / teardown
+ */
+
+int damon_perf_debugfs_init(void)
+{
+	if (!debugfs_initialized())
+		return -ENODEV;
+
+	/*
+	 * Create the "damon" directory first.  debugfs_create_dir() mounts
+	 * debugfs via simple_pin_fs() before touching debugfs_mount, so it
+	 * is safe to call during initcall time -- unlike debugfs_lookup(),
+	 * which dereferences debugfs_mount unconditionally and crashes with
+	 * a NULL mount.  If the directory already exists (created by another
+	 * DAMON interface) debugfs_create_dir() returns -EEXIST; fall back
+	 * to debugfs_lookup(), which is now safe because the mount exists.
+	 */
+	damon_debugfs_dir = debugfs_create_dir("damon", NULL);
+	if (damon_debugfs_dir == ERR_PTR(-EEXIST))
+		damon_debugfs_dir = debugfs_lookup("damon", NULL);
+	if (IS_ERR(damon_debugfs_dir))
+		return PTR_ERR(damon_debugfs_dir);
+
+	debugfs_create_file("perf_stats", 0400, damon_debugfs_dir,
+			NULL, &perf_stats_fops);
+
+	return 0;
+}
diff --git a/mm/damon/perf/stats.c b/mm/damon/perf/stats.c
index a869f115bb26..ae5b0037a31d 100644
--- a/mm/damon/perf/stats.c
+++ b/mm/damon/perf/stats.c
@@ -291,5 +291,5 @@ void damon_perf_stats_aggregate(struct damon_perf_stats *dst)
 
 int damon_perf_framework_init(void)
 {
-	return 0;
+	return damon_perf_debugfs_init();
 }
-- 
2.43.0

