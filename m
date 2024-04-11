Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12EA138480
	for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Apr 2024 18:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712858885; cv=none; b=hQIPvdp4cEV68tCZ4CTAR/QvBYYlAMVZfiKeY/4b5bZi4vTt/FjOBxN8xkvFpXO4jp8VJQ7/3ftulOtHYesFOUwOxyIeVIDSKflNLKKIqqL3dHdQVPN/zOtbKLgWPqkoRnx1zmoU3Ubqaepxr9Uoihp5ObZIMsPQz7xK2pWzJO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712858885; c=relaxed/simple;
	bh=VGQCL3mzonvhlfeFM/FLLnPemQv3LzNNv5aOxHxA3fw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T4Dz41MUc7BmGL4RqA7XH/DKzVCjRbCiLlGDyZyG/Jen7B/MFBHbjJCG6VRxwgbFVAMcU6MKkzhxmlvaiYA+hZa7/Z8l2iQelg+9D2hBtapCyeqSfMdC4xMJgWUPEAtLbKTzSyVfMFgPIGGsU0ItiHOJbTWDiY4Z4Iw3XoY4keg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zWrAwXEd; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zWrAwXEd"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-343e46ec237so19049f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Apr 2024 11:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712858882; x=1713463682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JF9ah2ntSllTmBnh03qU9h5oVsQBiEEOr0oLbxSFsGs=;
        b=zWrAwXEdVUItApaRoHDqqtiDmciPtO0gWHOqh1t0Yysmv6oaYFoS1nJf0vi75vYu3D
         MxaagZAwHGCUv6mnyRFTRVa8Alui/moY5kEan3o38nnE1hRnywdtgQg9BhBGLIeNuJYx
         f2DRYuJhYuqFOUFageLqogRQsV9iHWrQYsEkpab0K/BKaNkjc1lFQ/AojQBx0gWdA6Jn
         8nP+dD6dOfi3sJyznt+z7qtEiSYdcXBteWo7ZHbrMeafceUlgJyh9T7SE6nnhmf9k1Q1
         PkFgwlS67jkQs+uOYMFwYruASCizC11JPC/ZrEWknToJhj8bqNUcSEOkVnnIUT+payXq
         5dfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712858882; x=1713463682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JF9ah2ntSllTmBnh03qU9h5oVsQBiEEOr0oLbxSFsGs=;
        b=Sofcv4toUU91IH8gXBwUQYqeuGFz+obTqDEEe+viazHSdBlQycUP/c2KPd8+Cioo6f
         dmjbhAP/U2Q0/Tq9JxSRtbSHL/ImY0zQVHJtmU1VB9029g+iWeB+YbBNtPLFFe8avjjp
         FHqvQEF/hhUUHB6Ojl0psNs5atABsJukKKkt2WG+2LUp2A6U0/DQqeoVlSsKg5Td8TB+
         OM00V/3W4e3AUIPJZ0Mg57ik9nKdk3ZXBPUH3E8tf4VkRAmTKQ+ggp4X+3q8WNp3nuid
         +vieGjn4K+EjSZHDLYXS+74uPCp8RSEBDWS3XqTe4EDF2K0YYSOj5P8Js99sygtkm4ec
         zxgg==
X-Forwarded-Encrypted: i=1; AJvYcCXMctWoI6LRIpXClW9Bh2b3bscKr8kREo7RbBnYz9A/V5v8ojpNoSELuooyZgPtrpXtZfBccKee6EX0dT2SBnJ2o/D9fmdOKKhoq7lO4Ftxw7T0
X-Gm-Message-State: AOJu0Yyj8mB8U/0MNMaK4YtPO7orGv06NHc8iLmwZbKeKNmXoc5b1Mcn
	lprDObMi3aCgU6USAuHFlD/ZfT2GNqnxzonQ5lhsHGUq9eeQxwntKQ6/Hcdckjd1IAvgOjrs5/i
	xlgOQxfHSVuUld9ejVpSF6WUCuBgR1SZOAVkq
X-Google-Smtp-Source: AGHT+IEiceYluBXhzFycxHV9lNDFzL73YQ5JDtztY+Gf/8JctaddlSPwXQ5PFONIuLRV5abA4HCPeSQtllcEjNpQPdk=
X-Received: by 2002:a05:6000:eca:b0:346:bc1b:4efa with SMTP id
 ea10-20020a0560000eca00b00346bc1b4efamr230532wrb.32.1712858881999; Thu, 11
 Apr 2024 11:08:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401232946.1837665-1-jthoughton@google.com>
 <20240401232946.1837665-6-jthoughton@google.com> <ZhgZHJH3c5Lb5SBs@google.com>
 <Zhgdw8mVNYZvzgWH@google.com> <CALzav=f=_+UQBJv_eZ=t5wE0AytVo1mwfDoum+ZyNfNHvyOccQ@mail.gmail.com>
