Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35293E1D05
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Apr 2026 22:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775083099; cv=pass; b=sQfJSg5E/KpcyOxKflNzOQI63wGsdi/DYo9iI+BfSOJUqlKUsO90Wtn4+0dthtpAgCz28a8w7Gv+c5/OV2VyrwQdETmCfOMF7IfLKtf7emD8104VfKboKtNHug3NjV2KkTgmnZJYG3WULZieWHU/Y0/6KmbSY49wl1SDiLKiNMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775083099; c=relaxed/simple;
	bh=jXO8gD8XlEA3fjQ8sPVJzY/ZhuFjBKDxDVzAsc0vY6I=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mn0XyQIgT3hUrnzVKsdt5zzdB+CH+9+aZmH/I7rVDmgI+04jTDNWhFsJWJ8QARsC+r5AHB8hqDFryYZtfpfeGgzUY9LFCbrJyRUaU5ZEtzkmeA0ChiOA26Wrrp5pdJCMTe97Hy06Q8AiZqgcaIIXet6+DjwY2ULobwiZZygOQRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uCxpQvvc; arc=pass smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uCxpQvvc"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-60581b491a0so67209137.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Apr 2026 15:38:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775083094; cv=none;
        d=google.com; s=arc-20240605;
        b=AHJvQ5lLk1dpJMcEr5+Pi2m442YBG+F0sNeTxCcF1D6T+Elz6yuk0wZGONhHTgfJBl
         4l9fbK7lNd39P67cXYl5BS5pNbW88dA/bOZc14MdXcqW4oJ2kLimosQPNt/1WggZCBwc
         pEoJoxe5DywoWl5nLhmYBRSrItf5sWfhF/lwwztynVivF3wAg6ll27EPVL+m2YrQFfo1
         /kvQOaIXtVndfc2tbMXW97Kuu9dvcGS4+ZwByYJX7O1q6fZfgWp3sEhen81gpx4G4Xyj
         dxHQ/dz3ErR/qheh4aZGhhKCJpBr67N9BluHCJJqV27iJG6qGVdR0Uhxcg4MwttX26GO
         xagQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=euITMSp/xJeCQhYA18f4lx9pM8JTP5ZhaaxCuXCtMTI=;
        fh=v4mENWdV4ukH212yi8vd+Oyt2Iad0GQjkwajr2g9EBc=;
        b=KMUEdEHSDipIwRn6vvEPCYGcyTPp7mS2D46UkzL2AmjUGAlNhPEj2ffkxRLZQ2+icz
         mOjmPUaHyp4sD4/cNnxvhwjjrwKdNJ1L4cVE3IHWbvsrRyrq6clECZD4YFNBeA6tSB3d
         DFuxtHs+/y/E084wSLjsxHbkZJoBZ1vdM/zvFzHSlBpad6j0r93dI1MoInNQBxJQpiSF
         gyguHInCwvLoDO/9erXplCzKVAmr4Z5UbIyoqM5aECaGOMsdO8PbLRtkm629fXijNWA7
         blG3cF8Rq4i1PTvqQD/zgh0m9AzZ8MLH66CqDvlCz50bB1MUugYtm06nzuOThxf2eooA
         tRoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775083094; x=1775687894; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=euITMSp/xJeCQhYA18f4lx9pM8JTP5ZhaaxCuXCtMTI=;
        b=uCxpQvvc+0hcjsMUN671rmbWXMrSyqwrqTf3/sro5V11OwUvG8Ux4E7yRNXL9y3nJk
         P674tn4VbUHGQDn44atPoT2jydRhB5IKXGuziuL7PcdPXutGk8rTART8+nyy1xOkCswY
         uprTVCuySafYSktTyvOuvbxK9+b+nWdPwTNcykQ3dvt4mi41f2SF8JyWJ8BkIVKzuLE6
         +RJ9QZDZqSaNO3+p4G1aEXqgWLTf0gPd3Ts/BdmJ06GG61NVX3kmAs9JqE77rtNi8RjO
         UDguyXscnRr21wcD1M/+qN1h1vtswv+mekWziGIOBSxPkCgsRGMaFTkZQeIbH74JCJAd
         pTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775083094; x=1775687894;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=euITMSp/xJeCQhYA18f4lx9pM8JTP5ZhaaxCuXCtMTI=;
        b=XpKpFSNAGMc19rLZhPlpAsE+Xq0U1I0qckXkRBifXZ/kEgvrPE6IBgMGzVPEdJSCHY
         2eR4C8nbj0IVsspfHn2nZAct+L94UJVQ/Qu3YIPYN+A2/S90XSQeBm4XBZu+YfHno3Y+
         wbUAxI+3sk5HVDxq+uMmhmqIhKQOIrKzNzxVS6lCJ8YHuvDnP9BTIQKo5J1q8LwyianB
         Gwfwwdmu/87NFcvOgNrG9MXQPpRKWTdlvfxoXWkEtaF3nRznCFdrbvmzG1Kd6SJ2M9eU
         BO9zvszmxtenk3jiZdOxOZkvCZU12OJogedSlI4P6LwnVVTMrkp5BQ7V4r84n+TifEg9
         qD5g==
