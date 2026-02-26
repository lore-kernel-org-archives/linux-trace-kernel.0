Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65709229B18;
	Thu, 26 Feb 2026 21:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772141103; cv=none; b=TZgONTmHi4G1ra5/aDvVk+6wb/IT1Mnl1CZLL1hIYSc0IQ1V2z1EnB9ev2D6PYqQRxqIOdTWmz0lEBZ2uMSAG+yyJIM+rQSvEB3zBoOiYzMD+nXKNlfgM/k80r9U7g4FV5QGUI1GIRmR94BM18X5jh7dnbhRNFFBd7T+l96wA8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772141103; c=relaxed/simple;
	bh=TK9rkBAvvg4o3PRRG7ZVkuu7ATGJbZIF4YPRlRFQSLg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JaQ1Vx9HXgEJGUEkxlXadTt4eL5mI+6socOOBWX0YHrlxkpmtGJIGKfoSHXV4whVMS51j9YbEdpHB6J6YSegaZqz3sNtAeyf834v6hWVwqUDt8XTiXUF2gzzjTKuy8UHKLydEuhV6wsiPOXGeIqkqRLupdXnf8bAy8AMUNWF7Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=D2fLiuvl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D2fLiuvl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3127AC116C6;
	Thu, 26 Feb 2026 21:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1772141103;
	bh=TK9rkBAvvg4o3PRRG7ZVkuu7ATGJbZIF4YPRlRFQSLg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D2fLiuvldUwv1h2AWaUU5JWohz8ay95owgAQ1nxknK2oEr+xUU8haTPAO9WpznJ9e
	 RgN+BkHG3DWGZ5fk3gP1TCe2HHAxUs0B07WZJgYiYwwZroxbm+jYyTL7T+Ko16pORa
	 kQcLJNqTUzStzftpWjY9k694tncouhnOliWYcKkE=
Date: Thu, 26 Feb 2026 13:25:01 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Dmitry Ilvokhin <d@ilvokhin.com>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie
 <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Brendan Jackman
 <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan
 <ziy@nvidia.com>, Oscar Salvador <osalvador@suse.de>, Qi Zheng
 <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, kernel-team@meta.com, Benjamin Cheatham
 <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v3 5/5] mm: add tracepoints for zone lock
Message-Id: <20260226132501.5b70914daf9438a1103189ee@linux-foundation.org>
In-Reply-To: <aaCbMwGNuUO1SbUb@linux.dev>
References: <cover.1772129168.git.d@ilvokhin.com>
	<378089dd269249d3d7981fe10eb8b49ad551d353.1772129168.git.d@ilvokhin.com>
	<aaCbMwGNuUO1SbUb@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Feb 2026 11:14:52 -0800 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> On Thu, Feb 26, 2026 at 06:26:22PM +0000, Dmitry Ilvokhin wrote:
> > Add tracepoint instrumentation to zone lock acquire/release operations
> > via the previously introduced wrappers.
> > 
> > The implementation follows the mmap_lock tracepoint pattern: a
> > lightweight inline helper checks whether the tracepoint is enabled and
> > calls into an out-of-line helper when tracing is active. When
> > CONFIG_TRACING is disabled, helpers compile to empty inline stubs.
> > 
> > The fast path is unaffected when tracing is disabled.
> > 
> > Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> 
> ...
>
> > +void __zone_lock_do_trace_start_locking(struct zone *zone)
> > +{
> > +	trace_zone_lock_start_locking(zone);
> > +}
> > +EXPORT_SYMBOL(__zone_lock_do_trace_start_locking);
> 
> No reason to not have these as EXPORT_SYMBOL_GPL (& below)

Do we need the exports at all?

include/linux/mmzone.h
include/linux/zone_lock.h
include/trace/events/zone_lock.h
MAINTAINERS
mm/compaction.c
mm/internal.h
mm/Makefile
mm/memory_hotplug.c
mm/mm_init.c
mm/page_alloc.c
mm/page_isolation.c
mm/page_owner.c
mm/page_reporting.c
mm/show_mem.c
mm/vmscan.c
mm/vmstat.c
mm/zone_lock.c

