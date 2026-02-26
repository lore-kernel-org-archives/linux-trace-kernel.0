Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8747355F29;
	Thu, 26 Feb 2026 17:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772128516; cv=none; b=sg0WmsN/t50CKgS1CjzwjyH9aLPNRS6yV7q2lAn51TaPGiJHj9H3PDxY4umkyNBUdkccdzLgLVLBqraG1oGYw+/ph/tkzQqsE/OhJ0Y+1wX1tePGPnf8YgHQnI76C2oJeQUGsM695NrfgsrclEF+HobC5vpgWr6+KKhaZpFJl8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772128516; c=relaxed/simple;
	bh=1hEZeU/hT1jyKJd0X/RL5eJqLt4htVyC0mbRuVTZyKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/qejUpxmr1jVuVNAhyz/+Nw3Jxuv6tB+Wo3pysXJ9ikLHY2RaDjyenJhYN42KDEWSfgmsKwAFh9+CVZvn7+1bfJbusJUIxHuhR/Q1Jhn78CPAoxWLF6mnuckVEKFupy7ZOKzP9ZCXJKrIU+EPexd2gCkqD0IpKyc+wIwAx7uPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=2RHNxVtv; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="2RHNxVtv"
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 7CE69B2CB9;
	Thu, 26 Feb 2026 17:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1772128512;
	bh=n26Wbnp3l3vR8dz90LZIold6P91TJCToqADcCftfVoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=2RHNxVtva8HwJ7FaIWnZp6Yt1NGrDNHqnBR2rEXpPGHZoiZxHqeEXt4ZiiBE9um38
	 jZDDgBcsH0TK5JJY+MFhm54eAyQlY/ZNIR3lfuGaOX8fmuwGlXQZ/ok3VZQ7yqwFDi
	 3DqfRtRcGwfHjCw0V7gvMRm8Hl0iXme8KVRXyF4Y=
Date: Thu, 26 Feb 2026 17:55:11 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Oscar Salvador <osalvador@suse.de>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 1/4] mm: introduce zone lock wrappers
Message-ID: <aaCI_-bNm-YGGXI1@shell.ilvokhin.com>
References: <cover.1770821420.git.d@ilvokhin.com>
 <3826dd6dc55a9c5721ec3de85f019764a6cf3222.1770821420.git.d@ilvokhin.com>
 <20260225175105.7777c514@fedora>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225175105.7777c514@fedora>

On Wed, Feb 25, 2026 at 05:51:05PM -0500, Steven Rostedt wrote:
> On Wed, 11 Feb 2026 15:22:13 +0000
> Dmitry Ilvokhin <d@ilvokhin.com> wrote:
> 
> 
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
> 
> Have you thought about adding guards as well. It could make the code simpler:
> 
>   (Not tested)
> 
> #include <linux/cleanup.h>
> [..]
> 
> DEFINE_LOCK_GUARD_1(zonelock_irqsave, struct zone *,
> 		    zone_lock_irqsave(_T->lock, _T->flags),
> 		    zone_unlock_irqrestore(_T->lock, _T->flags),
> 		    unsigned long flags)
> DECLARE_LOCK_GUARD_1_ATTRS(zonelock_irqsave, __acquires(_T), __releases(*(struct zone ***)_T))
> #define class_zonelock_irqsave_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(zonelock_irqsave, _T)
> 
> DEFINE_LOCK_GUARD_1(zonelock_irq, struct zone *,
> 		    zone_lock_irq(_T->lock),
> 		    zone_unlock_irq(_T->lock))
> DECLARE_LOCK_GUARD_1_ATTRS(zonelock_irq, __acquires(_T), __releases(*(struct zone ***)_T))
> #define class_zonelock_irq_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(zonelock_irq, _T)
> 
> Then you could even remove the "flags" variables from the C code, and some goto unlocks.
> 

Thanks, Steve.

I like the idea: guards could indeed simplify parts of the
locking and reduce some of the explicit flags handling.

For this series, though, I'd prefer to keep the changes mostly
mechanical and focused on introducing the wrappers and tracepoints.
Converting to guards would make the transformation less mechanical
and potentially harder to review.

I'd be happy to follow up with a separate patch to explore adding
guards for zone locks and see whether we can simplify the existing
logic further.

> -- Steve
