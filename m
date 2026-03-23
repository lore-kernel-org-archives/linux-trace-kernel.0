Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56373BA23B
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281678; cv=none; b=k8FLSdxBJ8rlgHi6qPuH101zHm44Kevzb+ocuksQg5ru5ukpKqvPGuz6ZkRdzZ2nvZPgN1q0LcWxWP3tLfUvF+t3QW6DgaYscZz9gQ4X3ropXXmvlb87PPpvZ91UdJ+hupqdid2MLn+6rKRYu2l14LkSCuLHIkpQW5Ogkci4Mhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281678; c=relaxed/simple;
	bh=UYWQZ2GP0U++mha636tNmQDeDr1xCrJ4Hne/HQIGbQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OG/uOLiS1KcHPzuivpjd5F9kCGZ5ZOo52GMoFGMHwT4jflR14eGdiA0n2E+LLe2ck2MbgzFuzar8UoSc4HQXHvR314SWRUYZROY8RC793F+sbKJsE10HFlBpuqasmZ2Zej5PZa57865jAx14c+PeDFmmY1QzviZjmQXtzSZjjZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=MRJeYg/5; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="MRJeYg/5"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7d7eb85fb81so347626a34.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 09:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1774281675; x=1774886475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alZhVdYENKaCgEyuFWCx1ONcWxmGf0Z0mu4iI7gLWPk=;
        b=MRJeYg/53vCtQQdVZ5EGQ7rzA+mX1UXmCi8u38vZSN1PYY7KKlq25mnhrJGEoqSJTt
         6/jmy57s5FIbDh0shGos4MkijwsPQJU7CflSO56jAS5naxUG+NAp7Tdu2WjGEtWQqCN0
         HeXUCFFNUbeM6LRFjkI3Y1edH9JTHvjI5pqdEJboiuAScB/JI7zgrSAG8eHPcJ5qiGTi
         JJTlYDxlUSjDs7Dm4VapwPFU0XgLi78A8Ty5M+Wzhm2NV8BmO4CYcJPGZvwEaDILXUsB
         RyMeUxDP1j5wQ5RlyZlM/zEsWLhW6PcPpVuA/m4p9Vr5reHLRhKIX54Cz6mKnJjpMi8J
         m8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774281675; x=1774886475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=alZhVdYENKaCgEyuFWCx1ONcWxmGf0Z0mu4iI7gLWPk=;
        b=QlKmrTPLV17dJIp0+eZEJkiEehb+B61OBN8CYKhPyv6VrMY46Ohj25h9ljtsJIPsLo
         ZJfzpsITb/Kcc3ZGpDaSUUslAL64LPXQTl/+eACm4tPcW6tAaq+Jffh7wTiVfrM9Vh+l
         //nPdk2DBsQtNWI5MAVs52xyoo4th2cXwdwAab/UjeZCHS7lLtXC6fY9zJKf7dYIFmE3
         mtULXRHPLcmvHH9Bpwlxv7g8zR3D/GQMtL+aug8pKY39RmVUOJrwQJx1XQCNspOhRVYt
         7WeqtYghJGE4IXPIuWtKeodkuCpoCqNEG+KhEj1ddf6avM+7ko7SwktPRM3GJVxAR5CM
         GruA==
X-Forwarded-Encrypted: i=1; AJvYcCW86JVO3UC4Fk7syQBlTuDjtrYq48uI9ePOFP9AhbRZDjE+Hr7PAi6lEa1Kw/b1ZJBOrdJyBs/q/lxql95yiyV/YEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YznQrIrv19phacfkluXtMHU8AfH8IDn8JOafaXRhPd/p11FBSng
	4ER5W+9hrRaWi1GBlrwBGN/SY6myrFi5hGdx6+r9tCPKdj4DD0Gu88cZQcIT7QjMTDc=
X-Gm-Gg: ATEYQzyFgz0qqH2Rj5WkJx7N/mhETskqITS9bLcsCyV0PWtgDODI5quHP02hbessUGo
	OlBHfF2LBqYrw4BfE6ftGRyPGipzMVRbr9WpSBNXrq305sifMZmRVgvGCsPw0P28UC2WBKoe5GX
	SqiQmuhzbyTLHjT09HueoyDI9Mk65ZZHnN921jh5UBfZcRPbg4mhKsD7Ejc0qRhHyng98NrBqws
	JA945hcsb4KNMUtZwiw3M37uQ1QpjOS37ZZG/2Eg08gSzDTBHQb0KfINnyZGDx31KXc3xVbQWjo
	dgpHGabyE6rMieEdsiGuJ1c+48LcdewgJ8WC75s09Uty/fmgytYVfNrqUAOIM4F3KOThqBbh/jw
	INQpCPsSvBP6QDvRgr6aoF8sCLHH5IEO39cVR9V3XPzZh3XuVwviOXSbERnMW+85zSnEyg2h6Al
	CjHK49XXa3w+0kwPS77Jnz4xmimu7rgQ0XWB2Y1gCtZf4n2Auf7ErTQpvxSemeJbsXXA==
