Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652403624A8;
	Thu, 27 Aug 2026 07:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787814865; cv=none; b=kmOmFTJ9CxWXCjpKXHnz07kLpkFJdWCKrUQtwX18WAwvJfht2bL7sm5YCtmWNEe+HLiF6LzA1/BnTEdB4Dj8RJC/OlGvP2IqWWr7DJBZ6E24NfKYMYChWkPSX6JWJSiptJ/xJlNUKRn5dFV0iSOirEAdR3ber7RWmJzMgKjTurM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787814865; c=relaxed/simple;
	bh=3D8ff5zW/vZMlEclUlwi+ylibdKBP+Y7SVtfjULZPJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xw5yVi07178dXqF0JPXsA8oExX6zrcQB8w/id5d8UiRYoqepf67Vl+gg+C1jW1pks5C26uRweoFJowUgzt+AYSz9NhdTFeve1l3cxJdBCKlqG/IM4irW9GPY4+WvS81x6x1dcMG4XAeZxcNckRFJyrT5ycUDPGF2pXsZfgVmXQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNddaP5u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNddaP5u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037CF1F000E9;
	Thu, 27 Aug 2026 07:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787814863;
	bh=Raso+76RSPHx/Ucjk+/qBSNVKh7+vQJnbwdEuNJBG/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fNddaP5u4ClF4IxDP5h5xr3XP6tMYYeqDdj9zpbu5LHBY7nbpaoRRntLYSgV7jemr
	 b9eLgRPTDx55zngs9LXGmNbvEDH/S2ZXviXqTGjqmMO18aqmlUKhwWsgR1XWSi+/0G
	 rwQSwYcLJ6CvN57sswjLw5O5CfbNZF6CvrJ9z/3LjnO/hU7zrUdVLmkjQvW7ym603+
	 shF9ZXkrNBWluvZrGvfEWxHokaZVaa8X2HYN57n2H4s2ocnLV2KnlrBBib7zNEk8i4
	 1AlkgpTeTZgRm5MwacXLRcAE1gc8MYWCCVB+RwCd2LHQ7Em+lyzBK1JY1/n1207Nyi
	 X3uuqMYW2BQCQ==
Date: Thu, 27 Aug 2026 10:14:12 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>, Dev Jain <dev.jain@arm.com>,
	Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>, Lance Yang <lance.yang@linux.dev>,
	"Liam R. Howlett" <liam@infradead.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
	Nico Pache <nico.pache@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Pedro Falcato <pfalcato@suse.de>, Peter Xu <peterx@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Usama Arif <usama.arif@linux.dev>,
	Vlastimil Babka <vbabka@kernel.org>, Zi Yan <ziy@nvidia.com>,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] userfaultfd: use userfaultfd_*() helpers instead of
 open coded flag tests
Message-ID: <ao_jxMovVtj8UWeP@kernel.org>
References: <20260823-uffd-vm-flags-v1-v1-0-3086981b33cf@kernel.org>
 <20260823-uffd-vm-flags-v1-v1-3-3086981b33cf@kernel.org>
 <aoxdWWMEeQbcG5Pq@gremlin>
 <ao16WPoLpdIdU3ID@kernel.org>
 <ao17rY2r-01wJxy6@gremlin>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ao17rY2r-01wJxy6@gremlin>

On Tue, Aug 25, 2026 at 12:26:39PM +0100, Lorenzo Stoakes (ARM) wrote:
> On Tue, Aug 25, 2026 at 02:19:52PM +0300, Mike Rapoport wrote:
> > > > +/*
> > > > + * Don't do fault around for WP, RWP or MINOR registered uffd range.  For
> > > > + * MINOR registered range, fault around will be a total disaster and ptes can
> > > > + * be installed without notifications; for WP it should mostly be fine as long
> > > > + * as the fault around checks for pte_none() before the installation, however
> > > > + * to be super safe we just forbid it; for RWP, pre-faulted neighbours would
> > > > + * be indistinguishable from accessed pages in PAGEMAP_SCAN (PAGE_IS_ACCESSED)
> > > > + * and pollute the tracked working set, so each page must be populated by its
> > > > + * own fault.
> > > > + */
> > > > +static inline bool uffd_disable_fault_around(struct vm_area_struct *vma)
> > > > +{
> > > > +	return userfaultfd_minor(vma) || userfaultfd_wp(vma) ||
> > > > +	       userfaultfd_rwp(vma);
> > >
> > > This is changing the logic.
> > >
> > > Before we were testing only the flags, now we have:
> > >
> > > static inline bool userfaultfd_rwp(const struct vm_area_struct *vma)
> > > {
> > > 	/*
> > > 	 * Callers gate PAGE_NONE usage on this; PAGE_NONE is a BUILD_BUG()
> > > 	 * without CONFIG_ARCH_HAS_PTE_PROTNONE, so fold to false.
> > > 	 */
> > > 	if (!IS_ENABLED(CONFIG_ARCH_HAS_PTE_PROTNONE))
> > > 		return false;
> > > 	return vma_test_single_mask(vma, VMA_UFFD_RWP);
> > > }
> > >
> > > I.e. adding in a CONFIG_ARCH_HAS_PTE_PROTNONE check.
> >
> > Without CONFIG_ARCH_HAS_PTE_PROTNONE VMA_UFFD_RWP is hardwired to VM_NONE
> > so it's functionally the same ;-)
> 
> Well then you're explicitly removing logic and not mentioning it anywhere
> with a NFC commit.
> 
> So please say so in the commit message.

Ok 

> > > BTW side-note these:
> > >
> > > static inline bool userfaultfd_missing(const struct vm_area_struct *vma)
> > > {
> > > 	return vma_test_any_mask(vma, VMA_UFFD_MISSING);
> > > }
> > >
> > > static inline bool userfaultfd_wp(const struct vm_area_struct *vma)
> > > {
> > > 	return vma_test_any_mask(vma, VMA_UFFD_WP);
> > > }
> > >
> > > static inline bool userfaultfd_minor(const struct vm_area_struct *vma)
> > > {
> > > 	return vma_test_any_mask(vma, VMA_UFFD_MINOR);
> > > }
> > >
> > > Should all use vma_test_single_mask() really :)
> >
> > These are changed anyway in a later patch.
> 
> Yup, but you (potentially) break one of them. Will comment there.
 
Nope, nothing is broken, will comment there.

-- 
Sincerely yours,
Mike.
