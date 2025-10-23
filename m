Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A62225F78F
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761231938; cv=none; b=rIyDU2t6DeCxHRI/rAn0Zgoe8b0KofZh+bBZtzHsPWMBZimhZkIE0wUyPrLRAsLc05cR9Mavn9NaWfgT0ub7G2jURv4J3+RHoV0YMHx3xUXc4Zr2ntJRzmS0gHlJ4DRGVxvWCjSfNGmhRLWnjm3EJFUqkPaIDJCDJyVR7sdOTMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761231938; c=relaxed/simple;
	bh=jz93bF63ecWHqlpsfaTIWZ1F+DloVz29gxl65xxvxP8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WqIwgVoKB4vIFejteaHj4aFyeI09fOXF7L2o5jnOhEi9bwRl+cC7WHq9/uW6mb3Wf8jG3bCuudyyRcBgFOCSvZiV89L8UL9i/ppbTuyZ7LQp/3MnLq5ZnMzwHNNAAdFwfNXL3SoooBGyY+oiWwTvG6e8tyOFgms8uawZpTzUJ7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M7Zby9xO; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M7Zby9xO"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33bcb779733so938539a91.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761231936; x=1761836736; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PvcmXgf+o6Tu2cYvhHpGmpe9m3a/ceHWHcYak3PalII=;
        b=M7Zby9xOPXaShDYfHfELOZo+QIPupBI+fSUhPtUzu8LpLDzqODas4KLyd45oYCyAF8
         BDxJv0hNgFLFoB8WQcIXM00OkNa79EuitP9lwB6a1flH00FPjoJql2i6MS0i6b4VNMHd
         YNSloQK9lH9CXXwzouz+JypLxzeZxgc1xeDUpSCTKAItWzF7UiMt+e/I1MBpFeRulRun
         HKkA6NEPOx8XCDgUnnkYTUJNHuXc9jt68IA6uqroZdH3pPDKlADQDB4/t2+S7B22u6Hd
         Xei2sVhVvQyzMKQeO5urHWG2DtyKldzVKDB6mFy7mjgIM6JQsZqlWiyEmbDgTN26HkJA
         bMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761231936; x=1761836736;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PvcmXgf+o6Tu2cYvhHpGmpe9m3a/ceHWHcYak3PalII=;
        b=bvOiSJwXPSLyPhsi/ZXcxfXUx4sJstqRpCAxFUE1P1Pw34s96sP1OhksVjph5hi1h1
         oO1fS0xNwW3rnzDqZeh2zKpZr+Gp/cnrk+5o59mcA86/DhPTIXs4JYuSqbmcoiHLbqQ8
         WmcTXS9qSs1Y4k0JJJYw86rN+F9z8lsAVjwFkATY/Wi0lernkrq1UuQA8SmmThI7sFvN
         j6Gg9wzl3GzDvQYDZXwrf1gp8JM+rV74wLccXgLgHQ6Rvf2FokCOnGTBSKvxCfcoLbq8
         ek/+5pwYMD7wMIhGwRMS6Z5u3ofEFAMjKOeptV1UZ97Js9962ezrVrTEAiVJIjvIv4Vi
         t91Q==
X-Forwarded-Encrypted: i=1; AJvYcCVL4yRkpJa8LLmhEFQEF4Q7dl5gZ9Ye+idJ436UfcI4eIAgaA6goCGXoEjghlH4gAyQ17jHpsJcl98Urox1qv/dYjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFa0+TJg0H4bSXaTsjZjZwEqnjW4xqZxuyNI/G1a3L0TWpXyf3
	SEbnD671Ijy2MoHdH664WfuSOqFAcqqXQ3ZocFIIelVjKyvdaP2OgwJlliNHim5W8hE5BFdRqoQ
	IB6yUGA==
