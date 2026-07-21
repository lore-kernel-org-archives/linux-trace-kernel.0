Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23B744AB99;
	Tue, 21 Jul 2026 21:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784668648; cv=none; b=fAg0nQ94+z3B007aR9bceN3qC+Va0bZK+OhrMGkfyjaAPOj/MlZ+Jh6fN0gKmUmI0l5lRA3XaDEEAZMCj/sN30eS47+7uKApqbNBQiCiW/Ifxa/bCuRM49dQnKmk2jawEzcyO3iSmvQevy6tfQF0p0w1BAWxx2nPZ3/gpOATIGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784668648; c=relaxed/simple;
	bh=h30UGIZK08XsmJvolZCHLVOqPJztOVef21mXHYnzCEg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PXTvZqR4RJUZa0e2HwzAkxa7K9nFXwVQ/JM842WJggMq4dtxDXfoVutbgiVRDlEk4BSeiOJUIydHXgYlgX9i713h7fWZ4Am/6Tk+dT5Yo4tiQqjuWWT5zWIV1KVYf6hI2bTHI+PHYUgsdopPLcUjYO8nHvYRHAuX8W9Gw49avKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 204EA1C03FB;
	Tue, 21 Jul 2026 21:17:13 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id DF8AF35;
	Tue, 21 Jul 2026 21:17:05 +0000 (UTC)
Date: Tue, 21 Jul 2026 17:17:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Aditya Sharma <adi.sharma@zohomail.in>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
 <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, David Rientjes <rientjes@google.com>, Shakeel Butt
 <shakeel.butt@linux.dev>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Kees Cook
 <kees@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin
 Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 imbrenda@linux.ibm.com
Subject: Re: [RFC PATCH 6/7] mm: add tracepoints and vmstat counters for
 async teardown
Message-ID: <20260721171724.56f1aad5@gandalf.local.home>
In-Reply-To: <20260719185409.409685-7-adi.sharma@zohomail.in>
References: <20260719185409.409685-1-adi.sharma@zohomail.in>
	<20260719185409.409685-7-adi.sharma@zohomail.in>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DF8AF35
X-Stat-Signature: pq97feacsw775doex8t9efs7h5zba3oi
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+/ste/MyujSSeKSM6VrsZlDhaJTmhqqpE=
X-HE-Tag: 1784668625-226901
X-HE-Meta: U2FsdGVkX1+37sIM9lG4/zgdYQ9Eq4DMj9ICc9L+iKjZogAd1/mA/GA6amAuJMJbN3PsQ0qohHAMZGj7vbCevm3bBwwvOmY6AED/Ow+q6CVegC+1eRe/+akgpMaHk8PjPnmNUoI4uuFKKl0KtKxmQjpsEY2ZI6It5d4pD4hjUp32ge0UDoqIeflNRvXHurGfgaR7L3E2gvANNnVQHz9S7/W2oVTnBzRtJ9VSIWGY1MNdPtUYoVNOAdFVxrRfp1tBRzlUFFpGImYwryMsrmMRQ17caaZHPwu2aKixNJIhwzWZe+NLXb/GcPA6ab5mtk+t

On Mon, 20 Jul 2026 00:24:08 +0530
Aditya Sharma <adi.sharma@zohomail.in> wrote:

> diff --git a/include/trace/events/mm_reaper.h b/include/trace/events/mm_reaper.h
> new file mode 100644
> index 000000000..315bced7c
> --- /dev/null
> +++ b/include/trace/events/mm_reaper.h
> @@ -0,0 +1,73 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM mm_reaper
> +
> +#if !defined(_TRACE_MM_REAPER_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_MM_REAPER_H
> +
> +#include <linux/tracepoint.h>
> +#include <linux/sched.h>
> +#include <linux/topology.h>
> +
> +TRACE_EVENT(mm_async_teardown_queue,
> +
> +	TP_PROTO(struct mm_struct *mm, unsigned long rss),
> +
> +	TP_ARGS(mm, rss),
> +
> +	TP_STRUCT__entry(
> +		__field(struct mm_struct *, mm)
> +		__field(int, pid)
> +		__array(char, comm, TASK_COMM_LEN)

There's an effort to make comm size more dynamic and we want to prevent more
memcpy of the comm based on TASK_COMM_LEN. Please change the above to:

		__string(comm, comm);


> +		__field(unsigned long, rss)
> +		__field(int, node)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->mm = mm;
> +		__entry->pid = current->pid;
> +		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);

And this to:

		__assign_str(comm);

> +		__entry->rss = rss;
> +		__entry->node = numa_node_id();
> +	),
> +
> +	TP_printk("mm=%p pid=%d comm=%s rss=%lukB node=%d",
> +		__entry->mm,
> +		__entry->pid,
> +		__entry->comm,

and this to:

		__get_str(comm),

Thanks,

-- Steve

> +		__entry->rss << (PAGE_SHIFT - 10),
> +		__entry->node
> +	)
> +);
> +
