Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A923374172
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Feb 2026 19:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772133305; cv=none; b=PcsJ1TKw4EJe8uGFynSPpgVOQm1iKr3PSjLqXZltivITrGK9AyXdav0d5kWEnvqqeOkriRCG9Cj9p2A4BkoUxRBEb9c3RkjcxZwk0QcKtHJHBhKpgSVlpYlWuyXy7vfk40/SRYdx/wD8m21MxunEde003PqZSkTef2fahpg39sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772133305; c=relaxed/simple;
	bh=6UAngo7K2rE7FmURHqBxLH9v0gOvexhHZ+2NHts3pHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bP6qlB3fBY/kcWMwTYRiwzwu+V9tovxtKBncvvApbYPnvawoCENuNkF8THZnwFx2XS4nXm4iPI4mInoTzopmSaa/j/tnBOMqo6YxkOkK8Yxwxjq+v6gEZvL9qam3GfNMrT4tO3Rkxjxo9u7HfmQfZfmbS31DbMAvBZlVLJAWG5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AK81tUuu; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AK81tUuu"
Date: Thu, 26 Feb 2026 11:14:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772133298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cMr0rukwTOqGMK00EByy2+nr9vOp+eXR1iEsiwlAxyo=;
	b=AK81tUuuH2+5kjOKOi6usmyIuPwftnYihxKK99Hz2av1fuLRhqn97eot6nkyeI3pkW/Gm+
	PjJZmkjdn/gii9Kzqs8ZA442M3QsfAyHLQHpAZzbhk5DkzEF1zXySQuJNMNuKkj5iDvc0F
	eguY8Pxb7Yt0Q8RKcnSNpgH9xXCnqmY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Brendan Jackman <jackmanb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Oscar Salvador <osalvador@suse.de>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, kernel-team@meta.com, 
	Benjamin Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v3 5/5] mm: add tracepoints for zone lock
Message-ID: <aaCbMwGNuUO1SbUb@linux.dev>
References: <cover.1772129168.git.d@ilvokhin.com>
 <378089dd269249d3d7981fe10eb8b49ad551d353.1772129168.git.d@ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <378089dd269249d3d7981fe10eb8b49ad551d353.1772129168.git.d@ilvokhin.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 26, 2026 at 06:26:22PM +0000, Dmitry Ilvokhin wrote:
> Add tracepoint instrumentation to zone lock acquire/release operations
> via the previously introduced wrappers.
> 
> The implementation follows the mmap_lock tracepoint pattern: a
> lightweight inline helper checks whether the tracepoint is enabled and
> calls into an out-of-line helper when tracing is active. When
> CONFIG_TRACING is disabled, helpers compile to empty inline stubs.
> 
> The fast path is unaffected when tracing is disabled.
> 
> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>

One nit below other than that:

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

[...]
> --- /dev/null
> +++ b/mm/zone_lock.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/zone_lock.h>
> +
> +#include <linux/zone_lock.h>
> +
> +EXPORT_TRACEPOINT_SYMBOL(zone_lock_start_locking);
> +EXPORT_TRACEPOINT_SYMBOL(zone_lock_acquire_returned);
> +EXPORT_TRACEPOINT_SYMBOL(zone_lock_released);
> +
> +#ifdef CONFIG_TRACING
> +
> +void __zone_lock_do_trace_start_locking(struct zone *zone)
> +{
> +	trace_zone_lock_start_locking(zone);
> +}
> +EXPORT_SYMBOL(__zone_lock_do_trace_start_locking);

No reason to not have these as EXPORT_SYMBOL_GPL (& below)

> +
> +void __zone_lock_do_trace_acquire_returned(struct zone *zone, bool success)
> +{
> +	trace_zone_lock_acquire_returned(zone, success);
> +}
> +EXPORT_SYMBOL(__zone_lock_do_trace_acquire_returned);
> +
> +void __zone_lock_do_trace_released(struct zone *zone)
> +{
> +	trace_zone_lock_released(zone);
> +}
> +EXPORT_SYMBOL(__zone_lock_do_trace_released);
> +
> +#endif /* CONFIG_TRACING */
> -- 
> 2.47.3
> 
