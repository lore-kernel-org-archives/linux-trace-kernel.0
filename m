Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A705722ACFA;
	Tue,  8 Jul 2025 07:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751959627; cv=none; b=eAIY6VzHDRtnzkIfmS4HEKqFtVftn0VkMNKcM50whg2bYPlS/Fd9myUzke+T7F+Th1ihMh/GZFOUi3C6r72QpcJ09EbNZmJ/+SFgq+C3paxaWoVnfRyeTn+7Tke4h9Okps6x2RE0yodG7DUXEHJoo3c7m21GlGYpFJP0nnT7Og0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751959627; c=relaxed/simple;
	bh=A3b8xMcLJLpdw3D6e2Jf/FY/YGZHVVbbjl1q9UNTaMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1nKacsAa9tzceKqpg1UlingM7IXD/KT8GUDeVmZ0oAOzWMWozPvfZFl1MbXx0znawhZj/8QdzknfSJgDFtAF9m7ame+PZYHY+ASpRUZVl1YZiWMFNYoqM1KcuX3cvr98RlRF36/Tqi9GOjAB3tOhu5RSnORFVn5dsZ8mJMNSrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EF1PF8Jb; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EF1PF8Jb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=reVmejc4cOPygy1WONqUgsz18oI63wpfc0pQGOwsw0Y=; b=EF1PF8Jb+36WCTmR2ZWD3H7j+n
	kmec4/q/ZJgK1AKlZ+X8theLxuaAf08viSvAkdiOge8rq44UU9WG3PEyqEEoiuaBQUWAeP4NqfeIn
	+RMmdvTkRfc/dWhOemYU4lSztyvKIVbEMaPZhv2a0bf/qRC4AaSdlpypu5i683PnzmumsMs9KPDgR
	V08kx/Tt0Hx4p3X0qMhEH7bmWbLnQiobyQEzbDYm6fc+bHlEJU0Rk7Gn6UY9vEH8gntufzM7GjO3F
	OGQ7HWDtnHAfA6XFynKgRWD/to6FE0naKYdXQGOXyPsE1045yKDIBS3jFocSLghhNl4x4BSqcsJHq
	/+cNhe/A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZ2j3-00000008hjG-3gs8;
	Tue, 08 Jul 2025 07:26:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 72B3B30065D; Tue, 08 Jul 2025 09:26:49 +0200 (CEST)
Date: Tue, 8 Jul 2025 09:26:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Daniel Gomez <da.gomez@samsung.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 3/8] execmem: rework execmem_cache_free()
Message-ID: <20250708072649.GC1613376@noisy.programming.kicks-ass.net>
References: <20250704134943.3524829-1-rppt@kernel.org>
 <20250704134943.3524829-4-rppt@kernel.org>
 <20250707111102.GF1613200@noisy.programming.kicks-ass.net>
 <aGuwMtxsouXvdiCK@kernel.org>
 <oez2aoegd2dfq4h4fg2on2rsgwp36aumpedmobxkj7dlmaoeyr@sqz27uhgf3f7>
 <aGvj2gUHntuuOp4H@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGvj2gUHntuuOp4H@kernel.org>

On Mon, Jul 07, 2025 at 06:12:26PM +0300, Mike Rapoport wrote:
> On Mon, Jul 07, 2025 at 11:06:25AM -0400, Liam R. Howlett wrote:
> > * Mike Rapoport <rppt@kernel.org> [250707 07:32]:
> > > On Mon, Jul 07, 2025 at 01:11:02PM +0200, Peter Zijlstra wrote:
> > > > 
> > > > 	err = __execmem_cache_free(&mas, ptr, GFP_KERNEL | __GFP_NORETRY);
> > > > 	if (err) {
> > > > 		mas_store_gfp(&mas, pending_free_set(ptr), GFP_KERNEL);
> > > > 		execmem_cache.pending_free_cnt++;
> > > > 		schedule_delayed_work(&execmem_cache_free_work, FREE_DELAY);
> > > > 		return true;
> > > > 	}
> > > > 
> > > > 	schedule_work(&execmem_cache_clean_work);
> > > > 	return true;
> > > > }
> > > > 
> > > > And now I have to ask what happens if mas_store_gfp() returns an error?
> > > 
> > > AFAIU it won't. mas points to exact slot we've got the area from, nothing else
> > > can modify the tree because of the mutex, so that mas_store_gfp()
> > > essentially updates the value at an existing entry.
> > > 
> > > I'll add a comment about it.
> > > 
> > > Added @Liam to make sure I'm not saying nonsense :)
> > > 
> > 
> > Yes, if there is already a node with a value with the same range, there
> > will be no allocations that will happen, so it'll just change the
> > pointer for you.  This is a slot store operation.
> > 
> > But, if it's possible to have no entries (an empty tree, or a single
> > value at 0), you will most likely allocate a node to store it, which is
> > 256B.
> > 
> > I don't think this is a concern in this particular case though as you
> > are searching for an entry and storing, so it needs to exist.  So
> > really, the only scenario here is if you store 1 - ULONG_MAX (without
> > having expanded a root node) or 0 - ULONG_MAX, and that seems invalid.
> 
> Thanks for clarification, Liam!
> The tree cannot be empty at that point and if it has a single value, it
> won't be at 0, I'm quite sure no architecture has execmem areas at 0.

Would it make sense to have something like GFP_NO_ALLOC to pass to
functions like this where we know it won't actually allocate -- and
which when it does reach the allocator generates a WARN and returns NULL
?
