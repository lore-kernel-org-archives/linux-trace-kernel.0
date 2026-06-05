Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA7E33F59A;
	Fri,  5 Jun 2026 18:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684806; cv=none; b=e4KhDhL8m2MefnYrveHlxiGgZZZY9miTQozalVMaqpLxs+CL6yImP5LoweZgcRh0KELtYE41sZdu7CJu1rxKooRK3BgmMc19EOZb8J8EHX7EjFfauWC6hhzn48JBjC9o781QmKmerd5qJO5ukDN6yla4QiKPcbUqLJ8RYoiqOgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684806; c=relaxed/simple;
	bh=3NeQJ/6huPTik8Yef6xe4+FcW9uZSAc/bOVHCRIAnVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2zAb7MRgvZUoFRvMhazXO7U5gQ4B/TKv/nrcDDYgjHXmsjOdj+sY5uourwjM83YHGnhksbf/FGBrkCQ/nB8c4fpzrnVZy0kz5y3lS+Zsu/6H9pC6d2ftVufDA5ISrAk9itWpgNgzmitNPvAxorpdqOUdTm0KUAMP+Be4jd5Abg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I10tYfVd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I10tYfVd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276061F00893;
	Fri,  5 Jun 2026 18:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780684805;
	bh=jTyJbpnjz0kWvq3rixWsFNs2cgyukhDKAnb80ImkEk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I10tYfVdKGGqSv/Q2EFZd58lQ1NVLROgG98kfjLYCeSLNbr0Z+YZ8eea48dvlaqy+
	 Qa457EFC2SY8r95cit4+OarwxX5irG2eXykkU6m5cHXKSQiOtOyoL7kjoR8SIulO1l
	 xwh/ScwA5P75F9KgnYp26rFR2Hd73t/bvTzRwWgZeRvQaNbU9WAZYpwqqDAYdSrpbM
	 teCvM9V2O/6MHPZuZIbgZyMNhAQuDJmuF6E08pXq1nvmHV5wUEW03KQiusiQyJpNLW
	 H8nSIqodzTx9MZCmaGSTZncnnfOdidaWz6DhMJpWxe6eAbG0IN6wXfG/ZLQMgDVnj0
	 gYeAhzXIDB1MQ==
Date: Fri, 5 Jun 2026 19:39:50 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Nico Pache <npache@redhat.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	aarcange@redhat.com, akpm@linux-foundation.org, anshuman.khandual@arm.com, 
	apopple@nvidia.com, baohua@kernel.org, baolin.wang@linux.alibaba.com, 
	byungchul@sk.com, catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org, 
	hughd@google.com, jack@suse.cz, jackmanb@google.com, jannh@google.com, 
	jglisse@google.com, joshua.hahnjy@gmail.com, kas@kernel.org, lance.yang@linux.dev, 
	liam@infradead.org, mathieu.desnoyers@efficios.com, matthew.brost@intel.com, 
	mhiramat@kernel.org, mhocko@suse.com, peterx@redhat.com, pfalcato@suse.de, 
	rakie.kim@sk.com, raquini@redhat.com, rdunlap@infradead.org, 
	richard.weiyang@gmail.com, rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org, 
	ryan.roberts@arm.com, shivankg@amd.com, sunnanyong@huawei.com, surenb@google.com, 
	thomas.hellstrom@linux.intel.com, tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz, 
	vishal.moola@gmail.com, wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, zokeefe@google.com
Subject: Re: [PATCH mm-unstable v19 00/14] khugepaged: add mTHP collapse
 support
Message-ID: <aiMXqZkOJ2dZgyDU@lucifer>
References: <20260605161422.213817-1-npache@redhat.com>
 <177704e1-03b3-4791-9a69-9b83b72d61d5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177704e1-03b3-4791-9a69-9b83b72d61d5@kernel.org>

On Fri, Jun 05, 2026 at 08:07:02PM +0200, David Hildenbrand (Arm) wrote:
> On 6/5/26 18:14, Nico Pache wrote:
> > The following series provides khugepaged with the capability to collapse
> > anonymous memory regions to mTHPs.
> >
> > To achieve this we generalize the khugepaged functions to no longer depend
> > on PMD_ORDER. Then during the PMD scan, we use a bitmap to track individual
> > pages that are occupied (!none/zero). After the PMD scan is done, we use
> > the bitmap to find the optimal mTHP sizes for the PMD range. The
> > restriction on max_ptes_none is removed during the scan, to make sure we
> > account for the whole PMD range in the bitmap. When no mTHP size is
> > enabled, the legacy behavior of khugepaged is maintained.
> >
> > We currently only support max_ptes_none values of 0 or HPAGE_PMD_NR - 1
> > (ie 511). If any other value is specified, the kernel will emit a warning
> > and mTHP collapse will default to max_ptes_none=0. If a mTHP collapse is
> > attempted, but contains swapped out, or shared pages, we don't perform
> > the collapse.
> > It is now also possible to collapse to mTHPs without requiring the PMD THP
> > size to be enabled. These limitations are to prevent collapse "creep"
> > behavior. This prevents constantly promoting mTHPs to the next available
> > size, which would occur because a collapse introduces more non-zero pages
> > that would satisfy the promotion condition on subsequent scans.
> >
> > Patch 1-2:   Generalize hugepage_vma_revalidate and alloc_charge_folio
> >              for arbitrary orders.
> > Patch 3:     Rework max_ptes_* handling into helper functions
> > Patch 4:     Generalize __collapse_huge_page_* for mTHP support
> > Patch 5:     Require collapse_huge_page to enter/exit with the lock dropped
> > Patch 6:     Generalize collapse_huge_page for mTHP collapse
> > Patch 7:     Skip collapsing mTHP to smaller orders
> > Patch 8-9:   Add per-order mTHP statistics and tracepoints
> > Patch 10:    Introduce collapse_possible_orders helper functions
> > Patch 11-13: Introduce bitmap and mTHP collapse support, fully enabled
> > Patch 14:    Documentation
> >
>
> Went through it and didn't find any blockers. Let's wait for Lorenzo's assessment.
>
> If he also doesn't find anything major, I think we can move forward with merging
> it and handle smaller things as follow-ups.

All LGTM :)

Unless sashiko tells us about something utterly broken (trivial things meh,
existing things meh), or we see some massive breakage in testing, I
think... *drum roll*

We're good to take this this cycle :)

Thanks Nico for your patience during this process and obviously David and Lance
and all the other reviews for taking part.

We got there in the end :)

>
> --
> Cheers,
>
> David

Cheers, Lorenzo
