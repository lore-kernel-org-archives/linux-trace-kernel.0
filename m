Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09313AEF59
	for <linux-trace-kernel@vger.kernel.org>; Fri, 24 Jul 2026 20:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784924804; cv=pass; b=q/cw7BLCY4tG+2Aep0JNjydUP8/Rwq1aCd1R+pYf/OskjzZhr3Z04uXR5i5MHZH7sDbVEKpK2+kofAdTDUQy3Upbmog5cH2irUOwSbLiaOrJa2MfGTDe9vvxU0o1FfDN0VUHsPa0jZ7ZdG1Kiy0VEOMe9nycryr87XIZARe3acE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784924804; c=relaxed/simple;
	bh=3bPaFfkcLVVehjWoKc7uXp9Krk+zpZKVatRaC5BCI3o=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HNDFPEr2C4f3Jm7yQjCNDhMPXKOymyl2F1FHtqWTgc+vSEr6YY6b686kjg5GuZ1gnl0LOCzROx4YedqkgUTIO3G9KG28XPgtErEgZ9DBk6YFh8CDkLvkC9ebw+ULjP2yGpWGJpOeQflAvglkgxtTOnHcp486WL7jgWuwRz9dy/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X+22ytPV; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X+22ytPV"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38e347638adso771194a91.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 24 Jul 2026 13:26:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784924802; cv=none;
        d=google.com; s=arc-20260327;
        b=N11IIjrJbdb4Qlohe1EBiA5h44O4tiRO/+ZObm/Uv2NN7Vmrb2d/0lDzIpv7kWQmcz
         J0y8GnD75uVZIZwYg+O/ixBglmOH5hu7w8Vr/PPIl6KFiXjBzB978jEbxAKu0oSFS0AL
         0eO/56FDY1jNSi9o3nIXzTDVColV7UF8maSbQaccH9bMNIr1wRQx5CghSxikEzy4+BCs
         H2lCGAZb/sDj8yruTTXHbqXmeapKZC0SRP2DYRJs/3vZAAO+JO5bruLV10kP8fUIT5/t
         7Rc3p8eko3EBGlkjXHN21QBqMIwyrTz6x4wF7wxnSggZ0T7i9AdT3VBm/tu7qxnirA/+
         Oupw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=j6WRuRiOGlrBru4rjgXozk6E1Vpz9Ly8EIjgzHznenQ=;
        fh=NuSaHfBlD3j0AbFKnnv1mT5+e7xe9QAxAU6y0vPBgf0=;
        b=PHuX2KZDxLE+tzA8fCYq8Q7Km/N6O+Q9pR78GFYQXTyWN5qoO/BqIfFd/LuvTjvKKb
         +8lHlyiUPXzlvwh8oD6YTaGqLFrNnjXwAWtmAdR/0XtglIWDf43+5VTZima7eixU1bqi
         GFLbTnwfEcDppOLUfRFq6D2Uc0U1qrfCPYC2gG8al7kSlvO2H3egYOIf41vweJMFtk8I
         e5OW/FpIJ1lmA97rUSZfN2dr8DkwIimSpSAZBmpi9pqUmIvwGc2HcAhXf70HWDGre2GI
         GzswWNfUs5O9/VLkg2evcF58c0bAlY0e8GeKV5KKB/yiZ8QathSt4ZgpkkzFPKaybvKS
         OETQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784924802; x=1785529602; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j6WRuRiOGlrBru4rjgXozk6E1Vpz9Ly8EIjgzHznenQ=;
        b=X+22ytPVowtvdD7H6oAjAZ6dFwEHXHU3JHtOooAKf/4Rt/T6msrmpVN9yapaJuPCXF
         BQgztoqjDqxKNUHrk3zrFXjUxFbKWrfrz8lbDrMAWHinAAAB8ufFNA+lK8gYKjqlrNym
         nCMleNTnPIVIUC0Cxzqk6t7U+1ZMYES61Afdnwqh6y11P2qbfCubhE1TG1yz9YN9JAnT
         IJU9Op2jnp5XnD18dnSNzVhOIISoNbvoTWl5o29uKwaLWAbqeaOaIylQW4ptJX5WQSZD
         FxQgxEYU2QZcoUGSWWBdvaVpiQzGU7AxpH00Zw54jehpPXR+QugrnjlzcktqsCmk/6fa
         NAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784924802; x=1785529602;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j6WRuRiOGlrBru4rjgXozk6E1Vpz9Ly8EIjgzHznenQ=;
        b=HJim0y8lWz0d0H5+p04KtVuDbZLez1F4iQo0+w0WKVhzLbaKQf6ZjRdPjmdLwGzHtE
         s4dZgMPET3+BU8sAh21H+0LL7dTefyswmIiG9vvzcFMoCcvcKbgNurIPxibET2mks80l
         JSf+f4DNRzHdNJT8zz+R5FGFDMJQTYc58jLQ/JHGES4T2tmGF5EeYOZ2ZaGcrq4Iv52K
         2kecixA0i2xd7nOSAYX1JRjiFzJsWf/FRr6Wz2Cqx7We8wepz7Skw4SwIsSesuwnEJaY
         /e64UaPXDuer6e1+MrdtTy+GbVv3pI2WFAhF7mNJep1cxwSOWMlfdd8voZHmfBa5YW8W
         wpDw==
