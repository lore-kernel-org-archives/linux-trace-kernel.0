Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4474A436BEC
	for <linux-trace-kernel@vger.kernel.org>; Mon,  6 Jul 2026 18:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783361864; cv=pass; b=ipVisNCdS4lUKvX/Vo1mz7JtXUhcB8jGHrcxFtKRta/zUUa6o+I3u+yYmTeCZzMYIv5oMe34X4rYp45w0UNU+eibwCuJM9w0tbuyHt4EBFYroFAjuWZraPWFlJtYQoBco7fT7jmRoS7Y+QVs9SGuqhmh11tyRAAg/dAJTyqFtNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783361864; c=relaxed/simple;
	bh=qof4S+F17VBSSA1zaUR6umxTYpxJBd4EYxHTZo5RHIU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lyUMHq77WO9XW7L334ZxiWNhogpz0FKXl6yZJeUlgILB74RBQy5ZQnpPPBucEijUfrAAik8pATw2SbXB7EeiwDPGdWrUEvyr56YLjmvglTadPR1gJl5q789P9qBCNpCyQyWvnHCexZ1H2jxCI7acI/y0P4W7WmsV5OXIoPMg7gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wGpUJx4+; arc=pass smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wGpUJx4+"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c9fe3c9bd5fso81843a12.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 06 Jul 2026 11:17:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783361863; cv=none;
        d=google.com; s=arc-20260327;
        b=Do+rndiFD9rV1HPa8QmEibwWgEYQ3EfDb4uODFafyhZwNK73shDWgdMKpuwaL++JX0
         V44ZTSe+U+PKUnvjsILE/hlteO+/GqfJr7pI8FVAOxNpuaC1EMGRGCWU7fyy5XA0A0Sn
         nfijKOz6OCDWWW8fvL98BXLwwa9N52P3ENWeFHnSrud0BGrhy0zB8Cn7zm2cza/8RxKT
         f4i0bm2gI7T3Wo6WlPPXmTtE//+j7awfIX1XonMbGntl8/8NUepRk7/bxSHFisRlDWL4
         V/Z3xDaOfZVQ7pn+GhIMTfPUOWGLAxnsx4RFUYrBw1pV+ugPheR3RpQIA9bAFdb/f82U
         +RPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=c+wxJ1Yd1HSbDSoQd0ZgV/xzQAnAHKSd8sgBz4R4ZFc=;
        fh=HGrFKM6mloTdtkE28QBJG7dJQi2HaW4wsVeZ8CRmvqc=;
        b=SG8lVaynTtd/sqwlm7tQg1bjFXuh/dFvlK8zv5TjQe/kT/XOTxElVMTDGuVKlDnWP3
         scSHK1nKcEYwHed3Kli1KX/hbfIHv6xLjm5JiaNamnPjSa7v4qRKjgjK0nsRMSNYiNfk
         HOlBqyOVre4AHkdV7FPZwWj4AovHMbfGbbErIxwoip7doDP2WdLCDmAJyz6+0MlKmK5K
         P3CO7CLO8WWecvccnD1l/en9miZUSERNTOIqXVAT440z7pIR5VIhpBiw0F+y5Pu8OQ1l
         8s2seCHhcylMLkKyjH0DiNJDKPwoG3ZpdrVcrzvWAq6+a8ktnhguEHBCdQMZVteQLrYJ
         vH9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783361863; x=1783966663; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=c+wxJ1Yd1HSbDSoQd0ZgV/xzQAnAHKSd8sgBz4R4ZFc=;
        b=wGpUJx4+twYrV/a+QgakBZLpMgldvhxhp9YA2bba46ICeY6yZlvLj9KMc2AJ6lEw9F
         92iNNNg7JpRMoAf0/RRXF0OlKXtiqrn7pQduloQQun1xnFu5k1mhFYiHwaAd10+q18VM
         63pRMR0036ijWdPN3gaKrBa2/qsX608J2G83g0nq98giD3fCyrE1oG4E/FjTesOsmBsx
         jDvopr8B1foFGlcZw3tkbYYrbQctK9HFoGDXb1uC52/8O2uH+6U4jzQm8uLW5Q8hSbw4
         IRI0Tw5UOm7Vd8x5+HZssZL3Tlb7kB8TCuWCF6OokPtvxbqgcRv4KqekGY33kxl7FAgO
         fGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783361863; x=1783966663;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c+wxJ1Yd1HSbDSoQd0ZgV/xzQAnAHKSd8sgBz4R4ZFc=;
        b=VTg8YUVAOvK0sPHDcZPHQjmECQPynob24kDXAFZKzUsoG6tw+cOGEYrOzpCnyPK22y
         SMO3pMh7EI1dSffoSsMOdnjMUFp3KjGdY2+pFOGBVpg/F8Mwf12ZmQFGASGQQzIQeLmL
         0bGitBmJQH5mzBAd1dg4mq5qvbAdB1GBE1Mw7Obe8kYpDSvu1Y8jvdWg+rki/oTKB8tl
         IofFBOAZepurFGa15rScNMaScGf1W4Q1GNDl5LDv4dL7ydlxYo6ITbJem4KtYw7D9r+q
         Qy25qaz0Zev4E1G5Eo8NEtEY09aayv2qqU2j3wFnH2IRxVkt7yPOOK59Xxv8n3FK3OgN
         5yFQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpd7Lp/fTcl7/OR44wcrh8wVnbt78gtFvcLEBbG5zw4NnwoUuJcaJ+2YEurCaNCk9KqBdYi5l5X6N1h4iGQjZOTxF8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6QA+By2w6PpvXPzGKtdqCMsdlqmsdReQE/TlFDu+5/76/FF+b
	SH2oxavGjIOoQgQiW3FLbwWKh2GN9iC2OCS43ATr8XLSABLHKGtSXIommCW+gVy1fV+UqEHEqDN
	Qp9TPpcNQktdsq2ib9OtLyrOJYle34Sn65bSaNRIh
