Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27813EBF23
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Aug 2026 06:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787033493; cv=none; b=AK4Y7R1pU/iDfCHHTXtgIVGpVo0PzzACxYZbaD/lDRV0r7brKF85Q44j0X0fZT4IxXJgUE+s7phteFSZeA+0CCSfMilzO6owMVkhpZJlErjAk6toy/FXetRu8YQ7YK5Ex0ibrhgMvl8zD0gczzKgNspmyoexKwM+qmMtOjG66Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787033493; c=relaxed/simple;
	bh=LIvxhaVqnrIODtLHUsR+wAXp0bwosE7wdYeBrcUBUT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UnFlplCvsDxm4tTOyi0p+l/cIoSn4GNJv/iBbH9LdLn4/de9aFDCylGeO3Xd4uIcuBmH3pDhJ98IStw5k89inl6gsuPH2VxxzwhTH2wH1C6shcd3Uo+eeb01NwTkHpdNMwDnYSUDZXKr9STE/VnuW8OSMR4I9+RXQia20W6RzVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7SFwnHF; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7SFwnHF"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38f620399a0so3696235a91.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 23:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787033491; x=1787638291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qyQvFdJaou+co7R0CJUYpuqHbBnGV73Fl2ebn6kSllM=;
        b=E7SFwnHFzgJX2zvcZSWeyK7qzXjcd8x90LGSvAFRaREhRji1c3PFG48YqHCqNszH9I
         J7CxWaVy40vIgfRXpzoCWbtINrlfyJN3OoRnTwijxyGpSjD1KYbSF6Z3acQoTvIKnsvP
         Q38vl5X74SVL/SqsLxZprEmbVsBxCUkRT8bJrnoXagXBYNke+jTEi5XWJbHn1SQk/rTM
         g7Tx0vq3LRWmLJpMHpjJmhgjOwbYYtxFiwVhJ2TYOdjLI21r/9CesLA6IP4LvBFvC7+C
         SOWKNBiAixXmya/0/uasdXjODKZfzMy0aJLipx9shexJjIWF1nexHo6zDOZyCjX+jiTt
         U2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787033491; x=1787638291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qyQvFdJaou+co7R0CJUYpuqHbBnGV73Fl2ebn6kSllM=;
        b=dnJRfHsIgdYksvfEnClEsZVKocGW3uvMVD46L+LEKoH0Ru9OK0ug5mg1aGbP86rHYP
         BtqS/0vnRvC1ncOTSkKju/dmnzPqI+RoggH1Mh37UNG3rrDfgLczLU2FiNklybenyHKb
         87ClK+j/CKfJS19YFER4MgQmCah2Au+GmPN1rgizOLQjI/4FK8LWbjJZ0+eOlq2gEtAp
         ticTrSebea1kO7SxVk2qAtKCCkigSY6P2ed+DOMXIhM6jOkL1EKKnlZR7X9a/fQJGdZu
         WcFhK3doAI8pHjuf+iifpl4cefHkDergVFqU8RH3nqR15N+NnTzniTCYABGOUK4YVGNm
         Vbyw==
X-Forwarded-Encrypted: i=1; AHgh+Rr62SrV4scoTPvJX0Hc/fxnhqT/nJVzrtmUv23UtoLGA4ifX2aoavrI87t2acAii9ZLAs+Go3C20R088lfC2hZulV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNexzwnVIa4H+4/aWd0BEnIIBpRuod83hqw/nR+PRBQmfeF8vj
	2Vw4mqzhXk3BpKqE2Z0kKre61+t0PZp42fSPL1/u1P/JDpasNWQD6pHU
X-Gm-Gg: AR+sD11JkrEvbydgCEB98myy9CtR/Fjgx254YM4GaGtvGG+L6lqrLhxlGojUbwmvyQq
	Byj8GU9nu9NAXOdyv/MiP9so2QEzk/TDs52Kpzqi1b3eD/0qRRn2otuQ+12pe35BSYkM1TqsqsG
	Z2i2vswYfbCnBQgxzLUcy9sfVsnEAuqAmXAosebNql4zfp/aPfMzEGBv1/raLkFIsVQYRrcbfFZ
	uVtFJ5I9y4JU6AzvWp70PG1YD0Ai4mDebYD0iSrcE8tXMjTK1k8H3UNt3oV+ivuO48XoVRwB6Jr
	heGdW0tBT01+gf348Czm49h2BKv2hVoot6QaAcvbx7JcvVVganGlwWbBmoOvt7eXmHGhNPsdRgz
	DU3Qj0AQNvtBnLGFWJgPfsI6WlP9BxASWJo5kmykyFA436A+Dr6EzHEhhLbXHTxU2xf46Cyd7vh
	W23fRz/kjR2UjLNC9xussFdzxGQPtLHWijqTA78dSiRTCM0u9bnSZY/JS1q4fs90eszJoZEpyA3
	l5dR5U=
