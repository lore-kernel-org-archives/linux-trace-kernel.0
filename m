Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE8134677F
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Apr 2026 19:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775677698; cv=none; b=gH40uS3vf9JEYhhLmrQiKyEB9YDqAXjLgJbKzykleo9cDG/3elQC4X5ySqcV9FmpSArwgb88V4nyqXnan+VAhZyQQ/cOhXcPryCmYlJojzBDaVkr1QrU0LywfeHoubXyssMWS0G7N/OsHi86CyClLAily96eo6ze+4X3K4zpAI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775677698; c=relaxed/simple;
	bh=kcuf93EFkNLoVKl0b48bT1ldw0GbupHrhO89sqFB9nY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QsTw1ivYZ6Sv+qxOi4DZH6hjXmgF6Az5hlIK5eK7HXoX7T+aZGfvVDyZo3pzteYpSPz6+HFXpc3+L7zf1gPl3LDSDczR1CXg1/oUb0qBSSp9iRyI2s8ubQcs8Cwao2/FOfhisheneMv7VSkQ1/IHjFpnUR055J3C1MI1bJgucm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=recFrce+; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="recFrce+"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82a88a2704fso56310b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Apr 2026 12:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775677695; x=1776282495; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aSE638E7Oo0EzKCt6KnXRAv3sjqReWn6aOHcZy7PyI8=;
        b=recFrce+i2jQ/FoOARWx7hoEhPww5jXypTMW5CKphuzwz+hGmzrvrQ+a2CVhQGQVB+
         lCCay/8ihho7txYqNZAS77hUNiRmBN6+hKC+/h+VHUr/5m8+orEZyCyJadQfIee0LtZY
         r6SrifZDBev9PrT49NkMYNvocGxMQBsouLP/keYPdr7Em6fLPmKOyQp2JNTc4O0BkkIX
         am8HoXX7gvpYduz0lIzFR2/5qOcFh8LrOoJ1jaMWcMK4n4bSkE1VSV8l1LEO94+h7V4d
         Duqn492xMrhJL6dmk8f4kC0T+ryg/jBQPc5bo13D8fAlUs97GR9KccUYectX45GbeovJ
         Rv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775677695; x=1776282495;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aSE638E7Oo0EzKCt6KnXRAv3sjqReWn6aOHcZy7PyI8=;
        b=JIMAeVK31Teg2EUtT7Vm9ZXNHGAn2grQkakAji9Cps5MLiYImLi4UZd1P36qBMhgCS
         bGltbgIwfr50n9PPevSdQieBOaQVbZ85jGATCtPlBLhVTEaNB8uEp6XL+9svTmgQAVb0
         B9N9DOWyLxSgYRBlVezWx9rGGZfBzRridg6u38BjV5TIZmZvuwCRRrPhQY5NTLK8OJbc
         TVgVYNIZmwIuxgymchF5vdobaLSiKlO3qaYRjAO/DLslVGzE3bk/fEp7c8jigfcr522d
         f0xuK6Qg+omuujjgNSU6CxUd5nnDNRo1qVe7cTfBRTPghu3NXhBIcFjpcgmNOfuRQf/1
         Nghg==
X-Forwarded-Encrypted: i=1; AJvYcCXYc+Vf/g/K5LpwOYjhKbZF4PXpDhHh7CXnWr9i7+qCF9q43g95F6FDNgmGDCu/RrFmGBejdzROOceIOCy6bYkMj8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE58BtKK+dYUpo7M4TQXL3pV5fFK811BYRmzZl/r0hUvRFFIp8
	7u1mfbifJp3lzjYMgQ0excTU7xWywbyyc00jeU18Bkwhk+dnzFhCpkSJ8AdWcYxcOJhdXYLs612
	SWpFByA==
X-Received: from pfbea13.prod.google.com ([2002:a05:6a00:4c0d:b0:823:b9a:9230])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a01:b0:827:2ee7:baaf
 with SMTP id d2e1a72fcca58-82dd8aba4afmr575225b3a.12.1775677694713; Wed, 08
 Apr 2026 12:48:14 -0700 (PDT)
Date: Wed, 8 Apr 2026 12:48:13 -0700
In-Reply-To: <CAEvNRgEcKnHkgC2iK8hRMybruY5LrxWH+RK94M7MddUqgGChHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-10-e202fe950ffd@google.com>
 <2r4mmfiuisw26qymahnbh2oxqkkrywqev477kc4rlkcyx7tels@c7ple7kdgpo3>
 <CAEvNRgFkusZeKxGctUpTTbYjdi7nZL1ZZar-gT7XRUOCZ2xtpw@mail.gmail.com>
 <CAEvNRgGm9icDK8sK5ZfqHEOEqSbvjwtihE4p9d3vpBq-NfVjmw@mail.gmail.com>
 <CAEvNRgEtigp7+PVDkyu_DH947CUqDt312d+P+hWjjd2fHONiag@mail.gmail.com>
 <yvfwexsub7nrogh67hzcsupbrkzer6a7kbeao5tlq4elrzc2iz@xrwdjd7p32pp>
 <CAGtprH-kgRByFvvCYeWMXtsvpb6qpaWAo8k-3PEnioyPg-LEvA@mail.gmail.com>
 <nmy5polcxfnn3hoircsiqarxmzlulwwq7w34okanccntp32v56@h2eac44agovv>
 <adWidf8UgZeYctr1@google.com> <CAEvNRgEcKnHkgC2iK8hRMybruY5LrxWH+RK94M7MddUqgGChHQ@mail.gmail.com>
