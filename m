Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA77E3E764F
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Aug 2026 06:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787033488; cv=none; b=m2lkzPopZ9jfi1guxTUzf+XErnLScO59o3J6YOvdXKmZ0rJ9fl0RE09xJ6nYmK9xIwltA1AOR8K0utopPd1xqeFJOEtvcgFwn9BdRZzf+S0Oico4ugYm/z9TkIqchmQWPRxcAh0alhFwaYYxsyK0ByZxOfi1WRrFSiK81qRqgsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787033488; c=relaxed/simple;
	bh=gXkE5z9olmERVRUNaNaZmccPuEwdj1m2bfUVPwANH4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NSKxMrVCcyEY/YxRXIlLp3wP7GCsLxyshwdK3+NMnw43L9kfq/iZe7cvm05kOQTksopktFiJnjwOCyaNaVPZFbunRWkIbV5dHGFm+zQQF/i0a49GL+NlQ7AZqkgZ1V+kC7my5yVJYH2bl+yoFNPgwfYWFD/73x+OphiA+X49hS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXqhVtPE; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXqhVtPE"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-383cb94f742so5174845a91.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 23:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787033484; x=1787638284; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OkufMBhFwqowO3sZfc9l3+J3Km3N7KYxt/zmtGdjLcc=;
        b=LXqhVtPEXSB1hNwTk+lK+OgM2xooLTIhZ1UIlKmpaugG15DUSxdsUvgn5TJeoLcnbu
         r/I1W0pLCKBTP1qyKpOUawfmeeSJCCXN2+UKmbWU7/PghMFJtFUmHfpUjThiG5GcpctM
         XBtUU5Yl2dQrIqmqHoGipAkwF4SR/PBbb8O2QwlcMNxK7lIHDL4NgF9lni2SxtS/qJ13
         WUX4bgz5Et+mysLZywxPcDphd5qW1kIZyI5n9MIta0H3K+pbP9kRV6p1WDEng2QvSuAi
         2bZIBLFfRM4rOOiG6VaFUTU+SADDHF54yFvMYlGlMyiiA2e9NQKos3UrtJP4jOX3C4wE
         vUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787033484; x=1787638284;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OkufMBhFwqowO3sZfc9l3+J3Km3N7KYxt/zmtGdjLcc=;
        b=sA0BD0yYZBEyF4z12aaL2ohju/Ts9ISzWA0J4lDLwBg5n3gp1wcIsY0RpKVoKlTbW1
         0ufn9JWd+JEbjfqXzXv2Vh+2a+yK7ON/YFgLp4YJjvOb+GsE6j2YxCXgNwds3vhi6tJu
         8pB7YR0wueD1d+rBdnsZ0BD+SpMxHWkF87lbRwOHWXU5ncTQN3TQgW1OolnfX97OnumC
         al43JAkMqMo018xktdg1Q0HqI7JAbsSR8B/IREZAoTGw8ka1/5tpy7TssVKf++nsu2kO
         T/JTXYUsnLxcGZZNlngTjwetnPKhv20hdfcY6/1D9MBdjm4IkVbgpY8//ojNNGhyY7nA
         dnMw==
X-Forwarded-Encrypted: i=1; AHgh+RrDWUHhyiB1Af93G2gm3GTMx6uNm1oHMTQv9jrYLDH+ZUkw6FDxjgRVpi394hesuMfNQRDP2JOsx4+P3gwknsvBP74=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk3AYI7spZda+s839pDrTF0CJ9V1tLuXstjdUNRpwIEUjtYpIU
	ZIpPl/5qAil2uihmqx+bMIVmfvePieqzJCl1dOB3+hjAuuDzhUo4vCY/
