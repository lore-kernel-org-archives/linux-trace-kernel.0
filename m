Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8C8377EC6
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 04:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787631740; cv=pass; b=DPDnNWVWl7zJb/buyNCf6wWgM/iT0mJCm1DcSW9U1qwQCL3V9twhewnv5GeHJ8skCDF8P3MzUIzNq+mo8RvsMrwU+GbfDKvWN3A6EYLC5+IooOQUDlYe6JfkHU6fiGtxsMG0lLSJNpYQCmm73PwxrDSZWxXavb8YzBuK8Rb0QwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787631740; c=relaxed/simple;
	bh=5wurlj8MFbDvb5ZSMmaeAsrb3WsRNTwRnHS4VgII5LM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ohN35dDyEW13Ba4+x3VxPSrcz0bp0/RjOYxBxjQj7KfxEdXa2m7TMpZMRI1/vPIxxmvY1rJ4o5uYSYV6ghpIy1kQxcY9vghlE9gB7a06KD5L8un68783U5BjD5dSCh1QaCMsgal6gTwUkpWU+ZOoRksiXeAT6NWMpHXirXs2g5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y2OYq+ky; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y2OYq+ky"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d6d28aa26cso7623755ad.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 21:22:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787631738; cv=none;
        d=google.com; s=arc-20260327;
        b=B353+EFpmmmpfQBMzvIYcJe9NbYGpPIXPv9IAdKrF6H8lY2BBVq3h5PWZ7wO/fQej5
         YjwdExajoXMp5iZgZj1wGZZC5APp1UDyghghx0g0Av/2Stiq+ZOgvmL63tVd1xWYWU6S
         4eaB4bPXrDJLU86uJjCeLVR8BaNxEZnrbQm7Au9pmB1In4E51HHEOSPJeVv0G3nq9lSk
         7eU3hat/bQgxm7p+IRmAkjSq5EUNe3ZwsKm2KMD6vKpRCZWb/kTi3HAjSnYHumY23Fc+
         rBONnuQM1RF2UCxfStJE8L04R963ItxL0v6HfoQuubPpc7YhyYT6QsnMZKiUojX7C70z
         fChg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=ii2UjzWdYQBWun6iRfgoLkq7AXK2AM7SF1lOo7W5lmk=;
        fh=icOQh9BFQvovbO/k5niR59BYZaY1jz+s82VjLBaS/lI=;
        b=DB+g6RRuYOArqU1a5cw68BcZjXer2m5H1G4iN9ZyZFSGKBt3Mb4SRbzdVReeH0S5AX
         8RTRI95WJjY+QOgNDf2pHPR0OA+ixh0mGRIgm3hKiyc1evinnJQ5fSOjy5vmNt7KgwIv
         bs9i2xIjM81F3eal6BpzChgxdgp9Dcu/XPd6E8mHDhX78M+gxA9TYLZ2jzpHo5EnJTc6
         5OHCZPJSyx6sBXkrl/gntLn/PwVgw4JZciAAAjwp+DbPo8nWZqBCK2rxyfjIeUiqZve+
         3T/vEafxaxB2XGB1Dh7Nk5GO0OTxv2pabMWk5sy9fWjtnQcD0lmAk07SxIvxdd2gBnOZ
         Apnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787631738; x=1788236538; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ii2UjzWdYQBWun6iRfgoLkq7AXK2AM7SF1lOo7W5lmk=;
        b=Y2OYq+kyEqbKNSj6q6Dq5vgFdtnqaWT7PK/3lv5bhWe06UDmbyJxuvEC32Bjy6Vn7R
         NlK2vT1nEMz+ujnnbjI4dMkwZm6uHEZx8/NXh0GddlTXHOaxPaE3PJaz6nbksn9vU9gm
         Kvkkcw0UQaNGWPayxZvWvQNyCR802hrYSe5EspukffQIuBqgYTtdIs8ZQTE6Vg83GgCB
         QzleF6zvxSmO8iWu4Oa50I6BfKj+2cQfy1ML2Th/qnOICdaXMUQP0/pfm53szXCM2l9X
         WceuCgB2EOqwJN56aqqRyzel2by9k1RGnYuvrrxN/IAFcMmtPkfnkryI0a5ueEOkwKEi
         6Xdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787631738; x=1788236538;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ii2UjzWdYQBWun6iRfgoLkq7AXK2AM7SF1lOo7W5lmk=;
        b=T4Q9XgH8ZJi0nN/bdJL2c3kK0I2s9TxIuDodh2PZrMj3dbeXLloIF7uNmTMAKwfLV9
         phcsSz+0jfaJFQShwoVwlLHBl10B6IWTFN7gcFFg2yOUkdxJ6bn+71Ph0e/RsL1Iwv7F
         v+npWTkKpp6kL3cYC2yRL3mXSmoV2h8JUcG0mNOVcYtjIZ+/7qhcsb8v3XlZnAW4nkRU
         EY/e4Zh4sw2axKaLWWv9QbN893jQe7qjkuDbIwVk5jQiqq4w0AagS/3/GpzbAbGN5iRm
         5Q8TlRIED1u8mzHsckS9jD4yjrYmCbStaGEl6nNneuJoZHFSlw8on4ZF7h9oOz3s1/ad
         M+Ww==