X-Forwarded-Encrypted: i=1; AHgh+Royjkg+gnqmmyn6eTOync+nNE8acy07Ud2QG+cZi/x1UJ9JJrSHUxnQYHbKPbKJ/jCnnn1kDd4AqcBwQHECr4MB7fY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyB75MrwhiFW2s3WP66NSbdRJA56hrtXTPfB76rSMwYw4GyVnJ
	89LWkrEeJjnvHT+x4ShTiDr+q/SNPoz8aLswxgXKacJ6y0niVDQPakvkSIoz/Wx7zTgCKta2Q/a
	7gSNbXgp2IDyzZozoGUd/FlVQ8WBvi7aM67Q1vxGU
X-Gm-Gg: AR+sD13KQtMKHXb1GN7yl4yIh/Bb1bQZHpbMZIirTiZ0OEtpS+M7eOvnsb6/fc4/qYh
	HQzU9R6RuKWdwdO+Bv2/R7U2QKv1Yt8FPDV0CFyVWCHGHFS940CZA7D7TOj1RQl+wBcncy5iSyL
	MkOG8IJTLAtznHmV0XTQi40caHi4CRYYWxhJZMLiowiebqKlRsrIRVqPXTTNNfNCaCFrU5QC0B1
	JW8fD59xWL4qV0HHToLhG1Q0xpHc9Yd5x4brhtm0EnH5DeH8I5+s8+tFbXRalQ+JDOSI7el4vAE
	2HzipoVgF5FEZpFIs/+im1MkZ9a7PJTyEyGjddv5vm1AExR3
X-Received: by 2002:a17:90b:38c8:b0:38e:b400:a860 with SMTP id
 98e67ed59e1d1-38ec642bd98mr9249020a91.13.1784924801177; Fri, 24 Jul 2026
 13:26:41 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Jul 2026 13:26:39 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Jul 2026 13:26:38 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <c0e2df0a-19b2-4234-b0f7-41e010452b06@intel.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-17-9d2959357853@google.com>
 <584a8f9a-1538-4f8b-b576-75ef0fa961c7@intel.com> <akU7uAKb5E_Tklx-@google.com>
 <c0e2df0a-19b2-4234-b0f7-41e010452b06@intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 24 Jul 2026 13:26:38 -0700
X-Gm-Features: AUfX_mza0pn9bFWoM_88BD1HVQ8VVpLGhsBYWrYX7-3MlRMmF5M63UsjEJ6b88s
Message-ID: <CAEvNRgHmhpP=Re-RzojAp7E3E-TsdoUPhtZ6eSW4bf+5RVbzew@mail.gmail.com>
Subject: Re: [PATCH v8 17/46] KVM: guest_memfd: Advertise KVM_SET_MEMORY_ATTRIBUTES2
 ioctl
