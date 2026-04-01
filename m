Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF8F369985
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Apr 2026 21:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775079830; cv=pass; b=mIeZIJUK9D1/NQiQWmewV7K/KtWtlr6vCn2jOFJXjd4pQI1w4B5hUSUKVRT+dMOH9O+PkEbYct49g0AVkZEKBcpF4iatNJzN82M2yHE5PamfIdgueEVz5BCvlBCIULnvSBHqnlNw2aFhyCoFcy4rMB3d95B7kLcrrwAIcBr/wBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775079830; c=relaxed/simple;
	bh=Lqc2gSCGX27KLO8cR8TH/YramgapK7QqVjWuHRiu0ag=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l6KEUGQevtPnAojtW0iz0TKzvry3hBo3J0kiUM4Dg3S0CTAoZ720WmNTzArveMMea+Ude4OIB+nIT2POyVpWFQ4KbBeezVkLoPhQrhMSEKRXtjBHNlY04eghjKYyqVAMO7Biqo6yQ4TLi9QUjOq7tIQ1+GCu8voQmn9ErIYzHuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oE/hf/W6; arc=pass smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oE/hf/W6"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-951c5ac6253so80199241.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Apr 2026 14:43:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775079827; cv=none;
        d=google.com; s=arc-20240605;
        b=L2c9pPSZagWzK/9PveuMQlvUIdBwqRXkwC4n8tMXJY3QkWMc3kM/DgaZ13UCGQZVAl
         2hWsssyW/S6lB4Pw8ki/fEqNeDGcoshQeGyKK4ek80VjHjTSw53xFUql4wnmbu5PwOp4
         7ouPgVS1V478YSRUWUd0CN7fnonhPI0QWp7cWh0LGHW6EtqbxuTTqVvOSv80ED0OJUkt
         AVfAow8D+r6QjC3d6itpj6Z+620KULFttyJEJ++L7VIe7vBx9oeF4ZfNzoXsVRalre9n
         m9FtIbLCXt9GkLf8yVttl/fQc8tKsC+hRpnz6m/c7ZMRY1k85UGRcVYr7BsDhUVgmdhf
         q3kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=1YVI0hayK/pE2zwI/10lFSwnfbjn36xvcFyuXZ+58V8=;
        fh=go4Kfj5qYxEPrzzXuf99xxmNHFiu+xOaVNqqeer1btY=;
        b=AZZe1yHF7IwP+wRmaVonDLNzqXYG+2EOYS2SKDgv19h+VsvyL6Dm02/G/e4TXOrprj
         bvRFIq0dzCr+9FIqk8zv4FF8C96jSQOmG2vVQgFCNKgtZCgF4zRCnzU6eZhxHk3ipwc5
         XlYzadwYh61S30gJua+13hKTWWBLPS1yF23xPlzNfWeJ23xk5YOAMUsjPEk91GdgPnu/
         X2IZgnhGFk16jh/S0HBKkixvvENb7LjvzFGTxTbttycU8EEZHRLApCPnyUA4Yq8bH3b6
         coG8a7AhXqJaYVWw7YwYUeJcn+fUJCkphQQ206u3KzwKCJqpYFKQ7shml3y5QaDle6hM
         b9mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775079827; x=1775684627; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1YVI0hayK/pE2zwI/10lFSwnfbjn36xvcFyuXZ+58V8=;
        b=oE/hf/W65b7KEFAO6JVRtuEeQYfeoO8U2BZ2WTeOd+yKxhEBzT9yQSZqpsVsj7/r8V
         0SjaY5SxpPv3KvypX8YNjB8ZqoWGquXdzgu9zYeLWhgIE8ALLaQmN8+rwi04B6E6Xz/2
         CtvfqtaTEWLYazKbkBLD7ItAXpGwOX1UYdcbFQEsNnPvqlIwLQ32oN9W52+71qLwK7yp
         xkzUhhE0bNr7ABQMEb3gIeiB39R/RwMVzOjwB7cRmvUYi/M/jdQ+pYyaQSFSwf/+hFYV
         WGAz2lIHQk9/m+dVvmDj2C6+H7ReV73F155tSCO1+Za1+goV3KiJ6QB2DjT4ja9xE4Nb
         zTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775079827; x=1775684627;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1YVI0hayK/pE2zwI/10lFSwnfbjn36xvcFyuXZ+58V8=;
        b=VmgmiZxzxEwDA3r2aZ12Y/D/qLMwU/z/U5w1XRoeBKXQDBulFa7xiYUfoc3ri+Gp32
         6DiTVRYFltU+jHEJptGeD8eUOQSqVRYaGMa3CQuz1fCeN3zz2rwOceloxm7QdPaUJmjS
         rQ+eIdBQicyiG5CjGjUIomtdztcM9IkGGQ6K7KbTNVqnX24eZJjKOZv0jV3qhLvnVSii
         yVOc92EgMpshr71eDp9sUB2CVtXcrknLmSrDE+NnR9MdZmNPODDF3KlVBBQhXzeIPV6B
         1NPlq+CAAvcb0bCM+wKeJMktNUpmRow4XTpmV1g0SO56bsq76SXQPwfypGnrJ5yFtNec
         SNGA==
