Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDA43C140E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 14:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782310731; cv=pass; b=n5F5qdCeB2lDelcQjkXCWDGomKjpAMHPHjF5QPsn2y1r5beKRFhEmR33kxci7Y3pbqDSdtfbA/V4+U9bUQ7YAJbKyXwKvBm9EdGNodXtCTSWQFHGptxcyQW9AStSdzGG/PEKfm5PXrNz0fGH/wnWhaJBKo1VaLFFfKPUYtrgQdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782310731; c=relaxed/simple;
	bh=S43KLHfWZf4rr+LSchiMooKQ2vnBu5Vtd0C00yl/idE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TbTPXU1ryvwlb6LHhX+9IOU/grQw4pnJ5BS2eJ+eYuQclIdDMGJIxQrne67aGQYOCjXpuBxF201JizP8CCmeNrG9l4go4NQCoa4oryWp9AcWFIWW2FS7Jh853mvPIosNW70R1+KNiuqdxZFffekonxM/Mpz9v1NLeGw1tlNMzJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=df3sqHyt; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="df3sqHyt"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-13986d61b4eso2706745c88.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 07:18:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782310727; cv=none;
        d=google.com; s=arc-20240605;
        b=hh64LZ7bnNFWiDGBk68j1KQo1m3TL+fz2wIVTWXynfthE9djeou+Iu5yOcvPpsjeo7
         5jeX540KLKZe7wbCsNBmZ8HFxmBm4I5V1RYj+JsgROsvPr3ewUfaIBttLzS+FxzLe/bL
         RaWrWBOzH5rmRUU6IU1g8UBet7e3TMxFudQ9Nj09NSv6oAvd2CU/LEbStZAaJQ1y4WQt
         cR4pbiwr8P3AENPywVYYHgc2n3PVXD8k5eMxIIgLdaXHcGG1DBGyXiHKGJdw/cAwiyJ/
         jR0oem+ZMsI/pTc2wEeTHomiv92FfUnpnsqxL1N/QWe7AbeHBHJ+HJX3b+XtdVOQX7Xl
         bbPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=ucZ6vleVNv7XMe9m+p1ud+LWxJsaO5xEtX2/mrf+WGU=;
        fh=HZ/0KPVTnyvYIqthtHIzv2XKkQkg/15/Ts8u83Myjlg=;
        b=aQAfcOidSQJ/w5byXoipLqhyt+PgEYukdgMUwDfyLWTVnjlUF7KxEIu1z2YdasWd1P
         AT8YkhmzGL50kPzuT0v8IKxWKNtFLGaPJwkHiSdhRI3GGphiaDHGl9i5NfIYnVSA0I/J
         9NJiSJsvaYbkx+YbEL8XQnkZXnU73XYx/9GC5vevXTWLeqhikykEmtrpWTNQOeWn6bJ9
         Ii5HP10nhmAzQ+ck3x7CfzR8sWJ/z14kPpEJ6rtms8FAi6u7qC4aOcysBnUrVVB6HEWL
         zMM+cqdaaSIvNA6BYuE78ssUanmlQvAvmDC9PedlmPkFPyelD5dOxQyZ+CzN4gr/yfJj
         yYkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782310727; x=1782915527; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ucZ6vleVNv7XMe9m+p1ud+LWxJsaO5xEtX2/mrf+WGU=;
        b=df3sqHytMdVQfm8AoVQf0XDsZFlP86k7xtk4HCgprtM4Sn9s7OAXQylD/qcfp/Ep9r
         0t9p/fnfAiUBS/iQBNEPTdSrMRAMDtcJP1OwM4knL5F42tn5UEehXedN8s4JXkHtRTZK
         VOqr9xe3z7xacVEAVUp0J8cETm9/thUkrXIXkD9i85dk8hbcnwljADl4eLtMcNHJUdq7
         Y1FOh+re6oPej1vzugspLX8LP1l+xmKh7xNSPDHoAHZvo10EYqTi2dcHjOsy0YYdRivn
         fRKFRvQUauDv62EyXbk7hRSdU8O/51XpfJwHFWCzmVQRJkPuzoLRk3OrekIrJxhOujO3
         IjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782310727; x=1782915527;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ucZ6vleVNv7XMe9m+p1ud+LWxJsaO5xEtX2/mrf+WGU=;
        b=bMBycnoAESq6qzRr8v5iCxho3lyuE4jI2byg+GmfK1fuYeq8UwY44rYiVRDZq6WlzK
         hznvdRVso654nn7cDtcFAzSyDik5KiPd1pnBoVGazkOwgUxvpzC+SZYyI/0VEyQibuIa
         y+LBtZyMAFlkE42yoOtHTao22WBahhmbr7vWANbtofUH8cYBCF/6x7uoQStdNWSWmVZO
         LgEmwF8+8w1JNb+3VC4SdmKHslWfLnW3bLX3gT/GpyLdv/xc+fOeM1NnPEoeJ/X/07bM
         0OCpV/aW7OgNwH6OSn/O4/7aMQ1fJlVLmGmfkWq7TkMPAsg69uaytNvVZNTS4zoLeCbM
         UmCQ==