X-Received: by 2002:a05:6820:1a03:b0:67b:f147:4cdc with SMTP id 006d021491bc7-67c22fe7998mr10114283eaf.64.1774281675182;
        Mon, 23 Mar 2026 09:01:15 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc9088df1sm843364185a.25.2026.03.23.09.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:01:14 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Huang Rui <ray.huang@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 06/19] cpufreq: Use trace_call__##name() at guarded tracepoint call sites
Date: Mon, 23 Mar 2026 12:00:25 -0400
Message-ID: <20260323160052.17528-7-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323160052.17528-1-vineeth@bitbyteword.org>
References: <20260323160052.17528-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/cpufreq/amd-pstate.c   | 10 +++++-----
 drivers/cpufreq/cpufreq.c      |  2 +-
 drivers/cpufreq/intel_pstate.c |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 5aa9fcd80cf51..4c47324aa2f73 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -247,7 +247,7 @@ static int msr_update_perf(struct cpufreq_policy *policy, u8 min_perf,
 	if (trace_amd_pstate_epp_perf_enabled()) {
 		union perf_cached perf = READ_ONCE(cpudata->perf);
 
-		trace_amd_pstate_epp_perf(cpudata->cpu,
+		trace_call__amd_pstate_epp_perf(cpudata->cpu,
 					  perf.highest_perf,
 					  epp,
 					  min_perf,
@@ -298,7 +298,7 @@ static int msr_set_epp(struct cpufreq_policy *policy, u8 epp)
 	if (trace_amd_pstate_epp_perf_enabled()) {
 		union perf_cached perf = cpudata->perf;
 
-		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
+		trace_call__amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
 					  epp,
 					  FIELD_GET(AMD_CPPC_MIN_PERF_MASK,
 						    cpudata->cppc_req_cached),
@@ -343,7 +343,7 @@ static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
 	if (trace_amd_pstate_epp_perf_enabled()) {
 		union perf_cached perf = cpudata->perf;
 
-		trace_amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
+		trace_call__amd_pstate_epp_perf(cpudata->cpu, perf.highest_perf,
 					  epp,
 					  FIELD_GET(AMD_CPPC_MIN_PERF_MASK,
 						    cpudata->cppc_req_cached),
@@ -507,7 +507,7 @@ static int shmem_update_perf(struct cpufreq_policy *policy, u8 min_perf,
 	if (trace_amd_pstate_epp_perf_enabled()) {
 		union perf_cached perf = READ_ONCE(cpudata->perf);
 
-		trace_amd_pstate_epp_perf(cpudata->cpu,
+		trace_call__amd_pstate_epp_perf(cpudata->cpu,
 					  perf.highest_perf,
 					  epp,
 					  min_perf,
@@ -588,7 +588,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u8 min_perf,
 	}
 
 	if (trace_amd_pstate_perf_enabled() && amd_pstate_sample(cpudata)) {
-		trace_amd_pstate_perf(min_perf, des_perf, max_perf, cpudata->freq,
+		trace_call__amd_pstate_perf(min_perf, des_perf, max_perf, cpudata->freq,
 			cpudata->cur.mperf, cpudata->cur.aperf, cpudata->cur.tsc,
 				cpudata->cpu, fast_switch);
 	}
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 277884d91913c..58901047eae5a 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2222,7 +2222,7 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
 
 	if (trace_cpu_frequency_enabled()) {
 		for_each_cpu(cpu, policy->cpus)
-			trace_cpu_frequency(freq, cpu);
+			trace_call__cpu_frequency(freq, cpu);
 	}
 
 	return freq;
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 11c58af419006..70be952209144 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3132,7 +3132,7 @@ static void intel_cpufreq_trace(struct cpudata *cpu, unsigned int trace_type, in
 		return;
 
 	sample = &cpu->sample;
-	trace_pstate_sample(trace_type,
+	trace_call__pstate_sample(trace_type,
 		0,
 		old_pstate,
 		cpu->pstate.current_pstate,
-- 
2.53.0

