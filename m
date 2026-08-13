Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F054432BE6
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 21:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786654921; cv=pass; b=Htc+e1Q5+t8Hlp/zYbWMJStueIRXKsz1A3qpYf6kTgxHWW84KniSbdwgZLlsFD5Mr6nHnnWgayCX/2XT6JXyiAMYLw5CjV1aqQKHhRFolL66Rz5lNRnSuZyNqt/jsPoL1hMIfXEoXMRPos2Dr23zsP1/Dy2B5Wj7hRD9ZrY8BZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786654921; c=relaxed/simple;
	bh=4zrSQCT5vVjl4UEAlv+oAw5eKuOMF43JfK53dz2A/cQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GhMv93l4jNhnnstX3hxVxXcxqWmbZ8CPFqFcuKwlpAJ0qjC60841POqxYs/QURNhV9ry6VB+TGlHZiE+1DSl/VQ6fwUGDSN78Gn5tsiqMxbj2pMmN3vekgWEBf1xeOppF3vG/be2Xno2aM5AdpUFpfHLZdiv1e5hXz78LfnJBe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e2tTPiCy; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e2tTPiCy"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38e7109321dso232986a91.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 14:01:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786654917; cv=none;
        d=google.com; s=arc-20260327;
        b=PXEsDD5PHmawpZcDEfZObh+O82z70AZ/m8qncffDIahCsJ2r5DHpWZw50z9zjQ5/Sm
         Po8OjrEsxRwxGTRsHPylywUwFpAwEaaWd2Zr/ZPS3l/eaawnHwgjtzl44rDPhdsNZ9iU
         Zwtr5lelQE3foaWTejIqmAOpZmYGhPmo48Uehu/d15o31wl9LGLM9nIrwXe2GjnK7Uno
         ufrHfw1lWqH5vP7yzDI7dHNdMdcA5nHu0tpsLioeBqEJs91aWTLeiEYWHODOPo813c3O
         oH4JcuX9Hqdc9jYyXFll7NRppGvU4a+9NOJIM/oWXhrSkh2Swo2eCS9d3C+jFVztbP3a
         chBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:references:in-reply-to:from:dkim-signature;
        bh=ScWN871Op0fwwgzG1qLzviyqH/P4Azji6iscDLhHJjo=;
        fh=cLCjnna7xNOuDaL6/33SDvUJ+xk8ABilC48q9Bylj8A=;
        b=MSSgYeWVh4aKOKIe7qTYIdUuIZf21CLMR1nTl3dLA5yYreJfjdDKotL5yyTOmderar
         fPvyC38Qox1PYckNXhg3327ukL7TP59rG3zd+DqObhgWtP5ZEQ5feYZafN6hmjZ634mU
         ag2VnS/r7QSxW6+lWXKCbClGFHr6P562lov+gGlF3Yhbpf932O8aZ3/FDMAsV+kUss1f
         ILJKq1fwnTR65ioZGnXjr4V5JUrxDhiljTQzQFhCPBJOFgGab0KeI09deVPAxcBEryoc
         7MEZuzdplXWEsMfdQ8EU5POMu54x2F/+lmNzQ3N/2Tq9nuS3iECd4SwnOg+0G/f5OfHf
         Om7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786654917; x=1787259717; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:in-reply-to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ScWN871Op0fwwgzG1qLzviyqH/P4Azji6iscDLhHJjo=;
        b=e2tTPiCyhzn5HYv2cDsvj1Jm1CbEC2B1xT7QzEg2dSK116FfrQfKCo4m9IaWHOeyW3
         K/s8UE3DPBCvyhK9xR0E5+WpFd/bYBocyotK3JTkfEKRp1i4SkE2K7PG+2zFoo7j7vC0
         uKtoTqZBSP85NQ3B8aW5WKgH0r9+1z+zPSFPQVvt7Wgd4Ywn8NVtqdvyDzhk0PN4HlHX
         Wv8g1MhgHKGSA2WOs0XYV6l47zZi/qzXyHukDE4t/aV/su1slL0cMYZ/rJwVZIJphClU
         8u7UXgdjl57tzNmJKcourbKM319dhhbefdyZU7/dnCCri3ruWyHdTKhk5tv5oKWsdhS+
         8wIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786654917; x=1787259717;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:mime-version:references:in-reply-to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ScWN871Op0fwwgzG1qLzviyqH/P4Azji6iscDLhHJjo=;
        b=TXJ6YdumMnO13Ct4A2u/PUlC4cNtFNwzWeKTPkzr+5TtW+wWj7Lu/Kt8nNjPbIs9pM
         g72xlJXxGz4Gxfme5VrGc1aiopPDOD6B2vNJqRfnHA/WiWXdXKF4SwLzj6w5embY7Fli
         ugxU9piNbY2C7mWZuYfZ1SabX1I47pfwxnR9dAkd4Y/QLecBw7nDFut0+6VOgKVpWJ8J
         nptJmfKr1Ynn0y1OkzoZY0ie82XTYyC0Pn8LPvNE8nSxgRUwbCfxHCHMxrKmFBzDVrsy
         k/gaPr+Xgh/pLRR7BGTggiWF2ZTKbrH/018nACxb5jKdUx/6fITUFyx+H4+SH8mjuPN7
         6J2w==
