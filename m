Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7900D27A10F
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Feb 2026 21:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772141527; cv=none; b=eIsXNTh/l4C7ZFGXVnZa+QyPr7J8geNN31KF8Jqv+2Q4Q+MPxs0WIW1pkVJupnYjlPIkFqcQWiNZpwgtov2ZSC1whJNY1+C0DszMqQI7cjkya+BT4tjXEKc6sjicQYGp4pPRAIdSDf7jmEtBZGgFdaUcAJoYC+/X/Ko0Kn3HK8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772141527; c=relaxed/simple;
	bh=/R7hROwCpoDNk0099qEu5vC85eC5dyk3Y5NXIX/CD3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdS0z1w4WQIiz42VVWtmnEXAnzUXPj1o913LmeCaS0MyTcv5Mfbos4FVNU3/RwTXxJujPIID/dZR3oUJ1XSSxW5SB2xj2J0VkBHLvZ4/ttBsbZykucOG8DXeMHdbRvzr/+5xz9k193BvYm0XlxqwsmyMbHsn2gWqx9Udi59fxvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hn2ytuLO; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hn2ytuLO"
Date: Thu, 26 Feb 2026 13:31:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772141514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5vnnQTlVdZ/Og5RtD6XvnKakZXItRdyMij004ePH1bw=;
	b=Hn2ytuLO6KHfvcXYNvzmNp522fxz6wReD55jSQnK01E6iAgMZbR/2GbcXJUWEAuAgdxVmH
	GuBSoQ/Rr+Q0ren1UOzvnjHhUYHli3n7FF8VuS+4+vrOyJ6dageXcVeHErIOF83Dm7KXR4
	0yj7IllzR82We+0izRSBhfgrrIFltmY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Dmitry Ilvokhin <d@ilvokhin.com>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Brendan Jackman <jackmanb@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Oscar Salvador <osalvador@suse.de>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, kernel-team@meta.com, 
	Benjamin Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v3 5/5] mm: add tracepoints for zone lock
Message-ID: <aaC7S2ensAGTyujc@linux.dev>
References: <cover.1772129168.git.d@ilvokhin.com>
 <378089dd269249d3d7981fe10eb8b49ad551d353.1772129168.git.d@ilvokhin.com>
 <aaCbMwGNuUO1SbUb@linux.dev>
 <20260226132501.5b70914daf9438a1103189ee@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226132501.5b70914daf9438a1103189ee@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 26, 2026 at 01:25:01PM -0800, Andrew Morton wrote:
> On Thu, 26 Feb 2026 11:14:52 -0800 Shakeel Butt <shakeel.butt@linux.dev> wrote:
> 
> > On Thu, Feb 26, 2026 at 06:26:22PM +0000, Dmitry Ilvokhin wrote:
> > > Add tracepoint instrumentation to zone lock acquire/release operations
> > > via the previously introduced wrappers.
> > > 
> > > The implementation follows the mmap_lock tracepoint pattern: a
> > > lightweight inline helper checks whether the tracepoint is enabled and
> > > calls into an out-of-line helper when tracing is active. When
> > > CONFIG_TRACING is disabled, helpers compile to empty inline stubs.
> > > 
> > > The fast path is unaffected when tracing is disabled.
> > > 
> > > Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> > 
> > ...
> >
> > > +void __zone_lock_do_trace_start_locking(struct zone *zone)
> > > +{
> > > +	trace_zone_lock_start_locking(zone);
> > > +}
> > > +EXPORT_SYMBOL(__zone_lock_do_trace_start_locking);
> > 
> > No reason to not have these as EXPORT_SYMBOL_GPL (& below)
> 
> Do we need the exports at all?

Very good point and we don't. I think this might just be copying the mmap_lock
tracepoint wrappers which might need the exports as some drivers might be taking
the mmap_lock.

Dmitry, please confirm (test) and let us know.
