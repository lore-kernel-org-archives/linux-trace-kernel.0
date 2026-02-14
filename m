Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F002FFDFC
	for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Feb 2026 20:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771099796; cv=pass; b=YzvBWDhn757itvsVkK/MT0X5p15pz2pY1ydn7so3QTcGFWEnjSaJrMgIo9Qe7bNAAvp8ClYkASG3C1y7udutAp5x8r9QZHDDnQgk/C3R7rIMSbnkjS1L9b15A0tVU3tl9cqBpeM63Qf889C+Z91pPr/xy0p2sXk+pnGiKNvXOPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771099796; c=relaxed/simple;
	bh=FufzZ4uU/iS1q/sxK46E3rWJ6kguU0PcbAexdJqkwRY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GwEi0Ma5YHbOCQKshrWXAXGqw3Hm0uf5ZTZoli0cR1HO68Ek/AWt0I0zjHn3RthANO4UUWSs/nSqCda1pKLjzpYXfgdPSbhezUE8PliEFLevdEWcQSBTIqNwUsWX/zEhGcbJPJbiqRuLa2MxX4z6Ksh3hQMMRi3ENj93uXlJzwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c69O+6Wi; arc=pass smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c69O+6Wi"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-948ccec7c89so562708241.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Feb 2026 12:09:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771099790; cv=none;
        d=google.com; s=arc-20240605;
        b=IexBNRp/3bpfAy79iplRS5TE9HDEoE912U0V+6FzCzOS8uXRDSr5xr+E7O11Uv32/Z
         TTQZh4y+WC5TlzPd5KfEYLbBdkTtkG7T/CEVHXJESg/c6Es2cko01XmC0h9M5w7WONej
         MogYUYE80m+N+4OMerIdDqy6rbtpqnD0XwT1C6L9BfsPnmLc/LM7CDJC6PEg0ilLdYP+
         ZyyZHns/HCHgpe7H1YvC2MVXcrz+F0BWv0n8XwZpq7Ne5XYB+aPJRCRQx4sfvSN940Ey
         chr4dS0nC2S+MAlc7z5WQXp5Mn5b/9i0rvow7SMrt8w3clvys+Y+2KZR2IA2RQGTVs7D
         G48Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=1jQpoSMsRYyXQLWbsh+LVZl2/hfELtMQa6Z0sSC+Mns=;
        fh=7C1BrgUAVt9TO+DFUsi1ZYmPFhZEdxAs/KSh4BvVxY0=;
        b=B5aGWDSa3s2fHs7naKlzaDh5tZAeAfkiT4Bcy0agpXH7ghSeBibJorRhiNjXE+qUB4
         9VsR59liBrsFbkrQjBgsfrWmzv2m/NhRrHcNMV1AUJLS8tpZEZeH7Gok1yd4QqD5dRfa
         lCFcrSEwFSC5mayQFf35M0Rt8nN0bVqV8u5DSQX9XoHvNteO4xmLqHnhD+ulCKHqzew5
         X4tsqKtbNN7dAB7PqJDhogCPETtGtDwX8eR2VJI+hTMmnT1zRokWd5joa3eTtgBdGGUp
         z6g635P3gSLYqxtpLM+wgQ2wjDk+/BOV+sQeSSGY3yc5Y3UPeeIKdEYotB7K33B8X+bt
         /JsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771099790; x=1771704590; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1jQpoSMsRYyXQLWbsh+LVZl2/hfELtMQa6Z0sSC+Mns=;
        b=c69O+6WiC3D+oJAldcWVy75tWL6Mk44q+MqO47KVEoV5FFmTtNXa4HHKYQqvin5C0B
         YITY0Zl4Bb5dk1Gb9Kg9IItF5V2q+I3ljh6fFxT5z0WH9zR+vRHKKN3qQ5bVMIuFHFGb
         0TsCMeSIZFZo4sHTNKuukgp1yl8svj9AJOZL1+oHO9iz/hXfeBpRR6ZU1tyinaySe8Rm
         BSBo+26xTip+Prhs0Pk3m0K42AXyNb2CR0yAYWZ9XPOFpad36EKw8re+wODVR2/MYgri
         /stt/vgWae1KJydSMTz0LmxIfYnsmdcbtBnCjaNIh5TGSM3apBbwoTtbMQByIKvO1/LO
         Iz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771099790; x=1771704590;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1jQpoSMsRYyXQLWbsh+LVZl2/hfELtMQa6Z0sSC+Mns=;
        b=R4FhQNAsKT4cFBiEmj6U0Un5qdJJIcpA1EVq3LKZEhLrcLa93jQJOtoize6iTEsa59
         LugIj18pvoPOMdZDKuQeeueuPtOvmetiafV6XQWbFD6+zgAgUH+fHJIsybh24OxH7YDR
         m/KdUyWK/e1S2F2tdV4KWYL4J5janNP2+2HwTYsr44ZcCrfV3djy3gFVdXqMcnhLVnc7
         p93mXuXQ4/+vzn5DsEabnkLFUlXKxC6ZO7Deh379p7Z4f6ZIgwL6I5sCCb1DxhBgy225
         nSYhQm+vn/DKk5f11eXbxKyuCNlGdkCeT/ekICfnmFRF0tXwVuSYWWpRgEJgZPwmhRiQ
         Zd7g==
