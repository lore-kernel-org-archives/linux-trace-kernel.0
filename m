Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69642EACD;
	Tue, 18 Mar 2025 18:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742321311; cv=none; b=GMxHRP9Kn4F5mHOgMP5/1y5FdtHOwrvUElE9zvBbygR5F8+Z8bRmg74sXwb/iqwcT3Xgx1g0hMzSyWZWzUdWHTac/XirIxTVgeUOSARl1pFZ+OD01FeY6ZheHMoOo8zK8UjUaBxLJiQrmz1nZWpdVnxmW+QPVbQ67bj2sTzvGAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742321311; c=relaxed/simple;
	bh=9SfPkEWR1QuzPEhnOt8KPm0O/gheR8nP1GV+FI2TWlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LxPx3qHxePsaUe0gzxS4aYtnk1AswhnG2aKlrmy00MMzD/SS9juJ/DiLUdjYWDNo00E+kSsv4poCtx+aWUetT4rtdkxx6c2bziKGvhThWNchkRbJtReGid9xF1UHPmvb/hS0pJtf5mrioQASCZwr5CBKlVNFDLD7Eo6NcCL7gmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DFB61516;
	Tue, 18 Mar 2025 11:08:37 -0700 (PDT)
Received: from e132430.arm.com (unknown [10.57.85.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 05C6D3F694;
	Tue, 18 Mar 2025 11:08:26 -0700 (PDT)
From: Douglas RAILLARD <douglas.raillard@arm.com>
To: rostedt@goodmis.org
Cc: douglas.raillard@arm.com,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/3] tracing: Rename find_synth_event() into synth_event_find()
Date: Tue, 18 Mar 2025 18:08:11 +0000
Message-ID: <20250318180814.226644-2-douglas.raillard@arm.com>
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

Rename the freshly exposed function to comply with the existing naming
convention for synth event public API.

Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
---
 include/linux/trace_events.h      |  2 +-
 kernel/trace/trace_events_hist.c  |  8 ++++----
 kernel/trace/trace_events_synth.c | 10 +++++-----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index cbe389d0e144..e069d84a73f0 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -519,7 +519,7 @@ extern int dynevent_create(struct dynevent_cmd *cmd);
 
 struct synth_event;
 
-extern struct synth_event *find_synth_event(const char *name);
+extern struct synth_event *synth_event_find(const char *name);
 
 extern void trace_synth(struct synth_event *event, u64 *var_ref_vals,
 			       unsigned int *var_ref_idx);
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index a2bc7a972763..7067f6fedb1a 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -3964,7 +3964,7 @@ static int trace_action_create(struct hist_trigger_data *hist_data,
 	else
 		synth_event_name = data->action_name;
 
-	event = find_synth_event(synth_event_name);
+	event = synth_event_find(synth_event_name);
 	if (!event) {
 		hist_err(tr, HIST_ERR_SYNTH_EVENT_NOT_FOUND, errpos(synth_event_name));
 		return -EINVAL;
@@ -6580,7 +6580,7 @@ static void hist_unreg_all(struct trace_event_file *file)
 			trace_event_trigger_enable_disable(file, 0);
 
 			se_name = trace_event_name(file->event_call);
-			se = find_synth_event(se_name);
+			se = synth_event_find(se_name);
 			if (se)
 				se->ref--;
 
@@ -6699,7 +6699,7 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 
 		event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
 		se_name = trace_event_name(file->event_call);
-		se = find_synth_event(se_name);
+		se = synth_event_find(se_name);
 		if (se)
 			se->ref--;
 		ret = 0;
@@ -6735,7 +6735,7 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 		goto out_unreg;
 
 	se_name = trace_event_name(file->event_call);
-	se = find_synth_event(se_name);
+	se = synth_event_find(se_name);
 	if (se)
 		se->ref++;
  out:
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 9f0817eec3c2..4a9a44d37ffc 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -830,7 +830,7 @@ static struct tracepoint *alloc_synth_tracepoint(char *name)
 	return tp;
 }
 
-struct synth_event *find_synth_event(const char *name)
+struct synth_event *synth_event_find(const char *name)
 {
 	struct dyn_event *pos;
 	struct synth_event *event;
@@ -845,7 +845,7 @@ struct synth_event *find_synth_event(const char *name)
 
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(find_synth_event);
+EXPORT_SYMBOL_GPL(synth_event_find);
 
 typedef void (*synth_probe_func_t) (void *__data, u64 *var_ref_vals,
 				    unsigned int *var_ref_idx);
@@ -1317,7 +1317,7 @@ static int __create_synth_event(const char *name, const char *raw_fields)
 
 	mutex_lock(&event_mutex);
 
-	event = find_synth_event(name);
+	event = synth_event_find(name);
 	if (event) {
 		synth_err(SYNTH_ERR_EVENT_EXISTS, errpos(name));
 		ret = -EEXIST;
@@ -1513,7 +1513,7 @@ int synth_event_delete(const char *event_name)
 	int ret = -ENOENT;
 
 	mutex_lock(&event_mutex);
-	se = find_synth_event(event_name);
+	se = synth_event_find(event_name);
 	if (se) {
 		mod = se->mod;
 		ret = destroy_synth_event(se);
@@ -1622,7 +1622,7 @@ static int synth_event_run_command(struct dynevent_cmd *cmd)
 	if (ret)
 		return ret;
 
-	se = find_synth_event(cmd->event_name);
+	se = synth_event_find(cmd->event_name);
 	if (WARN_ON(!se))
 		return -ENOENT;
 
-- 
2.43.0

