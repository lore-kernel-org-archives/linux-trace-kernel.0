Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADA110E5;
	Sun,  9 Mar 2025 11:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741521385; cv=none; b=E7bHHxOjJwTSncNhCCZTj81wKAPKOMyEX41bc2TteFOiFMm/CoWE8D+xj6EFtkGckkBoUTSRCny1T0lbPk+EsNA05l5BP4nuGC45o0qNU+kGxn92ISW+o8J6U2+Spt40h0NuByTAXDGRPNA9tAI8BX3V2VCoD2LQ7miWXfpkCUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741521385; c=relaxed/simple;
	bh=JDUMq0R5Umlo/3rTwDj0VAv71rMgmH8LLUmYjZiD3Do=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZX26i+JSj83QQQ1vw40V+jedTpMCfwr37RoQPr8BmKvrsIEhKra1q/mu4XCl03OLVEVIj1B+IAzSMiemoXQ5NHocM+1wEgcGkHd19mdE6Cnl7kbT1NhRfAyCsFJxQxB3EMkpg/n1Hp0glJwdaMcH68G1Rmx1WzzgRwX9+p4vQcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=s2b+9s+3; arc=none smtp.client-ip=80.12.242.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="s2b+9s+3"
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id rFGQtpkDgPGDMrFGTtbkkZ; Sun, 09 Mar 2025 12:56:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1741521379;
	bh=H0s5CDqPZDbyKDmt23WAeBdwAAE/k7OMy3tznpH5qp0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=s2b+9s+3BQROKzRSjzGc2G8ccWqS9fED8EA6UGQEVSwMPCz/7MoPjoXWA2zLkzSlz
	 Jpk1g5TVXoldiCZbYdXZKTMq9iu2akQWGVEdkTcbV/Z7vyq7pUnMvssi8cc8WbP6F4
	 ADpyPtMrWQZ+DGpUOWbl1jIVvE8qtwbFJfr1wyjwFGnkdEqwmu+XE7Vd6fsP3iTe2Y
	 McRVkWUc6ngWJJGe06ZNcthOs91hCSlL2tyjJyW+j2SlCIXwnSqj4rR6DTCpM90Hlm
	 eaBZiDtLaNkyz+Si3szhJ5ky+YZVuGL+FNIEbyqJb0zzYLLOnGMrq76D8iH6IJ48yR
	 vUPhAasLmAH6A==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 09 Mar 2025 12:56:19 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: Constify struct event_trigger_ops
Date: Sun,  9 Mar 2025 12:56:06 +0100
Message-ID: <66e8f990e649678e4be37d4d1a19158ca0dea2f4.1741521295.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'event_trigger_ops mwifiex_if_ops' are not modified in these drivers.

