Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C8CF9C0
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 00:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786665922; cv=pass; b=j2AMDdMLf7Zt79RN6cASSEw7oLYiI8IlZjoeOC6MtGaTFcunNvux0XqRZGF/Dq4Y7GwuugTXU0jbiUr292NnuXHLdiaPtEEacgpTPhbFCq3KF9/vlyQ0+jZrF2vmRJT2hoJDZXVsbiVdGytCOL6wAxOa4FVz6SbtyXZex0KfDXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786665922; c=relaxed/simple;
	bh=ZgGzM+zjl+BHjjeXMPY/ag8Ox5OuAfFJuhyL7H+V3Q4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cP/wxtx+LgRegIob2z0Y41iHvgZFSPQhPpW96kHynrK2ypnz7+NGw4omR65lGUzGNzvlPHw/guX5beKYAFImTAqxaTwJl0sQbN89B5AYvXnSj5PYct7tM8bNc7P3YquQZq3sOvR3vo1nCfKRHmSu2IBOSz9y+NuL0615b+qHHdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fdRoUx4K; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fdRoUx4K"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cc891373e0so7381085ad.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 17:05:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786665919; cv=none;
        d=google.com; s=arc-20260327;
        b=GTzvTeU5sKlGupjEdqfulIqHrav1yiuU9JFJgTv0UA4F8+DlsUsMWCjAts4fPMDU8l
         3mErsRuaOVBC36G6z/+9mxaTwBIruGv72Gqt2qfMEJ6D026cvOd5Crt7mykp5DfzIjfK
         tt07SaXYiR4a4DUH/sWe8NQa444BIeMZRjkKxHDXeEAOnPop1vuRHk2KnWm3Ea/v8GAB
         SuYCA8f0M8WGNxJg0nfsRvPxaSTDJX2KolWQZarcMoJM40KtecOPnKk9njWnj7iR7NB2
         FmABkab7SNAovkPSBdvkhO15FoXCQHo59mscOpnlaiFmAY2bEb6/wYBPJAuV0k+oVFEf
         1WGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=6S8FmXxg5lAUAXg0md8s6VEd12Y3z7y8v3Uv1Qtefa8=;
        fh=5VscwXS31y2gyBsVRP+3B2SPviINzXy/GyWOd4pXJXk=;
        b=e6VAD+eyRSMSc/G+MqPcaM0zyABKbbZvwfzv+QclWRgXqG6VUnTzI4NmTEwa6Qbj5M
         pFFstTGVPNwrONyFdt8HUKNJwcvzkNnY6/882XTaohGR+eJgqg9+7vdm/LjW3txym68p
         BbOiT+vThp7SgaV3nA0jy87u+Yycgg9EUtN2PdWYG106wwYOrCRv8veX61FM8aIqPaUQ
         z77nMl1mD4eWZCTr44CywS+Tt5TgLGvqV98ebV2QwSd6L+DHyiZKeO0/62nSsMwMDZ5X
         99ixZXlHItFMN/jx3oiQusn+FduJZ0U7d/IjWTbWyJsg0VritpSi+zo/0MKPDcTa2xUT
         zAdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786665919; x=1787270719; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6S8FmXxg5lAUAXg0md8s6VEd12Y3z7y8v3Uv1Qtefa8=;
        b=fdRoUx4KG6LCFznmUO29oJyyZjazs8tYsql9ZO4krAb81PnhAot/ahUJg4hFPrWNfk
         fk4+/yIC5Q0f2Qkhr418JE6viJ70ZUX8QMw43r/qVMprrCdWDgKmWXOxLXBNLFl6werm
         fsqt+kYFv+InowddkCAoH/0V8nrt/hAgwJI+qUyYBUStpkxYwvkTY0Blv/Gw2EZvvIKL
         8CRaVOZyi//HmjC5HoZRDmHRtoyd/p+OX9Fabj78nAqnD06Pd1sV5JVLwPL38gHh/rNM
         TBU6H+KQ6DJbh4t5BR/PkGnvZvV9x4MY3sP4ubakkX+YbrHB6jmWkbBCdKcFyUMDs0w0
         2Pmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786665919; x=1787270719;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6S8FmXxg5lAUAXg0md8s6VEd12Y3z7y8v3Uv1Qtefa8=;
        b=H+Hpu1C6zZksmnLQclmsH/Im6JBqS3jgawLJTxhv+0ANTlB4ltYoLO9B9u3WRrQtJM
         KRZjJ1ciUX9j+bUXKhLB2U0m4hgv7C0a2u5HU9HPszkFk5N6a5ve5wD+rzFDWltQ+e3y
         22p4BWOUrpr+437HtDJF6NmzSPTJzvgyRAtdqEeH/32vQVr2+a8iD2ReOfcN76Exqw+O
         roKbe89f3Y2Isz05OdnOsZxcS3QlrD89WN7f6A5pFs19xXyNodKjWcAJul7bKNVLFeIn
         yKGLusXtS7ddTak5kB/ljlr4ybms+NemMmL4RqIadDAG8eoYWU2kKIFWS9PX7izC964P
         eSOA==
