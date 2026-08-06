Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F35F385D6E
	for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Aug 2026 13:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786022425; cv=none; b=fEo9HI88R3vOuQ51cKNOUMqf9WwhOkq1icJlK1Lmb7Sw7H+wGJWAilce/kzgPDt7hXelwbN/8OWiJGs6u6etxizHs0sOrQCWBGmjmpHAT3DAWYRqR5tUpIoDOkeRdqrxTPjEeHJ+gKCVcYlY2fvlVjx0M/eA+Y3HJwUeJkiyH7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786022425; c=relaxed/simple;
	bh=/Jh5oYlubsywuVmQ5YDdqkn0evsJEQYRz4nFdjoYIFk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eyZQHB0CLohK1/3pmPZxNpxVJeHb5MPusOzdYCkRrdYcSoxYSOloJBrr2ChMrrlw/hSxo47/mCUhZs5vUkkB8ourvkMUfVB6urx5K6srG8ue2TwdbIKZBnlBWdaL/oWrgx8NtIwxleUmRlC67UQp94LRxsa6AWQixp06qwBRa1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D1byBUH7; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D1byBUH7"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84e13b57b2cso2745296b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 06 Aug 2026 06:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786022417; x=1786627217; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=quMxwgvzS8F8CxQzPIpHc+hBSqfVyEO+f6ARjKTQRm8=;
        b=D1byBUH7rhMNbdLarcIo2F/MsOXYOEPyXeY+6+x/GiEXIJoBjTRlBaVdK+7cwRD1jd
         RpiQZKlSrwUHSx6vEl6JrUiPikI9JuQSWm5atoi9VR52Vi2ReT090mwH2GuDPXUqKvxY
         8/aXK8AK6ziAu1ZOTEpfvxHeohVtHGjDUIWsKRTbTy0kslhg3t248Uu88Q9XZbEONLYU
         Zsre/Wn0z/1QV1rxgRtZzOq7igMLsgeNTsuNDU33xuDpuRHPIM4rY7tG3qdISx4F5T3n
         ZAiDSdbMMM3GP2lDxo3/V+Jq/Wj54gEYJ6sGAkQRyTqGxv3o1XZdgmZpgmbvjK+bphia
         x49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786022417; x=1786627217;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=quMxwgvzS8F8CxQzPIpHc+hBSqfVyEO+f6ARjKTQRm8=;
        b=BlnV78kGfvJhe84YjmeUbZEdhqII7vu5vr3qQnNdNV4VhOqHQbhrlAiAm5mTHAUw8d
         YntS91IYM3DfIWAd8RF0hrjcTe8w+NI9PgVf+F0mRnSnJwoijV2GBGeOySYoTDXxByNr
         italKViKwhgj2/pL7TtnxByWl0rji2TpGqSSPX4dDEg6WW0YBYYVv/EdlrIbCnUIqFB7
         jGJoB3kea5Utnh/gBWijj3Mudk9OxLfejx6DovtHGkYAV84AjpqgHZzPQ/m2sJ4EbqrS
         7Yu3KzUXkty3E+vr3pIXAMtaxab6R33Ae0Q0n7c4KDeEMcLKJjRTgPddIBwyr/8JC1a9
         VD6w==
X-Forwarded-Encrypted: i=1; AHgh+Rpye2sOU9jDMg/lZy9uxsCvyz/cCSHfh15MM8wy1bgtb/WEbUh2CKdcQWoLEzL2MRBQKpf0A63GDO82MLFd+S2JOqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqXAFYl914R08NO4GZLCW20Au994LPQw/cuWbcJkgP0mvbqMFR
	rdvAuYIGGRCxxKoqJMNBW28J9Qsfc3v2YiGVWw2d7IRDbfXuKQVwYIq7CxNcNc5NzgQfR6jdUih
	Zhs77Ew==
