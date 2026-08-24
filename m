Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617DF239E60;
	Mon, 24 Aug 2026 14:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583575; cv=none; b=QN8Xad0zwSuQebgy9AuoIUJxc7aGJY5tljVchDxoPiMY5VRpaNswST6zMcGRTN1KLdtk86hioF+vxle77gwSSOZSK4cXT1pV6WH6Vr93SbwU/HNJqWaTyQfdi607lqxTUY+Zevp6HMFNLu8+99c+TROUhA8J45dQwXbpC6hAsQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583575; c=relaxed/simple;
	bh=2xbYWWA2A5lp9vXQmXIPtL6kb0IJD+kCExBxK7q+77Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/Wm0OvBXvXDvhPxD3C33TIThq64ows/UlPiW5jPk4PBrHj8ryZkmkUN724es6kZf7P0RzEYdnzHkSPt0yMvcXAL5Vz7aFZBzpaFCy/RNrqGCfzW5rfgf0D6/GkAWwFKY4zvjjU4OFtWMLosWPhcPAdWsD3AhRwjAy3HPp2KK/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGFVkLHL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGFVkLHL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2CC1F000E9;
	Mon, 24 Aug 2026 14:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787583574;
	bh=AccNNgKH6mpdiOZn+TQ6yi+YTRFl1ckABXXlP5qNp0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WGFVkLHLt8glwJyNyzpbegLiEczgB3KRRpoxrsKbnYBufxLJsdfqDhjhdP7T16Tx5
	 bqxKzSNDAJCPhN/X/3zf+HiOu+g0MnTXFumI1OQd9LYWSCC54AQS8bvMlvM7Q7DEdB
	 F6+Y9XiTmfKwR+wo5sGnM0dgZnSkFBQxie7k+L7q0HtnN0kovChN6zZm2ic4jGevda
	 Hkd+WMr6ZxnA/yTIZcDJL8LfULRtlUE+8UlWLZyr4gIuAu5E7JTeg9qNc7tLpPrH+L
	 z5FuXi7SjxSz37zwDb/a62Uf6rEkWJgcBNM1Kin4Iwuk7WW72JJ2lAu6X7xGJJIEi9
	 2kVhcK32BgG3Q==
Date: Mon, 24 Aug 2026 15:59:26 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
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
Subject: Re: [PATCH 1/6] mm/gup: move gup_can_follow_protnone() to gup.c
Message-ID: <aoxcRstdSy99lNEA@gremlin>
References: <20260823-uffd-vm-flags-v1-v1-0-3086981b33cf@kernel.org>
 <20260823-uffd-vm-flags-v1-v1-1-3086981b33cf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260823-uffd-vm-flags-v1-v1-1-3086981b33cf@kernel.org>

