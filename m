Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4101941B376;
	Fri, 27 Feb 2026 14:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772203589; cv=none; b=L+V7ru46y3w40T0+AM3Gu97vtocANfMhR71TQ0K7SKF7ek7iBLOe8o/H0t4HaPOQgwlwzDg7ip3V6Ywe1f0PDD60PJsFBgb8yyA5RRwmOkIuFe0RaJ9fhvRep8rRdcnSfUVyfEuonAp9RGh2CNYob4Kmih+H5NXQqxI4X6AYJtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772203589; c=relaxed/simple;
	bh=pyCgwrJ7kapj98sb1WhBxWc5AWVRM6mpu+pt02JG49o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmkVS/6oWny0ytC1sXGh+A1mQlw2B1RfsrtrOcT5EGIwoPnVPgo/o3qbq8QNNg+IFKABRUHW2xhrGS+8KqUzL4HuAPQ70kzTteoc3lyP1tx95Hu8arHJ8GGU0n21CU/8oKTpwkJ+qkwAn/idZt8wbgI0WNDgeFw5JH/g/Y5SIkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=C48u6fGI; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="C48u6fGI"
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 06DFEB2E0F;
	Fri, 27 Feb 2026 14:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1772203586;
	bh=Ifbx91T1EVW22r0wWKCJQbDbuWq+ff07mPFba4tUWaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C48u6fGIi6TakoiiyLCPZszKruRGU2YBmMYyVdsHmWQ4YHq37kxnUfjtSxRj5Mrcv
	 eAFQeCrkc9ZU33UtJsKXyXqCV0fI1s1tIOXVLYcuHDYrwYDdQdh4sP9kuQ6HsdhdQ5
	 7SfZFndBozlYu76CVf5I6k+6mOH5be2y1YUi2g7M=
Date: Fri, 27 Feb 2026 14:46:24 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Oscar Salvador <osalvador@suse.de>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, kernel-team@meta.com,
	Benjamin Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v3 3/5] mm: convert compaction to zone lock wrappers
Message-ID: <aaGuQFaCij5hvw4N@shell.ilvokhin.com>
References: <01729baf359e4c6612aead53f1fcb644f782d1de.1772129168.git.d@ilvokhin.com>
 <20260227004554.83555-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227004554.83555-1-sj@kernel.org>

On Thu, Feb 26, 2026 at 04:45:54PM -0800, SeongJae Park wrote:
> On Thu, 26 Feb 2026 18:26:20 +0000 Dmitry Ilvokhin <d@ilvokhin.com> wrote:
> 
> > Compaction uses compact_lock_irqsave(), which currently operates
> > on a raw spinlock_t pointer so it can be used for both zone->lock
> > and lruvec->lru_lock. Since zone lock operations are now wrapped,
> > compact_lock_irqsave() can no longer directly operate on a
> > spinlock_t when the lock belongs to a zone.
> > 
> > Split the helper into compact_zone_lock_irqsave() and
> > compact_lruvec_lock_irqsave(), duplicating the small amount of
> > shared logic. As there are only two call sites and both statically
> > know the lock type, this avoids introducing additional abstraction
> > or runtime dispatch in the compaction path.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> > ---
> >  mm/compaction.c | 33 ++++++++++++++++++++++++---------
> >  1 file changed, 24 insertions(+), 9 deletions(-)
> > 
> > diff --git a/mm/compaction.c b/mm/compaction.c
> > index 47b26187a5df..9f7997e827bd 100644
> > --- a/mm/compaction.c
> > +++ b/mm/compaction.c
> > @@ -503,19 +503,36 @@ static bool test_and_set_skip(struct compact_control *cc, struct page *page)
> >   *
> >   * Always returns true which makes it easier to track lock state in callers.
> >   */
> > -static bool compact_lock_irqsave(spinlock_t *lock, unsigned long *flags,
> > -						struct compact_control *cc)
> > -	__acquires(lock)
> > +static bool compact_zone_lock_irqsave(struct zone *zone,
> > +				      unsigned long *flags,
> > +				      struct compact_control *cc)
> > +__acquires(&zone->lock)
> 
> Nit.  Why don't you keep the indentation?
> 
> My impression based on below output is that mm code prefer indenting
> __acquires().
> 
>     $ git grep __acquires mm
>     mm/compaction.c:__acquires(&zone->_lock)
>     mm/compaction.c:__acquires(&lruvec->lru_lock)
>     mm/khugepaged.c:        __acquires(&khugepaged_mm_lock)
>     mm/userfaultfd.c:       __acquires(ptl1)
>     mm/userfaultfd.c:       __acquires(ptl2)
> 

Thanks for spotting it, will be fixed in v4.

> 
> Thanks,
> SJ
> 
> [...]
