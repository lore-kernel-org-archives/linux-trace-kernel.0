Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9187E337688
	for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Aug 2026 01:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787276550; cv=none; b=sPK8dDlHlb96D1V6Fx5YlhrQ1JD0ncZ37YMj/FtuEN+vDIHQpCSRR0bCfmTdNjXKtNCcHbAMQdNMwjz9/zoFHD3SAp4qiBXLopS2+ouGfS4iDAIon90M6vKvifO2YX43VhWT5cvmR6BanZxXpSc6jxeL3IdgxSaesp7gEEz5ZPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787276550; c=relaxed/simple;
	bh=cnGO77SZwM6ztR2iXPrLT1hQRzW3joCybwJahJ7pjaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KDhPzWedvAOKjW2fy0wJEd+Za9AolPkeyhPApZDWRx/ImQ055gPXV7iB7GQ1+73i23qAhxiJfJZJvUVtN+ezBe7uTQJir90/QgH0A0DRNdGVlazTDPbCuBqU8doKWYGaUeAGEpFAxfkzztphaOxOtQn9ClwNQFK+/2RbXQjjLzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tCS+sxW1; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tCS+sxW1"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cb5b8572b70so620635a12.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Aug 2026 18:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787276549; x=1787881349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IPPlPTzVw1FwO75QG0O3qCtpPyGRlfV8iguadoA9NEM=;
        b=tCS+sxW1mFfpp8fg+Fv9HH1hdnzpHYIPw/KdCo0C+o0FPJdevpsMQGKLQA9WUjphCE
         TW47o6/oVvqAPBwKmQocey6+oyuvvdKECUo8+w7+7ahKyjz9CJin0aPe+R1y9qNzKWDM
         u4n8kObdctDV2kFtVf2fedJfWLVPbXDXkCeVN4bq0WQQlU5GpAbGPc3J0zEqAdvKFYL+
         nMLeKB8+qfTvfJaSKpnSg9FBfNc+Xdm4vOeBOm8komiiTBgvDiOdJLKRN/xIKZhsa2WJ
         NnmhRPn9DvBWmsOlhi/nJRlqXe92By4XY4CMV6e0jOlgccqoXMMdzyv9RsakfRIvmuTn
         L3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787276549; x=1787881349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IPPlPTzVw1FwO75QG0O3qCtpPyGRlfV8iguadoA9NEM=;
        b=W80+4qhILFjrIqRyQhZ5dfc6vL1D7CAS8GxKZN7Kx20rAQ3+1y86xVvgpqTzPsXm+D
         OKNcGuG/Yi8mXhHmpYYRUcTczFU2Xzig4kJR0STFq4JtHeo+dSMV82GEVh2D15exClhY
         XWUCJHhQ/eTKZgazG5ue0tvfMHQIqXpZVV+2QDe9Qr+Wg8jOAs9pEqOfg7/4HZvGcn7f
         EWftyHsgXtqMsWwyorWcuIRlO0Evg7cMfRkcpGKDHtxfVNQw/fvXtciBjOnBUDk+EPxm
         SorT6RuiUI9QHfiGXnwHOz0ZasSp5TpkAwRwUa0Z8Cc4O2r4OuCnJQrx4heyELkVaSsU
         siWw==
X-Forwarded-Encrypted: i=1; AHgh+RorgyImQc8scTFwREu64D8ZoIsr5KJ2K2xrUePuJWYPJX0LGhTz4VoqcbdvT/bTkOrkEITJH9Zuhtwp9XcpesnIZUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUWU9mLtiYUOhyP8fNSV70wZzp7Mnv4aQGGg7aEcxrYl2M4WUV
	ci9T/biBWaCbNHaoYhXaANLRvHLqc00+QZmYUHw/jtGv9L5XeBgHzoK5