X-Gm-Gg: AR+sD12kaaGXwAzrv0BAIFeIvt1L6J9MFzEFihYZ6ylRyJ0amo27o3AGeZNFqrub5x9
	kqsVCCgZi7d6iifCZQZ/7t9wJ96uhi5+oRrRer6RwdHwxnpM+1pXggP2WCdsZhNvKhEFSPxtuSb
	tV8WooWDPVglsSZfbn4NRHfFo3BTw7dbuh7odIh06XHtHeELIfrAxthJI1jrUuApbyUzDQsyDMX
	se6E0XbfGwEaA48DXI6qXpgR/gxHfwQZlSHjAs5QbJKgfXwXzNYKnHIEwDPYUBQ26FKM49J0FWR
	ajneVGQNaZF7I6BeUvRw+gweQzBqv2X0i6GZdcYDmtmUHbRoYnBpbqIrd6gpTuFFrmkzctR4sH8
	PsC8maE4OKujPSkm2B94qaq391iW7AIbZhs42NoaJ32oYFDpKurCWO3BS5W7kvta0HxwZmSap5i
	wktiZ/BsMmfP8IlANabrSWmTYKz1rAlpyw4VoAvtHtfwqAlC93xY7qB6NJLp1ywf+ufhw8c+br9
	eRmwXkqDvYI
X-Received: by 2002:a17:90b:2f10:b0:38e:f6eb:2b38 with SMTP id 98e67ed59e1d1-3933e63ba0bmr31731771a91.17.1787033483851;
        Mon, 17 Aug 2026 23:11:23 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3954d38bf94sm4633942a91.9.2026.08.17.23.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 23:11:23 -0700 (PDT)
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
Subject: [RFC PATCH 6/7] Docs/mm/damon: document the perf observability framework
Date: Tue, 18 Aug 2026 14:10:30 +0800
Message-ID: <20260818061031.827057-7-kunwu.chan@linux.dev>
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

Add documentation for the DAMON perf observability framework,
covering the CONFIG_DAMON_PERF_OBSERVE Kconfig option, the
debugfs perf_stats interface, the tracepoints, and the per-CPU
pipeline counter model.  The debugfs format is explicitly marked
as unstable and must not be used by scripts.

Co-developed-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Lian Wang <lianux.mm@gmail.com>
---
 Documentation/admin-guide/mm/damon/index.rst  |   1 +
 .../mm/damon/perf-observability.rst           | 210 ++++++++++++++++++
 2 files changed, 211 insertions(+)
 create mode 100644 Documentation/admin-guide/mm/damon/perf-observability.rst

diff --git a/Documentation/admin-guide/mm/damon/index.rst b/Documentation/admin-guide/mm/damon/index.rst
index 3ce3164480c7..623a5c312b69 100644
--- a/Documentation/admin-guide/mm/damon/index.rst
+++ b/Documentation/admin-guide/mm/damon/index.rst
@@ -15,3 +15,4 @@ access monitoring and access-aware system operations.
    reclaim
    lru_sort
    stat
