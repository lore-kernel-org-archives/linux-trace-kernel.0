Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A6427B4F7;
	Fri, 19 Jun 2026 00:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781829109; cv=none; b=L0/zlsaXgh+L3UoyhKc3Fk8SmlB4l4NLOegixL/Tm55PnlayLTxZIpQsF3apS0oh3o5U9GugUxdqV8JtaLxP0ICbR2g15Vm0t2FKtpZEldNGVB/8RQWxeRj5DJsvNjivMZIt8ESf1iZ55le2p2VAjgUXMFRhu9iGQwsRpy/EOWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781829109; c=relaxed/simple;
	bh=fyOOtYfClGp09cjDKzYjVc3evf/urOJQVD3GzH69oRM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eLAkouAKirtQ6oogfshfimNfQMkArzAaJ7GV9N5H9Uw0G7885hrj0/tw6hxzVmVCIvhSf2suDMypEAe6UQpRncrCwZ7hXWD7LRM2hwPtOLz7Zjs+5vnIZIZq9yitHuYH+d4fzzMSaWkmK1uW4Y923AwSzbmrtG7Hg0SEXALlPTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPlGqjqD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPlGqjqD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36DB5C2BCC7;
	Fri, 19 Jun 2026 00:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781829109;
	bh=fyOOtYfClGp09cjDKzYjVc3evf/urOJQVD3GzH69oRM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TPlGqjqDI/PMYxZn5xjOYwF7kCayjYwZzXjWtCvfQBBsR+o5aBUNHa8P0RtkelR5T
	 njG+iVbj5faKb06+4r5OgWAOaejxWytg8snWVAne03bxp+tLpRNRbCkYcBO6+JsB4b
	 sx7FYlXH22R/CcVl5HD0FQgB+iOmSfzyAri9iokTLLktlf53uFwjduL5zrqwUFQGHZ
	 DKf+tLgO0pNo/7Ef7mzlJu/YwiGdvp0ZdPac4shTpWs6ZrelZeV5MOqOcum8XHGTio
	 tX4UAG/oOSaEcDt409fdpNxFbxRA8VISikCTBNlkcyQEta3GyXkaMr5wuWQTEe7vrv
	 /1UoZpXReqNmQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1FDCD98FE;
	Fri, 19 Jun 2026 00:31:49 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Thu, 18 Jun 2026 17:32:01 -0700
Subject: [PATCH v8 24/46] KVM: guest_memfd: Make in-place conversion the
 default
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-gmem-inplace-conversion-v8-24-9d2959357853@google.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
 brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
 jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
 oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
 rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
 steven.price@arm.com, tabba@google.com, willy@infradead.org, 
 wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
 pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
 liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, 
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
 Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, 
 Baoquan He <baoquan.he@linux.dev>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
 linux-coco@lists.linux.dev, Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781829104; l=3290;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=PRIZz/MUEDcYpJgxuI5DJhHZ5hfaG9jP2sr46JVINBY=;
 b=RxWU2Nn3vTjbe31iLWemaFC4u3fW67LS6mTsCASZGW43syFeZcJruijQ/SaPumweB4lztWXkR
 KKo4Y/vgPRQCh4wCRuGDPhwjndAdVzR8opSq/5IR4MMrz5c5YObQXT4
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

Make in-place conversion the default if the arch has private mem.

The default can be overridden at compile type by enabling
CONFIG_KVM_VM_MEMORY_ATTRIBUTES, or at KVM load time through a module
parameter.

In-place conversion also implies tracking a guest's private/shared state in
guest_memfd. To avoid inconsistencies in the way memory attributes are
tracked between the per-VM or by guest_memfd, make the module_param
read-only (0444).

Document that using per-VM attributes for tracking private/shared state of
guest memory is deprecated in favor of tracking in guest_memfd.

Warn if the admin sets gmem_in_place_conversion as false when
CONFIG_KVM_VM_MEMORY_ATTRIBUTES is not enabled. Add warning in the code
path where guest memory is populated for a CoCo VM, since that's the
earliest point in a CoCo VM's lifecycle where memory attributes are
queried. Unlike other query sites, this site is exclusively used by CoCo
VMs.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/Kconfig   | 7 ++++++-
 virt/kvm/guest_memfd.c | 5 +++++
 virt/kvm/kvm_main.c    | 3 ++-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index c28393dc664eb..a3c189d765150 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -85,7 +85,12 @@ config KVM_VM_MEMORY_ATTRIBUTES
 	bool "Enable per-VM PRIVATE vs. SHARED attributes (for CoCo VMs)"
 	help
 	  Enable support for tracking PRIVATE vs. SHARED memory using per-VM
-	  memory attributes.
+	  memory attributes.  Using per-VM attributes are deprecated in favor
+	  of tracking PRIVATE state in guest_memfd.  Select this if you need
+	  to run CoCo VMs using a VMM that doesn't support guest_memfd memory
+	  attributes.
+
+	  If unsure, say N.
 
 config KVM_SW_PROTECTED_VM
 	bool "Enable support for KVM software-protected VMs"
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 86c9f5b0863cb..5cb73543c03c8 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -1193,10 +1193,15 @@ static bool kvm_gmem_range_is_private(struct file *file, pgoff_t index,
 {
 	struct maple_tree *mt = &GMEM_I(file_inode(file))->attributes;
 
+#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 	if (!gmem_in_place_conversion)
 		return kvm_range_has_vm_memory_attributes(kvm, gfn, gfn + nr_pages,
 							  KVM_MEMORY_ATTRIBUTE_PRIVATE,
 							  KVM_MEMORY_ATTRIBUTE_PRIVATE);
+#else
+	if (WARN_ON_ONCE(!gmem_in_place_conversion))
+		return false;
+#endif
 
 	return kvm_gmem_range_has_attributes(mt, index, nr_pages,
 					     KVM_MEMORY_ATTRIBUTE_PRIVATE);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index dd1d18a1d2f68..46e92b5dc3804 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -102,7 +102,8 @@ static bool __ro_after_init allow_unsafe_mappings;
 module_param(allow_unsafe_mappings, bool, 0444);
 
 #ifdef kvm_arch_has_private_mem
-bool __ro_after_init gmem_in_place_conversion = false;
+bool __ro_after_init gmem_in_place_conversion = !IS_ENABLED(CONFIG_KVM_VM_MEMORY_ATTRIBUTES);
+module_param(gmem_in_place_conversion, bool, 0444);
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(gmem_in_place_conversion);
 #endif
 

-- 
2.55.0.rc0.738.g0c8ab3ebcc-goog


