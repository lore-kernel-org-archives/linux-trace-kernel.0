Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5F43E0090
	for <linux-trace-kernel@vger.kernel.org>; Mon,  3 Aug 2026 11:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785755266; cv=none; b=u9EatxyBfHQsSjVf3hn8REgUNAf90avr93XSqNPBwl6vulifDJXg8k7FT1UjJUvPab0MvGqJ0V+bRNtepZi2LIsfJUC2+YxbBGgR7F3KGakw1vQiCAXFSW06a9pzsr7FhK2j4vgfypc1S9gLAKpOdJkdG1uEb6+etE3DTxkg4xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785755266; c=relaxed/simple;
	bh=nzWVdbPhUHM1JYQ4vY19x0fcKaxPbwe0rwW22tG+pSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b2BSrRGUFIXPcvT/zeu61u1t90Ilg+3Y1FNUrFP7Txpb2+TQuDVO8GJWt+sk5EWtCHGv5FhY+SNCfLZpeuD4Oquzki/m6+1mx/fyVEnyCo7C4a0J1qwsIpsqQDkzRz59i3TACiwtd0hYDGku4OzbU74yDPKUShPj6yg8gVX4N5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q1FLAPRO; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q1FLAPRO"
X-Forwarded-Encrypted: i=1; AHgh+RptB1IYJmWv3XO0XzCLDWIfX8WcCibsfVXys8MtQdBpG3SO8CtB7UALN/B1JR0TJxYS7cKrC8xj/9udc+sVaXN2wqo=@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785755262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mzCaMTHAovu9nR3xKFYbhkLWMIFRJplDFgT55oFjVS8=;
	b=q1FLAPROn/qtFxTM92zy0rkpDphzUH62d1tBuRr/NX8SWt5OEjSq5SGNKQMqmzaiX5eENK
	gjCJcqLoStNBvm4x322UjCZ6MuPuyDbTSof0ULX/pjQU1206782ecebBydyYBsz2//uuoT
	iGZdjKaTd/Ydey37bR6l3ykNGzSnSMY=
X-Gm-Message-State: AOJu0YyS4Sg/dUkacd/HtB92ZXDo2jRtw6UttDjwHNq9rdBWxgrMFKFD
	kZXLV8Nr2XZ9niHr6eoBzqOfScTsLAjYkkG8V9q8JYJjm4miQ+I7kGBPq/tsnHAUD+bcoIbo1+z
	GHEhTjUevOf/jmVA6FMYUyVHFTYzjr6pVLgA+yTCR
X-Received: by 2002:a05:622a:9013:b0:517:6010:7c71 with SMTP id
 d75a77b69052e-52b598d1fbdmr37634331cf.4.1785755255277; Mon, 03 Aug 2026
 04:07:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720161343.1367007-1-fuad.tabba@linux.dev>
 <20260720162412.1401272-1-fuad.tabba@linux.dev> <20260720162412.1401272-2-fuad.tabba@linux.dev>
 <anByfvv9scyNuHrJ@google.com>
In-Reply-To: <anByfvv9scyNuHrJ@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Mon, 3 Aug 2026 12:06:57 +0100
X-Gmail-Original-Message-ID: <CA+EHjTytZhrp09XHFR3pqQ+oiheH1EYQMShMoMWN7g9Pt+ipcg@mail.gmail.com>
X-Gm-Features: AUfX_mwJ02RD_SjB0kuiiRDkFsHZ0ozXxl-aPjsP5iGHJw9s2-dKTUc8wqqTKmE
Message-ID: <CA+EHjTytZhrp09XHFR3pqQ+oiheH1EYQMShMoMWN7g9Pt+ipcg@mail.gmail.com>
Subject: Re: [PATCH v1 11/11] KVM: arm64: Tag host-VA hypercall parameters __hostva
To: Vincent Donnefort <vdonnefort@google.com>
Cc: maz@kernel.org, oupton@kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, catalin.marinas@arm.com, will@kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, alexandru.elisei@arm.com, 
	joey.gouly@arm.com, seiden@linux.ibm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, qperret@google.com, ardb@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

