Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2EA2BE03B
	for <linux-trace-kernel@vger.kernel.org>; Wed, 20 May 2026 13:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285263; cv=pass; b=VJe8zIu3AZHo1jjnud53BEZlZ9kTPOY2i5kjR/8QyipztYpjpvOep7uPsfbmpL86YsLnLkfeyhgx2BnPPsSChpV2b+05L+Tvgc3+zyQ1X0+S305+Ke2aima5lNpCg6P5uqmDKyYFlve8zFdON3CVO08kk6S4cjaTZBwUsQggQto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285263; c=relaxed/simple;
	bh=S2QQKlnUFtx99q7JAoA0OC+UdWmV5gUiJnNMdrUcP0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nVMxB+QL0Pkfy4aD+9v4CEOYv4bCYoWwg9NdE1W7jhRQc0p9e5WflOdt8ZwGewpT/LPteuPxOhY52BHsj3uTK8WiP6a6vQHKpHQKZ59Mj54cY1xuAU2eSjqqu+FKlG8wfDbhWKij0Q3rDmVzq9dls7Wb2BQ2U+kKV9+gBmRo0ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FlGpxnOy; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FlGpxnOy"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50e61648f10so17491cf.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 20 May 2026 06:54:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779285261; cv=none;
        d=google.com; s=arc-20240605;
        b=cpbfzdy9kQtRpAQkZz0fA7gVm3+DjRRbJvFexdIyPSJJMErl5ICNRmzUpNKjWJ8X6x
         VDifh1D2MWjI6xITRTKS+d9ARGTBwJ7U5SnsMNBKbpHXaveKrJNX2FK+JbpamGElZn/t
         KsTKrxk7o2jlobrzr+HqdwHcW/V3sHcaPjxVq4002Eoi0D3Tku8TZQBiUaV+NWRWEbFr
         V0wAbQ6gtFUew08QxLXAJOl6xjKZlAS3i+q+axeZ+vwBp+CgQXEmniGSC0CHKQrvNGkW
         i+SRi5hdbxLCd4bOrSV2ZTrwpMzye7M2ERr+ExL2oME8sNwRpEU1CxDpavGGIp8OkmJk
         vp2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gE3b6wCinhvGTxYfOlCOBpwr8sXmo/MKVQj4OkH8tQg=;
        fh=fY5NwWZOAKT8OdjosPHqrBhhivXXnN6wydIGTApTYO0=;
        b=gRLHhk6fhxQFjGRqGI8P0Ksq+hZZJxZSPheNVmtBw9QgtWAX6gkK3Ejd5ls5zwzs41
         1ZXvKLfTn/66S5N71P0GhJvb7llqeXIk8jvNi3e9UH/b62wVM+w2gV0jff1dwS//EDEL
         iT3t1bS1OXrukm2OBTS03sYw2IO7ESgevTskM0lwfo1uuRIuall97PRQabv76LRrlV7t
         GxJ+chAPZ71+/798CJJK4w21/BoTKgb2VHoPLw70P1OmH22SBUbvuQpJO0JeJcTZA0YS
         thsw8FeoIf+8C96qKaRsQF+gaWCY+VWb/XmvEGz/RYS180ADLzcM+FDVyHVmKFt2FxjA
         y4eA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779285261; x=1779890061; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gE3b6wCinhvGTxYfOlCOBpwr8sXmo/MKVQj4OkH8tQg=;
        b=FlGpxnOy1OupyW2Q1zIyup43N87OMJwKztCv6N+HDnob/jJvUJ8z8guWYdsvfgy5Vk
         bYZ8/IxQ03u0nq9UjDTFEIBxWJ0WluRCzbiidl+gTXI1ftCgVUJbKZ7IywxDxWZZdgCZ
         Eut7gVIanoDiulES82ZPcYhphjf4zLo4gZCmLH6DNtbYETq8gOoZpePWFOTSIVJ7z/I9
         jLZZHmnJbJTPJenYfMosc6xqdQYwIW1E+FWC3pTWPoQbcYcYeZzAem92yhNPYOXzfU/O
         MY+XtRStjWRikmNujbDSmdT22fpU0Ybesepsoknhbbd49idN4hoEqIbeVFjer9IUh7EA
         jRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779285261; x=1779890061;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gE3b6wCinhvGTxYfOlCOBpwr8sXmo/MKVQj4OkH8tQg=;
        b=ry75Vw7Hl3SUA99XOBw6SUIfWuGxQwIzY/3rsHsdTenOrTOAVxv+A4QzoIypIxiRjz
         P1/PVWcGiiZbzaWeYepvNPM1ymWFjmDfufH4lK6Vj4eCyHxFeo0x4t8IBEiU9btzVAkt
         65iLhu+PDNmgibm9NH6N5kaUHv5PG00GT0cde3hZcXfRvzcRyOF5RG9eCXerIMZnQdKf
         0WVEmyA8lIO7tFfbtLmLiSz/qRswmPBMQrPe94v4P1m/kks94CaDxp8AUqSeywX2ruqN
         WUQQfeFVRQE2B5x7ucnV3rDYH38LCEkHtOWs5wYGxWoqVoJQhleV0QvqtPC9AHwOL0Sj
         ae8A==
