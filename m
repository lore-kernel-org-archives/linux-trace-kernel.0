Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF3136F432
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 06:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382392; cv=none; b=U2yiMWkQYiTL2YyOk+rQ+GKcHlqkdYW+iDYxVhkXxfhifusFZXtMDooAOUCPxfT3MmCyfF4lw5lnpmtRfICF0+ERz0WDLG3TOWbSjl/+hXkezTKowG9VT0u9Q0N6ejCQA4srx5q04MNXuwWXCpSutJTvrx07nyA/fRIN40R46YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382392; c=relaxed/simple;
	bh=cCfNsCI87fg6TEnfgoRKAm3vjZfM30ZKoMGU1LRZRBo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=InMS22Yh/5SdkW2goACDZkRl4ZjGhF5iK77pZ5T/Wko4W0CLbrA285M2y3g4M6pcAkKJI5bUF0bO3RN/WJyHKhLRDwGQxQ55cEGzHSI4dasTxxTp5/X4K/70rLt1r3CpigR0W42dPno5WvrwW6Gr6ZrHj+shEndBqyfXkQGcr+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZBgbTAhe; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZBgbTAhe"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2ae4f27033cso19221015ad.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 23:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773382388; x=1773987188; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lTunW/QNrd+D2aaY5sITtIPS8ag2VRP0yYeRUeCHtMw=;
        b=ZBgbTAheyn74oo/DGKNYaeCqJCoOIr5Nan2IneK/Zzbx41TCYgZ0ZUE0a1MuBuXTDG
         C/c9iBt4REGSnWHx/tqr2OVSJvqUSn7kT+HcGha87IVSD2XjNZ6G+aNFuGVShaHCcfw8
         nbGvBowREZ8LeyGQ7XUeyFCd6+c3i/+jx7+b+XsY0MMvK4sWQND7O1pTsv5VJtlq5qsw
         PodYvbcGRcBOQiaHSiJOE/tJ18umS0O0WDTKb4vizBK/XER0orYkpuh82YioY5cbNFEi
         umhZrXwqB0jPzybFgEIt+NXU/8lhMpm/nGAx7LvkEkoben5JQMvMuKSLJGRxFoGZ7Ljw
         fpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382388; x=1773987188;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lTunW/QNrd+D2aaY5sITtIPS8ag2VRP0yYeRUeCHtMw=;
        b=QZOZnsKQlSiA3sD4NzomldzsGB2ICQPOYSvvQXJXxPmskWyha3DTB0Ps3c+xksTln0
         0uVdqkuyvZ/i6RqoFEX6updZ+nEz44ai0/AWchsLPXIvYctp7PmCdx9B02e6ZS+Z+Kti
         kDu0gxpgjUdPPKifyjX2auIkoEBKnH3yQhQysAy6G1YDMHuqU8QU+J/UV1zhoaukBiH0
         3Ozv30oL3mOQYq7eav7XZcT2XhK417284lfkI274LUQ3ta+KmJiiaaSOzHhRYc82rxt3
         iKJTAHAB/8GQKQ1coR1dOO/9NSDIATeyUV/sEno1WxI4G/mU7jZtAN2NqNaBaTGj0a5h
         swbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSMOcVyktGN4pkj/pCt5d0ikj+7eYT5QKc3X7SZDY0K53P/brt1rkyV+WHjMA5d43wn1EchP0aCZLxVcr4Ur60N5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiVL1Q4U31ppSBodJk03UMOqsJW+3RoAtv3PbNvF2uMLXNAxro
	nBQ5Z1UlXU919ah5TmUMKbNZJtQmwabI1beO7Q0CMcq9ybLqQhOI3K7EgSYphNnV2c3dpY+vxIn
	xj94iH5LXlxfLk0/JV0dhsKeLzA==