X-Forwarded-Encrypted: i=1; AJvYcCUb0ltuJAyzLL0vGPVhoG/+JLO4fBc3w2Nf0En9pvZFgPwjzP+78onwguDUeC5Zw7bszsoCk6epQjfCl0oMmSWQqko=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOMCpFrz3qqTOA2lbYiTNN15mnc7r+dbKPqApJMjb7ROXRqFMq
	7/PzSpirqSy3IXuTg2Q/DBR3UOK2mj+GO5puWkPNvXbpT6E5tUxDPu4421JkhswlSFO5qvURuLi
	dK5sLwjGWcdM32f4mSc0NMJ6sfYQzWL+ID2cTpQBE
X-Gm-Gg: ATEYQzzJ3rvihHkuaC4GmTv3b74tp0uKaA7mqhFLlDEJGn2js4y/OT+A1Z2CwWHLMbC
	a0b9+GfX1Ne8mNEOqMiHO5B9iUkylo48NiyQLSkhpINdklG3pL2K1qBRrmXPWFIO5xSHBmMDcD1
	yuoBO73Uv8hnkg8AayX7u0Ywp5uH514bpDdN6uAlnjzq3bwVdxY7ckN0xhTehf/MThBPPTH3Y9/
	CFNkIDu2jOwhyEiPFDGh0uRSV77VQ2ouS+M+lgRyRaUDoJ3AL0hdxTTR0wv1Ss34KkXnuOPNiBW
	IeC+pzaTJxlkeRNvAnJ619/jYCxIYTkbQ9GihHt/Gra+n2HucQdwhHdl6XNHPYhWALwHAZGwnh7
	R8yvf
X-Received: by 2002:a05:6102:14aa:b0:5f5:4055:4556 with SMTP id
 ada2fe7eead31-60583dd2d96mr513571137.4.1775079826765; Wed, 01 Apr 2026
 14:43:46 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 1 Apr 2026 14:43:45 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 1 Apr 2026 14:43:45 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <s4dbqrv2c6yzt4nsflfarnggtl25xlz6mzg74tfeg3eskceno6@6l5hpfmcbju3>
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
 <20260326-gmem-inplace-conversion-v4-7-e202fe950ffd@google.com>
 <CAEvNRgF+FjJ1EWSR_rzD1=N040ZitiRrM2O3N0Kj5yN5rT3h+Q@mail.gmail.com> <s4dbqrv2c6yzt4nsflfarnggtl25xlz6mzg74tfeg3eskceno6@6l5hpfmcbju3>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 1 Apr 2026 14:43:45 -0700
X-Gm-Features: AQROBzB6Nm5vUeDCJFrJRBVH_sKZ67O9qJoiuhUvd8m5ueyFjs7DkYFcGmC74e4
Message-ID: <CAEvNRgFQU6daGzYY1nTm=9omJ7ca3Eam3DuWRZPeRpYRiYM2fg@mail.gmail.com>
Subject: Re: [PATCH RFC v4 07/44] KVM: guest_memfd: Only prepare folios for
 private pages
To: Michael Roth <michael.roth@amd.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jroedel@suse.de, 
	jthoughton@google.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Michael Roth <michael.roth@amd.com> writes:

