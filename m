Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92EB326D51;
	Mon, 18 May 2026 17:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779123670; cv=none; b=nnkescTV7ykiCV+eabriW8ZjbKOh5dX2Z0o9E6ucZM090gGCSeoWWeWAMgQ6Jr2RJVa9ZBoRdSUoQNA/qqZFosdiqCrqxnL0T2sG+qov1VUoGAxM19E4rEEfpcDpNJa5OpVLRFGUaEmcChrv/SRhBvyh2WE+0hdSO5Iapt6h8o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779123670; c=relaxed/simple;
	bh=V/s1POIV7+iGl5ccqbg2taegNGsUMdkCx5nJQMJXcR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gglZCOv9kPJ0AqEks4SGr8bxjSzbkPVoBerTKFSbtwFbVQ6q9ok/pkCZeNFqQVnBalw1AKdwMFL6L7m+8UgbA8kV8VCIWKKnTP8ilShqsIhjExKdDPqGdozOSdRbe/qpIEm2NM8rn1lEZpmnw4ZzdJh4c/GWvK+yPQuPbiQi8gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=SudGqiPz; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="SudGqiPz"
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id E8864D0775;
	Mon, 18 May 2026 17:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1779123667;
	bh=53afaZ4VwfE18pyIt0/aLtc8OCUoXQOnKLkK9Ok63FY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SudGqiPzQrLgy7yMm3A8Ra87CT+LbsG/SSs0KP0TPL2HAbmbpUvjm2m+sfYPerK9f
	 rb85yUz5AVFjsOT5SxkFqq/DC4owCJZq1Cf+H3IbU6sSbjdGXh1IJ5s75fo2ARf2Ds
	 lecVop/RNmYktOPuYs3gRlfN4DuHAhLEtrriiKCg=
Date: Mon, 18 May 2026 17:01:03 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kernel-team@cloudflare.com
Subject: Re: [PATCH 1/2] mm/page_alloc: add tracepoints for zone->lock
 acquisitions
Message-ID: <agtFzw0a4SEyfUkr@shell.ilvokhin.com>
References: <20260508162207.3315781-1-hawk@kernel.org>
 <20260508102948.b1c687e623fabec65580f258@linux-foundation.org>
 <832e4333-4079-4865-8ad8-3dd8868fb964@kernel.org>
 <4f61457e-deff-430f-8a1e-d3c33c925db3@kernel.org>
 <af4mbDB3-ohO5DCp@shell.ilvokhin.com>
 <fab7d27a-6c2b-47aa-abe8-a327f05fb5cd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fab7d27a-6c2b-47aa-abe8-a327f05fb5cd@kernel.org>

On Wed, May 13, 2026 at 05:32:41PM +0200, Jesper Dangaard Brouer wrote:
> 
> 
> On 08/05/2026 20.07, Dmitry Ilvokhin wrote:
> > On Fri, May 08, 2026 at 07:40:51PM +0200, Vlastimil Babka (SUSE) wrote:
> > > On 5/8/26 7:38 PM, Vlastimil Babka (SUSE) wrote:
> > > > On 5/8/26 7:29 PM, Andrew Morton wrote:
> > > > > e .configOn Fri,  8 May 2026 18:22:06 +0200 hawk@kernel.org wrote:
> > > > > 
> > > > > > Add tracepoints to the page allocator fast paths that acquire
> > > > > > zone->lock, allowing diagnosis of lock contention in production.
> > > > > 
> > > > > Thanks, I'm surprised we haven't done this yet.
> > > > 
> > > > There was a recent attempt [1]. Not being a generic solution wasn't welcome.
> > > > 
> > > > [1] https://lore.kernel.org/all/cover.1772206930.git.d@ilvokhin.com/
> > > 
> > > And this is the generic solution I think?
> > > 
> > > https://lore.kernel.org/all/cover.1777999826.git.d@ilvokhin.com/
> > 
> > Thanks for cc'ing me, Vlastimil.
> > 
> > Yes, this is an attempt at a generic solution for tracing contended
> > locks, including spinlocks, so it should also cover the use case
> > proposed in this patchset.
> > 
> 
> I'm aware of the generic solution and often use `perf lock contention`.
> And the tool libbpf-tools/klockstat. My experience is unfortunately that
> enabling these tracepoint is prohibitive expensive on production server,
> and production suffers when I run these tools.

I think it depends on the workload: in particular how lock heavy it is.

At Meta we have a lock contention profiler (uses contention_begin and
contention_end tracepoints under the hood) running continiously in the
fleet. It is heavily sampled and each profilling session runs only for
few seconds, but in practice it is usually enough to get a pretty good
understanding what is going on.

That said, I understand the concern, and I can absolutely imagine
workloads where the overhead is still unacceptably high.

> 
> I'm very happy to see a patchset adding a contended case. But I worry
> that tracing all contented locks in the system is also too much to have
> enabled continuously for production.
> 
> This patch is carefully constructed to minimize overhead, such that I
> can enable this continuously on production to catch issues.  If I
> identify issue I will use the generic tracpoints for further debugging.
> 
> 
> > In fact, zone->lock contention was one of the primary motivations for
> > this work.
> 
> In the generic solution I'm loosing the "zone" and pages "count".  I
> need this information to get the answers I'm looking for.  Specifically
> I'm looking at reducing CONFIG_PCP_BATCH_SCALE_MAX, but I want to this
> to be a data-driven decision (my first principle is: if you cannot
> measure it you cannot improve it).
> 
> I'm likely going to apply this patch to our production system, such that
> I can get my data-driven decision.  I need to deploy it widely enough to
> get enough server experiencing direct-reclaim.  I'll report back if
> people are interested in these learning?

I would definitely be interested in hearing about your findings.

> 
> --Jesper
