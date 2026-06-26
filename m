Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E383BFACE
	for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Jun 2026 21:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782509057; cv=none; b=YLCNZcpvTJp027NdvtXnDmSttSPqPIJXtGpTHpiDidGhiJco1C3XHdNiHhI2uxI18yUTyXWAf/Y9qnuvQyX4gpLFjStowZB1/XxweCpqMF/X9fT/lG+Qb6Nj3sCZUyzFwF/KChsl3PnzjSXHkoUgjGoNdinTSO9OSC+bg6+cltE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782509057; c=relaxed/simple;
	bh=uExNL1nj/oWe5XhvwSnHAfjPe5bh+/O0zAlD2Xcjt34=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gmhtBEl+fWwu5CQQNk1RrkYmx8yhznBK/L+i0ZGYTpsAqltorGBG8tgQBni2ejf4E9WUllfIDGL7hTIpC7V3ry0L/RA5n1Jy++GY0WPiOWXZ3s0Tz4n5rXu/f0xbgLjrkPrHy766ymOWgFlhPAuooWJ8jlvYFRe2md9kP3KC8QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pZrRywbX; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pZrRywbX"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49222b6e871so7611735e9.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Jun 2026 14:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782509054; x=1783113854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ogi5exKYxsdjMJIMbUiIGL58nCel5NbzqqPFgFs3s/w=;
        b=pZrRywbX+Z0r16Aj8tAzut6s7c/trBp35LOywkidm/DdiDCdz0jbMqPLz5T48rqPtE
         vUTKFO1OA7VFjPzQc/R1If0tC1hXAk+oS6kKt3wul0Rcl2FGuCGknH98SK6CCiiUEzNb
         kaeAVNDJKaSOneBmyI6EkkKWVxEQbw153Si0ALQT0a69NLgw3LZzE4I2dIiBZnS2U8Ec
         A7H1ybJRsLTDNJU8fbpBLY0nMO7GgX6tBhD7iN0CXT1r683EKNuGSyTaC7N2Tv+2wrL+
         Kd1OQ9Q1PabPKfNW2ArLrs9Je2XCLscupi1RaDHf9r+eBrgFSoAG519mBrJUP2YNRuz9
         KuRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782509054; x=1783113854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ogi5exKYxsdjMJIMbUiIGL58nCel5NbzqqPFgFs3s/w=;
        b=ERa+xXWo65DLXZqYnUIascYnHOP3g+Zj+T29/Uznc+BWSANNkA5QUXImZVSVhrIq4K
         XJ+gSikNvfWDD+bJjLQxUwPJa4cCJL4KSrXlr/0EL4kXEzAzcJCqzkiCJJfCeZ6hXU1i
         5K2FOEmf4sGiKijzSLebxaAEs5S5TMBfqWD3o0cNJ/JCcg07gpxPyhNB1NCOSjfINPcz
         mUi9c3SEEM6jNOTsEfKVFX/9/uKPStQV74HMuBssJrSx5f1mZx6AfpoWMTA/gwrZsaq7
         ZK2SQd3JXY4IVzZPffkIcMn0EYA7n/ix/sE3xLNvtQ0tF/lJRqbzcnq149lRxDEI9AFS
         LBsQ==
X-Forwarded-Encrypted: i=1; AFNElJ9pJh8Tne0Ld7qwgx8LwmF9fR8udsznjTrG39BNTUFsSiQdnxaYrT/47KPaf+kUn/tCMfc2hSuyzGGg5sl9Q9npGgU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5fhK9+HC3c6tjtCWxEICbFBvzvnmANuesIkN2lVMMyqOsV7kc
	C/j2r7xsZrMZPojxxsd4b9mVUb9JFfFV6fhyeLF9fx9EJmDuW145/QYl
X-Gm-Gg: AfdE7cnzm0OQbOBFtm6TqASsNkg5NI/oW1k9DXITmsrmCGTzmTCSvc97TB7O1hHoboM
	yqWA0g71Z4HeiwDJDDk4GZXFGSr9zFGe+k6K18ksj0tUfVqEucxadm28SbM1ggSsBGlq3VIeq0f
	c/Um1HhOMRWewzDTYxUAxiliUsXLensN9HhSZrcynW+XTTko4sHgKeGb9Sduqe1y3N1zQPHBxcT
	gXq+kWRe8JolQskVI3be1f3BZlq3SNbhjQ9pJCNxxk87stLynMDy7SX/gcELSQsXbV5AKRYxwo7
	GZf1X/tTiWfrrHZnumpxXi7Ox5MNYZ3DhDcph0HV9kCa3/wiGkAw6kYRT2pyKV7CmfUF4zci512
	UJxSyeBs9hf4nt+4QvPvnKS7+GC7WAzFPfY1tWRa3FfbuTqCcFkXLC1ZhfplWAP3Ir77cSmbLed
	B4vl+2IRb1yFuhW8JP3IC0W9dLsPZ1g7/6bwFU/rPxAwvosiypvhpx4eVqLTvzVJNo7qDx2A==
