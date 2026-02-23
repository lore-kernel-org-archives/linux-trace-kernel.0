Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF218450F2;
	Mon, 23 Feb 2026 16:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771865571; cv=none; b=iXKQ3xIoBNnvRhlyD+P0Xi/2gptj42roEIPzZW3db2wAXR5+Vk4EfVYbUpXR+9EKnm2WzUS3TTBu9eyUakOEGyVLI7hBprS9HqoHHMJcFpnDcsFt8oymevFf9i8l5uLSASubdaBM+bNduRCtHJqmvNhL72hxaFC6EYJL5Q4FjD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771865571; c=relaxed/simple;
	bh=FUHvfu3Jmzp0zHVzdn/Uk4CmJaKwVmAq+zBZx82++80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQVNKRcI1TMXV1r4/mJglPFi5YCQEDUKFUjj6c0t3HbxuSUAEViexi3I7H54CL6ooZhfw7Q5DSw7JHpR0hdBakRjEsWavyP5+HYpGi8H77ybW4EBppN4vBjOup6/AVaf5e3WyslTKG92oveh1e1UrwxJHDRqCtGSj75dmovYPdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=Ez5r3CS0; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="Ez5r3CS0"
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 306DCB2B38;
	Mon, 23 Feb 2026 16:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1771865206;
	bh=TJU/c2ANGiupnU+sNCDAu4d01p6h+HYD6nV72nQ/8io=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ez5r3CS0SktKVrjI5VhlqUZ/251A3OUIM41kfLezdKCG2T+l+22yDhHSpHd407S1t
	 eIOzh1MKKab9MJFHEvCVc0pbOEePdKuMGxRWCD+kXVKL8nmM8Zk4iEGuKOcXo61A8S
	 iPkEJrq7iki2d0E/l7SJ15+1J/j6+hxGHSxWGJHs=
Date: Mon, 23 Feb 2026 16:46:42 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	kernel-team@meta.com, Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Oscar Salvador <osalvador@suse.de>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>
Subject: Re: [PATCH 0/4] mm: zone lock tracepoint instrumentation
Message-ID: <aZyEctoThn0anlz8@shell.ilvokhin.com>
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

Hi Ben,

Thanks for the suggestion.

I structured the series intentionally to keep all behavior-preserving
refactoring separate from the actual instrumentation change.

In particular, I had to split the conversion into two patches to
separate the purely mechanical changes from the compaction
restructuring. With the current order, tracepoints addition remains a
single, atomic functional change on top of a fully converted tree. This
keeps the instrumentation isolated from the refactoring and with an
intention to make bisection and review of the behavioral change easier.

Reordering as suggested would mix instrumentation with intermediate
refactoring states, which I'd prefer to avoid.

I hope this reasoning makes sense, but I'm happy to discuss if there are
strong objections.

> 
> Thanks,
> Ben