On Mon, 3 Aug 2026 at 11:50, Vincent Donnefort <vdonnefort@google.com> wrote:
...
> > diff --git a/arch/arm64/include/asm/kvm_hcall.h b/arch/arm64/include/asm/kvm_hcall.h
> > index 6aa2df90a14a4..3033a6ba1462a 100644
> > --- a/arch/arm64/include/asm/kvm_hcall.h
> > +++ b/arch/arm64/include/asm/kvm_hcall.h
> > @@ -27,6 +27,18 @@ struct kvm_vcpu;
> >  struct vgic_v3_cpu_if;
> >  struct vgic_v5_cpu_if;
> >
> > +/*
> > + * A host VA carried by a hypercall argument. At EL2 such a pointer must not
> > + * be dereferenced until it is translated with kern_hyp_va_host(); sparse
> > + * flags any use that skips the translation. The tag describes the EL2 view
> > + * only: the host dereferences its own VAs freely.
> > + */
> > +#if defined(__KVM_NVHE_HYPERVISOR__) && defined(__CHECKER__)
> > +#define __hostva     __attribute__((noderef, address_space(__hostva)))
> > +#else
> > +#define __hostva
> > +#endif
>
> Could we have __kern, just like we have __user.
>
> Ideally this could be used later to mark the values we don't trust, so not only
> VAs but also nr_pages. In mem_protect.c e.g.
>
> size_t pfn_range_is_valid(u64 __kern pfn, u64 __kern nr_pages)
>
> so that size is only trusted once pfn_range_is_valid() has run.
>
> And beside, that matches "kern_hyp_va"

Makes sense, I'll do it in the respin.

Thanks for the reviews!
/fuad

