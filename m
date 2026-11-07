Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794030760;
	b=5EX578nJyEhVdbywJY4zRUngEt028H3BcUshAsOyQE2Ww2fO/IgkxJymRnqcvZW65RAn
	 d6EDyF/pqrCGdd56DxDBOFlTUymt7FIckmTroaLBzflCsTcoMIxooLpaVMQnT7eCKnN59
	 Q7LDNguE9vu+S0i9OCt7K4jMkfaDftoN+I8/7mZNZQjLwctFFZRhxLhCpBV9oWV0tbjY/
	 n08wbgfDBH5G8FVnTAJLbxBZrrAldoWxgd0vnmpmPmcj8fH1Ylb2rcSq6OPz1Zh1tOnEr
	 eQ/GTW6eFiSrGg59hyUU1UWwp8TdxV3ppdCSiemRp4UpKW85YX3OgidOnpHjpRyCf2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794030760;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=u4nTXiGvoLBPJ6m6vBAshKxDWZY7SBPxeVPpU162HBU=;
	b=1KHS8NkU/epdONJj6OAtGQ8dUYA0vK0xp5gzBD54QOyndrspoQwetRhcDEspLRv5VeSz
	 bgiuHutgwQ+7HY1FQS54mapghcb2EKjQext064qcFK0+5bpEPiW9JiRxDz3IM0iM9CXfQ
	 8+JsP8lcnvV7bBt+s0Krjjgwen7pNrSWjDhnsNrwiT2IS8/OywAmv2CFJxhAG7gyeZ1rk
	 hQ2QcU01GOMtK2gPHTiVeysofg1SschU+qEJ3fpve67x6i6TKNWz/QvNzh2xgTWwvzclQ
	 SbuHkDGhtDomXX17gGUD02km2m1SzGYtXHjiTJSyS8QraEbIyflvJuxVqVbX9zpPNTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sTqb2z+O;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C475606A32D
	for <linux-trace-kernel@vger.kernel.org>; Sat,  7 Nov 2026 05:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C475606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sTqb2z+O
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ed1414df17so5053985ad.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Nov 2026 21:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794030759; x=1794635559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u4nTXiGvoLBPJ6m6vBAshKxDWZY7SBPxeVPpU162HBU=;
        b=sTqb2z+Ot/B3iVi+LnWhL32Lbw/KBWJT8Nl/gLMpAslqtMx1sopqaITkjS/bC9tz2a
         oMmWG2xiahslalTLRYjLCx7AHb/oUXDC/7gnoI79oOqpVZF3sjaeRgvGdkERzNMWcrGg
         MZHWbGpaOJyeqiMP471einPsifL6/nuAzOdE7gBMFvq/oeQybdZ0BkjUiXk3joRvqGiT
         WGsROdgKOIoNFsdscRwWsP/CF1LJVluuJjTx2W2iIb62Cm5hQ5ZBOEp0T0Sa3dcUjlb7
         uv8eu6CoaXeF+rjFA5TEqXyzKN2I550LLOcG9BMHrss6JdP5FADjqvtZ1W0TE0YGvCbw
         XPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794030759; x=1794635559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u4nTXiGvoLBPJ6m6vBAshKxDWZY7SBPxeVPpU162HBU=;
        b=oJI38sdSTui4hmoYpBig3MQQDTCNkRrl00HFPRyswiW/ykjRBp42/iuWLR1X2LkpIW
         6Nq9Ak+CzFRH+4uXLivuigSgYcyHym/12kq7Sn3hJ7UCs+NKwxdIY8XSiB7x9jiPfrnZ
         xq+SnhYaisMDIExLQh9kacOQTNS76mi96fsJyvXnAbHL70cwIYA3tZSfELRQqW0gbCvi
         jvuV8DX5pTGwNQR0r7E94TrpT/bSr/V4yD4sPhbFfU0No98PhUan58/A7p5FPIKL7Iwd
         QOttOG5sDJmN1FwRim0U9H0KjcJCRzxE/xXd1iFUCKUPjk+79jK1afLF+LjKDzvw9BPS
         mekw==
