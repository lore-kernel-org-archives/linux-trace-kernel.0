Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E5421771C;
	Fri, 27 Feb 2026 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772197565; cv=none; b=X4LUaGRZcFBR1SRb1za2tlCGtW3u4GLVoDSREzn9KPcy29W94TM0X3y+Pdi7MwQSTnS6BauOJflBMGD5NKuV8B0IwJQ2CyLYU4YfaD2VS2u8a8So0nxPt4oDW6aWQBzNERACGcy9eip8OIx7AipFSssA35UJSzqnw7TJ0wvnJXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772197565; c=relaxed/simple;
	bh=Fi5hexcsnAc5PF0tDcP//YWBYCKyWu7MVrAyuunYgRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqWOaj/L2i6uIrr0cwxVgXCo8ZbV9SxRvS+vICIB7uwFwFsb0WmJ7DqI2VuPTxMv7lBV82r1xt73lpw8lKO7PwK3tJWIL9vT/RZNDhqz+cWMGISlOavOwv+XRgjZb5I2ryw2uYxAbp+OuPfMCp4ofktQP+BOrBF/2dBJ/n0RyMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=fabxRk5j; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="fabxRk5j"
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id AF3A4B2DEB;
	Fri, 27 Feb 2026 13:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1772197562;
	bh=kFPcmXa3TYJ9a+ZatJmYfl714K9Z9gwrrVFBHqhQv2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fabxRk5jF/Q/JG1+ocNkMgBf91sfzczJhGM3o0kjghaJ1n/QylUZQMESyBBa0UvFD
	 g7EsxF3jkoSo0lnu/3ngvWkFv+dYHw50xqtbS/XcePqmmJLLUcAsZKnsFYZoQCHVPX
	 nJkRoSKIPktk0xJIO84YpLx3wMaDeMt9gO6+W6SY=
Date: Fri, 27 Feb 2026 13:06:00 +0000
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
Subject: Re: [PATCH v3 1/5] mm: introduce zone lock wrappers
Message-ID: <aaGWuPxfAMeHSKL1@shell.ilvokhin.com>
References: <5bcc39cd3a227944d0fbe75ff86cdac92b38d4ca.1772129168.git.d@ilvokhin.com>
 <20260227003140.82789-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227003140.82789-1-sj@kernel.org>

On Thu, Feb 26, 2026 at 04:31:39PM -0800, SeongJae Park wrote:
> On Thu, 26 Feb 2026 18:26:18 +0000 Dmitry Ilvokhin <d@ilvokhin.com> wrote:
> 
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
> > Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> > ---
> >  MAINTAINERS               |  1 +
> >  include/linux/zone_lock.h | 38 ++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 39 insertions(+)
> >  create mode 100644 include/linux/zone_lock.h
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 55af015174a5..61e3d1f5bf43 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -16680,6 +16680,7 @@ F:	include/linux/pgtable.h
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
> 
> I'm bit worried if I will think this as a file for another general locking, not
> the mm specific one.  I hence think renaming it to more clearly saying the
> fact, say, mmzone_lock.h, might be less confusing.  Or, putting things in
> mmzone.h might also be an option?  What do you think?

Thanks for the feedback, SJ.

Good point. I agree the current name looks too generic. Putting it into
mmzone.h would further overload that header, so renaming zone_lock.h to
mmzone_lock.h seems like the clearest option.

I'll make that change in v4.

> 
> 
> Thanks,
> SJ
> 
> [...]
