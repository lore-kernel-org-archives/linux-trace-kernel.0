Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8EF32C94A;
	Thu,  8 Jan 2026 22:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767912240; cv=none; b=YLMkW5GvYxhwrTaZ4sJrOid5sHmz/G+/8XxhBE/bWjXAz3QwcpyAP2DzsdpKyOiu5KPsNcn9Ha4fpjfOEPLnV5D0h9Of4AVkypgFNdL8M2IORChG6sWInqYoyLMZ5lC4TRn6I64fPg2zIugkQ7R6oACs/ixzVyJo+1cLYZmzjMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767912240; c=relaxed/simple;
	bh=HeiWW3fNlr5ujb8IgDiStM3Ms65aD7jakELXskU6xK4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=bM5LxoErfNcwD9IBhLlGdP1h8JXfDfpwlMlKqvTAByrVPHK9IA56wRaRg0Z0MjYqDWDLtolRcNHbrhR0JXHhXflWcBFN+5eWzBK+SCWA0tpmp66Jg9408A/RJzRBN7HjC3l6WODYmCrTsnZ3tLPvQctDhWliLRQBXblbIsIzr3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqpuITZW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqpuITZW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D1BC116C6;
	Thu,  8 Jan 2026 22:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767912240;
	bh=HeiWW3fNlr5ujb8IgDiStM3Ms65aD7jakELXskU6xK4=;
	h=Date:From:To:Cc:Subject:From;
	b=LqpuITZWM9lWRq1c9kWhm8TkFxYVbKpRrRPMVsIWRsFhbdiqh26MY4X94h8a10t0T
	 jjAk6kSFjk4EPtWeVkrn/OREvTsBrVCuO7OoZ9/pDRr272I7qW0QOb0vvlDzp6klOT
	 p5mhelH4dFATQ++KOVfkU0SvCxYk0xpmkHrs6bKyqif4eAbBKgt6IltkKlDDHJezN2
	 S6C+1tNN6FIOKTajxVG2HYkmrSXVTktsTECuIYGDIgXex/8l4QrFuL8CZeGg7vA26c
	 maKrQEZH2GgRwCCFYxyPeeAAKfX7C32EwL/tAvKfR5z3/tUZDmFIxKBqiOIUiNTON7
	 n6cuxZ64TEjpg==
Date: Thu, 8 Jan 2026 17:44:29 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Miaoqian Lin <linmq006@gmail.com>
Subject: [PATCH] tracing: Remove redundant call to
 event_trigger_reset_filter() in event_hist_trigger_parse()
Message-ID: <20260108174429.2d9ca51f@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

With the change to replace kfree() with trigger_data_free(), which starts
out doing the exact same thing as event_trigger_reset_filter(), there's no
reason to call event_trigger_reset_filter() before calling
trigger_data_free(). Remove the call to it.

Link: https://lore.kernel.org/linux-trace-kernel/20251211204520.0f3ba6d1@fedora/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index f9886fff7123..4a7f945e368d 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6898,8 +6898,6 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
  out_unreg:
 	event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
  out_free:
-	event_trigger_reset_filter(cmd_ops, trigger_data);
-
 	remove_hist_vars(hist_data);
 
 	trigger_data_free(trigger_data);
-- 
2.51.0

