Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D7F2EDD51;
	Fri, 22 Aug 2025 14:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871483; cv=none; b=ZltuBxqTd3mTpZIEJHcvmM7SahKl08hbYsHky5g8wKsuxW5GTSQb6PQmA21qEcQxtu7SjW2sRYLEKEFFZtd2pqjymZNGrhhX+B4ngA/qwsfAohu1LpZkwroXf80KsU8NG0ah1atULsCOuquUkYk53bQr2pn02AoSACl/WDbGex0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871483; c=relaxed/simple;
	bh=Xbkb7aPZQmlevLNqWJsrOMl50Zv01PZBojl6c0eh+RU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XwVtAICQoohvA3MbLKvnheYEfJKcbuw/rdRf1TuyQl86uBPeGmWRpzvaZoow5+8J7ERNVGHq07A1Jr94V08aVmVi+hdqZuk6SnSewD6FoKoU48YpM4U5ebjv5vCPkVgxGqcUq1aKntdLrrLBsHqQBPD0r4KDPLUYKSyUauSDWQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 8417B82AC0;
	Fri, 22 Aug 2025 14:04:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id D53261D;
	Fri, 22 Aug 2025 14:04:35 +0000 (UTC)
Date: Fri, 22 Aug 2025 10:04:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Xiang Gao <gxxa03070307@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, andrii@kernel.org,
 mingo@kernel.org, oleg@redhat.com, akpm@linux-foundation.org,
 gmonaco@redhat.com, ricardo.neri-calderon@linux.intel.com,
 libo.chen@oracle.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, gaoxiang17 <gaoxiang17@xiaomi.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] tracing/sched: add 'next_policy' to trace_sched_switch
Message-ID: <20250822100442.79691ab2@gandalf.local.home>
In-Reply-To: <20250822100209.7b1c5acf@gandalf.local.home>
References: <20250822105113.1102099-1-gxxa03070307@gmail.com>
	<20250822100209.7b1c5acf@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: D53261D
X-Stat-Signature: ij14jijodrczfxirtf443x44yo74jfwt
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18GKu2VDGi8bRXrue672Ec2iTLLeZfIeJQ=
X-HE-Tag: 1755871475-287915
X-HE-Meta: U2FsdGVkX1/DXovB48xGmUKZoUhgh6TpW2UkSAhOxmNgdsRp8g/NoGSsiJw5TEW7PJOieMYXyk70CVcwA/f45aohbyF6ZOmGe4r9UxJmW9d0MkJjdQCvGMDpZJ7nr6+oIlJdeifZMYLEwZTQmXNp7Pl32JvXoCXClvekVx2HujvOQR4SEMXkdhlN0diHAyQwztPZ0I/3FEhXKe06f8epihII1IqOnjjKfsXLiznkZ86Z9eobEBLjRiUMGVTyBN4wSXWF1LiwJxseaeYxz/PGxDGYtMpjKXgfF130FQDJqOJHkbEE2kptL0py9lMhlEyy3BILp/6DdWfFWyCTc7moMmGQx93jHsK4lY9cBLCuAch4ux2wnnOCict4pobwqL6ANFRTyALw6aKRKXWqYscnixZgZ+blUAdD4+8ePJtK+PItqNvV08tGPZR2WwaICKLcItV7SVrO0a8o4/Kjx+jVz7EePI+3s5Ch


[ Adding scheduler maintainers ]

On Fri, 22 Aug 2025 10:02:09 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 22 Aug 2025 18:51:13 +0800
> Xiang Gao <gxxa03070307@gmail.com> wrote:
> 
> > From: gaoxiang17 <gaoxiang17@xiaomi.com>
> > 
> > Sometimes, when analyzing some real-time process issues, it is necessary to know the sched policy.
> > 
> > Show up in the trace as:
> > 
> >       113.457176: sched_switch: prev_comm=kcompactd0 prev_pid=30 prev_prio=120 prev_state=S ==> next_comm=kworker/u4:1 next_pid=27 next_prio=120 next_policy=0
> >       113.457282: sched_switch: prev_comm=kworker/u4:1 prev_pid=27 prev_prio=120 prev_state=I ==> next_comm=swapper/0 next_pid=0 next_prio=120 next_policy=0
> >       113.461166: sched_switch: prev_comm=swapper/0 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=kworker/u4:1 next_pid=27 next_prio=120 next_policy=0
> > 
> > Signed-off-by: gaoxiang17 <gaoxiang17@xiaomi.com>
> > ---
> >  include/trace/events/sched.h | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> > index 7b2645b50e78..b416b7bafee4 100644
> > --- a/include/trace/events/sched.h
> > +++ b/include/trace/events/sched.h
> > @@ -234,6 +234,7 @@ TRACE_EVENT(sched_switch,
> >  		__array(	char,	next_comm,	TASK_COMM_LEN	)
> >  		__field(	pid_t,	next_pid			)
> >  		__field(	int,	next_prio			)
> > +		__field(	unsigned int,	next_policy	)
> >  	),
> >  
> >  	TP_fast_assign(
> > @@ -244,10 +245,11 @@ TRACE_EVENT(sched_switch,
> >  		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
> >  		__entry->next_pid	= next->pid;
> >  		__entry->next_prio	= next->prio;
> > +		__entry->next_policy	= next->policy;
> >  		/* XXX SCHED_DEADLINE */
> >  	),
> >  
> > -	TP_printk("prev_comm=%s prev_pid=%d prev_prio=%d prev_state=%s%s ==> next_comm=%s next_pid=%d next_prio=%d",
> > +	TP_printk("prev_comm=%s prev_pid=%d prev_prio=%d prev_state=%s%s ==> next_comm=%s next_pid=%d next_prio=%d next_policy=%u",
> >  		__entry->prev_comm, __entry->prev_pid, __entry->prev_prio,
> >  
> >  		(__entry->prev_state & (TASK_REPORT_MAX - 1)) ?
> > @@ -263,7 +265,7 @@ TRACE_EVENT(sched_switch,
> >  		  "R",
> >  
> >  		__entry->prev_state & TASK_REPORT_MAX ? "+" : "",
> > -		__entry->next_comm, __entry->next_pid, __entry->next_prio)
> > +		__entry->next_comm, __entry->next_pid, __entry->next_prio, __entry->next_policy)
> 
> 
> I'm fine with this change, but I'm not sure how Peter feels about updating
> scheduler tracepoints. That said, why not show the policy name?

Oh, and trace events are owned by the subsystem maintainers not the tracing
maintainers. You need to Cc them.

-- Steve


> 
> 	TP_printk("prev_comm=%s prev_pid=%d prev_prio=%d prev_state=%s%s ==> next_comm=%s next_pid=%d next_prio=%d next_policy=%s",
> 	[..]
> 		__entry->next_comm, __entry->next_pid, __entry->next_prio,
> 		__print_symbolic(__entry->next_policy,
> 			{ SCHED_NORMAL,		"normal" },
> 			{ SCHED_FIFO,		"FIFO" },
> 			{ SCHED_RR,		"RR" },
> 			{ SCHED_BATCH,		"batch" },
> 			{ SCHED_IDLE,		"idle" },
> 			{ SCHED_DEADLINE,	"deadline" },
> 			{ SCHED_EXT,		"sched_ext"}))
> 
> -- Steve
> 
> 
> 
> 
> 
> 
> >  );
> >  
> >  /*
> 

