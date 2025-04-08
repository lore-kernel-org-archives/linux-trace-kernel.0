Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E4921859D;
	Tue,  8 Apr 2025 17:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744131756; cv=none; b=a8jMQdCdCcY9jO0Tr9kpvdsrzFPpcX5Ihk+XB5wEIw3s+q56qJU1wAjGl4muMcPZSaScRRAM9ipH4ze5y3UjNPhUR6LDoGUccaXKQZ8Oi1BVvPmKoL5XzdPKOrsBsSD+dl57rvLTHnDTrzkjaRonZE2NTK8ax+Mbz+8Mzxoujx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744131756; c=relaxed/simple;
	bh=XpUvcH2fYKG/3+mJ7A6C90dV2a9DMLUENSZbwm6BhHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLNhWUtDtD0S6TvB61Je5qWQQO1XMAoZJCIGmbwMNN4I8fsfjqQgHmc7/b6wWI7CM1aqZmH/VlkBFsSLLMEv5rV37s7gxrQ3/AKBIh0mwXYRn3EKuEDl/MIcPn2Jgxueg1P79NJ51CC0tjPNLcpWO0suVdx61tkHslNEX5bDwi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pNvxRd/r; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pNvxRd/r"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Wthvw+g3VPjsBqYkn9PtU805EB50LUzQbJZB+kkRP04=; b=pNvxRd/rFKeuHejFP1UqBVVtJu
	wMFhn1znqYKaW/mLFjcM8+qpr5O392zgVI00cx12Ur6Rp6K+DE3Mglx/ManTL0g+3uJ6tazndBE2Q
	ew7Yo8AXeN7BLV0RSw5TffIiB7mEF5f85jPFWjjmwogHsITM7S0mLtBrcZ8KjM3lXoqusTb3DwK6O
	ilicc3T2BPad5dHtMSYfolaqiX+dTMYFNykY1BKO/mtvqVhauIS29BvQOsZYvkOE7B1Jt4NTyTv3c
	RZ/31JCEQI2IWe9u16RVO32pOAUC6PsWLXiEJfi5qWNVZGFSjqM+xQwfvOVsd1veTRO6VvjGX8sUs
	IQ+9PECA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u2CKR-000000000Fo-0n3G;
	Tue, 08 Apr 2025 17:01:39 +0000
Date: Tue, 8 Apr 2025 18:01:39 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sweet Tea Dorminy <sweettea@google.com>,
	Mateusz Guzik <mjguzik@gmail.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
	Martin Liu <liumartin@google.com>,
	David Rientjes <rientjes@google.com>, christian.koenig@amd.com,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [RFC PATCH v2] Introduce Hierarchical Per-CPU Counters
Message-ID: <Z_VWc6Z90rhfyLBp@casper.infradead.org>
References: <20250408160508.991738-1-mathieu.desnoyers@efficios.com>
 <f90d7646-99a3-48f5-ba2e-850c73592080@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f90d7646-99a3-48f5-ba2e-850c73592080@gentwo.org>

On Tue, Apr 08, 2025 at 09:37:18AM -0700, Christoph Lameter (Ampere) wrote:
> > The hierarchical per-CPU counters propagate a sum approximation through
> > a binary tree. When reaching the batch size, the carry is propagated
> > through a binary tree which consists of log2(nr_cpu_ids) levels. The
> > batch size for each level is twice the batch size of the prior level.
> 
> A binary tree? Could we do this N-way? Otherwise the tree will be 8 levels
> on a 512 cpu machine. Given the inflation of the number of cpus this
> scheme better work up to 8K cpus.

I find that a fan-out somewhere between 8 and 16 works well in practice.
log16(512) gives a 3 level tree as does a log8 tree.  log16(8192) is a 4
level tree whereas log8(8192) is a 5 level tree.  Not a big difference
either way.

Somebody was trying to persuade me that a new tree type that maintained
additional information at each level of the tree to make some operations
log(log(N)) would be a better idea than a B-tree that is log(N).  I
countered that a wider tree made the argument unsound at any size tree
up to 100k.  And we don't tend to have _that_ many objects in a
data structure inside the kernel.

ceil(log14(100,000)) = 5
ceil(log2(log2(100,000))) = 5

at a million, there's actually a gap, 6 vs 5.  But constant factors
become a much larger factor than scalability arguments at that point.
