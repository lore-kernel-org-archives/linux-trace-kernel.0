Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62BA364028
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 13:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782308680; cv=pass; b=DxMHj8h8QJj9DSXzAZsTTsdSqkRX6zwHTrXbl4CslupNEl4Ajo0kV4QnC5NRxwCRmRNRCF4FPXdLckRZHmA7aXtLXv8pw0SslWRsHKOawq6WFVc5cELkzb6EjZN3v7HLf2pDIL/kr7A2NnKaIwemxLb2FISc5uulpOwg76AU1J0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782308680; c=relaxed/simple;
	bh=qwRcQ/ClJ9JG4ryGwIJuvq/o3tliB127/9EJbI1JGOU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GK5Sf33WDdXMvUmJIT8axJvMoO+2o+Yka33Jdi61HqpkS84eR6KVxtEOB9jRlJbKCXGussMCvsWF+cQLkRtiakPcZSqyYTyRhuUa9/UNGJbQU90WLrXT+o0Qr1QWDrp04L88c8sgXw54SPUwWS08Kn3W12YD697j/vzro80Yzhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=arPYaw0m; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="arPYaw0m"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-13981833e13so1254432c88.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 06:44:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782308678; cv=none;
        d=google.com; s=arc-20240605;
        b=VxirWnazj85/LH96uCYcRQuOw3yg6leEX+BEXot4LWxfFD+3XG0mcn4KtVJ3vY/hoA
         LKgkMyqt7nh0z/bljLZc2KUCDUIDYdTB7BY3aI2jVt3IuCQvkrJeQMEVI3AsV3b8i6WB
         ZNJr8m54KTgrT6RnFylY2kbHfSqLol6MXajaVYPsFaRvt4QuFhMn/hXlRU+M7wJSfkjQ
         63GG7QAYCuyixE4NveqQBmcar9QpeQvP8OT7ZUO2DfzM0b0x7Jb77EF6BN+I+nsh+ac8
         3i5K8KqxYlasZKGDRFDfc52F1ug1IbFjvchPD/lKpToDQjZUoKrzwNHNewghDih/vFmI
         w8Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=OMYX25sMe8BokvDqBMKpyH1gjAy6dHukDWPb7UeMT1Q=;
        fh=VeWfgNp+81VIuQPDES/nOLnI4mzmVB4ycfXp+RbefA8=;
        b=kJsNHhlQ09OjZ81Gm42HlXzGQou/GPDDQXGpu7Yan8+oTvh5uyllYTCx8aeDYaI8bL
         taE3Afen5Mpg0ay7zd6Sp1fegcy1u6JQ3kNOHlrXK6IdhDS0tzoQFnladlE2v5ONijox
         JWExOzv/5arlrxNwW+3Gr6kcHqx+VCAaIqTxzrZnDpUwuz0azIhBPYBlFvXk+yPVv0Tc
         BeMwRtug1utCSYGhEGukA13yK4a2OuwBNDAhsw40HG547U7zAIiyDUA6PbNi7fODX/BL
         LR6yX0cWGi7v1Ere0xl/g9Jtrl2QenqQbfnwgi1gr7TXuf5H2jh8kJGkB4CEJh0V31gp
         /iAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782308678; x=1782913478; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OMYX25sMe8BokvDqBMKpyH1gjAy6dHukDWPb7UeMT1Q=;
        b=arPYaw0meVRjPYrgms4OkOLXFt/8P2iuU67wri+g544HgClaDMzfIAQhy6BtPLeVh4
         2nSTG1S1xNZsTnS+t2dJfwbJ/WtjWp5jPYDuti7YH+wZSG1d0uJTdBdqVugF0F1GJqlm
         mz+2HQHL4z1TPCf9je/KZBzz5f+CiZiX0tyQKqwTjW/ln09HIuiZ6YRJDPKI20kCZR91
         3HAt6Csj4wOcpZv/Cji3sdK5CsaAUxp9ekhKCOUF/PICHIw1Igqy4Ciu3GdgYIPHK4QH
         H/WjUDgtm4HpMCfS4bUR0sZrBlSONDoE9rG/SPXL+VDaKdXX8ycoZFH0P8eihDqUY/Hr
         qBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782308678; x=1782913478;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OMYX25sMe8BokvDqBMKpyH1gjAy6dHukDWPb7UeMT1Q=;
        b=g110GprDmnD67kuPMapfNUodg5IsOWG5NS0yI5dToFDH0DY5Vmu+/u1DwISPWrmIIP
         D/tRIPhTQiJZLOVBGVYMAmqDSa4rjs0lox5SvmusL2Vtrgiy1gwcFbJD09wWpYkAmxq/
         2wyEANtOZ/mtLbGUne2T9MoGxqe6BHO67UNn7OS6uyPYtp3VvZbiLK4pOYs/Ys6PHYff
         C3/j0lGeYsJ1nYpaGZbwDp+bwmxwipnj4zqqm2s/vCEGGXCPMJGfCXblf2sfrQ6WWE22
         DgqDlaYjxWpFYxwQZyzaEEhimwnuvF7MjBsouPcEyFSLGlVsVFLRIhaRC9jGbnaO+rDh
         tbjw==
