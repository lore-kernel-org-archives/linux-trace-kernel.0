Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262DD14C5B3;
	Fri, 29 Nov 2024 16:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732898894; cv=none; b=bzTv4O+tceVnnGfIZ/DiN7AntpSs/0L9BjOvPTWblXVtP8CVmNHH1On7hPO2UmuROcd6W2NuorVrj9bvWm6dRrsYGwQZnDfP70o9AhsQ6r4ez7tkvZnR9ixQLJvQcJyyx2v07nYLFkaTypWWO07BlA2SecFt/Alf8I+hj+OQwuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732898894; c=relaxed/simple;
	bh=lKW+UN1gtrpdcRVL8HfEsiSm3Hrt7GReKZv5w97QAsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kJuQhZGc+uqej9fAb76h9P++zg82DeqBctRenU7vcsdaN1BghhmYGjvYj04hU2Rh3RKXLMMUnf5zxqdGU3eUyoPs9/Zgufk6x46KpDsBmEnIflUfo9ZzDLH5Wuw0kyPlLThvL2xcrgpApzXA3kBXSdjFBNGgtspzNwBZn+5aQ0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqkQQdPA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqkQQdPA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497F6C4CECF;
	Fri, 29 Nov 2024 16:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732898893;
	bh=lKW+UN1gtrpdcRVL8HfEsiSm3Hrt7GReKZv5w97QAsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BqkQQdPAEfiFQPKT1bwY1lfQ5e2sTpoxwx+o/H1iZsD3anJjG3Y4vmq6gm20HDqFO
	 F3g7RPe6A1D5yOfahRxPnvkTZk7e5ngR6nZyRLT340Lq9FsvggPFULH5azz76jhf9t
	 6GUxQq2+W/dW+a2YRjINDQHIFVMCBecxFpi7CRLyHw/1qknPDeFysAmTV/bXoDRoyd
	 lo4/Wl4iB4epy6aPiFo46s+cE0S8B9YtteZDo15rTD2hCIyhflnVtjMnro8C2ZUTUN
	 4KR8Ifv/W3e9/gYLVwTlORUNorBE9kfTrk0LI0yPKIDOQzGeZwcZeOg4bbJbc5a0rq
	 OCqB1WoVlhgLQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Naveen N Rao <naveen@kernel.org>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] tracing/kprobe: Adopt guard() and scoped_guard()
Date: Sat, 30 Nov 2024 01:48:08 +0900
Message-ID: <173289888883.73724.6586200652276577583.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173289885627.73724.13632317993038475335.stgit@devnote2>
References: <173289885627.73724.13632317993038475335.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Use guard() or scoped_guard() in kprobe events for critical sections
rather than discrete lock/unlock pairs.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |   18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 263fac44d3ca..bae26eb14449 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -634,7 +634,7 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
 	struct trace_kprobe *old_tk;
 	int ret;
 
-	mutex_lock(&event_mutex);
+	guard(mutex)(&event_mutex);
 
 	old_tk = find_trace_kprobe(trace_probe_name(&tk->tp),
 				   trace_probe_group_name(&tk->tp));
@@ -642,11 +642,9 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
 		if (trace_kprobe_is_return(tk) != trace_kprobe_is_return(old_tk)) {
 			trace_probe_log_set_index(0);
 			trace_probe_log_err(0, DIFF_PROBE_TYPE);
-			ret = -EEXIST;
-		} else {
-			ret = append_trace_kprobe(tk, old_tk);
+			return -EEXIST;
 		}
-		goto end;
+		return append_trace_kprobe(tk, old_tk);
 	}
 
 	/* Register new event */
@@ -657,7 +655,7 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
 			trace_probe_log_err(0, EVENT_EXIST);
 		} else
 			pr_warn("Failed to register probe event(%d)\n", ret);
-		goto end;
+		return ret;
 	}
 
 	/* Register k*probe */
@@ -672,8 +670,6 @@ static int register_trace_kprobe(struct trace_kprobe *tk)
 	else
 		dyn_event_add(&tk->devent, trace_probe_event_call(&tk->tp));
 
-end:
-	mutex_unlock(&event_mutex);
 	return ret;
 }
 
@@ -706,7 +702,7 @@ static int trace_kprobe_module_callback(struct notifier_block *nb,
 		return NOTIFY_DONE;
 
 	/* Update probes on coming module */
-	mutex_lock(&event_mutex);
+	guard(mutex)(&event_mutex);
 	for_each_trace_kprobe(tk, pos) {
 		if (trace_kprobe_within_module(tk, mod)) {
 			/* Don't need to check busy - this should have gone. */
@@ -718,7 +714,6 @@ static int trace_kprobe_module_callback(struct notifier_block *nb,
 					module_name(mod), ret);
 		}
 	}
-	mutex_unlock(&event_mutex);
 
 	return NOTIFY_DONE;
 }
@@ -1968,13 +1963,12 @@ static __init void enable_boot_kprobe_events(void)
 	struct trace_kprobe *tk;
 	struct dyn_event *pos;
 
-	mutex_lock(&event_mutex);
+	guard(mutex)(&event_mutex);
 	for_each_trace_kprobe(tk, pos) {
 		list_for_each_entry(file, &tr->events, list)
 			if (file->event_call == trace_probe_event_call(&tk->tp))
 				trace_event_enable_disable(file, 1, 0);
 	}
-	mutex_unlock(&event_mutex);
 }
 
 static __init void setup_boot_kprobe_events(void)

