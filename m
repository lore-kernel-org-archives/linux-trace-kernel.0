Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E0C3DA7E3;
	Wed, 30 Sep 2026 10:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764119; cv=none; b=i7IOOSSKp+M/YfknkGsBBPPP6TNic2jFCQB6Ua79iS9+jjTlEdH154aJ2CI23DO6A2seAXauqKYHTM0IIdMEZjQiZnKtgvwo47Z/iO7damUWI0lE9YYA4EqrLUqmgK8zwIuMKr0E0M831s2phFsf+cdI3IRUlFCEjd8E9UcRHfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764119; c=relaxed/simple;
	bh=+YKSvw+J+7jyR16aky17JL7uQiLkoDOGI6/Tgsb5LPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMoYdC5yeQpoZvgXpSHDSxPlZCF9p2WECSXhBJIFWVS25cK+ZIFuTOUijdaYa+6qnkvGnMvPzctWC/Zv1Jgna7u4AGnah68RWIdk9XkUPFTaYuKXo8iT4IoMeXJvqAuESiCLwxCoJl0e5y9uOvn0YNkX2D/VCWSnSumF6XAlp8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gb7zXE9I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gb7zXE9I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6EE1F000FF;
	Wed, 30 Sep 2026 10:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790764118;
	bh=3AlfBCTmpruVCLkNFQRzrD/em+eWOpqKpyOiivU3oII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Gb7zXE9IoZs6cbj6Ja6aHJwZtGMS/ICAce6EWUxPoyYZD+wWn4JQB36ydNcIHy81P
	 Ix6KhornLVyu7QjQImjuYJQ6q3ut/Fpfea/s1Pxc6E9B/gYaAfai4tv658RbGEJV5w
	 c2FUbn7dDgVRndYi4OQH6cCcxSIYm4BWxmElD3MZlIFl78mR1DXuYpzw7KolJxBXXf
	 DG/sXJIz9HZBpHeGv5t+Hbz1DPI/xqH0NEWgu8GtDXVqzAS+LWJi2HH6uipj3+6Kyb
	 ynwz5InOjqSt/H9stD7inw5OssG4dusyaNgA1GOGAjyR7JwM8ARquCvuPpAC+nmpew
	 Jb/Z6N0cSvjjg==
Date: Wed, 30 Sep 2026 15:55:34 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Michael Roth <michael.roth@amd.com>
Cc: Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	Vishal Annapurve <vannapurve@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Youngjun Park <youngjun.park@lge.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
	Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Fuad Tabba <fuad.tabba@linux.dev>, Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, linux-coco@lists.linux.dev
Subject: Re: [PATCH v11 15/46] KVM: guest_memfd: Call arch make_shared
 callback for to-shared conversion
Message-ID: <arzjFT1Fqzcuw9QM@blrnaveerao1>
References: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
 <20260826-gmem-inplace-conversion-v11-15-0a15d8a799aa@google.com>
 <ao9CKMXAX-hScRSa@google.com>
 <art6ARechyK0iytK@blrnaveerao1>
 <gqybhgtzeufmbohckesirsbu3ftn4s4i3uhjhaestphuppvth5@zx7lqsldosbc>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gqybhgtzeufmbohckesirsbu3ftn4s4i3uhjhaestphuppvth5@zx7lqsldosbc>

On Tue, Sep 29, 2026 at 08:01:45AM -0500, Michael Roth wrote:
> On Tue, Sep 29, 2026 at 03:10:41PM +0530, Naveen N Rao wrote:
> > On Wed, Aug 26, 2026 at 12:44:40PM -0700, Sean Christopherson wrote:
> > > On Wed, Aug 26, 2026, Ackerley Tng wrote:
> > 
> > Can this be a problem with gmem hugepages? Not sure how that is going to 
> > look like, so this may be covered in other ways.
> > 
> > But, as it exists today, if the guest converts part of a 2M page to 
> > shared, then this skips zapping the SPTEs from the call in 
> > kvm_gmem_invalidate_start(). sev_gmem_make_shared() then issues PSMASH 
> > to convert RMP entry to 4k entries and we end up with 2M NPT+4K RMP. If 
> > the guest then writes to any private page in that range, 
> > page_fault_can_be_fast() returns true, fast_page_fault() only checks 
> > permissions with spte_permission_fault() and does not do anything.  
> > sev_handle_rmp_fault() also does not issue a zap since it finds that the 
> > RMP entry is already 4k, and we end up in a loop.
> 
> In Ackerley's hugetlb series, gmem will split the underlying folio to 4K in
> that case. I assume, if we end up adopting Sean's proposed optimization, we'd
> update the attr_filter to force a zap if there's a demotion, similarly to how
> kvm_gmem_punch_hole() handles it in this series.

Ah, nice - that would be better.

> 
> I think as a general rule of thumb though we'd decided that guessing
> too hard at what hugepages will need is best left to hugepage series
> itself (TDX prep work aside), because it always ends up different than
> expected :)

Got it, that makes sense. Will consider adding WARN_ON_ONCE() so the 
dependency is clear.


Thanks,
Naveen

