Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E13A1E485;
	Wed, 22 May 2024 12:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716381157; cv=none; b=IhxHF7BRbAG487BeqzAdqomTm4LPmsMxjnquJXYiHc7IzXcn0NZEpDhN3UZAb+toOxKjHJE8MlQimkXFCrcoNAEQBQyNuotBBbmROfhD83HhDcPx6Vrf5Rqca+MM+bKr8HaKTIYFzTaEhGQk4bM1tfb3wLj/ACl7+uuUtNWw0LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716381157; c=relaxed/simple;
	bh=T1TEdETKDky0Ul0jtRZKEW9X+I2E4h029Kzvzcm5KHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mm9KW4cfM+X7stWuDleRSLjhj7RwMm5uVt/VPsXtt5VrIGJWPQfW8Ll98nwj9A0zaVGyKl7hGjMpyi6AVZ27OABrq+PZPwHdkP/vwxFY8lEvhgVr6tPBO6ova9Nv+riCpFonzNP3hG6nBNWvueX4+Sj0ZjxXSgF882nMzCANkU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=P3MJu1Ok; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P3MJu1Ok"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qh0huu52jPPYWZ/xzSrqrdxD+6njjRFHzojMKnE5d8g=; b=P3MJu1OkUQPGCe/HSi+lJ630be
	j03rA5zbFr5Xub7i5IGmgPaTSUOi2VddgDnCqKE35dkS4UiNSgVpSupsdGeuE4ij30W3gp/YlDZ+p
	Q4sJSHOnxj2S6Q3vfMZO5HwqAqzjh6j6+0aUZgL86SlKTRLAY5MzbmmW1dqKuYVbr0WeMpdFLOXsM
	FDXD00/P3wYjZtlPuTr8a+W1QijTgui77xz8TKkztCSIycgOHpxtXy8/Sye2xU2lcAphNNyNPcMFP
	6qthMT2vgChPLBTm3fgcHW6hfJ2XU3GyPR77s465q9q/0hPUBkpQOQSyV77sWX4e77IfZq6s6es4K
	tTvjj62g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9l8g-00000000dr2-2Q6v;
	Wed, 22 May 2024 12:32:14 +0000
Date: Wed, 22 May 2024 13:32:14 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Sukrit Bhatnagar <Sukrit.Bhatnagar@sony.com>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>, Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: debug: print correct information for slab folios
Message-ID: <Zk3lzjVbXVrLW0XR@casper.infradead.org>
References: <20240522074629.2420423-1-Sukrit.Bhatnagar@sony.com>
 <20240522074629.2420423-3-Sukrit.Bhatnagar@sony.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522074629.2420423-3-Sukrit.Bhatnagar@sony.com>

On Wed, May 22, 2024 at 04:46:29PM +0900, Sukrit Bhatnagar wrote:
> The function dump_page() prints "anon" even for slab pages.
> This is not correct, especially now that struct slab is separated from
> struct page, and that the slab pages cannot be mapped to userspace.
> 
> [    7.071985] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x102768
> [    7.072602] head: order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> [    7.073085] anon flags: 0x8000000000000840(slab|head|zone=2)
> [    7.073777] raw: 8000000000000840 ffff8881000419c0 0000000000000000 dead000000000001
> 
> This debugging output may be misleading, and it is not easy to understand
> unless we read the source code.
> 
> If the folio tests true for slab, do not print information that does not
> apply to it. Instead, print the slab flags stored in the kmem_cache field.
> 
> [    7.248722] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888103e6aa87>
> [    7.249135] head: order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> [    7.249429] slab flags: 0x8000000000000840(slab|head|zone=2)
> [    7.249664] cache flags: 0x10310(HWCACHE_ALIGN|PANIC|TYPESAFE_BY_RCU|CMPXCHG_DOUBLE)
> [    7.249999] raw: 8000000000000000 ffffea00040f9a01 ffffea00040f9bc8 dead000000000400

You haven't tested this against the current codebase ...

> @@ -98,6 +101,8 @@ static void __dump_folio(struct folio *folio, struct page *page,
>  		is_migrate_cma_folio(folio, pfn) ? " CMA" : "");
>  	if (page_has_type(&folio->page))
>  		pr_warn("page_type: %pGt\n", &folio->page.page_type);
> +	else if (folio_test_slab(folio))
> +		pr_warn("cache flags: %pGs\n", &((struct slab *)&folio->page)->slab_cache->flags);
>  

... because page_has_type() is now true for slab; there is no more
PG_slab.  I think you also want:

	folio_slab(folio)->slab_cache->flags

Anyway, we have print_slab_info() which is currently static in slub.c.
Maybe that needs to become non-static and dump_page() should call that
for slabs?