X-Forwarded-Encrypted: i=1; AJvYcCUKchPBukqc8H8l/YOAsUlFBeUh1J/81OBmQy2fLOpwk8H4vnyqBLAywz+fh/WwQrErxnzEkPdy5p+vlv9F+Jzd0BM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZX6+1LQ6qSos8E+9Uj/7FqHcVcjICB8vctQSFsupfmDFEMH5K
	+LugyWWBg/eKh34h8WpPots+xWG1HxfjHo4kXo1xs5DKQMuGzjI+ugmPdxZns8h+UvNiXNs2Dz4
	QM97XuGcAotMsNqZBZLmAPeKOrQn6RwaHwqsHebkw
X-Gm-Gg: AZuq6aIuKaOhs0eBSxEF86LrBPAXE7DSqr3xeKDYurkBH0zaqFFt2GG+RZAL772xfk7
	NsSMSgS5gRq1YKwQ55JzFUMhH+ryqpO5uVnQInmUA+U8jMSxzhgUs3fUfFFWxHEoJPWJ5P/tIKo
	Ty9xHwj8BfdC5AM/ST7c9NmxJPE+7ZMdMcRvaPRDsUuyGL/FPk5Q0uZ+3HzSc6hOMm46ms7SmgH
	5reIIMetkksmAxC51lXCmbESEA3TjF1jFdRiWbbl/TDCr4QLAb7TIV61KbI1R++U+vag4FwdoCY
	S5+11pC58iYlEyWwZ0uBGUlBrb8Dy7pITqVQpOa3cA==
X-Received: by 2002:a05:6102:358d:b0:5f1:4fc3:855d with SMTP id
 ada2fe7eead31-5fe16f7123cmr2125991137.38.1771099789089; Sat, 14 Feb 2026
 12:09:49 -0800 (PST)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 14 Feb 2026 12:09:48 -0800
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 14 Feb 2026 12:09:48 -0800
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <86ad28b767524e1e654b9c960e39ca8bfb24c114.1770071243.git.ackerleytng@google.com>
References: <cover.1770071243.git.ackerleytng@google.com> <86ad28b767524e1e654b9c960e39ca8bfb24c114.1770071243.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 14 Feb 2026 12:09:48 -0800
X-Gm-Features: AaiRm50-4IHejrw9QDCNjWRongMJUvF1-Uwjne7RAjYwOg9FxNIKczofN5-jceI
Message-ID: <CAEvNRgFMNywpDRr+WeNsVj=MnsbhZp9H3j0QRDo_eOP+kGCNJw@mail.gmail.com>
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