Constifying these structures moves some data to a read-only section, so
increase overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig, as an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  31368	   9024	   6200	  46592	   b600	kernel/trace/trace_events_trigger.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  31752	   8608	   6200	  46560	   b5e0	kernel/trace/trace_events_trigger.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.
---
 kernel/trace/trace.h                |  4 +--
 kernel/trace/trace_eprobe.c         |  6 ++---
 kernel/trace/trace_events_hist.c    | 20 +++++++--------
 kernel/trace/trace_events_trigger.c | 38 ++++++++++++++---------------
 4 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 5307daa2dacb..abab9442ac0e 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1718,7 +1718,7 @@ struct event_trigger_data {
 	unsigned long			count;
 	int				ref;
 	int				flags;
-	struct event_trigger_ops	*ops;
+	const struct event_trigger_ops	*ops;
 	struct event_command		*cmd_ops;
 	struct event_filter __rcu	*filter;
 	char				*filter_str;
@@ -1963,7 +1963,7 @@ struct event_command {
 	int			(*set_filter)(char *filter_str,
 					      struct event_trigger_data *data,
 					      struct trace_event_file *file);
-	struct event_trigger_ops *(*get_trigger_ops)(char *cmd, char *param);
+	const struct event_trigger_ops *(*get_trigger_ops)(char *cmd, char *param);
 };
 
 /**
diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index af9fa0632b57..c08355c3ef32 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -478,7 +478,7 @@ static void eprobe_trigger_func(struct event_trigger_data *data,
 	__eprobe_trace_func(edata, rec);
 }
 
-static struct event_trigger_ops eprobe_trigger_ops = {
+static const struct event_trigger_ops eprobe_trigger_ops = {
 	.trigger		= eprobe_trigger_func,
 	.print			= eprobe_trigger_print,
 	.init			= eprobe_trigger_init,
@@ -507,8 +507,8 @@ static void eprobe_trigger_unreg_func(char *glob,
 
 }
 
-static struct event_trigger_ops *eprobe_trigger_get_ops(char *cmd,
-							char *param)
+static const struct event_trigger_ops *eprobe_trigger_get_ops(char *cmd,
+							      char *param)
 {
 	return &eprobe_trigger_ops;
 }
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index ad7419e24055..0a962e929243 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6191,7 +6191,7 @@ static void event_hist_trigger_free(struct event_trigger_data *data)
 	}
 }
 
-static struct event_trigger_ops event_hist_trigger_ops = {
+static const struct event_trigger_ops event_hist_trigger_ops = {
 	.trigger		= event_hist_trigger,
 	.print			= event_hist_trigger_print,
 	.init			= event_hist_trigger_init,
@@ -6223,15 +6223,15 @@ static void event_hist_trigger_named_free(struct event_trigger_data *data)
 	}
 }
 
-static struct event_trigger_ops event_hist_trigger_named_ops = {
+static const struct event_trigger_ops event_hist_trigger_named_ops = {
 	.trigger		= event_hist_trigger,
 	.print			= event_hist_trigger_print,
 	.init			= event_hist_trigger_named_init,
 	.free			= event_hist_trigger_named_free,
 };
 
-static struct event_trigger_ops *event_hist_get_trigger_ops(char *cmd,
-							    char *param)
+static const struct event_trigger_ops *event_hist_get_trigger_ops(char *cmd,
+								  char *param)
 {
 	return &event_hist_trigger_ops;
 }
@@ -6826,38 +6826,38 @@ hist_enable_count_trigger(struct event_trigger_data *data,
 	hist_enable_trigger(data, buffer, rec, event);
 }
 
-static struct event_trigger_ops hist_enable_trigger_ops = {
+static const struct event_trigger_ops hist_enable_trigger_ops = {
 	.trigger		= hist_enable_trigger,
 	.print			= event_enable_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_enable_trigger_free,
 };
 
-static struct event_trigger_ops hist_enable_count_trigger_ops = {
+static const struct event_trigger_ops hist_enable_count_trigger_ops = {
 	.trigger		= hist_enable_count_trigger,
 	.print			= event_enable_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_enable_trigger_free,
 };
 
-static struct event_trigger_ops hist_disable_trigger_ops = {
+static const struct event_trigger_ops hist_disable_trigger_ops = {
 	.trigger		= hist_enable_trigger,
 	.print			= event_enable_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_enable_trigger_free,
 };
 
-static struct event_trigger_ops hist_disable_count_trigger_ops = {
+static const struct event_trigger_ops hist_disable_count_trigger_ops = {
 	.trigger		= hist_enable_count_trigger,
 	.print			= event_enable_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_enable_trigger_free,
 };
 
-static struct event_trigger_ops *
+static const struct event_trigger_ops *
 hist_enable_get_trigger_ops(char *cmd, char *param)
 {
-	struct event_trigger_ops *ops;
+	const struct event_trigger_ops *ops;
 	bool enable;
 
 	enable = (strcmp(cmd, ENABLE_HIST_STR) == 0);
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index d45448947094..b66b6d235d91 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -825,7 +825,7 @@ struct event_trigger_data *event_trigger_alloc(struct event_command *cmd_ops,
 					       void *private_data)
 {
 	struct event_trigger_data *trigger_data;
-	struct event_trigger_ops *trigger_ops;
+	const struct event_trigger_ops *trigger_ops;
 
 	trigger_ops = cmd_ops->get_trigger_ops(cmd, param);
 
@@ -1367,38 +1367,38 @@ traceoff_trigger_print(struct seq_file *m, struct event_trigger_data *data)
 				   data->filter_str);
 }
 
-static struct event_trigger_ops traceon_trigger_ops = {
+static const struct event_trigger_ops traceon_trigger_ops = {
 	.trigger		= traceon_trigger,
 	.print			= traceon_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_trigger_free,
 };
 
-static struct event_trigger_ops traceon_count_trigger_ops = {
+static const struct event_trigger_ops traceon_count_trigger_ops = {
 	.trigger		= traceon_count_trigger,
 	.print			= traceon_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_trigger_free,
 };
 
-static struct event_trigger_ops traceoff_trigger_ops = {
+static const struct event_trigger_ops traceoff_trigger_ops = {
 	.trigger		= traceoff_trigger,
 	.print			= traceoff_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_trigger_free,
 };
 
-static struct event_trigger_ops traceoff_count_trigger_ops = {
+static const struct event_trigger_ops traceoff_count_trigger_ops = {
 	.trigger		= traceoff_count_trigger,
 	.print			= traceoff_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_trigger_free,
 };
 
-static struct event_trigger_ops *
+static const struct event_trigger_ops *
 onoff_get_trigger_ops(char *cmd, char *param)
 {
-	struct event_trigger_ops *ops;
+	const struct event_trigger_ops *ops;
 
 	/* we register both traceon and traceoff to this callback */
 	if (strcmp(cmd, "traceon") == 0)
@@ -1491,21 +1491,21 @@ snapshot_trigger_print(struct seq_file *m, struct event_trigger_data *data)
 				   data->filter_str);
 }
 
