Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E37305693
	for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jun 2026 18:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782411634; cv=pass; b=gD7Rn+Btb268XyBBu9nmev7xEfWfbKu0o0iunDSDjXTlpyYITTnYDJb73wFzlwUb9oAwIVn0KFuOB07OQfM5F9TkzQbsZ6x8cx46NI+/Nw+dBTt0ELR3D/eQ1dbRkHqsuJPq8Mj0ic5/JfFeJQFrK0wYK7SILjh9MHx62URUMZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782411634; c=relaxed/simple;
	bh=9k891PwJI4EFFALDu5zQboFYTAkeFrF++j9GP6B0KQ8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OFzZDhlVKqVRqzbrnlvd3znGLC6Gv1w4WiSE0NyqPURRjL9E4HPq/gTpNXm0T4/qzgrsKEL1wWUdy8mOKbacSJpbouvYD/OcYzPfoJeHiKlMQH7vHC0ynOBjsZDtuepc1oI+jkvwXsj8EPBpzC7PTeq42n0CWXbpyAhFGAhmA8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e8oFt3LG; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e8oFt3LG"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-139d5c9a495so437854c88.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jun 2026 11:20:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782411632; cv=none;
        d=google.com; s=arc-20260327;
        b=g0FlSbwimkQpm9kmIlX7YAi62rmJybB1CI1NVhUxgN0qmM3gMv+3FQxOt5O4XVLWhY
         fm1q/AtO3MFm2GI+L1Ojixo1bCQGXhi3JI6Z9+pqIrRy88XfXhXMIloWG/FA+guLz9C4
         l+e8gZ+Oi/iHgZg32+Dlcp5o1pv2oR43JuTuTox3tLfMKMc3HQOmfVyrAfGTStUqBxeC
         CXqRcLdroFCa0hvAefbLUOtP+Pxgi0Scd9N6ACAJoztdvbfNindxSy07n/9Bh6uqvnzn
         OC9QWEnh4R8jh+ScQLGwToXp0MquvcFrg0sDhgB134sa3den2+tFKXtIGu51O/0beRYD
         Aj0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Zxjcsz/dsIe56trrVdkQTSG2simPYkWb/FM1GFAid2k=;
        fh=m66ctx/ScWcMMEpLyaqOaPVDvrZiYf49mPIGJELo4MQ=;
        b=PfaIgQM+oRF+HkNGyYgyjtN7QbEqTY9Bv5Hya4zq+L0F5yw2eRLpWwg9uqAeR6+O4K
         mvnkfymHv6FPIQNJMHXcyu3RF1qjXTpl3Tqu1qSd5yJ7V4a62CaVEhBOmyBVXe07xkgo
         xlcC5NYPJcMH5eXGkm9IZV6nViAbGuS0hS2yhIeFFcf9Be7kltOiw1ukRqP1xWgCNt4/
         VJDWI/7kXvupHpLhZBdOn+IQFW3Lz6ojhGpGe8ygmpMuPvNcHDMAchJB5x/pkmmNezp7
         k+rq1rDPsFZQrovVQwgQ0IpCd9OKBDj3dzeA408IU3wwzjJgyJw5n1f+3k2vg5HToHQS
         fK2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782411632; x=1783016432; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zxjcsz/dsIe56trrVdkQTSG2simPYkWb/FM1GFAid2k=;
        b=e8oFt3LGsTo/VMCqFJZ012aCacvbQuFijkW3qnBD91v2JztKaQrzvk+Tw2sKJ4HNSd
         QH1bLDTTm0YEn9XreMNsjVFSzRe3IdWNeClgnwYIQOBUlrJPlb87KSGdiBEa2t7eYXAS
         CO4A9qdDjOrBDVdP04aD2QHnyIz5Q/LKXPrypJc/taOWvtYgzDw5yc1M5l6McpConPA+
         jSXKgCpCQJ/gD80g1/5E3nBcJ4atgOUWvE7aLsBumFESldYxrET9v6wHuaFYqE37XhJS
         URdCvXzUEKczc9FuzEHqAcwiqGgcR5HkBuyo67a5n6Rr16rqJj430QjR+fxFxbmGJhem
         SkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782411632; x=1783016432;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zxjcsz/dsIe56trrVdkQTSG2simPYkWb/FM1GFAid2k=;
        b=s5XvwL75eHVbSYRcdbcHj1RoLb6EYM6Et5fy8STxwFcp+mShdpaY+ibXU+mCOa+lFr
         1ylPAm8MFJx/INZiWXf3QXE1vUN8To5pTk/cVYKyCG9J5Dq+Yk7SxOn1A/hIzwoSxCtR
         iBWl8vvtpJPKR9+qBTREaj4pXcUp/p9rAYq7CACLmiMeaKvXVwecgTAp3hKDqD0MfQ6c
         jWK0wsOu2U77Av7s3CSPfPt14ePfuYajY1KleYvN1y1D+a3kQDu+oRHLPy+Mvvt5YVMz
         7Tk3LnvS4HnbigVfslpm1cHkFA6aiI+qfkeTnvJFtG4IoSKulE9pkqPi9EFXRZ9pirEf
         utzA==
