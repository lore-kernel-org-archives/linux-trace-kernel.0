Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FEF1A5B8A;
	Thu, 21 May 2026 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375556; cv=none; b=maVxci51mOOAPS140V26bnVW9lzvJ1iN0CbJrV2UN1QKnvHeHhTobKk6VY5uebAW8qhRjOoc2hfcH8hDP+N1LIYamkWhjUiVJF10IBKlMXPE3cn1KY3M/TPkpHG60bF/2jlYSY1EbZgXS8mq8OrO9SImshHNWrnoSlu0agHnGhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375556; c=relaxed/simple;
	bh=UwTJUQEEjEAuGD/38EJAyyJEhAp/6WUIT8s9od8d5cI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6Z062QhubEAUQnoktlqxAnRrJ9vQ9KNBwdO5TVElpnnvajqaC1CrkJObwJh83NIaZDjaXKDJOHmdHzK9mYa0ny78iWVJjtbLhgNCI3k01EjMeX7sQ/5ao3aob2DwpfO0O2c54NpryN/4F4vIr2GJIoN6cANXCJGxvyyofX+FWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFt9uYJs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFt9uYJs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8D71F00A3E;
	Thu, 21 May 2026 14:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779375555;
	bh=UwTJUQEEjEAuGD/38EJAyyJEhAp/6WUIT8s9od8d5cI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QFt9uYJslrjF5lm8zndfOP6s3oryviFzIwtzSew9cvovaEBxxtGMYXzbP6YEwm/FA
	 DzwtNNflGNX7N+8nu1hbd+NJ+jQqOdI3nxhHtvXbWBMjHkTOHLFDSj8QWJTT6IDJYo
	 uFIkB32kYEKxA5/AmPw1FtVZVCuVanyJYv+S67+Bcai0gRX6t533uIfV0YiMDM+DHD
	 mNdELy52vF5rXrxE86yG3e1LrKQK/Q3gpbuAbTkFtthFGJNf334t+hKR6Aw/r/LV6c
	 Q6A7crs20ItQBG5wza5dSlsdlUStwigXBDmsg/3T1ejlnsR3mnSwlXFztAe2aWPAjN
	 9B/gYwXbsHDkA==
Date: Thu, 21 May 2026 15:59:02 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Nico Pache <npache@redhat.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	Wei Yang <richard.weiyang@gmail.com>, Lance Yang <lance.yang@linux.dev>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	aarcange@redhat.com, akpm@linux-foundation.org, anshuman.khandual@arm.com, 
	apopple@nvidia.com, baohua@kernel.org, baolin.wang@linux.alibaba.com, 
	byungchul@sk.com, catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org, 
	hughd@google.com, jack@suse.cz, jackmanb@google.com, jannh@google.com, 
	jglisse@google.com, joshua.hahnjy@gmail.com, kas@kernel.org, liam@infradead.org, 
	mathieu.desnoyers@efficios.com, matthew.brost@intel.com, mhiramat@kernel.org, mhocko@suse.com, 
	peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, raquini@redhat.com, 
	rdunlap@infradead.org, rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org, 
	ryan.roberts@arm.com, shivankg@amd.com, sunnanyong@huawei.com, surenb@google.com, 
	thomas.hellstrom@linux.intel.com, tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz, 
	vishal.moola@gmail.com, wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, zokeefe@google.com
Subject: Re: [PATCH mm-unstable v17 04/14] mm/khugepaged: generalize
 __collapse_huge_page_* for mTHP support
Message-ID: <ag8dnKjkJgLgNkDv@lucifer>
References: <20260511185817.686831-5-npache@redhat.com>
 <20260512074202.10253-1-lance.yang@linux.dev>
 <20260514031009.f66cgop3ctgiqxz3@master>
 <9b33339e-157a-45b7-942e-3be3418a5142@kernel.org>
 <agtpK1x27B-E7mMo@lucifer>
 <CAA1CXcCNT51jeXh6Kwg1QN9e+AJB-1hg21kmeY6fTTKr2GACug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA1CXcCNT51jeXh6Kwg1QN9e+AJB-1hg21kmeY6fTTKr2GACug@mail.gmail.com>

On Tue, May 19, 2026 at 01:05:13PM -0600, Nico Pache wrote:
> On Mon, May 18, 2026 at 1:33 PM Lorenzo Stoakes <ljs@kernel.org> wrote:
> >
> > On Mon, May 18, 2026 at 03:16:11PM +0200, David Hildenbrand (Arm) wrote:
> > > > For me, I would vote for fallback to 0.
> > >
> > > At this point I'll prefer to not return errors from collapse_max_ptes_none().
> > > It's just rather awkward to return an error deep down in collapse code for a
> > > configuration problem.
> > >
> > > For mthp collapse, we only support max_ptes_none==0 and
> > > max_ptes_none=="HPAGE_PMD_NR - 1" (default).
> > >
> > > If another value is specified while collapsing mTHP, print a warning and treat
> > > it as 0 (save value, no creep, no memory waste).
> > >
> > > In a sense, this is similar to how we handle max_ptes_shared + max_ptes_swap:
> > > for mTHP: we always treat them as being 0 for mTHP collapse (and don't issue a
> > > warning, because we would issue a warning with the default settings).
> > >
> > > @Lorenzo, fine with you?
> >
> > Yes 100%, this sounds sensible both in terms of the error and the default. Let's
> > keep our lives simple(-ish) please :)
>
> Ok thank you im glad we finally came to consensus on this! phew!
>

It happens sometimes ;)

Cheers, Lorenzo
