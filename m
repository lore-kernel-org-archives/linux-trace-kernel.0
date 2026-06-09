Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74883BA222;
	Tue,  9 Jun 2026 16:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781021796; cv=none; b=aLTTPCbaS7tx8ggLkqvSpH1/tCeAj96cfXSO0kLVVzsRinOe9ielE7a1TDG9TegQEc2xU4O0ybSLNvZ1Cck2vlTQsYOErk8ZmQ+RNN0yHwHg4AMeQ0sXEhf/OCIQ7iFrJWOaaPAJLMGTO1B7hIl/wE1O6sHIYoiyXtWPDxAHlts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781021796; c=relaxed/simple;
	bh=558L1ra+dBxaD/r4YWvIOQvdm4T/8f3GLfBJYj9OeXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYxlkQ3+vy3YXPFoFf7xt9Vr6WDiH6OS3YpnsKQ+YC/Z5phweCWjAEk6pesRwJX7uTBYcDWqaK31cnXxeZ/41YOIh/lGUAZL/SqHpPgSDbAZ0TpirBjF9y6emyF4RuzWL84BK+BEv0gRYZVEKZ/JwtkGA2tb5UzvKCZqV0BGAOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=KCMiFdDQ; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="KCMiFdDQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=99lfJJqgGV+EWW3BmhkNn6qfLnQ2f2pBi7n0sNfkhRc=; b=KCMiFdDQRjj3L4VP/YosTAJIHo
	A1HbCUZVuYN7QbDdovs+Eez4e7YWDN+MESTqcmSKS0X6xUE+/AB4Y5lJHiz4InUoPPj+XMC/hNkIt
	SioyR/IQr8KNLhMSRH3hkQYgLUjy0MRbm2DjaC0AvRXaMOmnFidXdYk7mFLsSOrzNMMOmQ/LJpl8i
	nuiqHmuYaSIWoHJjOT8sCdtQYwbS7cZgmqX5m7G9eEmq9xw7YOJ6gbnSImVGYELlJCN5W7MqHe6y8
	x+dP6G3HTloYyhhFNFNGEJlk+s/4eVl+CagKaZMtwcfdmNv+j22FgaAjBLqep+zJea+ZaVcfsyC2W
	5NT40grw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wWz75-008WX7-3A;
	Tue, 09 Jun 2026 16:15:40 +0000
Date: Tue, 9 Jun 2026 09:15:33 -0700
From: Breno Leitao <leitao@debian.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, "Liam R. Howlett" <liam@infradead.org>, lance.yang@linux.dev, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v9 2/6] mm/memory-failure: surface unhandlable kernel
 pages as -ENOTRECOVERABLE
Message-ID: <aig7jzwDHfVCxikl@gmail.com>
References: <20260609-ecc_panic-v9-0-432a74002e74@debian.org>
 <20260609-ecc_panic-v9-2-432a74002e74@debian.org>
 <174b8d76-5514-4942-af5d-c975ff95ee03@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174b8d76-5514-4942-af5d-c975ff95ee03@kernel.org>
X-Debian-User: leitao

