Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83989369D57;
	Mon, 24 Aug 2026 15:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584261; cv=none; b=YQNH+cV+wLEiWj7MfVlyOuYpcPDIqwY2N7v+KVDpJz8yRtkTKU21lfkl92rY4x+/hkaMjHAm4cIzZGVJ5av6Yi5W+wtyIyvj3tctdv3xp/RbO66nrHnnfTNgGeOV1sTG6J6OzkHPHtxRByi83AxL0AqqanuBtpqkf5q3oyfXba0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584261; c=relaxed/simple;
	bh=N5HeBxgaLz7/XZFrGAR2Ht9zy4LD5buaaVV/LUpd5fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WI0Vt+Cy/x5bXIVi36OKpk8Fl8oOYFsip68nEIsu0VnQ2dDvXAQGcfpYxAHPdJXV5a0zBpw+PfNhh0bfR0Sky4moKhnJGsxle0mHpcFvGrAkX1gp5klwImNNQEb9NA8R9BIKd8mKV61uIduqjN4brWT5iFTSt8b6rRFaffpcnA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIeM4nw9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIeM4nw9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2423E1F000E9;
	Mon, 24 Aug 2026 15:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787584260;
	bh=Wx9f9XPX6UaTsyTsSp+lWebUiETju9PeSHKWEVZrKvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aIeM4nw9zSLp14C7Qg/aoWJ+Gibkr1HmmR0ckBQ4y26T1NYNtGBzmDSU3/xnRFaoV
	 TuzTZNLgmDM9Q08D5Yzggqivp3V83HsLluIKSwBD+aVrE53Ku2YeWV1SMVRw1b+oVv
	 WlqOq3JhDUknsD4U/dUlvXguIpg2M9YY9kuprCHgTPYml9GsRiKR1abr4/MGUglhw8
	 P0swNBzh5TBanefQbSD7CTT9M15MwtjMlbZh8xrpLK5szSEfkcbGMw9vqK000/4003
	 /mbEjamc8pSlzLFaYVI9BuaqwBPBc18xTuyi5oze1LI6PTCMFPD1qLTgli+1JpTkhb
	 q10MUO6pdJrJQ==
Date: Mon, 24 Aug 2026 16:10:51 +0100
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
Subject: Re: [PATCH 3/6] userfaultfd: use userfaultfd_*() helpers instead of
 open coded flag tests
Message-ID: <aoxdWWMEeQbcG5Pq@gremlin>
References: <20260823-uffd-vm-flags-v1-v1-0-3086981b33cf@kernel.org>
 <20260823-uffd-vm-flags-v1-v1-3-3086981b33cf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260823-uffd-vm-flags-v1-v1-3-3086981b33cf@kernel.org>

On Sun, Aug 23, 2026 at 03:17:40PM +0300, Mike Rapoport (Microsoft) wrote:
> Move userfaultfd_{missing,wp,minor,rwp}() and userfaultfd_protected()
> ahead of uffd_disable_huge_pmd_share() and uffd_disable_fault_around()
> and make the latter two use the helpers rather than open coded VMA flag
> masks.
>
> Convert open coded VMA flag test in mfill_get_vma() to userfaultfd_wp()
> as well.

It'd be better to do the moves and the reworks separately. We don't have a limit
on patch count :)

>
> With every user of the per-VMA uffd modes going through the helpers,
> their underlying representation can be changed in the next step.
>
> No functional change.

There is a functional change, or at least seems to be, see below.

