Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C448C34751C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 06:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382374; cv=none; b=Go+kr/EmhfueBOY5+9FWf7mMDfbMBXIEppIbZfDZADn57lihsncgnCmzhNITYC6mZpuM9fnqi88nFNj9gsR+Rftjx+Fo+ZfVEVD8o9FVB2jZqOGiExGv30DcgWycZFFvmssdm2e91w8rQycZhop7DKrV+DobUXRgnmXf2AA3S2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382374; c=relaxed/simple;
	bh=MRHw5oy5tFyWNvt56O9mcO7PI2R39CflC4bmNd2C60k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H7AvlDzY97jaOzROUB00VhS4Yt92i6OAWEVyG5P06KEpfd95mXL1VtUaRPscdj6yiuxMKd8zhZ08gLv3a9j5xGAcoAu//zxERaxhjCsF0oX9QQILMHaQLb8qv/f9UxINnLovPnBYzM5t2IrAvprCAnCgieIfYPFlqquDhFmf+Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P9dBzs5N; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P9dBzs5N"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2aecd4f7ca1so4687065ad.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 23:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773382372; x=1773987172; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7kRWhL+HkcSRRi26b8Op9JhhRMhDncUeSMvvheOqHO0=;
        b=P9dBzs5NoIjM9N6ZfHT1tZ/hqembV/VYsLoyIIPFNnwBClMyAq9ChFYkvk/nCRHJkg
         Oa6ZR3+I0FGjIg2nU/eG1uHFy21+WJtl1yToIgzEX+JdFULLlj6ouD2KddNwN0AwoSfb
         ZjUpZV3UaZHLkVgevkQIcT4lNu88wAj+e1LPbbyQ4k0bL2Zy34z4utCqrk4ibzIvyN9A
         cnf8TVgFDeh2qDNhdi9mAg3thBAj7EzpQUz/q7ZrbvMylzO6U7ClAG+yDvSs13R7YnSn
         gE9jfYU4ZIN5bW+lSBLIRx3NBFq8lvYR0W20WGKeADFE4Ddf+2ZMcSEtU7vU660QG3iQ
         0VAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382372; x=1773987172;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7kRWhL+HkcSRRi26b8Op9JhhRMhDncUeSMvvheOqHO0=;
        b=P864vn2srbY6Cp2YfzoRdD4C7LM8bqP/97QxQ66k/caP6HIS/5zf0VjZUgszgiaLlQ
         roL+WsMBUTkhp/n25HdoghDrpDYQKqt3jUBhtBr4y0R08I/Yb2dY5laYoCPrO63nq2Zz
         EJh5/4WLDP4y7CviGMK8EyFlpTVP6jtGDRBPkhrKl3Vla5WMgvIpiG+3lUsgKA4rq223
         t/qlXcp5ppOCy1UIBIuqdF1RM6+PqEAXjZ5OSHhKxek/3bXl5Jsgq0LbuGr3uQ+7aemc
         8w65haVHlGi/xwnBJjM1Ct/NyqA3qUkL2yAtgsvldjwmrzGis3aNsBjWat+QaBaU3iia
         t0+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzcyurJtaI1bStVaM6DLKzb344uomd/yogg/++J1ooDnTmQSM5cEPjaneRlu3g9X13j/iThjg8txybBDjLVTi/IMM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk5KIm6qR/wm/ZqFEcj0IMCkpoMmq9WJXyKbIzFZTc2XFRRVXL
	i+MKwdK0YAa6l/+T5xWHhrsDZ3PvGzlncBXTdX0dj+2Xv+9XrDlupmcRxE7d4Ic6Mk40I4/q4Dx
	yGFt208Tfgwg5xzc1l0V/iSlwyQ==
X-Received: from plef1.prod.google.com ([2002:a17:902:f381:b0:2ae:420c:c02a])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3804:b0:2ae:4445:f397 with SMTP id d9443c01a7336-2aeca9ec6aamr17773125ad.16.1773382371838;
 Thu, 12 Mar 2026 23:12:51 -0700 (PDT)
Date: Fri, 13 Mar 2026 06:12:42 +0000
In-Reply-To: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773382364; l=1737;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=SQorwu5NmjhCMRk1oX2e95cjFDSBZ7C/wme7YI2Safw=; b=BHQfpfOJVOPF572H7KOE0msVDrKGZUSyz6wGCvpiE0UcPhIUix+u1Tv6eCcQRd1Shu80yIiIv
 kXCpa4oqY4EDKBHo5FBojjEQ0I5LvI6zzsNmcvtkSVZYa1Ejso2F1hk
X-Mailer: b4 0.14.3
Message-ID: <20260313-gmem-inplace-conversion-v3-3-5fc12a70ec89@google.com>
Subject: [PATCH RFC v3 03/43] KVM: Enumerate support for PRIVATE memory iff
 kvm_arch_has_private_mem is defined
From: Ackerley Tng <ackerleytng@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jroedel@suse.de, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

From: Sean Christopherson <seanjc@google.com>

Explicitly guard reporting support for KVM_MEMORY_ATTRIBUTE_PRIVATE based
on kvm_arch_has_private_mem being #defined in anticipation of decoupling
kvm_supported_mem_attributes() from CONFIG_KVM_VM_MEMORY_ATTRIBUTES.
guest_memfd support for memory attributes will be unconditional to avoid
yet more macros (all architectures that support guest_memfd are expected to
use per-gmem attributes at some point), at which point enumerating support
KVM_MEMORY_ATTRIBUTE_PRIVATE based solely on memory attributes being
supported _somewhere_ would result in KVM over-reporting support on arm64.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_host.h | 2 +-
 virt/kvm/kvm_main.c      | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index e75f7295af5d0..4ba42a1278d5f 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -721,7 +721,7 @@ static inline int kvm_arch_vcpu_memslots_id(struct kvm_vcpu *vcpu)
 }
 #endif
 
-#ifndef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
+#ifndef kvm_arch_has_private_mem
 static inline bool kvm_arch_has_private_mem(struct kvm *kvm)
 {
 	return false;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 301d7ddac6ba6..793a2c8476b09 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2428,8 +2428,10 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
 #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 static u64 kvm_supported_mem_attributes(struct kvm *kvm)
 {
+#ifdef kvm_arch_has_private_mem
 	if (!kvm || kvm_arch_has_private_mem(kvm))
 		return KVM_MEMORY_ATTRIBUTE_PRIVATE;
+#endif
 
 	return 0;
 }

-- 
2.53.0.851.ga537e3e6e9-goog

