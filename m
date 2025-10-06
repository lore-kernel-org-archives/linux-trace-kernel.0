Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7572C235E;
	Mon,  6 Oct 2025 17:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759773537; cv=none; b=kL6mjzjBS8Boe1aYCR/HnKNK2LXO/S3DSY6RFWdyiBYTXgPPnmjArycQE0hWDgwXx7pBCShYrXJwwRHuf8kg2Lz3vCtes7SCM2N0YSLhD4HwWVjSCYByKqvkqF4LymxSxfkx4sUNjEYdWtSBLw5AEfknK7yg7MQKcv/mpwWyEdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759773537; c=relaxed/simple;
	bh=rwl1eMVoOI34wgRRQ/sE+tlqYZUKrsAzxbwQaW/U1GU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DxsFYSGXALFuTBSaxxsIw0BmkzDtWoQ92YnhjIVfVmESJoq7XtZw0p5iSzXZGiyDPSboDISa62yZBhBbpiHHyLezp3J8vkt3xYByr8BuYck+0YPlW/pb0tR7MpKlreiYJCJOvNeiNLvxpKmG6VhDurXV4JkXox0oXT6w5cLbCro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fo6WZMdQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fo6WZMdQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5823C4CEF7;
	Mon,  6 Oct 2025 17:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759773536;
	bh=rwl1eMVoOI34wgRRQ/sE+tlqYZUKrsAzxbwQaW/U1GU=;
	h=From:To:Cc:Subject:Date:From;
	b=fo6WZMdQk5bcnLBV024NYrXXSNzF/6lMcqyIyRVa53zB3g+bXuzJAq44V5E/iEEWN
	 g0ea0BUG0McLqKKTRooGkFdroMc8Cy+m6bYz22SPtGv5Ncya/d7I+VSt+qDBjjhtJE
	 IzT/8Y4K2MwVx0Rch6kWB35f/PLxChfSbO6B7gwGdbnQrJ/GE2nM0hOkxU4zThEmvJ
	 fFNA6DmRN9+saB3//hTqY5oYZ8dGI8x1xDAzJS78KJaVLukVHDzG3Fn7TimB+BibMn
	 gxQOlsjin0UJQ6V5a+2VjCk962SAYKbvCUrhOL59zM0OJQGfmSDYsmOGs6QmAJjjK5
	 oe7YyctzKrC4A==
From: Sasha Levin <sashal@kernel.org>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 1/2] tracing/wakeup: Balance prolog on fgraph failure
Date: Mon,  6 Oct 2025 13:58:47 -0400
Message-ID: <20251006175848.1906912-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit a485ea9e3ef3 ("tracing: Fix irqsoff and wakeup latency tracers when
using function graph") added fgraph_reserve_data()/fgraph_retrieve_data() to
the wakeup tracer's function-graph hooks.

When func_prolog_preempt_disable() succeeded but those calls failed, the code
returned without undoing the prolog (no local_dec(&data->disabled), no
preempt_enable_notrace()). That leaked a preempt disable into later code and
could trigger "BUG: scheduling while atomic".

Balance the prolog on these failure paths in both entry and return hooks.

Fixes: a485ea9e3ef3 ("tracing: Fix irqsoff and wakeup latency tracers when using function graph")
Assisted-by: gpt-5-codex
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_sched_wakeup.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index bf1cb80742aed..fa48bbdf0851c 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -138,8 +138,11 @@ static int wakeup_graph_entry(struct ftrace_graph_ent *trace,
 		return 0;
 
 	calltime = fgraph_reserve_data(gops->idx, sizeof(*calltime));
-	if (!calltime)
+	if (!calltime) {
+		local_dec(&data->disabled);
+		preempt_enable_notrace();
 		return 0;
+	}
 
 	*calltime = trace_clock_local();
 
@@ -169,8 +172,11 @@ static void wakeup_graph_return(struct ftrace_graph_ret *trace,
 	rettime = trace_clock_local();
 
 	calltime = fgraph_retrieve_data(gops->idx, &size);
-	if (!calltime)
+	if (!calltime) {
+		local_dec(&data->disabled);
+		preempt_enable_notrace();
 		return;
+	}
 
 	__trace_graph_return(tr, trace, trace_ctx, *calltime, rettime);
 	local_dec(&data->disabled);
-- 
2.51.0

