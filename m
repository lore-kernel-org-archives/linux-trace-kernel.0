Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3023DC862
	for <linux-trace-kernel@vger.kernel.org>; Wed, 20 May 2026 12:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779278941; cv=pass; b=pZm9nfPM7jk04nIUjK19V37p2h74h8o4I0LWkTZ6T0Q0R1Vo2ITGadnl90eEiCAjQfsv0Eg5JqjTGoabvGyGETYyEwbIZbirvAF4FkTt484hoXDRI8Ol2IXkX0N7ItZd7sYTa6VaUefjBVrRP0I/2hSObklJW+OUYRXykiBvJsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779278941; c=relaxed/simple;
	bh=UL5TH54YsejC0jorgc7QDDO4B8HZpwF6Hf/qda5tNFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tiUuF9VrPSbByAB9HOkeLwHbSP/4scy/3A7IpSfENWUygnAh7o4/ivduL0wDiOPwtVPCWCChu4U9fxxbSy8nUcTpqzy7qO/hqbOk9JXxI2HOVWYaM2IjcP3PMtK6vCDnbs8NI0tKCJs1UZFVYPvA4qwKow3ltxUBvXW8MAsvnt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vA79okPr; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vA79okPr"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-50e61648f10so531cf.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 20 May 2026 05:08:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779278939; cv=none;
        d=google.com; s=arc-20240605;
        b=IVyn90+4GFF7SldTqeh/X4UiHmPcjWTxeFoREJP6aJAgBksUet5NrwHIN1v77sIWUu
         4AqwDARcqPJ0u4NpiR2UkZevSrSdXl5lpzKxwIs99KWrVIu/LpbxRo5MG1bXJIU29tLX
         LEExXULTj+NKbKuF53X2qWhCEJ+bEwJoSXK+cNC2qYQy2+WBxTAXc6r2p68gb4gp00k1
         4DcU4XXKYntylkZWn+fP4F4o6/Gy6x78vVktpDHU0RhMCtdYKlORv40FjhCdMNuYq2vd
         kQ/3kkbKvigG3w/huyMsEV2jlrsl0pMf7+1Axu3sA6YZqi68fh9m6jnGMlKliy9G5leO
         s4Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+Px9FMSWQfRWBgPBzexC/j5D1iZQd5J23JXma/NqqOY=;
        fh=nnFSeB114Yt/xQ8xFG8EDI4mEbVjeh4k1ur5u6cBavw=;
        b=GGAR0uUaY5p3gxSFFdS8vi76pTd+FhTldbskGrv3iIkKeq7mL92COhqYqAI2E3464Z
         kl51hFG3j2QEBOQeS0hB2bj4ZaGZmRg8HmNohxaerc0AEB4nJNC03e5BeGPuxD2nJ++e
         iAxs+U1rnzFBwWm0fHKF/Dan5sJVYpaZ7Nf3kIYLNo50kqDFd/UAg4gSz5lLR0qGqvnz
         62hVBMgtdc1HpEpXLYmZMY/GrSa1TfI2SdpPHmDi3aEEGHqUJsM1+bRjwJdVpyG2h0JV
         aufxQ+ix8t+vhPywNG5beLuYHuUj+jX7bGmGCseQhyCvFIpgyApVtWMunbqDpv/7iRii
         l7gA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779278939; x=1779883739; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+Px9FMSWQfRWBgPBzexC/j5D1iZQd5J23JXma/NqqOY=;
        b=vA79okPrNl8/E58Oe6hC/PSwspCkodR6V4uLDnXuTL3mnZoq3pmr18UxTKlKQ0eF0l
         IOfCrnoq40V02E5ZNp+YB/CzGeDrIB4Uz6unz5fiOM5s2U0qHlU5TgPWy5MowFFrbNL2
         +iM0MFIOBnUyu2ci+T068ws8WkUGQf12du21hRH/KNK62CDlYF4J5Y3knhbN7bHiNtCA
         RFyq3AB+CKHw51QBseuCJj4rrLckY9nkZXOvQhh/CLjs2UJxlWKzAVPz0x/33Cqdk6AX
         bx+oRfwCxHpmDSXbC2LMr8W1T4id0XNp0Vjp6JrAjHMwWBervvGZhWxdQwjH6EynjVTY
         uqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779278939; x=1779883739;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Px9FMSWQfRWBgPBzexC/j5D1iZQd5J23JXma/NqqOY=;
        b=D140b2l09ncqtc/QMzdYCkW1oTgmUBH8cphTdQ+kcmbJFQbkCN7zvVVkDGutt3j/w8
         FavgmkfDBfo8PytOLi+M4tiTm2jXJuxF35pqjIZdGfBY4zzRcx2u61rlX3QVk1dC6rX9
         g5NUj3v+ucVZyg+hC3F/fG9JoxahJRgWZt4Swdtz/jiSpQQf5ojP98HpEAM3QITdKswf
         OYWoEO2FoMPdNOn5UutC3xB6iqoE7IeNSZ84VhNXJPmaQfkJ6QBCb+HsE6w6unOHWwvc
         avXkb0l0J0rxsRfuZs2/Lhyu3ajoLHro3Fpy6JQM7eqWhkM9R3rAwRWCfwYVKg6flR/u
         o7kQ==