X-Forwarded-Encrypted: i=1; AHgh+RoDyTZLe3HChwoT0+j+iD9rfJpRPLErHG/fTZE9egdMWARogj4bLVtKqCvFUKq7Yu1taL2w6Or0p8B2C6T3+vTXV2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbJP0QoTUQYUoEhWitPmU37Tz6gQiQ+t8xtrPjGNzJ8bNcLDem
	UTvdoxiXrYbrKBw1unc+9YHWRhO3dZ3WlCB38zXDDum+3EypW7t5wDL60rqL0yp+WpdsvTuRSmE
	G0SRVSK+V7JxNyj6BuEBvIxrmyWhX11CdJNeCDUr8
X-Gm-Gg: AR+sD13BZPkyCU1PSf3jabKa0R/1xyYib6p0L0wqkvN2wDkrK66qNRuCx05ejlJgFy/
	o4opAonk5swqEFMuiJ7DIwm5L7asIJ5ODj5HJkOh5bMEF/S4SXuxXeZKPQAcCPUVGWPrZn7HYV0
	Yr1SGa+OO6Ag7Lla41kfMUUGY97UQYCF2prSbJv4vqpmSNbMuoyfH7MwXJtM5l6/s8jmEgtgsWq
	GCC9QzB8yDF6u23b5WldTq4SQ42eoJQsJGRS+EupHGye40R8egBPq2nceA42DeYPZKwfR1SG/If
	AqcTV3hh3QM5Qp/7NKbOtPIXu/awHk7WjTKXXdUpk2pGkowz6zsiR9EIiJc60rAzHAexhJeEMY+
	2GzaZOI8UDHWTl0Qci8qoFW/lqIVImw==
X-Received: by 2002:a17:90b:3147:b0:38f:1a2e:6e56 with SMTP id
 98e67ed59e1d1-3933b8825fdmr709898a91.9.1786654916555; Thu, 13 Aug 2026
 14:01:56 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Aug 2026 14:01:55 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Aug 2026 14:01:55 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <an3o4h-E8mj6CUaM@google.com>
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-12-2fc18ee6d3ba@google.com>
 <1ec08cd8-3072-4753-ad5e-cd34956647f8@linux.intel.com> <an3o4h-E8mj6CUaM@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 13 Aug 2026 14:01:55 -0700
X-Gm-Features: AUfX_mxCp5gPchMRxL80fZacuO-M5ybDdte9e0UhxtiZjcdkxnSatGLDZOBypz0
Message-ID: <CAEvNRgGpCVCGVjc9jCt9Yr+XypF=71h6eBahkXNkrXhfrtGY+g@mail.gmail.com>
Subject: Re: [PATCH v10 12/41] KVM: guest_memfd: Call arch make_shared
 callback for to-shared conversion