Message-ID: <adaw_aEJYTLgJcEw@google.com>
Subject: Re: [PATCH RFC v4 10/44] KVM: guest_memfd: Add support for KVM_SET_MEMORY_ATTRIBUTES2
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Michael Roth <michael.roth@amd.com>, Vishal Annapurve <vannapurve@google.com>, aik@amd.com, 
	andrew.jones@linux.dev, binbin.wu@linux.intel.com, brauner@kernel.org, 
	chao.p.peng@linux.intel.com, david@kernel.org, ira.weiny@intel.com, 
	jmattson@google.com, jthoughton@google.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 08, 2026, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> > On Tue, Apr 07, 2026, Michael Roth wrote:
> >> On Tue, Apr 07, 2026 at 02:50:58PM -0700, Vishal Annapurve wrote:
> >> > > So I agree with Ackerley's proposal (which I guess is the same as what's
> >> > > in this series).
> >> > >
> >> > > However, 1 other alternative would be to do what was suggested on the
> >> > > call, but require userspace to subsequently handle the shared->private
> >> > > conversion. I think that would be workable too.
> >> >
> >> > IIUC, Converting memory ranges to private after it essentially is
> >> > treated as private by the KVM CC backend will expose the
> >> > implementation to the same risk of userspace being able to access
> >> > private memory and compromise host safety which guest_memfd was
> >> > invented to address.
> >>
> >> Doh, fair point. Doing conversion as part of the populate call would allow
> >> us to use the filemap write-lock to avoid userspace being able to fault
> >> in private (as tracked by trusted entity) pages before they are
> >> transitioned to private (as tracked by KVM), so it's safer than having
> >> userspace drive it.
> >>
> >> But obviously I still think Ackerley's original proposal has more
> >> upsides than the alternatives mentioned so far.
> >
> > I'm a bit lost.  What exactly is/was Ackerley's original proposal?  If the answer
> > is "convert pages from shared=>private when populating via in-place conversion",
> > then I agree, because AFAICT, that's the only sane option.
> 
> Discussed this at PUCK today 2026-04-08.
> 
> The update is that the KVM_SET_MEMORY_ATTRIBUTES2 guest_memfd ioctl will
> now support the PRESERVE flag for TDX and SNP only if the setup for the
> VM in question hasn't yet been completed (KVM_TDX_FINALIZE_VM or
> KVM_SEV_SNP_LAUNCH_FINISH hasn't completed yet).
> 
> The populate flow will be
> 
> 1a. Get contents to be loaded in guest_memfd (src_addr: NULL) as shared
> OR
> 1b. Provide contents from some other userspace address (src_addr:
>     userspace address)
> 
> 2.  KVM_SET_MEMORY_ATTRIBUTES2(attribute: PRIVATE and flags: PRESERVE)
> 3.  KVM_SEV_SNP_LAUNCH_UPDATE() or KVM_TDX_INIT_MEM_REGION()
> ...
> 4.  KVM_SEV_SNP_LAUNCH_FINISH() or KVM_TDX_FINALIZE_VM()
> 
> This applies whether src_addr is some userspace address that is shared
> or NULL, so the non-in-place loading flow is not considered legacy. ARM
> CCA can still use that flow :)
> 
> Other than supporting PRESERVE only if the setup for the VM in question
> hasn't yet been completed, KVM's fault path will also not permit faults
> if the setup hasn't been completed. (Some exception setup will be used
> for TDX to be able to perform the required fault.)

Nit: as Mike (or Rick?) called out in PUCK, TDX's flow is now a separate path
thanks to commit 3ab3283dbb2c ("KVM: x86/mmu: Add dedicated API to map guest_memfd
pfn into TDP MMU").  I.e. it is NOT a fault in any way, shape, or form.

tdx_mem_page_add() already asserts pre_fault_allowed=false:

	if (KVM_BUG_ON(kvm->arch.pre_fault_allowed, kvm) ||
	    KVM_BUG_ON(!kvm_tdx->page_add_src, kvm))
		return -EIO;

so I think we just to add similar checks in SEV and the MMU.  This can even be
done today as a hardening measure, as the rules aren't changing, we're just
doubling down on disallowing (pre-)faulting during pre-boot.

E.g.

diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index 73cdcbccc89e..99f070cf2480 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -363,6 +363,9 @@ static inline int kvm_mmu_do_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
        };
        int r;
 
+       if (KVM_BUG_ON(!vcpu->kvm->arch.pre_fault_allowed, vcpu->kvm))
+               return -EIO;
+
        if (vcpu->arch.mmu->root_role.direct) {
                /*
                 * Things like memslots don't understand the concept of a shared
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 2010b157e288..f0bbbda6e9c4 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2419,6 +2419,9 @@ static int snp_launch_update(struct kvm *kvm, struct kvm_sev_cmd *argp)
        if (!sev_snp_guest(kvm) || !sev->snp_context)
                return -EINVAL;
 
+       if (KVM_BUG_ON(kvm->arch.pre_fault_allowed, kvm)
+               return -EIO;
+
        if (copy_from_user(&params, u64_to_user_ptr(argp->data), sizeof(params)))
                return -EFAULT;