X-Forwarded-Encrypted: i=1; AFNElJ+0LQOVKrxYg68kpU7aXNhQZYYoQFdxmJPYopWm7py1oRzkSlh/hNtLr1e7tpF1QjGAABHd+k3yqVBdjbb0KIvLAKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjAIMHG4VJXT81Y6hOfsi2LkpGFZFjyWY+cUwFM9qT5NGJ+s40
	K8sl6RmMkbm9ZX5Ywa+D0JAOrgkKps3EZ7Djqh0iiju4xuwGxRZDLB7bnIGoquNIbSddj2gffRp
	bLCkq37ONbHJSvXFoI/IiVM841UrhwC7RtA4UBndT
X-Gm-Gg: Acq92OEdHpYGkru/it9IaddAcs6n8VA04cTneq3iq3HgiCD5IP9xn15tc56Wm35yt3f
	I/UEDjoB8Mc5xBNDHhYpdzsm5kf+IqozgXdEA1kwoDfrqIAZ0g75Xpwncm2w5XrA4/b7dQWRVoo
	jl/FPfyvsvvo9fp0xBfuVEXwxxaG/4PaVta4Rrq+HWO8lVSulv5v/2xfBTApMHJ9lrd6GgzdrQD
	LdGK3Op/aZilH95YG3PH4M+twysBjb0Ak66b/UPAB9Cda8KO6JRu9d27VMi7C127Ve2opej6Ctk
	NeFXZruud6dd2O00sWw=
X-Received: by 2002:ac8:7d11:0:b0:4ff:cb75:2a22 with SMTP id
 d75a77b69052e-5167b58811dmr18170691cf.3.1779278937787; Wed, 20 May 2026
 05:08:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com> <20260507-gmem-inplace-conversion-v6-3-91ab5a8b19a4@google.com>
In-Reply-To: <20260507-gmem-inplace-conversion-v6-3-91ab5a8b19a4@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 20 May 2026 13:08:19 +0100
X-Gm-Features: AVHnY4LfQbiWdiGwXSEhGQDtGx7oiVEOShaBU1_EGdecpQaasdwwwCwSujlZjbQ
Message-ID: <CA+EHjTzvkF93kznZ6e5SBu-w9Gc_Z4ryDwg7qnjzWSPt4KfNCQ@mail.gmail.com>
Subject: Re: [PATCH v6 03/43] KVM: Enumerate support for PRIVATE memory iff
 kvm_arch_has_private_mem is defined
To: ackerleytng@google.com
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

On Thu, 7 May 2026 at 21:22, Ackerley Tng via B4 Relay
<devnull+ackerleytng.google.com@kernel.org> wrote:
>
> From: Sean Christopherson <seanjc@google.com>
>
> Explicitly guard reporting support for KVM_MEMORY_ATTRIBUTE_PRIVATE based
> on kvm_arch_has_private_mem being #defined in anticipation of decoupling
> kvm_supported_mem_attributes() from CONFIG_KVM_VM_MEMORY_ATTRIBUTES.
> guest_memfd support for memory attributes will be unconditional to avoid
> yet more macros (all architectures that support guest_memfd are expected to
> use per-gmem attributes at some point), at which point enumerating support
> KVM_MEMORY_ATTRIBUTE_PRIVATE based solely on memory attributes being
> supported _somewhere_ would result in KVM over-reporting support on arm64.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  include/linux/kvm_host.h | 2 +-
>  virt/kvm/kvm_main.c      | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 7b9faa3545300..7d079f9701346 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -722,7 +722,7 @@ static inline int kvm_arch_vcpu_memslots_id(struct kvm_vcpu *vcpu)
>  }
>  #endif
>
> -#ifndef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
> +#ifndef kvm_arch_has_private_mem
>  static inline bool kvm_arch_has_private_mem(struct kvm *kvm)
>  {
>         return false;
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 306153abbafa5..abb9cfa3eb04d 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2421,8 +2421,10 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
>  #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
>  static u64 kvm_supported_mem_attributes(struct kvm *kvm)
>  {
> +#ifdef kvm_arch_has_private_mem
>         if (!kvm || kvm_arch_has_private_mem(kvm))
>                 return KVM_MEMORY_ATTRIBUTE_PRIVATE;
> +#endif
>
>         return 0;
>  }
>
> --
> 2.54.0.563.g4f69b47b94-goog
>
>
