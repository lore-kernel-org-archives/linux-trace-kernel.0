Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE703B7A8;
	Mon, 15 Jul 2024 19:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721070256; cv=none; b=go3A7oF2htCwi7vQlr0cmZg+8QNawc8VffVxIsuMVVCH7b0hwKxzZCs4Co5wzP/91A/ymbz6ZqqsqdhWErEHqDpbgaZCP82UsL7sYCro8i/pSXn6Qin2ztw2/gZeP+SmwcZTXbL6QLM3EbKLiiwl9rOtraJpfQLF6KEPopeumEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721070256; c=relaxed/simple;
	bh=+hfoYk9Yhf0gdV5eTnMvfTUCngh1RvFK66MxRsp9J48=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NKGhCD8RI+ZQIHawqU7wYgTGqOHoSKFjvGjXxWGceWAfW4g5PgNrepklcram0Hmrg5Fdvuv6HlY7jAVgmF6pQ1DEkIqYJMbJPq+aJg1R2ItqxLSEtbRSyDglc9FShri114e43JpUOwrCVu01TWvgGnvw/RiA8FXg+DN4nfYUl5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4594C32782;
	Mon, 15 Jul 2024 19:04:13 +0000 (UTC)
Date: Mon, 15 Jul 2024 15:04:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tio Zhang <tiozhang@didiglobal.com>
Cc: <mhiramat@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <vineethr@linux.ibm.com>,
 <akpm@linux-foundation.org>, <mathieu.desnoyers@efficios.com>,
 <mingo@kernel.org>, <mgorman@techsingularity.net>, <peterz@infradead.org>,
 <qyousef@layalina.io>, <vincent.guittot@linaro.org>, <elver@google.com>,
 <zyhtheonly@gmail.com>, <zyhtheonly@yeah.net>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Juri Lelli
 <juri.lelli@gmail.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
 <vschneid@redhat.com>
Subject: Re: [PATCH 1/1] tracing/sched: sched_switch: place prev_comm and
 next_comm in right order
Message-ID: <20240715150412.655abdda@rorschach.local.home>
In-Reply-To: <20240703033353.GA2833@didi-ThinkCentre-M930t-N000>
References: <20240703033353.GA2833@didi-ThinkCentre-M930t-N000>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


[ Adding sched maintainers, as this is a scheduling trace event ]

On Wed, 3 Jul 2024 11:33:53 +0800
Tio Zhang <tiozhang@didiglobal.com> wrote:

> Switch the order of prev_comm and next_comm in sched_switch's code to
> align with its printing order.

I'm going to pick this up in my tree, as it is pretty much a nop. It's
just changing the ordering of the assignments of the comm names so that
the copy of prev_comm is with the updates to the prev_fields, and the
next_comm is with the updates to the next fields.

-- Steve


> 
> Signed-off-by: Tio Zhang <tiozhang@didiglobal.com>
> Reviewed-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> ---
>  include/trace/events/sched.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index dbb01b4b7451..a4bd4330db4c 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -239,11 +239,11 @@ TRACE_EVENT(sched_switch,
>  	),
>  
>  	TP_fast_assign(
> -		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
> +		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
>  		__entry->prev_pid	= prev->pid;
>  		__entry->prev_prio	= prev->prio;
>  		__entry->prev_state	= __trace_sched_switch_state(preempt, prev_state, prev);
> -		memcpy(__entry->prev_comm, prev->comm, TASK_COMM_LEN);
> +		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
>  		__entry->next_pid	= next->pid;
>  		__entry->next_prio	= next->prio;
>  		/* XXX SCHED_DEADLINE */

