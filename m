Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BB0332604;
	Wed, 27 May 2026 14:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779891902; cv=none; b=GmwGNW34gNP/sF5df3mWTUwpjd24I7V1nn/bPbnewXl7qG8eVJzfwK9rtArmoAH2z5xlyia5+QWo44wGgUwJyZ2OWB96BuKQDhsuHAtzrr59dOXrmDjxOHsZXOMWeMfH88yyPcSN1/8pWrTiXw5XzVrmVULgreZK7eX0gCIpJ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779891902; c=relaxed/simple;
	bh=1idnnR1Bk/1Dfx1qbp4J/yzpYSHtzwFkWLxvLiWWy+M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YELNrmYENnwLdOsym/JvMBLcQCKzzAozh5YbrC0SpWyQKVhBaS3BIBDZSvLEox0teqJ3T6zi8peLqNpwbK0ObZVNjOfxtLLlv+3ykOK+cciJrUpL4jGJx0RWsxC9Bqlp3UL+qvh0H4Tp5vnMbiD7QxDdwPW+4MHoCDwXeh7vW58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 0D8861C04BB;
	Wed, 27 May 2026 14:15:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 2A6D633;
	Wed, 27 May 2026 14:15:51 +0000 (UTC)
Date: Wed, 27 May 2026 10:16:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>, Takaya Saeki <takayas@google.com>,
 Douglas Raillard <douglas.raillard@arm.com>, Tom Zanussi
 <zanussi@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas
 Gleixner <tglx@linutronix.de>, Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v6] tracing/eprobes: Allow use of BTF names to
 dereference pointers
Message-ID: <20260527101625.4c02a31e@gandalf.local.home>
In-Reply-To: <20260527100815.53e55c57@gandalf.local.home>
References: <20260521225033.56458336@fedora>
	<ahayVg7TvNrf1ama@krava>
	<20260527100815.53e55c57@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: p9ugdbrhxepzsrmy114djf7xtri9w37m
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 2A6D633
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19QYd7Hw1fpdyboERekW054u18ySx22ikQ=
X-HE-Tag: 1779891351-94475
X-HE-Meta: U2FsdGVkX18eSSZLDH9iz11ns+BdqD3/lqu8/EqPuhyOZLJadrIe7TsmmttHCTibKshUWjJZ4wdEXxWtLh/zgPlQXAGaJGzb6Ghan0H3l0v9Xt+9vp4tRrqYJYMwBoYZeP/CJtx+Nlgjrb0psU9dkw0Ktn54VuXLDfIAxfaAZX9gX5y+0PfIzVQOm8U2PIfnLoEPWK7rNuCAWM+9/64mBBgAp3qXIFAPMGJuavTeN4r46vAeoyT39F0Ma6EtgclIz06MMWRut4LIHrgynfQN4SEZoU3WvxRGtEswvprIUS4CVRow5o1QY2f+oL07XZ9276s/EdGlWRMsibnomBJz7a9fZbE5g8w3UJs0J2aDJcJesUTmulr3fw==

On Wed, 27 May 2026 10:08:15 -0400
Steven Rostedt <rostedt@kernel.org> wrote:

> > this seems to be supported only for argument (pointer) stored in the trace record,
> > not the actual arguments to the tracepoint, is that right?
> > 
> > so I can deref worker from sched.sched_kthread_work_queue_work, like:
> > 
> >   echo 'e:myprobe sched.sched_kthread_work_queue_work (kthread_worker)worker->flags (kthread_work)work->canceling' > dynamic_events  
> 
> Correct, that is because eprobes "e:" works on the output of a trace event.
> 
> 
> > 
> > but I can't deref sched.sched_process_exec p->pid, like:
> > 
> >   # echo 'e:myprobe sched.sched_process_exec (task_struct)p->pid' > dynamic_events
> >   bash: echo: write error: Invalid argument  
> 
> For function prototypes of a tracepoint, you would use a tprobe "t:"
> 
>  # echo 't:exec sched_process_exec pid=p->pid' > dynamic_events


Hmm, this is why I need to write a book ;-)

Thanks for helping with what content I need to add!

-- Steve
