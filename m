Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E0B39A7EF
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 22:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782340275; cv=none; b=Xtbq5UODE18FJD3CDyGq1nu2JrCXL0capAfeqUp97e+h0dE1BcSE7aW74U9nlquGICbBVlfI8eeZyyovYTAav03yevi1+zeuXVSBov5iva7MSyvEMiT1w1jOjRnHFufW2mB/NxN8usHakt/nXZtj92C4Gt7/7Ms4Tjr1ilpXIPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782340275; c=relaxed/simple;
	bh=s5tBx/7xtCFykAIgDxBHorccHMTIs8SU+hRfK9pT/Nw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Bn/FctKSALZj8BkL3XJMYk5L8JiljQGRICiU9EQ07IDEH1snk3sRN3KV9yfppyz73vNeUUG1/IBJ/8TLsI1PVRvnw7ZW1kMoVvswaK2iF7L9FFzx8U5CO++CvK9KDWAsojO201V0Zq+ThdbKNpxsfudbQ2DYBHHTBqOmlopZMWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EjAQjfaF; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EjAQjfaF"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36d98b76d12so1078261a91.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 15:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782340273; x=1782945073; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9UD0cYPMpLMjUxZJI9vflj/wONeUt3vfrqS2YoALbAM=;
        b=EjAQjfaFYScuTkoPJfjJ6LK+MdTxG6Zk9x4khj6IDoWUaQlFvfIXu8Z4QCfqkLM+ff
         v68tqxa7HHquLcs0tZNIkkf72mznZlMUd3YSvqznibgvZu156GykKNwD5Ac0aajyi/Cz
         AefWecScLxsnYeTRSPTUbD8mGYvFTsTYzEGb6f2dZ5tFK3vF286dIK9ta1SwWaK58RMB
         toIHjHRo5OFribAqbW1eo/1nNfO1TD9DFDGv90hraSnm4G7ITX66NDpxYxYdNRjQUMvq
         dwEys/IZ5FiVU9Kb/CxmwqtoETUmdkX7wql+2zbsYVib1+P+Eq+iMq2JONqYCX9cX1gB
         gxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782340273; x=1782945073;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9UD0cYPMpLMjUxZJI9vflj/wONeUt3vfrqS2YoALbAM=;
        b=i6z4xofl0GjyETHVtqq8C0kMqMmnnHShIEq68cEKJUMOt5W+8pE0C5n7Yyd9OR97Tz
         ZBz6A1HiyKFuwRHyDiZ6iU8U5mewymodUFajzr9WgXOYL11qljADMELkPTKvx9RAbvlu
         H1wfiVR4GcsjmP4Fkqd8iy6wrG0QLqvQNuJrIfS2vN0QTv4En+Hqq/HINw9p+SeCE9Vi
         E2VV0FsC/cR0bttCL9SqL90eM7/nyMdpV7cRdaXU5NfEj2d+58Zlacg21vZVdE/vQ9Sy
         c3a94L5ptRpdLzpfiI4V8uU+CJ1fmx6s+0tGpK03Lx+X6Kl5XCgA37dB888MlLGR9CEG
         r5DQ==
X-Forwarded-Encrypted: i=1; AHgh+RoTro1xOFljOS3fUNW7CU0AWtXeR8E3rrKeCTcsKFmnG9ty1ZM+k4Io/9vOhotAIKOiJhgTxS+vYg8yn2yey3f5fZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXgplbZC2WiAQzzSjXBHNmW4jWiZplUuE8d48nGrjlMZ7N5D4z
	rHJfkRxHLY9+1lU8PNUx6dk9l8MRbAXPIVSq1bTjABMzjWo0ExKzksOSUhD8KNH/kyPKc/PTd8H
	Vp9Xa2A==