X-Forwarded-Encrypted: i=1; AHgh+RqlzlYiJS/lJ3hHHk0Qvf4ZZyLTWO4/MKYKfy8A4FJn5ogR6+bv5all/k3vg/mGc26o4IgxC5ORhxAYNLzb6R1fjHc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv+9thrEyTBI4b636jOcPsBSHtoNpMrktF9R7KF+5d6mK+UUY4
	vfbv3zwMZRYDNSKot1xLCBrCvNJZl3eRD2j+AQ4pnXCupT+sAiB61CbjaEsCQJ/4IXobunVSP3S
	wp0eZAZl+EepOpyjOPF3/7YQ96BTR/ad9U/sAsHB2
X-Gm-Gg: AR+sD13OhSc3E9stH3OmrgObGUtZ8WNowDBUsJX68GRVAZEVTr8B6peSsDSmQdm+aKp
	/fpys1c2UW39IcKeXSMOXufrzmTGuRVmUOCe2lBfpBA/g4y4Io1Ehq80u57L2VlxYsGHgGHXQdt
	jXIcqfrpDwzciKd+NlyxrXRL5vJuuGovC4ooBtUvLPrC9ojhEjt4oNg3VOaxvmHzIex8fO4jLk8
	OnLENIb5Bx0ncZZwg9M4c3Dz6oLxRUVhArKYymWyGZ631QUErLih0oj1lTEXHVNVqxDl1cObdIq
	B0vGLNUk5qUsuZ33gdZ5Xj2yLec0gT6fv9OzRXidiaBH+2XSOQxd6CI+mvNnU90m2QZmtv1XbAR
	tMayd99q8F8DoNUsJ18XGpoIhdvBF1Rt2hfV42XiUpECbhQ==
X-Received: by 2002:a05:6a21:4cc7:b0:3c3:66c5:68cc with SMTP id
 adf61e73a8af0-3cc71fa8eafmr1715323637.21.1786665918897; Thu, 13 Aug 2026
 17:05:18 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Aug 2026 17:05:17 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Aug 2026 17:05:16 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <an5AcEG9mqDgnBYk@google.com>
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-12-2fc18ee6d3ba@google.com>
 <1ec08cd8-3072-4753-ad5e-cd34956647f8@linux.intel.com> <an3o4h-E8mj6CUaM@google.com>
 <CAEvNRgGpCVCGVjc9jCt9Yr+XypF=71h6eBahkXNkrXhfrtGY+g@mail.gmail.com> <an5AcEG9mqDgnBYk@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 13 Aug 2026 17:05:16 -0700