To: Xiaoyao Li <xiaoyao.li@intel.com>, Sean Christopherson <seanjc@google.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
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
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> On 7/2/2026 12:09 AM, Sean Christopherson wrote:
>> On Wed, Jul 01, 2026, Xiaoyao Li wrote:
>>> On 6/19/2026 8:31 AM, Ackerley Tng via B4 Relay wrote:
>>>> @@ -4969,6 +4973,11 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
>>>>    		return 1;
>>>>    	case KVM_CAP_GUEST_MEMFD_FLAGS:
>>>>    		return kvm_gmem_get_supported_flags(kvm);
>>>> +	case KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES:
>>>> +		if (!gmem_in_place_conversion || !kvm_supports_private_mem(kvm))
>>>> +			return 0;
>>>> +
>>>> +		return KVM_MEMORY_ATTRIBUTE_PRIVATE;
>>>>    #endif
>>>>    	default:
>>>>    		break;
>>>
>>> this looks inconsistent with the
>>>
>>> 	case KVM_SET_MEMORY_ATTRIBUTES2:
>>> 		if (!gmem_in_place_conversion)
>>> 			return -ENOTTY;
>>>
>>> Well, the check of
>>>
>>> 	if (!kvm_arch_has_private_mem(f->kvm))
>>> 		return -EINVAL;
>>>
>>> is buried in the following kvm_gmem_set_attributes(). How about moving of
>>> kvm_arch_has_private_mem() check to put it along with
>>> gmem_in_place_conversion check in kvm_gmem_ioctl() in Patch 13?
>>
>> Me confused, patch 13 already adds the kvm_arch_has_private_mem() in
>> kvm_gmem_set_attributes().
>
> I wanted to make the check in KVM_SET_MEMORY_ATTRIBUTES2 in Patch 13
> like something below:
>
> 	case KVM_SET_MEMORY_ATTRIBUTES2:
> 		if (!gmem_in_place_conversion || !kvm_arch_has_private_mem(f->kvm))
> 		return -EXXX;
>
> and finally, with the introduction of kvm_supports_private_mem() in this
> patch, it becomes:
>
> 	case KVM_SET_MEMORY_ATTRIBUTES2:
> 		if (!gmem_in_place_conversion || !kvm_supports_private_mem(f->kvm))
> 		return -EXXX;
>

Is the request here to make KVM_SET_MEMORY_ATTRIBUTES2 return -ENOTTY
instead of -EINVAL? kvm_gmem_set_attributes() also checks for
!kvm_arch_has_private_mem() and returns -EINVAL.

I'm about to post v9, which squashes the patches as Sean
suggested. Please review v9 instead to see if this concern is already
addressed :)

> So that the guard for KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES and
> KVM_SET_MEMORY_ATTRIBUTES2 is consistent.
>
>> That said, the ordering here is wonky and misleading.  A cursory read of the series
>> would make one think that waiting to advertise KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES
>> makes it safe/ok for KVM to plumb in support for KVM_SET_MEMORY_ATTRIBUTES2 over
>> multiple patches.  But that's not actually true, because the ioctl becomes live
>> the instant the code exists, userspace doesn't need to wait for KVM to formally
>> advertise support.
>>
>> To further confuse matters, it is actually safe/ok to iteratively add support,
>> because it's all effectively dead code until "Let userspace disable per-VM mem
>> attributes, enable per-gmem attributes".
>
> yeah, before patch 24, gmem_in_place_conversion is always false. So
> KVM_SET_MEMORY_ATTRIBUTES2 on gmem fd always return -ENOTTY.
>
>> So, I think we should go a step further than what I think Xiaoyao is suggesting,
>> and fully squash patch 17 into patch 13.  That way the reader doesn't have to jump
>> through as many mental hoops to piece together what is happening.  It'll obviously
>> be a bigger patch, but should be easier to review/understand overall.
>>
>> Oh, and that combined patch should carve out error_offset straightaway, so that
>> the full uAPI can be reviewed in a single patch.
>
> It sounds good.
