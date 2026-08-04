Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EFD43CE5A
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Aug 2026 21:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785878766; cv=none; b=nNOWftkJhp8GH2Ppo70D462giK/5V9PrEjQ12P28vD0SeD9Zdgi9tOIzbktjDeKChoz+MaoVK9RBEdX9MCaYuBSC48vkRI4SCLvMMgbFS05krrGcAsbEymMKs4WB2tJNdVac9oSZdNTUtq7i7tmgCEqggL/Mo8shyWlcdr2gxPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785878766; c=relaxed/simple;
	bh=BCQAfpaUqnDRdhFBqf5W6hE9jelLT+UwP2GtKgTlhtw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aJhWJs/e/nEBpETQjBQu4+ITpJ+EPt0OnKch0ET0Q/KW0raseByes8QFZJcg/cQEOFkFmXbkIvWVK7huiLrkuY/VcNFLZOkfDZXMoh4+fldNenQtBDbX0qpIjjxNooTFdROhhusJ5YR3ZTT7iizue6KRxVZOdTXY/gxHc6t5uzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OGntIopd; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OGntIopd"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb835525b13so276738a12.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Aug 2026 14:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785878763; x=1786483563; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D1m+pWGOS10uU1f2bsRnNlJub5JOhExh9V1AKmoVmG8=;
        b=OGntIopdxeQgPpCguxXN77FhflQfdmSlk+3k2USXLV2CXYHffSVoYsWDw1d44U+bVR
         6XQNlDBwgUEqMZ7i24XGlYm4fJZ5Bxe0DG5N388S07HMBNAasDLKhN4CSuRIN0ASLQ1x
         IVryFuwDs1FXdXVLBx7vjdg3LSm3KazG4Ed6MDLNYCvduMBZTqhictb0PpyNak59T8t/
         mdEHAp6XBvznUgVlxqviBcAHarDJi347E/vFv6t2LorVainUaaa3m3ZLXvY6sg/AYCNt
         +3j+y+5aTmA6DpTH0e/cjTU6t3Oee8tv5+bQ7DzDNENgFdGNZfJc4hYAXRspQtFQejci
         fijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785878763; x=1786483563;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D1m+pWGOS10uU1f2bsRnNlJub5JOhExh9V1AKmoVmG8=;
        b=eDA6GafwNC2mK6SYTnpLjEC8O/xxZiEuX06S1tZQjlFl9QALE+Xs/3SfNwZnpnUDTq
         FRKCo27+yVN1wi/Pf0QUd/C0PklmepcwL2RFrW3d0FurO1/QoR9tCpNEHuEscSWSk7Mv
         El5EmHvlqIzJ/Yon/3lkzkcexc8f9nXhLhkXAU/tTW5P3bx/JkFZ7TdFbAKdd86zuboB
         WrjdDQbfFfbNkXn6Dajeg+Evr1puktj3ctvvddDmmw24evXiwqpd5M0XD7sICnJl7yKV
         hWym+b5NdCKPyYEhgDNbCvRaz6HpxhMVBr5FGJtU3NTVQZPqquveKXnUZX9/t+qzxBWO
         tNiw==
X-Forwarded-Encrypted: i=1; AHgh+RqyRnUzwWgAFFoWJb4LyL94YQKeqoMi/bWWrmfTW6o9THzkmmQnPQaZ8Ku31cc+YhWzoaFk+7ep0Sf3JASS8EaAKXs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9DDyB8swDKsTjegCZhwcs6I1r4awj4tLYV30l4iAkI4+Q+wkG
	fopzvoceFK/Hta3hNJEqq2h6LhwntBgLfVC69uFNTuhBXH5QlRcsB1U7JrvURnM+NF9ITVUFn4m
	z+wEcJg==
X-Received: from pgip24.prod.google.com ([2002:a63:c158:0:b0:c82:7761:9936])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a103:b0:3bf:6237:4d3f
 with SMTP id adf61e73a8af0-3cb85e4dc7fmr1611110637.18.1785878762819; Tue, 04
 Aug 2026 14:26:02 -0700 (PDT)
Date: Tue, 4 Aug 2026 14:26:02 -0700
In-Reply-To: <CAEvNRgErZqaLPpBveBd2VxdrS_8mjMbArL_=AhzMdikXmUU5VA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728-gmem-inplace-conversion-v9-0-35f9aec2aed2@google.com>
 <20260728-gmem-inplace-conversion-v9-20-35f9aec2aed2@google.com>
 <7f23d149-b7f0-465a-a9c0-5c7484e289d2@intel.com> <CAEvNRgErZqaLPpBveBd2VxdrS_8mjMbArL_=AhzMdikXmUU5VA@mail.gmail.com>
Message-ID: <anJY6opttIJ4OQHP@google.com>
Subject: Re: [PATCH v9 20/41] KVM: Let userspace disable per-VM mem
 attributes, enable per-gmem attributes
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, tabba@google.com, willy@infradead.org, 
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
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 04, 2026, Ackerley Tng wrote:
> Xiaoyao Li <xiaoyao.li@intel.com> writes:
> 
> >
> > [...snip...]
> >
> >> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> >> index ea2752989f8bd..df67a6188aa99 100644
> >> --- a/virt/kvm/guest_memfd.c
> >> +++ b/virt/kvm/guest_memfd.c
> >> @@ -1137,10 +1137,12 @@ static bool kvm_range_is_private(struct file *file, pgoff_t index,
> >>   {
> >>   	struct inode *inode = file_inode(file);
> >>
> >> +#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
> >>   	if (!gmem_in_place_conversion)
> >>   		return kvm_range_has_vm_memory_attributes(kvm, gfn, gfn + nr_pages,
> >>   							  KVM_MEMORY_ATTRIBUTE_PRIVATE,
> >>   							  KVM_MEMORY_ATTRIBUTE_PRIVATE);
> >> +#endif
> >>
> >>   	return kvm_gmem_range_has_attributes(inode, index, nr_pages,
> >>   					     KVM_MEMORY_ATTRIBUTE_PRIVATE);
> >
> > With my suggestion[1] on patch 7, this diff block can be dropped.
> >
> > [1]
> > https://lore.kernel.org/all/dd4201f2-3660-46ad-958f-c70feb1ab1c3@intel.com/
> >
> > The code looks good to me,
> >
> > Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> >
> 
> I think your earlier suggestion on only defining the module_param when
> CONFIG_KVM_VM_MEMORY_ATTRIBUTES is selected still applies, since it
> removes an avenue for a user to turn off gmem_in_place_conversion if
> the other option (VM memory attributes) isn't available.
> 
>   +#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
>   +module_param(gmem_in_place_conversion, bool, 0444);
>   +#endif
> 
> Given that we're now dropping the diff block as you suggested, do you
> agree that we should keep this #ifdef?

Yes, the param needs to remain hidden if CONFIG_KVM_VM_MEMORY_ATTRIBUTES=n, so
that userspace attempts to disable gmem_in_place_conversion are ignored (and
logged as such).

The obvious downside is that the param won't exist when in-place conversion is
forced on, which is kinda weird, but I think it's the lesser evil?
