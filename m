Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF1535E95A
	for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Jun 2026 08:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781856679; cv=pass; b=Lh8pivCy6igd8oOJMiNUS2bFXnVarFpx0jbL2S3A67nBs9ioNLTWT62HFztOAJEitSCSNxfOmHziJ3rfHFESqifqtx3OIjr+NzSkjHE8QEBvN+xGMbRll3uZ8dMGllRdKtt5UYIvqYmxRPc2XYI3AOlIlyLCTiGF2p2Br59Y5IE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781856679; c=relaxed/simple;
	bh=pR0Zn2zvw6IcMAbbufKDgeBYie2BeloIDPjTlVVsmpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dIK3qytOVcF2ghc4BbskLACjNRzq4oFKLsyemi5rv3E6vy+o3/VPTLSvARiyfja8LN9IJ3fkkT4cQgPOefeFp0zqyrl4KJ6FSaoeAwObTWOGJ4MGwZG5Q2q7Bu7IhTGAFRe3BArSV0xkaQOVPWel2dEOLTAKfgJ3O+e5vAU4qac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=loj6O+Nd; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="loj6O+Nd"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5177d1ff061so112951cf.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 19 Jun 2026 01:11:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781856677; cv=none;
        d=google.com; s=arc-20260327;
        b=fXie2N81ysVoyvHEZ7q2G1HDs2JZm3J2kQ2ZTbEt5RF4DrUfbERzCXHdQUGXlZvavA
         6qHEXdHhAksofZOriNMMuq7H2ksqQMfh8Kd6K39XGK+/trlZXyvo5B2fQxtt2G1nODJ2
         d16i/Ia5UXRH5E5KCdW9svWsb8xVr2BaxKpOZpKMOApPYUjkxD4uc38qRvhqShBB/e/M
         3MvZ8h9S5eeGd0DeLbJnACSJ19ahZzr9l3yJbRzhroxpsmnHryIbxUPIKkaV4ObXl/Ug
         5rUl/EBbYTQ2GOUkkQRiedJZv+RY3WyNxlyvCqmrl5wLa4ktTWTrRHw7b/F3RZ7jCEqV
         0Fpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iM+8nrvlghRqxLR5gEfhNSNnyjY3ZW8GVmgYtfXOYBs=;
        fh=SbuVRRwMFxkncpO1sKNDfRalQLft9dr7YPAsZpB4w6o=;
        b=iSV4dLPWj0Dsi6yu55bvN7v4dWEs+4l8Hq2yLEHZTGzLtr18z3zuyQfGNqR5zZJrqi
         7JDEoaSN/9NcfGtr6C3FezLQIOccGwH7YuPZJd0Tz5jXIEqU2rrRS+M9JEdJrRp2QOiu
         zkJ6aHalWgRebCZ4vU6wAQJ0G0pyhr46Md8unqAQ5RMQg9ovnPHjq8DEBqxQiY1S9/NR
         TmpnNaTDP5dByX6AG9Sl/k7+LJDgZgdcZjDtf5K/eBftqv6yPaknoF1JOTYV1V8FZZL4
         5X2zJyaD09P5QEbjIJ/xdyF9PSXTy3KjPxrs/D+xXZRlJ1CYHWSniRsB4juMyOPLrVN+
         K57A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781856677; x=1782461477; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iM+8nrvlghRqxLR5gEfhNSNnyjY3ZW8GVmgYtfXOYBs=;
        b=loj6O+NddywcN7wL1xrCwqxjT4ZN9Ac53eU9ll7nxx7Xviu1AaXETFnmHI/NWxcXPr
         2tJOyD13+0Tc2mMvt/0jxvDCuCjQofn+Eu1lFwOxzQPdnek4cWrSyMzp69H5jZFbIiFw
         m2pL4MTAUSKIkrjvSWB4RIgyxLuYxhB4w0JU4cYiC64ASHdlO/8i+aQuJJ/04hbsN+UP
         CIkZGrA68OtXu619RPX4SuoMTzikB/Xhko55vP/fH4az0XznVHWuLwRXzWnVI33Ch5FK
         QkyQ18CymOUUlU5PsHCF5MaeIZWokQZr5ZD+UljGKqNfiM3VTMDvcyk35TUGjxVIQpru
         2+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781856677; x=1782461477;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iM+8nrvlghRqxLR5gEfhNSNnyjY3ZW8GVmgYtfXOYBs=;
        b=NI0S+hGyXyJ8ACoM068SSY/QwlPjhEuruwetzQvJV6AIVfT5nJjSMIPhu6xfzqf6Sk
         gU7y6/CeTELVurXiWpE+Q1Id9zHYfhYiQgPxQ+hSS8hKIWQXyO39cYYNpIX7EfQO96Lj
         M/rrE7781fCkCgTSB9AAXgDoaPR7V6rAN+Ugs6S5wXLJk7YFYcZPk1eynOfWxwvDmF+7
         9nGlyq0xxptLmbi1FKRlK2otUgkqVhLjSpC+Oo0pA7Aww9abmUnQ9fQqArsGw+ixurLv
         xtdbcn7+tTmwi4ooSnUvVsdvafYcMnbyw+4myxLrm/PVFn213HT1F7qIuoBHajjPh+Iw
         aoVw==