X-Forwarded-Encrypted: i=1; AFNElJ/rTOs7+8fRKuWZt2ZqROmkO1lDV6LC6CRi6VZFBbuQtX+66YqH3IvJW3T6kpjiGufM78oLpynpgz7xxFmfBy9dVLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaGe3L3o+rSCt76oNEWv9fDvBDnpyFc2ryvon4Odx1OSLa9efr
	Ne7qcdbqRV8YLqAZ/yVVPnJJwRvkoNBizIqviJFatSnorOspRJV0ikONb3HO7iU45bdrlHhuQkt
	tTc8xb7/cFeThDvsiCJTgMboGNAa8QdNeEE9cQ7r5
X-Gm-Gg: AfdE7cn98MTe6yVSCRlEegjyiwrs76zsY5t+BBLzJFsd0KHjnTssTAVCb9nR7CNF7+N
	hz7kmGc8/pzhcgaqYrt9rztx0ssWOaia7WIGbby6LEtp2zM+5ldTtxUwEcmDH2zujqUrRhqLwqy
	ibYaB3vbwSvi2k4LfNUIL8JAm4jOXHnicRdAO1Dgvoynxbotz4lvBpyasEsHXMj1lThdgwic1d5
	amPxzrk4noJVxhXO18BUHdeZx1a5yeintvBB4ikS9jkSNHXdIwMuD37xzJfBybB3ElhX7v+R+1u
	rB6alhGwOtenVo6dgSO+2a+0EkO5
X-Received: by 2002:a05:7022:ec0e:b0:137:eb26:10d with SMTP id
 a92af1059eb24-139c5b99857mr4976083c88.0.1782308676421; Wed, 24 Jun 2026
 06:44:36 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 06:44:35 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 06:44:35 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <96fb369d-dbff-4ed6-b1f9-0ce63d7d4ed0@linux.intel.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-7-9d2959357853@google.com> <96fb369d-dbff-4ed6-b1f9-0ce63d7d4ed0@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 24 Jun 2026 06:44:35 -0700
X-Gm-Features: AVVi8Ce7qJauzHB_wQ4GZOmMbMs8hfgU2sTfkjTDTjUh6bKjOQAsxLqy1nK_op4
Message-ID: <CAEvNRgGbBcrX5Fw3vNTsTOBNC=Ypi=9-S07674yPxLU9i4akjA@mail.gmail.com>
Subject: Re: [PATCH v8 07/46] KVM: Rename memory attribute APIs to prepare for
 in-place gmem conversion
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: aik@amd.com, andrew.jones@linux.dev, brauner@kernel.org, 
	chao.p.peng@linux.intel.com, david@kernel.org, jmattson@google.com, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
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
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Binbin Wu <binbin.wu@linux.intel.com> writes:

>
> [...snip...]
>
>> +static inline bool kvm_mem_range_is_private(struct kvm *kvm, gfn_t start,
>> +					    gfn_t end)
>> +{
>> +	return kvm_range_has_vm_memory_attributes(kvm, start, end,
>> +						  KVM_MEMORY_ATTRIBUTE_PRIVATE,
>> +						  KVM_MEMORY_ATTRIBUTE_PRIVATE);
>>  }
>
> This function is added, but never used in this patch series.
> Is it intended to be called only when CONFIG_KVM_VM_MEMORY_ATTRIBUTES is
> enabled?
>

Thank you for catching this! I think in some earlier revision this was
meant to be used from the guest_memfd populate flow.

I think the version of kvm_gmem_range_is_private in this revision is
good because it is symmetric. If conversion is enabled, call the gmem
range-has-attributes function, and if conversion is disabled, use the VM
range-has-attributes function.

Sean, if no new revision is needed would you be able to drop
kvm_mem_range_is_private() while you're pulling it in?

>>
>> [...snip...]
>>
