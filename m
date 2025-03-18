Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB5CEACD;
	Tue, 18 Mar 2025 18:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742321314; cv=none; b=KPqb6pyrQ5qTM69IijIihYPFxt8E6xrP9yb76DltdAHMnW8LSh+moRNGiQNrZStCXKNKjVTym/KYzt9VvP/HAvva4tPI+jnbhwpMvopFzXQ5fjGAl0RNQOPZOibqMZ3+ihJZaFjnHVbFiI1D8SB/zfMzyTCjsNKW9piF0TuEVjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742321314; c=relaxed/simple;
	bh=l4jSwPvmdVV590gyMwUYY4yYKxyZXT6p5HLrbNkZW70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fa3hd4aIq41x/W+yHNZmwniyq7F22fbAWXUlvLYQSqwd/ETDJ+2rsXz4Cr+HtmpuhqLg5fcVBfE7ynuntJY0W36Dye3ss6TbuUR/DoYnCpDpbpgBWtR923SXstWyZILFG6w3crWPzvBuWwWn2agns+i/Y4Bhdx5rARfsmnUVM5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F33313D5;
	Tue, 18 Mar 2025 11:08:41 -0700 (PDT)
Received: from e132430.arm.com (unknown [10.57.85.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1D17E3F694;
	Tue, 18 Mar 2025 11:08:30 -0700 (PDT)
From: Douglas RAILLARD <douglas.raillard@arm.com>
To: rostedt@goodmis.org
Cc: douglas.raillard@arm.com,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 3/3] tracing: Rename trace_synth() to synth_event_trace2()
Date: Tue, 18 Mar 2025 18:08:12 +0000
Message-ID: <20250318180814.226644-3-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318180814.226644-1-douglas.raillard@arm.com>
References: <20250318180814.226644-1-douglas.raillard@arm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Douglas Raillard <douglas.raillard@arm.com>

Rename the frehsly exposed trace_synth() to synth_event_trace2() to
comply with the existing naming convention. Since synth_event_trace()
already exists (and operates on a "struct trace_event_file *"), use a
new name for it.

Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
---
 include/linux/trace_events.h      | 2 +-
 kernel/trace/trace_events_hist.c  | 2 +-
 kernel/trace/trace_events_synth.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index e069d84a73f0..753ce8aecfe4 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -521,7 +521,7 @@ struct synth_event;
 
 extern struct synth_event *synth_event_find(const char *name);
 
-extern void trace_synth(struct synth_event *event, u64 *var_ref_vals,
+extern void synth_event_trace2(struct synth_event *event, u64 *var_ref_vals,
 			       unsigned int *var_ref_idx);
 
 extern int synth_event_delete(const char *name);
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 7067f6fedb1a..ee0fee123c91 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -822,7 +822,7 @@ static void action_trace(struct hist_trigger_data *hist_data,
 {
 	struct synth_event *event = data->synth_event;
 
-	trace_synth(event, var_ref_vals, data->var_ref_idx);
+	synth_event_trace2(event, var_ref_vals, data->var_ref_idx);
 }
 
 struct hist_var_data {
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 4a9a44d37ffc..8837aa258479 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -850,7 +850,7 @@ EXPORT_SYMBOL_GPL(synth_event_find);
 typedef void (*synth_probe_func_t) (void *__data, u64 *var_ref_vals,
 				    unsigned int *var_ref_idx);
 
-void trace_synth(struct synth_event *event, u64 *var_ref_vals,
+void synth_event_trace2(struct synth_event *event, u64 *var_ref_vals,
 			       unsigned int *var_ref_idx)
 {
 	struct tracepoint *tp = event->tp;
@@ -873,7 +873,7 @@ void trace_synth(struct synth_event *event, u64 *var_ref_vals,
 		}
 	}
 }
-EXPORT_SYMBOL_GPL(trace_synth);
+EXPORT_SYMBOL_GPL(synth_event_trace2);
 
 static struct trace_event_fields synth_event_fields_array[] = {
 	{ .type = TRACE_FUNCTION_TYPE,
-- 
2.43.0