X-Forwarded-Encrypted: i=1; AL+hErEWKphSp0mmAKGCG6E3bEXCTwb8Uaj6CWYsZZeiUIPJsPipHOwVGxrYxaoZj7UyM5p9E1Oy1v0xSqu23op7IgWpfiY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/5VKMvOsAS2ClZaGvKO26sFFH/2AHSL3XZPYfREPK//4VHUbuO
	6G1WLYlgescDJc7+s+SPoD+LUc8vo9dQs8+d+C7ZnFDhonVG2YZlbJzv
X-Gm-Gg: AYBFou1Vjwe77nUu6DHGXAOq1HSgAmn7dNhCuj8OB52Ei1DUqldvUU1zjjozSEpg8jZ
	FPAGqybEJ0R5AZhJLbngv1LmoiB7h0P6kiFD/WtQmyDNN+dXLtd2noQGd5YS4t3DWs06OOLP70e
	MedTWc8oxaaXxka6BHsRfGIx2lqVJijol9RgVymfOiEayn7Fl6amdM5ozXQ+BcIpUY5qRvffus+
	bOU/jWXPQ0q+HVDPZT9CBdNI+OaLWLUd9/qE6ybEY/kU6F+2sUmUXHwehJnKtuw0pgF+7ukumiC
	Ng35RxgXGad+0qwiV49lHiTrO5LBQyQ3K2y4QKIcJMS6mJn57aKu4QIRz1sg+pDXbtxB8wjbANj
	fED+tKyGtheHiyuCHC1kSEMh4hu2HAgFbCgDa6h5UGqBKrZwR7YqU7Ucfb57y/Rw4PEDconZQED
	IVPMfm8ar/RM+EeGEZxNu/Zmlby64rMsV7JcLX98VJhBs4xM3EV3jm6d+RYGm770STA2vepWUSz
	xZqIJpXgKbiZwJZpTLgthl2ulx3/77pmaB+YlwzFs061tQOesSfi8NUFjCG39MM90PEdhyErHwu
	63wBqcqKRCtkyLYFLp1P5UvWGg1jZmrO+ZeD2B5vfhUjLDhMMQFbYsYkB+vpKLs7HizxDw==
X-Received: by 2002:a17:903:1a30:b0:2ed:18cc:d3b3 with SMTP id d9443c01a7336-2ed405ee120mr57893445ad.6.1794030758978;
        Fri, 06 Nov 2026 21:52:38 -0800 (PST)
Received: from lipengfei28-ThinkStation-P368.mioffice.cn ([2408:8607:1b00:8:a1a:7bc2:20ba:a479])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d8949fsm11189465ad.62.2026.11.06.21.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 21:52:37 -0800 (PST)
From: Li Pengfei <ljdlns1987@gmail.com>
X-Google-Original-From: Li Pengfei <lipengfei28@xiaomi.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	mark.rutland@arm.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhangbo56@xiaomi.com,
	lipengfei28@xiaomi.com,
	lkp@intel.com
Subject: [PATCH v8 4/5] Documentation: tracing: Document the ftrace stackmap
Date: Sat,  7 Nov 2026 13:51:38 +0800
Message-Id: <20261107055139.3138633-5-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261107055139.3138633-1-lipengfei28@xiaomi.com>
References: <20261107055139.3138633-1-lipengfei28@xiaomi.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pengfei Li <lipengfei28@xiaomi.com>

Describe how to use the stackmap, how reset and free behave, and how to
resolve a trace that spans resets. List the option in ftrace.rst.

Assisted-by: LLM
Signed-off-by: Pengfei Li <lipengfei28@xiaomi.com>
---
 Documentation/trace/ftrace-stackmap.rst | 192 ++++++++++++++++++++++++
 Documentation/trace/ftrace.rst          |   6 +
 Documentation/trace/index.rst           |   1 +
 3 files changed, 199 insertions(+)
 create mode 100644 Documentation/trace/ftrace-stackmap.rst

