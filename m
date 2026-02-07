Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DC725F798;
	Sat,  7 Feb 2026 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770476183; cv=none; b=ddaNFuARul4c68nvxyguJUfBfNAdQrnTOfIyeGn9xFwjDR03bXC75Mge/SOABKUdwpw8CVFaPBOGks1QAoMgANyw/GaN0kH3U68f4skmIVGkVqYxYgIShYbEpY5iTgHWshDhz5UaEVcycNmagoxxa2CfOl+K1l09Pitk/As+rl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770476183; c=relaxed/simple;
	bh=Y6ZIj0/DCGFVsn5z6/DwxJnkTncBodEWiZC4H/XclQY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oGirr78/X6YSSf//n7TNITu6RrjiNnbqJPPpIgu8H7aueyOiav6xRxSBBIpomrmeW7uWfjDiFNxoL+HnJFOzx9ycf1ijL3Lp2zU1l4I/mRBGS9IN4MbDxNLsUurZHhTjw8t07KApFbW3CPY77W30UdeoT2Koq1LIc0MobtrQVyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 1705E13ABCD;
	Sat,  7 Feb 2026 14:56:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 15F3680009;
	Sat,  7 Feb 2026 14:56:14 +0000 (UTC)
Date: Sat, 7 Feb 2026 09:56:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 00/12] tracing: Clean up trace.c and move some code into
 other files
Message-ID: <20260207095612.6a1b2452@robin>
In-Reply-To: <20260206193741.767171392@kernel.org>
References: <20260206193741.767171392@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 15F3680009
X-Stat-Signature: 7pehzm5qsz4ek5h11umdz7xiygk8bmg8
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/CFK29JvnKGCdXS/ai3lUScY4m+6Letww=
X-HE-Tag: 1770476174-290528
X-HE-Meta: U2FsdGVkX19jXAxzRGbKlM9i52D0CHsGccLWlyX+AYN6tDaJM+w/i62iKFWk1fYcCpKh4KFBvG1DLCqjre+jknyU2YcEuwSzcGnRhRRU8RtPuuZ2ysgU90TdWQ6VBs0KkUPct5l2SFuSsXWlcxHo+hS7ppVtBpQJo1UKPnOmTBNhSGKnEw0o+53OLiX/09n46ECFvcZY4d+tvdDFYOpHjCuhX84uXurHKR6LaiVx14hheBS14W+QTBB7/HufMkox22ZQOxZQBFmg5VOFGHtKT4Pgng1AAzVvJVdh1A/1jwVohCiUqpNBVXVcPhodrR8XM4JM6kXLYUt4LOmL+6SJQTt7LUJa772X

On Fri, 06 Feb 2026 14:37:41 -0500
Steven Rostedt <rostedt@kernel.org> wrote:

> I have done basic testing with this code, but it hasn't gone through
> my full test suite. I'll start that now. Those tests test various config
> options which may catch something I missed.

After running it through my main tests it did find several issues with
the last patch. I do want most of this to get into the next merge
window, so I'm going to drop the last patch and see if the rest have no
issues. This is just a clean up and moving code around. It shouldn't be
too risky. The last patch required getting all the functions from being
static to global and with the right configs, so that's a bit too
complex for this late in the game.

-- Steve

> 
> 
> Steven Rostedt (12):
>       tracing: Make tracing_disabled global for tracing system
>       tracing: Make tracing_selftest_running global to the tracing subsystem
>       tracing: Move __trace_buffer_{un}lock_*() functions to trace.h
>       tracing: Move ftrace_trace_stack() out of trace.c and into trace.h
>       tracing: Make printk_trace global for tracing system
>       tracing: Make tracing_update_buffers() take NULL for global_trace
>       tracing: Have trace_printk functions use flags instead of using global_trace
>       tracing: Use system_state in trace_printk_init_buffers()
>       tracing: Move trace_printk functions out of trace.c and into trace_printk.c
>       tracing: Move pid filtering into trace_pid.c
>       tracing: Move tracing_set_filter_buffering() into trace_events_hist.c
>       tracing: Move snapshot code out of trace.c and into trace_snapshot.c

