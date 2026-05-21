Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E47396561
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 07:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779348019; cv=pass; b=SMRmQMkMSgH/Dufwru02brkxLULHBs3n6j8tTx08HvMSSDdj7nEXyiL8XC70vQrrk2B0x3egRr27qKHHvydfDbrwC/W6J3hEDHcmJtdcWA1EKA45r2ZkawVd8Mqf9LpKIwzqDJIARW9BU+xQiTvrHEcrI/rvvGaIWFgMYAwzETg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779348019; c=relaxed/simple;
	bh=H/h4INyZwih10l9AYdvongdVpuQiBkGMfR0jm2vWFLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=scL1thkM13EPKxGTvXKvHjJjeDmItUzqpqXCEqfsj/AYnjaI8j//Cnu2fmcVLSOaMUSnn3d35QBvTgLA0C0I43ZGvAu1xzeV5l9TKd5DkrX4rTrEJZvFCv8lcyPPaU9sr/Y1oK/LcRvsd6r2DzuLxgYpuO+bX4Pfb36YqLThGI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fyly2srd; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fyly2srd"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50d6b393d60so8491cf.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 00:20:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779348014; cv=none;
        d=google.com; s=arc-20240605;
        b=hK1XUrPIUK76ifP40lobxM41XDSEr2fOeq+9qJlAhC0VV/0UB/0QDEdlfgkWvPIaLJ
         X8Npf5TTgrCesgSFVaP/STF3Zur3UMUaSnLbOvd+WFlKFkX1FFbi2CeiVRioRc1uB28M
         QuUaWMR8bUOw+pdFmHQO2vji9wztHQbolUfiUlFJzqq4isHkgiH+N3HYoeHxQMWP4fvo
         56ZfTt/AcwgoEJeXQvX0GV7fgI2hFqc+lyayRN0c4pXg9iDziqWKzYu8W2YZVFxcJ7AS
         JeoyhnXesbi8uAZ/y6kAe4x+dQNlZ4v1/YKPfN9e1TNkBGf/8J916QFJlAtzGje4kJMe
         naSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4lV/LRyXdVcEtETS6N6JX0KnOiUE4cogpgAqkVQgk4U=;
        fh=8XhJIZa9MYT8gXFqCa1t9lHsjbgRgR6dMjnVHNyLRsc=;
        b=I0G165kC54IwePT7eHxkghnkosgotOgjTt67sd24kPYSbRK2+D5ihM+Qfq358Kn0Uk
         wwyYx46pAKD4d54yikKYYZAIohcV7FOlnxf/IuEz4YkMySKTOW6nTA4+rPmFS9bLspsF
         MCdAUYrNnNPE/gzwGS4e0Bpdv3LdVHEV0FCY+2MU/+cur3BHH8TyHJ92wY8at/UKadmO
         qVCszm4ZPJvgwXKeD9WclTy6JRN2kUg/2lEWrWQmC2PWY/biF4XZ76wDmyNrsxn0f5cU
         xt10UpJi2lVg1+/WNwCNuV7AU2ENVz5WBt0mQEEbmvEmIDybRNcOv5DuRlbOChA4NdVM
         1iKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779348014; x=1779952814; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4lV/LRyXdVcEtETS6N6JX0KnOiUE4cogpgAqkVQgk4U=;
        b=fyly2srdJ7tcPl2lAK8guLcb3fiIWl6RTdKuTX8jkxwxW2ZAZyEyJcwv2Xw4TtmXD5
         hxq4KFty2izzMPCByiD59tCE6dHyVxzhA/c7kG2bdzqczha9jDEzsJ3yX8NrSZVzq1Ms
         zkem2q9fVbYVIkSVbuJN8Baqr/W2kxIIUYw4kMQFsUMXuzrQkuLVJiqvgNHcWXv5Zm05
         L/vUwJnQG4wEOHdz76nl9kUPZEEzFytezUI3XMbtQDJKTJBg+O5m7/Cx5N/i94CDvS3F
         /9+1m338rLSNNw30qDf74hit3cLbq8LLg6ptmsmQ+sYXBUi0CetlKmXTxYOoq40SW3ea
         XS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779348014; x=1779952814;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lV/LRyXdVcEtETS6N6JX0KnOiUE4cogpgAqkVQgk4U=;
        b=Yl9TeL6B/FEMl+mUf6bzAgHJEudLsd/ixVU/67uXGhdZL5piesgkjuC550zWsiIWbu
         7yMQTa4A3Ox6HFExQu4nUYD88iR2dHZ/Jy0oKmQz0DTT6vWbm/rS8dTyAryM6N2xPOAt
         0MeuZxB6CuMf6e6jdOx49D6LDNru5kiPjmiM8voanwa2Ki5gVoDIknwdkZBriAf+UlB+
         JdkOwgPYieIfZvC235BHdQOHO1SRWO1zKmyktcoOawfV+qztetb6F8V8bh3wrL6L2F1o
         7vmk4DKSKQb0IXZsI+BmXX8+7zexx8zNQ4KDIAWPycrYdJyV2ZrEI7tXiGS91B1727te
         YxRA==
