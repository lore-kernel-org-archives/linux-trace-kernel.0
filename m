Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1697E46D2A7
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Aug 2026 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785857994; cv=pass; b=rLxCOChT+mktLUC09nv36jQOL6BLb1HwDyYxSzw5IHUIPwzIUq0hhgsK0AFctHtxpGZDt13HflSpFsKrjJPXM6vC7oDB84A3C9Ur9Fxm4jkjVYm/rebYXqfUvNo1VaAxT/ZDZr9Lwmvg/d/qcQlT9AoAdEoE0g9KrnNVNEY0WFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785857994; c=relaxed/simple;
	bh=3oWNFp8mlmM3sK5SQC2KqwSAdHvsMlVK7v6l4lJqdEI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fDf1HfBq/cbL8ZdqukMVSWuBVLmmwf39hkxdrnS9fGGDeunix2va4iQ3CXbEK188TGYo6/cG5WH0o49NflCM8RFPEg6a6lmiJRIcvII5T2qCS0DMGOZNNcLC2750TUUOaq1XwCM2lBiE6tgrj4dFUIMoFUxbfRq0ng7ti2bcNNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u8Kqbe+8; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u8Kqbe+8"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so3268826a91.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Aug 2026 08:39:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785857989; cv=none;
        d=google.com; s=arc-20260327;
        b=OUa10wizRv0d7B7Ojs4ZRkCGTttsUHQxCEz+sCD4Lhd6Pbx3mE7jTQ+qhDdHNoAcBq
         ah8ZC+DEwrQH58XzBeQMm48b2Wh31307s8KP9IwaAECcsGIb2l7XKx0dh9p77Z60F+Ue
         6XOe+YyNJIgRL0eyYcFRFZeY7kLSSvCPevogPZ1O13iRvs+86B6ew/7bx+O1CsWYK287
         cxmwprnRaa9IybbP0JXpk9Eac6f9VLqCDBoFea7byaEnMBGx3NK8MMu4C9CRD+s+adeg
         P5iRx4XyPddXH/4JHqgO2KrMXE+7LmDMW3pHtgvcMjQXlfN6xvR/QuNs+hDIoHB/LH8r
         X6HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=CroU6+PYSvOtV4uy1av7nC/Q1rK5iyolsTF+JTm0nJU=;
        fh=vhkhTrzq05bPzu299Xyytwt3sUhxKIY8kua+1F1j2MM=;
        b=AICA7Zq9jXqSZgJj9uWUiO7Yc9MeWfntdrTiBhbvZjjMmgViGpfPShufcHwNNDEYY2
         nyQpjgj8f0RUjdkIU/ADlYsrMWkwZgU2SxOgKns19EJsh1lBfUnXNb9lmzEfApqw8Wbl
         8rcQSllCHrbgkYju7nw8+9v1pWjlNA8eF5dSA3kSxpUDwHX6K28eEqk2+uFEPp8F1BmZ
         /J4O71+rTOozEMbyyW5aIqEDUTUvAOQ1pO1Vut9YcCnu3LqlnOL2W6bp1D5xtZN59wRF
         E+YCMrAyeXYxYjpKEj0nbTZHc/okbJ2mTa9Ox3dzqLfOewi+/3qYmJdQsbdWltz0QVKI
         BTIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785857989; x=1786462789; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CroU6+PYSvOtV4uy1av7nC/Q1rK5iyolsTF+JTm0nJU=;
        b=u8Kqbe+8NUGx9yefTwTAvANAItwU6yEEGFtaF1wptzb3NCfl/HzgNPdrrKzF+QZPyO
         qR2u7GnHAczFSGMxmu6RTivLrLESjLA6OcOIxReAP9at23zOfbu276qpd5NXebYcqTHA
         5N8K/OoH4gPX6399D+5ml7KSo3wNwYoSnMp/TiyNx1wFTWwJjIDfZUmJLvmOiqvMoXaq
         PV7jv6yblCt43N8A0QooLDkpvyGjlDlm4fFsN1RXKiXEpq8PzBqPKZHZ+22AjIlEmXOF
         FMh1HQ4kc6jxGPgaZJqsu/nRxDxYvTkJUY9S6qVhyXd3fjEH+qC+jhzuO6k67htlAucv
         cH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785857989; x=1786462789;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CroU6+PYSvOtV4uy1av7nC/Q1rK5iyolsTF+JTm0nJU=;
        b=NaaiJObIyWouQzN+7vJrwyUljnnWwpsP/lscR4nDOTSPjd6wX6OJVSOS3RPfLe6d8v
         gpaaSyxVDmAQHB7EybHds9DWiNO3A9rAM25qfvGfLYoo8IbeKK+hryT+9IyQbohjnXfh
         heqBgSYfTHObYXwdYEl9HoNFP/vUBIXVJcCsj+q4FCdD3YN8hSNeQkn3ROxcoxijdxo7
         vHtqjgrcBV+sn35PAcdchldIAkCXSuARCew2I8vguxAiZ6JTGKtEaigFEyZwlBqJjD5N
         bKYiL7Qf9Od5zj2Rs2NLQhb1Qh+klq/TV9OaMvhhjgn/4k1SwUE+VRs0ApT5Af5dVB14
         mO4g==
