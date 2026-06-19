Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805B82E0413
	for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Jun 2026 11:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781867010; cv=pass; b=HyRtoGA2N0uwN+vcyEyQ8scEtMIJMFMaj8R01njlaANGwZUeqyzEO/Boh1fZw9y+K34WNwW20nh22b3eZJbp5mpKkXdr+Scyo6WkIkHowhgYf3OYlXob2Sp0pxfrMvm1Y5dWVdZHWJA8DYWxlTzBIE6q2NhPm0GfF1ElMs8qi0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781867010; c=relaxed/simple;
	bh=GsiXIcEdAu1JNPx0o0Rkb8mPpCDUCHPoupmGVgfFazA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mst4fNQ3sNnDrNy4gpAI543d8VBhqDWoPCkYpr4tPojsb3Xk8/I/0dyL8qUEO9W8NkAnSS6OILftr+BxIihblzT4BcI+wBplmIyRP5j1UraUCuZAE8ujyQh/C6qo0u3qZVJ0/ckF1h47hjXnortrFPuLQMbNFKPw5hTpOsReat4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bbcADlBT; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bbcADlBT"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-519ed52bcc6so136661cf.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Jun 2026 04:03:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781867006; cv=none;
        d=google.com; s=arc-20260327;
        b=k2RS1Xk+VNbKtAEHGrJQ4rFqcaxlBAjaU/diZgiYhxjMTxoV7B+dg4kUfmADRkT1r5
         wCa3hDuMUw0ecyJhIoxuD/SZiSyN6XrOmZgWlB3CfjtfMDaKbFvyYnEwLAiLV/rMu1su
         Ov4Qb4tTPAZHtpktPf+4W9wpTioLGd/XZIuft+erFlPRzT67hJCb/IiRylk/Em1IZ51k
         WGkXil9BA8lDrfWx1vzKkiXFAVgHHrjSoPOMSnwrgnmmddz2GWUuvFQ4l6eL9LXhrT6L
         WUj6rLYKdz9G2fJaFCQUDhMMQB52Fy4n2eTG2Gen54w2PKGbTi9dfWHqV7XIvFRbCxJg
         H2+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tjw3cW/Oozrva+KBRQ9a1eMgdLYrVdyOI99ohvpEcUU=;
        fh=jVEd0E25NYxIPBpdy0EU8aRlqD55N59taX1rVmV+Pjg=;
        b=Eo4PjihzNM9MTKzEcBRGrwv3yiOnZQAP0r+BjC+qghLN1/o4uK4XpS1oLXBYMqMzh1
         CZ8bRH2zU66pl6lHOyb7zsa3T4uasH1pcqzYioJfK0esifJDchlJUuoBbsmvaXRy/zWh
         0inXG7O4KhKaDGKECcALnJwmc01gSs7sYjtJ2L4Ek/YY/Gupthw2A1SKXjAqwQzE6HUO
         eRBOBp9jEy/Wj1b2JKYOzp4k+Sj3kpe5DwWH2gdns0rMmCyPimi25qxQkl47Oudmllj0
         +l9q2g4dy7y2gPGdFUgZvBCyDYNrAbNoJ6aheg21U0t9XFvQnrJluuKIQguWe484FPDO
         4DPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781867006; x=1782471806; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tjw3cW/Oozrva+KBRQ9a1eMgdLYrVdyOI99ohvpEcUU=;
        b=bbcADlBT8HbCLpMyMG3EPLwa3qTHe3eGPyIP2OI/A91UMFYoORXh/tpHAi7X8NSPDG
         1kUSIlZt6BWlvj52JyUoPE5hWasC7NKFkEsSQ0zAQxyvdOSpVW/T9hp2/bKg/I/m036v
         8k/FTTc24b5mC/Wy/SGzNiZUA1pm+0qncVvvI3GyBB9Or5pUGPslfJCOrCxbkLpuDX1z
         iudVNAW/M9tbgf1Roi70sGQW6/1bKZ1SEuHX9zl8rOg1gnAB9kPVgYUpQRXULbgRJaCD
         354fbnoesOQTMqVG0pBEdnTJgKCYMdZmpTEl/iwyaixm8tLgehHqCuWfY07hoPgS32CV
         +r7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781867006; x=1782471806;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tjw3cW/Oozrva+KBRQ9a1eMgdLYrVdyOI99ohvpEcUU=;
        b=l4duRIrwx66sVa7esqIMC1yil7q8gmMeFFt8XXlNflNYyonhyHSu607hpFum41URit
         JhSI08zS3QKr5OuZL2iZ6NYq3o3iZD/P11/PpX0gy4gYUV76x08g0Pc39atNsL2RVjkT
         C0Z/IMd/qPAGxvWQxlif0z/jOsD0AyIpGlPf6a3cXeoySBgH2JxUHnUMI9XzFqdv86p5
         rgTcEmvuRAaPSh5irua1XAPzFvkj4RkKKY4LbNjoHoitjQhwqbDdCy/tH9O1hwsQIkXc
         qeSzH3YS7s4QpVnms8/6cxpcoMGVtXnUA+XRcRd0L6/U4IuVIVmN0WShLH3cdcKPcxnl
         ZYcg==
