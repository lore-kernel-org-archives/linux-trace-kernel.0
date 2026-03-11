Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7168F2F4A14;
	Wed, 11 Mar 2026 19:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773258802; cv=none; b=U1PyVG195F2Y7WxdTsh/FmgY/QHGYh8/aCUGnXyPZXVPDHRMffuCarFarYG8wkEQb3Rx5pESpRu7PFkM6hDRFd2JWJYxWnbZc7RyGT+rAfxxISs2ciY30oMSuc7XIoFhyYI4Kwm0QhJrcvBl2OK31F3iTwGnLoWzx2KDhE/v5zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773258802; c=relaxed/simple;
	bh=6CbWuAN3kpMm5yGrTrZUbidcKutcINvPkgFehbZL2uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGqmKb1gOXHqUtOGRNswrpTRJv9LsaXR/5MhDBK56KX6H3xoC17GcD05XG7TcngmJ2a6XCweazVIUOpemgMcBFanCG1ps8cTaXzNFtGjQRzO7xnUpjKWIOuheg4tbKW8oDvQD92Z9hAI/pwjU6cx7k1vhxUTEnA5WY7G2Mk6UT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=e8piXqft; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e8piXqft"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5Qn9ydgwgXA1uZDJYGnfOUVSibEcv8Yq8hit26e8VpU=; b=e8piXqftubz0OPvxGnMddUF2Bg
	DJxL7T1Ty63Kiu0uCGDcx5fSJKrVPTOAaY2LANxHXmoba7BBewCGIKNuFBK2gEiX8xYhpItvYJqfC
	ztT+pElVqduMT15fUyz5DxdmnND3ickQlD7VhCv0jy+5Sba/S0r9TrqYVy0VaCzVUJcqSes1A7bea
	ch/28k+mDyqvrCKikbLUH0hqezoaX5EdeKJP10FLy936mrbyEdQFVRh+oqchMErCntICAnv4omfXi
	R0Y1CGjQNGyXkSTxu0yUuW6l44rvmlcTZheELb2I1a8tmGp1sJFrizjPEYZ9lpPP7FzAR3Bm2CcGP
	DPPRys9A==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0PcG-000000002JI-0wrp;
	Wed, 11 Mar 2026 19:53:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E456C303165; Wed, 11 Mar 2026 20:53:10 +0100 (CET)
Date: Wed, 11 Mar 2026 20:53:10 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Wander Lairson Costa <wander@redhat.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:TRACING" <linux-trace-kernel@vger.kernel.org>,
	acme@kernel.org, williams@redhat.com, gmonaco@redhat.com,
	Vineeth Pillai <vineethrp@google.com>
Subject: Re: [PATCH v3 4/4] trace/preemptirq: Implement trace_irqflags hooks
Message-ID: <20260311195310.GU606826@noisy.programming.kicks-ass.net>
References: <20260311125021.197638-1-wander@redhat.com>
 <20260311125021.197638-5-wander@redhat.com>
 <20260311194305.GT606826@noisy.programming.kicks-ass.net>
 <20260311154842.0823790f@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311154842.0823790f@gandalf.local.home>

On Wed, Mar 11, 2026 at 03:48:42PM -0400, Steven Rostedt wrote:
> On Wed, 11 Mar 2026 20:43:05 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Wed, Mar 11, 2026 at 09:50:18AM -0300, Wander Lairson Costa wrote:
> > > +#define local_irq_enable()				\
> > > +	do {						\
> > > +		if (tracepoint_enabled(irq_enable))	\
> > > +			trace_local_irq_enable();	\  
> > 
> > I'm thinking you didn't even look at the assembly generated :/
> > 
> > Otherwise you would have written this like:
> > 
> > 		if (tracepoint_enabled(irq_enable))
> > 			__do_trace_local_irq_enable();
> 
> Please don't use the internal functions outside of the tracepoint.h
> 
> Vineeth is currently working on a patch set to properly do that. It's going
> to introduce:
> 
>   trace_invoke_<event>()
> 
> Which basically is just __do_trace_<event>(), but as a wrapper that can
> handle updates that may be needed, but supplies a proper API where thing
> wont randomly break when __do_trace_<event>() changes.

That's like a 3 line patch, hardly worth the effort. Its not like it'll
be hard to find and fix any users if you do ever change that.
