Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EABF1DDC3F
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 May 2025 13:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402868; cv=none; b=gscNU2PRKNJ5LGjkRuNHLT5zu66inUlGyGEUoq8hY54f495YxktE03+CETIPWcCZ39wNCKkhIylUJhaRACUyYUypSJN5VcbGyzGpI/Q9Ccsd+QwkD/NtL0zzHuh426BlCf4bcK5GKXyzdtrIo2+vJM0+GrfhH7Bv5GfEDARHzO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402868; c=relaxed/simple;
	bh=GFdibPOC36wpV8Uous2RaSr1XY5geTjwZRL1v/9HRRY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p623Ys2CyCeAZxb+MsovdPqjPn7uptKBdJIE+XPtjmwc3ifw2k2FsGCzV5vLNfO5zskHk2CZIxhwIL3TltwPreK5M5rChiJVhDK+VPAQMvMGu//db0PBH3TY2kF4+yZMOVo7erOxtdfkZjGHWXOnMBLS6JjOHFJzSpDbC2xC4Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sDPGPsTI; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sDPGPsTI"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43efa869b19so16210875e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 16 May 2025 06:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747402864; x=1748007664; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UnPspQ9npIBrd4S4MmL9DdGLdrnLPvxyuuuGQ/DUw7k=;
        b=sDPGPsTIRVP6mF2JEjdunQYuRs7X+LIB8J6H5aA3uqVXhNTot4+wD45HCG6zgEwxRn
         WczaEDWlqIuTRjz7VkAK6X6E5mGAC5DPFxtpxoB29yTh2a/qTPZINtYfnOrSsAtzYach
         3yJ0ZwwZyNajJKloEuXGS0xzO2Yvz3FViVF/odRrqi5g6ZjWaiAKbwoTehps8nbFTsW+
         qfijljxCrkHuyBzAcDOus8JItH8uGrdQv+NoCPJvOtwQi5IibnV2P1LEv9EeVPeMyxdf
         lNtqAiVHrF6EYAaG4GE6Fmad/FWGIdSY4Mfdnti2R8qgIdToYJkKWHfpu8NHFpSFmIBy
         ZGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747402864; x=1748007664;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UnPspQ9npIBrd4S4MmL9DdGLdrnLPvxyuuuGQ/DUw7k=;
        b=KKmNSMDmpdRnm5XhR2bg0ipKgT0l46DdSI7d3J0f2CwjmM2UOP/s9NWFyozjgNQoM2
         7XejhsJZfC9qtN4lQvBwK38ksMRtGFILKcW0FERK9oL4Fj6jM5KWjKdjCDuESm1gIhJC
         hk2bPdHZQgKGSBvRoEbHhwA+MH7RnD1VBIIFAnuIDlyvP+oTajfPtqfR1PxPJdjGVhT3
         WTcBvkXkaVn1Te+pMHaTIvUqHPmbOavH7Jr/dtShapfnELxo5n4GtQrQZrvgjOxWggRl
         9wzb/gWS+LyAaYuiuEuswJD5VTRoCbwL0o2DNYzUzQuQvJfP5wKFjyIG8rDZe1kpY3fz
         iGrA==
X-Forwarded-Encrypted: i=1; AJvYcCU8Q3FdHApddUyCMrNe5o/G3h7gCY4uF8Z+l8wJV4v0wGFUxiEsqa+Ffrzt5RetMtZjsQY2XPQmkaj9xk/nK411t3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlUIouUX3H04PtD4hX4ZTYeQjWvmKuSUBcFRJE6n3lq817+KHw
	TsQ2TZ0gLhmd8GWkKmG+BTxzo6Vx8KuTRwB05CjIeFYpvnjdfg5J5y5t14pXk5Ju1gtFtBCt76R
	s2iD9ypJt2M7qbj1UeC8W0w==
X-Google-Smtp-Source: AGHT+IGZgZ/Gc79ZOBKRvjg0SEuMNrVkd6guUMpYnYNcmNkDaw6H5jIch8mAkGbsI3ipZMEvlgcscvNmccBDHpRZ
X-Received: from wmbes8.prod.google.com ([2002:a05:600c:8108:b0:440:59df:376a])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1f87:b0:43c:ea36:9840 with SMTP id 5b1f17b1804b1-442ff031805mr20621965e9.22.1747402864032;
 Fri, 16 May 2025 06:41:04 -0700 (PDT)
Date: Fri, 16 May 2025 14:40:22 +0100
In-Reply-To: <20250516134031.661124-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250516134031.661124-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250516134031.661124-17-vdonnefort@google.com>
Subject: [PATCH v5 16/25] KVM: arm64: Add .hyp.data section
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	David Brazdil <dbrazdil@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Brazdil <dbrazdil@google.com>

The hypervisor has not needed its own .data section because all globals
were either .rodata or .bss. To avoid having to initialize future
data-structures at run-time, let's introduce add a .data section to the
hypervisor.

Signed-off-by: David Brazdil <dbrazdil@google.com>
Signed-off-by: Quentin Perret <qperret@google.com>
Link: https://lore.kernel.org/r/20250416160900.3078417-2-qperret@google.com
Signed-off-by: Marc Zyngier <maz@kernel.org>

diff --git a/arch/arm64/include/asm/sections.h b/arch/arm64/include/asm/sections.h
index 40971ac1303f..51b0d594239e 100644
--- a/arch/arm64/include/asm/sections.h
+++ b/arch/arm64/include/asm/sections.h
@@ -11,6 +11,7 @@ extern char __alt_instructions[], __alt_instructions_end[];
 extern char __hibernate_exit_text_start[], __hibernate_exit_text_end[];
 extern char __hyp_idmap_text_start[], __hyp_idmap_text_end[];
 extern char __hyp_text_start[], __hyp_text_end[];
