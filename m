Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0C43B2FF9
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 20:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782333855; cv=pass; b=j5Csr0SI8LrLhXPp05o0PYLqU2vBN3qI4ldCC4Fqg7gDYWS8ke8qH512Zho8V5ZW6RNLnKpAEippqllWafS/eFcRiFzlnggDaq7qhRdkJk5nximPHn7l4iBXzVHhN1E7dnlYK/9lzZEC6a+eElb4YuerBExLeHxrKv16kObDWKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782333855; c=relaxed/simple;
	bh=QyhcqbadZWN+AG6WcwYfzT9ILGIvGzGDjWcEDHa8YsM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s2ZmTN96EQh+J7woIXXgJZUGeZHlxrwm15y3H2+mkPBsuBmJx7AxhYvp5K7vgn0hMEf4FTSeLbr6gWjUkTDkYdzqTH4DjX11zJrmEat7L1FFqiF7mE9Bg8j/nW51ZYZxXu0vtIH1u9+avzvupgN4GxZSZhmbMnml1RhmNzvI0K0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JSkv1ByO; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JSkv1ByO"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-13986d61b4eso593247c88.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 13:44:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782333852; cv=none;
        d=google.com; s=arc-20240605;
        b=TLFzvpJRE7kvgkPtNNktDsNqRCOiQMokpn3p5BOy3NyrleeRgSQf5MIEcABst2gvzJ
         9Y4ztxmArCNxeB/O9raoCnv0NH3+QXl3bNc7yiHnRDYXBfr+sSOGXbARxaYTwFxqwaW+
         tRsnosQjXFJO2+hMS/rjrrGT7j9W+TQifAeXFeBRlm1hu6PJTBQY0K+Lcqfcnkhwrig4
         x7ZK4jRpAUrqIRWN7mUEwG7QTezo72COAWYUblWVqC6GL4cbjCN6d5oO3IZqs0l4SHAj
         1TDfxIbzyUUbdMQn2dt/RuuWH7Kvh6vZsW/fchOMBxe9fA0LtomHTItfDL5iAH2KJu77
         HmMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=G5/9dkbJhmiJkcsjBrae3PYSyLuk0zvc0a2KRC6LUH8=;
        fh=uwIXhxy3+i0dN0x+jTmgr5NNc5BNgOc9ANzfqtJ9KPo=;
        b=QtA1eRbObNv3+PhH5vI3rTYi/Bz+klNVzG7fLtSdq8cBayxnUwtTfKGwgmrhX8mmxO
         IaNw6+USH/r5HcIrL738j9aHDvJ8Oy7Nz70xCAjZeyQvdiRF076L9dCy3BpsubY7X+9z
         zUkCRo0fPecqSQuiASZCZLEN//qHyWM+jc1KfdtdYfXhdCT0KprBZzH9Lnw2HMkkWrye
         hHGuCmggE3e3mTd/SqbROeK8Ufr/6d0sHIcf+6hnNnoCzHzjM/rkipEwu1eG6RIfGIX4
         7jsBjUb33P1ZHbdB0GP7p9vGAJyHCE2JVuRywYVwx2ihd+GPgtQxTRBhHzA91S30+5to
         hLSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782333852; x=1782938652; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=G5/9dkbJhmiJkcsjBrae3PYSyLuk0zvc0a2KRC6LUH8=;
        b=JSkv1ByOJCbqB3lKP23YrYbT+yH7RufFZrgmn4j/W8qw6G5kef45xY9CunSp1hBjKl
         KHgVhL5ObhUsvnwhujk91Y67/6q+5ENJ5W776GmqArB+gXTtg+DIFH3JaFJNxCbmJgx2
         xK1qHRd0fYVk0P6hcWRVYj+0lEjKw/IRQzc4/bPK98RF9CScDpgGhyhJ+aB4yD10Nn48
         x058kobRMDvgeK0FribCHSLJNszxKB2rtE0mEA2S+CpTC9JeLDOuZC5qZs737sz/P9HV
         FvvFbAnWU8Eix7XSgeUEQs3GFnal1lCF03gEvkFky91ryDTf9BXSrKyKy2IGAXpkxAmx
         c54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782333852; x=1782938652;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G5/9dkbJhmiJkcsjBrae3PYSyLuk0zvc0a2KRC6LUH8=;
        b=OKw8wzZ5FxWDoy0sTAaZhjGFJOK90ZnpYOAD8PCqvM01qhI8QGXvkDSyaoh+iSi0TV
         xnYvEJvZblmEpTXt7xF4EHdor6sH+bUopOVVsfSvix0dNzxtNRvU8HqvJ4VLJGrowO68
         esuACtJ5J1QwvbVr9O0y0Rv9Y4VDe0baNTWEkUQPGAyg2jr2L2e03D7U3IaTMvOq2XO/
         3st1qIzrY7n0w9zFvfJ1hvkHLy4IiWqL+qWig9OxNoq9gwcxAsX/eEw6+Jbw4Ek4YW8G
         So1/VbFN1GZ1AnEN8Bnj98PaEdPwn2JOGJ/uWd9Z4/tRudnMgFJ5hnZAyoX6eOPXbIUA
         EyTA==