To: Sean Christopherson <seanjc@google.com>, Binbin Wu <binbin.wu@linux.intel.com>
Cc: aik@amd.com, andrew.jones@linux.dev, brauner@kernel.org, 
	chao.p.peng@linux.intel.com, david@kernel.org, jmattson@google.com, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
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
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev, Fuad Tabba <fuad.tabba@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sean Christopherson <seanjc@google.com> writes:

> On Thu, Aug 13, 2026, Binbin Wu wrote:
>> On 8/8/2026 5:52 AM, Ackerley Tng via B4 Relay wrote:
>> > +#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
>> > +static void kvm_gmem_make_shared(struct inode *inode, pgoff_t start, =
pgoff_t end)
>> > +{
>> > +	struct folio_batch fbatch;
>> > +	pgoff_t next =3D start;
>> > +	int i;
>> > +
>> > +	folio_batch_init(&fbatch);
>> > +	while (filemap_get_folios(inode->i_mapping, &next, end - 1, &fbatch)=
) {
>> > +		for (i =3D 0; i < folio_batch_count(&fbatch); ++i) {
>> > +			struct folio *folio =3D fbatch.folios[i];
>> > +			pgoff_t start_index, end_index;
>> > +			kvm_pfn_t start_pfn;
>> > +			kvm_pfn_t nr_pages;
>> > +
>> > +			start_index =3D max(start, folio->index);
>> > +			end_index =3D min(end, folio_next_index(folio));
>> > +			/*
>> > +			 * end_index is either in folio or points to
>> > +			 * the first page of the next folio. Hence,
>> > +			 * all pages in range [start_index, end_index)
>> > +			 * are contiguous.
>> > +			 */
>> > +			start_pfn =3D folio_file_pfn(folio, start_index);
>> > +			nr_pages =3D end_index - start_index;
>> > +
>> > +			kvm_arch_gmem_make_shared(start_pfn, nr_pages);
>> > +		}
>> > +
>> > +		folio_batch_release(&fbatch);
>> > +		cond_resched();
>> > +	}
>> > +}
>> > +#else
>> > +static void kvm_gmem_make_shared(struct inode *inode, pgoff_t start, =
pgoff_t end) {}
>> > +#endif
>> > +
>> >  static int __kvm_gmem_set_attributes(struct inode *inode, pgoff_t sta=
rt,
>> >  				     size_t nr_pages, uint64_t attrs,
>> >  				     pgoff_t *err_index)
>> > @@ -599,7 +636,12 @@ static int __kvm_gmem_set_attributes(struct inode=
 *inode, pgoff_t start,
>> >
>> >  	filter =3D to_private ? KVM_FILTER_SHARED : KVM_FILTER_PRIVATE;
>> >  	kvm_gmem_invalidate_start(inode, start, end, filter);
>> > +
>> > +	if (!to_private)

Should I make this condition

	if (!to_private && kvm_x86_ops.gmem_make_shared)

instead?

Will that help?

>> > +		kvm_gmem_make_shared(inode, start, end);
>>
>> If both KVM_AMD_SEV and KVM_INTEL_TDX are enabled, HAVE_KVM_ARCH_GMEM_CO=
NVERT
>> will be enabled and the logic in kvm_gmem_make_shared() introduces unnec=
essary
>> overhead for TDX.
>> Not sure about CSPs, but in a standard distribution kernel, it's very li=
kely
>> that both are enabled, right=EF=BC=9F
>
> Yep.
>
>> Should kvm_gmem_make_shared() do some optimization or the overhead is re=
lative
>> small in the conversion to shared path so that the optimization is not w=
orth it?
>
> I assume it's relatively small, but it's probably a good idea to gets num=
bers so
> that we can make a semi-informed decision.  E.g. if processing 1GiB work =
of 4KiB
> folios is <100 cycles, I think we generally don't care.  But if it's more=
 like
> tens of microseconds, then I think we do care enough to optimize the walk=
ing for
> TDX.
