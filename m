Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496F3303C91;
	Fri, 22 Aug 2025 14:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871331; cv=none; b=f+dwPkEEWfPdZ3mcilqMWakJAwxaIW+JPyVH03dUCwXwGhe60WT1jfM+oGKxzqcMDpuCX9isUoGaYnGK1TvO8MkY92Es6i6PlIMMMeGXY/fmbufQLnPBnSlnXFIvwfr+jv1bdRH6DCP5NZ5pPmE61K4omqdQ9VeSxODz7TrH7sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871331; c=relaxed/simple;
	bh=yCUqiA+xuE4zJFCW6AYibhagiz3DrxXdNGy+kNXMUPg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YproFZRYfhIV3SD2BHXX2/nwcEkz3ptekETO+uctOhoYXqf0Z8r494H8ZBN4bAPukaeHUTFrd6Ev+/xMab1c+f9dV0nf0UPdGTXK0KHOnaRA7TwKS++PDyP6CuaCDwQEYYUHAjSsX8KpE++8B5cFJPQbJzmABm8fGEdDBkrzvS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id C0B1B1A01F6;
	Fri, 22 Aug 2025 14:02:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id F3D3217;
	Fri, 22 Aug 2025 14:02:02 +0000 (UTC)
Date: Fri, 22 Aug 2025 10:02:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Xiang Gao <gxxa03070307@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, andrii@kernel.org,
 mingo@kernel.org, oleg@redhat.com, akpm@linux-foundation.org,
 gmonaco@redhat.com, ricardo.neri-calderon@linux.intel.com,
 libo.chen@oracle.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, gaoxiang17 <gaoxiang17@xiaomi.com>
Subject: Re: [PATCH] tracing/sched: add 'next_policy' to trace_sched_switch
Message-ID: <20250822100209.7b1c5acf@gandalf.local.home>
In-Reply-To: <20250822105113.1102099-1-gxxa03070307@gmail.com>
References: <20250822105113.1102099-1-gxxa03070307@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: F3D3217
X-Stat-Signature: 41atar358yqmjx6zd7oua7j9mb39hsxr
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19VJPBxE2vdYNGR/y0sUnI29O6vjzLWUsc=
X-HE-Tag: 1755871322-58142
X-HE-Meta: U2FsdGVkX183YkdXJK5HgpTFAwU5Wxv2lzm30piEMHx2krBWHgl4JBk65DDU2TC/0jtNHJhRo5biKFZ3x5mXT1+rLSqt9nGGzJytF2JgXEVVmrr5nfMTSQzgHnuVDkusodMgj6dTb+rN8IP1uefG9GEE+jhHrut73gNAn3IfuIJf/NEH2ZTJTGKYzk0riuv0yWM5XoLuDyXzX6MrnRv4HQY7bWroESMoi2L8WrfXuR++CETih3d/lAyh5Znmg23ZNpPNEycj0gjLzVQDGmwI2PXgqJNMM1qrbY2IxGzZUB5qw6uULMIB6GAPRGljwvfJgmHzxAifN8JaOfY1x6A6yb4ykSEsJFTFOeF4xKwg8Ga+i80S5lSEm8QoNhVS2F1wEmC60YfPEzxpb0gA109ORlD8SiCiLn7M

On Fri, 22 Aug 2025 18:51:13 +0800
Xiang Gao <gxxa03070307@gmail.com> wrote:

> From: gaoxiang17 <gaoxiang17@xiaomi.com>
> 
> Sometimes, when analyzing some real-time process issues, it is necessary to know the sched policy.
> 
> Show up in the trace as:
> 
>       113.457176: sched_switch: prev_comm=kcompactd0 prev_pid=30 prev_prio=120 prev_state=S ==> next_comm=kworker/u4:1 next_pid=27 next_prio=120 next_policy=0
>       113.457282: sched_switch: prev_comm=kworker/u4:1 prev_pid=27 prev_prio=120 prev_state=I ==> next_comm=swapper/0 next_pid=0 next_prio=120 next_policy=0
>       113.461166: sched_switch: prev_comm=swapper/0 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=kworker/u4:1 next_pid=27 next_prio=120 next_policy=0
> 
> Signed-off-by: gaoxiang17 <gaoxiang17@xiaomi.com>
> ---
>  include/trace/events/sched.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index 7b2645b50e78..b416b7bafee4 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -234,6 +234,7 @@ TRACE_EVENT(sched_switch,
>  		__array(	char,	next_comm,	TASK_COMM_LEN	)
>  		__field(	pid_t,	next_pid			)
>  		__field(	int,	next_prio			)
> +		__field(	unsigned int,	next_policy	)
>  	),
>  
>  	TP_fast_assign(
> @@ -244,10 +245,11 @@ TRACE_EVENT(sched_switch,
>  		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
>  		__entry->next_pid	= next->pid;
>  		__entry->next_prio	= next->prio;
> +		__entry->next_policy	= next->policy;
>  		/* XXX SCHED_DEADLINE */
>  	),
>  
> -	TP_printk("prev_comm=%s prev_pid=%d prev_prio=%d prev_state=%s%s ==> next_comm=%s next_pid=%d next_prio=%d",
> +	TP_printk("prev_comm=%s prev_pid=%d prev_prio=%d prev_state=%s%s ==> next_comm=%s next_pid=%d next_prio=%d next_policy=%u",
>  		__entry->prev_comm, __entry->prev_pid, __entry->prev_prio,
>  
>  		(__entry->prev_state & (TASK_REPORT_MAX - 1)) ?
> @@ -263,7 +265,7 @@ TRACE_EVENT(sched_switch,
>  		  "R",
>  
>  		__entry->prev_state & TASK_REPORT_MAX ? "+" : "",
> -		__entry->next_comm, __entry->next_pid, __entry->next_prio)
> +		__entry->next_comm, __entry->next_pid, __entry->next_prio, __entry->next_policy)


I'm fine with this change, but I'm not sure how Peter feels about updating
scheduler tracepoints. That said, why not show the policy name?

	TP_printk("prev_comm=%s prev_pid=%d prev_prio=%d prev_state=%s%s ==> next_comm=%s next_pid=%d next_prio=%d next_policy=%s",
	[..]
		__entry->next_comm, __entry->next_pid, __entry->next_prio,
		__print_symbolic(__entry->next_policy,
			{ SCHED_NORMAL,		"normal" },
			{ SCHED_FIFO,		"FIFO" },
			{ SCHED_RR,		"RR" },
			{ SCHED_BATCH,		"batch" },
			{ SCHED_IDLE,		"idle" },
			{ SCHED_DEADLINE,	"deadline" },
			{ SCHED_EXT,		"sched_ext"}))

-- Steve






>  );
>  
>  /*

