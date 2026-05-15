Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37FD48A2D5
	for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 14:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853612; cv=none; b=TqX9x3abKkxmMHcjM5+dk+GK3Nbgy2lvHOCkGgka0KEdW87z5KDZAIDM1MNCpN7lioeubywWJsqJSmsjcpEsMyQfj7HIBYcvwAAHsQtjz4zXlWnpNToelJt/RJx5Cbwl1N35sRmAcUnjS7MYdks8QuRpk4BJctIk0W7g/4sZluo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853612; c=relaxed/simple;
	bh=xn6M3jtoBFAqc18bYcdgC01807DqnYtE2DVmsXTENmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jNp9jfEuB6V8SqZi4gDWQPTNYKm1CUWANCFyGcaN1c0LOuI3IQaW4LVQcSjSEUfiADKF/LSLBxS5R56IpnI6YYaeTkTacsEOa0HbxnVftj9YJf/ewdNMIBSzYOga6wG4sA4Fh5yshWoajbBhIp7BxFrmFzuoO9nUDYStgcxYFrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=qXaP8fIw; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="qXaP8fIw"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8b7105dfb35so91379026d6.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 07:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1778853605; x=1779458405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0G5IkwxgvGNO4kpHPU/vpg8O9jRp6aBHr3Ah1HUHfIc=;
        b=qXaP8fIwaSzOPP+xsfBcN6219IFOdGeH7uEt95+rnLAjXjI6wpSaZyoMHOy99gDenI
         jeD86W818y22mV3okJ7d6zRkDIGxCII+FKG+Du6BZREBH6DNacCfdtMRxLJjw7i1ce4U
         BSeeAVxXjGdc/MXgOGXUtBvU72r90i2eRGvz7ZNiwVghqeRIHorjHNYPyuFKupLRV/y5
         IT4azLSiCe0wE63WFuR2J2LUh8ysnT+cATZR0KDKow+XbjIAZ6v9mEP1JNKZmmBjJCst
         C23n3YKMyeka0HsIIl1qW16302B6T+0Wf6wgId2iEwmIsT5elfAeO2zLh5H+trwMk+7o
         nQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778853605; x=1779458405;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0G5IkwxgvGNO4kpHPU/vpg8O9jRp6aBHr3Ah1HUHfIc=;
        b=D4GuAD79rNbJJSCSgN7sRsanN2utjl2AYar6Kkw9YbHbOTwS619OlhDQ0Ser39MvaS
         zvNonoEjtpg4a521gEYZiw5HAM16FgAXk5YoojjmzIxjbbbTdyyPZxKXxnNP7gDgrEy3
         mjLJCIoO3bSh8RLMl/0dE92tOg7rgw/sLzdi2ods2bSGIRztKkdFJgKna77CsjNmVGWx
         kEjYK6I0zvs6lVFVerDsQxpAcOxCCcB4F4F0cbhPO541gXOpAdw2U7310oYkIZqvKSgo
         0PcK1QQCSdRTOAtt2gcQz0rpIR2DVH5bJDSuDzqm997QqWo9CYbSuxGj4fqdN2OR9zg3
         hyrA==
X-Forwarded-Encrypted: i=1; AFNElJ8N5EI0wJkGhhJTpGP1Vo2kDzygYY7qpZQY6UvwiMaqAlsW1tGBjS512V41ekRl40tREZrFDyFl96wo8KlBAyaGwxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjnOP8gIxafq2oViWRzt1J2ni16wO9KTzn8AicWAC1+3mZWfKV
	PMfSOv0Cb7LiiJjdzYQbbFh0FDv7N5KPft0ePzJeu59CIbf3PAC1JxSRAWgMoMitE44=