X-Forwarded-Encrypted: i=1; AHgh+Ro+HcxwrxKxsP7d0hmdF3riGl5fe4mvmwCzyogqX2dqFhzMKqZDTIl6WMZqY5AuMscM/8a82CX6vJSv6eaX0D5a15s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz13jvnPZsfBrIm7OoB52AbtYqJihSjMzmxZO8jQjqhuMpyvTky
	RdTUsUpn1OJKFiSJVQ094LgIMehZ4V9fNJ7bmQTkRd560+f+1Mo+6YiTsOJvw+CGUZ9mgX9FLUL
	kc3bNCwrfdelqiCN4Tn7Am3q1hxAo99dzdIXqOm66
X-Gm-Gg: AR+sD119LZSxzB3kG2MDhTlZUbZ6Oj17SLTiV4W+ahmmkX+QnIXLBlAD9OLrRIYUmWg
	rzGBDAizY9j6gjfb5ouzizV0l3r+YAROSPldo2w6cXRmGHlpZLRBDHuI3YuBIThYzL935gvx9wH
	H8xhOcnFyFnWHgL8/c67kgk/EPzxeRqaLPMqHChrA9F6dP6crS4+38fZbkmNjzmsH57GbYl+wx6
	0e5XFo2ove2gnegiSySgWZJ5u1DNoX2aZHNrVB8NZO3aF1ptV511PxAU5VocqyetlPLfjIsCqHs
	nfmiHPAcAmoppWqqYl2gw9LmDWA/0aglKawYbfTbuUEG6+PAMyoDT572Pp810jd7hMZ3qCb41jD
	ytAFLys2TnN4=
X-Received: by 2002:a17:90b:1c8e:b0:38f:1a80:d1e7 with SMTP id
 98e67ed59e1d1-3903c596de7mr90484a91.13.1785857988201; Tue, 04 Aug 2026
 08:39:48 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Aug 2026 08:39:47 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Aug 2026 08:39:47 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <7f23d149-b7f0-465a-a9c0-5c7484e289d2@intel.com>
References: <20260728-gmem-inplace-conversion-v9-0-35f9aec2aed2@google.com>
 <20260728-gmem-inplace-conversion-v9-20-35f9aec2aed2@google.com> <7f23d149-b7f0-465a-a9c0-5c7484e289d2@intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 4 Aug 2026 08:39:47 -0700
X-Gm-Features: AUfX_my5tJzuKxcHX_DSDai20MF8F8MLGyTCXlBPRZTIfOOy8MGvwUJsA-dI9HA
Message-ID: <CAEvNRgErZqaLPpBveBd2VxdrS_8mjMbArL_=AhzMdikXmUU5VA@mail.gmail.com>
Subject: Re: [PATCH v9 20/41] KVM: Let userspace disable per-VM mem
 attributes, enable per-gmem attributes
To: Xiaoyao Li <xiaoyao.li@intel.com>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
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
	Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Xiaoyao Li <xiaoyao.li@intel.com> writes:

>
> [...snip...]
>
>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> index ea2752989f8bd..df67a6188aa99 100644
>> --- a/virt/kvm/guest_memfd.c
>> +++ b/virt/kvm/guest_memfd.c
>> @@ -1137,10 +1137,12 @@ static bool kvm_range_is_private(struct file *file, pgoff_t index,
>>   {
>>   	struct inode *inode = file_inode(file);
>>
>> +#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
>>   	if (!gmem_in_place_conversion)
>>   		return kvm_range_has_vm_memory_attributes(kvm, gfn, gfn + nr_pages,
>>   							  KVM_MEMORY_ATTRIBUTE_PRIVATE,
>>   							  KVM_MEMORY_ATTRIBUTE_PRIVATE);
>> +#endif
>>
>>   	return kvm_gmem_range_has_attributes(inode, index, nr_pages,
>>   					     KVM_MEMORY_ATTRIBUTE_PRIVATE);
>
> With my suggestion[1] on patch 7, this diff block can be dropped.
>
> [1]
> https://lore.kernel.org/all/dd4201f2-3660-46ad-958f-c70feb1ab1c3@intel.com/
>
> The code looks good to me,
>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
>

I think your earlier suggestion on only defining the module_param when
CONFIG_KVM_VM_MEMORY_ATTRIBUTES is selected still applies, since it
removes an avenue for a user to turn off gmem_in_place_conversion if
the other option (VM memory attributes) isn't available.

  +#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
  +module_param(gmem_in_place_conversion, bool, 0444);
  +#endif

Given that we're now dropping the diff block as you suggested, do you
agree that we should keep this #ifdef?

>>
>> [...snip...]
>>
