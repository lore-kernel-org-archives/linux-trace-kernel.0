Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787F5376A1C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Jun 2026 01:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782177768; cv=none; b=Il5C8XEaRWYFjmrzypUUVTRC8pP7/GRk4ToMLhw4rcJZPSc/CM7zhBt6wMklDilyTQobrpApul30uFtszLnBP/rfwCfi+sf8ic075f1WWXtOjWX42Nu8A4QmjXHzxM33KNI94qDMY8Taj8KBjFeJ9g0/5Yt0BOofFbU30J1edkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782177768; c=relaxed/simple;
	bh=dFe2FI4dOmbgg56+MmHgIOFrB/nhq/z0xCIy1SQ3BBI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mIs3JCdSIujjuwiLKqWFSKYxIavR2p0hvUC6CI6H4epIaj2ENEjv+wKXuwaEx1iwrDT6ssGpKi7RJDOZaEcPchzprxgxhKADwtDyiZz15MLDArkW7MPr6RSOuuPu1g+9l6aMcjO7Qx/S81HHItH2AnY4I4vUPGQkj32LjiXnoWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pZvVIr5q; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pZvVIr5q"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2c6c431a04fso49994055ad.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Jun 2026 18:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782177767; x=1782782567; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QZV3uH/IPwxj9lEYe1ZUXoqPM2qjMTtjeMRmC3XTGao=;
        b=pZvVIr5qCmoZ+VdSePQ6NSqlc/lXeCPf1u0qTCRN6pMvymiBXXbZ0kxfJ+w3eG7Nnr
         /tv3BiFFdX8v2DFVRMxFbFU2GaqEOPov2LXJJj08S/aX3iPuBqNJoAX5iG7WHUqeUiqn
         ZuOh+Agkq4Y0lzTO6UA1icEWLpBENNG78Z8UxdcUl4WaMizfVSW80xt4Lo5ICFXXRhAZ
         /+ugEyVe5JhOsBMB5W65l48O/sCzG1oVrF2p6dq/jnmrcJbZqn3nI+oyxql/oAOQ8gRA
         DlXoaH0mVXm4v7vRFvz0a0/qBeZtdz20nvt1hk1xzwZZGGHn7MFEVp1vDVlfAQJMs7rT
         oqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782177767; x=1782782567;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QZV3uH/IPwxj9lEYe1ZUXoqPM2qjMTtjeMRmC3XTGao=;
        b=s6aszbOrvDsLcy08Hsy+dG90BYJ9h9xiAVDSWVla8u7dSnicvM4qtkqNjKh//P++3e
         lc9jRQC+KOD9x6s6Eor9mUb6krVwu41PUnMY19Vmz9HeHYA0LVZiV2yT15+O4cIAZPC2
         3nwMe7D1u+PNwsyZrOXp2jCtLH3eJrd2Ep8LIHnyaIrxRAP7Z5sc+K+hjstZgKPGTujk
         EK0kqGsxNz+f1K//DYBPx6BPdd7BDhmoEiN0FFNMXtHNu+A+jPgpzHARFJW+URJF9Fe8
         KMgqRPEykuTYPKI8W9jpHiQQKvXVAZs7WvoycgYsXbEVDqcx+Qdlg2k/Fh9EVQjzGz9l
         ed7Q==
X-Forwarded-Encrypted: i=1; AFNElJ9RPnPrRy+7XTtZp4mfuImj+eP4I7Nun7S7BwnjZyxp5CISdl0JCt9vQJ69BL3lEO/bAA3kYNeeRV5dmuGFw9zo3+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0+90dd2s4Xa0IV93VCEhjj2TW1qeMs01MX3vZSKEGxB/BjXTP
	A8bf0sGrhLXkDhkxiErIOEY6JoDTcXLPF41TGjbD96ago7GchQr5dWMNwYwisJIfj/UUZtbQMUk
	szqviVA==
X-Received: from pgbck12.prod.google.com ([2002:a05:6a02:90c:b0:c8a:b173:5516])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d045:b0:3b4:904f:c9cd
 with SMTP id adf61e73a8af0-3bc5181907emr14837899637.6.1782177766311; Mon, 22
 Jun 2026 18:22:46 -0700 (PDT)
