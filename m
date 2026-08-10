Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CB43BBA0D
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Aug 2026 23:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786405296; cv=pass; b=XqOEfku5adpTa9JdYZ4hJZMYwwHgcUPUdLDHI60Y+Sy9gaied7rW0a99KfZEmPhV0kERtzvL/4KKfR2U4UmHjg8I7QEpMbHt0ngOxUL9Bmwie95uAmAdJC7we9QYTXjLqjpLOTBoAidSdXnXgqFRh1GAQKVqNLDQz//AuLQR25A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786405296; c=relaxed/simple;
	bh=Q7a7K8y6K91AYZoCZj24dpjtc+/Iv04y0vXjPDlyobw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VUrvh+XxB/w5EjymALPwEQ4XnMPATbXu7GNUMNTEMqq/vtR+3ChA92UAgchEHIU5e/9SzTgXUwRTYrR1lq72Pc0kwXnFTkYViNVez3GYTwW+tCgaS/1DEXqqxZoB6Xi1P3Jf1yGVEcLMIPp/AVuBCaQB9Du+oaXg2v1+oMYU/pE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FEKKeL8B; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FEKKeL8B"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38e69bdb0fcso2190795a91.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Aug 2026 16:41:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786405293; cv=none;
        d=google.com; s=arc-20260327;
        b=QcMbH6GjZPyTtemeloU9DLcCmsuoAvUpKXH+BkkzcHRHvHOW/uf3f6EH5IVWB+guWo
         UjwAPI1qPn5zoUS71AQTNzItIUZS67nIRjIOXJOvmutQHO1ch86YUlu8LZl6hxPenDpf
         D+QdzZJamG+l1Y3sIPQDkVUM4kt/n3SRGcRbZp5FP6aByX7NIpgZ9dxRlV+G9iE6MZTg
         NjkRqpuLdvxmukvz9J12lVflRIoHhZTXGuVrlmG+9JGhfmhw1r2m0XQaGn+VWsv9pj6p
         EH1VxasHFc0a+BJwLV/pbm6pExIiykJj0whJOtcGncphmgIh0qxWh1r0LyRC0vIilItD
         VELQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Dp0b2gqcZ26DbJ9BVPOHI0R6Nl9LEyZ50URFATgNWEw=;
        fh=YexQu4TIDyHqZb2QYfWmeuXBm56iYTkh4IV51+uO7Pw=;
        b=RnunLmqaNwY52k+VOS6FpSDsRlt9wi7Y5Jrd8kHPPnzyHvccbae2JsTpLmozHxN+qL
         7yM/9e0KIkUXOlt/1Nf4Lny8FWK8aOfYZKw2tc4T6uPM4oQuq5f3z93TDJG+nENEsQYy
         0cP+VXX9lzah3MAmPtCy/tby+B5WZadHHJQQsYFAvQwLXFAGLkV+22Digod4jnASFIfr
         gTZN9Mmf8TEiAcAZwTE9hQbkAtBAyWgXEXv9yc97CXcR3JQyJxNpqTW0q4MWjFWv1Jaq
         XI2J2vIfH2Dqk3ESUzLF9wg3IVCqepk2ubdzAr27WVbhOc94ZOBTSooylv7GVbKZhuNm
         J8ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786405293; x=1787010093; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dp0b2gqcZ26DbJ9BVPOHI0R6Nl9LEyZ50URFATgNWEw=;
        b=FEKKeL8BDcu2yxx33NUPSkerBgXdr7tsQFyUtlfDzXvHr22vsNjJFdIcM3SPGSlBbM
         avOM1r8hcMlxihNLXugYUed0t5o1M6x5TG3mwLB1m3Cawm1DU8c9wT4nLSdSzQE/S9lm
         XhYxZ030b7Ipap4HED0csiigjrqr0EwPAjD3JUGcqvq+cYAgDH0PMdJ0+v5X4NjIrXRO
         GFJzI1oBz91TRne2fQEcytITj3ceQXBtPZi5vnKQa5zGqRsx1S5YZTQwEFhRQhEO4mrf
         90ml2wgFG7Po8SiUi9kvpWtG7fbBRnOlDEIX0+eNeBGLdpD1LgyF8xt+6urTpwBQptDI
         jM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786405293; x=1787010093;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dp0b2gqcZ26DbJ9BVPOHI0R6Nl9LEyZ50URFATgNWEw=;
        b=ViXq+7PdYWxVuzx24FWfahz1fbkeQOk2LF/MOAKTk3NN8qMkeiPQizIWMB1sSe6RDG
         qOPIq2751Z1HE20frpLS7KLfcgPsGuhKUd46zVg6BhG4xNSOBIjRcCml5daryXhZpyXc
         SusxrgWDMxpHd0fcf2GDCCzunGA1x10npbAZ9/4kXqos1AxsCLh9iykem6nNZtT3VrOq
         o4O8N0Zg6dZkVyuPDIz2GNa7xZbuMERXT50QfvoBbqYDxU6t8WUanTQ/xhhWRnCnBO2l
         8cj1sWZ0eHUd5jzAl0eRlH9ck1FF8pV9h49ymodCWrN1oz9Ix3+jZBZS3aIKq2VxdtLA
         ZN7g==
