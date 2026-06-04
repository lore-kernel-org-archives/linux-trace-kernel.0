Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2779F47F2FC;
	Thu,  4 Jun 2026 13:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581221; cv=none; b=V0+4o8vtOs+I87KjjdN/99HUzg+y8ZvUIzfpkgKl8xY0BH6phkXJtiVy6ZHUkANEdyJoEo/s3VVOomNbxTgwD62kKA2Uho6S2yo2gF4r0q1HoQyRvFw+9SgGh6bNFzLAuhvkJhD0MaWfVEjXMYtqhPPApi/oI0z5WTscwBva2xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581221; c=relaxed/simple;
	bh=mRh0VaBA/yCfOha4TKlzMP49gsTdg47VGEalunDZymc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvlHWYIquLPIyt3r1GCoamD/+dc6YkvG91XV3nVqy437/8E9jskego0K3AqYQejaf6tY1yIJpt6v/sLjWaZvmicp4bHYnbEF8YWdHm3PsRSc8yjTmbpmiDHhunDeJUKpSq6HZCXjx9zXRzP106jDw7PpAGo02XmswkgLtLM1vQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzqzYO2T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzqzYO2T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0951F00899;
	Thu,  4 Jun 2026 13:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780581219;
	bh=h7fqEzq+8r1qw2WgMw+xFsqBS8Zw0z0B3cZPyb5YMMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dzqzYO2T3m36kzW1yxP+570KgkTp1IRt9fyu6XFmSzKGjEqAWM11AQdUQq36K+soG
	 fl//OGK/4EzzX3Br5DhTx8Qw98W6u0BrAr4vF3/L50mDdE/tYLjQKOTJnbQ+4IWlYn
	 n+d+1XYs6uULxVUh5qQManDthIp7OwJyZcZW7PwRs8NqBkIAQ10Bo9O+I3WorVUdBZ
	 mDEUpytJ252EZBGOJ9UN1GCaGzWPv0G0e963JW9drQuRZT3rCPw0lLT38S/NEgqRUf
	 cSyya0lYC14ApvoQ4lXZRXHGKNiacF2dKASVaRRXUlKH6gywPB5zr3Ppu3t61CbAUe
	 QGIAKxtNsKOpQ==
Date: Thu, 4 Jun 2026 14:53:25 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Nico Pache <npache@redhat.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	aarcange@redhat.com, akpm@linux-foundation.org, anshuman.khandual@arm.com, 
	apopple@nvidia.com, baohua@kernel.org, baolin.wang@linux.alibaba.com, 
	byungchul@sk.com, catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org, 
	hughd@google.com, jack@suse.cz, jackmanb@google.com, jannh@google.com, 
	jglisse@google.com, joshua.hahnjy@gmail.com, kas@kernel.org, lance.yang@linux.dev, 
	liam@infradead.org, mathieu.desnoyers@efficios.com, matthew.brost@intel.com, 
	mhiramat@kernel.org, mhocko@suse.com, peterx@redhat.com, pfalcato@suse.de, 
	rakie.kim@sk.com, raquini@redhat.com, rdunlap@infradead.org, 
	richard.weiyang@gmail.com, rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org, 
	ryan.roberts@arm.com, shivankg@amd.com, sunnanyong@huawei.com, surenb@google.com, 
	thomas.hellstrom@linux.intel.com, tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz, 
	vishal.moola@gmail.com, wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, zokeefe@google.com
Subject: Re: [PATCH mm-unstable v18 11/14] mm/khugepaged: Introduce mTHP
 collapse support
Message-ID: <aiF25dvH4qd_C4aj@lucifer>
References: <20260522150009.121603-1-npache@redhat.com>
 <20260522150009.121603-12-npache@redhat.com>
 <b8380eb3-096a-49f1-9ace-99c1e75888b4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8380eb3-096a-49f1-9ace-99c1e75888b4@kernel.org>

(Checking the algorithm here)

On Mon, Jun 01, 2026 at 10:11:24AM +0200, David Hildenbrand (Arm) wrote:
> On 5/22/26 17:00, Nico Pache wrote:
>
> Finally time for the core piece :)
>
> > Enable khugepaged to collapse to mTHP orders. This patch implements the
> > main scanning logic using a bitmap to track occupied pages and a stack
> > structure that allows us to find optimal collapse sizes.
> >
> > Previous to this patch, PMD collapse had 3 main phases, a light weight
> > scanning phase (mmap_read_lock) that determines a potential PMD
> > collapse, an alloc phase (mmap unlocked), then finally heavier collapse
> > phase (mmap_write_lock).
> >
> > To enabled mTHP collapse we make the following changes:
> >
> > During PMD scan phase, track occupied pages in a bitmap. When mTHP
> > orders are enabled, we remove the restriction of max_ptes_none during the
> > scan phase to avoid missing potential mTHP collapse candidates. Once we
> > have scanned the full PMD range and updated the bitmap to track occupied
> > pages, we use the bitmap to find the optimal mTHP size.
> >
> > Implement collapse_scan_bitmap() to perform binary recursion on the bitmap
> > and determine the best eligible order for the collapse. A stack structure
> > is used instead of traditional recursion to manage the search. This also
> > prevents a traditional recursive approach when the kernel stack struct is
> > limited. The algorithm recursively splits the bitmap into smaller chunks to
> > find the highest order mTHPs that satisfy the collapse criteria. We start
> > by attempting the PMD order, then moved on the consecutively lower orders
> > (mTHP collapse). The stack maintains a pair of variables (offset, order),