X-Forwarded-Encrypted: i=1; AHgh+RoGGnFCXIJoA/+pI6IAoDGY0hCwiIDmzwwLOzTSK7ri5jHCII5n4ovYFEUPk9Er4+R76j3Jy1rHGby0/5kQ+G3Wzy0=@vger.kernel.org
X-Gm-Message-State: AFuF++lvAIdP+uHRLlTkyG5129zgejAvVOsF8/P+xYanmBQnGMBoIHVZ
	2PuNUjZUwynh1Paa5B6vAFn0rAcU5H2iyhaTT9yacpOFg1cb7Q/zAleKEB9ZJ4YhjCU8+MW6X83
	hu0kJFqVUep+5Pd9hQaVyJ5KN3O6LJUgso8vHY1MN
X-Gm-Gg: AR+sD10XC6ifgZ2qEDcJsM7qs4bGFLOcsnY+zCtSKtvN0mzuh2zpS60dvnLhuK0tq0T
	queIHpJ+AeQSEgkUTqKmnDP4/feDfXuO5gQaRhnMU6sw4oClt5DYn/uAfiE5GgEem+O7HSGZ/Vt
	ULnTptdPxVus4n8RgKJQUTbtVcDfI/WHVQDlHo8Q1E+vmAavo8WHj4pj6KLKRh4ScMGehw+qStV
	/ZTtikLw35xVfmtl4yneZSPYt6knB0N/ehd3eCF1bYkU587X21VuWFXpfv2dDDnr/d8+/GCPmRR
	FB51clvsMxdjdwzPFdrcdc8vaxcrDiwqn8Qa+rr2+OIVRTu9nMP568ywLJRC08CJy9Xc17bhQAu
	o5VMGj7cdt2NPOX/tqgvilpgxZkVUVR4=
X-Received: by 2002:a17:90b:37d0:b0:395:4de9:b30 with SMTP id
 98e67ed59e1d1-39646350ad2mr7583961a91.5.1787631737593; Mon, 24 Aug 2026
 21:22:17 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 24 Aug 2026 21:22:15 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 24 Aug 2026 21:22:15 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <54d1bd0e-c27a-4033-ab97-02cd9579a620@intel.com>
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-7-2fc18ee6d3ba@google.com>
 <a410cca6-0776-44af-8353-9b7375e2fd4e@intel.com> <CAEvNRgGvxMus6pp=xuDYOumH3Ge4oi0=YKjTaFykFHwXuzRDwg@mail.gmail.com>
 <54d1bd0e-c27a-4033-ab97-02cd9579a620@intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 24 Aug 2026 21:22:15 -0700