X-Forwarded-Encrypted: i=1; AFNElJ9+XAG4UWrxjBJeYECQ5/AMu45Pe8FW2QnYIHbuAwoUStSAkvFLGMIQuXOzQFbRCIGaSRlz4VXJEZgQyFzXHPX1MZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzsq6oeail6lcktUjn/hUWeRfEOLOZ+3MfIIYbCxNdSQwHkZIG
	FHvYm7HrQuIjoUpM2hn3SOC1G27VZqS6cbhjm5k8IvqwoMih2OtaHha9SI32Tp50a+Qk6Za/uOn
	LeTFh1JdZiETv7nOADMfw+xf3/oy4g6RlaJpGGNUB
X-Gm-Gg: AfdE7cnrW6gUpDQKK1kkE2gWumWsKtRS3DBLdT8gy+g+vqDjUaqeWmWXVNjXXJtFyXc
	5C/h2saN9KG/J6SlrMLWhEohxOjeU4Yhg/A+sI/qro9T8+H07cZoug7DIyYMkmdpXxZnPokM8oe
	vm1N4zLQwldojx0smcldjE0UsdYYCc71qyzM/+ee+Zjs03xvMaOzI2NRFuUglWY8KfpR21Y1GL0
	RFBXSgRdewEwzLCGS8X7TSE6EB1uh9S9wGNyWw/6Eb9ILMpnvypzYuI4gN9v1Ve59euIyNohcie
	qEmm9nqlb/OeV5wZj+YcoOAklG4Q
X-Received: by 2002:a05:7022:43a0:b0:12d:de3e:86a8 with SMTP id
 a92af1059eb24-139ad72bfe4mr15983384c88.38.1782310725876; Wed, 24 Jun 2026
 07:18:45 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 07:18:45 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 07:18:44 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <3ec15992-2a29-434b-8c99-8b86bfcf007e@arm.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-8-9d2959357853@google.com>
 <CA+EHjTw6x-mxDnJjnhE-6SV73tMrb0paKDTtOC2j6zJ1fXZDLA@mail.gmail.com>
 <CA+EHjTxu32nQ+vPV7Zmcw76_-V4g2_g=P_UzRnnO2dP1PFO2ww@mail.gmail.com> <3ec15992-2a29-434b-8c99-8b86bfcf007e@arm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 24 Jun 2026 07:18:44 -0700
X-Gm-Features: AVVi8CeUzt8nV1nzvS6dw32sjloWQ_ALAuG02W0rgNOvY8pSNnpach_kfV-0O1g
Message-ID: <CAEvNRgEKB0FhD=qhyX=0m2o+d02Jz6n6njdbFmjyiUpK3Up-4Q@mail.gmail.com>
Subject: Re: [PATCH v8 08/46] KVM: Provide generic interface for checking
 memory private/shared status
