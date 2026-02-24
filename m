Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B0B265CC2
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Feb 2026 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771947080; cv=none; b=BfAfCCpSxdSd3fZi04eZHLMPkFSun2LVZpqJemOj4qz/6Lq6b1pctt8J1bPwHJlnBujWS2rU+SctsRXnzn3L0xS78ENRWHfpgArML6mOvvjf7G239GSwTxZ2WbZiYKPs4LWm2Quqli0K2Hp7LKKdSAJ3WHouPaeuPthNzlJAGHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771947080; c=relaxed/simple;
	bh=M9lnUUpFWY21hKwlJa0JlSvTqTxhj7/geUpVToaKRVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R7EzFj1xgQY3026fHgcBfdKhXDtvU3nIKHDPtksr/JQIP98UmmjMvyZwB+MLGGjj+/as5/dXyCmULG823Qd8QrYariWLDLlAK8ziF+QM7427sfEymL8nliawZIPDJHMoT5Ap+ighRJfT4uMuu2PTNEEoH7Rk8pkYcKgX8SoVVog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vPSKdZY5; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vPSKdZY5"
Date: Tue, 24 Feb 2026 07:30:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771947067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R+yfrV5RKBFEGAKtXVj/llMLh9I8k1XehmuxgjcMXfs=;
	b=vPSKdZY52nwmTjOayDoBACsDYtj6IQTSESDQ7/IEDYJb+Gj9DMzrniJmfcGumIi8gLxOCc
	1rvH45wBIVsApNtqMUVjbxdXlEFwcdF1L1OQTL1xif5r9BZkAaHhh6zW3Reink/8O87eZ6
	IpTrziHmHin7T8RyfqQXruhmifbn9R8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Oscar Salvador <osalvador@suse.de>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-cxl@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 1/4] mm: introduce zone lock wrappers
Message-ID: <aZ3EE4JVDghZSq59@linux.dev>
References: <cover.1770821420.git.d@ilvokhin.com>
 <3826dd6dc55a9c5721ec3de85f019764a6cf3222.1770821420.git.d@ilvokhin.com>
 <aZzWNM06gNYKDoQW@linux.dev>
 <aZ3BLKzhIIZvkbwL@shell.ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ3BLKzhIIZvkbwL@shell.ilvokhin.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 24, 2026 at 03:18:04PM +0000, Dmitry Ilvokhin wrote:
> On Mon, Feb 23, 2026 at 02:36:01PM -0800, Shakeel Butt wrote:
> > On Wed, Feb 11, 2026 at 03:22:13PM +0000, Dmitry Ilvokhin wrote:
> > > Add thin wrappers around zone lock acquire/release operations. This
> > > prepares the code for future tracepoint instrumentation without
> > > modifying individual call sites.
> > > 
> > > Centralizing zone lock operations behind wrappers allows future
> > > instrumentation or debugging hooks to be added without touching
> > > all users.
> > > 
> > > No functional change intended. The wrappers are introduced in
> > > preparation for subsequent patches and are not yet used.
> > > 
> > > Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> > > ---
> > >  MAINTAINERS               |  1 +
> > >  include/linux/zone_lock.h | 38 ++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 39 insertions(+)
> > >  create mode 100644 include/linux/zone_lock.h
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index b4088f7290be..680c9ae02d7e 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -16498,6 +16498,7 @@ F:	include/linux/pgtable.h
> > >  F:	include/linux/ptdump.h
> > >  F:	include/linux/vmpressure.h
> > >  F:	include/linux/vmstat.h
> > > +F:	include/linux/zone_lock.h
> > >  F:	kernel/fork.c
> > >  F:	mm/Kconfig
> > >  F:	mm/debug.c
> > > diff --git a/include/linux/zone_lock.h b/include/linux/zone_lock.h
> > > new file mode 100644
> > > index 000000000000..c531e26280e6
> > > --- /dev/null
> > > +++ b/include/linux/zone_lock.h
> > > @@ -0,0 +1,38 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#ifndef _LINUX_ZONE_LOCK_H
> > > +#define _LINUX_ZONE_LOCK_H
> > > +
> > > +#include <linux/mmzone.h>
> > > +#include <linux/spinlock.h>
> > > +
> > > +static inline void zone_lock_init(struct zone *zone)
> > > +{
> > > +	spin_lock_init(&zone->lock);
> > > +}
> > > +
> > > +#define zone_lock_irqsave(zone, flags)				\
> > > +do {								\
> > > +	spin_lock_irqsave(&(zone)->lock, flags);		\
> > > +} while (0)
> > > +
> > > +#define zone_trylock_irqsave(zone, flags)			\
> > > +({								\
> > > +	spin_trylock_irqsave(&(zone)->lock, flags);		\
> > > +})
> > 
> > Any reason you used macros for above two and inlined functions for remaining?
> >
> 
> The reason for using macros in those two cases is that they need to
> modify the flags variable passed by the caller, just like
> spin_lock_irqsave() and spin_trylock_irqsave() do. I followed the same
> convention here.
> 
> If we used normal inline functions instead, we would need to pass a
> pointer to flags, which would change the call sites and diverge from the
> existing *_irqsave() locking pattern.
> 
> There is also a difference between zone_lock_irqsave() and
> zone_trylock_irqsave() implementations: the former is implemented as a
> do { } while (0) macro since it does not return a value, while the
> latter uses a GCC extension in order to return the trylock result. This
> matches spin_lock_* convention as well.
> 

Cool, thanks for the explanation.
