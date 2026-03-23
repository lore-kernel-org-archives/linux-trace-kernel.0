Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2C33BF66E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 16:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281700; cv=none; b=NPY0BrPJFL0cB18uW+huNy1O84xaHCNtVxTAi1ffbW51p/VQi4u34ckYBey2c8Z9V6YfsUwR4/K355/6pE/scWTh95GoDaR/CELjaD7QR4vieelh3pRpo5nZdeG0KAJlwq6OYNfxsb8yh0gPSoWYxmJtL8RvNSWoR3dHqraCVXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281700; c=relaxed/simple;
	bh=3qkPSAaQSgsNl70OPhKr5fWkUQ73E3qA+EyRkUzx5nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CdRpYNwJqVUf1z0EmRM64qAFzeMCLsMpcPdWqQuGf6QjF/RNfymy/BCpnmn9pMRCdHYj3nU+aImDpr7Bq7OuHr3QWSpilUDS7a+Pt8CIMnm6DwF8hHCgOnNtc3vJiCNUSMKlVAVtqrGwz5KQzopw0mG26APzbPQ+P4PcGtQWl3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=GBRlsjdH; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="GBRlsjdH"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-662efd1bdd4so2479322eaf.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 09:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1774281698; x=1774886498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWg9VJeY8h5IypmpdUuwP3NNpd1Z5K7492bpBEEzhYM=;
        b=GBRlsjdHqZKRXdRhJvhgoZhuSkWmN1C9EAkugsSFFe36eFuxjL9FBdoqmDtTGGyUB6
         O1ikQEDs1yASl/xPlwBraIg6p8noXr+vWCruLV2pRVdl+lKqXbm2mXq99VaJ5MbhJWvq
         xrKE0mXiCfj0PQPnpknLUphlr3sXEDsvKEfgAjngBZ0MWF/xEofhJTbc832MQS0tMPYh
         iYOwzNvbCRONC3coRR+o4RDnHXHryD6jkA/Mssde4+7RLXfUg/jYs/7i1pXu07Z2S5VX
         EL09N1lGbT3lnaXbP0iSQsn2oiHue6HPuAtIsGYZKBgKn+SvrgiBNET14DF0ePhVDwgf
         J+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774281698; x=1774886498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BWg9VJeY8h5IypmpdUuwP3NNpd1Z5K7492bpBEEzhYM=;
        b=pfGvJmt3ETXZ2K0EXm+AJ3BMcOpytvk/j/I58WmlErAMctdIOuSBTM8WvuY66u2dkU
         2gAxSMV+v9PKTRqihXML9fqT0I7xIjX3sHJtGaoyLswsNP8TgmxApq+MsOantKUQiY8+
         tahMgy5r4PdhY9dP8S35NWpWmUNoeReOP3spxGfKHkGef1iYpJpRC9Lyflzfw3S5Bj+m
         U2t6VZB7pc4sRkPTIv/dylBW0lKYGfOQ+lYa/pKJamL6yea4R37SIs+3kuEn3jbpA+u1
         F8mNIX8s2FCSdDNIn29tZpoSNGDTUwEY4zE0WHUTP9C0ZE6nGi4SuXePX5Kp0Kgk9Sdw
         xwIw==
X-Forwarded-Encrypted: i=1; AJvYcCVaTO3/gRUqAk+xHqVWV+TIKsZNbR3miWkkw3sotUo6h9Ek8dUmoBkLNOR3GKefALlUshtemDd+zSpI1uOONREmrEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN45ETeQLfTTRLkgihwcBLXDGilSDXT6nRQL6zqVa1tuLRNYGl
	5jRj3BrbWA9lT9PQWjArkbcuD/+zBhraRaO3PxdtNKlOCdO/XTEykgjg+qt9E51E9ME=
X-Gm-Gg: ATEYQzxzqsNA+FXhT9eyGCiP0WJ4RfGK96oW7M03uqwNcGN0LIs2aBNgdkfifmjqpoT
	9rhB7b9+SCA72wPARx/uynWsjmphR3DOUP9n8VDBeSUNpGV17ze/gTB9iYNsvBiKwOxSINF6XNZ
	tDlBEYUGJAd7HgfVmVoW0GVi+O59/Zl6AtXU9tvP+3fLQGjNnEBgkUd5vE0ZS0Q4PLWPS7kEh/I
	GiPVGP7/E2DtWhEIrsdRl6SlDU7vOFzj0sVTrer0MA8bssA4HJQxUxJx2uAu4evA95MoCtC+BM6
	sP6vPRPNM1moTQt6F2BpUUICETCL7WyFyaffnQXfgCbQyLB2iqA0EmR8Ei709i6ROryz4YsYD4P
	EozMjqfJy2yo2GXRjd9P3YvDCT59gmmQUnriEo2GKIGtqJd3Q3R9WYZxc7l7fwQvNTiVVDjxQpq
	o4BliT/2MlxSbGjuuqUuVsRnwMPsPPfIAV38HrBD6JYz6nbbosucnPGl125abCta4C5A==
X-Received: by 2002:a05:6820:1999:b0:67d:b2f2:6e73 with SMTP id 006d021491bc7-67df5d03f02mr72822eaf.8.1774281697507;
        Mon, 23 Mar 2026 09:01:37 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc9088df1sm843364185a.25.2026.03.23.09.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:01:37 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 17/19] kernel: time, trace: Use trace_call__##name() at guarded tracepoint call sites
Date: Mon, 23 Mar 2026 12:00:36 -0400
Message-ID: <20260323160052.17528-18-vineeth@bitbyteword.org>
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

Replace trace_foo() with trace_call__foo() at sites already guarded by
tracepoint_enabled() or trace_foo_enabled() checks, avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.

- tick-sched.c: Multiple trace_tick_stop() calls are guarded by an early
  return when tracepoint_enabled(tick_stop) is false.
- trace_benchmark.c: trace_benchmark_event() is guarded by an early return
  when !trace_benchmark_event_enabled().

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
---
 kernel/time/tick-sched.c       | 12 ++++++------
 kernel/trace/trace_benchmark.c |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index f7907fadd63f2..f8ab472e30858 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -348,32 +348,32 @@ static bool check_tick_dependency(atomic_t *dep)
 		return !val;
 
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
index e19c32f2a9381..189d383934fd3 100644
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
2.53.0

