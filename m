Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0A23A63E7;
	Tue, 24 Feb 2026 15:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771948245; cv=none; b=B1IPORDcB48uWiYobGo6R+RpVB0gMF99MdqSGfvklQ1hKkf7FjsuljD04kqH4X5C4JyKmM8RKD0tdSMbaE9TmJL7SetaSNGjsFl0EAJox9h4HREFKxWHEGLkRWUbRwHa3Ii2O0g0/G0qYTqz6I250szmKN10s5/40JziNETZKwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771948245; c=relaxed/simple;
	bh=H3aQ95gTp6Y7Yb/KK4Q+CYpvZEeW3k+/vZSyRcXJvRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvZEIx5U2xzOy9IGO6ThzEGyxXauY7C9wyE8ydEzm9KKBuV0KA7QcUGhZzMU6oYvWer+7ozoEa/sn3ukmlDIAiOGxP6lLJsDpMKeh2DOVd/j7SOZFk4Le5gfk6Pqy/0uXhR0QfZU9U2sn9EZYtu6vnU+poKYynn+FwlFvtzRjhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=aNEnycGi; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="aNEnycGi"
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id E929EB2BBD;
	Tue, 24 Feb 2026 15:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1771948242;
	bh=Afmea4/5yCr+RWfrWvynSjvo68B8NHavl3Ss2MT9/VQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aNEnycGipuTvB2eFYUNi+YkjU7B1iN2zSAv5L2GpcFd4CIkpEfhb2xvGYXuJLJ4T5
	 H68tjkaI9ypOxNFtEqKRUfIN6qN3VyZvOUvCF70KRM1KYbJTEE4ZX/zTlI5MWMJ5hG
	 KNdFnNRD+v/8PyWc+lCMPO1pp1WLhsioXMoBUIRA=
Date: Tue, 24 Feb 2026 15:50:40 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	kernel-team@meta.com, Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Oscar Salvador <osalvador@suse.de>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>
Subject: Re: [PATCH 3/4] mm: convert compaction to zone lock wrappers
Message-ID: <aZ3I0ADTAdCN6UmN@shell.ilvokhin.com>
References: <cover.1770821420.git.d@ilvokhin.com>
 <3462b7fd26123c69ccdd121a894da14bbfafdd9d.1770821420.git.d@ilvokhin.com>
 <74fc1f28-b77e-4b9c-b208-51babae9d18e@amd.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74fc1f28-b77e-4b9c-b208-51babae9d18e@amd.com>

On Fri, Feb 20, 2026 at 01:10:05PM -0600, Cheatham, Benjamin wrote:
> On 2/11/2026 9:22 AM, Dmitry Ilvokhin wrote:
> > Compaction uses compact_lock_irqsave(), which currently operates
> > on a raw spinlock_t pointer so that it can be used for both
> > zone->lock and lru_lock. Since zone lock operations are now wrapped,
> > compact_lock_irqsave() can no longer operate directly on a spinlock_t
> > when the lock belongs to a zone.
> > 
> > Introduce struct compact_lock to abstract the underlying lock type. The
> > structure carries a lock type enum and a union holding either a zone
> > pointer or a raw spinlock_t pointer, and dispatches to the appropriate
> > lock/unlock helper.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> > ---
> >  mm/compaction.c | 108 +++++++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 89 insertions(+), 19 deletions(-)
> > 
> > diff --git a/mm/compaction.c b/mm/compaction.c
> > index 1e8f8eca318c..1b000d2b95b2 100644
> > --- a/mm/compaction.c
> > +++ b/mm/compaction.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/page_owner.h>
> >  #include <linux/psi.h>
> >  #include <linux/cpuset.h>
> > +#include <linux/zone_lock.h>
> >  #include "internal.h"
> >  
> >  #ifdef CONFIG_COMPACTION
> > @@ -493,6 +494,65 @@ static bool test_and_set_skip(struct compact_control *cc, struct page *page)
> >  }
> >  #endif /* CONFIG_COMPACTION */
> >  
> > +enum compact_lock_type {
> > +	COMPACT_LOCK_ZONE,
> > +	COMPACT_LOCK_RAW_SPINLOCK,
> > +};
> > +
> > +struct compact_lock {
> > +	enum compact_lock_type type;
> > +	union {
> > +		struct zone *zone;
> > +		spinlock_t *lock; /* Reference to lru lock */
> > +	};
> > +};
> > +
> > +static bool compact_do_zone_trylock_irqsave(struct zone *zone,
> > +					    unsigned long *flags)
> > +{
> > +	return zone_trylock_irqsave(zone, *flags);
> > +}
> > +
> > +static bool compact_do_raw_trylock_irqsave(spinlock_t *lock,
> > +					   unsigned long *flags)
> > +{
> > +	return spin_trylock_irqsave(lock, *flags);
> > +}
> > +
> > +static bool compact_do_trylock_irqsave(struct compact_lock lock,
> > +				       unsigned long *flags)
> > +{
> > +	if (lock.type == COMPACT_LOCK_ZONE)
> > +		return compact_do_zone_trylock_irqsave(lock.zone, flags);
> > +
> > +	return compact_do_raw_trylock_irqsave(lock.lock, flags);
> > +}
> 
> Nit: You could remove the helpers above and just do the calls directly in this function, though
> it would remove the parity with the compact helpers. compact_do_lock_irqsave() helpers can stay
> since they have the __acquires() annotations.

