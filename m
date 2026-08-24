Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B63B346E7A;
	Mon, 24 Aug 2026 08:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787559435; cv=none; b=JORIu3qqwkUjebGpa3RrOoXKqeaCvZfwZVczkEW+LFicZGK9VOAgBo7V6IZvYX7JM4XF3rnQxTAbt3HsQj+UpeOzzKh1cq4SS3/nOjlH9ERfK+Gq0d93zqPHR5fcGjv51+uXSpnthEPTuIFV6nY7q/cD8SRjqQT+tHra2KhTQgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787559435; c=relaxed/simple;
	bh=l5DE0vLKC2aO/UHzn1eUKYSOSLzkqDEzUDKrM/QvHwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ji206NvkeSBWidy/JWhzyRYbXxoITk8JMXhpPOskDVouZKFsAwEsrYQsTeW357IjFDXv2RN5bPKEM+ZqzEe2s++I6wzq2SGrkw0aMQLXnB/USpf8624kGFT0/sh4WamZXHgg31FUt/uk8SvCHJuFND3O15OuIIxTWOZ5GwkHvpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qpl6pTLo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qpl6pTLo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F411F000E9;
	Mon, 24 Aug 2026 08:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787559433;
	bh=IXaDWANMBlI65kh+v9rkRtQjLvm/PKZVB63CiqD6Ees=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qpl6pTLoaAeBpcbEKuwh7r8MjAtDrlHX9jbAvcFpcR3CrHgdYxXx4sNdOyT+5UBKY
	 hwZq5M/8DVldhkxcUcUBBVJpFFJx65vumAzWROkhZFaJiuN/Go9Oo5qBngNafk2Hnz
	 4Kxq6N+gG+DKLwsJ0rRHEZidN7GEYCsTMgChe8YBhRjImyKcBI3UrAtavVAVigyJLv
	 z676QZZTMwHGh3tA/ERm62yiT+TLykLWSMuKPn3ZFlO4phL6vWjYq5HA7PXoJyoZ/A
	 GP89f/3ADUV4wdxx07Q2m2351EcJIaNzyIUdQOg2KcUhJ+DF4PThf+Jgvs99hwVs8n
	 TfuPMAbNrQQ5Q==
Date: Mon, 24 Aug 2026 11:17:00 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@kernel.org,
	baolin.wang@linux.alibaba.com, baohua@kernel.org, dev.jain@arm.com,
	hughd@google.com, jannh@google.com, jgg@ziepe.ca,
	jhubbard@nvidia.com, corbet@lwn.net, liam@infradead.org,
	ljs@kernel.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	mhocko@suse.com, muchun.song@linux.dev, nico.pache@linux.dev,
	osalvador@suse.de, pfalcato@suse.de, peterx@redhat.com,
	ryan.roberts@arm.com, shakeel.butt@linux.dev,
	skhan@linuxfoundation.org, rostedt@goodmis.org, surenb@google.com,
	usama.arif@linux.dev, vbabka@kernel.org, ziy@nvidia.com,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] userfaultfd: collapse VM_UFFD_{MISSING,WP,MINOR,RWP}
 into single VM_UFFD
Message-ID: <aov9_DIHLHynm7tN@kernel.org>
References: <20260823-uffd-vm-flags-v1-v1-6-3086981b33cf@kernel.org>
 <20260824071126.41979-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824071126.41979-1-lance.yang@linux.dev>

Hi Lance, 

On Mon, Aug 24, 2026 at 03:11:26PM +0800, Lance Yang wrote:
> 
> On Sun, Aug 23, 2026 at 03:17:43PM +0300, Mike Rapoport (Microsoft) wrote:
> [...]
> >diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> >index 83587d34b189..193f6e65d875 100644
> >--- a/mm/userfaultfd.c
> >+++ b/mm/userfaultfd.c
> >@@ -50,10 +50,10 @@ struct mfill_state {
> > 	pmd_t *pmd;
> > };
> > 
> >-static bool anon_can_userfault(struct vm_area_struct *vma, vm_flags_t vm_flags)
> >+static bool anon_can_userfault(struct vm_area_struct *vma, unsigned int mode)
> > {
> > 	/* anonymous memory does not support MINOR mode */
> >-	if (vm_flags & VM_UFFD_MINOR)
> >+	if (mode & UFFD_MODE_MINOR)
> > 		return false;
> > 	return true;
> > }
> >@@ -462,7 +462,7 @@ static int mfill_copy_folio_locked(struct folio *folio, unsigned long src_addr)
> > }
> > 
> > #define MFILL_RETRY_STATE_VMA_FLAGS \
> >-	append_vma_flags(__VMA_UFFD_FLAGS, VMA_SHARED_BIT)
> >+	append_vma_flags(VMA_UFFD, VMA_SHARED_BIT)
> 
> Looks like this drops registration mode from the retry snapshot. Assume a
> shared shmem VMA is registered for MISSING and COPY reaches
> mfill_copy_folio_retry(). While locks are dropped, the same userfaultfd|
> can re-register the range for MINOR. VMA_UFFD, VM_SHARED, ops, file and
> pgoff all stay unchanged, so the old COPY can continue instead of
> returning -EAGAIN ... no?

Good catch, thanks!
 
> Maybe something like this?

I prefer to add mode to the retry_state:

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 193f6e65d875..a0377f7ecc69 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -471,6 +471,7 @@ static int mfill_copy_folio_locked(struct folio *folio, unsigned long src_addr)
  */
 struct mfill_retry_state {
 	const struct vm_uffd_ops *ops;
+	unsigned long mode;
 	struct file *file;
 	vma_flags_t flags;
 	pgoff_t pgoff;
@@ -482,6 +483,7 @@ static void mfill_retry_state_save(struct mfill_retry_state *s,
 	s->flags = vma_flags_and_mask(&vma->flags, MFILL_RETRY_STATE_VMA_FLAGS);
 	s->ops = vma_uffd_ops(vma);
 	s->pgoff = vma_start_pgoff(vma);
+	s->mode = uffd_mode(vma);
 
 	if (vma->vm_file)
 		s->file = get_file(vma->vm_file);
@@ -493,8 +495,9 @@ static bool mfill_retry_state_changed(struct mfill_retry_state *state,
 	vma_flags_t flags = vma_flags_and_mask(&vma->flags,
 					       MFILL_RETRY_STATE_VMA_FLAGS);
 
-	/* Have any UFFD flags (missing, WP, minor) changed? */
-	if (!vma_flags_same_pair(&state->flags, &flags))
+	/* UFFD registration mode or VMA sharing changed */
+	if (!vma_flags_same_pair(&state->flags, &flags) ||
+	    s->mode != uffd_mode(vma))
 		return true;
 
 	/* VMA type or effective uffd_ops changed while the lock was dropped */
 
> Cheers, Lance

-- 
Sincerely yours,
Mike.