X-Gm-Gg: AR+sD10LdzOGmXnhEB2MauSu24bs5gKAcGDyBjUbcEiH0lv31eoKdlmE+v8kF6D5tCn
	P2HfHAORSVNtRoc8fsQmCjSa4mzzUP7mvsE0avInlHjOE3h86f62teaqJeCQPcbvGFaPRuVpeDB
	dBOvnBd8SLEYeMIuMoQHVygbIk9KRQLHynaCbkQxsn4Z+wCSuOh3darfEGs62gv2uznaJfnKo9y
	U6zNkDd8oZiXkcJ3J7Stut1taZlCupLaq1BT63HjGVVmcLWfD69UiEMBgsknRV3yEVMIsXwZO7c
	Ig3njk8+z6KbONPZW1zilTR1G3EL6Ydt23nvD1K2HodaWu37a7P6L7nrdtfiKlJ5LXcAdcrbhuB
	SWbqIrx0D5ELjYDjn1Te0oIbfmmtV7iglJWQpOd5ppn/djNZxpRcvGZ0pJdZmbgQLnIpr/IjqOV
	esE4dwSVvm1RvhfyHdqLlyHpiDJn7La5npp35Ay7JVEGP2fZUCen9Cppg8G12ntUK6urY9QlSLZ
	E/tYWzut63i3mB+MIP5K17u8Z6HIuz6pL6FolcXDblHRuyUwmgiFA==
X-Received: by 2002:a05:6a20:c90c:b0:3cc:22bb:8911 with SMTP id adf61e73a8af0-3cd2fe7a2cdmr5359717637.6.1787276548650;
        Thu, 20 Aug 2026 18:42:28 -0700 (PDT)
Received: from deepanshu-Legion-Pro-5-16AFR10.. ([2405:201:682f:383f:707f:3e47:3c20:b84e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ad53874sm32078704c88.4.2026.08.20.18.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 18:42:27 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	olsajiri@gmail.com,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>
Subject: [PATCH] perf/bpf: Fix lockless access to parent_event->prog in perf_event_alloc()
Date: Fri, 21 Aug 2026 07:12:10 +0530
Message-ID: <20260821014210.18681-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During fork(), perf_event_alloc() reads parent_event->prog locklessly
which can race with a concurrent bpf_perf_link_release() clearing and
freeing the prog via perf_event_detach_bpf_prog(). This can result in
a NULL pointer dereference or use-after-free in bpf_prog_inc().

Fix by holding bpf_event_mutex when inheriting the BPF program during
fork(). Make bpf_event_mutex non-static and declare it extern in
perf_event.h so it is accessible from kernel/events/core.c.

Fixes: 85192dbf4de0 ("bpf: Convert bpf_prog refcnt to atomic64_t")
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 include/linux/perf_event.h | 2 ++
 kernel/events/core.c       | 8 +++++---
 kernel/trace/bpf_trace.c   | 2 +-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 48d851fbd8ea..5c6dabb6dccb 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -2136,4 +2136,6 @@ static inline void perf_lopwr_cb(bool mode)
 }
 #endif
 
+extern struct mutex bpf_event_mutex;
+
 #endif /* _LINUX_PERF_EVENT_H */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index ba5bd6a78fe7..a89e33c47073 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13433,12 +13433,15 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 		overflow_handler = parent_event->overflow_handler;
 		context = parent_event->overflow_handler_context;
 #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_EVENT_TRACING)
-		if (parent_event->prog) {
-			struct bpf_prog *prog = parent_event->prog;
-
+		struct bpf_prog *prog;
+
+		mutex_lock(&bpf_event_mutex);
+		prog = parent_event->prog;
+		if (prog) {
 			bpf_prog_inc(prog);
 			event->prog = prog;
 		}
+		mutex_unlock(&bpf_event_mutex);
 #endif
 	}
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 75495a5c3507..730fc22a9daa 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1944,7 +1944,7 @@ const struct bpf_verifier_ops perf_event_verifier_ops = {
 const struct bpf_prog_ops perf_event_prog_ops = {
 };
 
-static DEFINE_MUTEX(bpf_event_mutex);
+DEFINE_MUTEX(bpf_event_mutex);
 
 #define BPF_TRACE_MAX_PROGS 64
 
-- 
2.43.0

