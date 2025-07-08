Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D4429CB57;
	Tue,  8 Jul 2025 08:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751962397; cv=none; b=HLeRf5DkBjj6VvlYO3v16EmBVsdzYUV+tdhrI0FLumH8vaNUGXeluZj19gSMfnnKanwiL1QZJ2UMxj5yg4Zpa1Q90ENNC7w9YUG+TMM7f4RLMcOQ/0q1NWvy3tnXnfuC26dOgNtsYieODw7leScZfy/XBKRODcEz4ocduin5bC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751962397; c=relaxed/simple;
	bh=aYotaDQsTWKZrcKVAgzWOgtQh4U9sufr1mwzUzZ3AWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BqFheml22dnwrZKY9NxeLC4rHYaJA4sJ0Ru0h7XJGxjCrXQURaezeFrKL5wpbJ/YkO2w3r+grrOcDLBbb75130VU6j/PMyj3HqwwZz4FhPtx2fthFwR3/sw8tJtynrpwVFgaGzLIALfX0Ax3snoFLBuECXgSUAZIkbTsInG/Ghw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwGqV6tf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwGqV6tf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA29C4CEED;
	Tue,  8 Jul 2025 08:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751962394;
	bh=aYotaDQsTWKZrcKVAgzWOgtQh4U9sufr1mwzUzZ3AWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RwGqV6tfK3KqGqoZ+FGPc5T58orUwoWtR/bQB+rla9vlXVzyWp7Vtt8iM/9VraGQG
	 b/M+qCtY7XRbPfYjE3pK+W+PAf7Dvb6UWbhVO5J/giW6rCNXfj6xKTxe5hxDu8PGGc
	 M/RPuPcg4GfLfrZGik+xpOVhuF6B4OfU9IiHT6XcpduJM96Foftkop6l1ox4XPF9Uw
	 mr1AKcIvq1LyqytMIeX/44wvG7EIRfISMK7002sFVtz1XMxmEPkz/1nx8SJTRxmp51
	 yQoe6+gXqCPcgaXq+AhJJV1ZdYxFZpQh+DojSa9S9A0VRvOtxjLjAlS42bNf1aQa4D
	 reUxEA16sPoQA==
Date: Tue, 8 Jul 2025 11:13:04 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <aGzTEA6tx4rqubbF@kernel.org>
References: <20250704134943.3524829-1-rppt@kernel.org>
 <20250704134943.3524829-4-rppt@kernel.org>
 <20250707111102.GF1613200@noisy.programming.kicks-ass.net>
 <aGuwMtxsouXvdiCK@kernel.org>
 <oez2aoegd2dfq4h4fg2on2rsgwp36aumpedmobxkj7dlmaoeyr@sqz27uhgf3f7>
 <aGvj2gUHntuuOp4H@kernel.org>
 <20250708072649.GC1613376@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708072649.GC1613376@noisy.programming.kicks-ass.net>

On Tue, Jul 08, 2025 at 09:26:49AM +0200, Peter Zijlstra wrote:
> On Mon, Jul 07, 2025 at 06:12:26PM +0300, Mike Rapoport wrote:
> > On Mon, Jul 07, 2025 at 11:06:25AM -0400, Liam R. Howlett wrote:
> > > * Mike Rapoport <rppt@kernel.org> [250707 07:32]:
> > > > On Mon, Jul 07, 2025 at 01:11:02PM +0200, Peter Zijlstra wrote:
> > > > > 
> > > > > 	err = __execmem_cache_free(&mas, ptr, GFP_KERNEL | __GFP_NORETRY);
> > > > > 	if (err) {
> > > > > 		mas_store_gfp(&mas, pending_free_set(ptr), GFP_KERNEL);
> > > > > 		execmem_cache.pending_free_cnt++;
> > > > > 		schedule_delayed_work(&execmem_cache_free_work, FREE_DELAY);
> > > > > 		return true;
> > > > > 	}
> > > > > 
> > > > > 	schedule_work(&execmem_cache_clean_work);
> > > > > 	return true;
> > > > > }
> > > > > 
> > > > > And now I have to ask what happens if mas_store_gfp() returns an error?
> > > > 
> > > > AFAIU it won't. mas points to exact slot we've got the area from, nothing else
> > > > can modify the tree because of the mutex, so that mas_store_gfp()
> > > > essentially updates the value at an existing entry.
> > > > 
> > > > I'll add a comment about it.
> > > > 
> > > > Added @Liam to make sure I'm not saying nonsense :)
> > > > 
> > > 
> > > Yes, if there is already a node with a value with the same range, there
> > > will be no allocations that will happen, so it'll just change the
> > > pointer for you.  This is a slot store operation.
> > > 
> > > But, if it's possible to have no entries (an empty tree, or a single
> > > value at 0), you will most likely allocate a node to store it, which is
> > > 256B.
> > > 
> > > I don't think this is a concern in this particular case though as you
> > > are searching for an entry and storing, so it needs to exist.  So
> > > really, the only scenario here is if you store 1 - ULONG_MAX (without
> > > having expanded a root node) or 0 - ULONG_MAX, and that seems invalid.
> > 
> > Thanks for clarification, Liam!
> > The tree cannot be empty at that point and if it has a single value, it
> > won't be at 0, I'm quite sure no architecture has execmem areas at 0.
> 
> Would it make sense to have something like GFP_NO_ALLOC to pass to
> functions like this where we know it won't actually allocate -- and
> which when it does reach the allocator generates a WARN and returns NULL
> ?

We can add a WARN at the caller as well, that won't require a new gfp flag.
The question is how to recover if such thing happen, I don't really see
what execmem can do here if mas_store_gfp() returns an error :/

-- 
Sincerely yours,
Mike.
