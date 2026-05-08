Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369A2375AC3;
	Fri,  8 May 2026 18:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778263668; cv=none; b=O8XgAM8JJNpfUDhP/724H6OOibHwvKekqQd4h3vwgTQwC6VVMvcGRjs3ZKR3KfOu+Q9OAffJPUs9CiryTc3RllekVeEVUp7Hwq/R50nP7s5GCVdnH5KIqccdlUjrsDaAPaVMCFskITxlap1eIrFgptF3TtqjPBVkuv7ynJPCMvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778263668; c=relaxed/simple;
	bh=qhhTlGMvQMRL9Bmq9vcsE+UjnlVlYkTgwTJtLejSoFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=be/EERL610c3fi30wjcSXQyby+wN4y4TzauErHkxabid2JQiEP/Wr6DmbkokIgjg6gtpAOZU6ZP6KfXnzlucEA96JlrcuIwU5PxcCZ96OoySRtcm7e1e4sxuw8u84B9PEuEToEmpuBMt5XKYwrDD5lRoyNUycYwqGk9Yu691dxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=VQuOdwNp; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="VQuOdwNp"
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 361AFD019C;
	Fri, 08 May 2026 18:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1778263661;
	bh=U84xTPtSzHCYwlBfJ8QYFEF9cYH13YL55X92oolwzd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VQuOdwNpwD3wDXPZ50x0gvil9D7oQWIOkhUp+Dj0AEAOqKDxamokQgGBiTFsYPIG+
	 rzKKYCAZl/0yf5qyb96UUZtOWCM8Hnmsmm09tX1YRSzjKi9jQok2BrYaLyWZ279g/o
	 lHMGGVNXMSINmfC8NCrpkzmIis8akxSsC9KyMyDY=
Date: Fri, 8 May 2026 18:07:40 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, hawk@kernel.org,
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
Message-ID: <af4mbDB3-ohO5DCp@shell.ilvokhin.com>
References: <20260508162207.3315781-1-hawk@kernel.org>
 <20260508102948.b1c687e623fabec65580f258@linux-foundation.org>
 <832e4333-4079-4865-8ad8-3dd8868fb964@kernel.org>
 <4f61457e-deff-430f-8a1e-d3c33c925db3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f61457e-deff-430f-8a1e-d3c33c925db3@kernel.org>

On Fri, May 08, 2026 at 07:40:51PM +0200, Vlastimil Babka (SUSE) wrote:
> On 5/8/26 7:38 PM, Vlastimil Babka (SUSE) wrote:
> > On 5/8/26 7:29 PM, Andrew Morton wrote:
> >> e .configOn Fri,  8 May 2026 18:22:06 +0200 hawk@kernel.org wrote:
> >>
> >>> Add tracepoints to the page allocator fast paths that acquire
> >>> zone->lock, allowing diagnosis of lock contention in production.
> >>
> >> Thanks, I'm surprised we haven't done this yet.
> > 
> > There was a recent attempt [1]. Not being a generic solution wasn't welcome.
> > 
> > [1] https://lore.kernel.org/all/cover.1772206930.git.d@ilvokhin.com/
> 
> And this is the generic solution I think?
> 
> https://lore.kernel.org/all/cover.1777999826.git.d@ilvokhin.com/

Thanks for cc'ing me, Vlastimil.

Yes, this is an attempt at a generic solution for tracing contended
locks, including spinlocks, so it should also cover the use case
proposed in this patchset.

In fact, zone->lock contention was one of the primary motivations for
this work.