X-Gm-Gg: Acq92OE0Y2ghlWFfnH1m0NnN4jSropp8HnnLOXl4C5zSvgvC8hK4oYpH2+U6LXEhMa8
	XwAmh82msEmdzg/qNmuwGqSsgZPnCP19osfvEdaTrmIaTJg/XtadNsgNaWJ9DKZB4W3VgndrpT4
	rzPQLCudCV8BI1XDbnT2EpjjfVcrtx4NGq0gElzwOd7eBYjOIqxuhEq9NJ9divuWQUzWUJFjSBN
	Dy8Im4FP/6iQGmHwJrRrhRdsEFKQCmAoh+yQFFdcNBhIdfH8K2+/4ssWoA7RjDhQn5LkHhuNLV4
	xXx/21LxfWKbDsQyj15ko2Al70hVrOVBSBVbEyr62G2nU5uYufMmyki3mashbJ2yyLDbrjgaa1U
	ZkMYiKQl+PR8XwEVZi5FQc13XxEmaHjcZ/FKtTTzihkumMuyACIJ/fnqZctpOvns0IfrXAd/pLt
	32i6nvd7eU0S6fANxmiZlgPYsN3/lCSXK37Q8J1Rw=
X-Received: by 2002:a05:6214:484a:b0:8a0:3bd8:5950 with SMTP id 6a1803df08f44-8ca0f6c2e0dmr59828896d6.23.1778853604180;
        Fri, 15 May 2026 07:00:04 -0700 (PDT)
Received: from vinp2.lan ([2607:fb92:1900:6734:902:ab48:6190:9c1e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90bb80e7bsm52255326d6.33.2026.05.15.07.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 07:00:03 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 10/11] kernel: time, trace: Use trace_call__##name() at guarded tracepoint call sites
Date: Fri, 15 May 2026 09:59:59 -0400
Message-ID: <20260515135959.2238922-1-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vineeth Pillai <vineeth@bitbyteword.org>

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Original v2 series:
https://lore.kernel.org/linux-trace-kernel/20260323160052.17528-1-vineeth@bitbyteword.org/

Parts of the original v2 series have already been merged in mainline.
This patch is being reposted as a follow-up cleanup for the remaining
unmerged pieces.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 kernel/time/tick-sched.c       | 12 ++++++------
 kernel/trace/trace_benchmark.c |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index cbbb87a0c6e7..3b42ee75f48c 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -348,32 +348,32 @@ static bool check_tick_dependency(atomic_t *dep)
 		return !!val;
 
 	if (val & TICK_DEP_MASK_POSIX_TIMER) {
-		trace_tick_stop(0, TICK_DEP_MASK_POSIX_TIMER);
+		trace_call__tick_stop(0, TICK_DEP_MASK_POSIX_TIMER);
 		return true;
 	}
 
 	if (val & TICK_DEP_MASK_PERF_EVENTS) {
-		trace_tick_stop(0, TICK_DEP_MASK_PERF_EVENTS);
+		trace_call__tick_stop(0, TICK_DEP_MASK_PERF_EVENTS);
 		return true;
 	}
 
 	if (val & TICK_DEP_MASK_SCHED) {
-		trace_tick_stop(0, TICK_DEP_MASK_SCHED);
+		trace_call__tick_stop(0, TICK_DEP_MASK_SCHED);
 		return true;
 	}
 
 	if (val & TICK_DEP_MASK_CLOCK_UNSTABLE) {
-		trace_tick_stop(0, TICK_DEP_MASK_CLOCK_UNSTABLE);
+		trace_call__tick_stop(0, TICK_DEP_MASK_CLOCK_UNSTABLE);
 		return true;
 	}
 
 	if (val & TICK_DEP_MASK_RCU) {
-		trace_tick_stop(0, TICK_DEP_MASK_RCU);
+		trace_call__tick_stop(0, TICK_DEP_MASK_RCU);
 		return true;
 	}
 
 	if (val & TICK_DEP_MASK_RCU_EXP) {
-		trace_tick_stop(0, TICK_DEP_MASK_RCU_EXP);
+		trace_call__tick_stop(0, TICK_DEP_MASK_RCU_EXP);
 		return true;
 	}
 
diff --git a/kernel/trace/trace_benchmark.c b/kernel/trace/trace_benchmark.c
index e19c32f2a938..189d383934fd 100644
--- a/kernel/trace/trace_benchmark.c
+++ b/kernel/trace/trace_benchmark.c
@@ -51,7 +51,7 @@ static void trace_do_benchmark(void)
 
 	local_irq_disable();
 	start = trace_clock_local();
-	trace_benchmark_event(bm_str, bm_last);
+	trace_call__benchmark_event(bm_str, bm_last);
 	stop = trace_clock_local();
 	local_irq_enable();
 
-- 
2.54.0