X-Google-Smtp-Source: AGHT+IHpWV5RNhKUXvWMGZ+xD8d/MTd1Ze+E21K0nbVEiBP6P7EQ34tE5jerqVVq8m5WkJ7UUYnKv9jKozQ=
X-Received: from pjbsd7.prod.google.com ([2002:a17:90b:5147:b0:33b:b3b8:216b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3141:b0:32d:e07f:3236
 with SMTP id 98e67ed59e1d1-33bcf8e3ab0mr32372876a91.22.1761231935591; Thu, 23
 Oct 2025 08:05:35 -0700 (PDT)
Date: Thu, 23 Oct 2025 08:05:33 -0700
In-Reply-To: <diqzv7k5emza.fsf@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com> <8ee16fbf254115b0fd72cc2b5c06d2ccef66eca9.1760731772.git.ackerleytng@google.com>
 <2457cb3b-5dde-4ca1-b75d-174b5daee28a@arm.com> <diqz4irqg9qy.fsf@google.com>
 <diqzy0p2eet3.fsf@google.com> <aPlpKbHGea90IebS@google.com> <diqzv7k5emza.fsf@google.com>
Message-ID: <aPpEPZ4YfrRHIkal@google.com>
Subject: Re: [RFC PATCH v1 07/37] KVM: Introduce KVM_SET_MEMORY_ATTRIBUTES2
From: Sean Christopherson <seanjc@google.com>
To: Ackerley Tng <ackerleytng@google.com>
Cc: Steven Price <steven.price@arm.com>, cgroups@vger.kernel.org, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	akpm@linux-foundation.org, binbin.wu@linux.intel.com, bp@alien8.de, 
	brauner@kernel.org, chao.p.peng@intel.com, chenhuacai@kernel.org, 
	corbet@lwn.net, dave.hansen@intel.com, dave.hansen@linux.intel.com, 
	david@redhat.com, dmatlack@google.com, erdemaktas@google.com, 
	fan.du@intel.com, fvdl@google.com, haibo1.xu@intel.com, hannes@cmpxchg.org, 
	hch@infradead.org, hpa@zytor.com, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, jhubbard@nvidia.com, 
	jthoughton@google.com, jun.miao@intel.com, kai.huang@intel.com, 
	keirf@google.com, kent.overstreet@linux.dev, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, 
	maobibo@loongson.cn, mathieu.desnoyers@efficios.com, maz@kernel.org, 
	mhiramat@kernel.org, mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com, 
	mingo@redhat.com, mlevitsk@redhat.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, peterx@redhat.com, 
	pgonda@google.com, prsampat@amd.com, pvorel@suse.cz, qperret@google.com, 
	richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, roypat@amazon.co.uk, rppt@kernel.org, 
	shakeel.butt@linux.dev, shuah@kernel.org, suzuki.poulose@arm.com, 
	tabba@google.com, tglx@linutronix.de, thomas.lendacky@amd.com, 
	vannapurve@google.com, vbabka@suse.cz, viro@zeniv.linux.org.uk, 
	vkuznets@redhat.com, will@kernel.org, willy@infradead.org, wyihan@google.com, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Oct 23, 2025, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
> > On Wed, Oct 22, 2025, Ackerley Tng wrote:
> >> Ackerley Tng <ackerleytng@google.com> writes:
> >> 
> >> Found another issue with KVM_CAP_MEMORY_ATTRIBUTES2.
> >> 
> >> KVM_CAP_MEMORY_ATTRIBUTES2 was defined to do the same thing as
> >> KVM_CAP_MEMORY_ATTRIBUTES, but that's wrong since
> >> KVM_CAP_MEMORY_ATTRIBUTES2 should indicate the presence of
> >> KVM_SET_MEMORY_ATTRIBUTES2 and struct kvm_memory_attributes2.
> >
> > No?  If no attributes are supported, whether or not KVM_SET_MEMORY_ATTRIBUTES2
> > exists is largely irrelevant.
> 
> That's true.
> 
> > We can even provide the same -ENOTTY errno by
> > checking that _any_ attributes are supported, i.e. so that doing
> > KVM_SET_MEMORY_ATTRIBUTES2 on KVM without any support whatsoever fails in the
> > same way that KVM with code support but no attributes fails.
> 
> IIUC KVM_SET_MEMORY_ATTRIBUTES doesn't fail with -ENOTTY now when there
> are no valid attributes.
> 
> Even if there's no valid attributes (as in
> kvm_supported_mem_attributes() returns 0), it's possible to call
> KVM_SET_MEMORY_ATTRIBUTES with .attributes set to 0, which will be a
> no-op, but will return 0.
> 
> I think this is kind of correct behavior since .attributes = 0 is
> actually a valid expression for "I want this range to be shared", and
> for a VM that doesn't support private memory, it's a valid expression.
> 
> 
> The other way that there are "no attributes" would be if there are no
> /VM/ attributes, in which case KVM_SET_MEMORY_ATTRIBUTES, sent to as a
> vm ioctl, will return -ENOTTY.

Ya, this is what I was trying to say with "_any_ attributes are supported".  I.e.
by "any" I meant "any attributes in KVM for VMs vs. gmems", not "any attributes
for this specific VM/gmem instance".

> > In other words, I don't see why it can't do both.  Even if we can't massage the
> > right errno, I would much rather KVM_SET_MEMORY_ATTRIBUTES2 enumerate the set of
> 
> Did you mean KVM_CAP_MEMORY_ATTRIBUTES2 in the line above?

Doh, yes.