X-Forwarded-Encrypted: i=1; AJvYcCXHx1FLE76u+Ra8nKxa3VxijHGp4BqECmeIU8B6g28ePo9IZeaUhH4p0XngTgABY2dGx+yOhFaYoy1QSg9fGBWaw8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVBchIz6z78RWy5uqtNRLJp0/ps4U5hbLOIRiwYfuOhA2IiEw2
	qK6axnDqqSdKzHUVe3aWLXl6OdIXPGQMRo6SnM220GrAL1UB+Zt2+wqfpNi+LyCK8tUFQKtoo7c
	CiKvWszE+DIG8Hf+lE261NY+5U5DGv+lL1Q3lJyyN
X-Gm-Gg: ATEYQzxg89avJTLksHBtZOy3rl3LkYTsnUm81QqOOnE0ZE6lunGfmHizo7ZwjKi/tqp
	ewFoqXDWYaEq7Pk7dotGSb+PG7P33YQcCSla0VCndw3Kc+dzwrWNJx5mgPOgFVx2xmAS8xz4YC4
	rISW3oim1sMOu31VJ1wJvE1VUyY3YSCzxk1oDgn4pAlHjLp24adEMtFV96LuXyLXx1gzlIXDR+Y
	tsju+BxcMbL0EMiCkWN0oJO++visaVTH3d7Nsfp8bDl20QoaFhEDKTKZleAHn3yjBGN3S8O2Hs+
	4JXDaxqwyQPwHP0LRZTv/UgE/eyAAzqW2BraBp9YcRprVDcDmJQLjMYbGiDli5mGXx+jww==
X-Received: by 2002:a05:6102:cd0:b0:5f5:40ab:2d65 with SMTP id
 ada2fe7eead31-60583fb718fmr487325137.22.1775083093776; Wed, 01 Apr 2026
 15:38:13 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 1 Apr 2026 15:38:13 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 1 Apr 2026 15:38:12 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <2r4mmfiuisw26qymahnbh2oxqkkrywqev477kc4rlkcyx7tels@c7ple7kdgpo3>
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
 <20260326-gmem-inplace-conversion-v4-10-e202fe950ffd@google.com> <2r4mmfiuisw26qymahnbh2oxqkkrywqev477kc4rlkcyx7tels@c7ple7kdgpo3>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 1 Apr 2026 15:38:12 -0700
X-Gm-Features: AQROBzCNhmfEK8q5oXqVxD-E8d6K5nvB8FmwqZKQD4ACNG80cfTfNWvs3WVsxNc
Message-ID: <CAEvNRgFkusZeKxGctUpTTbYjdi7nZL1ZZar-gT7XRUOCZ2xtpw@mail.gmail.com>
Subject: Re: [PATCH RFC v4 10/44] KVM: guest_memfd: Add support for KVM_SET_MEMORY_ATTRIBUTES2
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