X-Forwarded-Encrypted: i=1; AFNElJ85gyVcwkPBfOZnA98N3Qv8+N9e0uj9mIxvnNeklfBQ76FgAkzMqIwlB5GtJXDx319t2iWo0PjXKYWLLPwVRVJXkZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA1j/mOEZ4elW/5IVYnqjxFv+0CwhEBrGDuIhhXVFhof89tOOc
	K2kerw3h0j6Ph2RDA8JxtA/+/quVKAYR6Ty7eVXDENGm+s3uL4A/BPLwtAU821TsLVjYH1chjSS
	Dd6DpELlEbNKTga8pmCirqOWr0Y0Q5NjabDJGTcA/
X-Gm-Gg: Acq92OEhTZ02pb46P/LU6ayVmUo6SM2kCR5zkvAd373z8qFDgU8ZVjbs0zib2R0sHkd
	fUjOpnuZbmjn/HrwVckD5F2y/MVY6E3AS/UkN9op9/cSKFqIrpX5xpTzU9WoaERzxYjsmk3ehwV
	TkXGjgw5ljI0wzBm1O+4g06lvUEblOYG8SpqdnZrOGnno+gV+OE78a/AU9U5A0+cz1kx/mmd+Tg
	RJE8OvVBnWkPqVnBZGZL/UuuZhu+RX2UH2pR4U2XhUKdcR29LaR4FX+9M5qdsEMuIMzuumSvI7Q
	qMjxIASPyo3OkqIIcwE=
X-Received: by 2002:a05:622a:8c09:b0:50e:41f3:6467 with SMTP id
 d75a77b69052e-516c545d431mr5347341cf.12.1779348013286; Thu, 21 May 2026
 00:20:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com>
 <20260507-gmem-inplace-conversion-v6-5-91ab5a8b19a4@google.com>
 <CA+EHjTw-cUM=FrJevtSDtR7K6MwUfGfOx21LMFDn7DAy5bFzYw@mail.gmail.com> <CAEvNRgGQvMdDmVfbk42EY_PGN0ybTp-x21Zj+pg_X1mk9iCRtA@mail.gmail.com>
In-Reply-To: <CAEvNRgGQvMdDmVfbk42EY_PGN0ybTp-x21Zj+pg_X1mk9iCRtA@mail.gmail.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 21 May 2026 08:19:36 +0100
X-Gm-Features: AVHnY4IfKawE844Bbti7f163iVDDGQdLfAc0aSSibjPNKnZdr2ZvCDCMhO5buRs
Message-ID: <CA+EHjTzLCD-dU-euZKgzwyEr2ecPqFDNutcaHm2fCDGA+MHVXA@mail.gmail.com>
Subject: Re: [PATCH v6 05/43] KVM: guest_memfd: Wire up kvm_get_memory_attributes()
 to per-gmem attributes
