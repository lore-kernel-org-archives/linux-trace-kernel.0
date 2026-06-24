Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEAD3E5A17
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 21:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782335441; cv=pass; b=OcHxyUf7+MAX2Qy74BW/QgnwBPSerqFzsTs6rKr6hhBJ6hn34d+oomN+TL1R2fx6hC8MP87IRPazcqxMyncn5TdrYVyDwYSvxQnxlrj+nDxhHkP45b+QpneM442RPKJFGWTISCJCD0OWta34t3JUjjKy3K18wKwFnj/VT3meuNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782335441; c=relaxed/simple;
	bh=/fqLeUK+2mBqGvKbYmtjhS3yw4ZIMajZ90sW7dKC8MY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tni02o0dlRVz5pfN84G5nI580kMb1cvQ8lzXFsOHdU+DGF9KcxTwA/ChtOFXfGNxhNPdcgoQCmn3gOxMS+w0quHRe9OLYMgbStvNjKIZw5RSUyqPug47UezVOYrWgouQMdABB5xRGv0qtVAr3GO61/EAjmo3d4R1yiTEQK8yn/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gZrCJnRz; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gZrCJnRz"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-13809223fd4so1814836c88.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Jun 2026 14:10:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782335438; cv=none;
        d=google.com; s=arc-20240605;
        b=DTrgkeC2zRkf2NyQ+NbjcfkqD1w2ED9sEZrElxZ+Rqb88z+IzN7cHzsojS+/AW058V
         yUe1Cf0xklfvxBNU0kn/j1B0gA7bHeGoTpUPY7LZWZGoGplGlE1D64d1piiPZaIZdQ+y
         uANaiagJjWEhuexk+9Kj0TH8ywKl44fxxJWry1PaQpOXtzbDaEWwCjvm9LoiJVetB1VW
         hlfHbhf9IzdRtgMJhXL32m4U7hmupWeLhbc28Hy27SIGcX8xANgjHayV/wyOVIVsO1e4
         pBmWO6SogiVADiPChE/HT5VkdvtLAJi6WwMDomeyLc/855fyJK7RllSjmiTjnyC2ezH6
         Zsmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=1qhY5YTt9otpZBdjhswjpjNDeK/pN32eIQWKDjhQOPw=;
        fh=Buy1zEOiOTq5/GFN9/dOJ306DqwnBQtxmfnnDTr97Gk=;
        b=A1jXOZv8AfiahJcb1IUpW9dHLqNr6ZBsBbm2tT2SqHD+AZqWGUDiLGC5TeiHfwA+zj
         UZZKzzXCKVlhTWSt1gKNnP2aPakjiwOAC7t3fXC94YdznSbjWUAglW1B5XUTjzZAFP/V
         mqusW2cLBdPp6po9ONE2Ipe2hEMaPtwtZFJwtdv+7wGRAw9+uqOVE4sk0YwwaGEC+IJM
         eSHa9QFeRfRHi3aXXqJzjXg6bDsfInglOfmf8WeqVEJ+Txx0L2BIlbcI2KLB+ZHnHBnG
         ZrhaL54HYdHrbpeFfzPKBQqfIHi71owitzcFGp9lScB6SpZvjM9zAl3WmJ6TS2o2gsOM
         AoIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782335438; x=1782940238; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1qhY5YTt9otpZBdjhswjpjNDeK/pN32eIQWKDjhQOPw=;
        b=gZrCJnRziYALESi+EyO4zrNEGpp7soNo5xePz6vITzszfo4F6y/KtcKGvcLpyKvZrd
         qtd0Q6THio+xAZ13GySQ7XR9xNuTXLNjTYxZHjxUD+jFV5qLjPimK8JsV5XtWPp+IAAE
         nueZGNVCzR76HQiXS9fWPEkZW+FEfophypqL9S0rY23Umgws0WYROaJTvJcYM9FMRvD0
         6v/Ue4mud2QRGPZtmqhpg5QOTD+bcStGRE/IYgeZ0R/CwpVQGH9tnaAkT8bojKXGfjeH
         y9dVcengerUfzgIllLUNo7WRQx57pHQqltKIqtj6TIwC4MFBTmGuK/vib7CEbCBHOYOf
         ZITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782335438; x=1782940238;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1qhY5YTt9otpZBdjhswjpjNDeK/pN32eIQWKDjhQOPw=;
        b=MdrjIrrPJJnsOsU8ejkbiYMGNL56vUGFwV2XdgWKL8Zu+fm+b0+Nz2pKgYa946K+KA
         YAGlUil+M66MCmC7QV4PcVawixmn/JZD22G9hOz4dcTa745Khp/0xGLU0c4PRlJKG2jz
         WwB+relZAPH0U/CqF1s2LINhr3TGyePJ/InEfF3hn/TQHdPiF26wHYrV3P7uEh360GDC
         hZo7U399A4oLLY4ReOljH3eFuaQF8s6mgm9DyuGnEQNn21Ms0Xr9moCQZq2T9+E840Pr
         zgdgY4FJe00OMf1pkEYeRN48Y5S3Rm/Dz2VXW3x9mljFYxuGAu10oR+OaP5Vz/jBHo2U
         iaGQ==
