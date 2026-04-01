Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED5D3EE1D8
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Apr 2026 22:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775083610; cv=pass; b=sXK8E468pkvTwnOYm/T1tRrgr+U4zE2JR/7E0ZpRYlXAZs7E9LigaAPzSeMLcx3KDwRAzr/Ts6+6oaf+rGlfmsoE4/CCZFn47n1BhvRe0NphMB+wT57jrrjUgGeUz8YgnYBImk6VQ0Q5YEEQ0lq6URsCKVudu8Q/Sfvth42FK7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775083610; c=relaxed/simple;
	bh=/6bWyUqm+9eDut6ccU8wAGvXDqzMH1T9XonO28gZlms=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f5LhUCRBJLKP9SKI5pcH5VfelCZ+RccdWEGidXOmMqWNhhjDTtKPBA86xt4Bio4ICM9QwgKs1IWZVr77KtFF6Xd1HkVpxDel6bhC2RzkDLl6JDeKitfX/GZceJe1+Pec90rLuFmXrvqZE21yDewHOBdLqJUNsbLgH1XSZ7M0Xv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g7QYe+TP; arc=pass smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g7QYe+TP"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-953ac1602f8so997948241.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Apr 2026 15:46:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775083605; cv=none;
        d=google.com; s=arc-20240605;
        b=Ilhb6+ggu21vPMmt5VWdXFWpxVVb0snk8OnPtw9M5T1QOjhbL1SeQIdXdRiwnNcMVh
         U/+vmz+nwJkMQWYYW//XSu5n2wHmNZc2cqHbIIra/rjlDu4qUdSb5UIuYKUpUKgvy1HT
         Vcj67Qw07GanKVjgZDWyup9ozxWx+spDnIceRpNFWReSL6YNIEJBBA74VxyxjRW7/FIV
         MdeJTPymgypmgDOI8irMbGMg9zNFjnDPJxHgLCzm3FVSQj+A7cdxS2x+wr02Xu4VnDGF
         L++BG5RYm77yf3/ok9hXfVb+aU/HE3ZwSUjetApBAHFgLgIugb2BwVFLoucufiMtcD/o
         ktpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=9YPPgluH5dfl2SzGDQZmCOiPT4mFW9I+aoMhSywEtUQ=;
        fh=r4T7VBQkO8q3SjiaWmM3UHM0NkIS83eaA3jAo+kXXqs=;
        b=liK1gZAmjTAsbGm4b9IdcbxPU/sy8Oc8iusxHTgzzFJ30HXkeuVwT5KJaUIwEqIWA2
         qpJCYW0a8nXxTe9aGfSPmnhubAaow7wA//jqETuVMpmPsNAL2TMEsXRYoJZxJJI6zMfp
         aZ/yDlJa4hrWJs220ii5rCgDEP0muwbL1ru6jAXeVlDnvHdN8KfFX+MKPJDocnttXLnU
         CybPfseLJINweTrsaJmmYztZSfUidCmkfcaptcm2oU47AnqRKx8lsZX/ZpxwBmLONXIL
         5xXHIaWmvdR5E/uHyJ1etZYizf+gQwD7tQA4DZY+txkFa1NQ5Fh/RSOJz8a+5a9Bw2Fi
         YmQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775083605; x=1775688405; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9YPPgluH5dfl2SzGDQZmCOiPT4mFW9I+aoMhSywEtUQ=;
        b=g7QYe+TP/Cr/+gKuTi2qxvH96+wG0sEY6sCZ8l7nib6kRQYysPP5n/KtiNHUlAde79
         KzrvGGiLJo8s+9nvELRNkZmvwgeBpBmYKVfEBkhYCyJLyDn/HCIs4HLZc/ycdW9km3jT
         y45DCGgnNT2iuH2+hQ2xyvHpKFI/VBkxSKaVWQ0NcngNHtxfgOgQA4k4S/CxYw9T8PXs
         Z6Ewkzv2gTHoL20KQYEaIhxHXa7clvdCcFB6+cY38ZQ4Ub7EARvQodfDpeyB2ZBo1OZf
         SuvylT2RBua1KAmjS6AvqECBjXmTLZrQD5ElWen3gGEXBW8tVa+cEkREEyND6/HueRuf
         jzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775083605; x=1775688405;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9YPPgluH5dfl2SzGDQZmCOiPT4mFW9I+aoMhSywEtUQ=;
        b=RJmzquN7L5OJnDSl2iuDP00b/YoblhWVcE2aOAG+Tr75bpMkCanCunu39e8dtDbGcJ
         bYrFxOJji/Rc6y5cGRt+qcv17xM13HyJgdCAAVLXAkI/Di1ZgPUeOAyb35PNsd14Gej2
         TyrVdKJMUY6mkjSrZYqA68WfvxL/k3beJpJGxGg0RMHsVCJj0xOVJL9UQrR84S9XCuaP
         F8CRvv/LXLJRpRA+ur/HsgiGBJtmLLibnG8AKpS8pMrod6VZhC+iNg+CrLcunkk5Ad7X
         qKjq8h4Kgwebf49HSqMXA/0yqzdNzuWVFmBeJ4oqexYLy4NyYLxFJwJsusd2iGE5f87L
         H6fg==