To: Suzuki K Poulose <suzuki.poulose@arm.com>, Fuad Tabba <tabba@google.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
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

Suzuki K Poulose <suzuki.poulose@arm.com> writes:

>
> [...snip...]
>
>>>> @@ -2546,7 +2546,7 @@ bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
>>>>   bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
>>>>                                           struct kvm_gfn_range *range);
>>>>
>>>> -static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
>>>> +static inline bool kvm_vm_mem_is_private(struct kvm *kvm, gfn_t gfn)
>>
>> Should have read the Sashiko review first, but where is this used?
>> It's not used at all in this series...
>
> See below:
>
>>
>> /fuad
>>
>>>>   {
>>>>          return kvm_get_vm_memory_attributes(kvm, gfn) & KVM_MEMORY_ATTRIBUTE_PRIVATE;
>>>>   }
>>>> @@ -2557,6 +2557,16 @@ static inline bool kvm_mem_range_is_private(struct kvm *kvm, gfn_t start,
>>>>                                                    KVM_MEMORY_ATTRIBUTE_PRIVATE,
>>>>                                                    KVM_MEMORY_ATTRIBUTE_PRIVATE);
>>>>   }
>>>> +#endif  /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
>>>> +
>>>> +#ifdef kvm_arch_has_private_mem
>>>> +typedef bool (kvm_mem_is_private_t)(struct kvm *kvm, gfn_t gfn);
>>>> +DECLARE_STATIC_CALL(__kvm_mem_is_private, kvm_mem_is_private_t);
>>>> +
>>>> +static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
>>>> +{
>>>> +       return static_call(__kvm_mem_is_private)(kvm, gfn);
>>>> +}
>>>>   #else
>>>>   static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
>>>>   {
>>>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>>>> index 6669f1477013c..8b238e461b854 100644
>>>> --- a/virt/kvm/kvm_main.c
>>>> +++ b/virt/kvm/kvm_main.c
>>>> @@ -2627,6 +2627,20 @@ static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
>>>>   }
>>>>   #endif /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
>>>>
>>>> +#ifdef kvm_arch_has_private_mem
>>>> +DEFINE_STATIC_CALL_RET0(__kvm_mem_is_private, kvm_mem_is_private_t);
>>>> +EXPORT_STATIC_CALL_GPL(__kvm_mem_is_private);
>>>> +
>>>> +static void kvm_init_memory_attributes(void)
>>>> +{
>>>> +#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
>>>> +       static_call_update(__kvm_mem_is_private, kvm_vm_mem_is_private);
>>>> +#endif
>>>> +}
>
>
> Here ^^ as the static call update ?
>
>
> Suzuki

Thanks Suzuki, it is used here. kvm_mem_is_private() was and still is
the function used to check if some gfn is private or shared. Hence, in
this patch, the usages of kvm_mem_is_private() were not
updated. Instead, kvm_mem_is_private() is now set up as a static call,
and the static call is hard-wired to kvm_vm_mem_is_private() in this
patch.

In the later wiring patch, all the places where attributes are looked up
are updated all at once: if conversion enabled, take gmem route, else
take VM route.

kvm_mem_is_private() is special in that the if-else is done at KVM load
time rather than runtime, and I believe that's for performance reasons
since this is checked quite often from the KVM fault handling code.

Buut I think perhaps Fuad was referring to kvm_mem_range_is_private(),
which is indeed not used anywhere. Binbin also asked about this, I think
we should drop kvm_mem_range_is_private(). My reply to Binbin is at [1].

[1] https://lore.kernel.org/all/CAEvNRgGbBcrX5Fw3vNTsTOBNC=Ypi=9-S07674yPxLU9i4akjA@mail.gmail.com/
