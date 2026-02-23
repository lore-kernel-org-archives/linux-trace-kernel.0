Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB7F37B41A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Feb 2026 22:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771886183; cv=none; b=noaUY5WQRpdEgaMPztHxrpchO45Oplv03M+LQzeD2yY+GrPvCX8RJAho7Zhn3mJH0gyHdVoAN74QbEbcwLTJE+ozmyLqKG6PJz6QEw1Yx26X+9bjtMrp8FouuNLBs/+Wc+uYhI3mKdpZSnWeASSrqyUb1jPX+Pdz+qYrQE8/1ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771886183; c=relaxed/simple;
	bh=c/MpV82BwZq4fsF7sSBWV0E8/a0M5n/zUgz/nHjkPag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqUo1M0vhdyMKwRudCGDd+KcF/XYL3+ewbT5r7MiVW4tnRUcC7GMYCQIguAw4ufjXIDgHjuFrmBiEaXORc6vxvkzmJf+X1C9aP2b44MWfb2SrZy+Qz8/TFhM0SBE3lkt5n1hJ/VxWC+BZDbX0JVB4IV/n7VA3rPyD5BZQCgYFnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w7O1/gGx; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w7O1/gGx"
Date: Mon, 23 Feb 2026 14:36:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771886170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zDZJJyZ7IybQJkD08lIeKoohpnEfHBOokZpr1hipx2Q=;
	b=w7O1/gGxpf9KkaRXmd2zY7VV0wWYJo83dYPGj/+G+/IdNRODXsASEMfSMzbf6UqJzTJtXb
	uKsU3rGDFmM3JSX/ore6gYZl5pl71WTCFXVlR1ykXPUVrp2YAv27KiAG1cKfMRCgwlqUn8
	iltCqg+uxvPUp31GSbs0/+GFH+eO7js=
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
Message-ID: <aZzWNM06gNYKDoQW@linux.dev>
References: <cover.1770821420.git.d@ilvokhin.com>
 <3826dd6dc55a9c5721ec3de85f019764a6cf3222.1770821420.git.d@ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3826dd6dc55a9c5721ec3de85f019764a6cf3222.1770821420.git.d@ilvokhin.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 11, 2026 at 03:22:13PM +0000, Dmitry Ilvokhin wrote:
> Add thin wrappers around zone lock acquire/release operations. This
> prepares the code for future tracepoint instrumentation without
> modifying individual call sites.
> 
> Centralizing zone lock operations behind wrappers allows future
> instrumentation or debugging hooks to be added without touching
> all users.
> 
> No functional change intended. The wrappers are introduced in
> preparation for subsequent patches and are not yet used.
> 
> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> ---
>  MAINTAINERS               |  1 +
>  include/linux/zone_lock.h | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
>  create mode 100644 include/linux/zone_lock.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b4088f7290be..680c9ae02d7e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16498,6 +16498,7 @@ F:	include/linux/pgtable.h
>  F:	include/linux/ptdump.h
>  F:	include/linux/vmpressure.h
>  F:	include/linux/vmstat.h
> +F:	include/linux/zone_lock.h
>  F:	kernel/fork.c
>  F:	mm/Kconfig
>  F:	mm/debug.c
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

Any reason you used macros for above two and inlined functions for remaining?

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
> -- 
> 2.47.3
> 
