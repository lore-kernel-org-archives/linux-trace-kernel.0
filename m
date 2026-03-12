Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F6431D381
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 05:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773294303; cv=pass; b=tOL/x9dHz1NVNEsCYW9+ajNPvoWRfeiQCaq6rf8pJEuymgxtS6fPX8kmuP6ZUQfduN7PeK2/e6j6YIIl3Yy891J3JG35CC8lE5EI+LSb/mIDQ5tcJaLApOQjWM5qk2NTCiJmmawll/yddAsJd4C1wvEl4jH/rqt7oZ+Q4RugP3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773294303; c=relaxed/simple;
	bh=GmJK/N0KBkRxDo+pqiY/6G+ZRXyparhw1yW+Cxl6e28=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FeLngpHAsuVBC+qHGFdNuFFo3GRvwIpQG9YIWHN/nVw1QU6UI6sH2P39Y1LrwSyE2tlauKDLXCDMbVjmFSDNdWLBz2ELflSfcHAFw7YeZOxU2T5erGDiWuTCkr9MdexLlQl61MZjec6o/XS7MgjkxG3Yh/uoHJJx1W7gXTqWYYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VdZJT0Tx; arc=pass smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VdZJT0Tx"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5ffe68892efso442191137.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Mar 2026 22:45:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773294301; cv=none;
        d=google.com; s=arc-20240605;
        b=HeMzTujAbh+Vbtwt4pyk5IcCl6Whkg+ISXVWwRsvsPBB0p85w8KedeipLJwkdxam2q
         wyh81Voq+dYmjrGZJXSrn00ckAXEdwhRJG7AVuifTGWB5KlH7R0odzM0gQfGpdu+0dGy
         6zSKH5EMZIaDKvmmx3T/Zcpd7g36QInTRJ//9VsTrZ+oQxZC8l/RXdvzVeRKmiIq5tV5
         rtLAxQ+1Ci7/l6z2YI3+oA6+f7WsDGZjpcYgWWUswKEQ7sazzrx4U/9OP+GIdRI0OduM
         30lvbYNnUEyYPQ9l5BhM9H8H/0T1TyWM4dVXv1XojnLY1Xfzivw1wJjXvdn+FiksVDFt
         +azg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=WHL+cdGBVdeYzUrRkXUnxuFTgvkDYPGLTyvabwlDW1U=;
        fh=3l5awn8D8oIspswSR1fLrTOwhAg/T3fgMCPTNLwfFJs=;
        b=XT+vFISmhnlNf/2COGkbS6khXwvcDVpjR7Dk73kFXY+q+svAZ9P5krK9/hcSlRQU68
         pyCgPAE0lDhehlrU3X/ATuGj3xOmqT/Hn/XWgv5aUlqFcHLhX+iMF+W2V+e+v9WnDdO8
         zfjmBBLuV7IuJkIzPpYmBUHBGtFUywHzlmUGhZ4shQVU+WGFyWUtrckdwgRzR9I2Pnai
         eVtoOCtI0NLCGEzSbUQMDdxb0Dl0wRlCiru9zPl6V0/ywfyGFMWLphBRhCIGUkElBeBw
         PRrAOeCAUDhLpmUBSh2YOtu+wLA5EDmKQkoYOpv1V1oeYZ6GkCxm2d7uYnUYPQqW+Ygt
         aElA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773294301; x=1773899101; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WHL+cdGBVdeYzUrRkXUnxuFTgvkDYPGLTyvabwlDW1U=;
        b=VdZJT0TxrE2a9giQrcsUQtWWCibe1Z2In7NV0CRlZMWbacWoFRZzPJiR7FY93c03j9
         2yAo6IHTgN6vy8NV77CVpW+HhOc8Y55Q1whsRU7GuexdhiOif0pMktOgLab0yQH24Xmb
         eY626NrC06XAbL+FuZen1nZxylloOh0Xe89KQ40vjxWjixm6s10qgZ4tccTY1C/SL9YU
         idN+6ZtprApYPnh/eGiR+dkQwu97WSop2d6awTVostO+SsiP5p9csP3pOO148vafEevW
         oby0MD9CpiBWwPQcNfulnvgZ3CI41epjzwTw2bXTqHx8ZBGK0yocieKobEXt292GR1Sr
         CfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773294301; x=1773899101;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WHL+cdGBVdeYzUrRkXUnxuFTgvkDYPGLTyvabwlDW1U=;
        b=ADfu9N/Y6wnbEjBnzvds3EJnTEHQD3ZmvtBhODIJ6+RFXY6LoDfwTmZpB9QssHcu+e
         MIxPZZ7MVQRa48PioG5wjbFLTkv/V/ImQTdtNI0VbfQrZulRblCq9l6eirLOBig4RT9G
         v4Hk6Htyv1782rjNHVHdEKkn3R6Uo/Kpz8T7myrSj0QuDZLtF9773vjUCkm9ibmSLqC1
         UJnQtefVy/q3UkmCBsYXnc7J2vg24Ptq0vDQ5nek/pxCuU6Yjti8PevmRzLB1wA8cdQW
         4yNvxhFb1Wo9sTEf68058KyOCcF6cXXMN/LUS891Xb69GfVMlYULSAzWZZUcohlNm14m
         1E5g==