On Tue, Jun 09, 2026 at 04:41:01PM +0200, David Hildenbrand (Arm) wrote:
> On 6/9/26 12:56, Breno Leitao wrote:
> > get_any_page() collapses every HWPoisonHandlable() rejection into a
> > single -EIO via the __get_hwpoison_page() -> -EBUSY -> shake_page()
> > -> retry path.  That is correct for the transient case (a userspace
> > folio briefly off LRU during migration or compaction, which a later
> > shake can drag back), but wrong for stable kernel-owned pages: slab,
> > page-table, large-kmalloc and PG_reserved pages will never become
> > HWPoisonHandlable(), so the retry loop is wasted work and the final
> > -EIO loses the "this is structurally unrecoverable" information.
> > memory_failure() then maps -EIO into MF_MSG_GET_HWPOISON, which the
> > panic-on-unrecoverable sysctl deliberately does not act on.
> > 
> > Introduce HWPoisonKernelOwned(), a small predicate that positively
> > identifies pages the hwpoison handler cannot recover from:
> > 
> >   HWPoisonKernelOwned(p, flags) :=
> >       !(MF_SOFT_OFFLINE && page_has_movable_ops(p)) &&
> >       (PageReserved(p) ||
> >        PageSlab(head) || PageTable(head) || PageLargeKmalloc(head))
> > 
> >   where head = compound_head(p).
> > 
> > PG_reserved is a per-page flag (PF_NO_COMPOUND) and is tested on the
> > page directly.  The slab, page-table and large-kmalloc page-type bits
> > are only stored on the head page, so those tests resolve the compound
> > head first, then re-read compound_head(page) afterwards: a concurrent
> > split or compound free that moves head invalidates the just-read flags
> > and the loop retries.  The lookup still takes no refcount, mirroring
> > the rest of get_any_page(); the recheck closes the common split race,
> > and a residual free->alloc->free in the same window can only mis-tag
> > a genuinely poisoned page, never reclassify a handlable one.
> > 
> > The MF_SOFT_OFFLINE / page_has_movable_ops() opt-out mirrors the
> > same exception in HWPoisonHandlable(): soft-offline is allowed to
> > migrate movable_ops pages even though they are not on the LRU, and
> > we must not pre-empt that with an unrecoverable verdict.
> > 
> > The list is intentionally not exhaustive.  vmalloc and kernel-stack
> > pages, for example, do not carry a page_type bit and would need a
> > different oracle; they keep going through the existing retry path
> > unchanged.  This is the smallest set we can identify with certainty
> > by page type.
> > 
> > Wire the helper into the top of get_any_page() to short-circuit
> > those pages before the retry loop runs.  On a hit, drop the caller's
> > MF_COUNT_INCREASED reference (if any) and return -ENOTRECOVERABLE
> > straight away.  Pages outside the helper's positive list still take
> > the existing retry path and return -EIO, leaving operator-visible
> > behaviour for those cases unchanged.
> > 
> > Extend the unhandlable-page pr_err() to fire for either errno and
> > update the get_hwpoison_page() kerneldoc to document the new return.
> > 
> > memory_failure() still folds every negative return into
> > MF_MSG_GET_HWPOISON via its existing "else if (res < 0)" branch, so
> > this patch on its own only changes the errno that soft_offline_page()
> > can propagate to its callers.  A follow-up wires -ENOTRECOVERABLE
> > through memory_failure() and reports MF_MSG_KERNEL for the
> > unrecoverable cases, which is what the
> > panic_on_unrecoverable_memory_failure sysctl observes.
> > 
> > Suggested-by: David Hildenbrand <david@kernel.org>
> > Suggested-by: Lance Yang <lance.yang@linux.dev>
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  mm/memory-failure.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 58 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index f4d3e6e20e13..eed9de387694 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -1325,6 +1325,46 @@ static inline bool HWPoisonHandlable(struct page *page, unsigned long flags)
> >  	return PageLRU(page) || is_free_buddy_page(page);
> >  }
> >  
> > +/*
> > + * Positive identification of pages the hwpoison handler cannot recover.
> > + * These page types are owned by kernel internals (no userspace mapping
> > + * to unmap, no file mapping to invalidate, no migration target), so the
> > + * shake_page() / retry loop in get_any_page() can never turn them into
> > + * something HWPoisonHandlable() will accept.  Short-circuit them to
> > + * -ENOTRECOVERABLE so callers can panic on operator request instead of
> > + * spinning through retries that exit as a transient-looking -EIO.
> > + *
> > + * The MF_SOFT_OFFLINE / page_has_movable_ops() opt-out mirrors
> > + * HWPoisonHandlable(): soft-offline is allowed to migrate movable_ops
> > + * pages even though they are not on the LRU.
> > + */
> > +static inline bool HWPoisonKernelOwned(struct page *page, unsigned long flags)
> > +{
> > +	struct page *head;
> > +
> > +	if ((flags & MF_SOFT_OFFLINE) && page_has_movable_ops(page))
> > +		return false;
> > +
> 
> On a second look: Do we really need that? The page types below never support
> migration. So I guess that check is not required?
> 
> Apart from that, looks good with two comments:
> 
> a) HWPoisonKernelOwned: this is not the common style for us to name functions.
> 
> is_kernel_owned_page() or sth like that would do.

Ack, I will rename it is_kernel_owned_page()

In my defence, most of the functions similar to HWPoisonKernelOwned()
has this name format, and I got this discussion earlier (with Lance?
I think). Here are the similar function names in that file:

 * HWPoisonHandlable
 * PageHWPoisonTakenOff()
 * SetPageHWPoisonTakenOff

I will update in the new version.

> b) The function doc can likely be simplified a bit. No need to mention the
> short-circuit stuff, for example, IMHO.

Ack

Thanks for the review,
--breno