X-Forwarded-Encrypted: i=1; AFNElJ9FrlqNVFWOxXJTceoqLUDhh2mWdeY2p9xEIlxlztQg0eJ03rY2qQ1eYpNh6SPJI5WPyf50LS4ynC34e414M40Byrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWXFkw+qvAIKIKJCfu/CigaCzN4bt0J68EO4KbuHQT0bLGHdQS
	WJZohVK6PWmKBcdCgxQraFh/atCNmyWlfcI+4M9XL84nO3A8aOiJZcpzkoocIwFIgRH53FlaNmf
	nNg+zTpiTRZY+Y0hPkOq/6gU4wykokHpTXuGIZZaP
X-Gm-Gg: AfdE7cknHI2Z/T4zCbNZCVqxNpeqXvn3XBgpqlIDxTXKAHacSYOsOWbxYni5TZLEwAJ
	9WftnY0lndXMnrl1kEjylHNEu+KGiNlp4ArqBtJR323uvNdHFQ91jy5ZBP1Wk+w/8qRqNgd+M5k
	Fl7d5mk6DU0dfuqaWNSGHSR9t+qRnIYrgmnxeO4mb6oJ2CahFqSW/KPvEqZVhpYe1P39Rn2tqoc
	ZJtTkoitQn78sfG6mlMOCpGYIBbx/K3RgBxvaT7t36oV4VDEEpILapbv5joq6g4PQwn2MPWGMtL
	ZJvWoEs+IKu+/ut746qRvTDKFedsoaW2A5/fuBkMFSJUPCXmM7PZynXn3gM=
X-Received: by 2002:a05:7022:ebc4:b0:139:7bac:db41 with SMTP id
 a92af1059eb24-139dbb49566mr3555362c88.28.1782411631187; Thu, 25 Jun 2026
 11:20:31 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 25 Jun 2026 11:20:30 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 25 Jun 2026 11:20:30 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <ajyCn0PnFtQK+Nka@yzhao56-desk.sh.intel.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-24-9d2959357853@google.com>
 <aji/2svhcc84rn5w@yzhao56-desk.sh.intel.com> <CAEvNRgHYTFnHbsLLgMTCSitmnp1_j9Pomikm9qmpGTh1w8YE5Q@mail.gmail.com>
 <ajyCn0PnFtQK+Nka@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 25 Jun 2026 11:20:30 -0700
X-Gm-Features: AVVi8Cc3nGhX7fIjy0JPI276GPFCp7STu7qOIMKXGadYwwvPojaXnYff9SHGUmw
Message-ID: <CAEvNRgFfgV0FbQLzP8hhNH5hMGaQao6OFQin4cb3TAmC7SVhfA@mail.gmail.com>
Subject: Re: [PATCH v8 24/46] KVM: guest_memfd: Make in-place conversion the default
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
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

Yan Zhao <yan.y.zhao@intel.com> writes:

> On Wed, Jun 24, 2026 at 05:05:44PM -0700, Ackerley Tng wrote:
>> Yan Zhao <yan.y.zhao@intel.com> writes:
>>
>> >
>> > [...snip...]
>> >
>> >>
>> >>  #ifdef kvm_arch_has_private_mem
>> >> -bool __ro_after_init gmem_in_place_conversion = false;
>> >> +bool __ro_after_init gmem_in_place_conversion = !IS_ENABLED(CONFIG_KVM_VM_MEMORY_ATTRIBUTES);
>> >> +module_param(gmem_in_place_conversion, bool, 0444);
>> >
>> > With gmem_in_place_conversion=true, userspace can create guest_memfd without the
>> > MMAP flag. In such cases, shared memory is allocated from different backends.
>> > This means this module parameter only enables per-gmem memory attribute and does
>> > not guarantee that gmem in-place conversion will actually occur.
>> >
>> > To avoid confusion, could we rename this module parameter to something more
>> > accurate, such as gmem_memory_attribute?
>> >
>>
>> I asked Sean about this after getting some fixes off list. Sean said
>> gmem_in_place_conversion is named for a host admin to use, and something
>> like gmem_memory_attributes is too much implementation details for the
>> admin.
> Thanks for this background.
>
> Some more context on why I'm asking:
>
> Currently, I'm testing TDX huge pages with the following two gmem components:
> 1. The gmem memory attribute in this gmem in-place conversion v8.
> 2. The gmem 2MB from buddy allocator. (for development/testing only).
>
> The gmem 2MB from buddy allocator allocates 2MB folios from buddy for private
> memory, while shared memory is allocated from a different backend.
> (To avoid fragmentation, only private mappings are split during private-to-shared
> conversions. In this approach, the 2MB folios are always retained in the gmem
> inode filemap cache without splitting.)
>
> Since shared memory is not allocated from gmem, there're no in-place conversions.
> The reason I'm using "gmem memory attribute" is that the per-VM attribute is
> being deprecated, as suggested by Sean [1].
>

v8 of conversions series changed that slightly, per-VM attributes is
going to stay around (because of work on RWX attributes, coming up) and
RWX will stay tracked at the VM level.

For v8 and beyond, only tracking of private/shared in per-VM attributes
is being deprecated.

By extension the entire thing about using guest_memfd for private memory
and a different backing memory for shared memory is being deprecated.

> Besides my current usage,

I think you can set up guest_memfd+2M for private memory and shared
memory from some other source, and that's the deprecated usage pattern.

> there may be other scenarios where gmem memory
> attributes is preferred without allocating shared memory from gmem.
> (e.g., PAGE.ADD from a temp extra shared source memory).
>

Is this TDH.MEM.PAGE.ADD, used indirectly from
tdx_gmem_post_populate()? This use case isn't blocked. Even if
gmem_in_place_conversion=true, you can still set src_address to
non-guest_memfd memory and load from anywhere you like.

Please let me know if that is broken! I think I accidentally used that
setup in selftests and it worked. The selftests are now defaulting to
in-place conversion.

> For such use cases, I'm concerns that the admins may find it confusing if they
> enable gmem_in_place_conversion but still observe extra memory consumptions for
> shared memory.
>

Hmm but I guess if someone enables gmem_in_place_conversion but still
allocates from elsewhere, they'd have to figure it out?

> [1] https://lore.kernel.org/kvm/aWmEegVP_A613WIr@google.com/
>
>> Sean, would you reconsider since Yan also asked? If the admin compiled
>> the kernel knowing what CONFIG_KVM_VM_MEMORY_ATTRIBUTES means, then the
>> admin would also be able to use a param like gmem_memory_attributes?
>>
>> There's the additional benefit that the similar naming aids in
>> understanding for both the admin and software engineers.
>>
>> Either way, in the next revision, I'll also add this documentation for
>> this module_param:
>>
>>   Setting the module parameter gmem_in_place_conversion to true will
>>   enable the KVM_SET_MEMORY_ATTRIBUTES2 guest_memfd ioctl and disables
>>   the KVM_SET_MEMORY_ATTRIBUTES VM ioctl. If gmem_in_place_conversion is
>>   true, the private/shared attribute will be tracked per-guest_memfd
>>   instead of per-VM.
>>
>> Let me know what y'all think of the wording!
>>
>> >>
>> >> [...snip...]
>> >>