X-Forwarded-Encrypted: i=1; AHgh+RofIMX+DQl748FmXBv2//3GoA2UJ34WC3WxBYraOb/3R0+aYkG58PYv8Kr6V7hNPlJX2WVWItIgwKT/0ZzI1p0HsPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIrxpSJGL7uFMbWsg4mCya7JJCjpAqhFt3zjOBcMc7pt8V1TJt
	n1Whsr9SZbEMtU4aQWgvxvygy9YIxUgpLLB0jUbdkn+mPIY4aQPU2+tEVgmYQ21v5SEg6gB8UWY
	7v46gZb6f5+44OViECgN5ekdi88x/Xsq8/t/YudhY
X-Gm-Gg: AR+sD13BAIpOt1GQrZK0TbmJ5kcOYGmD8qkPOhj9spB1P+1eiEITeObG0KQx2dYM1WC
	YF/xYT77wGCf9rmsWifSSln+HY3Jlfi8wvxdjb+s7ru79rwckJnToxU6PYi6EiUJLjtlwatUOZW
	Ir8IcdBkFG+NlKw5ouLXAlml0w7LBI4SKpNWNIiDDoHZRozFcUMgXuci+lnTS9XIH6ZAaAelhko
	DfV19yltqqSPEtsyTrf/wUvMEtUuceZI+txf7cbVbXw6yIkqODLQXnJYRKvuUAqfsHguKrGoAQM
	lVTytlT2TYsb1qy+9Waa4+hgkb5DdDkblZ8EFvOjwKC7F/iH61k9Jf4FxUwoKf3PWmmaNujZrp7
	8Z4JVnAss0cXn7d/va1b0D6dFjSVYLYcNkbE=
X-Received: by 2002:a17:90b:268f:b0:38d:c74d:29c5 with SMTP id
 98e67ed59e1d1-392cca64db7mr5320468a91.19.1786405292124; Mon, 10 Aug 2026
 16:41:32 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Aug 2026 16:41:31 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Aug 2026 16:41:31 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <dd9ebd52-7171-4353-8c83-9363019d55b8@kernel.org>
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-16-2fc18ee6d3ba@google.com> <dd9ebd52-7171-4353-8c83-9363019d55b8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 10 Aug 2026 16:41:31 -0700
X-Gm-Features: AUfX_mw6OlaGLLkL3HyJwIpviYhrAvoZYVarJDuu-bVxocdCtMCbumdkufhLAM8
Message-ID: <CAEvNRgGSK9tO_-TvQvXoMwVwGygh5WjjBUOY-zLOA5yP2DwS1g@mail.gmail.com>
Subject: Re: [PATCH v10 16/41] KVM: guest_memfd: Zero page while getting pfn
To: "David Hildenbrand (Arm)" <david@kernel.org>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
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
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev, Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"