X-Forwarded-Encrypted: i=1; AJvYcCWWs+4d6MQ/1hSzYIo9nwcSghA6ZvTwAm0AZk6Aw1hoCpwoD43QaexRSzvC9nBDdR3TlKUiPIcRbKJteGNvc05CaaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYNga8EYkTUKJoaV+MYyPEehndKNND2pkSmGTcugLNePT80Idx
	PcwZwMcgeFiPxvadH1tdLPrnpct20YesgpKvgHiuutluMz7XiUkEYO8xGypfE7wYhQsUkw2v4Dm
	ar7MnKpcSwhWYbHpWFN8Gpj0fPPK7lngfReHmIDahx4trGiI47kgAuOIcYTI=
X-Gm-Gg: ATEYQzxEJTafMIYgZsDVo367DXaytpplskDYctdHtc+q9V5SeimAc9whv/1uUuxipYN
	nm81+ECRmI4AMNMP1HAwCixY3ATI9hLxRc7ox5YiiGCtAXGetDKs1zj5rUcPx0bwbRtyRPti12E
	Tjwb2D/Sss8+HI7XYRk54AiZFW+DZWfHANOgmvSvT2ZGbChGsFMoao+fIahiizPtFcEdDBF023/
	pxOEHfH79hXWj4pCNlQln4qIcSW6eoTNJnaQgYCKgrYyTo9aKHd/pRNaqcnyyqxLPGIfcIyk9Y5
	HEEq6Tx/yn17p2jqOMrVHVLyydGiuFKyp+cE9w==
X-Received: by 2002:a05:6102:418e:b0:5ff:ba2d:17c1 with SMTP id
 ada2fe7eead31-601deb8f595mr2321310137.9.1773294300559; Wed, 11 Mar 2026
 22:45:00 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Mar 2026 22:44:59 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Mar 2026 22:44:59 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <CAEvNRgFMNywpDRr+WeNsVj=MnsbhZp9H3j0QRDo_eOP+kGCNJw@mail.gmail.com>
References: <cover.1770071243.git.ackerleytng@google.com> <86ad28b767524e1e654b9c960e39ca8bfb24c114.1770071243.git.ackerleytng@google.com>
 <CAEvNRgFMNywpDRr+WeNsVj=MnsbhZp9H3j0QRDo_eOP+kGCNJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 11 Mar 2026 22:44:59 -0700
X-Gm-Features: AaiRm50qY80lG_kPAevYiMiI4iaIYG-rOHvoXqEdwljZn3zJnS7kUqoIvI7enLE
Message-ID: <CAEvNRgG-L+GBcm+u_thGvXAxV-Nqzu5VtgXy0PfND6SG0FiyVg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/37] KVM: guest_memfd: Add support for KVM_SET_MEMORY_ATTRIBUTES2
To: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	bp@alien8.de, brauner@kernel.org, chao.p.peng@intel.com, 
	chao.p.peng@linux.intel.com, chenhuacai@kernel.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, david@kernel.org, hpa@zytor.com, 
	ira.weiny@intel.com, jgg@nvidia.com, jmattson@google.com, jroedel@suse.de, 
	jthoughton@google.com, maobibo@loongson.cn, mathieu.desnoyers@efficios.com, 
	maz@kernel.org, mhiramat@kernel.org, michael.roth@amd.com, mingo@redhat.com, 
	mlevitsk@redhat.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	pbonzini@redhat.com, prsampat@amd.com, qperret@google.com, 
	ricarkol@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, seanjc@google.com, shivankg@amd.com, shuah@kernel.org, 
	steven.price@arm.com, tabba@google.com, tglx@linutronix.de, 
	vannapurve@google.com, vbabka@suse.cz, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com
Content-Type: text/plain; charset="UTF-8"

Ackerley Tng <ackerleytng@google.com> writes:

Here's iteration 2 of the attributes, after getting a much clearer idea
of the use cases across platforms at the last guest_memfd biweekly.

Please comment in this context! I'm planning for this text to make it to
Documentation/virt/kvm/api.rst.

