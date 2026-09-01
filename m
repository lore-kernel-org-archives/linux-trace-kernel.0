Received: from mta1.migadu.com (out-64.mta1.migadu.com [95.215.58.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0211738DC66
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Sep 2026 08:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788250818; cv=none; b=sZMcfRcnZEkqcxrNXsJwOEYsSv7gXvXpLS4lqGI5pw0mxBkVmN/iVGocQgx6CLme5SQKirRhvUbM5hyMEj3jHkdh/EFbnIoqGqQEtvFCcaQl/BfnEvlZK/bY6QOvgvBDl9FgbvqSipx1jnG0561k/sxlJtSRtbcqRGbwyfDH49Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788250818; c=relaxed/simple;
	bh=dPSr56z5rAs+SkiIx0/dU1tmsjqb2fO0/em7DI52Cpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=miYpqLJx+PFvd+m2QNoyhFZH9aC4V6ETyo+qoFHlp+a3pqOHWB29ke4xY9A6mg218QAo2JeI8WWf5UB1mkrvLo9myTnxTzfwwXUaej1vWj04TT0VwVUsNb0saOd0uJNQF1pC2KTdJzl9zmCMc1FMPd+bNBD1YRyQmQJiwjTyJjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=paj0EtmS; arc=none smtp.client-ip=95.215.58.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="paj0EtmS"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=dPSr56z5rAs+SkiIx0/dU1tmsjqb2fO0/em7DI52Cpg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788250813; v=1; x=1788855613;
 b=paj0EtmSVacoEcS3+vfFsYSNX6rTYWIsaTQ3sx1pn5M/sp742MNB0h3wvf3fezicxxvwBTeZ
 MhzerZxd0BeLvg4WClysGROX+wCwsuaYR0o+wXWciRa5TPQcUwy1GcJSIGg37mVxZ3ka0S5ZRg8
 zq1e73xthzGtIB0k4pXJg29w=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 82605469617adbc9;
	Tue, 01 Sep 2026 08:20:13 +0000
X-Mizu-Trace-ID: 82605469617adbc9
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b2a8173142so3503e87.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 01 Sep 2026 01:20:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwl8vRvxc9G9mwRLX3wutQV5QPKNhL/6hwCYwLYn+7l+eOwSE8I2UY2BAZD0ChTyR6ob/In5cJth/DkOeAahtiThoc=@vger.kernel.org
X-Gm-Message-State: AFuF++kIG5DyEwqIOdn/XnbcWCiZRvSMIhjOSrXfkL2YJVSGrwcsNlJ6
	jtyJTcyiblHVqOQLg17N8jlvIffQR1mIJnrH0mfP2PuMm2oBDG1vRyghI/m1FQz+7K3xiaUz1cV
	/uCB1+K/laOlQJe5hurvpctBxy8mhPHpPmmRq9em4
X-Received: by 2002:a05:6512:3416:b0:5b1:5141:9156 with SMTP id
 2adb3069b0e04-5b600a4e6c1mr82007e87.9.1788250812101; Tue, 01 Sep 2026
 01:20:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830-gmem-inplace-conversion-v12-0-85e5fd25252a@google.com> <20260830-gmem-inplace-conversion-v12-23-85e5fd25252a@google.com>
In-Reply-To: <20260830-gmem-inplace-conversion-v12-23-85e5fd25252a@google.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 1 Sep 2026 09:19:35 +0100
X-Gmail-Original-Message-ID: <CA+EHjTzALzghuG5J-LFuG5pXJ4WgEfrMHgwkMHnq1U-D6yS7Pg@mail.gmail.com>
X-Gm-Features: AcwNN1VEd61L_O2SZt1wLXP8U1ZnnNtTHeRYFc82-Kw9mTwcloJaTFPGEc_5sR8
Message-ID: <CA+EHjTzALzghuG5J-LFuG5pXJ4WgEfrMHgwkMHnq1U-D6yS7Pg@mail.gmail.com>
Subject: Re: [PATCH v12 23/45] KVM: Let userspace disable per-VM mem
 attributes, enable per-gmem attributes
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
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Randy Dunlap <rdunlap@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev, 
	Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"

Hi Sean, Ackerley,

On Mon, 31 Aug 2026 at 01:25, Ackerley Tng via B4 Relay
<devnull+ackerleytng.google.com@kernel.org> wrote:
...
> +       kvm.gmem_in_place_conversion=
> +                       [KVM] Controls whether KVM enables in-place conversion
> +                       support for guest_memfd and tracks the private/shared
> +                       state of memory per guest_memfd instead of per VM.
> +
> +                       If enabled, KVM enables the KVM_SET_MEMORY_ATTRIBUTES2
> +                       ioctl on guest_memfd file descriptors and disables the
> +                       legacy VM-scoped KVM_SET_MEMORY_ATTRIBUTES ioctl for
> +                       private memory state tracking. Only the
> +                       KVM_MEMORY_ATTRIBUTE_PRIVATE attribute moves to
> +                       per-guest_memfd tracking; other attributes remain
> +                       per-VM.
> +
> +                       This parameter toggles KVM's in-place conversion
> +                       capability support. Whether a VMM uses separate backends
> +                       or out-of-place memory management is determined by
> +                       userspace VMM design.
> +
> +                       Note, this parameter is only available when
> +                       CONFIG_KVM_VM_MEMORY_ATTRIBUTES=y. When
> +                       CONFIG_KVM_VM_MEMORY_ATTRIBUTES is not set, in-place
> +                       conversion is unconditionally enabled.
> +
> +                       Default is Y (on).

The parameter is only settable when CONFIG_KVM_VM_MEMORY_ATTRIBUTES=y, and
in that config gmem_in_place_conversion initialises to
!IS_ENABLED(CONFIG_KVM_VM_MEMORY_ATTRIBUTES), i.e. N, not Y. Is the doc line
wrong, or is N-by-default not what was intended here?

Cheers,
/fuad

> +
>         kvm.nx_huge_pages=
>                         [KVM] Controls the software workaround for the
>                         X86_BUG_ITLB_MULTIHIT bug.
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 83e26ce45fb79..e840418427a1d 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1851,7 +1851,9 @@ enum kvm_intr_type {
>         ((vcpu) && (vcpu)->arch.handling_intr_from_guest && \
>          (!!in_nmi() == ((vcpu)->arch.handling_intr_from_guest == KVM_HANDLING_NMI)))
>
> -#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
> +#if defined(CONFIG_KVM_SW_PROTECTED_VM) ||     \
> +    defined(CONFIG_KVM_INTEL_TDX) ||           \
> +    defined(CONFIG_KVM_AMD_SEV)
>  #define kvm_arch_has_private_mem(kvm) ((kvm)->arch.has_private_mem)
>  #endif
>  #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index abb108886733a..2c3c22aeafa54 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -81,13 +81,21 @@ config KVM_WERROR
>           If in doubt, say "N".
>
>  config KVM_VM_MEMORY_ATTRIBUTES
> -       bool
> +       bool "Enable per-VM PRIVATE vs. SHARED attributes (for CoCo VMs)"
> +       depends on KVM_SW_PROTECTED_VM || KVM_INTEL_TDX || KVM_AMD_SEV
> +       help
> +         Enable support for tracking PRIVATE vs. SHARED memory using per-VM
> +         memory attributes.  Using per-VM attributes is deprecated in favor of
> +         tracking PRIVATE state in guest_memfd.  Select this if you need to run
> +         CoCo VMs using a VMM that doesn't support guest_memfd memory
> +         attributes.
> +
> +         If unsure, say N.
>
>  config KVM_SW_PROTECTED_VM
>         bool "Enable support for KVM software-protected VMs"
>         depends on EXPERT
>         depends on KVM_X86 && X86_64
> -       select KVM_VM_MEMORY_ATTRIBUTES
>         help
>           Enable support for KVM software-protected VMs.  Currently, software-
>           protected VMs are purely a development and testing vehicle for
> @@ -138,7 +146,6 @@ config KVM_INTEL_TDX
>         bool "Intel Trust Domain Extensions (TDX) support"
>         default y
>         depends on INTEL_TDX_HOST
> -       select KVM_VM_MEMORY_ATTRIBUTES
>         select HAVE_KVM_ARCH_GMEM_POPULATE
>         help
>           Provides support for launching Intel Trust Domain Extensions (TDX)
> @@ -162,7 +169,6 @@ config KVM_AMD_SEV
>         depends on KVM_AMD && X86_64
>         depends on CRYPTO_DEV_SP_PSP && !(KVM_AMD=y && CRYPTO_DEV_CCP_DD=m)
>         select ARCH_HAS_CC_PLATFORM
> -       select KVM_VM_MEMORY_ATTRIBUTES
>         select HAVE_KVM_ARCH_GMEM_CONVERT
>         select HAVE_KVM_ARCH_GMEM_RECLAIM
>         select HAVE_KVM_ARCH_GMEM_INVALIDATE
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 05c518c9b8078..929fd3e1a01e6 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -103,7 +103,10 @@ static bool __ro_after_init allow_unsafe_mappings;
>  module_param(allow_unsafe_mappings, bool, 0444);
>
>  #ifdef kvm_arch_has_private_mem
> -bool __ro_after_init gmem_in_place_conversion = false;
> +bool __ro_after_init gmem_in_place_conversion = !IS_ENABLED(CONFIG_KVM_VM_MEMORY_ATTRIBUTES);
> +#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
> +module_param(gmem_in_place_conversion, bool, 0444);
> +#endif
>  EXPORT_SYMBOL_FOR_KVM_INTERNAL(gmem_in_place_conversion);
>  #endif
>
>
> --
> 2.55.0.897.gb25b4bd76c-goog
>
>