Date: Mon, 22 Jun 2026 18:22:45 -0700
In-Reply-To: <ajjc0hw8PjGw69e9@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-23-9d2959357853@google.com> <ajjc0hw8PjGw69e9@yzhao56-desk.sh.intel.com>
Message-ID: <ajnf5Z9nWZxoLS4x@google.com>
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

On Mon, Jun 22, 2026, Yan Zhao wrote:
> On Thu, Jun 18, 2026 at 05:32:00PM -0700, Ackerley Tng via B4 Relay wrote:
> > From: Ackerley Tng <ackerleytng@google.com>
> > 
> > Update tdx_gmem_post_populate() to handle cases where a source page is
> > not explicitly provided. Instead of returning -EOPNOTSUPP when src_page
> > is NULL, default to using the page associated with the destination PFN.
> > 
> > This change allows for in-place memory conversion where the data is
> > already present in the target PFN, ensuring the TDX module has a valid
> > source page reference for the TDH.MEM.PAGE.ADD operation.
> > 
> > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  Documentation/virt/kvm/x86/intel-tdx.rst |  4 ++++
> >  arch/x86/kvm/vmx/tdx.c                   | 11 ++++++++---
> >  2 files changed, 12 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/virt/kvm/x86/intel-tdx.rst b/Documentation/virt/kvm/x86/intel-tdx.rst
> > index 6a222e9d09541..74357fe87f9ec 100644
> > --- a/Documentation/virt/kvm/x86/intel-tdx.rst
> > +++ b/Documentation/virt/kvm/x86/intel-tdx.rst
> > @@ -158,6 +158,10 @@ KVM_TDX_INIT_MEM_REGION
> >  Initialize @nr_pages TDX guest private memory starting from @gpa with userspace
> >  provided data from @source_addr. @source_addr must be PAGE_SIZE-aligned.
> >  
> > +If guest_memfd in-place conversion is enabled, pass NULL for @source_addr to
> > +initialize the memory region using memory contents already populated in
> > +guest_memfd memory.
> > +
> >  Note, before calling this sub command, memory attribute of the range
> >  [gpa, gpa + nr_pages] needs to be private.  Userspace can use
> >  KVM_SET_MEMORY_ATTRIBUTES to set the attribute.
> > diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
> > index ffe9d0db58c59..56d10333c61a7 100644
> > --- a/arch/x86/kvm/vmx/tdx.c
> > +++ b/arch/x86/kvm/vmx/tdx.c
> > @@ -3198,8 +3198,12 @@ static int tdx_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
> >  	if (KVM_BUG_ON(kvm_tdx->page_add_src, kvm))
> >  		return -EIO;
> >  
> > -	if (!src_page)
> > -		return -EOPNOTSUPP;
> > +	if (!src_page) {
> > +		if (!gmem_in_place_conversion)
> When userspace turns on gmem_in_place_conversion while creating guest_memfd
> without the MMAP flag, the absence of src_page should still be treated as an
> error.

Why MMAP?  Shouldn't this be a general "if (!src_page && !up-to-date)"?  Just
because userspace _can_ mmap() the memory doesn't mean userspace _has_ mmap()'d
and written memory.  And when write() lands, MMAP wouldn't be necessary to
initialize the memory.

> Additionally, to properly enable in-place copying for the TDX initial memory
> region, userspace must not only specify source_addr to NULL, but also follow
> a specific sequence (where steps 1/2/3/7 are required only for in-place copy):
> 1. create guest_memfd with MMAP flag
> 2. mmap the guest_memfd.
> 3. convert the initial memory range to shared.
> 4. copy initial content to the source page.
> 5. convert the initial memory range to private
> 6. invoke ioctl KVM_TDX_INIT_MEM_REGION.
> 7. do not unmap the source backend.
> 
> So, would it be reasonable to introduce a dedicated flag that allows userspace
> to explicitly opt into the in-place copy functionality? e.g.,

Why?  It's userspace's responsibility to get the above right.  If userspace fails
to provide a src_page when it doesn't want in-place copy, that's a userspace bug.
