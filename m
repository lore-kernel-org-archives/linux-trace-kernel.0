Received: from mta1.migadu.com (out-233.mta1.migadu.com [95.215.58.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFAA471CFB
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Sep 2026 08:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252172; cv=none; b=TvFctDZAiBoYJGuOJqsPaUE/jEHSwqcUMHYdCaWKeJfl3jD/0/ipEpBumvLaRWEUnGmTngEoztPdNWE/mPOmmTP9xUhHa3LfKHfPuAwx76Q9C7D4utnIsR16TWl7unDM7w0wEIUFsOx1e3OmeSElZwmwk1Q+NhljE7gD+dFRi00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252172; c=relaxed/simple;
	bh=NDRSGPV+38awmoPvP+Bzb90MiKF5Z4x3dNbI2Yyn7Pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=efWf7yiuMtRF+j5UQPdocOTSTm0uNBgJqOVTw+z3bvYa8IyJzFa9PIIp7m4mjxPFVP/bK/BeZHjwQvS8iBLtaFuPipQo9q+PFNwJX7PfzzRHgrL31ntOIUR2/Gr3+eLkYWgyQ6fv0lw9lmQQV73q07BYic1GJOJgwP7ZY57M2/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eAuZu+o4; arc=none smtp.client-ip=95.215.58.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eAuZu+o4"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NDRSGPV+38awmoPvP+Bzb90MiKF5Z4x3dNbI2Yyn7Pg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788252168; v=1; x=1788856968;
 b=eAuZu+o4XqExpzd4ECSzHJZgZWO58SYk8MHuFjyQZuhv1Q/rVIu1IX3lvbJ3JE2vKdudfEOf
 G5xPd0sVAtlxcohyvBRcaFoBusgSrT/fDmR6wHLM1neklZNiQ4va/6jDiuSXKpKS11YlVHcqxBA
 3z/r/zsW1NT277wIs9HNQNXE=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7432b5fee35ba848;
	Tue, 01 Sep 2026 08:42:48 +0000
X-Mizu-Trace-ID: 7432b5fee35ba848
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b2a8173142so3674e87.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 01 Sep 2026 01:42:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzZv5LHHsf2W4gHjHfqO2AT8fUvVdNLba+lCQqg8GQw2RfRBrfAVJ+RKUfe1kK9uP/zkxuNvKMkqV1rYubGH+vlKC4=@vger.kernel.org
X-Gm-Message-State: AFuF++khUHkCwQzlv3Oma8luuvyLpaaukzBSEaXlTG8CL37r7h3K6k3l
	HQTJOWuggN+NeP6FVKHG4pNDAj01AKDDf9m+dIDiIuzq5GnQ4XJaaejnOVc/IcLbakZSzPNPvES
	2MZX3nBd+nMYMVcjapcv6FDePqhv+8LL9Mk6WPH5+
X-Received: by 2002:a05:6512:ac6:b0:5b5:e890:1953 with SMTP id
 2adb3069b0e04-5b5ff29f4efmr129910e87.12.1788252166683; Tue, 01 Sep 2026
 01:42:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830-gmem-inplace-conversion-v12-0-85e5fd25252a@google.com> <20260830-gmem-inplace-conversion-v12-7-85e5fd25252a@google.com>
In-Reply-To: <20260830-gmem-inplace-conversion-v12-7-85e5fd25252a@google.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 1 Sep 2026 09:42:10 +0100
X-Gmail-Original-Message-ID: <CA+EHjTyRqnXDwFTcA7k2e-CXe1zdZ674F0mXSDFsn4PuwK+0zw@mail.gmail.com>
X-Gm-Features: AcwNN1WsZWoWKD6AG_hFPG5SzyReAqSBKWje84PPAdwPIk5UDZum7IDo5_qmIa4
Message-ID: <CA+EHjTyRqnXDwFTcA7k2e-CXe1zdZ674F0mXSDFsn4PuwK+0zw@mail.gmail.com>
Subject: Re: [PATCH v12 07/45] KVM: Rename kvm_mem_is_private() to kvm_is_private_gfn()
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
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 31 Aug 2026 at 01:25, Ackerley Tng via B4 Relay
<devnull+ackerleytng.google.com@kernel.org> wrote:
>
> From: Ackerley Tng <ackerleytng@google.com>
>
> Rename kvm_mem_is_private() to kvm_is_private_gfn() to prepare for in-place
> conversion, where there will be two lookup functions,
> kvm_vm_is_private_gfn() and kvm_gmem_is_private_gfn().
>
> This renaming allows consistent prefixing of "vm" vs "gmem" for
> kvm_*_is_private_gfn(), as opposed to kvm_gmem_mem_is_private(), which
> looks like a typo.
>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad

> ---
>  arch/x86/kvm/mmu/mmu.c   | 12 ++++++------
>  arch/x86/kvm/svm/sev.c   |  2 +-
>  include/linux/kvm_host.h |  4 ++--
>  virt/kvm/guest_memfd.c   |  2 +-
>  4 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 10e59507d252f..62f751952ad8a 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3421,7 +3421,7 @@ int kvm_mmu_max_mapping_level(struct kvm *kvm, struct kvm_page_fault *fault,
>                 is_private = fault->is_private;
>         } else {
>                 max_level = PG_LEVEL_NUM;
> -               is_private = kvm_mem_is_private(kvm, gfn);
> +               is_private = kvm_is_private_gfn(kvm, gfn);
>         }
>
>         max_level = min(max_level, max_huge_page_level);
> @@ -3634,13 +3634,13 @@ static bool page_fault_can_be_fast(struct kvm *kvm, struct kvm_page_fault *fault
>          * guest spinning on a #PF indefinitely, so don't attempt the fast path
>          * in this case.
>          *
> -        * Note that the kvm_mem_is_private() check might race with an
> +        * Note that the kvm_is_private_gfn() check might race with an
>          * attribute update, but this will either result in the guest spinning
>          * on RET_PF_SPURIOUS until the update completes, or an actual spurious
>          * case might go down the slow path. Either case will resolve itself.
>          */
>         if (kvm->arch.has_private_mem &&
> -           fault->is_private != kvm_mem_is_private(kvm, fault->gfn))
> +           fault->is_private != kvm_is_private_gfn(kvm, fault->gfn))
>                 return false;
>
>         /*
> @@ -4708,7 +4708,7 @@ static int kvm_mmu_faultin_pfn(struct kvm_vcpu *vcpu,
>          * Now that we have a snapshot of mmu_invalidate_seq we can check for a
>          * private vs. shared mismatch.
>          */
> -       if (fault->is_private != kvm_mem_is_private(kvm, fault->gfn)) {
> +       if (fault->is_private != kvm_is_private_gfn(kvm, fault->gfn)) {
>                 kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
>                 return -EFAULT;
>         }
> @@ -5111,7 +5111,7 @@ long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
>
>         direct_bits = 0;
>         if (kvm_arch_has_private_mem(vcpu->kvm) &&
> -           kvm_mem_is_private(vcpu->kvm, gpa_to_gfn(range->gpa)))
> +           kvm_is_private_gfn(vcpu->kvm, gpa_to_gfn(range->gpa)))
>                 error_code |= PFERR_PRIVATE_ACCESS;
>         else
>                 direct_bits = gfn_to_gpa(kvm_gfn_direct_bits(vcpu->kvm));
> @@ -6584,7 +6584,7 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
>         if (IS_ENABLED(CONFIG_KVM_SW_PROTECTED_VM) &&
>             !(error_code & PFERR_RSVD_MASK) &&
>             vcpu->kvm->arch.vm_type == KVM_X86_SW_PROTECTED_VM &&
> -           kvm_mem_is_private(vcpu->kvm, gpa_to_gfn(cr2_or_gpa)))
> +           kvm_is_private_gfn(vcpu->kvm, gpa_to_gfn(cr2_or_gpa)))
>                 error_code |= PFERR_PRIVATE_ACCESS;
>
>         r = RET_PF_INVALID;
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 0a887f8e05d3a..dff684b88f153 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -5030,7 +5030,7 @@ void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code)
>          * userspace via KVM_EXIT_MEMORY_FAULT events, however, so RMP faults
>          * for shared pages should not end up here.
>          */
> -       if (!kvm_mem_is_private(kvm, gfn)) {
> +       if (!kvm_is_private_gfn(kvm, gfn)) {
>                 pr_warn_ratelimited("SEV: Unexpected RMP fault for non-private GPA 0x%llx\n",
>                                     gpa);
>                 return;
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 6ca81f5349db8..9b97266f61ec8 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2573,12 +2573,12 @@ bool kvm_arch_pre_set_vm_memory_attributes(struct kvm *kvm,
>  bool kvm_arch_post_set_vm_memory_attributes(struct kvm *kvm,
>                                             struct kvm_gfn_range *range);
>
> -static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
> +static inline bool kvm_is_private_gfn(struct kvm *kvm, gfn_t gfn)
>  {
>         return kvm_get_vm_memory_attributes(kvm, gfn) & KVM_MEMORY_ATTRIBUTE_PRIVATE;
>  }
>  #else
> -static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
> +static inline bool kvm_is_private_gfn(struct kvm *kvm, gfn_t gfn)
>  {
>         return false;
>  }
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index e32ac2c28cbef..ce5efcacda36e 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -879,7 +879,7 @@ static long __kvm_gmem_populate(struct kvm *kvm, struct kvm_memory_slot *slot,
>
>         folio_unlock(folio);
>
> -       if (!kvm_mem_is_private(kvm, gfn)) {
> +       if (!kvm_is_private_gfn(kvm, gfn)) {
>                 ret = -EINVAL;
>                 goto out_put_folio;
>         }
>
> --
> 2.55.0.897.gb25b4bd76c-goog
>
>
