Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD121991DD;
	Thu, 17 Apr 2025 22:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744929926; cv=none; b=Hbpbty/B29Jejm31G7YZDuGiBsNNlqHyVJMcQX3UlMNV0bAdVGAL7sKg/z2UFfVuqe9iYxmcflza3WkRf2gCX/Ma4mn8InSKdcewbpX9mR6n4C9CnpZJjWECluuqqCjuSzfgd1jVTs3Z19YIgzPRW1ns35y8rqf1fnEokUWnXjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744929926; c=relaxed/simple;
	bh=A/Mp0zLisBIIjllZzrN3JfIF8CokUwQ+aC4E2YlCKUg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ul3ZmQDTAmx1t/ubKqLQ803hZxwVshngJwqq5zqISjkVCZJ2yBO1YVN6vyRcrhm5rptP2z8yql/QyRnfd5awk70wJDJej+qb9mSsbIpXj6wGfa+Mj7+hiR3WmhK4oJr8l1vk2e1FQ4n9y1dHSlJnFsZdLOtATvrAx9ylkSFCQ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRykDGeV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRykDGeV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D0CC4CEE4;
	Thu, 17 Apr 2025 22:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744929925;
	bh=A/Mp0zLisBIIjllZzrN3JfIF8CokUwQ+aC4E2YlCKUg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XRykDGeVv/2uepuBb8jPGd64IYp/uBQSTNknwMpv75nhoU8ZIhm19aONskwqQzGPw
	 aYU3juHTAjrlpDyU17Hr3tj6AsVrMfgESFFtLOufs7n4EHN9I249ZQavQLBEbx5NwG
	 bDjIfG8tbMBkAQbipZBhng+sDa6wVwmwX8BS2F10T2fauTKpoYlbJWwhUPhkZPf450
	 5U8PXHNXW8rnwc8nPodk90wNj+t0C/fllaohtJ0hdrQDI9RoYoVnKzQArXGGSBY0/q
	 Eb8W60jPb7vu1LpWhvBdcSORK9xW7CmzHAHlG3soLe059kktCUE7jZT/YLcEorTo7T
	 D8US69xLdVk3g==
Date: Fri, 18 Apr 2025 07:45:23 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: Record trace_clock and recover when reboot
Message-Id: <20250418074523.ae5e9f56950e431d60fc0c79@kernel.org>
In-Reply-To: <20250417101804.3117e478@gandalf.local.home>
References: <174486704950.3973933.810283141514120282.stgit@mhiramat.tok.corp.google.com>
	<20250417101804.3117e478@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Apr 2025 10:18:04 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 17 Apr 2025 14:17:29 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -6004,6 +6004,7 @@ struct trace_mod_entry {
> >  };
> >  
> >  struct trace_scratch {
> > +	char			clock[TRACE_CLOCK_NAME_MAX];
> >  	unsigned long		text_addr;
> >  	unsigned long		nr_entries;
> >  	struct trace_mod_entry	entries[];
> > @@ -6114,6 +6115,8 @@ static void update_last_data(struct trace_array *tr)
> >  	if (tr->scratch) {
> >  		struct trace_scratch *tscratch = tr->scratch;
> >  
> > +		strscpy(tscratch->clock, trace_clocks[tr->clock_id].name,
> 
> Why copy the name and not the clock_id?

The name is more robust if we rebooted in the different kernel.

> 
> The clock ids should not change between kernels.

Hmm, I thought it could be changed because we didn't define it.

----
static struct {
	u64 (*func)(void);
	const char *name;
	int in_ns;		/* is this clock in nanoseconds? */
} trace_clocks[] = {
	{ trace_clock_local,		"local",	1 },
	{ trace_clock_global,		"global",	1 },
	{ trace_clock_counter,		"counter",	0 },
	{ trace_clock_jiffies,		"uptime",	0 },
	{ trace_clock,			"perf",		1 },
	{ ktime_get_mono_fast_ns,	"mono",		1 },
	{ ktime_get_raw_fast_ns,	"mono_raw",	1 },
	{ ktime_get_boot_fast_ns,	"boot",		1 },
	{ ktime_get_tai_fast_ns,	"tai",		1 },
	ARCH_TRACE_CLOCKS
};
----

So the clock id is just an index of this array. That can be changed
easily between the kernel version. If we discard the previous boot
data in that case, I agree with using clock ids.

(Another reason for the implementation is that tracing_set_clock()
 only accepts a name, but this is just due to laziness on my part. :-( )

Thank you,

> 
> -- Steve
> 
> > +			TRACE_CLOCK_NAME_MAX);
> >  		memset(tscratch->entries, 0,
> >  		       flex_array_size(tscratch, entries, tscratch->nr_entries));
> >  		tscratch->nr_entries = 0;


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