X-Forwarded-Encrypted: i=1; AFNElJ/NpdaXkw/WdH6yQqkPuKMQKjMaEX0/W/VTcRzJyr1q5425zFSlPXAve4+AGM7Lq2x9dyp/3ktvkb2NI/qYYemoBZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB/YS0vmQGTwDQK3PCPdtX2Nh2n//yDnf6KjcnXygdIY1BpCyb
	GVZfGqIF2Zhtz6rhdZdd4blDZsCkEreQ9tjAYo8tnGZu2bEFpnE1DsCsesHNIhEmUtH52RAbfVf
	bLyfnlJUb+iViPnSf7fzy5yjqkTcQw3eBZcdd6JLB
X-Gm-Gg: AfdE7ckRUIHKm39zzqq4FNjvgotweZzN/5GzXjN8UOMDRlRUK/H/3ChIIGsUVJ4a0QU
	Lm6mp6Eyd7TmEqU1xSQ3+EsOpaFH2jJklWjiQK+yK0XsM+kFAy4+R3GFM6DVNgyPMRUuFNUx84+
	qmn1t7WJXMUwCjo14/uTxZiUD7yTz0aGp9hsJ3oY1TaOGdSbMSD+F3Dy28u8OLwfzQXq4qwp+y/
	K56PGDipnNg+69RYZUvWJZbIiFApeIPbRRTqu2jQytyfoRefdl9/V5VNNrbxoFsJglvY1ZdNA==
X-Received: by 2002:a05:622a:5a12:b0:50f:af60:3496 with SMTP id
 d75a77b69052e-519e878bcd3mr6572861cf.1.1781867005698; Fri, 19 Jun 2026
 04:03:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com> <20260618-gmem-inplace-conversion-v8-11-9d2959357853@google.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-11-9d2959357853@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 19 Jun 2026 12:02:47 +0100
X-Gm-Features: AVVi8CdeH8_e_cqUhrAt8PYHFeMtnUwZS7qxotCUws3_NP2cjS-AO0E0Squx-po
Message-ID: <CA+EHjTxd4_x-J8DurWuhPostfZqsxMUV87tWN5GzLCknH5wfQw@mail.gmail.com>
Subject: Re: [PATCH v8 11/46] KVM: Consolidate private memory and guest_memfd
 ifdeffery in kvm_host.h
To: ackerleytng@google.com
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
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

On Fri, 19 Jun 2026 at 01:31, Ackerley Tng via B4 Relay
<devnull+ackerleytng.google.com@kernel.org> wrote:
>
> From: Sean Christopherson <seanjc@google.com>
>
> Move the kvm_arch_has_private_mem() stub and a few guest_memfd function
> definitions/declarations "down" in kvm_host.h to utilize existing #ifdefs,
> and so that related code is clustered together.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

SoB fix please. With that...

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad
> ---
>  include/linux/kvm_host.h | 37 ++++++++++++++++---------------------
>  1 file changed, 16 insertions(+), 21 deletions(-)
>
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index acb552745b428..9c1cf1a6559e3 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -722,27 +722,6 @@ static inline int kvm_arch_vcpu_memslots_id(struct kvm_vcpu *vcpu)
>  }
>  #endif
>
> -#ifndef kvm_arch_has_private_mem
> -static inline bool kvm_arch_has_private_mem(struct kvm *kvm)
> -{
> -       return false;
> -}
> -#endif
> -
> -#ifdef CONFIG_KVM_GUEST_MEMFD
> -bool kvm_arch_supports_gmem_init_shared(struct kvm *kvm);
> -
> -static inline u64 kvm_gmem_get_supported_flags(struct kvm *kvm)
> -{
> -       u64 flags = GUEST_MEMFD_FLAG_MMAP;
> -
> -       if (!kvm || kvm_arch_supports_gmem_init_shared(kvm))
> -               flags |= GUEST_MEMFD_FLAG_INIT_SHARED;
> -
> -       return flags;
> -}
> -#endif
> -
>  #ifndef kvm_arch_has_readonly_mem
>  static inline bool kvm_arch_has_readonly_mem(struct kvm *kvm)
>  {
> @@ -2572,6 +2551,11 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
>  #else
>  #define gmem_in_place_conversion false
>
> +static inline bool kvm_arch_has_private_mem(struct kvm *kvm)
> +{
> +       return false;
> +}
> +
>  static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
>  {
>         return false;
> @@ -2580,6 +2564,17 @@ static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
>
>  #ifdef CONFIG_KVM_GUEST_MEMFD
>  bool kvm_gmem_is_private(struct kvm *kvm, gfn_t gfn);
> +bool kvm_arch_supports_gmem_init_shared(struct kvm *kvm);
> +
> +static inline u64 kvm_gmem_get_supported_flags(struct kvm *kvm)
> +{
> +       u64 flags = GUEST_MEMFD_FLAG_MMAP;
> +
> +       if (!kvm || kvm_arch_supports_gmem_init_shared(kvm))
> +               flags |= GUEST_MEMFD_FLAG_INIT_SHARED;
> +
> +       return flags;
> +}
>
>  int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
>                      gfn_t gfn, kvm_pfn_t *pfn, struct page **page,
>
> --
> 2.55.0.rc0.738.g0c8ab3ebcc-goog
>
>
