Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439EE480946;
	Thu,  4 Jun 2026 14:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780584066; cv=none; b=a/hipq+mrY1aJxKDRN2+lU9us/nFVFB1aC0bUDJNWlISlgW1hgnu9DbWroo0r2SS4Q3DiSpkNF5QaYmbSE1j+5si7mrYzgNj0F0W14gaKIuGgWj/9r4eoVl9XMgpAaQ34tqgcaDGlUvR4HWSSqhNhCi0aRZ8PhCHmFWVwx4DZxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780584066; c=relaxed/simple;
	bh=CtDt3lYeen32tJjPtVhK83NQYah0kpWdJdJve8FYL6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhKnAXNRv8Er5u9ezlucSDLZQ0Y9LAOnsJwXpFqqKjqKVnZdDU1jYTzdDcL7V50KjUge723O8ZGPIFhSkvWOtW7QL+bG7XkuY81rTECx4foKy0kg+bFv2ogFmmGYYonpg/xJmq0XD6xDd0gzujwy5KyU7m9JJG4FPYQ4EnHmW1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ip7V26mZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ip7V26mZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813361F00893;
	Thu,  4 Jun 2026 14:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780584064;
	bh=CtDt3lYeen32tJjPtVhK83NQYah0kpWdJdJve8FYL6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ip7V26mZ3lpilTPjqq54piAcvOldqnXrk4MptULiPvlt1TPj3O9KC/WGiBCpb6sS+
	 FE/PcYpQMfmHU4JeXTJyoK7qBUwLxMAT46k1dxOCBZ+IVZ/92S6R53dGbiuMpcfyZK
	 62TXYPA9ty+/tG9g1H445TrGZInqnRDINE0QCHnsRCJNisxk2ShRvoayrgTln0h3JT
	 Qh3k1N7Iic1u2ZWCI5CxGC92BdXhxeVP4kM4LU68/a0v9PaxSay2rbsuPPl8Q0du7s
	 QwF1SpaHIfafTST+QIOw9/ekg10tpWZbR3mnERIgDF6duw7/NNe4JE8yOrvpGwcnGK
	 FJin50Cz7XUIw==
Date: Thu, 4 Jun 2026 15:40:49 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Lance Yang <lance.yang@linux.dev>, Nico Pache <npache@redhat.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, aarcange@redhat.com, akpm@linux-foundation.org, 
	anshuman.khandual@arm.com, apopple@nvidia.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, byungchul@sk.com, catalin.marinas@arm.com, cl@gentwo.org, 
	corbet@lwn.net, dave.hansen@linux.intel.com, dev.jain@arm.com, gourry@gourry.net, 
	hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, jackmanb@google.com, 
	jannh@google.com, jglisse@google.com, joshua.hahnjy@gmail.com, kas@kernel.org, 
	liam@infradead.org, mathieu.desnoyers@efficios.com, matthew.brost@intel.com, 
	mhiramat@kernel.org, mhocko@suse.com, peterx@redhat.com, pfalcato@suse.de, 
	rakie.kim@sk.com, raquini@redhat.com, rdunlap@infradead.org, 
	richard.weiyang@gmail.com, rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org, 
	ryan.roberts@arm.com, shivankg@amd.com, sunnanyong@huawei.com, surenb@google.com, 
	thomas.hellstrom@linux.intel.com, tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz, 
	vishal.moola@gmail.com, wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, zokeefe@google.com
Subject: Re: [PATCH mm-unstable v18 11/14] mm/khugepaged: Introduce mTHP
 collapse support
Message-ID: <aiGOZyvD6lHskQSH@lucifer>
References: <20260522150009.121603-12-npache@redhat.com>
 <20260531071845.10875-1-lance.yang@linux.dev>
 <CAA1CXcA+oZmp=cxiC2_EBDxqGX94gAd335d9eFPNv=j_0=og7Q@mail.gmail.com>
 <185f5699-3797-4300-8c54-bb99fc2a45e0@linux.dev>
 <46bb9d9e-03f0-4e26-9ac9-1cdc5ba9bf4d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46bb9d9e-03f0-4e26-9ac9-1cdc5ba9bf4d@kernel.org>

On Wed, Jun 03, 2026 at 10:05:08AM +0200, David Hildenbrand (Arm) wrote:
> On 6/2/26 17:44, Lance Yang wrote:
> >
> >
> > On 2026/6/2 18:58, Nico Pache wrote:
> >> On Sun, May 31, 2026 at 1:19 AM Lance Yang <lance.yang@linux.dev> wrote:
> >>>
> >>>
> >>> [...]
> >>>
> >>> Hmm ... don't we lose the allocation-failure result here?
> >>>
> >>> Previously collapse_scan_pmd() propagated SCAN_ALLOC_HUGE_PAGE_FAIL from
> >>> collapse_huge_page(), so khugepaged would call khugepaged_alloc_sleep()
> >>> in khugepaged_do_scan().
> >>>
> >>> Now if allocation fails and nr_collapsed stays 0, we just return
> >>> SCAN_FAIL. So we won't back off via khugepaged_alloc_sleep() anymore?
> >>
> >> Ok I did the error propagation! I think I handled both of these cases
> >> you brought up pretty easily.
> >
> > Thanks.
> >
> >> However I don't know what to do in the following case: We successfully
> >> collapsed some portion of the PMD, but during that process, we also
> >> hit an allocation failure. Is it best to back off entirely? or can we
> >> treat some forward progress as a sign we can continue trying collapses
> >> without sleeping.
> >>
> >> Basically, do we prioritize SCAN_ALLOC_HUGE_PAGE_FAIL or the
> >> successful collapses as the returned value?
> >
> > Thinking out loud, forward progress should win here, the allocation
> > failure only matter if we made no progress at all?
>
> Agreed, in the first approach, forward progress makes sense.

Sounds sensible to me.

>
> --
> Cheers,
>
> David

Thanks, Lorenzo
