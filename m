Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95D722126C;
	Fri, 19 Jun 2026 00:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781829108; cv=none; b=m6BU1boVm6bRoExXxcDhkRa8TcO/QdM1PFueYOm+52s5TXQ3JRUOrEL9sctgHBu07H2dinhLU0BJxjAL6ZQXwfiDlCLBSgFAXdk1KJXe9KbmVx1qzJdg512RoXS7A3en2X11cGLOqlZ5QSk+CLIROxMsWHVIp1JAFy4HTlId0aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781829108; c=relaxed/simple;
	bh=0H2IgUs4dzVuCzjrH58X/cGXGyAD1oZYLqxV+FhozK0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BWrrhGiGxD+VoFt8S7Ftkx/4jNWkmZnINVthpk1ai7V5Pl1FYhJ+r+cBL55jySPFJhvDEK01s557CbYCeFAV14+HYb2FI54z0RtJKoYQRe2hJSZRvelcLuKf8qWhKSsfZ5M2PpQ0ZPVvAdhGUnbhFU5aa5rDxWsi325ObOlwWeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQ8+Sr/4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQ8+Sr/4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 757D4C4DE13;
	Fri, 19 Jun 2026 00:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781829107;
	bh=0H2IgUs4dzVuCzjrH58X/cGXGyAD1oZYLqxV+FhozK0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UQ8+Sr/4zjoDRjzngdzG+gtJ/Lw3UMYE+bD4PvXcNhxrUWdom4NYXl1FsewAJlomQ
	 jO5O50TozuER7C5k837zaleXt6t/z2YLcKFtI8d8wARE++jPZDpvMKxirvdhKD+x+1
	 jWxoBAZ/97yo3sV0B6DnucD4LnwyQu1nxPgO2QSm6hRc+4CLl2DJspZHyvhUMOoed7
	 ABe1WaS2sWYfpjiSUr5b+Y9Eo0J1ECJngHQBTyVys3pJiGeTSrrZ98qVCx2xxzwopN
	 U6UVESkCiBrwi+a0cHBWlV6CfDDJvI9qM61ALWnHGUpNyqnmHaQiqmtPHogkTlPVJg
	 gWqW/fF/plK2w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68400CD98FA;
	Fri, 19 Jun 2026 00:31:47 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Thu, 18 Jun 2026 17:31:45 -0700
Subject: [PATCH v8 08/46] KVM: Provide generic interface for checking
 memory private/shared status
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-gmem-inplace-conversion-v8-8-9d2959357853@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781829104; l=2977;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=r3yEEx41b7aixiqjjkGloSiqCgEFBbHdxuv0LadMDeU=;
 b=xTEebEXKr9XNrY/4ClqfxpuFQfAULsVn5D/QsFNVlsoF8ytkLlqq/u9gEsk/jwR8B7+W/Cpf+
 L3vkBV+fRWvDMKig52v8OLurUuaCFzAdR6qPRXMtWgqncjfEOV0c6zv
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Sean Christopherson <seanjc@google.com>

Introduce a generic kvm_mem_is_private() interface using a static call to
determine if a GFN is private. This allows the implementation for checking
a GFN's private/shared status to be set at runtime.

In preparation for choosing implementations between a guest_memfd lookup
and the existing VM attribute lookup, rename the existing
VM-attribute-based check to kvm_vm_mem_is_private to emphasize that it
looks up VM attributes.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_host.h | 12 +++++++++++-
 virt/kvm/kvm_main.c      | 15 +++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index eb26d4ea8945a..3915da2a61778 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2546,7 +2546,7 @@ bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
 bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
 					 struct kvm_gfn_range *range);
 
-static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
+static inline bool kvm_vm_mem_is_private(struct kvm *kvm, gfn_t gfn)
 {
 	return kvm_get_vm_memory_attributes(kvm, gfn) & KVM_MEMORY_ATTRIBUTE_PRIVATE;
 }
@@ -2557,6 +2557,16 @@ static inline bool kvm_mem_range_is_private(struct kvm *kvm, gfn_t start,
 						  KVM_MEMORY_ATTRIBUTE_PRIVATE,
 						  KVM_MEMORY_ATTRIBUTE_PRIVATE);
 }
+#endif  /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
+
+#ifdef kvm_arch_has_private_mem
+typedef bool (kvm_mem_is_private_t)(struct kvm *kvm, gfn_t gfn);
+DECLARE_STATIC_CALL(__kvm_mem_is_private, kvm_mem_is_private_t);
+
+static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
+{
+	return static_call(__kvm_mem_is_private)(kvm, gfn);
+}
 #else
 static inline bool kvm_mem_is_private(struct kvm *kvm, gfn_t gfn)
 {
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 6669f1477013c..8b238e461b854 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2627,6 +2627,20 @@ static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
 }
 #endif /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
 
+#ifdef kvm_arch_has_private_mem
+DEFINE_STATIC_CALL_RET0(__kvm_mem_is_private, kvm_mem_is_private_t);
+EXPORT_STATIC_CALL_GPL(__kvm_mem_is_private);
+
+static void kvm_init_memory_attributes(void)
+{
+#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
+	static_call_update(__kvm_mem_is_private, kvm_vm_mem_is_private);
+#endif
+}
+#else
+static void kvm_init_memory_attributes(void) { }
+#endif
+
 struct kvm_memory_slot *gfn_to_memslot(struct kvm *kvm, gfn_t gfn)
 {
 	return __gfn_to_memslot(kvm_memslots(kvm), gfn);
@@ -6528,6 +6542,7 @@ int kvm_init(unsigned vcpu_size, unsigned vcpu_align, struct module *module)
 	kvm_preempt_ops.sched_in = kvm_sched_in;
 	kvm_preempt_ops.sched_out = kvm_sched_out;
 
+	kvm_init_memory_attributes();
 	kvm_init_debug();
 
 	r = kvm_vfio_ops_init();

-- 
2.55.0.rc0.738.g0c8ab3ebcc-goog


