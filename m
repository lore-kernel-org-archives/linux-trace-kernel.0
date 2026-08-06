Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C179237AA78
	for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Aug 2026 00:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785977033; cv=none; b=M93Up1YAxaHcT4HLPS9cE4GdmZNRooQRcAdr4uDsDjJovvRDoH+Qg997g+GX7rH1LooeOxmbBZO1pFHIieTrT37+4G+atvrAK+dkU/SAc9z/3TMOQIPaiozrsgRQcRpxDKBH0OMaMLCiVH/QBDry306HbVWrygeGGl5unB07RxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785977033; c=relaxed/simple;
	bh=MOBnrAzJHjAXv0busTUd8AQe2wVTRESDC3GYmdGx6Jc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pqT4YUaYAtv/wZ85y1YOflWK9x/CJvMnt1rBGL8kODlLApVnCrPXDDO/Z57iCuZ9oyUvHkoZsX7pCOYrOFo1TW63jo6E1m9GIQvxYYYRH1mbk6V2kFS9AlxJacTxFxlbPY6ZcFd0LRyqmcb+2oyzzGQb11RN3YDF7mmkl94JIt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s9W9uVBX; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s9W9uVBX"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cb11535e6a1so1394035a12.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 05 Aug 2026 17:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785977031; x=1786581831; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GW1XyS3pE1vmBMrFND4uaqlT60WFAOcGNZed7ARn/tI=;
        b=s9W9uVBXMZADMYL3esIoidDW/3wdqPJ/VWnjeAbH6rJQJRQPL0AggH0/MOCz7FWeoV
         EGW4WNmQRuMx2WRkobs6JklVdkd+HnuAtR8jtJ4gUbjU23NQXBvQlRiBLlu8KpzKJc1G
         XUx5jKHagJDb77xXRqa877eee8TI6vhVWvZHj0OBitBkg8QBF3NnBLs+k1wcrnH1WrKL
         Xba3KfjDaCPDRtpnL5ff33HcpEBLdJPB3hzbvB37BGUJNXddi1+omIEmN9n8Qnw3NCYi
         L3wzawiNBzx2tbrN/pDuO+IiJRzFiJ5msDIUPSakKdCbGAicfGYnrwjwmfFT+s7HPha/
         aMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785977031; x=1786581831;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GW1XyS3pE1vmBMrFND4uaqlT60WFAOcGNZed7ARn/tI=;
        b=j2l2OcfuzgggG8JWMf6nrvSYKZpS/jbTzZfbGWiSqqTV6k/VkG6gSIoQTQab3nY7ZL
         BpWQUvLkWV+wb9a5dpku9+9bG+amLkiqmDq9/WQivX1uuQ7ju9Y03UjRijEuGpOaiH7A
         g9mZTj0m88dOXIGDid2nPblz3VFDoPYJNmZcf765wmogPwyorzM9aN1EFuFNbezEFMMj
         O9XWHIJlJISPbYUSi1PwRxLINFqu00jW/LLoZ19Hc3/3UHWs1rze60rf6ksDTUPOxv5h
         7nM70In2G+tM3+waNY59JWH+yKAXGeusM6xbTSplU2kzcJ/crsJBKBnyzQcDnXDu9CHv
         BpZQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpi5EtQehhOyNUoNbKQFW5b9twjQspfpCBcGsApNChu+4CdA/Q06Nn3iyXAetY7KXah/30gOlx05VoJXqq+TXiVCbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyybL7glfPDdAmLhC8aT731ieiKG+8XEe12aB6WrlxDUSaGMNDJ
	pFskis3DAqELzNOdNs165DPPMz3EGd5ARQZJkmgPI2EOKjmRsvbWewGzvAkhFzp8XQ0gkt1rzr8
	F8au1Bw==
X-Received: from pgki21.prod.google.com ([2002:a63:e455:0:b0:c9e:9c6:a85e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6112:b0:3b4:e4f6:4f15
 with SMTP id adf61e73a8af0-3cb85e9922cmr13235742637.5.1785977030773; Wed, 05
 Aug 2026 17:43:50 -0700 (PDT)
Date: Wed, 5 Aug 2026 17:43:50 -0700
In-Reply-To: <b9ad1a1d-c167-4adb-980b-90096515a363@intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260728-gmem-inplace-conversion-v9-0-35f9aec2aed2@google.com>
 <20260728-gmem-inplace-conversion-v9-3-35f9aec2aed2@google.com>
 <7dafaa90-f3d4-4be4-a5cc-472163f18040@intel.com> <CAEvNRgG3qXrG2ix2MEcyVo0GXaen-Pte4gFAwEN+9AY=VtGU5w@mail.gmail.com>
 <b9ad1a1d-c167-4adb-980b-90096515a363@intel.com>
Message-ID: <anPYxp-LMWaLDbMk@google.com>
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

On Wed, Aug 05, 2026, Xiaoyao Li wrote:
> On 7/31/2026 4:34 AM, Ackerley Tng wrote:
> > I think another way to phrase this is that if we don't make this change,
> > say, on the foo architecture where there's no CoCo and no private mem
> > support, kvm_supported_mem_attributes() would return true for the !kvm
> > case, which is over-reporting.
> 
> Under the condition that the foo architecture enables
> CONFIG_KVM_VM_MEMORY_ATTRIBUTES.
> 
> > How about this, replacing the entire changelog paragraph above:
> > 
> >    Explicitly guard reporting support for KVM_MEMORY_ATTRIBUTE_PRIVATE
> >    based on kvm_arch_has_private_mem being #defined. This improves
> >    reporting accuracy by not reporting support for
> >    KVM_MEMORY_ATTRIBUTE_PRIVATE when kvm_supported_mem_attributes() is
> >    called with kvm == NULL.
> 
> It doesn't help for the case where kvm == NULL, but help for the case where
> CONFIG_KVM_VM_MEMORY_ATTRIBUTES is defined but kvm_arch_has_private_mem not.
> 
> sorry for being picky. I think we can say
> 
> This improves the reporting accuracy by avoiding the case where
> KVM_MEMORY_ATTRIBUTE_PRIVATE is reported when kvm == null even without
> kvm_arch_has_private_mem being #defined.

How about this?

Explicitly guard reporting support for KVM_MEMORY_ATTRIBUTE_PRIVATE based
on kvm_arch_has_private_mem being #defined in anticipation of tracking
PRIVATE vs. SHARED state per-guest_memfd, not per-VM (to allow in-place
conversion).

guest_memfd support for memory attributes is expected to be unconditional
to avoid yet more macros (all architectures that support guest_memfd are
expected to use per-gmem attributes at some point), at which point
enumerating support KVM_MEMORY_ATTRIBUTE_PRIVATE based solely on memory
attributes being supported by KVM at-large would result in a system-scope
check (NULL @kvm) over-reporting support on arm64.

> 
> >    Give architectures full control over overriding the default definition
> >    of kvm_arch_has_private_mem() by removing the coupling with
> >    CONFIG_KVM_VM_MEMORY_ATTRIBUTES.
> > 
> >    In a later patch, kvm_arch_has_private_mem() will be defined based on
> >    whether architectural features are compiled in, and made orthogonal to
> >    CONFIG_KVM_VM_MEMORY_ATTRIBUTES.
> 
