Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48AB2773EC;
	Tue, 18 Nov 2025 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763483077; cv=none; b=tZIV0PsbAkK0dP60bzpgxgDOy0yGyZo91xyeoNeukRPQhiZl4mLHQwhZ4FEiBh+xua7BA3nKQuV4V8WEni0H+eJZ6iPC073+cy1Dsh8BEdRJitmduyJY8L6WmWMhyVwg3JIYPj4mRe3spWMt8/P1aDwMc5k7UZNegntB6WjPelQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763483077; c=relaxed/simple;
	bh=C3kMreGGlxn7Luh014qdzUi9i7RSS38nl2yZ1OvMIX4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jzpgfo/UuI1MSb0Ub7/jN2SRlIIvO7hwROn/AVgX05GeRVTjvZ7vVQX0iX+YqLXMpSesVjZJXab1Gc1v3kD1LXlgG1Cx5VSjDzsSGjge6DfV+MdHV04LJ3dVWzo+R994RdBS3HdXGJUe8Hlr+wA2bdv7/ssZXbJ4YEGUJ7bah44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id D0C7712EA38;
	Tue, 18 Nov 2025 16:24:27 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id E58AB6000A;
	Tue, 18 Nov 2025 16:24:24 +0000 (UTC)
Date: Tue, 18 Nov 2025 11:24:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Ian Rogers <irogers@google.com>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Douglas
 Raillard <douglas.raillard@arm.com>
Subject: Re: [POC][RFC][PATCH 0/3] tracing: Add perf events to trace buffer
Message-ID: <20251118112452.61c7de68@gandalf.local.home>
In-Reply-To: <aRwfhIT4pJ0pbY2k@google.com>
References: <20251118002950.680329246@kernel.org>
	<aRwfhIT4pJ0pbY2k@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 91bf7ns6uqwihj9dggy7pdxfqjoc7b13
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: E58AB6000A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+7z8qS4mthW4y6S9dlGuX8VocNJu0mHjg=
X-HE-Tag: 1763483064-427765
X-HE-Meta: U2FsdGVkX1/FTaFBC04Ba2J0rcqZWjhsohzIf5+nXFWwyyIZn0W8t/Wr0DcKCRRHxstDgTYes+EbtELiuYwTo1zEfEhFAzizgwpEnJIt7xw1fsB+LEBVN1+vUptksE1mxV411GRuM5ZHJCd3EXzr4Hr8icbUdEpho2Ph1dWGsi7wS1cgvAdpVJVvGPom4uGbLlMPqLDL4PONHPljQ/SF9LzFAFV9717tc2+ZAtlpThaofWGJVNnh9Xun+/SYq+OWOixkpLzRmu+EZSngVgzi9ExTHzsCYVAxCSDDv+B3wMc0CQHN7h2LEkGaDtfG7Adk+bh6huMwfzJmLFRHqKahhcvDCsXy4IYX

On Mon, 17 Nov 2025 23:25:56 -0800
Namhyung Kim <namhyung@kernel.org> wrote:

> > As for the perf event that is triggered. It currently is a dynamic array of
> > 64 bit values. Each value is broken up into 8 bits for what type of perf
> > event it is, and 56 bits for the counter. It only writes a per CPU raw
> > counter and does not do any math. That would be needed to be done by any
> > post processing.  
> 
> If you want to keep the perf events per CPU, you may consider CPU
> migrations for the func-graph case.  Otherwise userspace may not
> calculate the diff from the begining correctly.

That's easily solved by the user space too adding a sched_switch perf event
trigger. ;-)


> 
> Just FYI, I did the similar thing (like fgraph case) in uftrace and I
> grouped two related events to produce a metric.
> 
>   $ uftrace -T a@read=pmu-cycle ~/tmp/abc
>   # DURATION     TID      FUNCTION
>               [ 521741] | main() {
>               [ 521741] |   a() {
>               [ 521741] |     /* read:pmu-cycle (cycles=482 instructions=38) */
>               [ 521741] |     b() {
>               [ 521741] |       c() {
>      0.659 us [ 521741] |         getpid();
>      1.600 us [ 521741] |       } /* c */
>      1.780 us [ 521741] |     } /* b */
>               [ 521741] |     /* diff:pmu-cycle (cycles=+7361 instructions=+3955 IPC=0.54) */
>     24.485 us [ 521741] |   } /* a */
>     34.797 us [ 521741] | } /* main */
> 
> It reads cycles and instructions events (specified by 'pmu-cycle') at
> entry and exit of the given function ('a') and shows the diff with the
> metric IPC.

I originally tried to implement this, but then it became more complex than
I wanted in the kernel. As then I need to add a hook in the sched_switch
and record the perf event counter there, and keep track of it for every
task. That would require memory to be saved somewhere. I started adding it
to the function graph shadow stack and then just decided that it would be
so much easier to let user space figure it out.

By running function graph tracer and showing the start and end counters, as
well as the counters at the sched_switch trace event, user space could do
all the math and accounting, and the code in the kernel can remain simple.

-- Steve