X-Gm-Features: AUfX_mwNyds6nxIp7br0Dvgux1SWKykTqrMhXPSN-3v_34SJDBU412XbJ-YOoSs
Message-ID: <CAEvNRgE+05c9U8C=Zkm1S9hLw3Lw6YMmijZhEe7J4rYQAuNyEw@mail.gmail.com>
Subject: Re: [PATCH v10 12/41] KVM: guest_memfd: Call arch make_shared
 callback for to-shared conversion
To: Sean Christopherson <seanjc@google.com>
Cc: Binbin Wu <binbin.wu@linux.intel.com>, aik@amd.com, andrew.jones@linux.dev, 
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
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev, Fuad Tabba <fuad.tabba@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> On Thu, Aug 13, 2026, Ackerley Tng wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>>
>> > On Thu, Aug 13, 2026, Binbin Wu wrote:
>> >> On 8/8/2026 5:52 AM, Ackerley Tng via B4 Relay wrote:
>> >> > +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
>> >> > +static void kvm_gmem_make_shared(struct inode *inode, pgoff_t start, pgoff_t end)
>> >> > +{
>> >> > +	struct folio_batch fbatch;
>> >> > +	pgoff_t next = start;
>> >> > +	int i;
>> >> > +
>> >> > +	folio_batch_init(&fbatch);
>> >> > +	while (filemap_get_folios(inode->i_mapping, &next, end - 1, &fbatch)) {
>> >> > +		for (i = 0; i < folio_batch_count(&fbatch); ++i) {
>> >> > +			struct folio *folio = fbatch.folios[i];
>> >> > +			pgoff_t start_index, end_index;
>> >> > +			kvm_pfn_t start_pfn;
>> >> > +			kvm_pfn_t nr_pages;
>> >> > +
>> >> > +			start_index = max(start, folio->index);
>> >> > +			end_index = min(end, folio_next_index(folio));
>> >> > +			/*
>> >> > +			 * end_index is either in folio or points to
>> >> > +			 * the first page of the next folio. Hence,
>> >> > +			 * all pages in range [start_index, end_index)
>> >> > +			 * are contiguous.
>> >> > +			 */
>> >> > +			start_pfn = folio_file_pfn(folio, start_index);
>> >> > +			nr_pages = end_index - start_index;
>> >> > +
>> >> > +			kvm_arch_gmem_make_shared(start_pfn, nr_pages);
>> >> > +		}
>> >> > +
>> >> > +		folio_batch_release(&fbatch);
>> >> > +		cond_resched();
>> >> > +	}
>> >> > +}
>> >> > +#else
>> >> > +static void kvm_gmem_make_shared(struct inode *inode, pgoff_t start, pgoff_t end) {}
>> >> > +#endif
>> >> > +
>> >> >  static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
>> >> >  				     size_t nr_pages, uint64_t attrs,
>> >> >  				     pgoff_t *err_index)
>> >> > @@ -599,7 +636,12 @@ static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t start,
>> >> >
>> >> >  	filter = to_private ? KVM_FILTER_SHARED : KVM_FILTER_PRIVATE;
>> >> >  	kvm_gmem_invalidate_start(inode, start, end, filter);
>> >> > +
>> >> > +	if (!to_private)
>>
>> Should I make this condition
>>
>> 	if (!to_private && kvm_x86_ops.gmem_make_shared)
>>
>> instead?
>>
>> Will that help?
>
> No, because that's bleeding x86 details into common code, which defeats the purpose
> of arch hooks.

Ah okay yup maybe it should have been kvm_arch_has_gmem_make_shared()
that defaults to false and x86 will return !!kvm_x86_ops.gmem_make_shared.

> That's why I think it's worth analyzing the cost: if it's in the
> noise, leave it alone.  If it's meaningful, figure out a not-too-gross way to skip
> the entire thing if kvm_arch_gmem_make_shared() is a glorified nop in the end.

Is noise defined relative to the entire conversion process? Would this
benchmark look like

1. Convert 4G to shared on TDX with CONFIG_AMD_SEV defined
2. Convert 4G to shared on TDX without CONFIG_AMD_SEV defined

and then compare the difference in time taken?
