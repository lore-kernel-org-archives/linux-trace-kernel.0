Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991DE17B505;
	Tue, 28 Apr 2026 18:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777400614; cv=none; b=nB0N+iEyzR32yE5zpvDOe+htVGrl/mOXpaKhlEuQ3ICDYGFMM+0jrZi24Z/H0HWZ0mFj4eiKQ+AfAEwsU4Bk8g6qH9FBI9bAZn60xxu9B1BHuFrx7dwlUUU6ZX9n5VSSzlerwRoA72dlL0d5k2HfYx9iKWz8w0ZUnIm6XjUIqKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777400614; c=relaxed/simple;
	bh=w5NRPvOzrfOcdegk8n0OeOI6W/Dm/3D4ge28Mpaj5II=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r+9m+D3JdWsA1CLnLu+59iOfq076FhA10d4TbFpguPzhCrvNS0VGOnGQxfhhMOzyv4JvEC9Xq9/GjpjijqRxkXbHvScdCo/Zg97w/QyxE8z2HqdEGI1Vi2BKf8S5iWHRM76yvpkbnkQE0jmbU7/UfkuaxjUavYG5Wyl1FirhJwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id CAAAD1A019F;
	Tue, 28 Apr 2026 18:23:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 18B901A;
	Tue, 28 Apr 2026 18:23:20 +0000 (UTC)
Date: Tue, 28 Apr 2026 14:23:35 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Bunyod Suvonov <b.suvonov@sjtu.edu.cn>
Cc: akpm@linux-foundation.org, vbabka@kernel.org, linux-mm@kvack.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 surenb@google.com, mhocko@suse.com, jackmanb@google.com,
 hannes@cmpxchg.org, ziy@nvidia.com, david@kernel.org,
 vishal.moola@gmail.com, corbet@lwn.net, skhan@linuxfoundation.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_alloc: trace PCP refills and PCP zone lock
 usage
Message-ID: <20260428142335.3bca0166@gandalf.local.home>
In-Reply-To: <20260427060142.131055-1-b.suvonov@sjtu.edu.cn>
References: <20260425091335.346504-1-b.suvonov@sjtu.edu.cn>
	<20260427060142.131055-1-b.suvonov@sjtu.edu.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 18B901A
X-Stat-Signature: azhpryjtjnjdyigxqnnox89n13h3sinn
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+UFa9J6ZZ2ZCYIdHrHbaM4b3uPpjbsHn0=
X-HE-Tag: 1777400600-860295
X-HE-Meta: U2FsdGVkX1/1l2zYtyLHECIBTXZzaTsijdArxXDL4dGI03ymfn0eos1R7Rf+Ej3EUn4kWeGDWlbhwXewVl034g/zeL6EG9CH+GSQ8Y/65m0p8EEr+n1xRHjJ5cFgWMn3j6I/sfs/b99G5BwuBXrYlkQRznZSlEFLJcUughZb5sAYSlTghZ7hPj1ytx3ftMELzol4OThU1AlAnEAyefusg1kLtNCjN+wJPn8Qc8HoGTLxaHIp9q5sQPPVJiFKvNURHMHPNPbcdob79uFscTR05YKjPdvaM+/u7earOlCco1y6I7PcA9+iXuNPVCyMbA7X

On Mon, 27 Apr 2026 14:01:42 +0800
Bunyod Suvonov <b.suvonov@sjtu.edu.cn> wrote:

> +	TP_STRUCT__entry(
> +		__field(int, nid)
> +		__field(int, zid)
> +		__field(unsigned long, nr_pages)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->nid		= nid;
> +		__entry->zid		= zid;
> +		__entry->nr_pages	= nr_pages;
> +	),
> +
> +	TP_printk("nid=%d zid=%d nr_pages=%lu",
> +		__entry->nid, __entry->zid, __entry->nr_pages)
> +);
> +
> +DEFINE_EVENT(mm_page_pcpu_zone_locked, mm_page_pcpu_refill_zone_locked,
> +
> +	TP_PROTO(int nid, int zid, unsigned long nr_pages),
> +
> +	TP_ARGS(nid, zid, nr_pages)
> +);
> +
> +DEFINE_EVENT(mm_page_pcpu_zone_locked, mm_page_pcpu_drain_zone_locked,
> +
> +	TP_PROTO(int nid, int zid, unsigned long nr_pages),
> +
> +	TP_ARGS(nid, zid, nr_pages)
> +);
> +
> +DECLARE_EVENT_CLASS(mm_page_pcpu,
>  
>  	TP_PROTO(struct page *page, unsigned int order, int migratetype),
>  
>  	TP_ARGS(page, order, migratetype),
>  
>  	TP_STRUCT__entry(
> -		__field(	unsigned long,	pfn		)
> -		__field(	unsigned int,	order		)
> -		__field(	int,		migratetype	)
> +		__field(unsigned long, pfn)
> +		__field(unsigned int, order)
> +		__field(int, migratetype)

Why this change? It makes it much harder to understand.

The above is not a normal macro. Ignore any checkpatch warnings about it.
The proper way to do the TP_STRUCT__entry() is to make it just like a struct:

struct {
	unsigned long		pfn;
	unsigned int		order;
	int			migratetype;
};

Thus, the macro should be:

	TP_STRUCT__entry(
		__field(	unsigned long,	pfn		)
		__field(	unsigned int,	order		)
		__field(	int,		migratetype	)
	),

-- Steve



>  	),
>  
