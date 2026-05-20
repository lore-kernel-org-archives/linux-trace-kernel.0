Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FB936AB57
	for <linux-trace-kernel@vger.kernel.org>; Wed, 20 May 2026 20:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779308754; cv=pass; b=BmOtd/KJZrOodL/x4wwYiLZH+E0gmqM8tSPhexCGxRwhTnulyRD0J4mplD6Xon3EGYES1jxDqKxRqPfSPwdDwvuxu+Rpt+ofZ7FnrreKUFeySIGEoA3FIMkrMqIIof6pWYsA9ftd+DQ9aFIfghwOuzP0mKc3UZl2IDM0af7Rpow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779308754; c=relaxed/simple;
	bh=0y54nFg7E7TaoQP1DdnZ3Kd8izilERRAcK4RB5V7BZY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CYQn5/Dz45visUwNv3fVRaQFFtIPfDpo6VczzuJLjrIsm39kRabTOeMt0KS7fRdhXpDMalfVyY0LsifCR/ezL926Xv2eOzQRENNA9KNOXbVp0jsEbmTHgxk/wWF4HTI98G/x8BzxAtqBpfymYV7AGaUvQS4ZT835AS9LJSpboAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XwbOvfxx; arc=pass smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XwbOvfxx"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-63201e0d6b8so4834825137.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 20 May 2026 13:25:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779308752; cv=none;
        d=google.com; s=arc-20240605;
        b=Ak8lmzmYYkLD2uwNjnbeS9S+4bw1TQf6TgbrOs3qCVqRxuZA3RA5+Jm68jsgk50ebR
         ZM+aOPUacsMcyhEvVoSKn+AfPdcqpLFkm8pAtXM4MLzri3fLCB5X6/eeizGr8quKGsod
         +sGQ5fqLFkpLl1/0K3R6w+svEYygW5LC5FgljKRCy4qsbAdSCEEVm0H5r9mqRAdQcFZb
         46WIjF0Xethc+PvIKHO9Po+PlaprGGhM6b9YP8gll3UNqffT7S2KPGIc2kh6x+bGB3a0
         tIpnHuP1hPLLsj1enJq65MLp32wHSZSH068TBlC3fYq60MByaLhyPuKYfFlDIbYqKdNl
         v0kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=ANitp46w7gSSv/gOMNKZIor35cJdYj41rSqFN5gAzAs=;
        fh=/+S45RwpYpL74y0NnvtlFmsB5EfLV5xAaUppswun9t4=;
        b=EzBAiQCP5DQU4tBdT7kP99KzBb/vBpM+5k7q4qfL6ELoO96FcOIRIZ7ZBHuiXGJ7wN
         82ajziCss8rdEqoZIhbcupZ/hDE4kO0NIqQsPYVOOgp92az299An0HAIs+EXgZSEZg5s
         W6/kHfpXieAGZzvthuTdjjKy4otqBOmzxBpDftKoT3m9DAVkrgneVPS4msTbzeQ4uJdT
         zyAAmcYiAXFeXt/YM4yqMcGDKmzZdwnKGX1BVtP59/lGrwacZ22HA3PDOI2c7avODnIm
         +Oai+GXaaEStc91MEMDG8/eO1Be8UuXdO3/VsnV5rpz73Ts4znXTODURd9Yv1KZMzUr6
         bxeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779308752; x=1779913552; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ANitp46w7gSSv/gOMNKZIor35cJdYj41rSqFN5gAzAs=;
        b=XwbOvfxxojNTaZZg5xc85ejdAJLXOGIhj/ihtMbe8SNH7QL1VPADFRhf2ZTOAtHqFV
         4k7u1P39PnV25R6VstbsKpEE4wyX0JhVZqvNJ8buaI6G2q2H87BuGLzAO2nbgYCxH5Ft
         GnRlujwb7rxQbKACZqw87Jpo8dHQ7+08omse+HqQur9nmbbQbcYBGsu6Lt95kx29nZ8H
         oiskX7kcTOn14ZXsouLohobxRDb0u/MaDuHoHkfQpRcCjf3Xaun8eVFfJz7WA98ch44F
         epcFLiYRTMix2UmAxWj2gy1brAg77X3TksdbyI3HnBAOQPRug4fxELrHdLfrSuRtRNJl
         7tmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779308752; x=1779913552;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ANitp46w7gSSv/gOMNKZIor35cJdYj41rSqFN5gAzAs=;
        b=ourzO9NYIXn9OMJ/h5fX3rrvDIuPp1zJddkIv22t/skavKNM3FbikhAIyNT80M9+yI
         ZWuJhoZeA0CTerhH0ywmZcIiSODYtkICok515Lj0XF8Jnt6pMpz/aWq/zSBLTECdU9Iz
         /P6TlZQTsCqIDB6vqrY/iVYvlneJlSlNis56UIOoai75D2rgFrE7R3U6Hm9+S+qNU77a
         G7qtJ4PimKZgVU3kUJFGQsf6SUQdLadDraUFZOsQ+ZBXKLNgNssEN87b9o3M7e5MZXJV
         zDDRY3mUsqR6N17nf7pt4gAAheZW7GdKzdUymTx/DlfecMAzCZR1BOBv9RcC+hSP9kwh
         f2WA==
