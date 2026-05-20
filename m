Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600AB371071
	for <linux-trace-kernel@vger.kernel.org>; Wed, 20 May 2026 20:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779309335; cv=pass; b=GsVsSOhbHM1OhGAEOf7Y9hPBCRI/XCVzAbsZ8X8K9+W9KhxaOSWlH16MD3aew8dtNpgYhVMsC9/JOFEgObjB9VOMtIDp1o6YiyZJj7+NvIzmxpRM5MGv94+rTtpPAARnbwgwu+8MbUygMdukm+VbTWvinll2O7qPGI4LhIQcI7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779309335; c=relaxed/simple;
	bh=UfnbwtuocpefoEJwGQVdq2On9IxQDWbOXLMcN0R2rQ4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BvvbTFBYSK7w2a3MqBKVA7JlD15OuHrnomsmXOfxwIpOGPctNn5Xi2sspjPKW6mz1HO3J/RhWQd+xEfJDgXjLKzwQGiO7AXQejTDmh5laegnn0+tfx40HeCIzwZTOfpKWPMY3Kk/thWGLgSq2bPP93wydREu3BheSNYS6n87BH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BF4ldaZy; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BF4ldaZy"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-393d6025f99so59635921fa.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 20 May 2026 13:35:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779309332; cv=none;
        d=google.com; s=arc-20240605;
        b=chy4E2Xay0skxJAs7PaSu3MwXw77s5ryEgzeVparSTWnbzJNrXTgXvwziSkyNChE/+
         0fMt1VSJnSiglldqZwcmAofv8PZN/IjsJNA+xCpG3Vclqv9ouFM7yN/i7I0SUCwWYik3
         E/igGmsnygNjYNzvWqf7u9cFIFH9qGd3e9ZmWyoAVDhE6IcG7B0YeDPvN5coYsnY8Z3G
         4yWJmiJHA/vhuZtD3OmY2aKHT2yN0m87vtK1zJiH98itJs6ZZs4cahtRI2v24jM2bNEy
         jimbAuFR0XRlEdfxuOqObPHwHa9i/1vbsYwPvPeeI3uL/wJzOaEc8J1brkuRSdHLmk+3
         +gXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=y7Uhb594XOL1gZOtZrSL5VavWJB1z/5+87hhs5G/QCo=;
        fh=HW/T1LNrv/8b1R5u5mPfYsPBOoD4dOOvi9l4o44DJzQ=;
        b=ZmM1Enqlz2C3zbyJz8MlKiOQaic9bhGMazGl0faSIdjYmX/LBmLp4Dbfd3sje0BIEI
         52sX4eePfINCy2HH/5aUPq+pfW8IhdfmDsMOBkLyKYeKpdGTb5bGNrpcU2Mu3VtXFoq2
         CNIemKZqcFWdCphcx9TX5ns2nvtnvZbVaw52TBxWIeFJ/f+OW30UQqFjPt+MxCdkhFRB
         rVoAC4cu2U72B0b4EKzf9leOYaf9cOdrS48J8sUEGF9iML/QTddqTrvYfSD/u/YlhfSK
         uB3zW5R20F8ovWHVrsp29bW1fdQ7G6F9/SudP+PzSvOQWNShlBKTwreplrqaGlEJrg6Z
         VN7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779309332; x=1779914132; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=y7Uhb594XOL1gZOtZrSL5VavWJB1z/5+87hhs5G/QCo=;
        b=BF4ldaZyC+lHxU44sHFQ0CFw+weOZpGOVHFOcMM8Li4CKJThd7CRHo5MjaVFKYUCaz
         X8XvyHppDRJuvc//6aWB12le06EFlb2lPcMYGwsb/SY5XPiGKJaOgjg+D8zfv9nvsSk2
         MSLN2cMKSy7+LW4QZCwjkQ3vHegMSX2QZBTb28MyT/huzKl0D0NjzK7wt0g0kpyrhAmu
         s0Wo8tk3XhbxA/bcSehc88QF4QdeHJW0Ieqc5V/y3kpeKHzCytHezB8cD9PsmFvftPU0
         0l2Me10+xDIVCKjhaAYOVRE8lvPY/zel/blgAizg7rb6n5JODmq4wrLhTAC384dhYArp
         n2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779309332; x=1779914132;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y7Uhb594XOL1gZOtZrSL5VavWJB1z/5+87hhs5G/QCo=;
        b=IaaBHa6oq3NqV3tPAsWgS5JB1KSbgby6ePG8lXUvWuYHrucCRS3ONjlTI27ktLDkwZ
         AoE3oyqVYtVb4zNyTisksYvib3sEJl7FvSreI8pXi6Vks/4bzZulJrR0+NSiUvEF+DeQ
         xNbjnYZzqoHLOzwOMFTyJxmTGDiOe6xLwja47Tn5Kfz+lMvaAAbYwsJuvhX8xUgvaBrz
         0gdJt7k6VTp8JTegzeu/JfURxyjiVDbDFigfVjAz/mYTNMN3ByB1+Jlb/YEUwP3sGawc
         j0+XhaxFUD6XsTGJB59YRSfJat+x011cD6JTJ6ava8U6mTZu8zujVsqkLiCBCYRdWLzm
         t6Ww==