X-Forwarded-Encrypted: i=1; AFNElJ8Q5+l/qOgRpAQuTB6UkENjpFrevHsvv/vkLDM3kPpgPbQIfqABZ9D9RVt7cq0S63b1c0K3spZuUN16HEG2V68yf4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGoRixKreSMD0S2Ag6RDk3X6rGc2EYCQTNbHeTmzaOJTwPZt3R
	8C8As+hp/3rWmDb89YoMOWi0UOPuENKrEX0xTPpw5b6bG8NOZ5/SbIxhmo4q8u0g7ff0fh5XQh7
	gmBryLZAXPYzOFZ8p8CnNhdsomPGymnU3bRQCU8BA
X-Gm-Gg: AfdE7cn5UuCXjlfOE7ya0fmPCWef4TLZVdGG3PKcB9dWnMys6Ng6eKoETVaAmZhVYTs
	aDYec9zAQ5y7mR+nIkaUA6qsqQuiIUg0VWqmB9qmQEG04ihO4KwywqYvmaeRqGSNaqPTfdPuzjY
	/faEgy9vFFSqC7dHm8gypNL1+BTdsn24TpprPhYEZzFpm/8dmISwylvBc37XAqUz5AhiRr+3gYm
	EVGNv0UFgXiU30EI+u7xgioVknqLwlq4/GtvgzUBI+61czZYs+Iz7gj6q89nUK83dgtQbEsJ1BP
	tFN46OC4ZzLMnwYb2f4wapYRcqzWQiklIcC+WCyWv7FleFofO36cYFOm8tA=
X-Received: by 2002:a05:7022:e995:b0:137:eda3:e5a9 with SMTP id
 a92af1059eb24-139ad711637mr14297421c88.28.1782333850616; Wed, 24 Jun 2026
 13:44:10 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 13:44:09 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 13:44:09 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <2ef455c3-a3f5-4ba1-86ea-b96416d163ce@linux.intel.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-10-9d2959357853@google.com> <2ef455c3-a3f5-4ba1-86ea-b96416d163ce@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 24 Jun 2026 13:44:09 -0700
X-Gm-Features: AVVi8Cc-v85YTGgbOrOpBNr09aOMCIpUVvlduJvADSpw08YaAcwUxrqW73F-Zbs
Message-ID: <CAEvNRgFYpTAi+F8iF_m3mQnP_hB+DWN1oTnhEQ5WWxduX2D5MQ@mail.gmail.com>
Subject: Re: [PATCH v8 10/46] KVM: guest_memfd: Wire up core private/shared
 attribute interfaces
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

> On 6/19/2026 8:31 AM, Ackerley Tng via B4 Relay wrote:
>
> [...]
>
>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> index bca912db5be6e..e0e544ef47d69 100644
>> --- a/virt/kvm/guest_memfd.c
>> +++ b/virt/kvm/guest_memfd.c
>> @@ -926,6 +926,24 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_gmem_get_pfn);
>>
>>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_POPULATE
>> +static bool kvm_gmem_range_is_private(struct file *file, pgoff_t index,
>> +				      size_t nr_pages, struct kvm *kvm, gfn_t gfn)
>> +{
>> +	struct maple_tree *mt = &GMEM_I(file_inode(file))->attributes;
>> +	pgoff_t end = index + nr_pages - 1;
>> +	void *entry;
>> +
>> +	if (!gmem_in_place_conversion)
>> +		return kvm_range_has_vm_memory_attributes(kvm, gfn, gfn + nr_pages,
>> +							  KVM_MEMORY_ATTRIBUTE_PRIVATE,
>> +							  KVM_MEMORY_ATTRIBUTE_PRIVATE);
>> +
>> +	mt_for_each(mt, entry, index, end) {
>> +		if (xa_to_value(entry) != KVM_MEMORY_ATTRIBUTE_PRIVATE)
>> +			return false;
>> +	}
>
> Patch 1 noted that "Ensuring every index is represented in the maple tree at all times".
> So I think the queried range should not be a hole in the maple tree.
> However, there is a inconsistency: in patch 1 kvm_gmem_get_attributes() explicitly
> checks for holes, but this patch does not.
>
>> +	return true;
>> +}
>>

With Sean's suggestion for patch 1, I'll update this one to default to
the "init" state if xa_to_value(entry) is NULL.

Thanks!
