Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB132C859;
	Thu, 26 Feb 2026 17:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772127923; cv=none; b=gMptbzlcK8qKcRPfwEKp/YUObPFsOs0GQAG+h+hZ3znhLpTLyPI2FfqW0qG07sGR6YtGvmbXdlBN+t0ftS1QNESnm4I0FAYABBlLuBc8X3HYNyqcfeEcf0Y/C8kWcGLRagY6RqzV7BY/5ueYup+jo3g/Hadg7c87CLTSfNdohrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772127923; c=relaxed/simple;
	bh=unn/sjX4F2jPw0WpfcpNJXKnNATRIN8KQyYg4Wq0E3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SaU1/uyOprwG+zZzv/ij2BFrHVna/TIQ4QaOblDyOXbYK6RSgOBD6qSjgr1CHYgdtdq1P6SWgNej9zzEcIw8VWDxiOoYEA4NCfHT/LiMAAhRhghVlOh9VQR6gNreJvgSF/qZLPMFP+fGL5gb623xURToR0yegdnHlUapxgIFn50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=XykilkVd; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="XykilkVd"
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id AFFD7B2CB4;
	Thu, 26 Feb 2026 17:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1772127919;
	bh=7itAp3Hnu5FQvNWR3bqYNG7oBmnjq8V66kLCXadRGQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XykilkVdm3dqUbRzNdGsTWGQJOPcDREWG1rINi0v4L67XgdIVYMR6fvXN9aBxFzCE
	 SSr/CZRSiny0EqWgtjql7ZYVsC1D/OQmJPOxW+xXNQiknqoceSR+sLFcR7lzlDZEgR
	 49w05mVSKhnWffrr01pxuNy3mfbayzuczT636xHM=
Date: Thu, 26 Feb 2026 17:45:18 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
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
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	kernel-team@meta.com, Benjamin Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v2 3/4] mm: convert compaction to zone lock wrappers
Message-ID: <aaCGrl96pD-0_ts4@shell.ilvokhin.com>
References: <cover.1772030186.git.d@ilvokhin.com>
 <9710c3448c6c984164c93d7c6c0283e06ff987bf.1772030186.git.d@ilvokhin.com>
 <20260225121252.7c6519a857c1a8c56ba5206f@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225121252.7c6519a857c1a8c56ba5206f@linux-foundation.org>

On Wed, Feb 25, 2026 at 12:12:52PM -0800, Andrew Morton wrote:
> On Wed, 25 Feb 2026 14:43:05 +0000 Dmitry Ilvokhin <d@ilvokhin.com> wrote:
> 
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
> 
> It's regrettable that adds overhead - increased .text, increased
> instructions.
> 
> Thing is, compact_lock_irqsave() has only two callsites.  One knows
> that it's dealing with the zone lock, the other knows that it's dealing
> with the lruvec lock.
> 
> Would it not be simpler and more efficient to copy/paste/edit two
> versions of compact_lock_irqsave()?  A compact_zone_lock_irqsave() and a
> compact_lruvec_lock_irqsave()?
>

Thanks for the feedback, Andrew.

My initial goal was to reduce code duplication by keeping the logic
centralized, but your rationale makes sense. Given that there are only
two call sites and both statically know the lock type, splitting the
helper avoids unnecessary abstraction.

I'll introduce compact_zone_lock_irqsave() and
compact_lruvec_lock_irqsave() in v3.