X-Received: from pjca15.prod.google.com ([2002:a17:90b:5b8f:b0:37c:64eb:faf7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b50:b0:36d:9e0b:3801
 with SMTP id 98e67ed59e1d1-37dd0d314c8mr11081058a91.8.1782340272872; Wed, 24
 Jun 2026 15:31:12 -0700 (PDT)
Date: Wed, 24 Jun 2026 15:31:12 -0700
In-Reply-To: <ajpGxu2uQys+S2F8@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-23-9d2959357853@google.com>
 <ajjc0hw8PjGw69e9@yzhao56-desk.sh.intel.com> <ajnf5Z9nWZxoLS4x@google.com>
 <ajoWngKaZ+wfIyR+@yzhao56-desk.sh.intel.com> <ajpGxu2uQys+S2F8@yzhao56-desk.sh.intel.com>
Message-ID: <ajxasFBzp_9KnQLq@google.com>
Subject: Re: [PATCH v8 23/46] KVM: TDX: Make source page optional for KVM_TDX_INIT_MEM_REGION
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: ackerleytng@google.com, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 23, 2026, Yan Zhao wrote:
> On Tue, Jun 23, 2026 at 01:16:14PM +0800, Yan Zhao wrote:
> > On Mon, Jun 22, 2026 at 06:22:45PM -0700, Sean Christopherson wrote:
> > > On Mon, Jun 22, 2026, Yan Zhao wrote:
> > > > On Thu, Jun 18, 2026 at 05:32:00PM -0700, Ackerley Tng via B4 Relay wrote:
> > > > > diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> > > > > index ffe9d0db58c59..56d10333c61a7 100644
> > > > > --- a/arch/x86/kvm/vmx/tdx.c
> > > > > +++ b/arch/x86/kvm/vmx/tdx.c
> > > > > @@ -3198,8 +3198,12 @@ static int tdx_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> > > > >  	if (KVM_BUG_ON(kvm_tdx->page_add_src, kvm))
> > > > >  		return -EIO;
> > > > >  
> > > > > -	if (!src_page)
> > > > > -		return -EOPNOTSUPP;
> > > > > +	if (!src_page) {
> > > > > +		if (!gmem_in_place_conversion)
> > > > When userspace turns on gmem_in_place_conversion while creating guest_memfd
> > > > without the MMAP flag, the absence of src_page should still be treated as an
> > > > error.
> > > 
> > > Why MMAP?
> > Hmm, I was showing a scenario that in-place conversion couldn't occur.
> > I didn't mean that with the MMAP flag, mmap() and user write must occur.
> > 
> > > Shouldn't this be a general "if (!src_page && !up-to-date)"?  Just
> > > because userspace _can_ mmap() the memory doesn't mean userspace _has_ mmap()'d
> > > and written memory.  And when write() lands, MMAP wouldn't be necessary to
> > > initialize the memory.
> > Do you mean using up-to-date flag as below?

Yes?  I didn't actually look at the implementation details.

> > if (!src_page) {
> > 	src_page = pfn_to_page(pfn);
> > 	if (!folio_test_uptodate(page_folio(src_page)))
> > 		return -EOPNOTSUPP;
> > }
> 
> Another concern with this fix is that:
> commit "KVM: guest_memfd: Zero page while getting pfn" [1] always marks the
> folio uptodate before reaching post_populate().
> 
> [1] https://lore.kernel.org/all/20260618-gmem-inplace-conversion-v8-21-9d2959357853@google.com/
> 
> > One concern is that TDX now does not much care about the up-to-date flag since
> > TDX doesn't rely on the flag to clear pages on conversions.
> > I'm not sure if the flag can be reliably checked in this case. e.g.,
> > now the whole folio is marked up-to-date even if only part of it is faulted by
> > user access.
> > Ensuring that the up-to-date flag works correctly with huge page support seems
> > to have more effort than introducing a dedicated flag for TDX.
> > 
> > > > Additionally, to properly enable in-place copying for the TDX initial memory
> > > > region, userspace must not only specify source_addr to NULL, but also follow
> > > > a specific sequence (where steps 1/2/3/7 are required only for in-place copy):
> > > > 1. create guest_memfd with MMAP flag
> > > > 2. mmap the guest_memfd.
> > > > 3. convert the initial memory range to shared.
> > > > 4. copy initial content to the source page.
> > > > 5. convert the initial memory range to private
> > > > 6. invoke ioctl KVM_TDX_INIT_MEM_REGION.
> > > > 7. do not unmap the source backend.
> > > > 
> > > > So, would it be reasonable to introduce a dedicated flag that allows userspace
> > > > to explicitly opt into the in-place copy functionality? e.g.,
> > > 
> > > Why?  It's userspace's responsibility to get the above right.  If userspace fails
> > > to provide a src_page when it doesn't want in-place copy, that's a userspace bug.
> > I mean if userspace specifies a NULL source_addr by mistake, it's better for
> > kernel to detect this mistake, similar to how it validates whether source_addr
> > is PAGE_ALIGNED.

The alignment case is different.  If userspace provides an unaligned value, KVM
*can't* do what userspace is asking because hardware and thus KVM only supports
converting on page boundaries.

For a NULL source, KVM can still do what userspace is asking.  Rejecting userspace's
request would then be making assumptions about what userspace wants.

> > Since userspace already needs to perform additional steps to enable in-place
> > copy, specifying a dedicated flag to indicate that the NULL source_addr is
> > intentional seems like a reasonable burden.

I don't see how it adds any value.  I wouldn't be at all surprised if most VMMs
just wen up with code that does:

	if (in-place) {
		src = NULL;
		flags |= KVM_TDX_IN_PLACE_COPY_INITIAL_MEMORY_REGION;
	}