X-Received: from pfbcj19.prod.google.com ([2002:a05:6a00:2993:b0:84c:3651:a4b1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3ccd:b0:845:c7f1:29fa
 with SMTP id d2e1a72fcca58-84f2e04a63bmr16001363b3a.30.1786022416699; Thu, 06
 Aug 2026 06:20:16 -0700 (PDT)
Date: Thu, 6 Aug 2026 06:19:45 -0700
In-Reply-To: <fda26964-721d-4a8c-9225-46ca3a5b2785@intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728-gmem-inplace-conversion-v9-0-35f9aec2aed2@google.com>
 <20260728-gmem-inplace-conversion-v9-3-35f9aec2aed2@google.com>
 <7dafaa90-f3d4-4be4-a5cc-472163f18040@intel.com> <CAEvNRgG3qXrG2ix2MEcyVo0GXaen-Pte4gFAwEN+9AY=VtGU5w@mail.gmail.com>
 <b9ad1a1d-c167-4adb-980b-90096515a363@intel.com> <anPYxp-LMWaLDbMk@google.com>
 <fda26964-721d-4a8c-9225-46ca3a5b2785@intel.com>
Message-ID: <anSJ1lLS0HZnfjCt@google.com>
Subject: Re: [PATCH v9 03/41] KVM: Enumerate support for PRIVATE memory iff
 kvm_arch_has_private_mem is defined
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Ackerley Tng <ackerleytng@google.com>, aik@amd.com, andrew.jones@linux.dev, 
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

On Thu, Aug 06, 2026, Xiaoyao Li wrote:
> On 8/6/2026 8:43 AM, Sean Christopherson wrote:
> > On Wed, Aug 05, 2026, Xiaoyao Li wrote:
> > > On 7/31/2026 4:34 AM, Ackerley Tng wrote:
> > > > I think another way to phrase this is that if we don't make this change,
> > > > say, on the foo architecture where there's no CoCo and no private mem
> > > > support, kvm_supported_mem_attributes() would return true for the !kvm
> > > > case, which is over-reporting.
> > > 
> > > Under the condition that the foo architecture enables
> > > CONFIG_KVM_VM_MEMORY_ATTRIBUTES.
> > > 
> > > > How about this, replacing the entire changelog paragraph above:
> > > > 
> > > >     Explicitly guard reporting support for KVM_MEMORY_ATTRIBUTE_PRIVATE
> > > >     based on kvm_arch_has_private_mem being #defined. This improves
> > > >     reporting accuracy by not reporting support for
> > > >     KVM_MEMORY_ATTRIBUTE_PRIVATE when kvm_supported_mem_attributes() is
> > > >     called with kvm == NULL.
> > > 
> > > It doesn't help for the case where kvm == NULL, but help for the case where
> > > CONFIG_KVM_VM_MEMORY_ATTRIBUTES is defined but kvm_arch_has_private_mem not.
> > > 
> > > sorry for being picky. I think we can say
> > > 
> > > This improves the reporting accuracy by avoiding the case where
> > > KVM_MEMORY_ATTRIBUTE_PRIVATE is reported when kvm == null even without
> > > kvm_arch_has_private_mem being #defined.
> > 
> > How about this?
> > 
> > Explicitly guard reporting support for KVM_MEMORY_ATTRIBUTE_PRIVATE based
> > on kvm_arch_has_private_mem being #defined in anticipation of tracking
> > PRIVATE vs. SHARED state per-guest_memfd, not per-VM (to allow in-place
> > conversion).
> 
> Sorry, maybe I'm stupid. I still don't understand how to connect it to
> tracking PRIVATE vs. SHARED state per-guest_memfd.
> 
> There are two diffs in this patch, and we are talking about the second diff,
> right?

Yes, the second diff is what provides the desired change in behavior.

> If the kvm_supported_mem_attributes() will be used by gmem, I can buy the
> justification. But it won't. At least, it won't after this series.

It's not about gmem using that API, it's about non-gmem using the API when
reporting KVM_CAP_MEMORY_ATTRIBUTES.  Without the change, if KVM supports any
memory attributes, i.e. if KVM_GENERIC_MEMORY_ATTRIBUTES=y, then the below will
*incorrctly* include PRIVATE in the set of memory attributes, because
KVM_CAP_MEMORY_ATTRIBUTES reports what memory attributes are supported via the
VM-scoped KVM_SET_MEMORY_ATTRIBUTES.

#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
	case KVM_CAP_MEMORY_ATTRIBUTES:
		return kvm_supported_mem_attributes(kvm);
#endif


> 
> > guest_memfd support for memory attributes is expected to be unconditional
> > to avoid yet more macros (all architectures that support guest_memfd are
> > expected to use per-gmem attributes at some point), at which point
> > enumerating support KVM_MEMORY_ATTRIBUTE_PRIVATE based solely on memory
> > attributes being supported by KVM at-large would result in a system-scope
> 
> s/memory attributes/CONFIG_KVM_VM_MEMORY_ATTRIBUTES/ ?

No.  I mean "memory attributes" as in KVM as a whole entity, i.e. everything
linked into kvm.ko (and kvm-{amd,intel}.ko, supports memory attributes.

> > check (NULL @kvm) over-reporting support on arm64.
> 
> I think arm64 won't define CONFIG_KVM_VM_MEMORY_ATTRIBUTES?

Precisely *because* of this patch.  More at the bottom.

> So it seems to have nothing to do with arm64.
> 
> It matters for x86. After patch 20, CONFIG_KVM_VM_MEMORY_ATTRIBUTES is
> user-configurable. At that time, people can disable
> CONFIG_KVM_SW_PROTECTED_VM, CONFIG_KVM_INTEL_TDX and CONFIG_KVM_AMD_SEV, but
> enable CONFIG_KVM_VM_MEMORY_ATTRIBUTES on x86. 

No, they can't.  KVM_VM_MEMORY_ATTRIBUTES depends on one of those three being
enabled.  What am I missing?

config KVM_VM_MEMORY_ATTRIBUTES
	bool "Enable per-VM PRIVATE vs. SHARED attributes (for CoCo VMs)"
	depends on KVM_SW_PROTECTED_VM || KVM_INTEL_TDX || KVM_AMD_SEV  <======

> In this case, kvm_supported_mem_attributes() reports
> KVM_MEMORY_ATTRIBUTE_PRIVATE for system-scope query which is totally wrong. I
> think this is the case we want to prevent not something won't happen for
> arm64?

Well, yeah, because of patches like this one.  That's the whole point.  Without
this change, kvm_supports_private_mem() would be reachable if and only if
KVM_VM_MEMORY_ATTRIBUTES=y, which would prevent burying that Kconfig in x86 and
would prevent arm64 from enabling the PRIVATE memory attribute in guest_memfd.