To: Ackerley Tng <ackerleytng@google.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 May 2026 at 22:44, Ackerley Tng <ackerleytng@google.com> wrote:
>
> Fuad Tabba <tabba@google.com> writes:
>
> >
> > [...snip...]
> >
> >> +unsigned long kvm_gmem_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
> >> +{
> >> +       struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
> >> +       struct inode *inode;
> >> +
> >> +       /*
> >> +        * If this gfn has no associated memslot, there's no chance of the gfn
> >> +        * being backed by private memory, since guest_memfd must be used for
> >> +        * private memory, and guest_memfd must be associated with some memslot.
> >> +        */
> >> +       if (!slot)
> >> +               return 0;
> >> +
> >> +       CLASS(gmem_get_file, file)(slot);
> >> +       if (!file)
> >> +               return 0;
> >> +
> >> +       inode = file_inode(file);
> >> +
> >> +       /*
> >> +        * Rely on the maple tree's internal RCU lock to ensure a
> >> +        * stable result. This result can become stale as soon as the
> >> +        * lock is dropped, so the caller _must_ still protect
> >> +        * consumption of private vs. shared by checking
> >> +        * mmu_invalidate_retry_gfn() under mmu_lock to serialize
> >> +        * against ongoing attribute updates.
> >> +        */
> >> +       return kvm_gmem_get_attributes(inode, kvm_gmem_get_index(slot, gfn));
> >> +}
> >
> > Doesn't this imply that all consumers of kvm_mem_is_private() should
> > validate the result using mmu_lock and the invalidation sequence?
>
> Let me know how I can improve the comment.

Given Sean's context, the comment is good I think. I would quibble
with the the "_must_ still protect" phrasing being a bit too strict.

Maybe just soften it slightly to acknowledge the exception? Something like:

  * lock is dropped, so callers that require a strict result _must_ protect
  * consumption of private vs. shared by checking mmu_invalidate_retry_gfn()
  * under mmu_lock to serialize against ongoing attribute updates. Callers
  * doing lockless reads must be able to tolerate a stale result.

That aligns the comment with how KVM is actually using it today. That
said, this is nitpicking. Feel free to use or ignore.

>
> I think the "consumption" of private vs shared here actually means
> something like "don't commit a page being faulted into page tables based
> on the result of kvm_gmem_get_memory_attributes() without checking
> kvm->mmu_invalidate_in_progress.", since a racing conversion may
> complete before you commit.
>
> kvm_mem_is_private() is used from these places:
>
> 1. Fault handling in KVM, like page_fault_can_be_fast(),
>    kvm_mmu_faultin_pfn(), kvm_mmu_page_fault(): this already handles the
>    entire mmu_lock and invalidation dance. No fault will be committed if
>    a racing conversion happened after kvm_mem_is_private() but before
>    the commit.
>
> 2. kvm_mmu_max_mapping_level() from recovering huge pages after
>    disabling dirty logging: Other than that it can't be used with
>    guest_memfd now since dirty logging can't be used with guest_memfd
>    and guest_memfd memslots are not updatable, this holds mmu_lock
>    throughout until the huge page recovery is done. invalidate_begin
>    also involves zapping the pages in the range, so if the order of
>    events is
>
>    | Thread A                     | Thread B          |
>    |------------------------------|-------------------|
>    | invalidate_begin + zap       |                   |
>    | update attributes maple_tree | recover huge page |
>    | invalidate_end               |                   |
>
>    Then recovering will never see the zapped pages, nothing to
>    recover, no kvm_mem_is_private() lookup.
>
> 3. kvm_arch_vcpu_pre_fault_memory()
>
>    This eventually calls kvm_tdp_mmu_page_fault(), which checks
>    is_page_fault_stale(), so it does check before committing.
>
> Were there any other calls I missed?

The one I was looking at was `sev_handle_rmp_fault()`, which does a lockless
read without the retry loop. But as Sean just pointed out, that path can
tolerate false positives/negatives and relies on the guest faulting again,
so the lack of synchronization there is existing behavior and considered "fine".

>
> > sev_handle_rmp_fault() calls kvm_mem_is_private() without holding
> > mmu_lock and without any retry mechanism. Is that a problem?
> >
>
> Sean already replied on your actual question separately :)
>
> > Cheers,
> > /fuad
> >
> >
> >>
> >> [...snip...]
> >>
