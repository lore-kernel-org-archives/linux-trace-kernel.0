Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8DE285CB4;
	Thu,  9 Jul 2026 15:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783609276; cv=none; b=Pe0J8X0vHTBaQaa8rztk3+/QDgpI4+sUEHC+V0YxvPGWUq6xIgYjBZXVYWgT22gZPyjArpqduqwO4rYbzudFiFYJVfiJrGETYpqxX7Rx8Agk/8rOPaby8+Uu2H/t5ZLsrK1zg0H1FbAOUm1rZo2Y9g3AlI1KVaO8mUsIMFcT26Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783609276; c=relaxed/simple;
	bh=kB98HACJNrDeBqSvWdJcV/CPd9n7jhCez6XjJmsAfnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5EFT7czLDrQIWvQVh5JtLHv+Va2ayvOxXUw7FiolPNFlaXzz2QjMmSzLZjoC8bIdckuTARGfHA7TtravfcpoN+zRyQzb2CWwsR0gCxAWWpfqc9wVwTqyaSfZOxeyGkNOX1XYco+zMURVo/glhrqiRIA5kN9OC3YKBkiy/Q487Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCclnew5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCclnew5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440AF1F00A3A;
	Thu,  9 Jul 2026 15:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783609275;
	bh=bs58MBJLx0dSPnNUhauIAU/NgeeIieNvdxeLqwZSYtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mCclnew5cVt0n37fGUUOr9gmU1Esl5X7tOEFvhzautMETbyXk8KpmxhNQm8vmKPZ5
	 6XiMWaT8Biz/cLcvM2s5XXBMQnwpqmRJghipz963jxTuyfGEcGt0wgnXt8rgVoh2+d
	 fHb+wlRnlRgtdgycUpXTEggEYCvDSu613ePaDgE6SYGnzUQ2QFcrWP1AmuLpWhwI6o
	 9bFlytaI212c9Wo30pIdQVtQDa/LNOgnc1B1DegVASnPEkUwHzsWmNP3QB5uYFzP3M
	 jsiCRfnMrK9HpwWrFvFjlxe2uKfdx5pKI6aJpXbkSDlKODymBAIVQSX75bx7V5lQkz
	 YTUeXC6mf9jkw==
Date: Thu, 9 Jul 2026 16:00:59 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Wandun <chenwandun1@gmail.com>
Cc: vbabka@kernel.org, david@kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, Alexander.Krabler@kuka.com, hughd@google.com, fvdl@google.com, 
	bigeasy@linutronix.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, akpm@linux-foundation.org, 
	surenb@google.com, mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, 
	ziy@nvidia.com, riel@surriel.com, liam@infradead.org, harry@kernel.org, 
	jannh@google.com, lance.yang@linux.dev, mathieu.desnoyers@efficios.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, 
	gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com, 
	pfalcato@suse.de
Subject: Re: [PATCH v2 1/4] mm/migrate: do not migrate folios mapped into
 VM_LOCKED VMAs under compaction
Message-ID: <ak-2VAwNNuCD98Jv@lucifer>
References: <20260707125925.3725177-1-chenwandun1@gmail.com>
 <20260707125925.3725177-2-chenwandun1@gmail.com>
 <akz7ythMxfIZeT0d@lucifer>
 <ak0EsCeucJarlI7G@lucifer>
 <f33a9dca-03d6-45f8-bd25-717b9033c75c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f33a9dca-03d6-45f8-bd25-717b9033c75c@gmail.com>

On Thu, Jul 09, 2026 at 04:25:27PM +0800, Wandun wrote:
>
>
> On 7/7/26 21:55, Lorenzo Stoakes wrote:
> > On Tue, Jul 07, 2026 at 02:44:50PM +0100, Lorenzo Stoakes wrote:
> >> See above about deduplicating.
> >>
> >>> +			ttu |= TTU_RESPECT_MLOCK;
> >>
> >> Hmm. I don't love 'respect mlock'. I guess we only know about the reason
> >> being compaction here.
> >>
> >> But I'm confused anyway. We have the folio, why aren't we just checking for
> >> PG_mlocked() here instead of getting the rmap to see if it's mapped
> >> anywhere with VMA_LOCKED_BIT?
> >
> > Also, since compaction_allow_unevictable() is a function that is accessible
> > elsewhere, you could literally just have a TTU_MIGRATION here instead and have
> > the rmap logic call compaction_allow_unevictable() instead rather than this.
> Do you mean:
> 1. change TTU_RESPECT_MLOCK to TTU_MIGRATION, that'is OK.
> 2. move call compaction_allow_unevictable() to try_to_migrate_one? but as you suggested
>    migrate_mlock_allowed function, it already called compaction_allow_unevictable()
>    in order to determine whether TTU_MIGRATION needs to be added. Did I misunderstand
>    something somewhere?

The next paragraph addresses this.

>
> >
> > And then you could adapt the function I suggested before not to take a reason
> > parameter but rather a 'is_migration' one instead possibly and then pass (ttu &
> > TTU_MIGRATION) in.


> >
> > BUT. I still question whether this is at all needed since you have the folio you
> > can check for PG_mlocked...
>
> I described a race scenario at this link:
> https://lore.kernel.org/lkml/c372e68f-2bfc-45b6-a431-01bf55717247@gmail.com/

OK thanks. You really have to spell this out in the code in a comment, this is
really non-obvious.

I will try to look at your reply in due course (am between jobs atm).

>
>
> >
> > Cheers, Lorenzo
>

Thanks, Lorenzo