Yes, I agree, there is no much value in this wrappers, will remove them,
thanks!

> > +
> > +static void compact_do_zone_lock_irqsave(struct zone *zone,
> > +					 unsigned long *flags)
> > +__acquires(zone->lock)
> > +{
> > +	zone_lock_irqsave(zone, *flags);
> > +}
> > +
> > +static void compact_do_raw_lock_irqsave(spinlock_t *lock,
> > +					unsigned long *flags)
> > +__acquires(lock)
> > +{
> > +	spin_lock_irqsave(lock, *flags);
> > +}
> > +
> > +static void compact_do_lock_irqsave(struct compact_lock lock,
> > +				    unsigned long *flags)
> > +{
> > +	if (lock.type == COMPACT_LOCK_ZONE) {
> > +		compact_do_zone_lock_irqsave(lock.zone, flags);
> > +		return;
> > +	}
> > +
> > +	return compact_do_raw_lock_irqsave(lock.lock, flags);
> 
> You don't need the return statement here (and you shouldn't be returning a value at all).

Yes, agree, will fix in v2.

> 
> It may be cleaner to just do an if-else statement here instead.
> 
> > +}
> > +
> >  /*
> >   * Compaction requires the taking of some coarse locks that are potentially
> >   * very heavily contended. For async compaction, trylock and record if the
> > @@ -502,19 +562,19 @@ static bool test_and_set_skip(struct compact_control *cc, struct page *page)
> >   *
> >   * Always returns true which makes it easier to track lock state in callers.
> >   */
> > -static bool compact_lock_irqsave(spinlock_t *lock, unsigned long *flags,
> > -						struct compact_control *cc)
> > -	__acquires(lock)
> > +static bool compact_lock_irqsave(struct compact_lock lock,
> > +				 unsigned long *flags,
> > +				 struct compact_control *cc)
> >  {
> >  	/* Track if the lock is contended in async mode */
> >  	if (cc->mode == MIGRATE_ASYNC && !cc->contended) {
> > -		if (spin_trylock_irqsave(lock, *flags))
> > +		if (compact_do_trylock_irqsave(lock, flags))
> >  			return true;
> >  
> >  		cc->contended = true;
> >  	}
> >  
> > -	spin_lock_irqsave(lock, *flags);
> > +	compact_do_lock_irqsave(lock, flags);
> >  	return true;
> >  }
> >  
> > @@ -530,11 +590,13 @@ static bool compact_lock_irqsave(spinlock_t *lock, unsigned long *flags,
> >   * Returns true if compaction should abort due to fatal signal pending.
> >   * Returns false when compaction can continue.
> >   */
> > -static bool compact_unlock_should_abort(spinlock_t *lock,
> > -		unsigned long flags, bool *locked, struct compact_control *cc)
> > +static bool compact_unlock_should_abort(struct zone *zone,
> > +					unsigned long flags,
> > +					bool *locked,
> > +					struct compact_control *cc)
> >  {
> >  	if (*locked) {
> > -		spin_unlock_irqrestore(lock, flags);
> > +		zone_unlock_irqrestore(zone, flags);
> 
> I would move this (and other wrapper changes below that don't use compact_*) to the last patch. I understand you
> didn't change it due to location but I would argue it isn't really relevant to what's being added in this patch
> and fits better in the last.

Thanks for the suggestion. Totally makes sense to me, will do in v2 as well.

> 
> >  		*locked = false;
> >  	}
> >  
> > @@ -582,9 +644,8 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
> >  		 * contention, to give chance to IRQs. Abort if fatal signal
> >  		 * pending.
> >  		 */
> > -		if (!(blockpfn % COMPACT_CLUSTER_MAX)
> > -		    && compact_unlock_should_abort(&cc->zone->lock, flags,
> > -								&locked, cc))
> > +		if (!(blockpfn % COMPACT_CLUSTER_MAX) &&
> > +		    compact_unlock_should_abort(cc->zone, flags, &locked, cc))
> >  			break;
> >  
> >  		nr_scanned++;
> > @@ -613,8 +674,12 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
> >  
> >  		/* If we already hold the lock, we can skip some rechecking. */
> >  		if (!locked) {
> > -			locked = compact_lock_irqsave(&cc->zone->lock,
> > -								&flags, cc);
> > +			struct compact_lock zol = {
> > +				.type = COMPACT_LOCK_ZONE,
> > +				.zone = cc->zone,
> > +			};
> > +
> > +			locked = compact_lock_irqsave(zol, &flags, cc);
> >  
> >  			/* Recheck this is a buddy page under lock */
> >  			if (!PageBuddy(page))
> > @@ -649,7 +714,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
> >  	}
> >  
> >  	if (locked)
> > -		spin_unlock_irqrestore(&cc->zone->lock, flags);
> > +		zone_unlock_irqrestore(cc->zone, flags);
> >  
> >  	/*
> >  	 * Be careful to not go outside of the pageblock.
> > @@ -1157,10 +1222,15 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
> >  
> >  		/* If we already hold the lock, we can skip some rechecking */
> >  		if (lruvec != locked) {
> > +			struct compact_lock zol = {
> > +				.type = COMPACT_LOCK_RAW_SPINLOCK,
> > +				.lock = &lruvec->lru_lock,
> > +			};
> > +
> >  			if (locked)
> >  				unlock_page_lruvec_irqrestore(locked, flags);
> >  
> > -			compact_lock_irqsave(&lruvec->lru_lock, &flags, cc);
> > +			compact_lock_irqsave(zol, &flags, cc);
> >  			locked = lruvec;
> >  
> >  			lruvec_memcg_debug(lruvec, folio);
> > @@ -1555,7 +1625,7 @@ static void fast_isolate_freepages(struct compact_control *cc)
> >  		if (!area->nr_free)
> >  			continue;
> >  
> > -		spin_lock_irqsave(&cc->zone->lock, flags);
> > +		zone_lock_irqsave(cc->zone, flags);
> >  		freelist = &area->free_list[MIGRATE_MOVABLE];
> >  		list_for_each_entry_reverse(freepage, freelist, buddy_list) {
> >  			unsigned long pfn;
> > @@ -1614,7 +1684,7 @@ static void fast_isolate_freepages(struct compact_control *cc)
> >  			}
> >  		}
> >  
> > -		spin_unlock_irqrestore(&cc->zone->lock, flags);
> > +		zone_unlock_irqrestore(cc->zone, flags);
> >  
> >  		/* Skip fast search if enough freepages isolated */
> >  		if (cc->nr_freepages >= cc->nr_migratepages)
> > @@ -1988,7 +2058,7 @@ static unsigned long fast_find_migrateblock(struct compact_control *cc)
> >  		if (!area->nr_free)
> >  			continue;
> >  
> > -		spin_lock_irqsave(&cc->zone->lock, flags);
> > +		zone_lock_irqsave(cc->zone, flags);
> >  		freelist = &area->free_list[MIGRATE_MOVABLE];
> >  		list_for_each_entry(freepage, freelist, buddy_list) {
> >  			unsigned long free_pfn;
> > @@ -2021,7 +2091,7 @@ static unsigned long fast_find_migrateblock(struct compact_control *cc)
> >  				break;
> >  			}
> >  		}
> > -		spin_unlock_irqrestore(&cc->zone->lock, flags);
> > +		zone_unlock_irqrestore(cc->zone, flags);
> >  	}
> >  
> >  	cc->total_migrate_scanned += nr_scanned;
> 