> Ackerley Tng <ackerleytng@google.com> writes:
>
>>
>> [...snip...]
>>
>> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
>> index 23ec0b0c3e22..26e80745c8b4 100644
>> --- a/Documentation/virt/kvm/api.rst
>> +++ b/Documentation/virt/kvm/api.rst
>> @@ -117,7 +117,7 @@ description:
>>        x86 includes both i386 and x86_64.
>>
>>    Type:
>> -      system, vm, or vcpu.
>> +      system, vm, vcpu or guest_memfd.
>>
>>    Parameters:
>>        what parameters are accepted by the ioctl.
>> @@ -6523,11 +6523,22 @@ the capability to be present.
>>  ---------------------------------
>>
>>  :Capability: KVM_CAP_MEMORY_ATTRIBUTES2
>> -:Architectures: x86
>> -:Type: vm ioctl
>> +:Architectures: all
>> +:Type: vm, guest_memfd ioctl
>>  :Parameters: struct kvm_memory_attributes2 (in/out)
>>  :Returns: 0 on success, <0 on error
>>
>> +Errors:
>> +
>> +  ========== ===============================================================
>> +  EINVAL     The specified `offset` or `size` were invalid (e.g. not
>> +             page aligned, causes an overflow, or size is zero).
>> +  EFAULT     The parameter address was invalid.
>> +  EAGAIN     Some page within requested range had unexpected refcounts. The
>> +             offset of the page will be returned in `error_offset`.
>> +  ENOMEM     Ran out of memory trying to track private/shared state
      EOPNOTSUPP The specified content policy is not supported while
                 setting the requested attribute
>> +  ========== ===============================================================
>> +
>>  KVM_SET_MEMORY_ATTRIBUTES2 is an extension to
>>  KVM_SET_MEMORY_ATTRIBUTES that supports returning (writing) values to
>>  userspace.  The original (pre-extension) fields are shared with
>> @@ -6538,15 +6549,42 @@ Attribute values are shared with KVM_SET_MEMORY_ATTRIBUTES.
>>  ::
>>
>>    struct kvm_memory_attributes2 {
>> -	__u64 address;
>> +	/* in */
>> +	union {
>> +		__u64 address;
>> +		__u64 offset;
>> +	};
>>  	__u64 size;
>>  	__u64 attributes;
>>  	__u64 flags;
>> -	__u64 reserved[12];
>> +	/* out */
>> +	__u64 error_offset;
>> +	__u64 reserved[11];
>>    };
>>
>>    #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
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
>> +
>> +Userspace is expected to figure out how to remove all known refcounts
>> +on the shared pages, such as refcounts taken by get_user_pages(), and
>> +try the ioctl again. A possible source of these long term refcounts is
>> +if the guest_memfd memory was pinned in IOMMU page tables.
>> +

Memory *content* policies can be requested while setting memory
attributes. This defines:

  - What the host reads after a private to shared conversion
  - What the guest reads after a shared to private conversion (if
    applicable)

The policy definitions below provide more details:

``KVM_SET_MEMORY_ATTRIBUTES2_CONTENT_POLICY_ZERO`` (default)

  On a private to shared conversion, the host will read zeros from the
  converted memory on the next fault after successful return of the
  KVM_SET_MEMORY_ATTRIBUTES2 ioctl.

  This is not supported (-EOPNOTSUPP) for a shared to private
  conversion. While some CoCo implementations do zero memory contents
  such that the guest reads zeros after conversion, the guest is not
  expected to trust host-provided zeroing, hence as a UAPI policy, KVM
  does not make any such guarantees.

  For testing purposes, the KVM_X86_SW_PROTECTED_VM testing vehicle
  will support this policy and ensure zeroing for conversions in both
  directions.

``KVM_SET_MEMORY_ATTRIBUTES2_CONTENT_POLICY_PRESERVE``

  On private/shared conversions in both directions, memory contents
  will be preserved and readable. As a concrete example, if the host
  writes ``0xbeef`` to memory and converts the memory to shared, the
  guest will also read ``0xbeef``, after any necessary hardware or
  software provided decryption. After a reverse shared to private
  conversion, the host will also read ``0xbeef``.

  pKVM (ARM) is the first user of this policy. Since pKVM does not
  protect memory with encryption, a content policy to preserve memory
  will not will not involve any decryption. The guest will be able to
  read what the host wrote with full content preservation.

  For testing purposes, the KVM_X86_SW_PROTECTED_VM testing vehicle
  will support this policy and the contents of converted memory will
  be preserved.

``KVM_SET_MEMORY_ATTRIBUTES2_CONTENT_POLICY_NONE``

  This is an explicit request that KVM provide no guarantees on memory
  contents after conversion. Neither host nor guest should expect any
  guarantees about the memory contents after conversion.

  For testing purposes, the KVM_X86_SW_PROTECTED_VM testing vehicle will
  support this policy and every byte of converted memory will read
  ``0xab``.

>>  See also: :ref: `KVM_SET_MEMORY_ATTRIBUTES`.
>>
>
> [...snip...]
>
