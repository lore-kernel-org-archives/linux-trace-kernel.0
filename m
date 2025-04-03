Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79601E3DF4
	for <linux-trace-kernel@vger.kernel.org>; Thu,  3 Apr 2025 00:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743638457; cv=none; b=lS175K01KogVdXlmTVHiMhdBUzD+NrqOwaQXpRCOAEZ3w890fL/kqL0rTvjvTM4o0g5D40iM/PItbsBRNNcqnqM9rnU6rtabfc8FplePsV5Fmv6zKLbgO7iEONE1Wq9Xn1loXmNk8IL+DAShGwhGvKaAHSXJMgiSmGn9TTIxNb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743638457; c=relaxed/simple;
	bh=N+5czGiKNIfXpcO8ryGWeAvIF9qFsbtnJ/AWcAjAtfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k37HyVPIAGRKnv2guM0aeSgSlvaQr6ycOn4Cg3iEVIm2NjjxZY4sM+uCyihGbKbpIfVWz9ii7gYZyi5S3NoXyCJBncMSS8qnbq41qob+mkUm0lLRP1geuLbLZQLRAnr2JGjKxrOAp87HGVne39uzhOo1qg6cLSICQkIuBPMGFpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=an8qUAGu; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="an8qUAGu"
Date: Wed, 2 Apr 2025 17:00:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743638442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NBVywoZb0NEn0WwM4pPg/B+f3OtNhSDn+vmBeEDlF7c=;
	b=an8qUAGuyhMYlilculWrL5DNR/oDu+DDo0lVvJk2VlaXl0uFGifvakKKysQ5FnrJAy+pfv
	UK13v7/PRjNor8WI6v3guxShOFydlWRmvq3erqHaDgQUNmRSWzRXicp0N1m4oSepfeLdGr
	ohH+Nt2KE7OKUM0ih0pVYdvqTHDKgoo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Martin Liu <liumartin@google.com>, 
	David Rientjes <rientjes@google.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Sweet Tea Dorminy <sweettea@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, 
	David Hildenbrand <david@redhat.com>, Miaohe Lin <linmiaohe@huawei.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [RFC PATCH v2] mm: use per-numa-node atomics instead of
 percpu_counters
Message-ID: <2m3wwqpha2jlo4zjn6xbucahfufej75gbaxxgh4j4h67pgrw7b@diodkog7ygk3>
References: <20250331223516.7810-2-sweettea-kernel@dorminy.me>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331223516.7810-2-sweettea-kernel@dorminy.me>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 31, 2025 at 06:35:14PM -0400, Sweet Tea Dorminy wrote:
> [Resend as requested as RFC and minus prereq-patch-id junk]
> 
> Recently, several internal services had an RSS usage regression as part of a
> kernel upgrade. Previously, they were on a pre-6.2 kernel and were able to
> read RSS statistics in a backup watchdog process to monitor and decide if
> they'd overrun their memory budget.

Any reason these applications are not using memcg stats/usage instead of
RSS? RSS is not the only memory comsumption for these applications.

> Now, however, a representative service
> with five threads, expected to use about a hundred MB of memory, on a 250-cpu
> machine had memory usage tens of megabytes different from the expected amount
> -- this constituted a significant percentage of inaccuracy, causing the
> watchdog to act.

Are these 5 threads jump all over the 250 cpus?