X-Forwarded-Encrypted: i=1; AFNElJ+UkzJWd5lLWFNYGA1Kkk69Et/2ADZzqgAMurnHu0kEZA4MM3+Hq6y13bA9LXHQMA/80/9kAy1fBnKbEjblxBhT4ao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs6T5nl9bz2BMuHjxLEO2wXviLoZ0L06hWobMbC4RwZpHMDCig
	A1zYERP1c/VIBd7gOD9jduRI64lQlRXEi4+is3JGiQDx2k4BbdjsNF8ALB/bIAPxKwFIuXkkGXy
	VABYqEgwERKRSrEpGMrKpKnOmqvzmepxd64b4VeS5
X-Gm-Gg: Acq92OH9gD+HgDiiNk2xhSsTUWE6moXKUoixY30dWhFTHcU4rqwZPJcUI7fPFx62z9N
	efcBtbTpjWklyKxo1ViIUE6cmudQ/Wa1Yt+y218HXVcw9Ssx+XI9cuaupDZYekU+Ka+k05i4xVL
	Ao7ZbmDt1el/R0TfEIgnLCLB2DGwEtAQDcqdTMmd3Amd7jqDind8I5ss14wDET3KJgogShhk3oM
	4VZqff+p96YsGAXE1XeVjhl6znUJt2gFyrrb9V4X9hWzuaTQ23tbF+yyBoNsw+8Hn5WqZbq/C+9
	jwjy3xLRao/RmAvI/g/+pWpuq0rihg9qL7z152btyIZYHjRe4bOF73fXxRdc0Z/VQ1pFz8xc/wi
	2wJyP
X-Received: by 2002:ac2:5b03:0:b0:5a8:8818:819c with SMTP id
 2adb3069b0e04-5aa2ba8d0a4mr6125e87.16.1779309331108; Wed, 20 May 2026
 13:35:31 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 May 2026 13:35:27 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 May 2026 13:35:27 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <CA+EHjTwOfJ=nCRoX3m5uDt=CcF_zrqGsZVBBmo4MscmPqrBxOA@mail.gmail.com>
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com>
 <20260507-gmem-inplace-conversion-v6-12-91ab5a8b19a4@google.com> <CA+EHjTwOfJ=nCRoX3m5uDt=CcF_zrqGsZVBBmo4MscmPqrBxOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 20 May 2026 13:35:27 -0700
X-Gm-Features: AVHnY4JCI2WxkpGpEfiZH45uIXCVj4Nb0JRb9mme96xXqvKAS-EEsMTVSDBkz1s
Message-ID: <CAEvNRgFqPSLKKKb9etgfqdt0y81Agu5RwRipuGw=j2y7W2Y0-w@mail.gmail.com>
Subject: Re: [PATCH v6 12/43] KVM: guest_memfd: Call arch invalidate hooks on conversion
To: Fuad Tabba <tabba@google.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, willy@infradead.org, 
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
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Fuad Tabba <tabba@google.com> writes:

> On Thu, 7 May 2026 at 21:22, Ackerley Tng via B4 Relay
> <devnull+ackerleytng.google.com@kernel.org> wrote:
>>
>> From: Ackerley Tng <ackerleytng@google.com>
>>
>> When memory in guest_memfd is converted from private to shared, the
>> platform-specific state associated with the guest-private pages must be
>> invalidated or cleaned up.
>>
>> Iterate over the folios in the affected range and call the
>> kvm_arch_gmem_invalidate() hook for each PFN range. This allows
>> architectures to perform necessary teardown, such as updating hardware
>> metadata or encryption states, before the pages are transitioned to the
>> shared state.
>>
>> Invoke this helper after indicating to KVM's mmu code that an invalidation
>> is in progress to stop in-flight page faults from succeeding.
>>
>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>
> Minor nit below, but lgtm.
>
> Reviewed-by: Fuad Tabba <tabba@google.com>
>
> Cheers,
> /fuad
>
>> ---
>>  virt/kvm/guest_memfd.c | 41 +++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 41 insertions(+)
>>
>> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
>> index 9d82642a025e9..baf4b88dead1f 100644
>> --- a/virt/kvm/guest_memfd.c
>> +++ b/virt/kvm/guest_memfd.c
>> @@ -603,6 +603,42 @@ static bool kvm_gmem_is_safe_for_conversion(struct inode *inode, pgoff_t start,
>>         return safe;
>>  }
>>
>> +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_INVALIDATE
>> +static void kvm_gmem_invalidate(struct inode *inode, pgoff_t start, pgoff_t end)
>> +{
>> +       struct folio_batch fbatch;
>> +       pgoff_t next = start;
>> +       int i;
>> +
>> +       folio_batch_init(&fbatch);
>> +       while (filemap_get_folios(inode->i_mapping, &next, end - 1, &fbatch)) {
>> +               for (i = 0; i < folio_batch_count(&fbatch); ++i) {
>> +                       struct folio *folio = fbatch.folios[i];
>> +                       pgoff_t start_index, end_index;
>> +                       kvm_pfn_t start_pfn, end_pfn;
>> +
>> +                       start_index = max(start, folio->index);
>> +                       end_index = min(end, folio_next_index(folio));
>> +                       /*
>> +                        * end_index is either in folio or points to
>> +                        * the first page of the next folio. Hence,
>> +                        * all pages in range [start_index, end_index)
>> +                        * are contiguous.
>> +                        */
>> +                       start_pfn = folio_file_pfn(folio, start_index);
>> +                       end_pfn = start_pfn + end_index - start_index;
>> +
>> +                       kvm_arch_gmem_invalidate(start_pfn, end_pfn);
>> +               }
>> +
>> +               folio_batch_release(&fbatch);
>> +               cond_resched();
>> +       }
>> +}
>> +#else
>> +static void kvm_gmem_invalidate(struct inode *inode, pgoff_t start, pgoff_t end) {}
>> +#endif
>> +
>>  static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
>>                                      size_t nr_pages, uint64_t attrs,
>>                                      pgoff_t *err_index)
>> @@ -643,7 +679,12 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
>>          */
>>
>>         kvm_gmem_invalidate_begin(inode, start, end);
>> +
>> +       if (!to_private)
>> +               kvm_gmem_invalidate(inode, start, end);
>> +
>>         mas_store_prealloc(&mas, xa_mk_value(attrs));
>> +
>
> Why the unrelated extra space?
>

Hmm this space provides vertical space between invalidate_{begin,end}
and the STUFF it wraps, like

  invalidate_begin

  STUFF

  invalidate_end

More STUFF is going to go here in future patch series, such as splitting
private pages in TDX.

>>         kvm_gmem_invalidate_end(inode, start, end);
>>  out:
>>         filemap_invalidate_unlock(mapping);
>>
>> --
>> 2.54.0.563.g4f69b47b94-goog
>>
>>