>
> [...snip...]
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 23ec0b0c3e22..26e80745c8b4 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -117,7 +117,7 @@ description:
>        x86 includes both i386 and x86_64.
>
>    Type:
> -      system, vm, or vcpu.
> +      system, vm, vcpu or guest_memfd.
>
>    Parameters:
>        what parameters are accepted by the ioctl.
> @@ -6523,11 +6523,22 @@ the capability to be present.
>  ---------------------------------
>
>  :Capability: KVM_CAP_MEMORY_ATTRIBUTES2
> -:Architectures: x86
> -:Type: vm ioctl
> +:Architectures: all
> +:Type: vm, guest_memfd ioctl
>  :Parameters: struct kvm_memory_attributes2 (in/out)
>  :Returns: 0 on success, <0 on error
>
> +Errors:
> +
> +  ========== ===============================================================
> +  EINVAL     The specified `offset` or `size` were invalid (e.g. not
> +             page aligned, causes an overflow, or size is zero).
> +  EFAULT     The parameter address was invalid.
> +  EAGAIN     Some page within requested range had unexpected refcounts. The
> +             offset of the page will be returned in `error_offset`.
> +  ENOMEM     Ran out of memory trying to track private/shared state
> +  ========== ===============================================================
> +
>  KVM_SET_MEMORY_ATTRIBUTES2 is an extension to
>  KVM_SET_MEMORY_ATTRIBUTES that supports returning (writing) values to
>  userspace.  The original (pre-extension) fields are shared with
> @@ -6538,15 +6549,42 @@ Attribute values are shared with KVM_SET_MEMORY_ATTRIBUTES.
>  ::
>
>    struct kvm_memory_attributes2 {
> -	__u64 address;
> +	/* in */
> +	union {
> +		__u64 address;
> +		__u64 offset;
> +	};
>  	__u64 size;
>  	__u64 attributes;
>  	__u64 flags;
> -	__u64 reserved[12];
> +	/* out */
> +	__u64 error_offset;
> +	__u64 reserved[11];
>    };
>
>    #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
>
> +Set attributes for a range of offsets within a guest_memfd to
> +KVM_MEMORY_ATTRIBUTE_PRIVATE to limit the specified guest_memfd backed
> +memory range for guest_use. Even if KVM_CAP_GUEST_MEMFD_MMAP is
> +supported, after a successful call to set
> +KVM_MEMORY_ATTRIBUTE_PRIVATE, the requested range will not be mappable
> +into host userspace and will only be mappable by the guest.
> +
> +To allow the range to be mappable into host userspace again, call
> +KVM_SET_MEMORY_ATTRIBUTES2 on the guest_memfd again with
> +KVM_MEMORY_ATTRIBUTE_PRIVATE unset.
> +
> +If this ioctl returns -EAGAIN, the offset of the page with unexpected
> +refcounts will be returned in `error_offset`. This can occur if there
> +are transient refcounts on the pages, taken by other parts of the
> +kernel.
> +
> +Userspace is expected to figure out how to remove all known refcounts
> +on the shared pages, such as refcounts taken by get_user_pages(), and
> +try the ioctl again. A possible source of these long term refcounts is
> +if the guest_memfd memory was pinned in IOMMU page tables.
> +
>  See also: :ref: `KVM_SET_MEMORY_ATTRIBUTES`.
>

Transferring/re-summarizing an internal comment from Sean upstream here!
We can also follow up on this topic at the next guest_memfd biweekly.


Before this lands, Sean wants, at the very minimum, an in-principle
agreement on guest_memfd behavior with respect to whether or not memory
should be preserved on conversion.

Sean is against deferring whether to preserve memory to the underlying
hardware because that is letting (effectively) micro-architectural
behavior to define KVM's ABI. KVM's uAPI cannot let behavior be
undefined, or be based on vendor, and maybe even on firmware version.

Sean says that all decisions that affect guest data must be made by
userspace. The architecture can restrict what is possible, e.g. neither
SNP nor TDX currently support "generic" in-place conversion, but whether
or not data is to be preserved must be an explicit request from
userspace. If preserving data is impossible, then KVM needs to reject
the request.

(Vendor specific ioctls are out-of-scope, SNP and TDX cases were brought
up purely to highlight that there's nothing that fundamentally prevents
preserving data on conversion.)

I suggested a few uAPI options for configuring content preservation on
conversion:

1. guest_memfd creation time flag like
   GUEST_MEMFD_FLAG_PRESERVE_CONTENTS. This can be valid only if the
   kernel and vendor support content preservation

This was rejected because we should not assume all current and future
use cases will want the same content preservation config for a given
guest_memfd.

2. KConfig: automatically select to preserve contents if the
   architecture supports content preservation

This was rejected because it's not a decision explicitly made by
userspace.

3. KVM module param to configure content preservation.

This was rejected because the configuration may not generalize across
all VMs on the same host.

4. guest_memfd ioctl flag
   SET_MEMORY_ATTRIBUTES2_FLAG_PRESERVE_CONTENTS. -EINVAL if kernel and
   vendor don't support content preservation

Specifying a flag to choose whether content should be preserved at
conversion-time is the current best suggestion.

What does the rest of the community think of a conversion ioctl flag to
choose whether to preserve memory contents on conversion?

Fuad, I think you also made a related comment on an earlier internal
version we were working on. What do you/pKVM think?

>
> [...snip...]
>