X-Forwarded-Encrypted: i=1; AFNElJ9fUq4+EIZe7ADFMxaYfFMrrUKUtbeKtJESl3ByTEwKfITox/WB6FA6aZFkNnvIFm3dm1Bfs9O9Y6waTj3/xd+YKW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpzqHivo15VIzBBYnhLdKvMIpfQHa9Ism7pEFzb9pq4PMkbmoo
	YT1rQS1rDR5r3YMJgmbtfe0oLWU1eJF8zFUPWqlypymR7H2vsJd7pzD2Liy/fNJD042oe7jl0Xi
	fzle4sYwcV1vogEVYCed7DBZGblwJ2qn+d19rh74x
X-Gm-Gg: Acq92OExq5MVMNtW9Fo3be9hD1zMAm3NsAAbnp0UGWRYUFScYexzWh+HLUYLIIiIQkd
	ctcN9ZQb6EW/oXSSk9MjcBc8qD5nZcEx4dn0he2Q3zLptRBXswzW+WCfDHHrtzubdIioUZvRM6b
	pOV1AJT9VSi7lOClNdJSeXuW0tFJ1JNn7OAZnSL/F4P+xLVbRQS3j+dWaVyRn2O73pvBYRJKIn1
	koam1z92JwV/0lXaCx9sPxYUOEoqkC7q/SQ8GwCbspQK94JR/Lr0pUd7B0oBlbb2MNeFNA2FphT
	lgxLCSy3PaSKj3imO062DDDxsoxrsg==
X-Received: by 2002:a05:622a:4248:b0:50e:38f0:ccb2 with SMTP id
 d75a77b69052e-5167b6af157mr20549601cf.15.1779285259966; Wed, 20 May 2026
 06:54:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com> <20260507-gmem-inplace-conversion-v6-9-91ab5a8b19a4@google.com>
In-Reply-To: <20260507-gmem-inplace-conversion-v6-9-91ab5a8b19a4@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 20 May 2026 14:53:43 +0100
X-Gm-Features: AVHnY4Im-a3duwAXpFrRqgO3e6bv1dT8inf454bQ9t5MibC6MZzfjT5fwn9v5O8
Message-ID: <CA+EHjTzd7HrkXyXdO65VDzUg3mehBoajRCS2XBU4ogK+JCuX_g@mail.gmail.com>
Subject: Re: [PATCH v6 09/43] KVM: Move kvm_supported_mem_attributes() to kvm_host.h
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
> From: Ackerley Tng <ackerleytng@google.com>
>
> Move kvm_supported_mem_attributes() from kvm_main.c to kvm_host.h and
> make it a static inline function. This allows the helper to be used in
> other parts of the KVM subsystem outside of kvm_main.c. This helper will be
> used later by guest_memfd.
>
> No functional change intended.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad
> ---
>  include/linux/kvm_host.h | 10 ++++++++++
>  virt/kvm/kvm_main.c      | 10 ----------
>  2 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 1deab76dc0a2c..f9ea95e33d050 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2529,6 +2529,16 @@ static inline bool kvm_memslot_is_gmem_only(const struct kvm_memory_slot *slot)
>  }
>
>  #ifdef CONFIG_KVM_MEMORY_ATTRIBUTES
> +static inline u64 kvm_supported_mem_attributes(struct kvm *kvm)
> +{
> +#ifdef kvm_arch_has_private_mem
> +       if (!kvm || kvm_arch_has_private_mem(kvm))
> +               return KVM_MEMORY_ATTRIBUTE_PRIVATE;
> +#endif
> +
> +       return 0;
> +}
> +
>  typedef unsigned long (kvm_get_memory_attributes_t)(struct kvm *kvm, gfn_t gfn);
>  DECLARE_STATIC_CALL(__kvm_get_memory_attributes, kvm_get_memory_attributes_t);
>
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 0a4024948711a..ff20e63143642 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2428,16 +2428,6 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
>  #endif /* CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT */
>
>  #ifdef CONFIG_KVM_MEMORY_ATTRIBUTES
> -static u64 kvm_supported_mem_attributes(struct kvm *kvm)
> -{
> -#ifdef kvm_arch_has_private_mem
> -       if (!kvm || kvm_arch_has_private_mem(kvm))
> -               return KVM_MEMORY_ATTRIBUTE_PRIVATE;
> -#endif
> -
> -       return 0;
> -}
> -
>  #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
>  static unsigned long kvm_get_vm_memory_attributes(struct kvm *kvm, gfn_t gfn)
>  {
>
> --
> 2.54.0.563.g4f69b47b94-goog
>
>
