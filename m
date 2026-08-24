Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AD4369990
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 14:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582751; cv=pass; b=ObFiUCRFjsrLaYolh6DBatsgdRYUsAyR1qBNh8Uzk2pVnUeURorwST1YHA2LQd6YaspwW/0hRER7qTE9HQbrNZysXHZVU0MFXeT8JIkTb6ljerLc2xUeMrBQ3AIp5PsE91+eTvwalPfRSBP0zXxuJIns6snklP7Y9Lt4hOPrDuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582751; c=relaxed/simple;
	bh=HjYwTd5kWmHq4WzayeX05JXI6uq7QkVWkmVqyAOIZIg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gzgIuSUPBA0tIdJpVj656ui2g1ta4nt/j/m8VZB8fsPe+fEmYod4+LJkCCDdwiazLtS8UUMF1JoybpjGeakwMz7Q1Us1XdiSBOUXeKLU8RmsYHxFYtRFx/HQBd83taz6eNIkFnMf9Imi+oNLSsPJlKUSG79HIrPLHeKnt+2RcEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bP0h7Zqh; arc=pass smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bP0h7Zqh"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8fcc43c48f7so41047956d6.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 07:45:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787582748; cv=none;
        d=google.com; s=arc-20260327;
        b=NfzRiqzwnsrLkat7h8rWW91ZKXtPP2KgSbHzmGe8uOw4Leu7ip9WyBVVfeGM/aLZTQ
         rs2o98rG7HTy2jXnRFeH6ZbWkjOyhPrp8Oru7x4aSaoARwtsy9Eh3ec1m1lqQYPKlCh9
         AKWQ8vKogcoZS9Z+82ZqLf9VAPbBxoT2Xv6yZpcRVqs8Auf1t9rhNJYHU8kzPBHIhPnU
         CeGCJhCVFspGA+6ofRrV/qWOvl/ZpRNI00F/Qt3a2ZiESaBWWy3K3RJr7HJJwV9K0GFF
         FW1Ht3HLfMhzR+UsP/uPoJHcMOzF6GdTRoZym3bT+7h67apWkhsgb8fRDPT1zEutMLpk
         dhzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=skkP3oMbeet6bj4bc4/M8i6L8abYIXvlg1WGbPCJGYM=;
        fh=gemRYWvfSzlRbMl13nlNW7PK6OmsOckmMmeiCxQvAlc=;
        b=LxTugnLtDf0FZZu45v1ievx3FeXlTc3QROSupC/fZE++jO1aQtTMkFootAV9OxF8wC
         Bw+/LxEzC1RpC0x3hcphDS50nPQh+FxigtHL/Z7w0cuk2fe4C1i8DwiwHEy/fQKmM90T
         4JVCIXL+TBnF0MwMPCim+aeS3d6JuhfACyejOEowBj2mGe5ApS8jnJQB6lfcvUzdNXmF
         IzCXwA/+JPOUY/5pbY8mFbS4tHTKzRydbssULxUpNhrhbSy+JH5+GiZq9Z91+VD4QgBw
         XPYv9DLkyMB1/LYteBF0eSsI55sDLWXX+GRu6r+HsINR+yIRzx7cSdVkqIEL9dLDmjS0
         YWjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787582748; x=1788187548; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=skkP3oMbeet6bj4bc4/M8i6L8abYIXvlg1WGbPCJGYM=;
        b=bP0h7ZqhRP2YZvqVZFGgMR0GPc6dwH6/vzBF6W2hb+DmQUHbkyzIIorUyBAK/VYuoS
         khNXL66K3q3Dbw1lqJVp87tc+5faJbejMLEd5pbky8AHTNu/qv0+CzWTXfiL7NoF1wO9
         gIn8WMJMzMPTvdevPI06JkZ8qaL+ezt+fkYRBb/RNi/bGHuK7fJ4CkYqnOkRJAP++Tsx
         vKWmYJtP/phj0tMvhrH/J1pqucckN7zM3HYb/UqD7CkgP3PpFNhPDwou/xc5GuMhJSaC
         wOBR1ynPpBCfH2eBAWSB3KrKWOSLJGpIpIKTGRRZ2dIawrhmIy8md6FJvyzmo6p9n1wT
         O06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787582748; x=1788187548;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=skkP3oMbeet6bj4bc4/M8i6L8abYIXvlg1WGbPCJGYM=;
        b=VkvFu9qbJV+CQQi6m1m9JbMwfsgdndpdOpwCYSiqqZmLW2L6niNigDPgZ6B80/Ah4u
         yDLstPfHZ6hqPr6t75s8fbnEe6XdE1SgC6cE1o01Dz6DyU5N/qRudoSBhWXqkDwss38F
         mlemB8C5H2nWt07rKqLvxOTROj3qIdr9VIemkHwrHiXT6rEiBFQr0WBS2pJQFPikBqmh
         DZLc1dHo8SqKUeINJ24TJJ6WiHMBMlehN3mPSjnnnJ+RwMIS6mj7hYInyqkwqw9tN4FW
         LS76VwQqYfFxtLuo9TZF/0B6PkWijLSd2efsAhNUdtxXHcxoecZnnAwgeGNG4gP/FUhR
         xwwA==
