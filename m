Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25052F12A0;
	Thu, 30 Oct 2025 09:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761816312; cv=none; b=Ttdo6yOPmzciCp+c6iBLkCsv0CFT/WcIWGrs3pNIg7nD7E8pF01yIlg8ibyGJzo0pzqTNk76qtHLFNRZsFiyoqQ02/0BAA2uVjuy4EgNvsmeFtah5JWcssY428e1RVjb1yqHbYksOqeWxKh8D7SA7WRhGdxD8dzLoetV8lVUTbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761816312; c=relaxed/simple;
	bh=DpFpHz03fndgc3c3a2wxOlEQygIJTifzb1pJ8dcuoEI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OskIxO2Gf2q0qsSQ6QLL74s0R6oCk60b6lGN2IeKKr0rk1jRYPTIDloQ6TisBdlJ1SXmkdbG64d7cDxRn7LiRQOZGzqXkyhGXA0ZFEfGJF5sX6CzV2+Nl6cUIUVXM/Je4dD8RznvKG9sCP/zhe2knzl3Kkjf7QSaCMSXfDCD6B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 6014213C065;
	Thu, 30 Oct 2025 09:25:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 5D1D62D;
	Thu, 30 Oct 2025 09:25:06 +0000 (UTC)
Date: Thu, 30 Oct 2025 05:25:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] tracing: Add an option to show symbols in
 _text+offset for function profiler
Message-ID: <20251030052548.31130e33@gandalf.local.home>
In-Reply-To: <176179500583.960652.5730113001091388258.stgit@devnote2>
References: <176179500583.960652.5730113001091388258.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: hew37fn8857yrgqumogco8a64jydhi4p
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 5D1D62D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+XngP3+g5kU6Rih6QlNW7S74dhrSuOaYs=
X-HE-Tag: 1761816306-243772
X-HE-Meta: U2FsdGVkX18qE+Zdxv77pGAyBq4Y81FS+xkgunEdYQ5p1sEoqtM67K36eNvyLryb8eE8v3+Oo13xGcUL1xObQsqCF58zKZRXkjNK2Ispz6Nv2Azbjj877sxIxG8e2GD9++UsM6xyGxAq8Zd1s/1puqNTs6PAUo19UXrl69m5cpMenJ9ZSeabKLewqsjzr3898Vs1hj6MTZemvFZ92jCnlX9Er3PlkX+JaY8CfvYtMb9uFChJ8bY9/zeDxVOeUNHA4ZVVdKuVg8BOI2UQNCMMqSHyKGdmxA23HVQ/+dbSNBMgDqvtJ+Jtn8ldcPjcJtHXrLXMVAbC/bOIgStMfkjkeEgzSKwLdWpx

On Thu, 30 Oct 2025 12:30:05 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

>  kernel/trace/blktrace.c              |    6 +
>  kernel/trace/ftrace.c                |   26 ++++++
>  kernel/trace/trace.c                 |  154 +++++++++++++++++-----------------
>  kernel/trace/trace.h                 |   40 +++++----
>  kernel/trace/trace_events.c          |    4 -
>  kernel/trace/trace_events_synth.c    |    2 
>  kernel/trace/trace_fprobe.c          |    6 +
>  kernel/trace/trace_functions_graph.c |   18 ++--
>  kernel/trace/trace_irqsoff.c         |   30 +++----
>  kernel/trace/trace_kdb.c             |    2 
>  kernel/trace/trace_kprobe.c          |    6 +
>  kernel/trace/trace_output.c          |   18 ++--
>  kernel/trace/trace_sched_wakeup.c    |   24 +++--
>  kernel/trace/trace_syscalls.c        |    4 -
>  kernel/trace/trace_wprobe.c          |    2 

I didn't realize this affected your branch too. Which means I can't apply
this to any branch.

Also, could you make a helper function...

+++ b/kernel/trace/trace_wprobe.c
@@ -260,7 +260,7 @@ print_wprobe_event(struct trace_iterator *iter, int flags,
 
        trace_seq_printf(s, "%s: (", trace_probe_name(tp));
 
-       if (!seq_print_ip_sym(s, field->ip, flags | TRACE_ITER_SYM_OFFSET))
+       if (!seq_print_ip_sym(s, field->ip, flags | TRACE_ITER(SYM_OFFSET)))
                goto out;
 
        trace_seq_putc(s, ')');

that both fprobe and wprobe use? And then you don't need to have this open
coded everywhere.

That is, add this patch:

diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 591adc9bb1e9..bd26004cc320 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -598,3 +598,9 @@ struct uprobe_dispatch_data {
 	struct trace_uprobe	*tu;
 	unsigned long		bp_addr;
 };
+
+static inline int probe_print_ip_sym(struct trace_seq *s, unsigned long ip,
+				     int flags)
+{
+	retun seq_print_ip_sym(s, field->ip, flags | TRACE_ITER_SYM_OFFSET);
+}

And use that instead.

So, new plan. Base this patch on top of v6.18-rc3 and send that.

Then what we can do is merge this branch into your branch and my branch and
add on top of it.

Note, you should have rebased your probe branch on top of one of the
v6.18-rc releases. It's still based on top of 6.17-rc6, which can cause
other issues.


-- Steve