X-Gm-Features: AcwNN1WQy8t54bcd0rpO36nvPxS3ceyAlSt6scpIWjMhQZqgzc7w7cgeUX3ASbs
Message-ID: <CAEvNRgFhjbgC9Ng1qviPx4oE=qihUwiBcsYOgJG3yOU-nLG1hQ@mail.gmail.com>
Subject: Re: [PATCH v10 07/41] KVM: guest_memfd: Stub in ability to enable
 in-place shared<=>private conversion
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
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> On 8/24/2026 10:45 PM, Ackerley Tng wrote:
>> Xiaoyao Li <xiaoyao.li@intel.com> writes:
>>
>>> On 8/8/2026 5:52 AM, Ackerley Tng via B4 Relay wrote:
>>>> From: Sean Christopherson <seanjc@google.com>
>>>>
>>>> Stub in global variable to enable in-place guest_memfd private<=>shared
>>>> memory conversion, which will eventually be exposed to userspace via a
>>>> module param, and wire up the __kvm_mem_is_private() static call to the
>>>> guest_memfd version when in-place conversion is enabled, i.e. when gmem is
>>>> the sole authority on private vs. shared memory.
>>>
>>> I find this patch changes the default memory type for a @gfn.
>>>
>>> - When memory attribute is tracked per-VM, the default memory type is
>>> always shared.
>>>
>>> - when gmem_in_place_conversion is true,
>>>     - if the @gfn has no memslot, or the memslot where the @gfn locates
>>>       doesn't have gmem bound, the default memory type is shared,
>>>     - otherwise, the default memory type is determined by the
>>>       GUEST_MEMFD_FLAG_INIT_SHARED flag.
>>>
>>> I think we should document this change.
>>>
>>
>> In a way it's not really a "change" since gmem_in_place_conversion is
>> set up as false in this patch.
>
> I agree. It is not this patch making the change but the patch allows
> gmem_in_place_conversion to be true.
>
>> When it is enabled in a later patch, another way to see it is that the
>> default remains "shared unless defined as private".
>>
>> Before:
>>
>> + no memslot, or memslot not bound to gmem => shared
>> + memory is shared unless VM ioctl used to make gfn private.
>>
>> After:
>>
>> + no memslot, or memslot not bound to gmem => still shared
>> + otherwise, ask gmem about status, which I think is already captured in
>>    the module param concept.
>>      + The very usage of gmem (without INIT_SHARED) is defining memory as
>>        private, I think that is already documented elsewhere when
>>        INIT_SHARED was introduced, that now the default is private.
>>
>> So in summary, I feel that this has already been documented in various
>> places. I'll also add the following in v11's "KVM: Let userspace disable
>> per-VM mem attributes, enable per-gmem attributes", in
>> Documentation/admin-guide/kernel-parameters.txt:
>>
>> 	kvm.gmem_in_place_conversion=
>> 			[KVM] Controls whether KVM enables in-place conversion
>> 			support for guest_memfd and tracks the private/shared
>> 			state of memory per guest_memfd instead of per VM.
>>
>> 			If enabled (the default), KVM enables the
>
> I think the default is disabled?
>

Ah. I'm thinking of the state in the way that we're deprecating
non-in-place-conversion. I'll drop "(the default)", since the default
depends on the CONFIG flag.

>> 			KVM_SET_MEMORY_ATTRIBUTES2 ioctl on guest_memfd file
>> 			descriptors and disables the legacy VM-scoped
>> 			KVM_SET_MEMORY_ATTRIBUTES ioctl for private memory state
>> 			tracking. Only the KVM_MEMORY_ATTRIBUTE_PRIVATE
>> 			attribute moves to per-guest_memfd tracking; other
>> 			attributes remain per-VM.
>>
>> 			This parameter toggles KVM's in-place conversion
>> 			capability support.
>
> I start to think that the term "in-place conversion" seems to read
> inaccurate. I think it is describing the shared/private conversion of a
> gfn, and in-place means when a gfn is converted between shared/private,
> the backend comes from the same gmem page, thus in-place. But KVM
> doesn't enforce the "in-place".
>
> If "in-place conversion" describes the shared/private conversion of a
> gmem page, then "in-place" is redundant because the conversion a
> specific gmem page is always in-place.
>

Hmm, a few people have raised something related to this
gmem_in_place_conversion module param's naming: Xiaoyao, Yan, David, and
Sean's response is generally that it is confusing, but can't find a
better way out. The main consideration around module param naming is
that it should be named for the benefit of the admin. We want some name
that admins can understand at a high level (for some definition of "high
level") what this does.

Do you have a proposal to resolve your concern, considering naming,
documentation, comments, code, etc?

>>                       Whether a VMM uses separate backends
>> 			or out-of-place memory management is determined by
>> 			userspace VMM design.
>>
>> 			Note, this parameter is only available when
>> 			CONFIG_KVM_VM_MEMORY_ATTRIBUTES=y. When
>> 			CONFIG_KVM_VM_MEMORY_ATTRIBUTES is not set, in-place
>> 			conversion is unconditionally enabled.
>>
>> 			Default is Y (on).
>
> I'm looking at the doc of KVM_SET_USER_MEMORY_REGION2, which reads
>
> # When mapping a gfn into the guest, KVM selects shared vs. private, i.e
> consumes
> # userspace_addr vs. guest_memfd, based on the gfn's
> KVM_MEMORY_ATTRIBUTE_PRIVATE
> # state.  At VM creation time, all memory is shared, i.e. the PRIVATE
> attribute
> # is '0' for all gfns.  Userspace can control whether memory is
> shared/private by
> # toggling KVM_MEMORY_ATTRIBUTE_PRIVATE via KVM_SET_MEMORY_ATTRIBUTES as
> needed.

I'm not sure how this snippet from the documentation connects with what
you'd like changed. Let me know your suggested changes across
naming/docs/comments/code to address your concern :)