X-Forwarded-Encrypted: i=1; AHgh+RpmDrdq5HPyrjdEJ4N0Z3ArWrHKTD29YhMUXnIWWwzw6nHGB5utmSBLE0bj096XH1/hecZviiBDbKgG0oHoJlN2GaM=@vger.kernel.org
X-Gm-Message-State: AFuF++kUKmFVQD/CIH4mlKmiZwh58L+MBBk3DxS7ZK/MOwimdnR44D3z
	AGN7qF1lcjXS59a6VmmFSBZ/Wc2ZvknIDlllgyTxVvMoULgYNlTAboj23FiuquJZwP8admNwY7u
	j/eXVWP5TmzMNMgkgsJW+GbRfLaidH9+bFuIIgwk4
X-Gm-Gg: AR+sD13+HR9CZZCN356nVUhS00rkYpDGh2zG8zthnS/MFGy0U6z+EAvz894Ok5SR8uQ
	Us6FT4eQyz2Nh4wRAintzhMf31C+LfWM03+FYy5ghv5Y2yDV2XeZlAhCpbxNtwANfiltXXcvxxj
	LpUAXu73gjmdPOgPsCQ6HorAUlCeG6BpPXTTxDbgvkH1I0JIZcWlWO0RXtqtWj1O9FBLcp9yRHR
	edDwasklmLjsaiinGbkT8icf7lh5ZAFFOYRWb95CLjI25MmIh/3WK87qBXUi3mVN9KgG5liM1eV
	vMdGg9yKntMTe51wrFI7YBx/gA6Ik9hOGTDBC69TyIuX+B6K6aXB9GZ5ZfBHEVgLMJlCLxJqUKG
	9HvQ=
X-Received: by 2002:a05:6214:246a:b0:908:2369:df1c with SMTP id
 6a1803df08f44-90c8f9f6e2amr182627906d6.20.1787582747578; Mon, 24 Aug 2026
 07:45:47 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 24 Aug 2026 07:45:46 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 24 Aug 2026 07:45:46 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <a410cca6-0776-44af-8353-9b7375e2fd4e@intel.com>
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-7-2fc18ee6d3ba@google.com> <a410cca6-0776-44af-8353-9b7375e2fd4e@intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 24 Aug 2026 07:45:46 -0700
X-Gm-Features: AcwNN1X5oDcPBaq55pm-MNepv-y7g9QlVSIhzW239c93dbXJQTRPUD7hBagIvPo
Message-ID: <CAEvNRgGvxMus6pp=xuDYOumH3Ge4oi0=YKjTaFykFHwXuzRDwg@mail.gmail.com>
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

> On 8/8/2026 5:52 AM, Ackerley Tng via B4 Relay wrote:
>> From: Sean Christopherson <seanjc@google.com>
>>
>> Stub in global variable to enable in-place guest_memfd private<=>shared
>> memory conversion, which will eventually be exposed to userspace via a
>> module param, and wire up the __kvm_mem_is_private() static call to the
>> guest_memfd version when in-place conversion is enabled, i.e. when gmem is
>> the sole authority on private vs. shared memory.
>
> I find this patch changes the default memory type for a @gfn.
>
> - When memory attribute is tracked per-VM, the default memory type is
> always shared.
>
> - when gmem_in_place_conversion is true,
>    - if the @gfn has no memslot, or the memslot where the @gfn locates
>      doesn't have gmem bound, the default memory type is shared,
>    - otherwise, the default memory type is determined by the
>      GUEST_MEMFD_FLAG_INIT_SHARED flag.
>
> I think we should document this change.
>

In a way it's not really a "change" since gmem_in_place_conversion is
set up as false in this patch.

When it is enabled in a later patch, another way to see it is that the
default remains "shared unless defined as private".

Before:

+ no memslot, or memslot not bound to gmem => shared
+ memory is shared unless VM ioctl used to make gfn private.

After:

+ no memslot, or memslot not bound to gmem => still shared
+ otherwise, ask gmem about status, which I think is already captured in
  the module param concept.
    + The very usage of gmem (without INIT_SHARED) is defining memory as
      private, I think that is already documented elsewhere when
      INIT_SHARED was introduced, that now the default is private.

So in summary, I feel that this has already been documented in various
places. I'll also add the following in v11's "KVM: Let userspace disable
per-VM mem attributes, enable per-gmem attributes", in
Documentation/admin-guide/kernel-parameters.txt:

	kvm.gmem_in_place_conversion=
			[KVM] Controls whether KVM enables in-place conversion
			support for guest_memfd and tracks the private/shared
			state of memory per guest_memfd instead of per VM.

			If enabled (the default), KVM enables the
			KVM_SET_MEMORY_ATTRIBUTES2 ioctl on guest_memfd file
			descriptors and disables the legacy VM-scoped
			KVM_SET_MEMORY_ATTRIBUTES ioctl for private memory state
			tracking. Only the KVM_MEMORY_ATTRIBUTE_PRIVATE
			attribute moves to per-guest_memfd tracking; other
			attributes remain per-VM.

			This parameter toggles KVM's in-place conversion
			capability support. Whether a VMM uses separate backends
			or out-of-place memory management is determined by
			userspace VMM design.

			Note, this parameter is only available when
			CONFIG_KVM_VM_MEMORY_ATTRIBUTES=y. When
			CONFIG_KVM_VM_MEMORY_ATTRIBUTES is not set, in-place
			conversion is unconditionally enabled.

			Default is Y (on).


>>
>> [...snip...]
>>
