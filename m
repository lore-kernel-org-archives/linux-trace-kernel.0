Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27B730FC0F
	for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Feb 2026 22:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771627001; cv=none; b=MfioHwPT9g+g5UAUFqK3GnyRGsvGck/n/8uHOobZnvynuD9bnvGURUitgZD8zpAFFdrCS8SWaB8j5Joy8cUMSwJy5JjxFEgj5RC/yFlY3d05c+DkowdGdOg8Ci0Udj/VpRu7aq2BcPufZ3mo5nbYWMKOinCFww9vX802H3EQNro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771627001; c=relaxed/simple;
	bh=xLi+aK+1wulqXHZb2GEEHAC39+H82DMD83cUD0D89d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzepU9Imt7nBn3z1LnE+HZMAf9PpJXzwQn146p0Gn8eYHW+ARGnZTBMVqUBKsHjtL/oeUa5AzWr5ptLCl1t4F53o59Ok5M36NosL5sl83NPjylykED8QrVNFAs85gUpMLw26fFUYueATX5GNDlY+VHl6bpFBkUMRCiLSUGeQCP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pKvJjS9D; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pKvJjS9D"
Date: Fri, 20 Feb 2026 14:36:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771626997;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=17l9wsknqpDh3Ho+puVaM2L51kBHPZptdt5u/gzymAg=;
	b=pKvJjS9DhaYP6P189MDYI9eqKNgtG2SFJBPkLvlJ+EBhb2h1Hrm9vIr1r3RBj6tuvWybPL
	HOqCqJcKbLRyHd56eGCI5eEreqe8BzOONEYoL5854Uq/71x6q4FoY5OEOnRKxdpxmLsDRx
	8fv3ZkcV40+xfqzepF/mQibG5VpBqV8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Cc: Dmitry Ilvokhin <d@ilvokhin.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, 
	kernel-team@meta.com, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Oscar Salvador <osalvador@suse.de>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>
Subject: Re: [PATCH 0/4] mm: zone lock tracepoint instrumentation
Message-ID: <aZjg6PWn_xhZV7Nb@linux.dev>
References: <cover.1770821420.git.d@ilvokhin.com>
 <06b2a2b6-d5c8-4522-8e22-10616f887846@amd.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06b2a2b6-d5c8-4522-8e22-10616f887846@amd.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Feb 20, 2026 at 01:09:59PM -0600, Cheatham, Benjamin wrote:
> On 2/11/2026 9:22 AM, Dmitry Ilvokhin wrote:
> > Zone lock contention can significantly impact allocation and
> > reclaim latency, as it is a central synchronization point in
> > the page allocator and reclaim paths. Improved visibility into
> > its behavior is therefore important for diagnosing performance
> > issues in memory-intensive workloads.
> > 
> > On some production workloads at Meta, we have observed noticeable
> > zone lock contention. Deeper analysis of lock holders and waiters
> > is currently difficult with existing instrumentation.
> > 
> > While generic lock contention_begin/contention_end tracepoints
> > cover the slow path, they do not provide sufficient visibility
> > into lock hold times. In particular, the lack of a release-side
> > event makes it difficult to identify long lock holders and
> > correlate them with waiters. As a result, distinguishing between
> > short bursts of contention and pathological long hold times
> > requires additional instrumentation.
> > 
> > This patch series adds dedicated tracepoint instrumentation to
> > zone lock, following the existing mmap_lock tracing model.
> > 
> > The goal is to enable detailed holder/waiter analysis and lock
> > hold time measurements without affecting the fast path when
> > tracing is disabled.
> > 
> > The series is structured as follows:
> > 
> >   1. Introduce zone lock wrappers.
> >   2. Mechanically convert zone lock users to the wrappers.
> >   3. Convert compaction to use the wrappers (requires minor
> >      restructuring of compact_lock_irqsave()).
> >   4. Add zone lock tracepoints.
> 
> I think you can improve the flow of this series if reorder as follows:
> 	1. Introduce zone lock wrappers
> 	4. Add zone lock tracepoints
> 	2. Mechanically convert zone lock users to the wrappers
> 	3. Convert compaction to use the wrappers...
> 
> and possibly squash 1 & 4 (though that might be too big of a patch). It's better to introduce the
> wrappers and their tracepoints together before the reviewer (i.e. me) forgets what was added in
> patch 1 by the time they get to patch 4.

I don't think this suggestion will make anything better. This just seems like a
different taste. If I make a suggestion, I would request to squash (1) and (2)
i.e. patch containing wrappers and their use together but that is just my taste
and would be a nit. The series ordering is good as is.