+extern char __hyp_data_start[], __hyp_data_end[];
 extern char __hyp_rodata_start[], __hyp_rodata_end[];
 extern char __hyp_reloc_begin[], __hyp_reloc_end[];
 extern char __hyp_bss_start[], __hyp_bss_end[];
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 2004b4f41ade..798405ec48a3 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -127,6 +127,8 @@ KVM_NVHE_ALIAS(__hyp_text_start);
 KVM_NVHE_ALIAS(__hyp_text_end);
 KVM_NVHE_ALIAS(__hyp_bss_start);
 KVM_NVHE_ALIAS(__hyp_bss_end);
+KVM_NVHE_ALIAS(__hyp_data_start);
+KVM_NVHE_ALIAS(__hyp_data_end);
 KVM_NVHE_ALIAS(__hyp_rodata_start);
 KVM_NVHE_ALIAS(__hyp_rodata_end);
 
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index e73326bd3ff7..7c770053f072 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -13,7 +13,7 @@
 	*(__kvm_ex_table)					\
 	__stop___kvm_ex_table = .;
 
-#define HYPERVISOR_DATA_SECTIONS				\
+#define HYPERVISOR_RODATA_SECTIONS				\
 	HYP_SECTION_NAME(.rodata) : {				\
 		. = ALIGN(PAGE_SIZE);				\
 		__hyp_rodata_start = .;				\
@@ -23,6 +23,15 @@
 		__hyp_rodata_end = .;				\
 	}
 
+#define HYPERVISOR_DATA_SECTION					\
+	HYP_SECTION_NAME(.data) : {				\
+		. = ALIGN(PAGE_SIZE);				\
+		__hyp_data_start = .;				\
+		*(HYP_SECTION_NAME(.data))			\
+		. = ALIGN(PAGE_SIZE);				\
+		__hyp_data_end = .;				\
+	}
+
 #define HYPERVISOR_PERCPU_SECTION				\
 	. = ALIGN(PAGE_SIZE);					\
 	HYP_SECTION_NAME(.data..percpu) : {			\
@@ -51,7 +60,8 @@
 #define SBSS_ALIGN			PAGE_SIZE
 #else /* CONFIG_KVM */
 #define HYPERVISOR_EXTABLE
-#define HYPERVISOR_DATA_SECTIONS
+#define HYPERVISOR_RODATA_SECTIONS
+#define HYPERVISOR_DATA_SECTION
 #define HYPERVISOR_PERCPU_SECTION
 #define HYPERVISOR_RELOC_SECTION
 #define SBSS_ALIGN			0
@@ -190,7 +200,7 @@ SECTIONS
 	/* everything from this point to __init_begin will be marked RO NX */
 	RO_DATA(PAGE_SIZE)
 
-	HYPERVISOR_DATA_SECTIONS
+	HYPERVISOR_RODATA_SECTIONS
 
 	.got : { *(.got) }
 	/*
@@ -295,6 +305,8 @@ SECTIONS
 	_sdata = .;
 	RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_ALIGN)
 
+	HYPERVISOR_DATA_SECTION
+
 	/*
 	 * Data written with the MMU off but read with the MMU on requires
 	 * cache lines to be invalidated, discarding up to a Cache Writeback
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 19ca57def629..6c42682bc66f 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -2604,6 +2604,13 @@ static int __init init_hyp_mode(void)
 		goto out_err;
 	}
 
+	err = create_hyp_mappings(kvm_ksym_ref(__hyp_data_start),
+				  kvm_ksym_ref(__hyp_data_end), PAGE_HYP);
+	if (err) {
+		kvm_err("Cannot map .hyp.data section\n");
+		goto out_err;
+	}
+
 	err = create_hyp_mappings(kvm_ksym_ref(__hyp_rodata_start),
 				  kvm_ksym_ref(__hyp_rodata_end), PAGE_HYP_RO);
 	if (err) {
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
index f4562f417d3f..d724f6d69302 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
@@ -25,5 +25,7 @@ SECTIONS {
 	BEGIN_HYP_SECTION(.data..percpu)
 		PERCPU_INPUT(L1_CACHE_BYTES)
 	END_HYP_SECTION
+
 	HYP_SECTION(.bss)
+	HYP_SECTION(.data)
 }
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index d62bcb5634a2..46d9bd04348f 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -119,6 +119,10 @@ static int recreate_hyp_mappings(phys_addr_t phys, unsigned long size,
 	if (ret)
 		return ret;
 
+	ret = pkvm_create_mappings(__hyp_data_start, __hyp_data_end, PAGE_HYP);
+	if (ret)
+		return ret;
+
 	ret = pkvm_create_mappings(__hyp_rodata_start, __hyp_rodata_end, PAGE_HYP_RO);
 	if (ret)
 		return ret;
diff --git a/arch/arm64/kvm/pkvm.c b/arch/arm64/kvm/pkvm.c
index 0f89157d31fd..c462140e640a 100644
--- a/arch/arm64/kvm/pkvm.c
+++ b/arch/arm64/kvm/pkvm.c
@@ -262,6 +262,7 @@ static int __init finalize_pkvm(void)
 	 * at, which would end badly once inaccessible.
 	 */
 	kmemleak_free_part(__hyp_bss_start, __hyp_bss_end - __hyp_bss_start);
+	kmemleak_free_part(__hyp_data_start, __hyp_data_end - __hyp_data_start);
 	kmemleak_free_part(__hyp_rodata_start, __hyp_rodata_end - __hyp_rodata_start);
 	kmemleak_free_part_phys(hyp_mem_base, hyp_mem_size);
 
-- 
2.49.0.1101.gccaa498523-goog

