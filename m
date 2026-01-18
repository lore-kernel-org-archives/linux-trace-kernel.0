Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285F81A3179
	for <linux-trace-kernel@vger.kernel.org>; Sun, 18 Jan 2026 05:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768712695; cv=none; b=NRQlaBrwjmEjBvVOq5GZLOwSN4aZN6t/pqkrhknIIPHTAV4rpygYXq6tNMoZHgPUHk/AwxqUnPq6IKpcQAPtYSs3UiPJ0S3eBtL2xfsK2YPcjFJzfq6gInOXVMe4qk7REcY+xnKroLL/qkTa1uoT0yJhM/oDNVYha8UBQkyJ/dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768712695; c=relaxed/simple;
	bh=+KRQ/TJSIlVh5UaRDHBTc54iX+JLIziyN4LGyeJm8gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIShSoa0mZJV5UziS+OJpt1MGOAMYSaILLJEzJd4dhp3mk6qWPSiGd7rVtLxBYDDc/SwZltQx8RkIDReawKfxG/8KDUegjhi9Jvx1zSGC+SPMvJmLeGEIUsLHnNZLWCzIRqfDk27VhRiFp9UMlidAwE7PvdcBtez1VCmhaEf6d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YjB8ndGY; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YjB8ndGY"
Date: Sat, 17 Jan 2026 21:04:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768712690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2ilj6/dtjZjTchAVyTXVluY1eXFhY21oaAp6+lqrc9g=;
	b=YjB8ndGYK5rdvz8Mvf8c4GHNQMj5zqOZHoWFeP84IUyTs7MKnhS3pxBoha7BuYTFrltE7g
	tPKkzRj/cW8fYHyoHVMukDaYs8pYXwCMQQW+5lUNcksI+5XagrKUJNGqZPPsVW3TOg198H
	VfgI5Qvj6xX5iD83saMZHDzjNEdKrs4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: linux-mm@kvack.org, Jiayuan Chen <jiayuan.chen@shopee.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Brendan Jackman <jackmanb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm/vmscan: mitigate spurious kswapd_failures
 reset from direct reclaim
Message-ID: <55m7lphwqp3nywapjutkdzajehvhhulig5v4zsu2lafsxqmwkf@qmwqjgk6z3ke>
References: <20260114074049.229935-1-jiayuan.chen@linux.dev>
 <20260114074049.229935-2-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114074049.229935-2-jiayuan.chen@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Wed, Jan 14, 2026 at 03:40:35PM +0800, Jiayuan Chen wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> When kswapd fails to reclaim memory, kswapd_failures is incremented.
> Once it reaches MAX_RECLAIM_RETRIES, kswapd stops running to avoid
> futile reclaim attempts. However, any successful direct reclaim
> unconditionally resets kswapd_failures to 0, which can cause problems.
> 
> We observed an issue in production on a multi-NUMA system where a
> process allocated large amounts of anonymous pages on a single NUMA
> node, causing its watermark to drop below high and evicting most file
> pages:
> 
> $ numastat -m
> Per-node system memory usage (in MBs):
>                           Node 0          Node 1           Total
>                  --------------- --------------- ---------------
> MemTotal               128222.19       127983.91       256206.11
> MemFree                  1414.48         1432.80         2847.29
> MemUsed                126807.71       126551.11       252358.82
> SwapCached                  0.00            0.00            0.00
> Active                  29017.91        25554.57        54572.48
> Inactive                92749.06        95377.00       188126.06
> Active(anon)            28998.96        23356.47        52355.43
> Inactive(anon)          92685.27        87466.11       180151.39
> Active(file)               18.95         2198.10         2217.05
> Inactive(file)             63.79         7910.89         7974.68
> 
> With swap disabled, only file pages can be reclaimed. When kswapd is
> woken (e.g., via wake_all_kswapds()), it runs continuously but cannot
> raise free memory above the high watermark since reclaimable file pages
> are insufficient. Normally, kswapd would eventually stop after
> kswapd_failures reaches MAX_RECLAIM_RETRIES.
> 
> However, containers on this machine have memory.high set in their
> cgroup. Business processes continuously trigger the high limit, causing
> frequent direct reclaim that keeps resetting kswapd_failures to 0. This
> prevents kswapd from ever stopping.
> 
> The key insight is that direct reclaim triggered by cgroup memory.high
> performs aggressive scanning to throttle the allocating process. With
> sufficiently aggressive scanning, even hot pages will eventually be
> reclaimed, making direct reclaim "successful" at freeing some memory.
> However, this success does not mean the node has reached a balanced
> state - the freed memory may still be insufficient to bring free pages
> above the high watermark. Unconditionally resetting kswapd_failures in
> this case keeps kswapd alive indefinitely.
> 
> The result is that kswapd runs endlessly. Unlike direct reclaim which
> only reclaims from the allocating cgroup, kswapd scans the entire node's
> memory. This causes hot file pages from all workloads on the node to be
> evicted, not just those from the cgroup triggering memory.high. These
> pages constantly refault, generating sustained heavy IO READ pressure
> across the entire system.
> 
> Fix this by only resetting kswapd_failures when the node is actually
> balanced. This allows both kswapd and direct reclaim to clear
> kswapd_failures upon successful reclaim, but only when the reclaim
> actually resolves the memory pressure (i.e., the node becomes balanced).
> 
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

After incorporating suggestions from Johannes, you can add:

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