X-Received: by 2002:a05:600c:4ecb:b0:492:4a50:8445 with SMTP id 5b1f17b1804b1-492668ac2efmr119163205e9.31.1782509053677;
        Fri, 26 Jun 2026 14:24:13 -0700 (PDT)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46e95f3d71fsm11505686f8f.12.2026.06.26.14.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 14:24:13 -0700 (PDT)
From: David Laight <david.laight.linux@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: David Laight <david.laight.linux@gmail.com>
Subject: [PATCH 1/2] tracing: Embed 'char comm[16]' in a structure
Date: Fri, 26 Jun 2026 22:23:55 +0100
Message-Id: <20260626212356.64150-2-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260626212356.64150-1-david.laight.linux@gmail.com>
References: <20260626212356.64150-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Embedding the array in a stucture makes the size explicit and lets
structure copies be used.

Limit the size to 16 charatacters even if task_struct.comm is
made larger (there are plans to increase it).

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 kernel/trace/blktrace.c              | 28 +++++++++----------
 kernel/trace/trace.c                 |  3 +-
 kernel/trace/trace.h                 |  9 ++++--
 kernel/trace/trace_events_filter.c   |  2 +-
 kernel/trace/trace_events_hist.c     | 26 +++++++----------
 kernel/trace/trace_functions_graph.c | 10 +++----
 kernel/trace/trace_output.c          | 24 ++++++++--------
 kernel/trace/trace_sched_switch.c    | 42 ++++++++++++++++------------
 8 files changed, 75 insertions(+), 69 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 8cd2520b4c99..68ffc95548b7 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1590,20 +1590,20 @@ static void blk_log_dump_pdu(struct trace_seq *s,
 
 static void blk_log_generic(struct trace_seq *s, const struct trace_entry *ent, bool has_cg)
 {
-	char cmd[TASK_COMM_LEN];
+	struct trace_comm cmd;
 
-	trace_find_cmdline(ent->pid, cmd);
+	trace_find_cmdline(ent->pid, &cmd);
 
 	if (t_action(ent) & BLK_TC_ACT(BLK_TC_PC)) {
 		trace_seq_printf(s, "%u ", t_bytes(ent));
 		blk_log_dump_pdu(s, ent, has_cg);
-		trace_seq_printf(s, "[%s]\n", cmd);
+		trace_seq_printf(s, "[%s]\n", cmd.comm);
 	} else {
 		if (t_sec(ent))
 			trace_seq_printf(s, "%llu + %u [%s]\n",
-						t_sector(ent), t_sec(ent), cmd);
+						t_sector(ent), t_sec(ent), cmd.comm);
 		else
-			trace_seq_printf(s, "[%s]\n", cmd);
+			trace_seq_printf(s, "[%s]\n", cmd.comm);
 	}
 }
 