X-Forwarded-Encrypted: i=1; AJvYcCXcb+0LQV4YVAjo+lrvFrnTYWGcrhrDUXeoZyFhweTHqLKyT/1X7q2TrmyoMQrX0TtQAluYRJaI0T8f7R4Fv7/GYD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzJ/xM3g0ourTGW2YJ7e88YJbwY8P2iwVshegGc+IoKuVQtV1m
	TwziJdcl9Jp4KB9X6v6WO5LrPEODiks8YfAQKzzOAOqI+rnGOjGhBkHvU62RW5aXp8zsHFrtkF2
	Tf3mBASiauFFWzCeMf3aKfERkjFq4tzMt9xXvmKeN
X-Gm-Gg: ATEYQzyylPsLYoj224Ayp+c0PgNZ9jVMi9gFPjfUkiEFbdmfP1I42LdmKvrelhT+MW0
	hgyMSY3lpT204BJ+ATKYJc9gpAb/16vgGKLQMjNm9GXXn2PCvXgcoFAjyjcnmXb6zbrBxaDGgCK
	BjiAdB0RiT2WE+s1ccVPbFjrIvOoAmUMYF98q01+ZkG3eRWNJ0JR8ee2ztSw19WULTwdBOcaHW7
	PBJWjc5ehIao37VAApGxAzreSU2BGhL9wvUs8LIWFbcuu4smWr/tFE3QpiI19ZMBc7+rGQKgZK4
	N2dWIJupKQVhHl7842Zy06gdeXyl55sZsAn9R0D2RPXJQ5qOzf394rpdt+UU+OrjsAV9qA==
X-Received: by 2002:a05:6102:3e19:b0:602:70ca:64ff with SMTP id
 ada2fe7eead31-6058a9eb523mr70227137.20.1775083604142; Wed, 01 Apr 2026
 15:46:44 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 1 Apr 2026 15:46:43 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 1 Apr 2026 15:46:43 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <cqkyz4zxosmev6lnbasa32ed5jjfljrx3gr6plyjfhrtbysuwr@rg5noy6y6ayu>
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
 <20260326-gmem-inplace-conversion-v4-10-e202fe950ffd@google.com> <cqkyz4zxosmev6lnbasa32ed5jjfljrx3gr6plyjfhrtbysuwr@rg5noy6y6ayu>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 1 Apr 2026 15:46:43 -0700
X-Gm-Features: AQROBzDDCz2wIjIVmNQ0-ajdRi4I1p90A0stJRrbKBWGRj169blHjivIVN8AGHc
Message-ID: <CAEvNRgFgOJj1_WKGrmFfXe8Kg9BrrX7Shmu_cjsEfiq2RP79zQ@mail.gmail.com>
Subject: Re: [PATCH RFC v4 10/44] KVM: guest_memfd: Add support for KVM_SET_MEMORY_ATTRIBUTES2
To: Michael Roth <michael.roth@amd.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jroedel@suse.de, 
	jthoughton@google.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Michael Roth <michael.roth@amd.com> writes:

