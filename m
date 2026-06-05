Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442503321A1;
	Fri,  5 Jun 2026 18:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683389; cv=none; b=uxg7jf9yO7HOk11OsNPabNa6JwO/RFn8Vdl/1sCVNu1X+CVXyTFZnbH9r6S4+rul8IdtzKYm48hFRXGwrQWmtZ6SXncMhIKvLmGujmVpCrip0fT88cLsF9JazQJAq7ygXLq0efxXa2bEqrkMupP6uZqh/6rXKHpnfVzlm3U0Zfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683389; c=relaxed/simple;
	bh=eAluAguZzFUdrd+ESkmvS2Q88UdRRRGmIF3vIvoAO5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s68Eovk/yhtYO/9We4iMRS76RiA9ZV4PGDWnfwR+nQWhnkJT+5IRDTn0weNdSDylxtRwtPqdQez2a3qDoyC0+bp/pVlr1uy31pAEAIRvjKya+MZ6Csf110IktFE381Vx8igvgq2nUR21r625ZT1981EOX6chbCQV5Djeufw7HF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfMOpKUY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfMOpKUY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FADD1F00893;
	Fri,  5 Jun 2026 18:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780683388;
	bh=hr3TDHITD2hFuly6b/zauwhYDrgCiLGzrw4YBwU12/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LfMOpKUY0kSkBKh+0v34G7pUSesBtCCe09LObqD9AaUizQ8XxYq5F1hDWE8qOk1Js
	 A6FKdJImxkAT9Lym8c5dYvXt8+w+Zo4wvV91s2HibfZGKDTbsBCyVR0lTMYexbE8+r
	 Tn8jAQEmr6y+PVxsxcCX5tteSX4r5Czf9awjMF4k05p9Cvi5MV7NHv5GROydwdTDsu
	 7bafKU4zSxWAM3NsIafvT25unEEis1CMWQd7AeTx6Cms0jtwKTyNvGPhiOcUcsnHw4
	 Wem3mZc2ktdQYCN4JsDucEKpU1in37L17u1bMN4h2KM/mlA5zjqS6RqmhFEDalI95u
	 DSQTzvSYU/Huw==
Date: Fri, 5 Jun 2026 19:16:12 +0100
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
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, zokeefe@google.com, 
	Usama Arif <usama.arif@linux.dev>
Subject: Re: [PATCH mm-unstable v19 12/14] mm/khugepaged: avoid unnecessary
 mTHP collapse attempts
Message-ID: <aiMSYAPTHDVEyP4N@lucifer>
References: <20260605161422.213817-1-npache@redhat.com>
 <20260605161422.213817-13-npache@redhat.com>
 <44b12ede-1e16-47f5-9051-27fa4ea34236@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44b12ede-1e16-47f5-9051-27fa4ea34236@kernel.org>

On Fri, Jun 05, 2026 at 07:49:34PM +0200, David Hildenbrand (Arm) wrote:
> On 6/5/26 18:14, Nico Pache wrote:
> > There are cases where, if an attempted collapse fails, all subsequent
> > orders are guaranteed to also fail. Avoid these collapse attempts by
> > bailing out early.
> >
> > Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
> > Acked-by: Usama Arif <usama.arif@linux.dev>
> > Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >  mm/khugepaged.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 430047316f43..7de92b28dd30 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -1499,6 +1499,7 @@ static enum scan_result mthp_collapse(struct mm_struct *mm,
> >  			collapse_address = address + offset * PAGE_SIZE;
> >  			ret = collapse_huge_page(mm, collapse_address, referenced,
> >  						 unmapped, cc, order);
> > +
>
> Unrelated to this patch, but not the end of the world :)

NA....h that's fine ;)

>
> --
> Cheers,
>
> David

Cheers, Lorenzo