>
> > +
> >  /*
> >   * Hypercall signatures are declared as (type, name) argument pairs.
> >   * __KVM_HCALL_MAP() applies a macro to each pair, in the mold of __MAP()
> > @@ -157,24 +169,24 @@ DECLARE_KVM_HOST_HCALL0(int, __pkvm_prot_finalize)
> >
> >  /* Hypercalls that are always available and common to [nh]VHE/pKVM. */
> >  DECLARE_KVM_HOST_HCALL_VOID(__kvm_adjust_pc, 1,
> > -     struct kvm_vcpu *, vcpu)
> > +     struct kvm_vcpu __hostva *, vcpu)
> >  DECLARE_KVM_HOST_HCALL(int, __kvm_vcpu_run, 1,
> > -     struct kvm_vcpu *, vcpu)
> > +     struct kvm_vcpu __hostva *, vcpu)
> >  DECLARE_KVM_HOST_HCALL0_VOID(__kvm_flush_vm_context)
> >  DECLARE_KVM_HOST_HCALL_VOID(__kvm_tlb_flush_vmid_ipa, 3,
> > -     struct kvm_s2_mmu *, mmu, phys_addr_t, ipa, int, level)
> > +     struct kvm_s2_mmu __hostva *, mmu, phys_addr_t, ipa, int, level)
> >  DECLARE_KVM_HOST_HCALL_VOID(__kvm_tlb_flush_vmid_ipa_nsh, 3,
> > -     struct kvm_s2_mmu *, mmu, phys_addr_t, ipa, int, level)
> > +     struct kvm_s2_mmu __hostva *, mmu, phys_addr_t, ipa, int, level)
> >  DECLARE_KVM_HOST_HCALL_VOID(__kvm_tlb_flush_vmid, 1,
> > -     struct kvm_s2_mmu *, mmu)
> > +     struct kvm_s2_mmu __hostva *, mmu)
> >  DECLARE_KVM_HOST_HCALL_VOID(__kvm_tlb_flush_vmid_range, 3,
> > -     struct kvm_s2_mmu *, mmu, phys_addr_t, start, unsigned long, pages)
> > +     struct kvm_s2_mmu __hostva *, mmu, phys_addr_t, start, unsigned long, pages)
> >  DECLARE_KVM_HOST_HCALL_VOID(__kvm_flush_cpu_context, 1,
> > -     struct kvm_s2_mmu *, mmu)
> > +     struct kvm_s2_mmu __hostva *, mmu)
> >  DECLARE_KVM_HOST_HCALL_VOID(__kvm_timer_set_cntvoff, 1,
> >       u64, cntvoff)
> >  DECLARE_KVM_HOST_HCALL(int, __tracing_load, 2,
> > -     void *, desc_hva, size_t, desc_size)
> > +     void __hostva *, desc_hva, size_t, desc_size)
> >  DECLARE_KVM_HOST_HCALL0_VOID(__tracing_unload)
> >  DECLARE_KVM_HOST_HCALL(int, __tracing_enable, 1,
> >       bool, enable)
> > @@ -189,13 +201,13 @@ DECLARE_KVM_HOST_HCALL(int, __tracing_enable_event, 2,
> >  DECLARE_KVM_HOST_HCALL_VOID(__tracing_write_event, 1,
> >       u64, id)
> >  DECLARE_KVM_HOST_HCALL_VOID(__vgic_v3_save_aprs, 1,
> > -     struct vgic_v3_cpu_if *, cpu_if)
> > +     struct vgic_v3_cpu_if __hostva *, cpu_if)
> >  DECLARE_KVM_HOST_HCALL_VOID(__vgic_v3_restore_vmcr_aprs, 1,
> > -     struct vgic_v3_cpu_if *, cpu_if)
> > +     struct vgic_v3_cpu_if __hostva *, cpu_if)
> >  DECLARE_KVM_HOST_HCALL_VOID(__vgic_v5_save_apr, 1,
> > -     struct vgic_v5_cpu_if *, cpu_if)
> > +     struct vgic_v5_cpu_if __hostva *, cpu_if)
> >  DECLARE_KVM_HOST_HCALL_VOID(__vgic_v5_restore_vmcr_apr, 1,
> > -     struct vgic_v5_cpu_if *, cpu_if)
> > +     struct vgic_v5_cpu_if __hostva *, cpu_if)
> >
> >  /* Hypercalls that are available only when pKVM has finalised. */
> >  DECLARE_KVM_HOST_HCALL(int, __pkvm_host_share_hyp, 1,
> > @@ -220,10 +232,11 @@ DECLARE_KVM_HOST_HCALL0(int, __pkvm_reserve_vm)
> >  DECLARE_KVM_HOST_HCALL_VOID(__pkvm_unreserve_vm, 1,
> >       pkvm_handle_t, handle)
> >  DECLARE_KVM_HOST_HCALL(int, __pkvm_init_vm, 3,
> > -     struct kvm *, host_kvm, void *, vm_hva, void *, pgd_hva)
> > +     struct kvm __hostva *, host_kvm, void __hostva *, vm_hva,
> > +     void __hostva *, pgd_hva)
> >  DECLARE_KVM_HOST_HCALL(int, __pkvm_init_vcpu, 3,
> > -     pkvm_handle_t, handle, struct kvm_vcpu *, host_vcpu,
> > -     void *, vcpu_hva)
> > +     pkvm_handle_t, handle, struct kvm_vcpu __hostva *, host_vcpu,
> > +     void __hostva *, vcpu_hva)
> >  DECLARE_KVM_HOST_HCALL0(int, __pkvm_vcpu_in_poison_fault)
> >  DECLARE_KVM_HOST_HCALL(int, __pkvm_force_reclaim_guest_page, 1,
> >       phys_addr_t, phys)
> > diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> > index 6eae7e7e2a684..55fac40377c03 100644
> > --- a/arch/arm64/include/asm/kvm_mmu.h
> > +++ b/arch/arm64/include/asm/kvm_mmu.h
> > @@ -7,6 +7,8 @@
> >  #ifndef __ARM64_KVM_MMU_H__
> >  #define __ARM64_KVM_MMU_H__
> >
> > +#include <linux/compiler.h>
> > +
> >  #include <asm/page.h>
> >  #include <asm/memory.h>
> >  #include <asm/mmu.h>
> > @@ -140,6 +142,14 @@ static __always_inline unsigned long __kern_hyp_va(unsigned long v)
> >
> >  #define kern_hyp_va(v)       ((typeof(v))(__kern_hyp_va((unsigned long)(v))))
> >
> > +/*
> > + * Translate a __hostva-tagged host VA, dropping the tag: the only sanctioned
> > + * unwrap. Translation only, no ownership or bounds validation; the result
> > + * carries the pointee type stripped of the tag and of any cv-qualifiers.
> > + */
> > +#define kern_hyp_va_host(v)                                          \
> > +     ((TYPEOF_UNQUAL(*(v)) *)__kern_hyp_va((unsigned long)(__force void *)(v)))
> > +
> >  extern u32 __hyp_va_bits;
> >
> >  /*
> > diff --git a/arch/arm64/kvm/hyp/include/nvhe/pkvm.h b/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
> > index 2643a1a819668..dcbe8b8913270 100644
> > --- a/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
> > +++ b/arch/arm64/kvm/hyp/include/nvhe/pkvm.h
> > @@ -7,6 +7,7 @@
> >  #ifndef __ARM64_KVM_NVHE_PKVM_H__
> >  #define __ARM64_KVM_NVHE_PKVM_H__
> >
> > +#include <asm/kvm_hcall.h>
> >  #include <asm/kvm_pkvm.h>
> >
> >  #include <nvhe/gfp.h>
> > @@ -69,9 +70,10 @@ void pkvm_hyp_vm_table_init(void *tbl);
> >
> >  int __pkvm_reserve_vm(void);
> >  void __pkvm_unreserve_vm(pkvm_handle_t handle);
> > -int __pkvm_init_vm(struct kvm *host_kvm, void *vm_hva, void *pgd_hva);
> > +int __pkvm_init_vm(struct kvm *host_kvm, void __hostva *vm_hva,
> > +                void __hostva *pgd_hva);
> >  int __pkvm_init_vcpu(pkvm_handle_t handle, struct kvm_vcpu *host_vcpu,
> > -                  void *vcpu_hva);
> > +                  void __hostva *vcpu_hva);
> >
> >  int __pkvm_reclaim_dying_guest_page(pkvm_handle_t handle, u64 gfn);
> >  int __pkvm_start_teardown_vm(pkvm_handle_t handle);
> > diff --git a/arch/arm64/kvm/hyp/include/nvhe/trace.h b/arch/arm64/kvm/hyp/include/nvhe/trace.h
> > index 4aa36fd76b9e2..58e0ad3329034 100644
> > --- a/arch/arm64/kvm/hyp/include/nvhe/trace.h
> > +++ b/arch/arm64/kvm/hyp/include/nvhe/trace.h
> > @@ -4,6 +4,7 @@
> >
> >  #include <linux/trace_remote_event.h>
> >
> > +#include <asm/kvm_hcall.h>
> >  #include <asm/kvm_hyptrace.h>
> >
> >  static inline pid_t __tracing_get_vcpu_pid(struct kvm_cpu_context *host_ctxt)
> > @@ -46,7 +47,7 @@ static inline pid_t __tracing_get_vcpu_pid(struct kvm_cpu_context *host_ctxt)
> >  void *tracing_reserve_entry(unsigned long length);
> >  void tracing_commit_entry(void);
> >
> > -int __tracing_load(void *desc_va, size_t desc_size);
> > +int __tracing_load(void __hostva *desc_va, size_t desc_size);
> >  void __tracing_unload(void);
> >  int __tracing_enable(bool enable);
> >  int __tracing_swap_reader(unsigned int cpu);
> > @@ -59,7 +60,7 @@ static inline void tracing_commit_entry(void) { }
> >  #define HYP_EVENT(__name, __proto, __struct, __assign, __printk)      \
> >       static inline void trace_##__name(__proto) {}
> >
> > -static inline int __tracing_load(void *desc_va, size_t desc_size) { return -ENODEV; }
> > +static inline int __tracing_load(void __hostva *desc_va, size_t desc_size) { return -ENODEV; }
> >  static inline void __tracing_unload(void) { }
> >  static inline int __tracing_enable(bool enable) { return -ENODEV; }
> >  static inline int __tracing_swap_reader(unsigned int cpu) { return -ENODEV; }
> > diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> > index f2501249f4391..679b6df9c998d 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
> > @@ -269,7 +269,7 @@ DEFINE_KVM_HOST_HCALL0_VOID(__pkvm_vcpu_put)
> >  }
> >
> >  DEFINE_KVM_HOST_HCALL(int, __kvm_vcpu_run, 1,
> > -     struct kvm_vcpu *, host_vcpu)
> > +     struct kvm_vcpu __hostva *, host_vcpu)
> >  {
> >       int ret;
> >
> > @@ -294,7 +294,7 @@ DEFINE_KVM_HOST_HCALL(int, __kvm_vcpu_run, 1,
> >
> >               sync_hyp_vcpu(hyp_vcpu);
> >       } else {
> > -             struct kvm_vcpu *vcpu = kern_hyp_va(host_vcpu);
> > +             struct kvm_vcpu *vcpu = kern_hyp_va_host(host_vcpu);
> >
> >               /* The host is fully trusted, run its vCPU directly. */
> >               fpsimd_lazy_switch_to_guest(vcpu);
> > @@ -421,9 +421,9 @@ DEFINE_KVM_HOST_HCALL(int, __pkvm_host_mkyoung_guest, 1,
> >  }
> >
> >  DEFINE_KVM_HOST_HCALL_VOID(__kvm_adjust_pc, 1,
> > -     struct kvm_vcpu *, vcpu)
> > +     struct kvm_vcpu __hostva *, vcpu)
> >  {
> > -     __kvm_adjust_pc(kern_hyp_va(vcpu));
> > +     __kvm_adjust_pc(kern_hyp_va_host(vcpu));
> >  }
> >
> >  DEFINE_KVM_HOST_HCALL0_VOID(__kvm_flush_vm_context)
> > @@ -432,27 +432,27 @@ DEFINE_KVM_HOST_HCALL0_VOID(__kvm_flush_vm_context)
> >  }
> >
> >  DEFINE_KVM_HOST_HCALL_VOID(__kvm_tlb_flush_vmid_ipa, 3,
> > -     struct kvm_s2_mmu *, mmu, phys_addr_t, ipa, int, level)
> > +     struct kvm_s2_mmu __hostva *, mmu, phys_addr_t, ipa, int, level)
> >  {
> > -     __kvm_tlb_flush_vmid_ipa(kern_hyp_va(mmu), ipa, level);
> > +     __kvm_tlb_flush_vmid_ipa(kern_hyp_va_host(mmu), ipa, level);
> >  }
> >
> >  DEFINE_KVM_HOST_HCALL_VOID(__kvm_tlb_flush_vmid_ipa_nsh, 3,
> > -     struct kvm_s2_mmu *, mmu, phys_addr_t, ipa, int, level)
> > +     struct kvm_s2_mmu __hostva *, mmu, phys_addr_t, ipa, int, level)
> >  {
> > -     __kvm_tlb_flush_vmid_ipa_nsh(kern_hyp_va(mmu), ipa, level);
> > +     __kvm_tlb_flush_vmid_ipa_nsh(kern_hyp_va_host(mmu), ipa, level);
> >  }
> >
> >  DEFINE_KVM_HOST_HCALL_VOID(__kvm_tlb_flush_vmid_range, 3,
> > -     struct kvm_s2_mmu *, mmu, phys_addr_t, start, unsigned long, pages)
> > +     struct kvm_s2_mmu __hostva *, mmu, phys_addr_t, start, unsigned long, pages)
> >  {
> > -     __kvm_tlb_flush_vmid_range(kern_hyp_va(mmu), start, pages);
> > +     __kvm_tlb_flush_vmid_range(kern_hyp_va_host(mmu), start, pages);
> >  }
> >
> >  DEFINE_KVM_HOST_HCALL_VOID(__kvm_tlb_flush_vmid, 1,
> > -     struct kvm_s2_mmu *, mmu)
> > +     struct kvm_s2_mmu __hostva *, mmu)
> >  {
> > -     __kvm_tlb_flush_vmid(kern_hyp_va(mmu));
> > +     __kvm_tlb_flush_vmid(kern_hyp_va_host(mmu));
> >  }
> >
> >  DEFINE_KVM_HOST_HCALL_VOID(__pkvm_tlb_flush_vmid, 1,
> > @@ -468,9 +468,9 @@ DEFINE_KVM_HOST_HCALL_VOID(__pkvm_tlb_flush_vmid, 1,
> >  }
> >
> >  DEFINE_KVM_HOST_HCALL_VOID(__kvm_flush_cpu_context, 1,
> > -     struct kvm_s2_mmu *, mmu)
> > +     struct kvm_s2_mmu __hostva *, mmu)
> >  {
> > -     __kvm_flush_cpu_context(kern_hyp_va(mmu));
> > +     __kvm_flush_cpu_context(kern_hyp_va_host(mmu));
> >  }
> >
> >  DEFINE_KVM_HOST_HCALL_VOID(__kvm_timer_set_cntvoff, 1,
> > @@ -499,15 +499,15 @@ DEFINE_KVM_HOST_HCALL0_VOID(__vgic_v3_init_lrs)
> >  }
> >
> >  DEFINE_KVM_HOST_HCALL_VOID(__vgic_v3_save_aprs, 1,
> > -     struct vgic_v3_cpu_if *, cpu_if)
> > +     struct vgic_v3_cpu_if __hostva *, cpu_if)
> >  {
> > -     __vgic_v3_save_aprs(kern_hyp_va(cpu_if));
> > +     __vgic_v3_save_aprs(kern_hyp_va_host(cpu_if));
> >  }
> >
> >  DEFINE_KVM_HOST_HCALL_VOID(__vgic_v3_restore_vmcr_aprs, 1,
> > -     struct vgic_v3_cpu_if *, cpu_if)
> > +     struct vgic_v3_cpu_if __hostva *, cpu_if)
> >  {
> > -     __vgic_v3_restore_vmcr_aprs(kern_hyp_va(cpu_if));
> > +     __vgic_v3_restore_vmcr_aprs(kern_hyp_va_host(cpu_if));
> >  }
> >
> >  DEFINE_KVM_HOST_HCALL(int, __pkvm_init, 4,
> > @@ -579,16 +579,17 @@ DEFINE_KVM_HOST_HCALL_VOID(__pkvm_unreserve_vm, 1,
> >  }
> >
> >  DEFINE_KVM_HOST_HCALL(int, __pkvm_init_vm, 3,
> > -     struct kvm *, host_kvm, void *, vm_hva, void *, pgd_hva)
> > +     struct kvm __hostva *, host_kvm, void __hostva *, vm_hva,
> > +     void __hostva *, pgd_hva)
> >  {
> > -     return __pkvm_init_vm(kern_hyp_va(host_kvm), vm_hva, pgd_hva);
> > +     return __pkvm_init_vm(kern_hyp_va_host(host_kvm), vm_hva, pgd_hva);
> >  }
> >
> >  DEFINE_KVM_HOST_HCALL(int, __pkvm_init_vcpu, 3,
> > -     pkvm_handle_t, handle, struct kvm_vcpu *, host_vcpu,
> > -     void *, vcpu_hva)
> > +     pkvm_handle_t, handle, struct kvm_vcpu __hostva *, host_vcpu,
> > +     void __hostva *, vcpu_hva)
> >  {
> > -     return __pkvm_init_vcpu(handle, kern_hyp_va(host_vcpu), vcpu_hva);
> > +     return __pkvm_init_vcpu(handle, kern_hyp_va_host(host_vcpu), vcpu_hva);
> >  }
> >
> >  DEFINE_KVM_HOST_HCALL0(int, __pkvm_vcpu_in_poison_fault)
> > @@ -623,7 +624,7 @@ DEFINE_KVM_HOST_HCALL(int, __pkvm_finalize_teardown_vm, 1,
> >  }
> >
> >  DEFINE_KVM_HOST_HCALL(int, __tracing_load, 2,
> > -     void *, desc_hva, size_t, desc_size)
> > +     void __hostva *, desc_hva, size_t, desc_size)
> >  {
> >       return __tracing_load(desc_hva, desc_size);
> >  }
> > @@ -670,15 +671,15 @@ DEFINE_KVM_HOST_HCALL_VOID(__tracing_write_event, 1,
> >  }
> >
> >  DEFINE_KVM_HOST_HCALL_VOID(__vgic_v5_save_apr, 1,
> > -     struct vgic_v5_cpu_if *, cpu_if)
> > +     struct vgic_v5_cpu_if __hostva *, cpu_if)
> >  {
> > -     __vgic_v5_save_apr(kern_hyp_va(cpu_if));
> > +     __vgic_v5_save_apr(kern_hyp_va_host(cpu_if));
> >  }
> >
> >  DEFINE_KVM_HOST_HCALL_VOID(__vgic_v5_restore_vmcr_apr, 1,
> > -     struct vgic_v5_cpu_if *, cpu_if)
> > +     struct vgic_v5_cpu_if __hostva *, cpu_if)
> >  {
> > -     __vgic_v5_restore_vmcr_apr(kern_hyp_va(cpu_if));
> > +     __vgic_v5_restore_vmcr_apr(kern_hyp_va_host(cpu_if));
> >  }
> >
> >  typedef void (*hcall_t)(struct kvm_cpu_context *);
> > diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
> > index 205c52535c887..bfc9f07f336a1 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
> > @@ -644,9 +644,9 @@ static size_t pkvm_get_hyp_vm_size(unsigned int nr_vcpus)
> >               size_mul(sizeof(struct pkvm_hyp_vcpu *), nr_vcpus));
> >  }
> >
> > -static void *map_donated_memory_noclear(void *host_va, size_t size)
> > +static void *map_donated_memory_noclear(void __hostva *host_va, size_t size)
> >  {
> > -     void *va = kern_hyp_va(host_va);
> > +     void *va = kern_hyp_va_host(host_va);
> >
> >       if (!PAGE_ALIGNED(va))
> >               return NULL;
> > @@ -658,7 +658,7 @@ static void *map_donated_memory_noclear(void *host_va, size_t size)
> >       return va;
> >  }
> >
> > -static void *map_donated_memory(void *host_va, size_t size)
> > +static void *map_donated_memory(void __hostva *host_va, size_t size)
> >  {
> >       void *va = map_donated_memory_noclear(host_va, size);
> >
> > @@ -805,7 +805,8 @@ void teardown_selftest_vm(void)
> >   *
> >   * Return 0 success, negative error code on failure.
> >   */
> > -int __pkvm_init_vm(struct kvm *host_kvm, void *vm_hva, void *pgd_hva)
> > +int __pkvm_init_vm(struct kvm *host_kvm, void __hostva *vm_hva,
> > +                void __hostva *pgd_hva)
> >  {
> >       struct pkvm_hyp_vm *hyp_vm = NULL;
> >       size_t vm_size, pgd_size;
> > @@ -896,7 +897,7 @@ static int register_hyp_vcpu(struct pkvm_hyp_vm *hyp_vm,
> >  }
> >
> >  int __pkvm_init_vcpu(pkvm_handle_t handle, struct kvm_vcpu *host_vcpu,
> > -                  void *vcpu_hva)
> > +                  void __hostva *vcpu_hva)
> >  {
> >       struct pkvm_hyp_vcpu *hyp_vcpu;
> >       struct pkvm_hyp_vm *hyp_vm;
> > diff --git a/arch/arm64/kvm/hyp/nvhe/trace.c b/arch/arm64/kvm/hyp/nvhe/trace.c
> > index 97203ddd3cf45..5d0fcdce9507d 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/trace.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/trace.c
> > @@ -206,9 +206,9 @@ static bool hyp_trace_desc_is_valid(struct hyp_trace_desc *desc, size_t desc_siz
> >       return true;
> >  }
> >
> > -int __tracing_load(void *desc_hva, size_t desc_size)
> > +int __tracing_load(void __hostva *desc_hva, size_t desc_size)
> >  {
> > -     struct hyp_trace_desc *desc = kern_hyp_va(desc_hva);
> > +     struct hyp_trace_desc *desc = kern_hyp_va_host(desc_hva);
> >       int ret;
> >
> >       ret = __admit_host_mem(desc, desc_size);
> > --
> > 2.39.5
> >
>
> --
> Vincent