X-Received: by 2002:a17:90b:39a6:b0:37c:6130:7a5b with SMTP id 98e67ed59e1d1-3955a7467f8mr6401620a91.8.1787033490697;
        Mon, 17 Aug 2026 23:11:30 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3954d38bf94sm4633942a91.9.2026.08.17.23.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 23:11:30 -0700 (PDT)
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
Subject: [RFC PATCH 7/7] mm/damon/perf: add CONFIG_DAMON_PERF_DEBUG and pipeline health check
Date: Tue, 18 Aug 2026 14:10:31 +0800
Message-ID: <20260818061031.827057-8-kunwu.chan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818061031.827057-1-kunwu.chan@linux.dev>
References: <20260818061031.827057-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lian Wang <lianux.mm@gmail.com>

Add CONFIG_DAMON_PERF_DEBUG as an optional Kconfig option that
enables pr_debug() output for the observability pipeline via the
damon_perf_dbg() macro.  Default off, zero overhead when disabled.

Add a pipeline health check to the observability selftest that
diagnoses which stage is broken when callbacks are zero, using the
existing per-CPU state and counter deltas.

Co-developed-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Lian Wang <lianux.mm@gmail.com>
---
 mm/damon/Kconfig                               | 16 ++++++++++++++++
 mm/damon/perf/debugfs.c                        |  5 ++++-
 mm/damon/perf/perf.h                           |  7 +++++++
 mm/damon/perf/stats.c                          | 15 ++++++++++++++-
 .../selftests/damon/damon_perf_obs_test.sh     | 18 +++++++++++++++++-
 5 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index 9f811510760f..35ec4d12c5b8 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -148,4 +148,20 @@ config DAMON_PERF_OBSERVE
 	  static-inline no-ops with zero runtime overhead.
 
 	  If unsure, say N.
+
+config DAMON_PERF_DEBUG
+	bool "DAMON Perf verbose debugging output"
+	depends on DAMON_PERF_OBSERVE
+	help
+	  Enable verbose per-event and per-drain pr_debug() output
+	  for the DAMON perf observability pipeline.  When enabled,
+	  key lifecycle transitions and sampling events are logged
+	  at KERN_DEBUG level, visible via dynamic_debug or when
+	  DEBUG is defined at compile time.
+
+	  This adds dmesg noise and should only be enabled for
+	  development or troubleshooting.
+
+	  If unsure, say N.
+
 endmenu
diff --git a/mm/damon/perf/debugfs.c b/mm/damon/perf/debugfs.c
index c54dd7644ac3..48f3d23c2dbc 100644
--- a/mm/damon/perf/debugfs.c
+++ b/mm/damon/perf/debugfs.c
@@ -132,11 +132,14 @@ int damon_perf_debugfs_init(void)
 	damon_debugfs_dir = debugfs_create_dir("damon", NULL);
 	if (damon_debugfs_dir == ERR_PTR(-EEXIST))
 		damon_debugfs_dir = debugfs_lookup("damon", NULL);
-	if (IS_ERR(damon_debugfs_dir))
+	if (IS_ERR(damon_debugfs_dir)) {
+		damon_perf_dbg("debugfs init failed: %ld\n", PTR_ERR(damon_debugfs_dir));
 		return PTR_ERR(damon_debugfs_dir);
+	}
 
 	debugfs_create_file("perf_stats", 0400, damon_debugfs_dir,
 			NULL, &perf_stats_fops);
 
+	damon_perf_dbg("debugfs init ok\n");
 	return 0;
 }
diff --git a/mm/damon/perf/perf.h b/mm/damon/perf/perf.h
index 78e23d436336..908c06f2e3db 100644
--- a/mm/damon/perf/perf.h
+++ b/mm/damon/perf/perf.h
@@ -18,6 +18,13 @@
 struct perf_event;
 #include <linux/types.h>
 
