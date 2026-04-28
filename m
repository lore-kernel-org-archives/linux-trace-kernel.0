Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4963939B0;
	Tue, 28 Apr 2026 23:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777418718; cv=none; b=OZQ4RZuTYzQ9Y0bhQnDkmcgIXYMXYmkcDUN374kwaj1GvNNIUALBFXUdrBcOh0tSI2F9qau06fbtnFAkpdZKZtvjaXIr68HaMedvv9LCU7Wac1PIh0RjJiwfC2vko2ly05y7CYHh1y89KJlfJipqHvWI59Rtl5JaWmIJ9nCuyfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777418718; c=relaxed/simple;
	bh=dtwLZrTCdtYF0WQJCPjTeRznnhw4wbsEzLijM5CfNpA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=clj038H83g0ntcQ9ON7w/wp88wvXeYV4N/Z2SRTrXszfqU9AwgW+2hx7JQUgrwBQ0u/77/nTVbTxbBY8U4aN4hhbfE3/VoBdM3ruRM0rairOCudkmE9BEq4WpurA9WtMr830+zlAXiBi4eQax+YARqmblMUPxX+s8Tlv0kNEE6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hhi6sSq1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hhi6sSq1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9F50C2BCC9;
	Tue, 28 Apr 2026 23:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777418717;
	bh=dtwLZrTCdtYF0WQJCPjTeRznnhw4wbsEzLijM5CfNpA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Hhi6sSq1dTusGbTEV5YXaLfYZWXv3/OHMw5TZG/7VvSV7Ar/4PfncrK2vpfuVEcve
	 ZoYDCVA37T6Yt7+e6R9eTFqE64ZGuY2+OmIKNEHTEQQGQmHCe6LTbM7YKe2sgZEdDx
	 iLEq810PQ8QLAAbRmTwHpDnE6KCK8DHHBufOOq4nMzxyzdxUWPQ8rrCw8wRkBbqZ0p
	 tSGfShtFGqOjOzjc+tugDVhSIwDe3uXfYpiSlmxNTQAuqqPhM+teGiHV80z0l+2iKL
	 KX/N2Lp2SlokUJrlT2cRYuDwYum/smf/C1UBxrLmXW7gvQQvkJiVratyMuCX4Y+8lo
	 GEx54JWp4lbew==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3DBFF887C;
	Tue, 28 Apr 2026 23:25:17 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Tue, 28 Apr 2026 16:25:04 -0700
Subject: [PATCH RFC v5 09/53] KVM: Move kvm_supported_mem_attributes() to
 kvm_host.h
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-gmem-inplace-conversion-v5-9-d8608ccfca22@google.com>
References: <20260428-gmem-inplace-conversion-v5-0-d8608ccfca22@google.com>
In-Reply-To: <20260428-gmem-inplace-conversion-v5-0-d8608ccfca22@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
 brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
 ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
 michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
 qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
 shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
 willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
 forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
 aneesh.kumar@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777418714; l=1904;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=KgLAU6noveUvf5fI6bj1R5BsJhhYvScuPPA/BlOKlOk=;
 b=k2Xf4rmjwdl/N8GqDeRUZeG+vf5oIPyQCq1XNAC4f6MtoL0TdhL4DVBhgoajGopGFq4FETryr
 jbKaEXhTk8cADW9GiGhS1xOa3Dxz4QcX3WkmF+6dbj+4WQxORlleMO8
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

Move kvm_supported_mem_attributes() from kvm_main.c to kvm_host.h and
make it a static inline function. This allows the helper to be used in
other parts of the KVM subsystem outside of kvm_main.c. This helper will be
used later by guest_memfd.

No functional change intended.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/kvm_host.h | 10 ++++++++++
 virt/kvm/kvm_main.c      | 10 ----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 1deab76dc0a2c..f9ea95e33d050 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2529,6 +2529,16 @@ static inline bool kvm_memslot_is_gmem_only(const struct kvm_memory_slot *slot)
 }
 
 #ifdef CONFIG_KVM_MEMORY_ATTRIBUTES
+static inline u64 kvm_supported_mem_attributes(struct kvm *kvm)
+{
+#ifdef kvm_arch_has_private_mem
+	if (!kvm || kvm_arch_has_private_mem(kvm))
+		return KVM_MEMORY_ATTRIBUTE_PRIVATE;
+#endif
+
+	return 0;
+}
+
 typedef unsigned long (kvm_get_memory_attributes_t)(struct kvm *kvm, gfn_t gfn);
 DECLARE_STATIC_CALL(__kvm_get_memory_attributes, kvm_get_memory_attributes_t);
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 0a4024948711a..ff20e63143642 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2428,16 +2428,6 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
 #endif /* CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT */
 
 #ifdef CONFIG_KVM_MEMORY_ATTRIBUTES
-static u64 kvm_supported_mem_attributes(struct kvm *kvm)
-{
-#ifdef kvm_arch_has_private_mem
-	if (!kvm || kvm_arch_has_private_mem(kvm))
-		return KVM_MEMORY_ATTRIBUTE_PRIVATE;
-#endif
-
-	return 0;
-}
-
 #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 static unsigned long kvm_get_vm_memory_attributes(struct kvm *kvm, gfn_t gfn)
 {

-- 
2.54.0.545.g6539524ca2-goog