-static struct event_trigger_ops snapshot_trigger_ops = {
+static const struct event_trigger_ops snapshot_trigger_ops = {
 	.trigger		= snapshot_trigger,
 	.print			= snapshot_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_trigger_free,
 };
 
-static struct event_trigger_ops snapshot_count_trigger_ops = {
+static const struct event_trigger_ops snapshot_count_trigger_ops = {
 	.trigger		= snapshot_count_trigger,
 	.print			= snapshot_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_trigger_free,
 };
 
-static struct event_trigger_ops *
+static const struct event_trigger_ops *
 snapshot_get_trigger_ops(char *cmd, char *param)
 {
 	return param ? &snapshot_count_trigger_ops : &snapshot_trigger_ops;
@@ -1586,21 +1586,21 @@ stacktrace_trigger_print(struct seq_file *m, struct event_trigger_data *data)
 				   data->filter_str);
 }
 
-static struct event_trigger_ops stacktrace_trigger_ops = {
+static const struct event_trigger_ops stacktrace_trigger_ops = {
 	.trigger		= stacktrace_trigger,
 	.print			= stacktrace_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_trigger_free,
 };
 
-static struct event_trigger_ops stacktrace_count_trigger_ops = {
+static const struct event_trigger_ops stacktrace_count_trigger_ops = {
 	.trigger		= stacktrace_count_trigger,
 	.print			= stacktrace_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_trigger_free,
 };
 
-static struct event_trigger_ops *
+static const struct event_trigger_ops *
 stacktrace_get_trigger_ops(char *cmd, char *param)
 {
 	return param ? &stacktrace_count_trigger_ops : &stacktrace_trigger_ops;
@@ -1711,28 +1711,28 @@ void event_enable_trigger_free(struct event_trigger_data *data)
 	}
 }
 
-static struct event_trigger_ops event_enable_trigger_ops = {
+static const struct event_trigger_ops event_enable_trigger_ops = {
 	.trigger		= event_enable_trigger,
 	.print			= event_enable_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_enable_trigger_free,
 };
 
-static struct event_trigger_ops event_enable_count_trigger_ops = {
+static const struct event_trigger_ops event_enable_count_trigger_ops = {
 	.trigger		= event_enable_count_trigger,
 	.print			= event_enable_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_enable_trigger_free,
 };
 
-static struct event_trigger_ops event_disable_trigger_ops = {
+static const struct event_trigger_ops event_disable_trigger_ops = {
 	.trigger		= event_enable_trigger,
 	.print			= event_enable_trigger_print,
 	.init			= event_trigger_init,
 	.free			= event_enable_trigger_free,
 };
 
-static struct event_trigger_ops event_disable_count_trigger_ops = {
+static const struct event_trigger_ops event_disable_count_trigger_ops = {
 	.trigger		= event_enable_count_trigger,
 	.print			= event_enable_trigger_print,
 	.init			= event_trigger_init,
@@ -1916,10 +1916,10 @@ void event_enable_unregister_trigger(char *glob,
 		data->ops->free(data);
 }
 
-static struct event_trigger_ops *
+static const struct event_trigger_ops *
 event_enable_get_trigger_ops(char *cmd, char *param)
 {
-	struct event_trigger_ops *ops;
+	const struct event_trigger_ops *ops;
 	bool enable;
 
 #ifdef CONFIG_HIST_TRIGGERS
-- 
2.48.1

