Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D39B2DC796;
	Fri, 12 Sep 2025 14:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757687404; cv=none; b=Hv0csuwA8JQQicHCsjffiDPYMz/WZLdj6gM95xADqRHm0XiFLqbpT1KcRTBS/JwEkXU4KzJmtQ+1WuUn/oL3c2r4s/PNlI6Bohs2SKPwbEQT5fcdLj3jDbozf3PnUVrnT9LhdrvUkGfzjzRN107nCn8h5CeFqZ7cDLk8huwSKLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757687404; c=relaxed/simple;
	bh=PzXy3J+sljkaF9/qM0Z9jTDMC2pKfDUjU75OFzOan50=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cOavYElzssKsLxd+tX6keL3bzDcyVToKvDEYXl+XT4801X4mH1QSa+Gb3e5HnLJ8Kxxa5SM4GYWM7U2z804Bq52G4lbtVgpCd8MHPQpRBB4zOaaV6U3Wc67wUyeMCYFS0S7a7WKAKz3RKtxQ2QMQNwxSzjP718Xg8LJlXJu5OTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 04AB014085C;
	Fri, 12 Sep 2025 14:29:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id C2E6520027;
	Fri, 12 Sep 2025 14:29:55 +0000 (UTC)
Date: Fri, 12 Sep 2025 10:30:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Xiang Gao <gxxa03070307@gmail.com>
Cc: mhiramat@kernel.org, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 mathieu.desnoyers@efficios.com, andrii@kernel.org, mingo@kernel.org,
 oleg@redhat.com, akpm@linux-foundation.org, gmonaco@redhat.com,
 ricardo.neri-calderon@linux.intel.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, gaoxiang17 <gaoxiang17@xiaomi.com>
Subject: Re: [PATCH v2 1/1] tracing/sched: add 'next_policy' to
 trace_sched_switch
Message-ID: <20250912103050.5bf82967@gandalf.local.home>
In-Reply-To: <c2894f9b0c5116eeffdc19947529aef5c5d1db4c.1756212396.git.gaoxiang17@xiaomi.com>
References: <cover.1756212396.git.gaoxiang17@xiaomi.com>
	<c2894f9b0c5116eeffdc19947529aef5c5d1db4c.1756212396.git.gaoxiang17@xiaomi.com>
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
X-Rspamd-Queue-Id: C2E6520027
X-Stat-Signature: 95jo8ccmhhjmhg39hwgka5nywg7ob9ps
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/HcNQwkKSYWfiQu92jxe3bnbMF4m9VtHY=
X-HE-Tag: 1757687395-783471
X-HE-Meta: U2FsdGVkX1/n5zk81QSwQrrD/DdxaLvSp913YGxMVAbDHQyrPaTXrYwCJTLkx89nalPdTY/TInEq8ueaLYxpCY2HLSbBCsk0FZZmHd8nNHEzip38/Fr7akMADa3WaqFX39Vz87OnVnjjTcJp9AB+wL8Zlq+VCKQEobghfZ7GSdoy4KSS0d6GqBV1p50mKYZPtOyKyGibv+XMJczW39GnX0JZlO4VxzUyW9cpn30w1Yvg0SsmyyF/aw7VBXQO0NMtuN+shWOVD/JyvUDP/qaMhRZOUAAeQmChnZWZ65/THR2BPvhx1vSR2yIe1ptmOHFf9MDaJCMfKvJ0Bs9MxHkFNKysPEE/1rVY/oP/zJ9xSmfKvFf+hyYQD1nOqEW1HdPTbEI6vKmbK9eXAUqkOyP67CwePYNWaQkO

On Tue, 26 Aug 2025 20:48:54 +0800
Xiang Gao <gxxa03070307@gmail.com> wrote:

> From: gaoxiang17 <gaoxiang17@xiaomi.com>
> 
> Sometimes, when analyzing some real-time process issues, it is necessary to know the sched policy.
> 
> Show up in the trace as:
> 
> 	 72.267374: sched_switch: prev_comm=grep prev_pid=67 prev_prio=19 prev_state=S ==> next_comm=cat next_pid=66 next_prio=120 next_policy=normal
> 	 72.267594: sched_switch: prev_comm=cat prev_pid=66 prev_prio=120 prev_state=R+ ==> next_comm=grep next_pid=67 next_prio=19 next_policy=RR
> 	562.192567: sched_switch: prev_comm=grep prev_pid=85 prev_prio=19 prev_state=S ==> next_comm=cat next_pid=84 next_prio=120 next_policy=normal
> 	562.192944: sched_switch: prev_comm=cat prev_pid=84 prev_prio=120 prev_state=R+ ==> next_comm=grep next_pid=85 next_prio=19 next_policy=FIFO
> 

Peter,

Are you OK with extending the sched switch tracepoint?

-- Steve

> Signed-off-by: gaoxiang17 <gaoxiang17@xiaomi.com>
> ---
>  include/trace/events/sched.h | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index 7b2645b50e78..00336211aca6 100644
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
> +	TP_printk("prev_comm=%s prev_pid=%d prev_prio=%d prev_state=%s%s ==> next_comm=%s next_pid=%d next_prio=%d next_policy=%s",
>  		__entry->prev_comm, __entry->prev_pid, __entry->prev_prio,
>  
>  		(__entry->prev_state & (TASK_REPORT_MAX - 1)) ?
> @@ -263,7 +265,16 @@ TRACE_EVENT(sched_switch,
>  		  "R",
>  
>  		__entry->prev_state & TASK_REPORT_MAX ? "+" : "",
> -		__entry->next_comm, __entry->next_pid, __entry->next_prio)
> +		__entry->next_comm, __entry->next_pid, __entry->next_prio,
> +		__print_symbolic(__entry->next_policy,
> +				{ SCHED_NORMAL,         "normal" },
> +				{ SCHED_FIFO,           "FIFO" },
> +				{ SCHED_RR,             "RR" },
> +				{ SCHED_BATCH,          "batch" },
> +				{ SCHED_IDLE,           "idle" },
> +				{ SCHED_DEADLINE,       "deadline" },
> +				{ SCHED_EXT,            "sched_ext"})
> +	)
>  );
>  
>  /*