X-Forwarded-Encrypted: i=1; AFNElJ+bxa1qwy5tVw6RdSXdD2cI3yoR9aekOnF4dOPgfrqPucbhT/uOjnoCYPuE9DXkJORsgGK8EsgYhXDHoWNFFCjnPek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwry24i6UcroQvn6mMCLwetLnQQeWMZ2uy/96V3kMVR+L48Ple
	C9rsR8JrMEYot7bQyA8owUyJ41Y/NDcNqNkgL9y2kae72btN0xMV4wde+GAxpf8HHlMNzt/c/kF
	PZE4HJw1Xu7Z3hKM6HZZ+bfaMGDzNlW+kWmCRCayX
X-Gm-Gg: AfdE7cnsd0J+alGZtHDgjKOFrw2HcxFrIX84GP5oUZ4fWR6K2tOYCw6WEabpd0AiM5N
	I21MfCuX9zl2AE4uZf5rAI/euFamk8BnUXpMcHrvazbxTTrhdkxZZSGizrNmdrUmHEhOJTyO4v3
	I3gvX0GmfAz1oDem0c6yFbtuI4xPsjkVtGYq9dn4J114AbCPfNn4kuAQ2EUoIDUgeDYdPIRcq2d
	WhfOn/h9uIC+DBNc2hbZY42Q4XAUNR7yA64xPVNaB9gWGtHyU3gtseVedDAYB0s37NR/Y4eH8xk
	fwj+5RERXA+1Hw9dLNmwwE7jy73dtb1xqgnrprCfmaYdBYfvoLmWeT7usiM=
X-Received: by 2002:a05:7022:ec4:b0:138:4e1:4701 with SMTP id
 a92af1059eb24-139d0bfe4c6mr3377918c88.7.1782335437124; Wed, 24 Jun 2026
 14:10:37 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 14:10:36 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Jun 2026 14:10:36 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <ede86ac4-d560-49a6-82d6-b33ac5fc9355@linux.intel.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-13-9d2959357853@google.com> <ede86ac4-d560-49a6-82d6-b33ac5fc9355@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 24 Jun 2026 14:10:36 -0700
X-Gm-Features: AVVi8CebnA3rqvCzlkQD0wA3EY7nvdb5mQUucCUu-AjWUK6m396TQ3uUDm-u_rc
Message-ID: <CAEvNRgGWwfWZbvXxBAKHxc3DYVGzDo8TYtii+8fVnJNtBwvCqg@mail.gmail.com>
Subject: Re: [PATCH v8 13/46] KVM: guest_memfd: Add base support for KVM_SET_MEMORY_ATTRIBUTES2
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: aik@amd.com, andrew.jones@linux.dev, brauner@kernel.org, 
	chao.p.peng@linux.intel.com, david@kernel.org, jmattson@google.com, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, liam@infradead.org, 
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

Binbin Wu <binbin.wu@linux.intel.com> writes:

> On 6/19/2026 8:31 AM, Ackerley Tng via B4 Relay wrote:
>> From: Ackerley Tng <ackerleytng@google.com>
>>
>> Introduce base support for KVM_SET_MEMORY_ATTRIBUTES2 in guest_memfd, which
>> just updates attributes tracked by guest_memfd.
>>
>> Validate input fields in general. Guard usage of KVM_SET_MEMORY_ATTRIBUTES2
>> by making sure requested attributes are supported for this instance of kvm.
>>
>> A new KVM_SET_MEMORY_ATTRIBUTES2 is defined to support writes (unlike
>> KVM_SET_MEMORY_ATTRIBUTES) in addition to reads so it can provide error
>> details to userspace. This will be used in a later patch.
>>
>> The two ioctls use their corresponding structs with no overlap, but
>> backward compatibility is baked in for future support of
>> KVM_SET_MEMORY_ATTRIBUTES2 and struct kvm_memory_attributes2 in the VM
>> ioctl.
>>
>> The process of setting memory attributes is set up such that the later half
>> will not fail due to allocation. Any necessary checks are performed before
>> the point of no return.
>>
>> Co-developed-by: Vishal Annapurve <vannapurve@google.com>
>> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
>> Co-developed-by: Sean Christoperson <seanjc@google.com>
>> Signed-off-by: Sean Christoperson <seanjc@google.com>
>
> s/Christoperson /Christopherson
>

Thanks!

>> Reviewed-by: Fuad Tabba <tabba@google.com>
>> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
>> ---
>>  include/uapi/linux/kvm.h |  13 ++++++
>>  virt/kvm/Kconfig         |   1 +
>>  virt/kvm/guest_memfd.c   | 116 +++++++++++++++++++++++++++++++++++++++++++++++
>>  virt/kvm/kvm_main.c      |  12 +++++
>>  4 files changed, 142 insertions(+)
>>
>>
>
> [...]
>
>> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
>> index 297e4399fbd49..cfa2c78ba5fb9 100644
>> --- a/virt/kvm/Kconfig
>> +++ b/virt/kvm/Kconfig
>> @@ -102,6 +102,7 @@ config KVM_MMU_LOCKLESS_AGING
>>
>>  config KVM_GUEST_MEMFD
>>         select XARRAY_MULTI
>> +       select KVM_MEMORY_ATTRIBUTES
>
> What's this?
> This config is gone.
>

I'm surprised this compiles... I'll fix it, thanks!

>>         bool
>>