>
> [...snip...]
>
>>  static unsigned long kvm_get_vm_memory_attributes(struct kvm *kvm, gfn_t gfn)
>>  {
>> @@ -2635,6 +2625,8 @@ static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
>>  		return -EINVAL;
>>  	if (!PAGE_ALIGNED(attrs->address) || !PAGE_ALIGNED(attrs->size))
>>  		return -EINVAL;
>> +	if (attrs->error_offset)
>> +		return -EINVAL;
>>  	for (i = 0; i < ARRAY_SIZE(attrs->reserved); i++) {
>>  		if (attrs->reserved[i])
>>  			return -EINVAL;
>> @@ -4983,6 +4975,11 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
>>  		return 1;
>>  	case KVM_CAP_GUEST_MEMFD_FLAGS:
>>  		return kvm_gmem_get_supported_flags(kvm);
>> +	case KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES:
>> +		if (vm_memory_attributes)
>> +			return 0;
>> +
>> +		return kvm_supported_mem_attributes(kvm);
>
> Based on the discussion from the PUCK call this morning,

Thanks for copying the discussion here, I'll start attending PUCK to
catch those discussions too :)

> it sounds like it
> would be a good idea to limit kvm_supported_mem_attributes() to only
> reporting KVM_MEMORY_ATTRIBUTE_PRIVATE if the underlying CoCo
> implementation has all the necessary enablement to support in-place
> conversion via guest_memfd. In the case of SNP, there is a
> documentation/parameter check in snp_launch_update() that needs to be
> relaxed in order for userspace to be able to pass in a NULL 'src'
> parameter (since, for in-place conversion, it would be initialized in place
> as shared memory prior to the call, since by the time kvm_gmem_poulate()
> it will have been set to private and therefore cannot be faulted in via
> GUP (and if it could, we'd be unecessarily copying the src back on top
> of itself since src/dst are the same).

Could this be a separate thing? If I'm understanding you correctly, it's
not strictly a requirement for snp_launch_update() to first support a
NULL 'src' parameter before this series lands.

Without this series, the startup procedure is to have memory set up in
non-guest_memfd shared memory, and then snp_launch_update()-ed into
guest_memfd private memory.

With this series, it is a little troublesome, but the startup procedure
can still set up memory in guest_memfd shared memory, then copy
everything out to some temporary memory, then set guest_memfd memory to
private, then snp_launch_update() the temporary memory into guest_memfd
private memory.

We would be unnecessarily copying the src (now in some temporary memory)
back onto itself. Can that be a separate patch series?

Btw, if snp_launch_update() is going to accept a NULL src parameter and
launch-update the src in-place:

+ Will userspace have to set that memory to private before calling launch
  update?
    + If yes, then would we need some other mode of conversion that is
      not ZERO and not quite PRESERVE (since PRESERVE is defined as that
      the guest will see what the host wrote post-encryption, but it
      sounds like launch update is doing the encryption)
+ Or should launch update be called when that memory is shared? Will
  launch update then also set that memory to private in guest_memfd?

>
> So maybe there should be an arch hook to check a whitelist of VM types
> that support KVM_MEMORY_ATTRIBUTE_PRIVATE when vm_memory_attributes=0,
> and if we decide to enable it for SNP as part of this series you could
> include the 1-2 patches needed there, or I could enable the SNP support
> separately as a small series and I guess that would then become a prereq
> for the SNP self-tests?
>
> Not sure if additional enablement is needed for TDX or not before
> KVM_MEMORY_ATTRIBUTE_PRIVATE would be advertised, but similar
> considerations there.
>
> -Mike
>
>>  #endif
>>  	default:
>>  		break;
>>
>> --
>> 2.53.0.1018.g2bb0e51243-goog
>>
