Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDEE28373;
	Fri, 22 May 2026 16:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779466811; cv=none; b=JnRmJy/GBffkzcJOtUj6/jc+Ykcrk8DDTf7Anbgclr3j3LjYompXS2JTq9igCh7H6PI5iUQxkQp4ONslST9D5/0c4kGHroVg46a+BqIqejVBwQ2crUYIjHXDKoz+pDDV5b8Sr5dsKivXNWpXgDkX6poDClvNuwKE8LshCeYgHbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779466811; c=relaxed/simple;
	bh=FnSicpjvcBNVy0CRSGn1QhxVVZS//kfYT8GlbArGmV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xv7QNDLYi/3cb4l19ysL8SN5IJS0x2UzijNy3hBA0TU572s3lWn+NoDFhKtJYuakWHenu3dmBxWrsszN1iy2iy5ygmbFzhciCOrJj4H5NI78ZCg90oV4Zf7j5wSz8FURWgwYRzJERtLd1q4bZGIPDKyfEaPrLvb58JQqwiFgk6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j85b84o7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j85b84o7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F821F000E9;
	Fri, 22 May 2026 16:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779466810;
	bh=FnSicpjvcBNVy0CRSGn1QhxVVZS//kfYT8GlbArGmV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j85b84o74dlM2RlikWLtxJ8InZVwop88/rTxiPexhk+8nBlTalaWkjejulMgi6MOg
	 Otfw6BCjq5y5HGx6wlPg+DesU+9LvQ6X9h4vJsJW3JWyTuk0PqiGTMMCUXmO8uH9JZ
	 uSBnA2R6/ORbxzKWFOOhviNaYIyIAv9GaSBrTSp4GQRNF6ocMKKrHn/PNEjEF1VtSB
	 kB03USBOnE8B1vWYbl+ZJHc6A5c5hDGKeyr9ruTS0p69+lgtuDNbca5ROQWi6u7Ch8
	 K2cb9KUB+u00h4qaTL8jEGhsg/lzQC4FM5nZ02MHuluix6um4gyMrG53jy05UiNu/f
	 Yj6rzl4Fhc5Hg==
Date: Fri, 22 May 2026 17:19:55 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Nico Pache <npache@redhat.com>
Cc: linux-doc@vger.kernel.org, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	aarcange@redhat.com, anshuman.khandual@arm.com, apopple@nvidia.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, byungchul@sk.com, catalin.marinas@arm.com, cl@gentwo.org, 
	corbet@lwn.net, dave.hansen@linux.intel.com, david@kernel.org, dev.jain@arm.com, 
	gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, 
	jackmanb@google.com, jannh@google.com, jglisse@google.com, joshua.hahnjy@gmail.com, 
	kas@kernel.org, lance.yang@linux.dev, liam@infradead.org, 
	mathieu.desnoyers@efficios.com, matthew.brost@intel.com, mhiramat@kernel.org, mhocko@suse.com, 
	peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, raquini@redhat.com, 
	rdunlap@infradead.org, richard.weiyang@gmail.com, rientjes@google.com, 
	rostedt@goodmis.org, rppt@kernel.org, ryan.roberts@arm.com, shivankg@amd.com, 
	sunnanyong@huawei.com, surenb@google.com, thomas.hellstrom@linux.intel.com, 
	tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com, 
	wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, zokeefe@google.com
Subject: Re: [PATCH mm-hotfixes-unstable v18 00/14] khugepaged: add mTHP
 collapse support
Message-ID: <ahB_hae8coGvf12Z@lucifer>
References: <20260522150009.121603-1-npache@redhat.com>
 <CAA1CXcCoDU_pnp0SmMzRi8wPGB1OBjbbokevq2X_03X1vpWtOw@mail.gmail.com>
 <ahByO_HWn6MB8z-u@lucifer>
 <CAA1CXcDoFdZZ4aBx0BPA7QXYKYBYDoqUiLTLYe3L5opJ0LsJGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA1CXcDoFdZZ4aBx0BPA7QXYKYBYDoqUiLTLYe3L5opJ0LsJGg@mail.gmail.com>

On Fri, May 22, 2026 at 10:08:19AM -0600, Nico Pache wrote:
> On Fri, May 22, 2026 at 9:17 AM Lorenzo Stoakes <ljs@kernel.org> wrote:
> >
> > On Fri, May 22, 2026 at 09:07:29AM -0600, Nico Pache wrote:
> > > Whoops I manually changed the coverletter subject to reflect that this
> > > in on mm-hotfixes-unstable but never updated the others...
> > >
> > > Hopefully that is ok. Just a small mistake. Base commit is referenced here.
> >
> > It's not ok, this isn't suitable for a hotfix in any way shape or form?
> >
> > As you know, because we told you :) May has been difficult because of
> > conferences, holidays (and in my case burnout recovery).
> >
> > And unfortunately the series seems to have needed quite a bit of review again
> > (my suggestion to you would be to ensure you don't make major changes, only
> > small incremental ones on the basis of review feedback).
> >
> > So this isn't viable for 7.2, and we'll have to target 7.3. Therefore there
> > was no rush.
> >
> > Also please don't spring a respin on this series on us without discussion
> > first, with people away and (frankly) the amount of work involved here,
> > you're going to have to accept the pace that workload/availability permits.
> >
> > Adding spurious hotfixes tags doesn't help anything :) please don't do that
> > again.
>
> Hi,
>
> Sorry for the confusion but Andrew and I spoke about this before I
> sent it, and he confirmed that I should send it against this tree to
> prevent merge conflicts.
>
> Because Zi's series depends on this, and this is already in the mm
> tree, choosing a candidate before my commits was best to prevent merge
> conflicts.

There's some kind of confusion here.

This series isn't suited for 7.2.

Sorry but Zi's series, unless it depends on functionality here, will have
to be rebased.

People have been at conferences, people have been on leave, I've had to
pace myself for health reasons and it seems there's been more than simply
review comment-based changes happening here.

(Again I strongly encourage, at this stage, to ONLY be making changes based
on review, not adding ANYTHING else or changing ANYTHING else to avoid
delays :)

Also - shouldn't mm-unstable already have mm-hotfixes-unstable in it?

I think in mm-next we will have an stable branch, that everything is
based on, where things go once review is complete and things are mergeable.

And a separate hotfixes branch based on Linus's tree.

That would avoid issues like this :)

>
> The intent wasn't that this is a hotfix, just that this was the
> closest base before the v17 that is already in the tree.

The convention is that [PATCH ... <branch>] indicates the target of the
changes. Putting the hotfixes branch there implies it's a hotfix.

So please be careful with that in future :)

>
> Sorry for the confusion, hopefully Andrew can still apply it to the
> correct tree.

I'm not even sure what's best for that at this stage given we have
conflicts and this has to be delayed until 7.3.

I wonder if given that we should not have this in mm-unstable at all and
just wait it out until the next cycle begins? Review can happen
concurrently.

>
> -- Nico
>
> >
> > Thanks, Lorenzo
> >
>

Thanks, Lorenzo
