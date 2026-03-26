Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1590C38F941
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 22:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563902; cv=none; b=hFckdIoqULI1QsnaotsoToyLOIvN0DDLLxodojPep4Gp5VhRihky56BZOX4evjHfgGLIoFnsnyO5rwlo9zHYrutYsV/PT2yhpHPtmqSsfRp5w3dntPffrUb+cSgzxR+L/XYNrZ+rP3mG5oG00LMRCClR31GKveW01pD7p8cGE4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563902; c=relaxed/simple;
	bh=tJ9dGCdGH+eMi1rzPnbXzIog9htm51QzhB2FZFrGK3o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FhtgjUojPK9T+RpRkJlx0Z4c6A+vH2fAI5H89t+3VzvL6uiHxUZGfmKCsJmwQj+0ZGcxM0TgFjhkBWBYJJj99mCXVeSDF39iLyLUNVPo1vWVrYwnBMPAIvf1Uh8baVwUDzdIXxgtClJkFdSWQoUFYm0irwOnktQDd5J2VXGiJ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FIMECDLR; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FIMECDLR"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82c8768a633so1553532b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 15:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774563899; x=1775168699; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ammt0BhOIyLXS2ULMUn5WewBTpBTKqlX10HzkZ/Adsk=;
        b=FIMECDLRohoy2njyqs9/MC3lpXOAMJR8Ssc/IW8vRi1msn4tQ7O980FXSYVP6P4WH4
         tRNttoWbOyfCtPtCx4TNItcjQZUrHG9ehph36SpZBqqZnl3+bEWOlaTpUaXbesMcLTIp
         HQIsvIrr/XuOEU6LkgRfblYBpRIVKSaMJdJwDNFeRwrjtbIazY1J0kehwHkscUSCOxSl
         evQ1rledcxzosklpE2LpZyQD6xFZD6qo4lPagh9dV0fSgT12J0mFivaSdK5a9x5CDWoV
         vmF7qHVGTEvUaE/4wOEPEDNW1+y/qcxlcLHxS3+yN/tfWVo0DvuXvFZ86alKcguzRF/9
         qq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774563899; x=1775168699;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ammt0BhOIyLXS2ULMUn5WewBTpBTKqlX10HzkZ/Adsk=;
        b=VVtNXPpHjP0oAHxBqoOhdMdBTbBI33hfCnd8rKdCa8ZOKHJU/tLh2C9r+dHO4XFpMp
         CGB6ZF1TXoDNAleewvvgWe5yPCupg5yhI6mTXTryQJLIukROUcapUmgjDFR028QYug/S
         COfLSDCmM8hdFi9LfX4Lo7sGKKwvweQMYWxdKfz+04jpCGUJkMapYmZvCBviGiZ8wvRy
         ASR9kdtOcsMGo1gCRwNf9/ps7MBsQZq33Lfqu8FrNsCIX/xEM7kizUyAfCvbHf0WoriH
         E1nYuZFXy2VAJz7lN5hkFOvJt1VZ+lJYYsmxu/maLcKG1FCZwfV+chyn+IRAQPeDg6nx
         WIVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWCoIllMA761J93FgJACB7bg0efZPmXZCq6AXDemZv6CS7a/KuTPD/V8FEcXFGBC3RQmTof5jfp9xek7rd04fRaYY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc0bo3aaZBsyJ7tfeZnJFeBc4M0JO2+2kKgldNgAD8XNoyhVa4
	N5HsjNLZyzrkk4wy+TSm9585aR9d1SmMgQdvYKTbe2H9S1Wg7BfqIW9TiOWnOyVYpMQQdFzvXAY
	hMH0UuNCoooB9KLuopEc8RrlhqA==
X-Received: from pfblh10.prod.google.com ([2002:a05:6a00:710a:b0:827:1713:6de8])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:909e:b0:829:86a5:d30a with SMTP id d2e1a72fcca58-82c95d3979fmr158458b3a.16.1774563899156;
 Thu, 26 Mar 2026 15:24:59 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:24:26 -0700
In-Reply-To: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774563861; l=2856;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=YkFqhRwEQZVyHiDJUj6H4E4tU4Wvsdzaj7skS/qkZuE=; b=fYqOIs0iI3/nAEboIQ/PrkKD3DqiKgh0ZKOH0/alwG+ByCa4bQDdDE7B7eewnHx+Vkr5yyN3L
 qYWooCrUe9JDhY0cerupGdZo3deYAs2/zlmrWXsG3XBYe8lS1/Lli9y
X-Mailer: b4 0.14.3
Message-ID: <20260326-gmem-inplace-conversion-v4-17-e202fe950ffd@google.com>
Subject: [PATCH RFC v4 17/44] KVM: Let userspace disable per-VM mem
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
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	Ackerley Tng <ackerleytng@google.com>
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
index 6607127eaaeed..05e203f5292be 100644
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
2.53.0.1018.g2bb0e51243-goog

