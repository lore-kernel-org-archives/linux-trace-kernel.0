Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4102F3E315C
	for <linux-trace-kernel@vger.kernel.org>; Sun, 16 Aug 2026 23:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786921339; cv=pass; b=Xu/YhMfYeVGXHTCgytZjOiuYP8B5CeTBzchTgH3Sej9F48dHXob//1OG3M5yoe0yMkSBfCAzD8EAsxOdJsseRwxxdsHAo4PPcmWEtnem2uqa6wntQIhyAcbMHErFMe34cLTUx88GtiDCXSuv+GiQhHY0DAseAR9OO/6TF+yOs2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786921339; c=relaxed/simple;
	bh=TfZcEuGOfr1J68VSYUvGJF5oR+xbrzPMOaOCm+qrrgM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZhBU3R2BBBUgxt2p5r3PqZs/Nqm3GwnqzUGhC+ENND3hxSAg+zo21bqo6aerkp0Y3wJ3sQwM8aXEcMaG6LYl5MSUrBJLvPXvABQ0VBH4ftv2HyDSGu9hggqurA4nl0wL7olsR5WIb7k8wSObaqpE0YbZiagvKRdcgm0dSoKlFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZhytyHed; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZhytyHed"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so2271825a91.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 16 Aug 2026 16:02:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786921337; cv=none;
        d=google.com; s=arc-20260327;
        b=NQxaOfAESuErw2sSsRgJZ4gKrthmu4vrC5xN20lIe5fuvdXmbAOSJ1zCITwaQ214KV
         NurQeIjX9SoaBVUTK3vhmLegtjPh2NKk6+GgTgE5hCuFER+1CrUtv6PBM3qrreJZkyJw
         Vcgnrln72FXdrX2eK0B7x3GID8T6GNZpojPfJ8sdE0CTQoiKMqwxVFIf/P3Y5IN9tp/X
         LGMFmxiKTeEavxHsRrTJwYKxiAFR2ai0JzEmJ5T+yhplKZtY7zvDKhNjftZq39FHOqtm
         faj78gyWJCXDeSJDfdhnRCKx8fFXUjBodkVgd/Mj0AClNVdw7eQX8ai0nF54QyEI64Jd
         CSjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=5ZNfUxpi7veRTWLY2tYd3MK6swZzgBzgGr9g7FewAwE=;
        fh=R8yujAsZzsVpzISSUxx6B3Pc43ZVIcWKi1ziLSd+IK4=;
        b=s/0P2oVf4mfmnkZy/ojj7xKa5n+j6+LnNPe7DGsp4eK3hHyKpJROlsQgEn4K0Mp+hn
         i2SY8v7v26aI1zCDBMfCpGeM9UKZOO3gKR6Fzq6lXXJrGH+j+fQx6KSZcDTVmuaKhEFg
         +0c1d+NfFTHXioXIlEKt1Ftp7OAsNY9HY9JcXMkIUkK4GYJxEovLesP01n6NDGWB1Jmd
         3jLztZkfBnfklz5XPVC1YpNkCreYOBe59u90Jo3opME4Q1fUksxiGQHYBAeOUKhmBWrZ
         8GO22pi09x5gvblUKAhiFWdwigLXkCDwcbBQBcWilPdx4cZ/vTP89svtiPFtmEqK5yr2
         clBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786921337; x=1787526137; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5ZNfUxpi7veRTWLY2tYd3MK6swZzgBzgGr9g7FewAwE=;
        b=ZhytyHedRegTQJdB72hzhl36LkwlPMY+SUvTiVNmcR2RGcaV/Y45h8XH7PULKVmJWW
         kvNIpiVinXbb4MeanQHpAtpUun6QXSs0d2gEFj+kShHk//NNiQs+bjHTR+ZmkzVebzK7
         uyEHY6wzjDKN7zja4oujvUBnY5AHVcx0t9x5whiMPyj7K6rSofmJYrmbDWZWWKr8U1ei
         GGOjbdRWoXsmZPFDzMqRZ3E1iIEUq1UyVXLkFfi+91Le7OjmGd+hbYHNUY5H1kYwkyz2
         jesurAJdpwqbBKRhJlRgPo+0Hpj4OsfpssK8OGcz8iruokGlfWQLtX856uCRYohbZGhu
         BWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786921337; x=1787526137;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5ZNfUxpi7veRTWLY2tYd3MK6swZzgBzgGr9g7FewAwE=;
        b=oyk+OjUn+B2fVGG1tFD9Cw8od5ziuMazCpH4P0hYI4yZ/ZVKZFz8+a7/7XxUUXmpTN
         sM5hCrt8EGHkI8vLxtZBXyckbpJw7Fd4SIqVxqkzh+FKY78n3G59SYdFfViDnL/5SC54
         9ng6dbXWUZ+yFC8a+JWaEbGKR5vttt0Mjwxv1hswzO9TOisCM5H6o2ftCwcJwW/lN2fZ
         qLL2phfbieytXD3sgQKvliUGTNrzUj5KZKu3olA29o6pNQ15zIwa70+V+349TAABKDrf
         L8/PlgTthAOUL361+PrIz4s3T2XBSjEWk6hjsWrHQcAGly2B7De5A+ZFeiGq7FDoBO2L
         Mh3g==
