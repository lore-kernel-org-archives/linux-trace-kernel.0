Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E233749F1;
	Tue,  7 Jul 2026 14:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783436241; cv=none; b=s1xwps0HwsVexc+Wc1mbjhbWubKKe14AHPfyexjBmpOn6gmQ4+KZVHuPLjz0YEZVhxHjA49HkueyR9PmWZ7C2lHze3oUA7lIoDJyPVyO1RjfbulN1kHQ8k2oSkvcv/arw0CPy5jfjS3Gw7YPAx/hmTNjBe2N420CwwCSvZX2aOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783436241; c=relaxed/simple;
	bh=iF2qfpr+jdum+opeeAzFXT2X/6hDzwG0ffeFdqszmGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9ubVpuEEbh9f5e+/KbdiJjuYpVwKQ5o/6vC2DbHwwDFht4tI8hoXmwWlU/PJdQEDPn8CAYJg7Jr425M6gNDOj39TyW+2V8BCksCHGG9AphYoQloQRLfMfwFFqZjvmmtb+v1uOjJyldEe3jskbBO31R0g70D1OPuLroTaeLgbWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNK7mSok; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNK7mSok"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D671F000E9;
	Tue,  7 Jul 2026 14:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783436240;
	bh=P2vjmbjMy3vZ7oRtbv0eCFaCHMRnzEbJjEHjnyLeBK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SNK7mSokgCWpqfPi1jZRPTr23XF0hZ4iuApU4oYxv4oyU+taDfXcalL2D7Kgx1WuG
	 q02Pwto8RMmO5VNUNiguJnzKYgGf7itgSBSA3L5zjvZfGCN4AGbdKTEXWVH62mSCxl
	 T7QtZwQEZ9OrfF3t9ySdDTPhHC/HTgKC8A55mlVAFJF4VwrYvFSttPKXjsCB/Td7cS
	 bPBAkUUVHP9+t+0tubSBgj1dsWw0vJ3OJZa4IjbUdVUbQoPcJ7ArKPi/h/14E/3yEm
	 R+MHGGD1Y5WqOuC5XXMdlIOGzrdybpNZNUAeSsqrlY5Y5FKdP85z2hMcOkO+mWfhFe
	 238Q5vkXCWBLg==
Date: Tue, 7 Jul 2026 15:57:05 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Wandun <chenwandun1@gmail.com>
Cc: vbabka@kernel.org, david@kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, Alexander.Krabler@kuka.com, hughd@google.com, fvdl@google.com, 
	bigeasy@linutronix.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, akpm@linux-foundation.org, 
	surenb@google.com, mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, 
	ziy@nvidia.com, riel@surriel.com, liam@infradead.org, harry@kernel.org, 
	jannh@google.com, lance.yang@linux.dev, mathieu.desnoyers@efficios.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, 
	gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com, 
	pfalcato@suse.de
Subject: Re: [PATCH v2 4/4] mm/mlock: migrate folios out of CMA when mlocking
 a range
Message-ID: <ak0TU506eGq2sYJf@lucifer>
References: <20260707125925.3725177-1-chenwandun1@gmail.com>
 <20260707125925.3725177-5-chenwandun1@gmail.com>
 <bd88f65e-000b-4dde-92f7-28af6a34e977@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd88f65e-000b-4dde-92f7-28af6a34e977@gmail.com>

On Tue, Jul 07, 2026 at 09:36:17PM +0800, Wandun wrote:
<snip>
> > diff --git a/mm/mlock.c b/mm/mlock.c
> > index ac65de40b22b..f56c685533f5 100644
> > --- a/mm/mlock.c
> > +++ b/mm/mlock.c
<snip>
> > +static int mlock_collect_migratable_pte_range(pmd_t *pmd, unsigned long addr,
> > +			unsigned long end, struct mm_walk *walk)
> > +{
> > +	struct vm_area_struct *vma = walk->vma;
> > +	struct list_head *folio_list = walk->private;
> > +	spinlock_t *ptl;
> > +	pte_t *start_pte, *pte;
> > +	pte_t ptent;
> > +	struct folio *folio;
> > +	unsigned int step = 1;
> > +
> > +	if (!(vma->vm_flags & VM_LOCKED))
> > +		return 0;
> > +
> > +	ptl = pmd_trans_huge_lock(pmd, vma);
> > +	if (ptl) {
> > +		if (!pmd_present(*pmd)) {
> > +			if (unlikely(softleaf_is_migration(softleaf_from_pmd(*pmd)))) {
> > +				spin_unlock(ptl);
> > +				pmd_migration_entry_wait(vma->vm_mm, pmd);
> > +				walk->action = ACTION_AGAIN;
> > +				return 0;
> > +			}
> > +			goto out;
> > +		}
> > +		if (is_huge_zero_pmd(*pmd))
> > +			goto out;
> > +		folio = pmd_folio(*pmd);
> > +		if (folio_is_zone_device(folio))
> > +			goto out;
> > +		if (is_migrate_cma_page(&folio->page))
> > +			isolate_folio_to_list(folio, folio_list);
> > +		goto out;
> > +	}
> > +
> > +	start_pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> > +	if (!start_pte) {
> > +		walk->action = ACTION_AGAIN;
> > +		return 0;
> > +	}
> > +
> > +	for (pte = start_pte; addr != end; pte += step, addr += step * PAGE_SIZE) {
> > +		step = 1;
> > +		ptent = ptep_get(pte);
> > +		if (!pte_present(ptent)) {
> > +			if (unlikely(softleaf_is_migration(softleaf_from_pte(ptent)))) {
> > +				pte_unmap_unlock(start_pte, ptl);
> > +				migration_entry_wait(vma->vm_mm, pmd, addr);
> > +				walk->action = ACTION_AGAIN;
> > +				return 0;
> > +			}
> > +			continue;
> > +		}
> > +		folio = vm_normal_folio(vma, addr, ptent);
> > +		if (!folio || folio_is_zone_device(folio))
> > +			continue;
> > +		step = folio_mlock_step(folio, pte, addr, end);
> > +		if (is_migrate_cma_page(&folio->page))
> Here should be, sorry about this.
> 	if (!is_migrate_cma_page(&folio->page))
> 		continue;

But above you do the:

		if (is_migrate_cma_page(&folio->page))
			isolate_folio_to_list(folio, folio_list);

Pattern :) so these should be consistent. But you're copy/pasting and need to
not do that so it's kind of by the by.

Anyway, yes I assumed you meant this. But see the main review, I am not really a
fan of the implementation, overall.

>
> Best regards
> Wandun

Thanks, Lorenzo
