Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FE43C09EE
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735934; cv=none; b=ASYgSkyKqybpVHbdCI7ZbH2bBLGdEBr34VWbahzidV+a+isUDAIQJiCqRmW8uLIWTE5pwyH4URMtBCEWuNKJ11L/pj1BGM/ZTZiuYbPMlKiPCk34jLbz4L+z7+t6sAiY2oEnzWFBjrYCyNI0XK31Y20BiuZBkdUb7jgNkpGmX80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735934; c=relaxed/simple;
	bh=tMdiXviK1wZX5Gu5mkLKJd0vddbMyb0Df5lYz3OBLic=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TXhNfb7Aa4elWOIm+/bsvhv1mKGLwvEoA90ABFxNLOIhSXmCMqMtPzE6oxy88k1Ik/AiqcDP6YBvrAMWy1/u/8ChtPKjPxjB+hL02KzoI7YAHYBDoGN/IwCXFk3t5ZGnG4gjWGBkaLoiQ8AhA1CDUtieMr3Rb+dqAu3x3KTb9JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gHtApVsY; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gHtApVsY"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d63bad3d09so12877295ad.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 02:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787735927; x=1788340727; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P2MYy9xCCsRh/a0/MTuFJqGfvDDDTtCK5nvSZnRDqWg=;
        b=gHtApVsYFt/BTbO4D/jAJ4PPT3NRfD5LLlwOuePs0Buu0rv/gUv9l6h0iq5C99192r
         vC4JML+sia27rkWJRXzxy8W1pkhoK7JOjs0LwFbfu0WK+wT6653LLTWxu8sHdAZ7DwxM
         Vxhid65gcSw5I2mSo2ox/zMdFFj4I2XyO9EInqQz/SZODWYesvnTGJwkDD+b3fCPVKat
         IDGYdNFXzbCe2/EcURTExRyfnaucT+XI1MlUU5cYMX4DAgliGJr+Mob7XzuNcQTx/mSg
         mxGFMX9dFgKQw2mHhDSzphHmyL4dY5beYQK3qWuFuYnwU5Moj/oNo/4crRZDikju0w5r
         aAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735927; x=1788340727;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P2MYy9xCCsRh/a0/MTuFJqGfvDDDTtCK5nvSZnRDqWg=;
        b=mjsOuIKSCcygGLAwVE67aX+982PpzHeWdQOo7wmtHiZL/gYu4abMqu0MOwEUvp0KiV
         cen3Cf4rkmzS3kHjpSbXP3FAE/BUdcdxqGWHOgRRklrgYyfxChlte2srdEb5xVF81PWJ
         WewH+7S7c5FlSKr7l8HZgjXY1+uNw32rvbnK68L08k69QGO+6s/5XNiAl/g5tvVJ3cdj
         FU1CtvycIIXMCVVJckhNE4paqi6RKQBLRMX0uzcp7EYBAXdsBdSXEVymlhNYTiY6dDCR
         MXMC9vfneTYC0B2jVFp8WDkcL55Rjm7T2SQMxpthc5gWPj+rxR1o1/kCEVY4RkGS6stR
         ZeMA==
X-Forwarded-Encrypted: i=1; AHgh+RrHW6rCSO3eGpYi9pEAG1ZVUPfpzjbjSU6A0ugFQ3kRWbki27Anam+fRW6T+xSgZqp+NG2PlvBbiq4GLqDu+fRCS50=@vger.kernel.org
X-Gm-Message-State: AFuF++lI75umzJ7VEHXhMTUKKFneYxQW//fduqaKzGhBrXeeR+n9tWQJ
	xupBYNefUHFMfb7dIq9Y25WVmXstI+c/ro0RyVDwjCS1CieW/dA47JhZFEcQf0DmKs3bnrxU3Ub
	ezvIOyqk7HPYmmi9dQtdw58B95g==
X-Received: from plio3.prod.google.com ([2002:a17:903:46c3:b0:2d6:3009:ccc2])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2283:b0:2d6:7409:7145 with SMTP id d9443c01a7336-2d707a2edd0mr90965095ad.1.1787735926573;
 Wed, 26 Aug 2026 02:18:46 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:18:21 +0000