X-Forwarded-Encrypted: i=1; AFNElJ+izdrYJAKQXxDMU1iHPT38Wx/6A+NxFiGTwRKV4BbJIgE2utLjdVOYmywlgBNAcCiBOpXA1V1iF1VunhjIgWLYvf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBMMLiTupiLt6MrjW23q4vM9dIkrYQXY9dtOvXDi9/0McGWQyU
	zsHh9HAMn9btyayVS8W59yu7M3fizrjK1pwEMVbXqZ21ekIHb3gOlFN8jnkVQaHmM3oJ3y5cHrL
	KuPpfPViDUdO1j1qJbUUfSLVDnlcFQHfflDPaXuEe
X-Gm-Gg: AfdE7cl2dUjSDAZpMsXSBxDfkJhoitaebLCrrXnMbnOHSehQoJeDRvJ9BA68Dcatljf
	QkW001ohNZPwH2a1eBED47nOHnDxyZ8OIA+xK4gGbxi5p5HgqFKsvUVFXluKhu8k7w+leIYZIDi
	81a9s42YaOktqhQW+4Mlw4DDn6ONE45TJiOeRE8gwPqwCoWB32ZZKZkDIh0w+etp3IqBUa4Pjk3
	WmgpUXVVF2sPiGr6Qoxk7wNxFx0FERzPcrBiWJsggIqIFpi+1Sqb+7FlHgQcoPrZ5Xvi45abw==
X-Received: by 2002:a05:622a:191d:b0:517:38aa:c2b3 with SMTP id
 d75a77b69052e-519e48d02b3mr6024501cf.14.1781856676299; Fri, 19 Jun 2026
 01:11:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com> <20260618-gmem-inplace-conversion-v8-4-9d2959357853@google.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-4-9d2959357853@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Fri, 19 Jun 2026 09:10:39 +0100
X-Gm-Features: AVVi8CdHX5FmAYr_l4a3mgee9sp6dg3wXgxt_dR1E7cWLhRy0b4A0kukfNDJw2g
Message-ID: <CA+EHjTxT9tcPk4HtyPXs1eo0bUQvwf3=G7P8ZTfJhDpXNm=ntg@mail.gmail.com>
Subject: Re: [PATCH v8 04/46] KVM: Decouple kvm_has_arch_private_mem from CONFIG_KVM_VM_MEMORY_ATTRIBUTES
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
> When memory attributes become trackable in guest_memfd, the concept of
> having private memory is no longer dependent on
> CONFIG_KVM_VM_MEMORY_ATTRIBUTES.
>
> With this, on x86, kvm_arch_has_private_mem() is defined if some CoCo
> platform support (or the testing CONFIG_KVM_SW_PROTECTED_VM) is compiled
> in.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Co-developed-by: Ackerley Tng <ackerleytng@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad
> ---
>  arch/x86/include/asm/kvm_host.h | 4 +++-
>  include/linux/kvm_host.h        | 2 +-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 8e8eb8a5e8a6b..1bde67cf6eb0e 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -2394,7 +2394,9 @@ void kvm_configure_mmu(bool enable_tdp, int tdp_forced_root_level,
>                        int tdp_max_root_level, int tdp_huge_page_level);
>
>
> -#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
> +#if defined(CONFIG_KVM_SW_PROTECTED_VM) ||     \
> +       defined(CONFIG_KVM_INTEL_TDX) ||        \
> +       defined(CONFIG_KVM_AMD_SEV)
>  #define kvm_arch_has_private_mem(kvm) ((kvm)->arch.has_private_mem)
>  #endif
>
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 201d0f2143976..d370e834d619e 100644
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
>
> --
> 2.55.0.rc0.738.g0c8ab3ebcc-goog
>
>