"David Hildenbrand (Arm)" <david@kernel.org> writes:

> On 8/7/26 23:52, Ackerley Tng via B4 Relay wrote:
>> From: Ackerley Tng <ackerleytng@google.com>
>>
>> Move the folio initialization logic from kvm_gmem_get_pfn() into
>> __kvm_gmem_get_pfn() to also zero pages if the page is to be used in
>> kvm_gmem_populate().
>>
>> With in-place conversion, the existing data in a guest_memfd page can be
>> populated into guest memory through platform-specific ioctls.
>>
>> Without first zeroing the page obtained using __kvm_gmem_get_pfn(), it
>> might contain uninitialized host memory, which would leak to the guest if
>> the populate completes.
>>
>> guest_memfd pages are zeroed at most once in the page's entire lifetime
>> with guest_memfd, and that is tracked using the uptodate flag.
>>
>> Zeroing the page in __kvm_gmem_get_pfn() is chosen over zeroing in
>> kvm_gmem_get_folio() since other flows, such as a future write() syscall,
>> can get a page, write to the page and then set page uptodate without
>> zeroing.
>>
>> This aligns with the concept of zeroing before first use - the other place
>> where zeroing happens is in kvm_gmem_fault_user_mapping().
>>
>> Don't mark the page uptodate again after populating, since the page would
>> already be marked uptodate before the post_populate() call.
>
> The downside is that __kvm_gmem_populate() will now zero+write. I assume we
> don't care about possible performance impacts?
>

Would we rather zero in kvm_gmem_populate() only if !uptodate &&
gmem_in_place_conversion && src_addr == 0? That could work too.

Previously, without in-place conversion, populate never reads memory
from guest_memfd so there was no danger of leaking uninitialized memory.

> Worth spelling that out.
>
>>
>> Reviewed-by: Fuad Tabba <tabba@google.com>
>> Tested-by: Shivank Garg <shivankg@amd.com>
>> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>> ---
>>  virt/kvm/guest_memfd.c | 12 +++++-------
>>  1 file changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> index 030af0855f8b0..41950c8105b5d 100644
>> --- a/virt/kvm/guest_memfd.c
>> +++ b/virt/kvm/guest_memfd.c
>> @@ -1079,6 +1079,11 @@ static struct folio *__kvm_gmem_get_pfn(struct file *file,
>>  		return ERR_PTR(-EHWPOISON);
>>  	}
>>
>> +	if (!folio_test_uptodate(folio)) {
>> +		clear_highpage(folio_page(folio, 0));
>> +		folio_mark_uptodate(folio);
>> +	}
>> +
>>  	*pfn = folio_file_pfn(folio, index);
>>  	if (max_order)
>>  		*max_order = 0;
>> @@ -1108,11 +1113,6 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>>  		goto out;
>>  	}
>>
>> -	if (!folio_test_uptodate(folio)) {
>> -		clear_highpage(folio_page(folio, 0));
>> -		folio_mark_uptodate(folio);
>> -	}
>> -
>>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
>>  	if (kvm_gmem_is_private_mem(file_inode(file), index))
>>  		r = kvm_arch_gmem_make_private(kvm, gfn, *pfn,
>> @@ -1159,8 +1159,6 @@ static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
>>  	}
>>
>>  	ret = post_populate(kvm, gfn, pfn, src_page, opaque);
>> -	if (!ret)
>> -		folio_mark_uptodate(folio);
>
> In case post-populate failed, do we want to re-zero the pages?
>

I believe we can't re-zero the pages. When SNP fails to populate it
could be because SNP didn't like the CPUIDs userspace set up, and after
the error userspace is expected to check what SNP likes, then
retry.

IIUC zeroing will destroy the message SNP wanted to leave for userspace.

Michael should be able to explain more here :)

Btw Michael may I also get your reviews on this series?

> --
> Cheers,
>
> David
