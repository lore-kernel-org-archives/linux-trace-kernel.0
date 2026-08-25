Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D993D331E;
	Tue, 25 Aug 2026 10:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787652619; cv=none; b=S4SRsvckYtYC5/e20Kq80iQwoMsudKRT3EX5d7KFgG+mt8On6LDIksz+3/JRYimYXfU1uTeu5raC5mRMp9XUbflojF/K8uF5plXsO0rvhW7Wr475JiEll5GkUdHTRJ4yo16hFCenbtMpqj6UD/uJUY25uTW88UmdjdMBlEV1NDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787652619; c=relaxed/simple;
	bh=Ixk1g54x/R5LZj2YsRLYQX3HrbUEENLo+c/BzI/I9Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqzKHia98/ISYEBufgAwQhaNvrZe6HY41w2m2GiT1XAPBBcC+/qAncYng0IW2IcWUNpXOIsmr8Z7F0bfphQU+WDLnGlCHgsEyqPjIaHbI6qjInoYIdy8SF2QJZYK4Y6aeH/Msv6QJh2FI0K9L2H/RRbUUrFJKmDK09G9XqvLhVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEp6Zs/b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEp6Zs/b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6B11F000E9;
	Tue, 25 Aug 2026 10:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787652618;
	bh=Gc/RwX49RzhXZE0sl31padjbZCQIrL/qbFqg1Am65DQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hEp6Zs/bcUGJlqDp/EbOC2DmyXKUeOwUhZg/4RPSwxt8QqXEK/FGUyACEgsNTzJXs
	 niAxA0abeMUsTL+DPw7nttWvgJ9hamdm1dpoemM/YCzolyR84Z5oHw833iKT9x4KVi
	 2M+mzEGzQMAnIuPf9s1rPxU3cDR+4JXe4G1a+nXmjh64ExcCdfE8ykSeKaJBaEnFX3
	 2wtnt+5yUjHf8Qn5utrGqHhYyfqZAJOxHpYvIejwTfxx91lXFxnrxSeoIyXGJzV1Xx
	 xMJSIfpSh//nweywTXWK1CFY7JUwOj9F10yzkQ8yAkrmBgZSr9bvnsty3+yaxomh06
	 0lwzDmRBoAeyA==
Date: Tue, 25 Aug 2026 13:10:03 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>, Dev Jain <dev.jain@arm.com>,
	Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>, Lance Yang <lance.yang@linux.dev>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
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
Subject: Re: [PATCH 1/6] mm/gup: move gup_can_follow_protnone() to gup.c
Message-ID: <ao1p-3no7A4Rh6K3@kernel.org>
References: <20260823-uffd-vm-flags-v1-v1-0-3086981b33cf@kernel.org>
 <20260823-uffd-vm-flags-v1-v1-1-3086981b33cf@kernel.org>
 <a4650e75-ae01-418a-b695-f8bb15c5d7db@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4650e75-ae01-418a-b695-f8bb15c5d7db@kernel.org>

On Mon, Aug 24, 2026 at 04:42:56PM +0200, David Hildenbrand (Arm) wrote:
> On 8/23/26 14:17, Mike Rapoport (Microsoft) wrote:
> > gup_can_follow_protnone() is defined in include/linux/mm.h but only used
> > by mm/gup.c.
> > 
> > First, there is no reason to have it in already gigantic header.
> 
> Once upon a time there was a user in mm/huge_memory.c, in a beautifully named
> function called follow_trans_huge_pmd().
> 
> > 
> > Next, the upcoming refactoring of userfaultfd flags will make
> > gup_can_follow_protnone() depend on userfaultfd_k.h which would cause a
> > cyclic header dependency.
> > 
> > Move gup_can_follow_protnone() to mm/gup.c.
> > 
> > No functional change.
> > 
> > Assisted-by: copilot:claude-opus-5
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> 
> 
> [...]
> 
> >  typedef int (*pte_fn_t)(pte_t *pte, unsigned long addr, void *data);
> >  extern int apply_to_page_range(struct mm_struct *mm, unsigned long address,
> >  			       unsigned long size, pte_fn_t fn, void *data);
> > diff --git a/mm/gup.c b/mm/gup.c
> > index eb898ea1ee22..500e2aa99e48 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -633,6 +633,44 @@ static struct page *no_page_table(struct vm_area_struct *vma,
> >  	return NULL;
> >  }
> >  
> > +/*
> > + * Indicates whether GUP can follow a PROT_NONE mapped page, or whether
> > + * a (NUMA hinting or userfaultfd RWP) fault is required.
> > + */
> > +static inline bool gup_can_follow_protnone(const struct vm_area_struct *vma,
> > +					   unsigned int flags)
> 
> While at it, could switch to double-tab here.

Ok.
 
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> 
> -- 
> Cheers,
> 
> David

-- 
Sincerely yours,
Mike.
