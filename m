Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC5A1E5B63;
	Wed, 25 Feb 2026 22:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772059876; cv=none; b=G3nvj2EWdptWuNcoY6VB0gzuExRilYdVMVGPw07xD85+WvydMwLEdliqTShnCR+6MLJCXmLIgY034OtdySxg41LTUnK14Xee9evpvuWC1aCgZ0nqST65G6d/8lIDUMLPcIypz6DS++jWjLm2kIf4mIODlS72WI5XieoiU8BHPtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772059876; c=relaxed/simple;
	bh=xfRFRyo44vG49OSOssSJ4CG8+ErTpbHSpJqE14IcduM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EaIuRk57zg6lj74Y0xR0O0bRBdV6SyJfmMzwM1l9ab8wxh0Z6kYNnyYRHPSjGLWLwlu1IbHvzGetxnBCyhu8vt5y7ApLt6492UocQSLZxdGxCVp0RXvWaOuOdm78y+3oB77hVdsdxl96XxmeENxZeJPpPGLOK9ddbR+cysqWCqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 4F7A91C74B;
	Wed, 25 Feb 2026 22:51:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 2D6B819;
	Wed, 25 Feb 2026 22:51:07 +0000 (UTC)
Date: Wed, 25 Feb 2026 17:51:05 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
 <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Brendan Jackman
 <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan
 <ziy@nvidia.com>, Oscar Salvador <osalvador@suse.de>, Qi Zheng
 <zhengqi.arch@bytedance.com>, Shakeel Butt <shakeel.butt@linux.dev>, Axel
 Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei
 Xu <weixugc@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH 1/4] mm: introduce zone lock wrappers
Message-ID: <20260225175105.7777c514@fedora>
In-Reply-To: <3826dd6dc55a9c5721ec3de85f019764a6cf3222.1770821420.git.d@ilvokhin.com>
References: <cover.1770821420.git.d@ilvokhin.com>
	<3826dd6dc55a9c5721ec3de85f019764a6cf3222.1770821420.git.d@ilvokhin.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2D6B819
X-Stat-Signature: 8gfyis76sfgdc1u14u6tppapitasde71
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19bcS51kdQMJLg4y+CWNN6mKgepRI8oF40=
X-HE-Tag: 1772059867-798157
X-HE-Meta: U2FsdGVkX1/tj9mqP/zexxSNbzfzJyNDn3Ikcoz9DM7IrcRLT4iJW9kifyj/zq12MlJmNIjaxAlYOyS3OVEskQGvSr6j2wOSQr4HauKmUod9p5RnvvAxrahOxlqk+oH4Ol5w6uws6FKwFTPR68+qweqED6rOryjCvuMJO2ZTATs92nH8W4R/Pp2qLAK2T2gz7rU1DQuMj9KTkr5PEKIAE3Dg4TqYHi5RHkwdlmYRJYSL6C+FSbZdN2YxvnZ+XXzK3T6KoJOVX0Se6kXSSy2fSWGEvLebKL+M3f1uz3BFWqVnjdOvNhVnNOm1AZfDO5LDRN1jNrbXoMR6wjybtI29GKMzZUrJXXUk3P3X6XVS5YFSysdNbNP41hAv7wez19mJ

On Wed, 11 Feb 2026 15:22:13 +0000
Dmitry Ilvokhin <d@ilvokhin.com> wrote:


> diff --git a/include/linux/zone_lock.h b/include/linux/zone_lock.h
> new file mode 100644
> index 000000000000..c531e26280e6
> --- /dev/null
> +++ b/include/linux/zone_lock.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_ZONE_LOCK_H
> +#define _LINUX_ZONE_LOCK_H
> +
> +#include <linux/mmzone.h>
> +#include <linux/spinlock.h>
> +
> +static inline void zone_lock_init(struct zone *zone)
> +{
> +	spin_lock_init(&zone->lock);
> +}
> +
> +#define zone_lock_irqsave(zone, flags)				\
> +do {								\
> +	spin_lock_irqsave(&(zone)->lock, flags);		\
> +} while (0)
> +
> +#define zone_trylock_irqsave(zone, flags)			\
> +({								\
> +	spin_trylock_irqsave(&(zone)->lock, flags);		\
> +})
> +
> +static inline void zone_unlock_irqrestore(struct zone *zone, unsigned long flags)
> +{
> +	spin_unlock_irqrestore(&zone->lock, flags);
> +}
> +
> +static inline void zone_lock_irq(struct zone *zone)
> +{
> +	spin_lock_irq(&zone->lock);
> +}
> +
> +static inline void zone_unlock_irq(struct zone *zone)
> +{
> +	spin_unlock_irq(&zone->lock);
> +}
> +
> +#endif /* _LINUX_ZONE_LOCK_H */

Have you thought about adding guards as well. It could make the code simpler:

  (Not tested)

#include <linux/cleanup.h>
[..]

DEFINE_LOCK_GUARD_1(zonelock_irqsave, struct zone *,
		    zone_lock_irqsave(_T->lock, _T->flags),
		    zone_unlock_irqrestore(_T->lock, _T->flags),
		    unsigned long flags)
DECLARE_LOCK_GUARD_1_ATTRS(zonelock_irqsave, __acquires(_T), __releases(*(struct zone ***)_T))
#define class_zonelock_irqsave_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(zonelock_irqsave, _T)

DEFINE_LOCK_GUARD_1(zonelock_irq, struct zone *,
		    zone_lock_irq(_T->lock),
		    zone_unlock_irq(_T->lock))
DECLARE_LOCK_GUARD_1_ATTRS(zonelock_irq, __acquires(_T), __releases(*(struct zone ***)_T))
#define class_zonelock_irq_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(zonelock_irq, _T)

Then you could even remove the "flags" variables from the C code, and some goto unlocks.

-- Steve