X-Gm-Gg: AfdE7clHOawhjmA29JwDC8WbXpgxYn87mLuKsTvFqQcPdqDGjwjIuVYiRoq5HPeIeCM
	jL28HJ5OLVqKXM/RIoPhxnzFPqDFRn8SLQNb8WecS6PgJ1areGZuvxQHIeefBS1LoYpdCqPJgHV
	t3Ce2/NijVT4K7ZMYnrXEBZZsYbm18nG4MSHrwpd0Tq082SSEuQweuAOtZef2ae2GsaXD6M5qae
	YDzhRRSWBUVH4fWkvpMhgecQPfkfHDBlPzxbVWoLhv+UrKpRg1rV+AJrYvEDOjc3PPzagvo+ekG
	mPr+qCxQEPbEo0mXUNPV/Bjz6xlsSM63UTMYyYhhjk67UJmWl652eP5uUHSiJqY/I72SVg==
X-Received: by 2002:a05:6a21:6906:b0:3bf:79b5:ebdb with SMTP id
 adf61e73a8af0-3c01caab306mr16907533637.21.1783361861894; Mon, 06 Jul 2026
 11:17:41 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jul 2026 11:17:40 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jul 2026 11:17:40 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <114e2488-97ed-4740-a8e8-1edd991f26c5@arm.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-13-9d2959357853@google.com> <114e2488-97ed-4740-a8e8-1edd991f26c5@arm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 6 Jul 2026 11:17:40 -0700
X-Gm-Features: AVVi8CeLpju1khujHSRbueqIxtdXRIsffiKvTI6S-exNvUblyDgAMTgWeujtT7w
Message-ID: <CAEvNRgFKbKfTMkqh_XF-igm07qYWfRwYJ5SH7wHcLZnqesCzTw@mail.gmail.com>
Subject: Re: [PATCH v8 13/46] KVM: guest_memfd: Add base support for KVM_SET_MEMORY_ATTRIBUTES2
To: Suzuki K Poulose <suzuki.poulose@arm.com>, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, aneesh.kumar@kernel.org, liam@infradead.org, 
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
	Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Suzuki K Poulose <suzuki.poulose@arm.com> writes:

>
> [...snip...]
>
>> +static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
>> +				     size_t nr_pages, uint64_t attrs)
>> +{
>> +	struct address_space *mapping = inode->i_mapping;
>> +	struct gmem_inode *gi = GMEM_I(inode);
>> +	pgoff_t end = start + nr_pages;
>> +	struct maple_tree *mt;
>> +	struct ma_state mas;
>> +	int r;
>> +
>> +	mt = &gi->attributes;
>> +
>> +	filemap_invalidate_lock(mapping);
>> +
>> +	mas_init(&mas, mt, start);
>> +	r = kvm_gmem_mas_preallocate(&mas, attrs, start, nr_pages);
>> +	if (r)
>> +		goto out;
>> +
>> +	/*
>> +	 * From this point on guest_memfd has performed necessary
>> +	 * checks and can proceed to do guest-breaking changes.
>> +	 */
>> +
>> +	kvm_gmem_invalidate_start(inode, start, end);
>
> I added support for Arm CCA KVM patches with the inplace conversion and
> I am hitting the following issue.
>
> 1. I am supporting INIT_SHARED + MMAP flags.
> 2. VMM creates the Gmem_fd with both the flags above.
> 3. Uses the shared gmem-mmap to load the initial payloads (kernel, dtb).
> 4. At the VM finalization time, Populate the loaded regions one by one
>     by
>      a) copying the images to a temparory buffer - Since CCA can't really
>         load the contents in-place.

