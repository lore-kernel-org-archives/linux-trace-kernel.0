Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D1B234964;
	Sat, 23 May 2026 00:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779495484; cv=none; b=lsRBqtPe20nbd2I5oolFhGxsXOlUgIgoKCJx1BE8WzDVyYLsAJ3E7Jo0fisvQBRnMnbcfuP1USPs0oe6u1ci5IKni05m0R24VukacHKEaHFAAIylgHlLXs+PSO4/DDarIrFZ3tlYrWZu3nNvvkS+DjCx9MrGmjORY5TxI22pd6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779495484; c=relaxed/simple;
	bh=c0f+CGKARYuIRsR6prxFYb9SX4wd15NRM9c4tz63uZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pOvR1qA00VzZQqSduf+6up3lpbN0ewf0TbMPGJGVS/klDUSRyiw0bGkqn7avY2VWy1S8/3aXGb/0+LlP+VHuz6gmX5Nx+iPsPlw0X/WEAdt+xWwZLCZ+w1Tcs6vpURn0Sk0yhF3uCFW1z1QKhmunO83b28nDPmwrcz/KLiFe20g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jChBftNo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jChBftNo"
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE531C2BCC6;
	Sat, 23 May 2026 00:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779495483;
	bh=c0f+CGKARYuIRsR6prxFYb9SX4wd15NRM9c4tz63uZ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jChBftNocnbeVk1l8w6INLZoXx3M3+na86bnCfPy/HoV/1qaXhw9nb59zky6lHjDL
	 nyGQnREhM9obkZ4H9Axn5y+mCh7tOEe8tMFNUhyHuGflJhrjWbVTpWppGtKlS14WqQ
	 cCDahlzUvrDCe63hqmALEaF7b5KK63HvN0vDU7Ys6pyWnf4JqNNOcXNqAcFC8i96jo
	 KS6iBGTYZQlYGBPfwJ9eXgxIqlQ7LsgPVmk9lkQW6PaH9ldCrFs22xcCXgjAjqX7mU
	 A/V6pTsBGl660p6SFTYVmcvL96y/6ELUjP81Jwtmr5zAlhEC/zC5yGxG0IsyQZx77a
	 XrH2/T7OKzhhg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE0DCD5BB3;
	Sat, 23 May 2026 00:18:03 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 22 May 2026 17:17:50 -0700
Subject: [PATCH v7 08/42] KVM: Move kvm_supported_mem_attributes() to
 kvm_host.h
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-gmem-inplace-conversion-v7-8-2f0fae496530@google.com>
References: <20260522-gmem-inplace-conversion-v7-0-2f0fae496530@google.com>
In-Reply-To: <20260522-gmem-inplace-conversion-v7-0-2f0fae496530@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779495480; l=1948;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=efw6NUHcHLRdRk3uPvWSSZaXmjqUPOR/HwNza8dJmHY=;
 b=B5lunaP9bPm36pOBF1WpXomZpQHYcSiiA3pF7kR7bYZ+1X60uYHWizr+JKmDOu0UPCYEqw5j/
 qRmSJ+EXwocBeQEXU4B9jDFBeR7D4lyVv3+zIN3h3yBNjoSA6FXUDNq
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

Reviewed-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/kvm_host.h | 10 ++++++++++
 virt/kvm/kvm_main.c      | 10 ----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 3039b291e4b09..b67e7b308d280 100644
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
2.54.0.794.g4f17f83d09-goog