@@ -1637,30 +1637,30 @@ static void blk_log_remap(struct trace_seq *s, const struct trace_entry *ent, bo
 
 static void blk_log_plug(struct trace_seq *s, const struct trace_entry *ent, bool has_cg)
 {
-	char cmd[TASK_COMM_LEN];
+	struct trace_comm cmd;
 
-	trace_find_cmdline(ent->pid, cmd);
+	trace_find_cmdline(ent->pid, &cmd);
 
-	trace_seq_printf(s, "[%s]\n", cmd);
+	trace_seq_printf(s, "[%s]\n", cmd.comm);
 }
 
 static void blk_log_unplug(struct trace_seq *s, const struct trace_entry *ent, bool has_cg)
 {
-	char cmd[TASK_COMM_LEN];
+	struct trace_comm cmd;
 
-	trace_find_cmdline(ent->pid, cmd);
+	trace_find_cmdline(ent->pid, &cmd);
 
-	trace_seq_printf(s, "[%s] %llu\n", cmd, get_pdu_int(ent, has_cg));
+	trace_seq_printf(s, "[%s] %llu\n", cmd.comm, get_pdu_int(ent, has_cg));
 }
 
 static void blk_log_split(struct trace_seq *s, const struct trace_entry *ent, bool has_cg)
 {
-	char cmd[TASK_COMM_LEN];
+	struct trace_comm cmd;
 
-	trace_find_cmdline(ent->pid, cmd);
+	trace_find_cmdline(ent->pid, &cmd);
 
 	trace_seq_printf(s, "%llu / %llu [%s]\n", t_sector(ent),
-			 get_pdu_int(ent, has_cg), cmd);
+			 get_pdu_int(ent, has_cg), cmd.comm);
 }
 
 static void blk_log_msg(struct trace_seq *s, const struct trace_entry *ent,
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6eb4d3097a4d..7de658b8ee0d 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -52,6 +52,7 @@
 #include <linux/sort.h>
 #include <linux/io.h> /* vmap_page_range() */
 #include <linux/fs_context.h>
+#include <linux/trace_printk.h>
 
 #include <asm/setup.h> /* COMMAND_LINE_SIZE */
 
@@ -2972,7 +2973,7 @@ print_trace_header(struct seq_file *m, struct trace_iterator *iter)
 	seq_puts(m, "#    -----------------\n");
 	seq_printf(m, "#    | task: %.16s-%d "
 		   "(uid:%d nice:%ld policy:%ld rt_prio:%ld)\n",
-		   data->comm, data->pid,
+		   data->comm.comm, data->pid,
 		   from_kuid_munged(seq_user_ns(m), data->uid), data->nice,
 		   data->policy, data->rt_priority);
 	seq_puts(m, "#    -----------------\n");
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 80fe152af1dd..afd59d79e1fe 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -183,6 +183,11 @@ struct fexit_trace_entry_head {
 
 struct trace_array;
 
+/* task_struct->comm[] may be truncated to save memory/width */
+struct trace_comm {
+	char comm[16];
+};
+
 /*
  * The CPU trace array - it consists of thousands of trace entries
  * plus some other descriptor data: (for example which task started
@@ -203,7 +208,7 @@ struct trace_array_cpu {
 	u64			preempt_timestamp;
 	pid_t			pid;
 	kuid_t			uid;
-	char			comm[TASK_COMM_LEN];
+	struct trace_comm	comm;
 
 #ifdef CONFIG_FUNCTION_TRACER
 	int			ftrace_ignore_pid;
@@ -906,7 +911,7 @@ void trace_last_func_repeats(struct trace_array *tr,
 
 extern u64 ftrace_now(int cpu);
 
-extern void trace_find_cmdline(int pid, char comm[]);
+extern void trace_find_cmdline(int pid, struct trace_comm *comm);
 extern int trace_find_tgid(int pid);
 extern void trace_event_follow_fork(struct trace_array *tr, bool enable);
 
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 609325f57942..749887aff315 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -994,7 +994,7 @@ static int filter_pred_comm(struct filter_pred *pred, void *event)
 	int cmp;
 
 	cmp = pred->regex->match(current->comm, pred->regex,
-				TASK_COMM_LEN);
+				sizeof(current->comm));
 	return cmp ^ pred->not;
 }
 
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 0dbbf6cca9bc..1b51491b2a41 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -680,7 +680,7 @@ struct track_data {
 };
 
 struct hist_elt_data {
-	char *comm;
+	struct trace_comm *comm;
 	u64 *var_ref_vals;
 	char **field_var_str;
 	int n_field_var_str;
@@ -756,7 +756,7 @@ static struct track_data *track_data_alloc(unsigned int key_len,
 
 	data->elt.private_data = elt_data;
 
-	elt_data->comm = kzalloc(TASK_COMM_LEN, GFP_KERNEL);
+	elt_data->comm = kzalloc_obj(*elt_data->comm);
 	if (!elt_data->comm) {
 		track_data_free(data);
 		return ERR_PTR(-ENOMEM);
@@ -1608,19 +1608,19 @@ parse_hist_trigger_attrs(struct trace_array *tr, char *trigger_str)
 	return ERR_PTR(ret);
 }
 
-static inline void save_comm(char *comm, struct task_struct *task)
+static inline void save_comm(struct trace_comm *comm, struct task_struct *task)
 {
 	if (!task->pid) {
-		strcpy(comm, "<idle>");
+		strcpy(comm->comm, "<idle>");
 		return;
 	}
 
 	if (WARN_ON_ONCE(task->pid < 0)) {
-		strcpy(comm, "<XXX>");
+		strcpy(comm->comm, "<XXX>");
 		return;
 	}
 
-	strscpy(comm, task->comm, TASK_COMM_LEN);
+	strscpy(comm->comm, task->comm);
 }
 
 static void hist_elt_data_free(struct hist_elt_data *elt_data)
@@ -1646,7 +1646,6 @@ static void hist_trigger_elt_data_free(struct tracing_map_elt *elt)
 static int hist_trigger_elt_data_alloc(struct tracing_map_elt *elt)
 {
 	struct hist_trigger_data *hist_data = elt->map->private_data;
-	unsigned int size = TASK_COMM_LEN;
 	struct hist_elt_data *elt_data;
 	struct hist_field *hist_field;
 	unsigned int i, n_str;
@@ -1659,7 +1658,7 @@ static int hist_trigger_elt_data_alloc(struct tracing_map_elt *elt)
 		hist_field = hist_data->fields[i];
 
 		if (hist_field->flags & HIST_FIELD_FL_EXECNAME) {
-			elt_data->comm = kzalloc(size, GFP_KERNEL);
+			elt_data->comm = kzalloc_obj(*elt_data->comm);
 			if (!elt_data->comm) {
 				kfree(elt_data);
 				return -ENOMEM;
@@ -1677,8 +1676,6 @@ static int hist_trigger_elt_data_alloc(struct tracing_map_elt *elt)
 
 	BUILD_BUG_ON(STR_VAR_LEN_MAX & (sizeof(u64) - 1));
 
-	size = STR_VAR_LEN_MAX;
-
 	elt_data->field_var_str = kcalloc(n_str, sizeof(char *), GFP_KERNEL);
 	if (!elt_data->field_var_str) {
 		hist_elt_data_free(elt_data);
@@ -1687,7 +1684,7 @@ static int hist_trigger_elt_data_alloc(struct tracing_map_elt *elt)
 	elt_data->n_field_var_str = n_str;
 
 	for (i = 0; i < n_str; i++) {
-		elt_data->field_var_str[i] = kzalloc(size, GFP_KERNEL);
+		elt_data->field_var_str[i] = kzalloc(STR_VAR_LEN_MAX, GFP_KERNEL);
 		if (!elt_data->field_var_str[i]) {
 			hist_elt_data_free(elt_data);
 			return -ENOMEM;
@@ -3449,7 +3446,7 @@ static bool cond_snapshot_update(struct trace_array *tr, void *cond_data)
 	elt_data = context->elt->private_data;
 	track_elt_data = track_data->elt.private_data;
 	if (elt_data->comm)
-		strscpy(track_elt_data->comm, elt_data->comm, TASK_COMM_LEN);
+		track_elt_data->comm = elt_data->comm;
 
 	track_data->updated = true;
 
@@ -5505,16 +5502,13 @@ static void hist_trigger_print_key(struct seq_file *m,
 				   uval, (void *)(uintptr_t)uval);
 		} else if (key_field->flags & HIST_FIELD_FL_EXECNAME) {
 			struct hist_elt_data *elt_data = elt->private_data;
-			char *comm;
 
 			if (WARN_ON_ONCE(!elt_data))
 				return;
 
-			comm = elt_data->comm;
-
 			uval = *(u64 *)(key + key_field->offset);
 			seq_printf(m, "%s: %-16s[%10llu]", field_name,
-				   comm, uval);
+				   elt_data->comm->comm, uval);
 		} else if (key_field->flags & HIST_FIELD_FL_SYSCALL) {
 			const char *syscall_name;
 
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 0d2d3a2ea7dd..e46c5aa0d4e4 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -561,19 +561,19 @@ static void print_graph_cpu(struct trace_seq *s, int cpu)
 
 static void print_graph_proc(struct trace_seq *s, pid_t pid)
 {
-	char comm[TASK_COMM_LEN];
+	struct trace_comm comm;
 	/* sign + log10(MAX_INT) + '\0' */
 	char pid_str[12];
 	int spaces = 0;
 	int len;
 	int i;
 
-	trace_find_cmdline(pid, comm);
-	comm[7] = '\0';
+	trace_find_cmdline(pid, &comm);
+	comm.comm[7] = '\0';
 	sprintf(pid_str, "%d", pid);
 
 	/* 1 stands for the "-" character */
-	len = strlen(comm) + strlen(pid_str) + 1;
+	len = strlen(comm.comm) + strlen(pid_str) + 1;
 
 	if (len < TRACE_GRAPH_PROCINFO_LENGTH)
 		spaces = TRACE_GRAPH_PROCINFO_LENGTH - len;
@@ -582,7 +582,7 @@ static void print_graph_proc(struct trace_seq *s, pid_t pid)
 	for (i = 0; i < spaces / 2; i++)
 		trace_seq_putc(s, ' ');
 
-	trace_seq_printf(s, "%s-%s", comm, pid_str);
+	trace_seq_printf(s, "%s-%s", comm.comm, pid_str);
 
 	/* Last spaces to align center */
 	for (i = 0; i < spaces - (spaces / 2); i++)
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index a5ad76175d10..58405291b44f 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -554,12 +554,12 @@ int trace_print_lat_fmt(struct trace_seq *s, struct trace_entry *entry)
 static int
 lat_print_generic(struct trace_seq *s, struct trace_entry *entry, int cpu)
 {
-	char comm[TASK_COMM_LEN];
+	struct trace_comm comm;
 
-	trace_find_cmdline(entry->pid, comm);
+	trace_find_cmdline(entry->pid, &comm);
 
 	trace_seq_printf(s, "%8.8s-%-7d %3d",
-			 comm, entry->pid, cpu);
+			 comm.comm, entry->pid, cpu);
 
 	return trace_print_lat_fmt(s, entry);
 }
@@ -658,11 +658,11 @@ int trace_print_context(struct trace_iterator *iter)
 	struct trace_array *tr = iter->tr;
 	struct trace_seq *s = &iter->seq;
 	struct trace_entry *entry = iter->ent;
-	char comm[TASK_COMM_LEN];
+	struct trace_comm comm;
 
-	trace_find_cmdline(entry->pid, comm);
+	trace_find_cmdline(entry->pid, &comm);
 
-	trace_seq_printf(s, "%16s-%-7d ", comm, entry->pid);
+	trace_seq_printf(s, "%16s-%-7d ", comm.comm, entry->pid);
 
 	if (tr->trace_flags & TRACE_ITER(RECORD_TGID)) {
 		unsigned int tgid = trace_find_tgid(entry->pid);
@@ -700,13 +700,13 @@ int trace_print_lat_context(struct trace_iterator *iter)
 	entry = iter->ent;
 
 	if (verbose) {
-		char comm[TASK_COMM_LEN];
+		struct trace_comm comm;
 
-		trace_find_cmdline(entry->pid, comm);
+		trace_find_cmdline(entry->pid, &comm);
 
 		trace_seq_printf(
 			s, "%16s %7d %3d %d %08x %08lx ",
-			comm, entry->pid, iter->cpu, entry->flags,
+			comm.comm, entry->pid, iter->cpu, entry->flags,
 			entry->preempt_count & 0xf, iter->idx);
 	} else {
 		lat_print_generic(s, entry, iter->cpu);
@@ -1276,7 +1276,7 @@ static enum print_line_t trace_ctxwake_print(struct trace_iterator *iter,
 					     char *delim)
 {
 	struct ctx_switch_entry *field;
-	char comm[TASK_COMM_LEN];
+	struct trace_comm comm;
 	int S, T;
 
 
@@ -1284,7 +1284,7 @@ static enum print_line_t trace_ctxwake_print(struct trace_iterator *iter,
 
 	T = task_index_to_char(field->next_state);
 	S = task_index_to_char(field->prev_state);
-	trace_find_cmdline(field->next_pid, comm);
+	trace_find_cmdline(field->next_pid, &comm);
 	trace_seq_printf(&iter->seq,
 			 " %7d:%3d:%c %s [%03d] %7d:%3d:%c %s\n",
 			 field->prev_pid,
@@ -1293,7 +1293,7 @@ static enum print_line_t trace_ctxwake_print(struct trace_iterator *iter,
 			 field->next_cpu,
 			 field->next_pid,
 			 field->next_prio,
-			 T, comm);
+			 T, comm.comm);
 
 	return trace_handle_return(&iter->seq);
 }
diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
index e9f0ff962660..972883643097 100644
--- a/kernel/trace/trace_sched_switch.c
+++ b/kernel/trace/trace_sched_switch.c
@@ -172,27 +172,33 @@ struct saved_cmdlines_buffer {
 	unsigned *map_cmdline_to_pid;
 	unsigned cmdline_num;
 	int cmdline_idx;
-	char saved_cmdlines[];
+	struct trace_comm saved_cmdlines[];
 };
 static struct saved_cmdlines_buffer *savedcmd;
 
 /* Holds the size of a cmdline and pid element */
 #define SAVED_CMDLINE_MAP_ELEMENT_SIZE(s)			\
-	(TASK_COMM_LEN + sizeof((s)->map_cmdline_to_pid[0]))
+	(sizeof(struct trace_comm) + sizeof((s)->map_cmdline_to_pid[0]))
 
-static inline char *get_saved_cmdlines(int idx)
+static inline struct trace_comm *get_saved_cmdlines(int idx)
 {
-	return &savedcmd->saved_cmdlines[idx * TASK_COMM_LEN];
+	return &savedcmd->saved_cmdlines[idx];
 }
 
-static inline void set_cmdline(int idx, const char *cmdline)
+static inline void set_cmdline(int idx, const struct task_struct *tsk)
 {
-	strscpy(get_saved_cmdlines(idx), cmdline, TASK_COMM_LEN);
+	struct trace_comm *comm = get_saved_cmdlines(idx);
+
+	BUILD_BUG_ON(sizeof(comm->comm) > sizeof(tsk->comm));
+
+	memcpy(comm->comm, tsk->comm, sizeof comm->comm);
+	if (sizeof(comm->comm) != sizeof(tsk->comm))
+		comm->comm[ARRAY_SIZE(comm->comm) - 1] = 0;
 }
 
 static void free_saved_cmdlines_buffer(struct saved_cmdlines_buffer *s)
 {
-	int order = get_order(sizeof(*s) + s->cmdline_num * TASK_COMM_LEN);
+	int order = get_order(sizeof(*s) + s->cmdline_num * sizeof(struct trace_comm));
 
 	kmemleak_free(s);
 	free_pages((unsigned long)s, order);
@@ -222,7 +228,7 @@ static struct saved_cmdlines_buffer *allocate_cmdlines_buffer(unsigned int val)
 	s->cmdline_num = val;
 
 	/* Place map_cmdline_to_pid array right after saved_cmdlines */
-	s->map_cmdline_to_pid = (unsigned *)&s->saved_cmdlines[val * TASK_COMM_LEN];
+	s->map_cmdline_to_pid = (unsigned *)&s->saved_cmdlines[val];
 
 	memset(&s->map_pid_to_cmdline, NO_CMDLINE_MAP,
 	       sizeof(s->map_pid_to_cmdline));
@@ -273,25 +279,25 @@ int trace_save_cmdline(struct task_struct *tsk)
 	}
 
 	savedcmd->map_cmdline_to_pid[idx] = tsk->pid;
-	set_cmdline(idx, tsk->comm);
+	set_cmdline(idx, tsk);
 
 	arch_spin_unlock(&trace_cmdline_lock);
 
 	return 1;
 }
 
-static void __trace_find_cmdline(int pid, char comm[])
+static void __trace_find_cmdline(int pid, struct trace_comm *comm)
 {
 	unsigned map;
 	int tpid;
 
 	if (!pid) {
-		strcpy(comm, "<idle>");
+		strcpy(comm->comm, "<idle>");
 		return;
 	}
 
 	if (WARN_ON_ONCE(pid < 0)) {
-		strcpy(comm, "<XXX>");
+		strcpy(comm->comm, "<XXX>");
 		return;
 	}
 
@@ -300,14 +306,14 @@ static void __trace_find_cmdline(int pid, char comm[])
 	if (map != NO_CMDLINE_MAP) {
 		tpid = savedcmd->map_cmdline_to_pid[map];
 		if (tpid == pid) {
-			strscpy(comm, get_saved_cmdlines(map), TASK_COMM_LEN);
+			*comm = *get_saved_cmdlines(map);
 			return;
 		}
 	}
-	strcpy(comm, "<...>");
+	strcpy(comm->comm, "<...>");
 }
 
-void trace_find_cmdline(int pid, char comm[])
+void trace_find_cmdline(int pid, struct trace_comm *comm)
 {
 	preempt_disable();
 	arch_spin_lock(&trace_cmdline_lock);
@@ -561,11 +567,11 @@ static void saved_cmdlines_stop(struct seq_file *m, void *v)
 
 static int saved_cmdlines_show(struct seq_file *m, void *v)
 {
-	char buf[TASK_COMM_LEN];
+	struct trace_comm buf;
 	unsigned int *pid = v;
 
-	__trace_find_cmdline(*pid, buf);
-	seq_printf(m, "%d %s\n", *pid, buf);
+	__trace_find_cmdline(*pid, &buf);
+	seq_printf(m, "%d %s\n", *pid, buf.comm);
 	return 0;
 }
 
-- 
2.39.5