Sounds good :). I see that you blocked this in the kernel by returning
-EOPNOTSUPP if (!src_page) [0].

>      b) Set the "region" to Private in the gmem_fd (via
> SET_MEMORY_ATTRIBUTES2)
>      c) Invoke CCA backend to populate the private memory via
>         ioctl(KVM_ARM_RMI_POPULATE,..) [0]
>

This flow sounds right.

> [0]
> https://lore.kernel.org/all/20260513131757.116630-27-steven.price@arm.com/
>
>
> 5. Additionally, VMM can mark the entire RAM to be private before the VM
>     starts running, again via SET_MEMORY_ATTRIBUTES2. On CCA, this
> action is measured and doesn't require the Host to "commit" memory to
> the VM.
> Instead the host can lazily donate memory on a fault.
>

For both TDX and SNP, the host can also lazily donate memory,
guest_memfd supports this.

> But step (5) triggers the invalidation of both private and shared
> mappings of the gmem area, from the kvm_gmem_invalidate_start()
> above.
>
> This is because, the entire DRAM now has, some portions PRIVATE (the
> loaded regions) and the rest are SHARED (from the Gmem_fd creation).
>   Thus, kvm_gmem_get_invalidate_filter(Dram_start, Dram_end) causes the
> invalidation of both "PRIVATE" and "SHARED" regions, which results
> in the destruction of the already loaded data and things go south.
>

This destruction will happen for TDX as well. I think we managed to get
around this because we didn't apply conversion on the already-private
ranges.

IIUC on SNP, zapping pages in the stage 2 page tables doesn't destroy
the data, so that's probably why it has been fine for SNP.

> When we know that the kvm_gmem_invalidate_xx is triggered by a
> conversion, we don't need to invalidate the existing pages that
> are in the requested state. i.e., the following patch on top of
> this series does the trick for me :
>
>
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index a97fcac34a0e..62e0427a49f4 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -250,16 +250,23 @@ static void __kvm_gmem_invalidate_start(struct
> gmem_file *f, pgoff_t start,
>                  KVM_MMU_UNLOCK(kvm);
>   }
>
> +static void kvm_gmem_invalidate_start_filter(struct inode *inode,
> pgoff_t start,
> +                                            pgoff_t end,
> +                                            enum kvm_gfn_range_filter
> attr_filter)
> +{
> +       struct gmem_file *f;
> +
> +       kvm_gmem_for_each_file(f, inode)
> +               __kvm_gmem_invalidate_start(f, start, end, attr_filter);
> +}
> +
>   static void kvm_gmem_invalidate_start(struct inode *inode, pgoff_t start,
>                                        pgoff_t end)
>   {
>          enum kvm_gfn_range_filter attr_filter;
> -       struct gmem_file *f;
> -
>          attr_filter = kvm_gmem_get_invalidate_filter(inode, start, end);
>
> -       kvm_gmem_for_each_file(f, inode)
> -               __kvm_gmem_invalidate_start(f, start, end, attr_filter);
> +       kvm_gmem_invalidate_start_filter(inode, start, end, attr_filter);
>   }
>
>   static void __kvm_gmem_invalidate_end(struct gmem_file *f, pgoff_t start,
> @@ -724,9 +731,14 @@ static int __kvm_gmem_set_attributes(struct inode
> *inode, pgoff_t start,
>          /*
>           * From this point on guest_memfd has performed necessary
>           * checks and can proceed to do guest-breaking changes.
> +        * Also, we don't have to invalidate the regions that
> +        * may already be in the requested state. Hence, we could
> +        * explicitly filter the invalidations to the opposite
> +        * state.
>           */
>
> -       kvm_gmem_invalidate_start(inode, start, end);
> +       kvm_gmem_invalidate_start_filter(inode, start, end,
> +                                       to_private ? KVM_FILTER_SHARED :
> KVM_FILTER_PRIVATE);
>

I think this makes sense. Thanks for catching this.

>          if (!to_private)
>                  kvm_gmem_invalidate(inode, start, end);
>
>
> Thoughts ?
>
> Suzuki
>
>
>>
>> [...snip...]
>>