In-Reply-To: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787735885; l=7437;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=erBMg+vYNKFmnIk1EALqLuAs5vQ8G8lIJWnAQEPGhMk=; b=rvsxDqasKEC9y24pJL6GBixd0VO6ms1BpDtgqU2vfiPjwfeBV4W2WWC2J5Xrl4izaS+xS4TWP
 bS2O2g3q2UYCaaj4SuKQQVw+wKicDiRXtr4U+uVmHBd3z9x3HPMjVOo
X-Mailer: b4 0.16.0
Message-ID: <20260826-gmem-inplace-conversion-v11-23-0a15d8a799aa@google.com>
Subject: [PATCH v11 23/46] KVM: Let userspace disable per-VM mem attributes,
 enable per-gmem attributes
From: Ackerley Tng <ackerleytng@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
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
	Fuad Tabba <fuad.tabba@linux.dev>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev, Ackerley Tng <ackerleytng@google.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="utf-8"

From: Sean Christopherson <seanjc@google.com>

Allow the user to disable KVM_VM_MEMORY_ATTRIBUTES even when KVM supports
PRIVATE and SHARED attributes, and expose gmem_in_place_conversion as a
module parameter when per-VM attributes are supported.  I.e. let userspace
enable in-place PRIVATE<=>SHARED conversion of guest_memfd pages.

Provide both a Kconfig option and a (conditional) module param so that
deployments that use a custom kernel can fully disable per-VM tracking,
while not forcing distros to ship two separate kernels in order to provide
backwards compatibility for downstream users.

