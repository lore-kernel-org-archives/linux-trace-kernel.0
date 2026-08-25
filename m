Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172563F44FC;
	Tue, 25 Aug 2026 11:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787657211; cv=none; b=Z24IUTU6vVRpKenIjhbnjZ1ACU26ooe69XfUthIWQweQpB8Sxz1RR9t0dkAY33jnwa/5Ug1Ezog5dSztAmFmhlR9LL7AeWmSLJoSAqTL6XpOOf0xnASa+HtrURCxGXOPJfncjyJYU2fI2K/sIZMV9EdudpFNaWi5C2QIgnQ4EK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787657211; c=relaxed/simple;
	bh=PbYB/wvtFM1VPd3iwbL1tVogTkEhGUZQvsMK0I2XnnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OaF68BEnmxFwaRgxxkyuoxlZ0jQURoQF4NMsuyd+EuEGexBHeecHceZ0M5mXFSMWbRYq6cfaSCCmymFVSUnGaVwgLzwuPDr7vfNK3mh10ZaEmar/kIgjZa1lusQx8goI3wXDQePzCvX5G5Rc4PbGUWABBlXuVzOoTgj6wg2AlG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GoXlgVdV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GoXlgVdV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F260C1F000E9;
	Tue, 25 Aug 2026 11:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787657209;
	bh=+Kwg1vlmpiXfsrVuG+kXUemOecdCeye6XceIRD4GCkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GoXlgVdVnQB3UIKDtlCK2MeqgMCYQLVg5a+xp6sO3+cbWgVd5+A/I2aV1BFeUM7k6
	 BVHc7H3QnM5OAstm5ICZF1F8UtUkOy4StSrkX8dng+bSYclRRQOkGUeYGNXJIH+4/P
	 l6uMBxScbiacbX2oODUOkqBBoDvwqh6gu0SouefX1HJd802b3VnwzhSPutCafbEAgU
	 8TdZqHlqFtDqM86XjkQzIPwG4CoL+2UmnlHJLOG1je/70VJB/I7p+JYvsI646XL6a8
	 Mci0t5DOw3pDjpm/SEMAL6Qcu0JDgf8r4KMhu5L88J2MrpMu0jWyZHq0dsDmDpecvY
	 UJWoV4aI7U0Kg==
Date: Tue, 25 Aug 2026 12:26:39 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Barry Song <baohua@kernel.org>, Dev Jain <dev.jain@arm.com>, Hugh Dickins <hughd@google.com>, 
	Jann Horn <jannh@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, 
	Lance Yang <lance.yang@linux.dev>, "Liam R. Howlett" <liam@infradead.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>, 
	Nico Pache <nico.pache@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	Pedro Falcato <pfalcato@suse.de>, Peter Xu <peterx@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Shuah Khan <skhan@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Suren Baghdasaryan <surenb@google.com>, Usama Arif <usama.arif@linux.dev>, 
	Vlastimil Babka <vbabka@kernel.org>, Zi Yan <ziy@nvidia.com>, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] userfaultfd: use userfaultfd_*() helpers instead of
 open coded flag tests
Message-ID: <ao17rY2r-01wJxy6@gremlin>
References: <20260823-uffd-vm-flags-v1-v1-0-3086981b33cf@kernel.org>
 <20260823-uffd-vm-flags-v1-v1-3-3086981b33cf@kernel.org>
 <aoxdWWMEeQbcG5Pq@gremlin>
 <ao16WPoLpdIdU3ID@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ao16WPoLpdIdU3ID@kernel.org>

On Tue, Aug 25, 2026 at 02:19:52PM +0300, Mike Rapoport wrote:
> > > +/*
> > > + * Don't do fault around for WP, RWP or MINOR registered uffd range.  For
> > > + * MINOR registered range, fault around will be a total disaster and ptes can
> > > + * be installed without notifications; for WP it should mostly be fine as long
> > > + * as the fault around checks for pte_none() before the installation, however
> > > + * to be super safe we just forbid it; for RWP, pre-faulted neighbours would
> > > + * be indistinguishable from accessed pages in PAGEMAP_SCAN (PAGE_IS_ACCESSED)
> > > + * and pollute the tracked working set, so each page must be populated by its
> > > + * own fault.
> > > + */
> > > +static inline bool uffd_disable_fault_around(struct vm_area_struct *vma)
> > > +{
> > > +	return userfaultfd_minor(vma) || userfaultfd_wp(vma) ||
> > > +	       userfaultfd_rwp(vma);
> >
> > This is changing the logic.
> >
> > Before we were testing only the flags, now we have:
> >
> > static inline bool userfaultfd_rwp(const struct vm_area_struct *vma)
> > {
> > 	/*
> > 	 * Callers gate PAGE_NONE usage on this; PAGE_NONE is a BUILD_BUG()
> > 	 * without CONFIG_ARCH_HAS_PTE_PROTNONE, so fold to false.
> > 	 */
> > 	if (!IS_ENABLED(CONFIG_ARCH_HAS_PTE_PROTNONE))
> > 		return false;
> > 	return vma_test_single_mask(vma, VMA_UFFD_RWP);
> > }
> >
> > I.e. adding in a CONFIG_ARCH_HAS_PTE_PROTNONE check.
>
> Without CONFIG_ARCH_HAS_PTE_PROTNONE VMA_UFFD_RWP is hardwired to VM_NONE
> so it's functionally the same ;-)

Well then you're explicitly removing logic and not mentioning it anywhere
with a NFC commit.

So please say so in the commit message.

>
> > BTW side-note these:
> >
> > static inline bool userfaultfd_missing(const struct vm_area_struct *vma)
> > {
> > 	return vma_test_any_mask(vma, VMA_UFFD_MISSING);
> > }
> >
> > static inline bool userfaultfd_wp(const struct vm_area_struct *vma)
> > {
> > 	return vma_test_any_mask(vma, VMA_UFFD_WP);
> > }
> >
> > static inline bool userfaultfd_minor(const struct vm_area_struct *vma)
> > {
> > 	return vma_test_any_mask(vma, VMA_UFFD_MINOR);
> > }
> >
> > Should all use vma_test_single_mask() really :)
>
> These are changed anyway in a later patch.

Yup, but you (potentially) break one of them. Will comment there.

>
> > --
> > Cheers, Lorenzo
>
> --
> Sincerely yours,
> Mike.

--
Cheers, Lorenzo