On Sun, Aug 23, 2026 at 03:17:38PM +0300, Mike Rapoport (Microsoft) wrote:
> gup_can_follow_protnone() is defined in include/linux/mm.h but only used
> by mm/gup.c.
>
> First, there is no reason to have it in already gigantic header.
>
> Next, the upcoming refactoring of userfaultfd flags will make
> gup_can_follow_protnone() depend on userfaultfd_k.h which would cause a
> cyclic header dependency.
>
> Move gup_can_follow_protnone() to mm/gup.c.
>
> No functional change.
>
> Assisted-by: copilot:claude-opus-5
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  include/linux/mm.h | 38 --------------------------------------
>  mm/gup.c           | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+), 38 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0829e0d3b2d1..4daf9cd6ae8e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4860,44 +4860,6 @@ static inline int vm_fault_to_errno(vm_fault_t vm_fault, int foll_flags)
>  	return 0;
>  }
>
> -/*
> - * Indicates whether GUP can follow a PROT_NONE mapped page, or whether
> - * a (NUMA hinting or userfaultfd RWP) fault is required.
> - */
> -static inline bool gup_can_follow_protnone(const struct vm_area_struct *vma,
> -					   unsigned int flags)
> -{
> -	/*
> -	 * VM_UFFD_RWP uses protnone as an access-tracking marker, not for
> -	 * NUMA hinting. GUP must always take a fault so the access is
> -	 * delivered to userfaultfd, regardless of FOLL_HONOR_NUMA_FAULT.
> -	 *
> -	 * Only do so while the VMA is accessible. If it has been made
> -	 * inaccessible (e.g. mprotect(PROT_NONE)), fall through to the guard
> -	 * below: forcing a fault there would loop, as handle_mm_fault() makes
> -	 * no progress on protnone in an inaccessible VMA, and the access is
> -	 * denied regardless of RWP anyway.
> -	 */
> -	if (vma_test_single_mask(vma, VMA_UFFD_RWP) && vma_is_accessible(vma))
> -		return false;
> -
> -	/*
> -	 * If callers don't want to honor NUMA hinting faults, no need to
> -	 * determine if we would actually have to trigger a NUMA hinting fault.
> -	 */
> -	if (!(flags & FOLL_HONOR_NUMA_FAULT))
> -		return true;
> -
> -	/*
> -	 * NUMA hinting faults don't apply in inaccessible (PROT_NONE) VMAs.
> -	 *
> -	 * Requiring a fault here even for inaccessible VMAs would mean that
> -	 * FOLL_FORCE cannot make any progress, because handle_mm_fault()
> -	 * refuses to process NUMA hinting faults in inaccessible VMAs.
> -	 */
> -	return !vma_is_accessible(vma);
> -}
> -
>  typedef int (*pte_fn_t)(pte_t *pte, unsigned long addr, void *data);
>  extern int apply_to_page_range(struct mm_struct *mm, unsigned long address,
>  			       unsigned long size, pte_fn_t fn, void *data);
> diff --git a/mm/gup.c b/mm/gup.c
> index eb898ea1ee22..500e2aa99e48 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -633,6 +633,44 @@ static struct page *no_page_table(struct vm_area_struct *vma,
>  	return NULL;
>  }
>
> +/*
> + * Indicates whether GUP can follow a PROT_NONE mapped page, or whether
> + * a (NUMA hinting or userfaultfd RWP) fault is required.
> + */
> +static inline bool gup_can_follow_protnone(const struct vm_area_struct *vma,
> +					   unsigned int flags)
> +{
> +	/*
> +	 * VM_UFFD_RWP uses protnone as an access-tracking marker, not for
> +	 * NUMA hinting. GUP must always take a fault so the access is
> +	 * delivered to userfaultfd, regardless of FOLL_HONOR_NUMA_FAULT.
> +	 *
> +	 * Only do so while the VMA is accessible. If it has been made
> +	 * inaccessible (e.g. mprotect(PROT_NONE)), fall through to the guard
> +	 * below: forcing a fault there would loop, as handle_mm_fault() makes
> +	 * no progress on protnone in an inaccessible VMA, and the access is
> +	 * denied regardless of RWP anyway.
> +	 */
> +	if (vma_test_single_mask(vma, VMA_UFFD_RWP) && vma_is_accessible(vma))
> +		return false;
> +
> +	/*
> +	 * If callers don't want to honor NUMA hinting faults, no need to
> +	 * determine if we would actually have to trigger a NUMA hinting fault.
> +	 */
> +	if (!(flags & FOLL_HONOR_NUMA_FAULT))
> +		return true;
> +
> +	/*
> +	 * NUMA hinting faults don't apply in inaccessible (PROT_NONE) VMAs.
> +	 *
> +	 * Requiring a fault here even for inaccessible VMAs would mean that
> +	 * FOLL_FORCE cannot make any progress, because handle_mm_fault()
> +	 * refuses to process NUMA hinting faults in inaccessible VMAs.
> +	 */
> +	return !vma_is_accessible(vma);
> +}
> +
>  #ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
>  /* FOLL_FORCE can write to even unwritable PUDs in COW mappings. */
>  static inline bool can_follow_write_pud(pud_t pud, struct page *page,
>
> --
> 2.53.0
>

--
Cheers, Lorenzo