+#ifdef CONFIG_DAMON_PERF_DEBUG
+#define damon_perf_dbg(fmt, ...) \
+	pr_debug("damon-perf: " fmt, ##__VA_ARGS__)
+#else
+#define damon_perf_dbg(fmt, ...) no_printk(fmt, ##__VA_ARGS__)
+#endif
+
 struct damon_perf_event;
 
 /*
diff --git a/mm/damon/perf/stats.c b/mm/damon/perf/stats.c
index ae5b0037a31d..e2c1e5764d41 100644
--- a/mm/damon/perf/stats.c
+++ b/mm/damon/perf/stats.c
@@ -67,6 +67,7 @@ void damon_perf_observe_event_created(struct damon_perf_event *event, int cpu)
 			return;
 	}
 	*per_cpu_ptr(event->cpu_state, cpu) = DAMON_PERF_STATE_CREATED;
+	damon_perf_dbg("cpu %d: event created\n", cpu);
 	damon_perf_cpu_state_advance(cpu, DAMON_PERF_STATE_CREATED);
 }
 
@@ -76,6 +77,7 @@ void damon_perf_observe_event_bound(struct damon_perf_event *event,
 	if (event->cpu_state)
 		*per_cpu_ptr(event->cpu_state, cpu) = DAMON_PERF_STATE_BOUND;
 	damon_perf_cpu_state_advance(cpu, DAMON_PERF_STATE_BOUND);
+	damon_perf_dbg("cpu %d: event bound\n", cpu);
 }
 
 void damon_perf_observe_event_enabled(struct damon_perf_event *event,
@@ -84,12 +86,14 @@ void damon_perf_observe_event_enabled(struct damon_perf_event *event,
 	if (event->cpu_state)
 		*per_cpu_ptr(event->cpu_state, cpu) = DAMON_PERF_STATE_ENABLED;
 	damon_perf_cpu_state_advance(cpu, DAMON_PERF_STATE_ENABLED);
+	damon_perf_dbg("cpu %d: event enabled\n", cpu);
 }
 
 void damon_perf_observe_event_disabled(struct damon_perf_event *event,
 		int cpu, int state)
 {
 	/* State unchanged: the event may be re-enabled later. */
+	damon_perf_dbg("cpu %d: event disabled\n", cpu);
 }
 
 void damon_perf_observe_event_destroyed(struct damon_perf_event *event, int cpu)
@@ -104,6 +108,7 @@ void damon_perf_observe_event_destroyed(struct damon_perf_event *event, int cpu)
 	 */
 	if (event->cpu_state)
 		*per_cpu_ptr(event->cpu_state, cpu) = DAMON_PERF_STATE_UNINIT;
+	damon_perf_dbg("cpu %d: event destroyed\n", cpu);
 }
 
 void damon_perf_observe_event_free(struct damon_perf_event *event)
@@ -111,6 +116,7 @@ void damon_perf_observe_event_free(struct damon_perf_event *event)
 	if (event->cpu_state) {
 		free_percpu(event->cpu_state);
 		event->cpu_state = NULL;
+		damon_perf_dbg("event freed\n");
 	}
 }
 
@@ -231,6 +237,7 @@ void damon_perf_observe_drain(unsigned int total, unsigned int matched)
 {
 	if (trace_damon_perf_drain_enabled())
 		trace_damon_perf_drain(total, matched);
+	damon_perf_dbg("drain: total=%u matched=%u\n", total, matched);
 }
 
 /*
@@ -291,5 +298,11 @@ void damon_perf_stats_aggregate(struct damon_perf_stats *dst)
 
 int damon_perf_framework_init(void)
 {
-	return damon_perf_debugfs_init();
+	int ret = damon_perf_debugfs_init();
+
+	if (ret)
+		damon_perf_dbg("framework init failed: %d\n", ret);
+	else
+		damon_perf_dbg("framework init ok\n");
+	return ret;
 }
diff --git a/tools/testing/selftests/damon/damon_perf_obs_test.sh b/tools/testing/selftests/damon/damon_perf_obs_test.sh
index 4c4074cdd191..cd567c151ae6 100755
--- a/tools/testing/selftests/damon/damon_perf_obs_test.sh
+++ b/tools/testing/selftests/damon/damon_perf_obs_test.sh
@@ -344,7 +344,7 @@ max_cpu_state() {
 	} END { print max+0 }' "$1" 2>/dev/null
 }
 
-CPU_ST_BASE=$(max_cpu_state "$STATS_BASE")
+CPU_ST_BASE=$(max_cpu_state /sys/kernel/debug/damon/perf_stats)
 
 if [[ "$CPU_ST_BASE" -ge 1 ]]; then
 	pass "Event Created (max per-CPU state >= CREATED)"
@@ -431,6 +431,22 @@ VALID=$(delta valid)
 ADDR_ZERO=$(delta addr_zero)
 KERNEL=$(delta kernel)
 ENQUEUE=$(delta enqueue)
+# Pipeline health check: diagnose which stage is broken when
+# callbacks are zero, using the existing per-CPU state and
+# counter deltas.  This is a best-effort diagnostic, not a
+# substitute for detailed per-backend debugging.
+if [[ "$CALLBACK" -eq 0 ]]; then
+	CPU_ST_BASE_VAL=$(max_cpu_state /sys/kernel/debug/damon/perf_stats)
+	if [[ "$CPU_ST_BASE_VAL" -le 1 ]]; then
+		echo "  Pipeline diagnosis: event not created or bound (state=$CPU_ST_BASE_VAL)"
+	elif [[ "$CPU_ST_BASE_VAL" -eq 2 ]]; then
+		echo "  Pipeline diagnosis: event bound but not enabled (state=BOUND)"
+	elif [[ "$ENQUEUE" -eq 0 ]]; then
+		echo "  Pipeline diagnosis: PMU not producing data or AUX pipeline broken"
+	else
+		echo "  Pipeline diagnosis: samples enqueued but none valid"
+	fi
+fi
 DEQUEUE=$(delta dequeue)
 OVERFLOW=$(delta overflow)
 MATCH=$(delta match)
-- 
2.43.0

