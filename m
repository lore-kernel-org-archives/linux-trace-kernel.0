Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4EE3A0B1D;
	Tue, 24 Feb 2026 15:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771946291; cv=none; b=u1Q6WPTmwza7KRWJ9LMarnhfI0NuoVgNaFYXu/wCtNYuJTi9BIBK5sKl6ZXTMX9lN8978h+gQU3mfLGTLsEZZkAbfTfYoBjLFTvqnvi4YZhSr+TuBS6bGMrzj6kexRPLCH2CQ2cMvy7IOXOPquaBXevd/kIKSygKNF48IgA4/ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771946291; c=relaxed/simple;
	bh=ennJiAS/Gf3CMKnffwk705VVkJfkGLYHgNNI9T0rmyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4kVXsHtiGc9+tyU8MBEFqJbhKkOlw3spl2qbUAgsznedxxCQT8v3rx2aLD7tpIfLsrvkd/fy+9yrpDLYLatxtKtsnIwxF5regqaG2mBMk3ApKVSE5828TTJejn2/wbTyq9CFEF3RPqAxxWePkC450ycTCiKyVXni8FsxdjI7q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=TjYFzDnt; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="TjYFzDnt"
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 19550B2BA8;
	Tue, 24 Feb 2026 15:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1771946286;
	bh=vjbAdZH+HcILdXS95EbQM6Jm5jY1DudQ1+3DHISJ1DA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TjYFzDntZp50UvP3NtII4msWGYbwxHj/LdBYNJDkgknZzO2x7YgnkPEOJk0K2PNZD
	 NjeKtNqKpmkJN9o2WGX6gfta0wgyn1rfASSQWYb49P3Fzg7dfvrY9LhjwLKUxh451F
	 h4F06Z6WAEXz5H5HL+NvHHCjU1pdi/cbo+UsgbZw=
Date: Tue, 24 Feb 2026 15:18:04 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 1/4] mm: introduce zone lock wrappers
Message-ID: <aZ3BLKzhIIZvkbwL@shell.ilvokhin.com>
References: <cover.1770821420.git.d@ilvokhin.com>
 <3826dd6dc55a9c5721ec3de85f019764a6cf3222.1770821420.git.d@ilvokhin.com>
 <aZzWNM06gNYKDoQW@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZzWNM06gNYKDoQW@linux.dev>

On Mon, Feb 23, 2026 at 02:36:01PM -0800, Shakeel Butt wrote:
> On Wed, Feb 11, 2026 at 03:22:13PM +0000, Dmitry Ilvokhin wrote:
> > Add thin wrappers around zone lock acquire/release operations. This
> > prepares the code for future tracepoint instrumentation without
> > modifying individual call sites.
> > 
> > Centralizing zone lock operations behind wrappers allows future
> > instrumentation or debugging hooks to be added without touching
> > all users.
> > 
> > No functional change intended. The wrappers are introduced in
> > preparation for subsequent patches and are not yet used.
> > 
> > Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> > ---
> >  MAINTAINERS               |  1 +
> >  include/linux/zone_lock.h | 38 ++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 39 insertions(+)
> >  create mode 100644 include/linux/zone_lock.h
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index b4088f7290be..680c9ae02d7e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -16498,6 +16498,7 @@ F:	include/linux/pgtable.h
> >  F:	include/linux/ptdump.h
> >  F:	include/linux/vmpressure.h
> >  F:	include/linux/vmstat.h
> > +F:	include/linux/zone_lock.h
> >  F:	kernel/fork.c
> >  F:	mm/Kconfig
> >  F:	mm/debug.c
> > diff --git a/include/linux/zone_lock.h b/include/linux/zone_lock.h
> > new file mode 100644
> > index 000000000000..c531e26280e6
> > --- /dev/null
> > +++ b/include/linux/zone_lock.h
> > @@ -0,0 +1,38 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _LINUX_ZONE_LOCK_H
> > +#define _LINUX_ZONE_LOCK_H
> > +
> > +#include <linux/mmzone.h>
> > +#include <linux/spinlock.h>
> > +
> > +static inline void zone_lock_init(struct zone *zone)
> > +{
> > +	spin_lock_init(&zone->lock);
> > +}
> > +
> > +#define zone_lock_irqsave(zone, flags)				\
> > +do {								\
> > +	spin_lock_irqsave(&(zone)->lock, flags);		\
> > +} while (0)
> > +
> > +#define zone_trylock_irqsave(zone, flags)			\
> > +({								\
> > +	spin_trylock_irqsave(&(zone)->lock, flags);		\
> > +})
> 
> Any reason you used macros for above two and inlined functions for remaining?
>

The reason for using macros in those two cases is that they need to
modify the flags variable passed by the caller, just like
spin_lock_irqsave() and spin_trylock_irqsave() do. I followed the same
convention here.

If we used normal inline functions instead, we would need to pass a
pointer to flags, which would change the call sites and diverge from the
existing *_irqsave() locking pattern.

There is also a difference between zone_lock_irqsave() and
zone_trylock_irqsave() implementations: the former is implemented as a
do { } while (0) macro since it does not return a value, while the
latter uses a GCC extension in order to return the trylock result. This
matches spin_lock_* convention as well.

> > +
> > +static inline void zone_unlock_irqrestore(struct zone *zone, unsigned long flags)
> > +{
> > +	spin_unlock_irqrestore(&zone->lock, flags);
> > +}
> > +
> > +static inline void zone_lock_irq(struct zone *zone)
> > +{
> > +	spin_lock_irq(&zone->lock);
> > +}
> > +
> > +static inline void zone_unlock_irq(struct zone *zone)
> > +{
> > +	spin_unlock_irq(&zone->lock);
> > +}
> > +
> > +#endif /* _LINUX_ZONE_LOCK_H */
> > -- 
> > 2.47.3
> > 
