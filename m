Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E362D5A14;
	Mon,  6 Oct 2025 17:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759773538; cv=none; b=BspIfpHthM3MtB9T5t3PZ/69TtcUHPcqH+pju7U8MJaLAEz7X5qi+QNqNIA2GJAwQQD/oJec3xmpYudGOV9F2j4enTKkj/mUJRmH5TdD49d+ToNICKjgggAI47Iq7RQcJz7iiGPTxNhxuRi2oDHwmwivx0pwSexh3WimMR2/blE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759773538; c=relaxed/simple;
	bh=/KMdcdGisVl4dcCGckJsx5gRWrWh8HU17o3WRWDyWCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IRoGcakGuOp6RBe/B+76PO8kOtmWlDEorU2Ip/e+OShL0rWLG3WsGIJagv2qgzMtro9C7WRyzTFiyUVm3BfQBgDYx8lCMg775XblC5lR4ynlJpi0nl6MDjjE09PMDzrzdEFfc/sL7cojcq3bq6pBPAd+j931PwcR2jp98qm09qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCvrS++u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCvrS++u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1FFC113D0;
	Mon,  6 Oct 2025 17:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759773537;
	bh=/KMdcdGisVl4dcCGckJsx5gRWrWh8HU17o3WRWDyWCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LCvrS++uX4fegSNJfpga3slBp5QO8fhrSJ6NhD9liu9K6XAH6tOwDCbxkiTndq0zZ
	 59ugERVAL39iYrkdOMNWcModkit2IaR5ocTpTP7punahycAfyZb5UNOzv2/P+R8+JN
	 A6CPuUhcCyAOCibkMLshlX6oebTUv9oDfxBDlIlUcQYrJG55vZAjXJ0oQeLSXsHWgW
	 xB8Kh2L7zlm3PbrphopRs2PfwEiLZnS6gJaDhSAvkqHurnrCf8IFcCDWg2ansQsiPh
	 I3mQZc/EisV1myJ5PkDRcdfeOChxrzhEOv2NpCPTeFYbniALZXw6gjn3rDNXRK2X/f
	 zcQ31f9OoCHVg==
From: Sasha Levin <sashal@kernel.org>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 2/2] tracing/irqsoff: Balance prolog on fgraph failure
Date: Mon,  6 Oct 2025 13:58:48 -0400
Message-ID: <20251006175848.1906912-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251006175848.1906912-1-sashal@kernel.org>
References: <20251006175848.1906912-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit a485ea9e3ef3 ("tracing: Fix irqsoff and wakeup latency tracers when
using function graph") added fgraph_reserve_data()/fgraph_retrieve_data() to
the irqsoff tracer's function-graph hooks.

When func_prolog_dec() succeeded but those calls failed, the code returned
without undoing the prolog (no local_dec(&data->disabled)). While
func_prolog_dec() does not disable preemption, this left the tracer recursion
guard (data->disabled) incremented on this CPU, suppressing subsequent tracing
and leaving the tracer state inconsistent.

Balance the prolog on these failure paths in both entry and return hooks.

Fixes: a485ea9e3ef3 ("tracing: Fix irqsoff and wakeup latency tracers when using function graph")
Assisted-by: gpt-5-codex
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_irqsoff.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index 5496758b6c760..39152ef3d2432 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -202,8 +202,10 @@ static int irqsoff_graph_entry(struct ftrace_graph_ent *trace,
 		return 0;
 
 	calltime = fgraph_reserve_data(gops->idx, sizeof(*calltime));
-	if (!calltime)
+	if (!calltime) {
+		local_dec(&data->disabled);
 		return 0;
+	}
 
 	*calltime = trace_clock_local();
 
@@ -233,8 +235,10 @@ static void irqsoff_graph_return(struct ftrace_graph_ret *trace,
 
 	rettime = trace_clock_local();
 	calltime = fgraph_retrieve_data(gops->idx, &size);
-	if (!calltime)
+	if (!calltime) {
+		local_dec(&data->disabled);
 		return;
+	}
 
 	trace_ctx = tracing_gen_ctx_flags(flags);
 	__trace_graph_return(tr, trace, trace_ctx, *calltime, rettime);
-- 
2.51.0
