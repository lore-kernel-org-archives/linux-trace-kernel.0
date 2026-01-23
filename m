Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B534295DBD;
	Fri, 23 Jan 2026 01:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769132723; cv=none; b=rG//1ag2LxY3YkzEpwqfp3do3t5TtXDiM1PG5GLA2djPDFeTLGS8dqundZb0py3KnBLYW0oX6+i95PyqvjuXKj0SeRA3f5TqmQFfw0bk7kvtBH3Ur4IN1uQSLJBLsFueL4ppQeYvSuaxk5/pv42NcNb0bLXAf2R3b+Md0+0cF/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769132723; c=relaxed/simple;
	bh=WcRDCLcyRXYTFIrdzYuIDO7h+x3yqMvMCvgb4iyzeSY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=knoNdtwJFNHpQ8clPAtg1Oum3Zlgv6YoiJmmgVfCrWBxTbNCePVPoi6EYzIWjzT91lHT0ZxgyRSbEJzb+eR+cCjyoOT4TuC5ETYR5qp6jqwjcHtC2ICKvfZ5yPH828I475VVsqYCVvrVVekDhNpSSioZUjydtMnIvqb7gLHJBvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 14BA213D3AD;
	Fri, 23 Jan 2026 01:45:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 424F720027;
	Fri, 23 Jan 2026 01:45:00 +0000 (UTC)
Date: Thu, 22 Jan 2026 20:45:26 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH] tracing: Remove notrace from trace_event_raw_event_synth()
Message-ID: <20260122204526.068a98c9@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 424F720027
X-Stat-Signature: 79htmiin8f6us5hf1xz7egnax51swfpe
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+iXSWvB2J3Ke4YzgcezNZL/Pa6nUKHmTQ=
X-HE-Tag: 1769132700-912107
X-HE-Meta: U2FsdGVkX1+Hlsp7QSnqeQOi/tNQq4haPd5oa8vQ9p1KsWVX8A5LRJr6Mg3/HtKC+BG+SmFt6mtVLlk7CAlDCE9pipLyGQGrgjILFQ9+QlAiQ3U4oMQCIlmrWrUzuRWSc+su6rLetpzSL4WvkGGq/nwq28G1xjaDnFuNZUcgxCuB8ZRcb3/o8YSWvVHdhCrEZPTkQA1yhNiP9KG0HqbVtfccs5q7hiCGzyXEs1+gvEE0hxAtRPqXHJWTvVvM2kGISOUTYtsFZTO+XuaoCqul/2koT8azXYSFEiJ2RPi0wZcWiNRZqD9Sh7ObmibkS5HYafXQeK4lXejNA6SgsQI4zXLwyFypfKeKAdCp1e0dDEC1hP50VZzF1iSJC/2DqaPg

From: Steven Rostedt <rostedt@goodmis.org>

When debugging the synthetic events, being able to function trace its
functions is very useful (now that CONFIG_FUNCTION_SELF_TRACING is
available). For some reason trace_event_raw_event_synth() was marked as
"notrace", which was totally unnecessary as all of the tracing directory
had function tracing disabled until the recent FUNCTION_SELF_TRACING was
added.

Remove the notrace annotation from trace_event_raw_event_synth() as
there's no reason to not trace it when tracing synthetic event functions.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_synth.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 4554c458b78c..79a506fc2856 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -493,9 +493,9 @@ static unsigned int trace_stack(struct synth_trace_event *entry,
 	return len;
 }
 
-static notrace void trace_event_raw_event_synth(void *__data,
-						u64 *var_ref_vals,
-						unsigned int *var_ref_idx)
+static void trace_event_raw_event_synth(void *__data,
+					u64 *var_ref_vals,
+					unsigned int *var_ref_idx)
 {
 	unsigned int i, n_u64, val_idx, len, data_size = 0;
 	struct trace_event_file *trace_file = __data;
-- 
2.51.0

