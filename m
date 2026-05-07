Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061DF49550D;
	Thu,  7 May 2026 20:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778185371; cv=none; b=VtwqbzvGBOdLMw8iKQ2G9wF6SWi2rW9PXSZDgo/KoNp4AXs6tvHKu8ea82xx492kwOrSZ2J1mH5S9b0npsT/RGd9GBU3NJBk6vFHxNxcYPOM8R9W4GxAA7atGOsbu7NSUuovdt1PtrIs1y4of2ISgBcqwVy3ILRX5PgEEPYWnCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778185371; c=relaxed/simple;
	bh=3Ey26oHjBIStPVcofdxUBpg3KGMQjwyU1xBvE1HXR/Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R5cq4JCEePXDgxkz9aXLhBBV7woNIg9V7eDPL/JqwYUQZtJD2phS0UzERoucyXc/T0hCWY48qGjluXfRsmmwO4oOegU44ocYPVcxjMCSCICfX9jHTHvfynySwMkp1Yh5rQPUYa9psFSAKBfTRRdP2Gi3iygvcVj62LFJkI/D/I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gb8C1jBY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gb8C1jBY"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB8E5C2BCC9;
	Thu,  7 May 2026 20:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778185370;
	bh=3Ey26oHjBIStPVcofdxUBpg3KGMQjwyU1xBvE1HXR/Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Gb8C1jBYrCcNvhb+cC1N2B8UsClY2LEckLli6WjImjD7JLxImOdt/tzEeXaoYJ3vd
	 UoY8Ye38gRR9xsueOz+cDl8Xf39TGdOunMk0DLffLVE9kbsZJ18JoP2sP6yHrR9Pvg
	 qBk4CgMgHiHQqACWNkgx8hnhG39raA71JAUyBQn0StNJSCHfNSmd2+3tx/4G0C+KHc
	 4j4cZFwWoav4xnUEpo+OElX1V/sNKlX07Ruw75xjrx4U4rpjUFJ5b8fZQM+VwkMlo7
	 XKGKUdkfYUztVreqQIw5A0QYmJ1L2whVj+LuEgBlQm9sXJX3hs9fVh7hZ+gYXlpy9F
	 3AyC/D1kzp/oQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC027CD3446;
	Thu,  7 May 2026 20:22:50 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Thu, 07 May 2026 13:22:38 -0700
Subject: [PATCH v6 19/43] KVM: Let userspace disable per-VM mem attributes,
 enable per-gmem attributes
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-gmem-inplace-conversion-v6-19-91ab5a8b19a4@google.com>
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com>
In-Reply-To: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
 brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
 ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
 michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
 qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
 shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
 willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
 forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
 aneesh.kumar@kernel.org, liam@infradead.org, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Youngjun Park <youngjun.park@lge.com>, Qi Zheng <qi.zheng@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
 linux-coco@lists.linux.dev, Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778185365; l=2855;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=C+ZXwAuQ/e98Rs7Di9G1EWrlq6zteRCZz2vi1AClkpI=;
 b=dp6jCn9ExgjqByTG7kaxpBbRNBGPX7nuFMLB6FJJWILEhdvQnCRngdmKGdljRH2+yoCeSw4BK
 Y/wktRb6O2yBOVvPb6wUEdVPY4MaXo1fd0+4WQ5Hw96ejsK19n6u44i
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

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
index cec02d68d7039..ba195bb239aaa 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -104,6 +104,7 @@ module_param(allow_unsafe_mappings, bool, 0444);
 #ifdef CONFIG_KVM_MEMORY_ATTRIBUTES
 #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 bool vm_memory_attributes = true;
+module_param(vm_memory_attributes, bool, 0444);
 #endif
 DEFINE_STATIC_CALL_RET0(__kvm_get_memory_attributes, kvm_get_memory_attributes_t);
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(STATIC_CALL_KEY(__kvm_get_memory_attributes));

-- 
2.54.0.563.g4f69b47b94-goog