In-Reply-To: <CALzav=f=_+UQBJv_eZ=t5wE0AytVo1mwfDoum+ZyNfNHvyOccQ@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Thu, 11 Apr 2024 11:07:35 -0700
Message-ID: <CALzav=euNq2eaHYg79V=sZWytGBh-=TNoHNwRMgChy+DsCNRrw@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] KVM: x86: Participate in bitmap-based PTE aging
To: James Houghton <jthoughton@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Yu Zhao <yuzhao@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Sean Christopherson <seanjc@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, James Morse <james.morse@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Shaoqin Huang <shahuang@redhat.com>, 
	Gavin Shan <gshan@redhat.com>, Ricardo Koller <ricarkol@google.com>, 
	Raghavendra Rao Ananta <rananta@google.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	David Rientjes <rientjes@google.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 11:00=E2=80=AFAM David Matlack <dmatlack@google.com=
> wrote:
>
> On Thu, Apr 11, 2024 at 10:28=E2=80=AFAM David Matlack <dmatlack@google.c=
om> wrote:
> >
> > On 2024-04-11 10:08 AM, David Matlack wrote:
> > > On 2024-04-01 11:29 PM, James Houghton wrote:
> > > > Only handle the TDP MMU case for now. In other cases, if a bitmap w=
as
> > > > not provided, fallback to the slowpath that takes mmu_lock, or, if =
a
> > > > bitmap was provided, inform the caller that the bitmap is unreliabl=
e.
> > > >
> > > > Suggested-by: Yu Zhao <yuzhao@google.com>
> > > > Signed-off-by: James Houghton <jthoughton@google.com>
> > > > ---
> > > >  arch/x86/include/asm/kvm_host.h | 14 ++++++++++++++
> > > >  arch/x86/kvm/mmu/mmu.c          | 16 ++++++++++++++--
> > > >  arch/x86/kvm/mmu/tdp_mmu.c      | 10 +++++++++-
> > > >  3 files changed, 37 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm=
/kvm_host.h
> > > > index 3b58e2306621..c30918d0887e 100644
> > > > --- a/arch/x86/include/asm/kvm_host.h
> > > > +++ b/arch/x86/include/asm/kvm_host.h
> > > > @@ -2324,4 +2324,18 @@ int memslot_rmap_alloc(struct kvm_memory_slo=
t *slot, unsigned long npages);
> > > >   */
> > > >  #define KVM_EXIT_HYPERCALL_MBZ             GENMASK_ULL(31, 1)
> > > >
> > > > +#define kvm_arch_prepare_bitmap_age kvm_arch_prepare_bitmap_age
> > > > +static inline bool kvm_arch_prepare_bitmap_age(struct mmu_notifier=
 *mn)
> > > > +{
> > > > +   /*
> > > > +    * Indicate that we support bitmap-based aging when using the T=
DP MMU
> > > > +    * and the accessed bit is available in the TDP page tables.
> > > > +    *
> > > > +    * We have no other preparatory work to do here, so we do not n=
eed to
> > > > +    * redefine kvm_arch_finish_bitmap_age().
> > > > +    */
> > > > +   return IS_ENABLED(CONFIG_X86_64) && tdp_mmu_enabled
> > > > +                                    && shadow_accessed_mask;
> > > > +}
> > > > +
> > > >  #endif /* _ASM_X86_KVM_HOST_H */
> > > > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > > > index 992e651540e8..fae1a75750bb 100644
> > > > --- a/arch/x86/kvm/mmu/mmu.c
> > > > +++ b/arch/x86/kvm/mmu/mmu.c
> > > > @@ -1674,8 +1674,14 @@ bool kvm_age_gfn(struct kvm *kvm, struct kvm=
_gfn_range *range)
> > > >  {
> > > >     bool young =3D false;
> > > >
> > > > -   if (kvm_memslots_have_rmaps(kvm))
> > > > +   if (kvm_memslots_have_rmaps(kvm)) {
> > > > +           if (range->lockless) {
> > > > +                   kvm_age_set_unreliable(range);
> > > > +                   return false;
> > > > +           }
> > >
> > > If a VM has TDP MMU enabled, supports A/D bits, and is using nested
> > > virtualization, MGLRU will effectively be blind to all accesses made =
by
> > > the VM.
> > >
> > > kvm_arch_prepare_bitmap_age() will return true indicating that the
> > > bitmap is supported. But then kvm_age_gfn() and kvm_test_age_gfn() wi=
ll
> > > return false immediately and indicate the bitmap is unreliable becaus=
e a
> > > shadow root is allocate. The notfier will then return
> > > MMU_NOTIFIER_YOUNG_BITMAP_UNRELIABLE.
>
> Ah no, I'm wrong here. Setting args.unreliable causes the notifier to
> return 0 instead of MMU_NOTIFIER_YOUNG_FAST.
> MMU_NOTIFIER_YOUNG_BITMAP_UNRELIABLE is used for something else.

Nope, wrong again. Just ignore me while I try to figure out how this
actually works :)
