Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7CA849C
	for <linux-trace-kernel@vger.kernel.org>; Sat,  8 Nov 2025 00:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762560137; cv=none; b=C/qTgiDKwjCKA9U8CYrJ9qGI60JsqZP9YZjb9RFQ1Mj17l5MxXoiLpFJXYQKmt7U9eygWQNFnuQfpKIys0PRfleS+9MUNeYfEq67zWs85SLEfYT6tZ2DTjvhaKPL9GfGlYl9RqbV9n83s6tcuG3w8UBUpxurOyG5WxTmKRy+wPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762560137; c=relaxed/simple;
	bh=EAgqa3Zs+r/5nRl5WqFpnGeVUN787jXodc/S2ylw0Lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnAKPd+kEbRB2sXLStIQS82+GSKBraVlBVMh7Hvfgu9gZT5DLSve4BVD0AxFOQX4tqxkydO6aMeB29tTkPMNZoXdHQdyequcZZgwQY71YtPJrs65rU/B3tXbZeaYI0Sm9Jcov4kHyFKi7b8HRXWHLYfq9pYDv3jedSPBeD7yW6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ls2OpTMQ; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ls2OpTMQ"
Date: Fri, 7 Nov 2025 16:01:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762560132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PSP6l7mhg1u2uTbJjzva7r/QaQVEvYhyFI/ReZFQzdY=;
	b=ls2OpTMQSmOeDEfv8P4qyc8/YddPVMSn5fEKHSQCgSObawmV/H8+XLEyEdCwJ1VJ5+m8vP
	naNPEZNyKI71TjB5uf8JxOoTxnEzrV2YCeIg66r4rLFRe9aV/97y0MaYCrcsGSP0MbwPdQ
	2MxL91Ttu8ZaaQfhu6/omx3S+tOqz40=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, Andrew Morton <akpm@linux-foundation.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@linux.com>, Martin Liu <liumartin@google.com>, 
	David Rientjes <rientjes@google.com>, SeongJae Park <sj@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Sweet Tea Dorminy <sweettea@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R . Howlett" <liam.howlett@oracle.com>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Wei Yang <richard.weiyang@gmail.com>, David Hildenbrand <david@redhat.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Al Viro <viro@zeniv.linux.org.uk>, Yu Zhao <yuzhao@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Mateusz Guzik <mjguzik@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Aboorva Devarajan <aboorvad@linux.ibm.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, christian.koenig@amd.com
Subject: Re: [RFC PATCH v7 2/2] mm: Fix OOM killer inaccuracy on large
 many-core systems
Message-ID: <ahtgrrgn4uwqjumr2blnnhyykow77weu3iuk2wqiimjhq4yset@5o3wls37n5pp>
References: <20251031144232.15284-3-mathieu.desnoyers@efficios.com>
 <202511061432.4e534796-lkp@intel.com>
 <6hmgutxgdchs4qz6hprwsecwoygwszn5ywixxrvnereilegcsx@mxroaotaw2me>
 <7732c2eb-e547-47a8-93b3-1d1b4d9c27e8@efficios.com>
 <7b76f0e4-6148-4290-a295-7ceeb1ef2feb@efficios.com>
 <81258c9e-1436-4a4f-9343-ef574b8b0de6@efficios.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81258c9e-1436-4a4f-9343-ef574b8b0de6@efficios.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Nov 07, 2025 at 11:04:01AM -0500, Mathieu Desnoyers wrote:
> On 2025-11-07 10:53, Mathieu Desnoyers wrote:
> [...]
> > 
> > It would make sense to call an explicit percpu counter tree init
> > function from start_kernel() between the call to mm_core_init() and the
> > call to maple_tree_init(). This way it would be initialized right after
> > mm, but given that the hierarchical counter tree is a lib that can be
> > used for other purposes than mm accounting, I think it makes sense
> > to call its init explicitly from start_kernel() rather than bury
> > it within mm_core_init().
> See the following diff. If nobody object, I'll prepare a v8 which
> includes it.

This seems reasonable to me, I see v8 is already posted. I will take a
deeper look.