X-Forwarded-Encrypted: i=1; AFNElJ/gylpwKPaKng/oY8BA/Ixnhd0WrX2uRdkL0qSrLhR1AYpvszPc3+BvNm4gb8VW45ORjl7xBr9WvrE0SO0E9raIz60=@vger.kernel.org
X-Gm-Message-State: AOJu0YzENoDi1dI0U2W394lS3Q5RczK096XpYAFV27fNQ/lFvyMyJskh
	TFAZbEzVyy/8Ab51N5SSMQ6cpNff62JN9aQN1JB+5+wVHIt3os4q6/Bwsf/pgrwzWNxe82TDVmS
	Kqk+Q1ubln/Oh6TuGIElgQXuVZEdI0WFy9bZ0mtoC
X-Gm-Gg: Acq92OFcxLKBRKHQCst3xB87ekxQ/QpjEit4LL3tTbXy22TGyign+atLpnff9U5Ybij
	UrJjWKSPghL8X6w26RuKGYwhIrhLOfP5yWmKDbyafLK8g+QU3orM0HB3U1lB9SYWhYqN0i8QFqH
	gN78mkS0sZyYrzPRHyZh4R74/OntBNarkqJL0AFFV+y1v8zT9TVg908z5oGZw9QtYdyyWkBWKJF
	gceF9F6ImQVsctGkU3WHHI3ZaRau9haH0bGxh1ZCIzrmyY3nozYvXl+mWCP3v/Izu91jhzh++yA
	1u9QtjLfg47l+PiOUgK/5EeCo29+AIKTZMRPTHTMDqwL2i4VvUO+5nKh2Aop0wZOaAus3bfiqmj
	8YfMi
X-Received: by 2002:a05:6102:2583:10b0:631:a34d:b671 with SMTP id
 ada2fe7eead31-673bf885fcfmr10043137.5.1779308751281; Wed, 20 May 2026
 13:25:51 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 May 2026 13:25:50 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 May 2026 13:25:50 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <ag3DawWCcrpCkD0e@google.com>
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com>
 <20260507-gmem-inplace-conversion-v6-6-91ab5a8b19a4@google.com>
 <CA+EHjTxvLU4XDPXDXYXXWJES1OFQgN8VTRLMgCCNMwBE6Hk8tQ@mail.gmail.com> <ag3DawWCcrpCkD0e@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 20 May 2026 13:25:50 -0700
X-Gm-Features: AVHnY4IBlIN9DzOr96NZ1ZZdFo1tnLv8pC5ZAKQh-hjUOng4U7q5IXabnxVwwpI
Message-ID: <CAEvNRgGHHkvfJ-mn9rfDvS+_1ht08YatFWo-Swt+5wFSPnC9Nw@mail.gmail.com>
Subject: Re: [PATCH v6 06/43] KVM: x86/mmu: Bug the VM if gmem attributes are
 queried to determine max mapping level
To: Sean Christopherson <seanjc@google.com>, Fuad Tabba <tabba@google.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
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

Sean Christopherson <seanjc@google.com> writes:

>
> [...snip...]
>
>> > @@ -3357,6 +3357,15 @@ int kvm_mmu_max_mapping_level(struct kvm *kvm, struct kvm_page_fault *fault,
>> >                 max_level = fault->max_level;
>> >                 is_private = fault->is_private;
>> >         } else {
>> > +               /*
>> > +                * Memory attributes cannot be obtained from guest_memfd while
>> > +                * the MMU lock is held.
>> > +                */
>> > +               if (KVM_BUG_ON(static_call_query(__kvm_get_memory_attributes) ==
>> > +                              kvm_gmem_get_memory_attributes, kvm)) {
>> > +                       return 0;
>> > +               }
>> > +
>>
>> This directly takes the address of kvm_gmem_get_memory_attributes,
>> which is only compiled if CONFIG_KVM_GUEST_MEMFD=y. This breaks
>> ARCH=i386.
>
> And this bleeds guest_memfd implementation details into places they don't belong.
> The right way to deal with this is to use lockdep_assert_not_held() in whatever
> code mustn't run with mmu_lock held.  E.g.
>
> diff --git virt/kvm/guest_memfd.c virt/kvm/guest_memfd.c
> index c9f155c2dc5c..3bea9c1137ef 100644
> --- virt/kvm/guest_memfd.c
> +++ virt/kvm/guest_memfd.c
> @@ -547,6 +547,9 @@ unsigned long kvm_gmem_get_memory_attributes(struct kvm *kvm, gfn_t gfn)
>         struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
>         struct inode *inode;
>
> +       /* Comment goes here. */
> +       lockdep_assert_not_held(&kvm->mmu_lock);
> +
>         /*
>          * If this gfn has no associated memslot, there's no chance of the gfn
>          * being backed by private memory, since guest_memfd must be used for
>
> But I'm confused, because kvm_gmem_get_memory_attributes() doesn't actually take
> filemap_invalidate_lock(), so what exactly is the problem?
>

Ahh I can drop this patch now. kvm_gmem_get_memory_attributes() used to
take the filemap_invalidate_lock(), but after Liam pointed out that
the attributes maple tree should be using MT_FLAGS_USE_RCU, I stopped
taking filemap_invalidate_lock() and forgot to undo this.

I'll wait a bit for more reviews and then put out another revision
without this patch.

>> >                 max_level = PG_LEVEL_NUM;
>> >                 is_private = kvm_mem_is_private(kvm, gfn);
>> >         }
>> >
>> > --
>> > 2.54.0.563.g4f69b47b94-goog
>> >
>> >
