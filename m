Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD7615E97
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Feb 2026 19:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772132893; cv=none; b=cTcnvMTv+srjLVeST4nm5pcfFRK8zYHEAyuvWV7EmYtCJPrT1VmtlvPqrMS1nrRCcOGYeOvy7jFA+XSU9YyfHNiI1L7avhvrY/m7h1aPfjIXOj/qn3ofthz8Tgzpnd50Y2DdTne3Hs56UYYZCb6OxMAOWCyhyKwydFQqNoOHZ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772132893; c=relaxed/simple;
	bh=QlUCFGmt40Do3inzQMkNE/maW8Tvo1t9wA1vJXS2KaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpGWc/YEZwkok2WuYvQrPLKwHq1b4oA6VFWGPW/ZK8btHbrVKkvSML4Qw/XTKo4G15eHGsXLlBxXynksOdaGl1SbCI4DUD/xjT6c5xj8EX7Pyv0e36Xu9AyRKsMrT3Kj2Q6/W5Tl5c4UU7Nrq2QMZq9+itKlwkeX7/qFQ09tgW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xcdCIWPN; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xcdCIWPN"
Date: Thu, 26 Feb 2026 11:07:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772132884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qnz04KoSeLYWXnrsOC3JNgCNE8W9yeAASjRrer+Hk78=;
	b=xcdCIWPNB2YdRrnVuyylqSjUcwyXHjxniab/BF//SgB52TDmBLqxS5u6NpYGv6dxTyUZ6H
	2X1k/zbLJx+UdJWHwr2tYqx2+ZxmRY0jNduR7EBdi0Pno3q/Kg7PwpEKLuEsl/sD8OuUke
	2x2VKs+e+YmwAFVRCNKiF2HsHvZfxKs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Brendan Jackman <jackmanb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Oscar Salvador <osalvador@suse.de>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, kernel-team@meta.com, 
	Benjamin Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v3 3/5] mm: convert compaction to zone lock wrappers
Message-ID: <aaCZ6Kmi71liz7K5@linux.dev>
References: <cover.1772129168.git.d@ilvokhin.com>
 <01729baf359e4c6612aead53f1fcb644f782d1de.1772129168.git.d@ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01729baf359e4c6612aead53f1fcb644f782d1de.1772129168.git.d@ilvokhin.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 26, 2026 at 06:26:20PM +0000, Dmitry Ilvokhin wrote:
> Compaction uses compact_lock_irqsave(), which currently operates
> on a raw spinlock_t pointer so it can be used for both zone->lock
> and lruvec->lru_lock. Since zone lock operations are now wrapped,
> compact_lock_irqsave() can no longer directly operate on a
> spinlock_t when the lock belongs to a zone.
> 
> Split the helper into compact_zone_lock_irqsave() and
> compact_lruvec_lock_irqsave(), duplicating the small amount of
> shared logic. As there are only two call sites and both statically
> know the lock type, this avoids introducing additional abstraction
> or runtime dispatch in the compaction path.
> 
> No functional change intended.
> 
> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