diff --git a/Documentation/trace/ftrace-stackmap.rst b/Documentation/trace/ftrace-stackmap.rst
new file mode 100644
index 000000000000..58af7c564b10
--- /dev/null
+++ b/Documentation/trace/ftrace-stackmap.rst
@@ -0,0 +1,192 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================
+Ftrace Stack Map
+======================
+
+:Author: Pengfei Li <lipengfei28@xiaomi.com>
+
+Overview
+========
+
+The ftrace stack map provides stack trace deduplication for the ftrace
+ring buffer. When enabled, instead of a full kernel stack trace event
+(typically 80-160 bytes) for each stack the map can store, ftrace writes a
+fixed-size event of 20-24 bytes, depending on the architecture, that holds
+a 64-bit cookie: the map generation in the high 32 bits and the slot index
+in the low 32. The full stacks are kept once in a separate hash table and
+exported via tracefs for userspace to resolve.
+
+It is similar to eBPF's ``BPF_MAP_TYPE_STACK_TRACE``.
+
+Configuration
+=============
+
+Enable ``CONFIG_FTRACE_STACKMAP=y`` in the kernel config.
+
+The map holds up to 16384 distinct stacks. It is allocated when the
+``stackmap`` option is first enabled; if the allocation fails, enabling
+the option fails with ``-ENOMEM``. The map stays allocated while the
+option is turned off, so a trace can still be resolved, until ``free``
+is written to ``stack_map``. On a 64-bit kernel the map takes about
+8.6 MiB.
+
+Usage
+=====
+
+Enable stack deduplication for event stacks::
+
+    echo 1 > /sys/kernel/tracing/options/stackmap
+    echo 1 > /sys/kernel/tracing/options/stacktrace
+    echo 1 > /sys/kernel/tracing/events/sched/sched_switch/enable
+
+The function tracer records stacks through its own option instead of
+``stacktrace``::
+
+    echo vfs_read > /sys/kernel/tracing/set_ftrace_filter
+    echo function > /sys/kernel/tracing/current_tracer
+    echo 1 > /sys/kernel/tracing/options/func_stack_trace
+
+The trace output will show ``<stack_id N gen G>`` instead of full stack
+traces, where N is the slot and G the map generation::
+
+    sh-1234 [006] d.h.. 123.456789: <stack_id 42 gen 1>
+
+Stacks are not always replaced. A stack deeper than 64 frames, a stack
+recorded before the map is allocated or during a reset, a stack that
+another context is inserting at the same moment, and a stack the map
+cannot store (element pool exhausted, probe limit, or ring buffer
+reservation failure) are recorded in full. A trace can therefore contain
+both ``<stack_id N gen G>`` records and full ``<stack trace>`` records.
+With the option enabled, a stack recorded where RCU is not watching is
+discarded.
+
+To view the actual stacks::
+
+    cat /sys/kernel/tracing/stack_map
+
+Output format::
+
+    stack_id 42 gen 1 ref 1337 depth 8
+     => schedule+0x48/0xc0
+     => schedule_timeout+0x1c/0x30
+     ...
+
+``ref`` is the number of times the stack was recorded as a cookie since
+the last reset. It is not decremented when events leave the ring buffer,
+and it saturates at ``INT_MAX``.
+
+To view statistics::
+
+    cat /sys/kernel/tracing/stack_map_stat
+
+Output::
+
+    generation: 1
+    entries: 2500
+    capacity: 16384
+    successes: 148923
+    fallbacks: 0
+
+``entries`` is the number of map elements reserved since the last reset;
+an insertion in progress can make it briefly exceed the number of records
+in ``stack_map``. ``successes`` is the number of stacks recorded as a
+cookie. ``fallbacks`` is the number of stacks the map could not store
+because the element pool was exhausted or the probe limit was reached;
+those are recorded in full instead. The other cases above are not
+counted. A growing
+``fallbacks`` count means the map is too small or too crowded; a reset
+makes room again. The file is empty while no map is allocated.
+
+To reset the stack map::
+
+    echo 0 > /sys/kernel/tracing/stack_map
+
+To release the map once the option is off::
+
+    echo 0 > /sys/kernel/tracing/options/stackmap
+    echo free > /sys/kernel/tracing/stack_map
+
+``free`` fails with ``-EBUSY`` while the option is enabled. A ``stack_map``
+file opened for reading before ``free`` keeps the old map. ``free`` blocks
+until all such files are closed, then releases the memory, so a process
+that has one open must close it first. If ``free`` is written through a
+file that is also open for reading, that file is not waited for: ``free``
+returns and the memory is released when that file is closed. If the writer
+is killed while it waits, the map has already been removed, and its memory
+is released when the last such file is closed.
+
+Reset clears the map without touching the trace buffer, and tracing does
+not have to be stopped. Reset and ``free`` both leave cookies in the trace
+buffer; the generation changes, so those cookies no longer match the map.
+A cookie only resolves against ``stack_map`` records of the same
+generation. The generation in a cookie is 32 bits. It only has to tell
+resets apart, and wraps after 2^32 resets and frees.
+
+To resolve a trace that spans resets, save ``stack_map`` before each
+reset. ``stack_map`` is not a snapshot of concurrent insertions: a read
+can include stacks inserted while it is in progress and can miss stacks
+inserted into slots it has already passed. A reader that spans a reset
+can get records of two generations across separate ``read()`` calls; the
+``gen`` field shows this. Stop tracing across the copy and the reset if
+every record must resolve.
+
+Boot-time activation
+====================
+
+The stackmap option can be enabled from the kernel command line::
+
+    trace_options=stackmap,stacktrace
+
+The map is then allocated when tracefs initializes. Stacks recorded before
+that are recorded in full. If the allocation fails, the option is turned
+off and a warning is printed.
+
+The stack_map files
+===================
+
+``stack_map`` (mode 0640) and ``stack_map_stat`` (mode 0440) exist when
+``CONFIG_FTRACE_STACKMAP`` is enabled, also before the map is allocated.
+While no map is allocated, both are empty. Writing ``0`` to ``stack_map``
+resets the map; writing ``free`` releases it.
+
+Design
+======
+
+The stack map is modeled after ``tracing_map.c`` (used by hist triggers):
+
+- **Lookup/Insert**: Lock-free via ``cmpxchg``, safe in NMI and IRQ context
+  where RCU is watching
+- **Memory**: Pre-allocated element pool, no allocation on the hot path
+- **Collision**: Linear probing with a 2x over-provisioned table; probe
+  length is bounded so worst-case insert/lookup is O(1)
+- **Scope**: Top level trace array only
+- **Hash**: 32-bit jhash with a per-map random seed; full ``memcmp``
+  confirms matches
+
+The map holds at most one copy of a stack per generation. When a lookup
+reaches a slot with the same hash whose element is not yet published,
+another context is inserting that stack, or another stack with the same
+hash. The lookup does not wait, because in NMI context it may have
+interrupted that insert, and it does not add a second copy; that one stack
+is recorded in full instead. A context that loses the ``cmpxchg`` for a
+free slot re-reads the slot for the same reason.
+
+Differences from ``tracing_map``
+--------------------------------
+
+The table, the element pool and the probing follow ``tracing_map``. The
+stack map differs where its callers differ:
+
+- ``tracing_map_clear()`` requires its caller to keep inserts out. The
+  stack map does this itself: new callers are kept out and admitted ones
+  are drained with RCU before the map is cleared, so a reset can be
+  written to ``stack_map`` while tracing is active.
+- An insert that meets an unpublished element of the same hash records
+  the stack in full, which loses nothing. ``tracing_map`` spins instead,
+  since a lost insert there is a lost histogram update.
+- Probing stops after 64 slots, so a slot claimed without an element can
+  stay claimed. ``tracing_map`` has no probe limit and releases such a
+  slot, so that its loop always reaches a free slot.
+- The cookie is the slot index, so it stays valid while the map is not
+  reset; ``tracing_map`` hands out element pointers.
diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 84f06bf0da9b..f90cf7575458 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -1396,6 +1396,12 @@ Here are the available options:
 	When set, a stack trace is recorded after any trace event
 	is recorded.
 
+  stackmap
+	When set, a recorded stack trace is replaced by a cookie that
+	refers to a single copy of the stack in the stack_map file.
+	Only for the top level trace array. See
+	Documentation/trace/ftrace-stackmap.rst.
+
   branch
 	Enable branch tracing with the tracer. This enables branch
 	tracer along with the currently set tracer. Enabling this
diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index 5d9bf4694d5d..ac8b1141c23a 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -33,6 +33,7 @@ the Linux kernel.
    ftrace
    ftrace-design
    ftrace-uses
+   ftrace-stackmap
    kprobes
    kprobetrace
    fprobetrace
-- 
2.34.1