>
> Assisted-by: copilot:claude-opus-5
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  include/linux/userfaultfd_k.h | 70 +++++++++++++++++++++----------------------
>  mm/userfaultfd.c              |  2 +-
>  2 files changed, 35 insertions(+), 37 deletions(-)
>
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index 3396d270b159..d8262e3dc134 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -168,42 +168,6 @@ static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
>  	return vma->vm_userfaultfd_ctx.ctx == vm_ctx.ctx;
>  }
>
> -/*
> - * Never enable huge pmd sharing on some uffd registered vmas:
> - *
> - * - VM_UFFD_WP and VM_UFFD_RWP VMAs, because the write protect / access
> - *   tracking information is per pgtable entry.
> - *
> - * - VM_UFFD_MINOR VMAs, because otherwise we would never get minor faults for
> - *   VMAs which share huge pmds. (If you have two mappings to the same
> - *   underlying pages, and fault in the non-UFFD-registered one with a write,
> - *   with huge pmd sharing this would *also* setup the second UFFD-registered
> - *   mapping, and we'd not get minor faults.)
> - */
> -static inline bool uffd_disable_huge_pmd_share(struct vm_area_struct *vma)
> -{
> -	return vma_test_any_mask(vma,
> -		mk_vma_flags_from_masks(VMA_UFFD_WP, VMA_UFFD_RWP,
> -					VMA_UFFD_MINOR));
> -}
> -
> -/*
> - * Don't do fault around for WP, RWP or MINOR registered uffd range.  For
> - * MINOR registered range, fault around will be a total disaster and ptes can
> - * be installed without notifications; for WP it should mostly be fine as long
> - * as the fault around checks for pte_none() before the installation, however
> - * to be super safe we just forbid it; for RWP, pre-faulted neighbours would
> - * be indistinguishable from accessed pages in PAGEMAP_SCAN (PAGE_IS_ACCESSED)
> - * and pollute the tracked working set, so each page must be populated by its
> - * own fault.
> - */
> -static inline bool uffd_disable_fault_around(struct vm_area_struct *vma)
> -{
> -	return vma_test_any_mask(vma,
> -		mk_vma_flags_from_masks(VMA_UFFD_WP, VMA_UFFD_RWP,
> -					VMA_UFFD_MINOR));
> -}
> -
>  static inline bool userfaultfd_missing(const struct vm_area_struct *vma)
>  {
>  	return vma_test_any_mask(vma, VMA_UFFD_MISSING);
> @@ -235,6 +199,40 @@ static inline bool userfaultfd_protected(const struct vm_area_struct *vma)
>  	return userfaultfd_wp(vma) || userfaultfd_rwp(vma);
>  }
>
> +/*
> + * Never enable huge pmd sharing on some uffd registered vmas:
> + *
> + * - uffd-WP and uffd-RWP VMAs, because the write protect / access tracking
> + *   information is per pgtable entry.
> + *
> + * - uffd-MINOR VMAs, because otherwise we would never get minor faults for
> + *   VMAs which share huge pmds. (If you have two mappings to the same
> + *   underlying pages, and fault in the non-UFFD-registered one with a write,
> + *   with huge pmd sharing this would *also* setup the second UFFD-registered
> + *   mapping, and we'd not get minor faults.)
> + */
> +static inline bool uffd_disable_huge_pmd_share(struct vm_area_struct *vma)
> +{
> +	return userfaultfd_minor(vma) || userfaultfd_wp(vma) ||
> +	       userfaultfd_rwp(vma);
> +}
> +
> +/*
> + * Don't do fault around for WP, RWP or MINOR registered uffd range.  For
> + * MINOR registered range, fault around will be a total disaster and ptes can
> + * be installed without notifications; for WP it should mostly be fine as long
> + * as the fault around checks for pte_none() before the installation, however
> + * to be super safe we just forbid it; for RWP, pre-faulted neighbours would
> + * be indistinguishable from accessed pages in PAGEMAP_SCAN (PAGE_IS_ACCESSED)
> + * and pollute the tracked working set, so each page must be populated by its
> + * own fault.
> + */
> +static inline bool uffd_disable_fault_around(struct vm_area_struct *vma)
> +{
> +	return userfaultfd_minor(vma) || userfaultfd_wp(vma) ||
> +	       userfaultfd_rwp(vma);

This is changing the logic.

Before we were testing only the flags, now we have:

static inline bool userfaultfd_rwp(const struct vm_area_struct *vma)
{
	/*
	 * Callers gate PAGE_NONE usage on this; PAGE_NONE is a BUILD_BUG()
	 * without CONFIG_ARCH_HAS_PTE_PROTNONE, so fold to false.
	 */
	if (!IS_ENABLED(CONFIG_ARCH_HAS_PTE_PROTNONE))
		return false;
	return vma_test_single_mask(vma, VMA_UFFD_RWP);
}

I.e. adding in a CONFIG_ARCH_HAS_PTE_PROTNONE check.

BTW side-note these:

static inline bool userfaultfd_missing(const struct vm_area_struct *vma)
{
	return vma_test_any_mask(vma, VMA_UFFD_MISSING);
}

static inline bool userfaultfd_wp(const struct vm_area_struct *vma)
{
	return vma_test_any_mask(vma, VMA_UFFD_WP);
}

static inline bool userfaultfd_minor(const struct vm_area_struct *vma)
{
	return vma_test_any_mask(vma, VMA_UFFD_MINOR);
}

Should all use vma_test_single_mask() really :)


> +}
> +
>  static inline bool userfaultfd_pte_wp(struct vm_area_struct *vma,
>  				      pte_t pte)
>  {
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 74f04c323c50..32003aa04943 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -261,7 +261,7 @@ static int mfill_get_vma(struct mfill_state *state)
>  	 * validate 'mode' now that we know the dst_vma: don't allow
>  	 * a wrprotect copy if the userfaultfd didn't register as WP.
>  	 */
> -	if ((flags & MFILL_ATOMIC_WP) && !(dst_vma->vm_flags & VM_UFFD_WP))
> +	if ((flags & MFILL_ATOMIC_WP) && !userfaultfd_wp(dst_vma))
>  		goto out_unlock;
>
>  	if (is_vm_hugetlb_page(dst_vma))
>
> --
> 2.53.0
>

--
Cheers, Lorenzo