> On Wed, Apr 01, 2026 at 07:05:16AM -0700, Ackerley Tng wrote:
>> Ackerley Tng <ackerleytng@google.com> writes:
>>
>> > All-shared guest_memfd used to be only supported for non-CoCo VMs where
>> > preparation doesn't apply. INIT_SHARED is about to be supported for
>> > non-CoCo VMs in a later patch in this series.
>> >
>> > In addition, KVM_SET_MEMORY_ATTRIBUTES2 is about to be supported in
>> > guest_memfd in a later patch in this series.
>> >
>> > This means that the kvm fault handler may now call kvm_gmem_get_pfn() on a
>> > shared folio for a CoCo VM where preparation applies.
>> >
>> > Add a check to make sure that preparation is only performed for private
>> > folios.
>> >
>> > Preparation will be undone on freeing (see kvm_gmem_free_folio()) and on
>> > conversion to shared.
>> >
>> > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>> > ---
>> >  virt/kvm/guest_memfd.c | 9 ++++++---
>> >  1 file changed, 6 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> > index b6ffa8734175d..d414ebfcb4c19 100644
>> > --- a/virt/kvm/guest_memfd.c
>> > +++ b/virt/kvm/guest_memfd.c
>> > @@ -900,6 +900,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>> >  		     int *max_order)
>> >  {
>> >  	pgoff_t index = kvm_gmem_get_index(slot, gfn);
>> > +	struct inode *inode;
>> >  	struct folio *folio;
>> >  	int r = 0;
>> >
>> > @@ -907,7 +908,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>> >  	if (!file)
>> >  		return -EFAULT;
>> >
>> > -	filemap_invalidate_lock_shared(file_inode(file)->i_mapping);
>> > +	inode = file_inode(file);
>> > +	filemap_invalidate_lock_shared(inode->i_mapping);
>> >
>> >  	folio = __kvm_gmem_get_pfn(file, slot, index, pfn, max_order);
>> >  	if (IS_ERR(folio)) {
>> > @@ -920,7 +922,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>> >  		folio_mark_uptodate(folio);
>> >  	}
>> >
>> > -	r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
>> > +	if (kvm_gmem_is_private_mem(inode, index))
>> > +		r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
>>
>> Michael, I might have misunderstood you at the last guest_memfd call:
>> sev_gmem_prepare() doesn't prepare a page for being a shared page,
>> right? Does this work? That prepare is only called to "make private"?
>
> Hmm, I guess your guest_memfd-inplace-conversion-v4 branch is out of sync with
> these patches?
>

My bad, it was. I just force-pushed to github to synchronize them with
this patch series.

> I have the below local patch based on top of that for SNP-specific enablement,
> which is basically identically, so suffice to say: yes, this should work
> for SNP :) If any architecture pops up that needs to do some prep in
> advance of mapping shared pages, then we could potentially plumb the
> shared/private flag through to the arch-specific prep hook, as was also
> suggested on the call, but it doesn't seem like that's needed by any
> users for now.
>

Thanks for checking :)

> -Mike
>
>   Author: Michael Roth <michael.roth@amd.com>
>   Date:   Mon Oct 27 07:58:32 2025 -0500
>
>       KVM: guest_memfd: Don't prepare shared folios
>
>       In the current guest_memfd logic, "preparation" is only used currently
>       to describe the additional work of putting a guest_memfd page into an
>       architecturally-defined "private" state, such as updating RMP table
>       entries for SEV-SNP guests. As such, there's no input to the
>       corresponding kvm_arch_gmem_prepare() hooks as to whether a page is
>       being prepared/accessed as shared or as private, so "preparation" will
>       end up being erroneously done on pages that were supposed to remain in a
>       shared state. Rather than plumb through the additional information
>       needed to distinguish between shared vs. private preparation, just
>       continue to only do preparation on private pages, as was the case prior
>       to support for GUEST_MEMFD_FLAG_MMAP being introduced.
>
>       Signed-off-by: Michael Roth <michael.roth@amd.com>
>
>   diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>   index 3acc6d983449..4869e59e4fc5 100644
>   --- a/virt/kvm/guest_memfd.c
>   +++ b/virt/kvm/guest_memfd.c
>   @@ -1249,7 +1249,8 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>                   folio_mark_uptodate(folio);
>           }
>
>   -       r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
>   +       if (!kvm_gmem_is_shared_mem(file_inode(file), index))
>   +               r = kvm_gmem_prepare_folio(kvm, slot, gfn, folio);
>
>           folio_unlock(folio);
>
>>
>> >
>> >  	folio_unlock(folio);
>> >
>> > @@ -930,7 +933,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>> >  		folio_put(folio);
>> >
>> >  out:
>> > -	filemap_invalidate_unlock_shared(file_inode(file)->i_mapping);
>> > +	filemap_invalidate_unlock_shared(inode->i_mapping);
>> >  	return r;
>> >  }
>> >  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_get_pfn);
>> >
>> > --
>> > 2.53.0.1018.g2bb0e51243-goog