This is inaccurate, it's only consecutively smaller until you hit smallest then
it starts bumping around 2 -> 3 -> 2 -> 3 -> 2 -> .. -> 4 -> 3 -> 2 -> 3 -> 2 -> 4 -> etc.

More like consecutively smaller, then always trying for the smallest possible
fit?

Would be good to describe why we do this, presumably to get a best _fit_?

> > indicating the number of PTEs from the start of the PMD, and the order of
> > the potential collapse candidate.
> >
> > The algorithm for consuming the bitmap works as such:
> >     1) push (0, HPAGE_PMD_ORDER) onto the stack
> >     2) pop the stack
> >     3) check if the number of set bits in that (offset,order) pair
> >        statisfy the max_ptes_none threshold for that order
> >     4) if yes, attempt collapse
> >     5) if no (or collapse fails), push two new stack items representing
> >        the left and right halves of the current bitmap range, at the
> >        next lower order

I notice the ordering is wrong here, you actualy push the mid_offset first then
the offset (e.g. 'right', then 'left'):

			collapse_mthp_stack_push(cc, &stack_size, mid_offset,
						 next_order);
			collapse_mthp_stack_push(cc, &stack_size, offset,
						 next_order);

So that way you are popping the 'left' first then the 'right'.

So seems you'll get:

stack={0, 9}

Pop (0, order=9):

	|----------------------------------------|
	|########################################|
	|----------------------------------------|

stack={256, 8}, {0, 8}

Pop (0, order=8):

	|--------------------|-------------------|
	|####################|                   |
	|--------------------|-------------------|


stack={256, 8}, {128, 7}, {0, 7}

Pop (0, order=7):

	|----------|-----------------------------|
	|##########|                             |
	|----------|-----------------------------|

stack={256, 8}, {128, 7}, {64, 6}, {0, 6}

Pop (0, order=6):

	|----|-----------------------------------|
	|####|                                   |
	|----|-----------------------------------|

...

stack={256, 8}, ..., { 8, 3 }, {0, 2}

Pop (0, order=2):

	|-|--------------------------------------|
	|#|                                      |
	|-|--------------------------------------|

Then finally :) we get the offsets :)

stack={256, 8}, ..., {8, 3}, {4, 2}

Pop (4, order=2):

	|-|-|------------------------------------|
	| |#|                                    |
	|-|-|------------------------------------|

stack={256, 8}, ..., { 12, 2 }, {8, 3}

Pop (8, order=3):

	|---|--|---------------------------------|
	|   |##|                                 |
	|---|--|---------------------------------|

stack={256, 8}, ..., { 12, 2 }, {12, 2}, {8, 2}

Pop (8, order=2):

	|---|-|----------------------------------|
	|   |#|                                  |
	|---|-|----------------------------------|

etc.


It seems to me that you're going to keep iterating down until you match an mTHP
when a larger mTHP could have been had?

So we're going:

order 9 -> 8 -> 7 -> 6 -> ... -> 2 -> 3 -> 2 -> 4 -> 3 -> 2

I guess the point is to avoid only getting the largest possible




I guess if we did try to get the largest then we'd only get 2 of the largest
possible then exhaust the whole PMD, should a PMD-sized entry not be possble.

> >     6) repeat at step (2) until stack is empty.
> >
> > Below is a diagram representing the algorithm and stack items:
> >
> >                             offset   mid_offset
> >                             |        |
> >                             |        |
> >                             v        v
> >           ____________________________________
> >          |          PTE Page Table            |
> >          --------------------------------------
> > 			    <-------><------->
> >                              order-1  order-1
>
>
> Reading this, it is unclear why exactly do we need the stack.
>
> Why can't you work with offset + cur_order?
>
> Initially,
>
> 	offset = 0;
> 	cur_order = HPAGE_PMD_ORDER;
>
> If collapse succeeded, advance to next range.
> If collapse failed, try next smaller order, keeping offset unchanged.
>
> 	if (failed && cur_order > KHUGEPAGED_MIN_MTHP_ORDER) {
> 		/* Try next smaller order. */
> 		cur_order = cur_order - 1;

OK this matches the stack for the 0 offset entries...

> 	} else {
> 		/* Skip to next chunk. */
> 		offset += 1 << cur_order;
> 		cur_order = max_order_from_offset(offset);

Then 1 << 2 -> 4 so go to offset=4.

max_order_from_offset(4) = 2. so (4, offset=2) same as above.

Then we'd loop back here and go to offset = 8, and max_order_from_offset(8) = 3

And, yeah this seems equivalent.

> 	}

>
> Of course, handling disabled orders. max_order_from_offset() is rather trivial
> (natural buddy order, capped at HPAGE_PMD_ORDER).

Something like?

static unsigned long max_order_from_offset(unsigned long offset)
{
	if (!offset)
	   return HPAGE_PMD_ORDER;

	return ilog2(offset);
}

>
> What's the benefit of the stack?

Yeah it seems equivalent. Good idea!

Thanks, Lorenzo