+   perf-observability
diff --git a/Documentation/admin-guide/mm/damon/perf-observability.rst b/Documentation/admin-guide/mm/damon/perf-observability.rst
new file mode 100644
index 000000000000..3aa8185de314
--- /dev/null
+++ b/Documentation/admin-guide/mm/damon/perf-observability.rst
@@ -0,0 +1,210 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============================================
+DAMON Perf Event Observability Framework
+=============================================
+
+The DAMON perf event observability framework provides per-CPU counters and
+tracepoints for hardware-sampled access reports.  When DAMON is configured to
+use a hardware PMU (e.g. AMD IBS, Intel PEBS, or ARM SPE) instead of page-table
+walks, this framework exposes raw pipeline diagnostics so that every stage of
+the PMU-to-DAMON pipeline can be inspected.
+
+Counters are best-effort: individual ``u64`` writes are atomic on 64-bit
+platforms, but no cross-field consistency is guaranteed.  Do not build
+policy on snapshot reads.  For stable, structured diagnostics, use the
+tracepoints under ``/sys/kernel/debug/tracing/events/damon/``.
+
+Pipeline Stages
+===============
+
+::
+
+  PMU hardware → overflow_handler / AUX drain
+    → damon_report_access() → per-CPU SPSC ring
+    → kdamond drain → target match → region update
+
+  Layer 1:  Event Create   perf_event_create_kernel_counter()
+  Layer 2:  Event Bind     per-CPU PMU attachment
+  Layer 3:  Event Enable   perf_event_enable()
+  Layer 4:  Sampling       callback / AUX record received
+  Layer 5:  Ring           SPSC enqueue / dequeue / overflow
+  Layer 6:  Drain          kdamond consumes entries from ring
+  Layer 7:  Match & Update region access-rate update
+
+Each layer has a dedicated counter, and most layers have corresponding
+tracepoints.  Per-CPU event state (UNINIT → CREATED → BOUND → ENABLED →
+RUNNING) is recorded unconditionally and exposed via the debugfs
+perf_stats file.
+
+Overhead Control
+================
+
+Two levels of overhead control are provided:
+
+1. **Compile-time** — ``CONFIG_DAMON_PERF_OBSERVE``
+   When set to ``n``, all observe functions are compiled to static-inline
+   no-ops.  No code is generated and no runtime overhead exists.
+
+2. **Per-tracepoint on/off** — standard ftrace ``enable`` files
+   Individual tracepoints (``damon_perf_sample``, etc.) can be
+   enabled or disabled independently via
+   ``/sys/kernel/debug/tracing/events/damon/``.  Counter increments are
+   unconditional (cheap per-CPU ``inc``); tracepoint decisions are
+   guarded by the ftrace static key and are zero-overhead when disabled.
+
+When ``CONFIG_DAMON_PERF_OBSERVE=y``, per-CPU counters always increment.
+There is no runtime toggle for counters; compile-time is the sole gate.
+
+Debugfs Interface
+=================
+
+Mount debugfs::
+
+    # mount -t debugfs none /sys/kernel/debug
+
+One file is created under ``/sys/kernel/debug/damon/``:
+
+perf_stats
+----------
+
+**DEBUG ONLY — format may change without notice.**  Do not parse in
+scripts or tools.  For stable diagnostics, use the tracepoints.
+
+Read-only.  Aggregated counter table with all pipeline counters plus
+per-CPU breakdown::
+
+    # cat /sys/kernel/debug/damon/perf_stats
+      ┌──────────────┬──────────┐
+      │ Counter      │   Value  │
+      ├──────────────┼──────────┤
+      │ callback     │    233   │
+      │ valid        │      0   │
+      │ null         │      0   │
+      │ addr_zero    │    233   │
+      │ kernel       │      0   │
+      │ inv_phys     │      0   │
+      │ enqueue      │      0   │
+      │ dequeue      │      0   │
+      │ overflow     │      0   │
+      │ ring_peak    │      0   │
+      │ match        │      0   │
+      │ miss_tgid    │      0   │
+      │ miss_region  │      0   │
+      │ miss_bound   │      0   │
+      │ update       │      0   │
+      └──────────────┴──────────┘
+
+      Per-CPU (non-zero / non-UNINIT):
+      CPU00: st=BOUND   cb=44 enq=0 deq=0 ovf=0 match=0 miss=0 upd=0
+      ...
+
+The ``st=<state>`` column shows the per-CPU event state machine position
+(UNINIT, CREATED, BOUND, ENABLED, RUNNING, ERROR), derived from the
+lifecycle observe calls.  This allows verifying lifecycle progression
+without parsing dmesg.
+
+All counters are monotonic (cumulative since boot); userspace computes
+deltas between snapshots.
+
+Tracepoints
+===========
+
+Four tracepoints are defined::
+
+    damon_perf_sample
+    damon_perf_ring_overflow
+    damon_perf_report_missed
+    damon_perf_drain
+
+Enable via ftrace::
+
+    # echo 1 > /sys/kernel/debug/tracing/events/damon/damon_perf_sample/enable
+    # cat /sys/kernel/debug/tracing/trace_pipe
+
+Each ``damon_perf_sample`` record includes:
+
+  - ``addr``: the accessed virtual address (0 if the PMU did not populate)
+  - ``data_src``: PERF_MEM_* encoding (PMU-dependent)
+  - ``period``: sample period or frequency count
+  - ``cpu``: CPU that generated the sample
+  - ``reason``: 0=valid, 1=null-data, 2=addr-zero, 3=kernel-addr, 4=invalid-phys
+  - ``sample_flags``: what the PMU actually populated
+  - ``sample_type``: what DAMON requested
+  - ``context``: 0=process, 1=softirq, 2=hardirq, 3=NMI
+
+The ``context`` field is particularly useful for cross-PMU validation.
+For example, AMD IBS samples arrive in NMI context (context=3), while
+ARM SPE data from an AUX backend would arrive in process context (context=0).
+A mismatch between the expected and actual context is immediately visible.
+
+Selftest
+========
+
+A comprehensive automated test script is provided::
+
+    # cd tools/testing/selftests/damon
+    # sudo ./damon_perf_obs_test.sh --pmu arm_spe_0 --freq 0 --period 256
+
+The script performs a layer-by-layer validation:
+
+1. Checks kernel configuration (CONFIG_DAMON, CONFIG_DAMON_PERF_OBSERVE, etc.)
+2. Verifies PMU availability, tracepoints, and the debugfs perf_stats file
+3. Refuses to run if existing kdamonds are present (side-effect guard)
+4. Configures DAMON with the specified PMU via sysfs
+5. Runs a memory workload (stress-ng, stress, or dd fallback)
+6. Collects dmesg delta, trace output, and perf_stats
+7. Verifies per-CPU state progression and counter values
+
+Example output::
+
+    --- Layer 0: Environment ---
+    [PASS] CONFIG_DAMON_PERF_OBSERVE=y
+    [PASS] debugfs perf_stats exists
+
+    --- Layer 2-3: Enable & Run (via per-CPU state) ---
+    [PASS] Event Created (max per-CPU state >= CREATED)
+    [PASS] Event Bound (max per-CPU state >= BOUND)
+    [PASS] Event Enabled (max per-CPU state >= ENABLED)
+
+    --- Layer 4: Sampling (Callback) ---
+    [PASS] Sampling: 84532 callbacks received
+    Callback breakdown: valid=82103 addr_zero=0 kernel=2429
+
+    --- Layer 5: Ring ---
+    [PASS] Ring: enqueue > 0
+    [PASS] Ring: dequeue > 0
+    Ring: enqueue=82100 dequeue=81987 overflow=0
+
+    --- Layer 6: Drain & Match ---
+    [PASS] Drain & Match: 81987 matched
+    [PASS] Update: 81987 region updates
+
+Additional PMU examples::
+
+    # Software page-fault event (positive control):
+    sudo ./damon_perf_obs_test.sh --pmu software --freq 1 --sample-freq 100
+
+    # Any PMU by type number:
+    sudo ./damon_perf_obs_test.sh --pmu-type 38 --freq 0 --period 256
+
+Kernel Configuration
+====================
+
+Required for observability::
+
+    CONFIG_DAMON=y
+    CONFIG_DAMON_SYSFS=y
+    CONFIG_DAMON_VADDR=y
+    CONFIG_PERF_EVENTS=y
+    CONFIG_DEBUG_FS=y
+    CONFIG_TRACING=y
+    CONFIG_TRACEPOINTS=y
+
+Optional (enables observability framework)::
+
+    CONFIG_DAMON_PERF_OBSERVE=y
+
+When ``CONFIG_DAMON_PERF_OBSERVE=n``, ``/sys/kernel/debug/damon/perf_stats``
+is not created, tracepoints are not registered, and all observe functions
+are compiled to empty static inlines with zero overhead.
-- 
2.43.0

