Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07F8399026;
	Fri, 27 Feb 2026 12:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772195948; cv=none; b=NFuIqfEIFGshlAwaut7ayVbOmVVGxZxzf+3uvXweKb8FPNY63cCjV8Oek8nnMYvyPFSB7zQpJnArIJWWtHdevVYnmsdIk8f9vIzthcKdKRdfHqIbZWvgjMUVslpOCn4HcGgI9OBCcSczUFJMUYtcyD7T/7a6vpmg+sZfZsvMRko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772195948; c=relaxed/simple;
	bh=LQaAxYbXykQ71q0y4SbJbnezXbB7UItWi6hV3dMayAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chkdvp2M3K6sZ8aCBMDFSbCwSB6a/D6pSMg6r1c0fOo8qTzOjFrqOy4Tm+bboGt9A+AAIY9cOAm+AqWmdohSGFtOJhGAYfhEsLh3YWht0thi93AkZDsusqpSATe77NeXDeHwn7VQXwnZ2+bJTDVcyg0foyhUlY3mLkIvKYGc0bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=sx9uvzb6; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="sx9uvzb6"
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 66C23B2DDC;
	Fri, 27 Feb 2026 12:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1772195944;
	bh=lagw43JwvowHFrojgNjKAjJ7QQwZVHMS96IQwGeM2pY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=sx9uvzb6fY4BMRxlL73VCSdMzqVe0zeqoGpO1lAPnBmEbW8AbhPkSkGPuu4b460kI
	 m8BJ+MuG/RJ3vmuNA1EhDXrHF4vH8Cz6IEgFFDLR1qgBc+fEg5kSEb+okRx7bGt+Yi
	 ybSwmN9VBUS7VW1OG4Lw1HGV4ytlCNxAP9PZYpRE=
Date: Fri, 27 Feb 2026 12:39:00 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
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
	Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, kernel-team@meta.com,
	Benjamin Cheatham <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v3 5/5] mm: add tracepoints for zone lock
Message-ID: <aaGQZOk0_afa8SOk@shell.ilvokhin.com>
References: <cover.1772129168.git.d@ilvokhin.com>
 <378089dd269249d3d7981fe10eb8b49ad551d353.1772129168.git.d@ilvokhin.com>
 <aaCbMwGNuUO1SbUb@linux.dev>
 <20260226132501.5b70914daf9438a1103189ee@linux-foundation.org>
 <aaC7S2ensAGTyujc@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaC7S2ensAGTyujc@linux.dev>

On Thu, Feb 26, 2026 at 01:31:48PM -0800, Shakeel Butt wrote:
> On Thu, Feb 26, 2026 at 01:25:01PM -0800, Andrew Morton wrote:
> > On Thu, 26 Feb 2026 11:14:52 -0800 Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > 
> > > On Thu, Feb 26, 2026 at 06:26:22PM +0000, Dmitry Ilvokhin wrote:
> > > > Add tracepoint instrumentation to zone lock acquire/release operations
> > > > via the previously introduced wrappers.
> > > > 
> > > > The implementation follows the mmap_lock tracepoint pattern: a
> > > > lightweight inline helper checks whether the tracepoint is enabled and
> > > > calls into an out-of-line helper when tracing is active. When
> > > > CONFIG_TRACING is disabled, helpers compile to empty inline stubs.
> > > > 
> > > > The fast path is unaffected when tracing is disabled.
> > > > 
> > > > Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>
> > > 
> > > ...
> > >
> > > > +void __zone_lock_do_trace_start_locking(struct zone *zone)
> > > > +{
> > > > +	trace_zone_lock_start_locking(zone);
> > > > +}
> > > > +EXPORT_SYMBOL(__zone_lock_do_trace_start_locking);
> > > 
> > > No reason to not have these as EXPORT_SYMBOL_GPL (& below)
> > 
> > Do we need the exports at all?
> 
> Very good point and we don't. I think this might just be copying the mmap_lock
> tracepoint wrappers which might need the exports as some drivers might be taking
> the mmap_lock.
> 
> Dmitry, please confirm (test) and let us know.

This is a good catch, thank you. I don't think we need EXPORT_SYMBOL()
here. Just verified it locally. I'll remove it in v4. 
