Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3BB3D9DA5;
	Fri,  5 Jun 2026 09:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780652150; cv=none; b=BgMfUAA7/LGXeqTVf16h4t91cDqmkkuDFm8iNNF4kZfC8ICi3QVm4NuLkPILHGSVqlSwHin5c6WcahVPIx6DU+oAMdc9Tb8shH90pAciM8qXSzCPam8oU+jVlUI/HhUOoJXq0IaYWijzdeb6rK76sZcoRmBPWa2KskUOCCiAQN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780652150; c=relaxed/simple;
	bh=RWyXGpeXTKNETGHIWgEjmAejxFfG/u5gH8IJN3uweL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmRjthOp87cSCuJysIProvhv1Vu/BrWeNieRdzyeJWGFeUS+BHZJAQ98hZudxjgmGLOyj2gwBFihrIBmbxvBY/9lrt/wNRy2jWidDR+8n5H27OZXvGFIaa5wRzlWrGieHFBX83mhQvhscFDQ7FAcelzm0B3HzgcLfYFmiXCXc4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=iDfmlnHG; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="iDfmlnHG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zlWtZOvWgDoHJPvKqfNO3Eu581+nJ0SQLgmcmlXuYXo=; b=iDfmlnHGeVi2uxrYd7Tq9kWHf7
	K+WPKvGVHHa1tIf0LwmKs9t6/v/nnGtvSwPhfytbVmDXWmmWoGQZ0v+rByRdaJA3tIYblFmqS4nIS
	98Z4UbeAaVVIl+Em61k1tTXgScPOGnTtzUtQJtrQwgD1PqQHt4ngV9dPt3ik/u4d3jEtfaIbZcX5K
	RByY1L08ON2pVGaR/VGq1IWlKHSo7St1+DxGWLp/bQpwVnMcOoyXYxg89tUNddrOlhJpYJWly3+/Y
	XDvflUXvtQUsfaQ6nXNNM45oijiggEAwFb8SE4JJxSWoB1kQWoNtuYqpklQHvV56wUan3+1Jdh/6F
	LoPIbzrg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wVQxe-005CEJ-2i;
	Fri, 05 Jun 2026 09:35:31 +0000
Date: Fri, 5 Jun 2026 02:35:23 -0700
From: Breno Leitao <leitao@debian.org>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com, Lance Yang <lance.yang@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>
Subject: Re: [PATCH v8 2/6] mm/memory-failure: surface unhandlable kernel
 pages as -ENOTRECOVERABLE
Message-ID: <aiKXrovzrNN-gExm@gmail.com>
References: <20260527-ecc_panic-v8-0-9ea0cfa16bb0@debian.org>
 <20260527-ecc_panic-v8-2-9ea0cfa16bb0@debian.org>
 <19f968f5-1289-f573-4406-e5c91dcd8923@huawei.com>
 <e3d023f1-ab6e-4424-b304-55f1294480c3@kernel.org>
 <33ef8821-c809-b7d1-ea77-6e8a07a6e784@huawei.com>
 <21732071-14a1-486a-951c-34de97b7c757@kernel.org>
 <4b27467e-935f-5587-2f48-5a794c30a592@huawei.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b27467e-935f-5587-2f48-5a794c30a592@huawei.com>
X-Debian-User: leitao

On Wed, Jun 03, 2026 at 10:33:04AM +0800, Miaohe Lin wrote:
> On 2026/6/2 17:41, David Hildenbrand (Arm) wrote:
> > On 6/2/26 05:08, Miaohe Lin wrote:
> >> On 2026/6/1 21:22, David Hildenbrand (Arm) wrote:
> >>> On 6/1/26 14:28, Miaohe Lin wrote:
> >>>>
> >>>> Thanks for your patch.
> >>>>
> >>>>
> >>>> Once shake_page finds a lightweight range-based way to shrink slab, slab pages could be freed
> >>>> into buddy and above PageSlab test should be removed then. Maybe add a TODO or XXX here?
> >>>>
> >>>>
> >>>> I'm not sure but is it safe or a common way to test PageReserved, PageSlab,
> >>>> PageTable and PageLargeKmalloc without extra page refcnt?
> >>>
> >>> Checking typed pages in a racy fashion is fine (PageSlab, PageTable,
> >>> PageLargeKmalloc).
> >>
> >> Got it. Thanks.
> >>
> >>> Checking PageReserved in a racy fashion is fine as well. TESTPAGEFLAG() will
> >>> allow checking it on compound pages.
> >>
> >> It seems PageReserved is not intended to be set on compound pages. I see there are PF_NO_COMPOUND
> >> in its definition: PAGEFLAG(Reserved, reserved, PF_NO_COMPOUND).
> >>
> >>>
> >>> For PageLargeKmalloc, we would want to check the head page, though. The page
> >>> type is only stored for the head page.
> >>
> >> Maybe we should check the head page for PageSlab and PageTable too? alloc_slab_page only
> >> set PageSlab on the head page and __pagetable_ctor uses __folio_set_pgtable to set PageTable
> >> on folio.
> >>
> >>>
> >>> So maybe we want to lookup the compound head (if any) and perform the type
> >>> checks against that?
> >>
> >> Maybe we should or we might miss some pages that could have been handled. And
> >> if compound head is required, should we hold an extra page refcnt to guard against
> >> possible folio split race?
> > 
> > Races are fine. We might miss some pages, but that can happen on races either way.
> > 
> > 
> > I'd just do something like
> > 
> > if (PageReserved(page))
> > 	return true;
> > 
> > head = compound_head(page);
> 
> If @head is split just after compound_head. And then @head is freed into buddy and re-allocated as slab
> page while @page is still in the buddy. We would panic on this scene as @head is PageSlab. But we were
> supposed to successfully handle @page. Or am I miss something?

You're right that it is racy, but I think it is an acceptable race here.

For it to happen, the poisoned @page has to be a tail of a live compound page
at the time of the fault, and then -- in the few instructions between
compound_head() and the PageSlab(head) test -- that compound page has to be
split, the old head freed to buddy, and that head re-allocated as a slab page,
all while @page lands back in the buddy.  It cannot happen without concurrent
split/free/alloc activity in that exact window.

It is also worth noting the page in question genuinely took a unrecoverable ECC
error, and panic_on_unrecoverable_memory_failure is opt-in -- an operator who
enables it has explicitly chosen to crash rather than risk running on corrupted
memory.  Mis-attributing one such rare, genuinely-poisoned page as
unrecoverable is within that contract.

Thanks for the review and discussions,
--breno