> 
> This was a result of f1a7941243c1 ("mm: convert mm's rss stats into
> percpu_counter") [1].  Previously, the memory error was bounded by
> 64*nr_threads pages, a very livable megabyte. Now, however, as a result of
> scheduler decisions moving the threads around the CPUs, the memory error could
> be as large as a gigabyte.

Applications with 10s of thousands of threads is very normal at Google.
So, inaccuracy should be comparable for such applications.

> 
> This is a really tremendous inaccuracy for any few-threaded program on a
> large machine and impedes monitoring significantly. These stat counters are
> also used to make OOM killing decisions, so this additional inaccuracy could
> make a big difference in OOM situations -- either resulting in the wrong
> process being killed, or in less memory being returned from an OOM-kill than
> expected.
> 
> Finally, while the change to percpu_counter does significantly improve the
> accuracy over the previous per-thread error for many-threaded services, it does
> also have performance implications - up to 12% slower for short-lived processes
> and 9% increased system time in make test workloads [2].
> 
> A previous attempt to address this regression by Peng Zhang [3] used a hybrid
> approach with delayed allocation of percpu memory for rss_stats, showing
> promising improvements of 2-4% for process operations and 6.7% for page
> faults.
> 
> This RFC takes a different direction by replacing percpu_counters with a
> more efficient set of per-NUMA-node atomics. The approach:
> 
> - Uses one atomic per node up to a bound to reduce cross-node updates.
> - Keeps a similar batching mechanism, with a smaller batch size.
> - Eliminates the use of a spin lock during batch updates, bounding stat
>   update latency.
> - Reduces percpu memory usage and thus thread startup time.

That one atomic per node will easily become a bottleneck for
applications with a lot of threads particularly on the system where
there are a lot of cpus per numa node.

> 
> Most importantly, this bounds the total error to 32 times the number of NUMA
> nodes, significantly smaller than previous error bounds.
> 
> On a 112-core machine, lmbench showed comparable results before and after this
> patch.  However, on a 224 core machine, performance improvements were

How many cpus per node for each of these machines?

> significant over percpu_counter:
> - Pagefault latency improved by 8.91%

The following fork ones are understandable as percpu counter allocation
is involved but the above page fault latency needs some explanation.

> - Process fork latency improved by 6.27%
> - Process fork/execve latency improved by 6.06%
> - Process fork/exit latency improved by 6.58%
> 
> will-it-scale also showed significant improvements on these machines.

Are these process ones or the threads ones?

> 
> [1] https://lore.kernel.org/all/20221024052841.3291983-1-shakeelb@google.com/
> [2] https://lore.kernel.org/all/20230608111408.s2minsenlcjow7q3@quack3/
> [3] https://lore.kernel.org/all/20240418142008.2775308-1-zhangpeng362@huawei.com/
> 
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Mateusz Guzik <mjguzik@gmail.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 
> ---
> 
> This is mostly a resend of an earlier patch, where I made an utter hash
> of specifying a base commit (and forgot to update my commit text to not
> call it an RFC, and forgot to update my email to the one I use for
> upstream work...). This is based on akpm/mm-unstable as of today.
> 
> v1 can be found at
> https://lore.kernel.org/lkml/20250325221550.396212-1-sweettea-kernel@dorminy.me/
> 
> Some interesting ideas came out of that discussion: Mathieu Desnoyers
> has a design doc for a improved percpu counter, multi-level, with
> constant drift, at 
> https://lore.kernel.org/lkml/a89cb4d9-088e-4ed6-afde-f1b097de8db9@efficios.com/
> and would like performance comparisons against just reducing the batch
> size in the existing code;

You can do the experiments with different batch sizes in the existing
code without waiting for Mathieu's multi-level percpu counter.

> and Mateusz Guzik would also like a more general solution and is also
> working to fix the performance issues by caching mm state. Finally,
> Lorenzo Stoakes nacks, as it's too speculative and needs more
> discussion.
> 
> I think the important part is that this improves accuracy; the current
> scheme is difficult to use on many-cored machines. It improves
> performance, but there are tradeoffs; but it tightly bounds the
> inaccuracy so that decisions can actually be reasonably made with the
> resulting numbers.
> 
> This patch assumes that intra-NUMA node atomic updates are very cheap

The above statement/assumption needs experimental data.

> and that
> assigning CPUs to an atomic counter by numa_node_id() % 16 is suitably
> balanced. However, if each atomic were shared by only, say, eight CPUs from the
> same NUMA node, this would further reduce atomic contention at the cost of more
> memory and more complicated assignment of CPU to atomic index. I don't think
> that additional complication is worth it given that this scheme seems to get
> good performance, but it might be. I do need to actually test the impact
> on a many-cores-one-NUMA-node machine, and I look forward to testing out
> Mathieu's heirarchical percpu counter with bounded error.
> 

I am still not buying the 'good performance' point. To me we might need
to go with reduced batch size of existing approach or multi level
approach from Mathieu (I still have to see Mateusz and Kairui's
proposals).