X-Forwarded-Encrypted: i=1; AHgh+Rq3XKPB4OT0lycvZn1kIfuaiP5Y7I5CKApg0xIU9jlboVj3RGV7z4MTa+e2jwRWezrMWHU/waOfgUshwwjWMIJHpAk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqw77yZsNvlEindEvHW2cAsDB8BcZpNSb71wpNksoBz6U5F8sk
	mgMkTF6kNDN77YUgfjDFEDql80P2mFwAnAWNBt0/vgWQiiSybYUcJ/L50+yd1b/iAJScdGWR4X6
	SrYgVn1phDmRPpgwG/XeWRI+q/zAchbhUE2ZoQ/ET
X-Gm-Gg: AR+sD12pqam5Zxx2VHJcsPC/kmAG5mmh0jj+hEt9Wf3eCJpdxin8jEUgFyP98GRgUMY
	/vEppk705C94+XsMeth61KecqspyKNpB0xD2UsUaWjebvXNBnP/j3ok3Y/9G+fAaULXSwTxXfxu
	Luz3WTv8CLJ707dnkzYOtPdt+LRqrSJxzqOF5Bw8VHWR6TtGBYRO3xkIfu3xBDk9MQB7EptxiNa
	vIgkdZqoxFhxpv0wDeq8jXgKoX0tCyagV32RaW2oT1aAbjiEdz3DLDR38wf9d2fu/DNqy8KFk/S
	mEwQPw1xMVDWWygxfbH067Emk7PGTe1tGH5xhjrfclFa0kwMD27X16dN/Tz52mOAP4jFcuZDJAN
	LFg==
X-Received: by 2002:a17:90a:e7c8:b0:38d:adae:4866 with SMTP id
 98e67ed59e1d1-3933bd2066dmr20117316a91.21.1786921336732; Sun, 16 Aug 2026
 16:02:16 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 16 Aug 2026 16:02:15 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 16 Aug 2026 16:02:15 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <beecf36b-b0eb-4691-918f-fd39f46d5d8f@linux.intel.com>
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-15-2fc18ee6d3ba@google.com> <beecf36b-b0eb-4691-918f-fd39f46d5d8f@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 16 Aug 2026 16:02:15 -0700
X-Gm-Features: AcwNN1Va1JdlpRRtXfl-rgaiOwbgkg6rBN2xjp1zNZlzVot1c-IWzDKRKQ6t494
Message-ID: <CAEvNRgGtnQfhCkrWah3jNeivbHCQqRSQEXs=uqJhBmS+GVntrA@mail.gmail.com>
Subject: Re: [PATCH v10 15/41] KVM: guest_memfd: Handle lru_add fbatch
 refcounts during conversion safety check
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
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Binbin Wu <binbin.wu@linux.intel.com> writes:

>
> [...snip...]
>
>> +static bool __folio_safe_for_conversion(struct folio *folio,
>> +					enum lru_cache_drained *drained)
>> +{
>> +	const int filemap_get_folios_refcount = 1;
>> +
>
> Nit:
> After adding the helper, the use of filemap_get_folios_refcount seems
> less obvious. It introduces unnecessary tight coupling with the caller,
> though it has only one caller currently.
>
> Is it better to pass the value as extra_refs, similar to what
> lru_cache_drain_for_folio() does?
>
>

David also suggested [1] something similar, please see
https://lore.kernel.org/all/4c638fc5-5a74-43d0-b5bf-d7ef893cb994@kernel.org/,

Please add on to that thread if you disagree with the suggestions!

>> +	if (folio_maybe_dma_pinned(folio) || folio_mapped(folio))
>> +		return false;
>> +
>> +	lru_cache_drain_for_folio(folio, filemap_get_folios_refcount,
>> +				  drained);
>> +
>> +	return folio_ref_count(folio) ==
>> +	       folio_nr_pages(folio) + filemap_get_folios_refcount;
>> +}
>> +
>>
>> [...snip...]
>>