Don't allow running VMs with mixed tracking for a given instance of KVM,
i.e. disallow toggling the module param after KVM is loaded, as the extra
complexity needed to handle per-VM behavior far outweighs any potential
benefit.  E.g. neither TDX nor SNP supports live migration, so in effect
the requirement is that existing deployments that want to support both the
old and the new models would need to tell their VMM which flavor of
tracking to use.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Shivank Garg <shivankg@amd.com>
[Define module_param only if CONFIG_KVM_VM_MEMORY_ATTRIBUTES is enabled]
Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 25 +++++++++++++++++++++++++
 Documentation/virt/kvm/api.rst                  |  7 +++++--
 arch/x86/include/asm/kvm_host.h                 |  4 +++-
 arch/x86/kvm/Kconfig                            | 14 ++++++++++----
 virt/kvm/kvm_main.c                             |  5 ++++-
 5 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1069806616b94..0ac44e1bccd28 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3114,6 +3114,31 @@ Kernel parameters
 	kvm.enable_vmware_backdoor=[KVM] Support VMware backdoor PV interface.
 				   Default is false (don't support).
 
+	kvm.gmem_in_place_conversion=
+			[KVM] Controls whether KVM enables in-place conversion
+			support for guest_memfd and tracks the private/shared
+			state of memory per guest_memfd instead of per VM.
+
+			If enabled, KVM enables the KVM_SET_MEMORY_ATTRIBUTES2
+			ioctl on guest_memfd file descriptors and disables the
+			legacy VM-scoped KVM_SET_MEMORY_ATTRIBUTES ioctl for
+			private memory state tracking. Only the
+			KVM_MEMORY_ATTRIBUTE_PRIVATE attribute moves to
+			per-guest_memfd tracking; other attributes remain
+			per-VM.
+
+			This parameter toggles KVM's in-place conversion
+			capability support. Whether a VMM uses separate backends
+			or out-of-place memory management is determined by
+			userspace VMM design.
+
+			Note, this parameter is only available when
+			CONFIG_KVM_VM_MEMORY_ATTRIBUTES=y. When
+			CONFIG_KVM_VM_MEMORY_ATTRIBUTES is not set, in-place
+			conversion is unconditionally enabled.
+
+			Default is Y (on).
+
 	kvm.nx_huge_pages=
 			[KVM] Controls the software workaround for the
 			X86_BUG_ITLB_MULTIHIT bug.
diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index f88d65b78c504..d976f8ec2e2dc 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6383,9 +6383,12 @@ on-demand.
 
 When mapping a gfn into the guest, KVM selects shared vs. private, i.e consumes
 userspace_addr vs. guest_memfd, based on the gfn's KVM_MEMORY_ATTRIBUTE_PRIVATE
-state.  At VM creation time, all memory is shared, i.e. the PRIVATE attribute
-is '0' for all gfns.  Userspace can control whether memory is shared/private by
+state.  If in-place conversion is disabled, i.e. PRIVATE is tracked per-VM,
+then at VM creation time, all memory is shared, i.e. the PRIVATE attribute is
+'0' for all gfns.  Userspace can control whether memory is shared/private by
 toggling KVM_MEMORY_ATTRIBUTE_PRIVATE via KVM_SET_MEMORY_ATTRIBUTES as needed.
+If in-place conversion is enabled, then the starting PRIVATE vs. SHARED state
+of a gfn is determined by the relevant guest_memfd instance.
 
 S390:
 ^^^^^
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 83e26ce45fb79..e840418427a1d 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1851,7 +1851,9 @@ enum kvm_intr_type {
 	((vcpu) && (vcpu)->arch.handling_intr_from_guest && \
 	 (!!in_nmi() == ((vcpu)->arch.handling_intr_from_guest == KVM_HANDLING_NMI)))
 
-#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
+#if defined(CONFIG_KVM_SW_PROTECTED_VM) ||	\
+    defined(CONFIG_KVM_INTEL_TDX) ||		\
+    defined(CONFIG_KVM_AMD_SEV)
 #define kvm_arch_has_private_mem(kvm) ((kvm)->arch.has_private_mem)
 #endif
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index abb108886733a..2c3c22aeafa54 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -81,13 +81,21 @@ config KVM_WERROR
 	  If in doubt, say "N".
 
 config KVM_VM_MEMORY_ATTRIBUTES
-	bool
+	bool "Enable per-VM PRIVATE vs. SHARED attributes (for CoCo VMs)"
+	depends on KVM_SW_PROTECTED_VM || KVM_INTEL_TDX || KVM_AMD_SEV
+	help
+	  Enable support for tracking PRIVATE vs. SHARED memory using per-VM
+	  memory attributes.  Using per-VM attributes is deprecated in favor of
+	  tracking PRIVATE state in guest_memfd.  Select this if you need to run
+	  CoCo VMs using a VMM that doesn't support guest_memfd memory
+	  attributes.
+
+	  If unsure, say N.
 
 config KVM_SW_PROTECTED_VM
 	bool "Enable support for KVM software-protected VMs"
 	depends on EXPERT
 	depends on KVM_X86 && X86_64
-	select KVM_VM_MEMORY_ATTRIBUTES
 	help
 	  Enable support for KVM software-protected VMs.  Currently, software-
 	  protected VMs are purely a development and testing vehicle for
@@ -138,7 +146,6 @@ config KVM_INTEL_TDX
 	bool "Intel Trust Domain Extensions (TDX) support"
 	default y
 	depends on INTEL_TDX_HOST
-	select KVM_VM_MEMORY_ATTRIBUTES
 	select HAVE_KVM_ARCH_GMEM_POPULATE
 	help
 	  Provides support for launching Intel Trust Domain Extensions (TDX)
@@ -162,7 +169,6 @@ config KVM_AMD_SEV
 	depends on KVM_AMD && X86_64
 	depends on CRYPTO_DEV_SP_PSP && !(KVM_AMD=y && CRYPTO_DEV_CCP_DD=m)
 	select ARCH_HAS_CC_PLATFORM
-	select KVM_VM_MEMORY_ATTRIBUTES
 	select HAVE_KVM_ARCH_GMEM_CONVERT
 	select HAVE_KVM_ARCH_GMEM_RECLAIM
 	select HAVE_KVM_ARCH_GMEM_INVALIDATE
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 05c518c9b8078..929fd3e1a01e6 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -103,7 +103,10 @@ static bool __ro_after_init allow_unsafe_mappings;
 module_param(allow_unsafe_mappings, bool, 0444);
 
 #ifdef kvm_arch_has_private_mem
-bool __ro_after_init gmem_in_place_conversion = false;
+bool __ro_after_init gmem_in_place_conversion = !IS_ENABLED(CONFIG_KVM_VM_MEMORY_ATTRIBUTES);
+#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
+module_param(gmem_in_place_conversion, bool, 0444);
+#endif
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(gmem_in_place_conversion);
 #endif
 

-- 
2.55.0.887.g758fc8c411-goog