> On Thu, Mar 26, 2026 at 03:24:19PM -0700, Ackerley Tng wrote:
>> For shared to private conversions, if refcounts on any of the folios
>> within the range are elevated, fail the conversion with -EAGAIN.
>>
>> At the point of shared to private conversion, all folios in range are
>> also unmapped. The filemap_invalidate_lock() is held, so no faulting
>> can occur. Hence, from that point on, only transient refcounts can be
>> taken on the folios associated with that guest_memfd.
>>
>> Hence, it is safe to do the conversion from shared to private.
>>
>> After conversion is complete, refcounts may become elevated, but that
>> is fine since users of transient refcounts don't actually access
>> memory.
>>
>> For private to shared conversions, there are no refcount checks, since
>> the guest is the only user of private pages, and guest_memfd will be the
>> only holder of refcounts on private pages.
>
> I think KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES deserves some mention in
> the commit log.
>

Will update this in the next revision. Thanks!

>>
>>
>> [...snip...]
>>
>>
>> +Set attributes for a range of offsets within a guest_memfd to
>> +KVM_MEMORY_ATTRIBUTE_PRIVATE to limit the specified guest_memfd backed
>> +memory range for guest_use. Even if KVM_CAP_GUEST_MEMFD_MMAP is
>> +supported, after a successful call to set
>> +KVM_MEMORY_ATTRIBUTE_PRIVATE, the requested range will not be mappable
>> +into host userspace and will only be mappable by the guest.
>> +
>> +To allow the range to be mappable into host userspace again, call
>> +KVM_SET_MEMORY_ATTRIBUTES2 on the guest_memfd again with
>> +KVM_MEMORY_ATTRIBUTE_PRIVATE unset.
>> +
>> +If this ioctl returns -EAGAIN, the offset of the page with unexpected
>> +refcounts will be returned in `error_offset`. This can occur if there
>> +are transient refcounts on the pages, taken by other parts of the
>> +kernel.
>
> That's only true for the guest_memfd ioctl, for KVM ioctl these new
> fields and r/w behavior are basically ignored. So you might need to be
> clearer on which fields/behavior are specific to guest_memfd like in
> the preceeding paragraphs..
>

Yes, will update in the next revision, thanks!

> ..or maybe it's better to do the opposite and just have a blanket 'for
> now, all newly-described behavior pertains only to usage via a
> guest_memfd ioctl, and for KVM ioctls only the fields/behaviors common
> with KVM_SET_MEMORY_ATTRIBUTES are applicable.', since it doesn't seem
> like vm_memory_attributes=1 is long for this world and that's the only
> case where KVM memory attribute ioctls seem relevant.
>
> But then it makes me wonder, if we adopt the semantics I mentioned
> earlier and have KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES advertise both
> the gmem ioctl support as well as the struct kvm_memory_attributes2
> support, if we should even advertise KVM_CAP_MEMORY_ATTRIBUTES2 at all
> as part of this series.
>

Read your other email as well, thanks for reviewing!

It makes sense, hope this captures what you suggested. In v5,

If vm_memory_attributes == 1:
    (KVM_CAP_MEMORY_ATTRIBUTES2 will be removed (will return 0))

If vm_memory_attributes == 0 aka attributes are tracked by guest_memfd:
    KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES2 will return valid attributes
    (KVM_CAP_MEMORY_ATTRIBUTES2 will be removed (will return 0))

So yup, KVM_CAP_MEMORY_ATTRIBUTES2 will not even be #defined at all.

>> +
>> +Userspace is expected to figure out how to remove all known refcounts
>> +on the shared pages, such as refcounts taken by get_user_pages(), and
>> +try the ioctl again. A possible source of these long term refcounts is
>> +if the guest_memfd memory was pinned in IOMMU page tables.
>
> One might read this to mean error_offset is used purely for the EAGAIN
> case, so it might be worth touching on the other cases as well.
>

Will update this in the next revision.

> -Mike
>
>>
>> [...snip...]
>>