X-Received: from pgww15.prod.google.com ([2002:a05:6a02:2c8f:b0:c65:d823:cdf2])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:2d42:b0:398:7d4a:c2c5 with SMTP id adf61e73a8af0-398eca52535mr1641278637.20.1773382387685;
 Thu, 12 Mar 2026 23:13:07 -0700 (PDT)
Date: Fri, 13 Mar 2026 06:12:51 +0000
In-Reply-To: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773382364; l=2855;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=nUG7MbP2VMtZ/RqI1k3lVv6HlTa0rLwtPHHfG9+apaQ=; b=gIIAcTAoq+uh6ZLKHTYgkGSDsVcXa8Oje6UJiWgcGy3Vt15Tyj1DsgsgEZxls9Z0bpWC4urhr
 c83+zR3qU4jB7TwLhF6aLoFZOf67MMkSywGzRdj1slybgAxZUnFmyqS
X-Mailer: b4 0.14.3
Message-ID: <20260313-gmem-inplace-conversion-v3-12-5fc12a70ec89@google.com>
Subject: [PATCH RFC v3 12/43] KVM: Let userspace disable per-VM mem
 attributes, enable per-gmem attributes
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

Make vm_memory_attributes a module parameter so that userspace can disable
the use of memory attributes on the VM level.

To avoid inconsistencies in the way memory attributes are tracked in KVM
and guest_memfd, the vm_memory_attributes module_param is made
read-only (0444).

Make CONFIG_KVM_VM_MEMORY_ATTRIBUTES selectable, only for (CoCo) VM types
that might use vm_memory_attributes.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 arch/x86/kvm/Kconfig | 13 +++++++++----
 virt/kvm/kvm_main.c  |  1 +
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index b6d65ee664d0f..8b97d341bd33f 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -82,13 +82,20 @@ config KVM_WERROR
 
 config KVM_VM_MEMORY_ATTRIBUTES
 	select KVM_MEMORY_ATTRIBUTES
-	bool
+	depends on KVM_SW_PROTECTED_VM || KVM_INTEL_TDX || KVM_AMD_SEV
+	bool "Enable per-VM memory attributes (for CoCo VMs)"
+	help
+	  Enable support for per-VM memory attributes, which are deprecated in
+	  favor of tracking memory attributes in guest_memfd.  Select this if
+	  you need to run CoCo VMs using a VMM that doesn't support guest_memfd
+	  memory attributes.
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
@@ -139,7 +146,6 @@ config KVM_INTEL_TDX
 	bool "Intel Trust Domain Extensions (TDX) support"
 	default y
 	depends on INTEL_TDX_HOST
-	select KVM_VM_MEMORY_ATTRIBUTES
 	select HAVE_KVM_ARCH_GMEM_POPULATE
 	help
 	  Provides support for launching Intel Trust Domain Extensions (TDX)
@@ -163,7 +169,6 @@ config KVM_AMD_SEV
 	depends on KVM_AMD && X86_64
 	depends on CRYPTO_DEV_SP_PSP && !(KVM_AMD=y && CRYPTO_DEV_CCP_DD=m)
 	select ARCH_HAS_CC_PLATFORM
-	select KVM_VM_MEMORY_ATTRIBUTES
 	select HAVE_KVM_ARCH_GMEM_PREPARE
 	select HAVE_KVM_ARCH_GMEM_INVALIDATE
 	select HAVE_KVM_ARCH_GMEM_POPULATE
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index b8f5ce3a33e27..9744d3a7fd917 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -105,6 +105,7 @@ module_param(allow_unsafe_mappings, bool, 0444);
 #ifdef CONFIG_KVM_MEMORY_ATTRIBUTES
 #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 bool vm_memory_attributes = true;
+module_param(vm_memory_attributes, bool, 0444);
 #endif
 DEFINE_STATIC_CALL_RET0(__kvm_get_memory_attributes, kvm_get_memory_attributes_t);
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(STATIC_CALL_KEY(__kvm_get_memory_attributes));

-- 
2.53.0.851.ga537e3e6e9-goog

