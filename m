Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44C738F24C;
	Tue, 28 Apr 2026 23:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777418717; cv=none; b=d6QPqousSIWnXDiQzIulqz/4YEQ8sxhpZn+k3dQ3rBJMI+rsF2P3hpT5S/9HBxFi+w8geUuwIn5z0ReWCOilpEqM+KAqALPyp3CFlKjtlcesyfMOLvxrBXdHcJ/vlHAB9Ri6bckZxDEDBi64WK4o9wXRXAFxB/p57K31BmBxgoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777418717; c=relaxed/simple;
	bh=AaF4HXGpP5WD6rmFOZxYKszkVonAtOtfufgz8/0EJFA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WoEYyLHWnUUWnhYYJU9nXJA9UdFVebqksomGspIQ+CjQAMgaJZYDVaPsS88Zu4kdHPOvyOjJwCkielXrln7PlIs62pT+VOfFB46uE/OmUoPIYzDnC6jYq5QfITtv6KxiQC3JmFT7jCjEO+M4vjO9OQ0Llfb3FMjhf0BHCzwLsYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TECxRH7d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TECxRH7d"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42006C2BCF7;
	Tue, 28 Apr 2026 23:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777418717;
	bh=AaF4HXGpP5WD6rmFOZxYKszkVonAtOtfufgz8/0EJFA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TECxRH7dkgEkaATJlrzxU+2UYhlBdNl/WGlDIixmHZcnS8qBtEDP6PBsEsTstWAef
	 0mDThIVLhAV5LRd5Qs/zPWXSjzd2Gx4yN9N92LxjrZMVO+rmGR8LHYawy074RML1dI
	 LFxn6Tej0APPQFGIBkAzy9vMIj7gNOAuB6VMjtHpDr41KZlu2s7iI9YNZyaC0lcBiH
	 +rX0bpCw5uGqLqE5S3baeoDoLH9M6HmAAJpduMPK+IE3wGPdW2ut28fG+/hOJ/Kt9r
	 On2BCWmtd4jRB13UFPwUTkBdoB87ePxZUfhltla4Z5eb0yceTzcjwD03qTi4UEvAkF
	 PTO9yweGJ1rrw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371B8FF8879;
	Tue, 28 Apr 2026 23:25:17 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Tue, 28 Apr 2026 16:24:58 -0700
Subject: [PATCH RFC v5 03/53] KVM: Enumerate support for PRIVATE memory iff
 kvm_arch_has_private_mem is defined
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-gmem-inplace-conversion-v5-3-d8608ccfca22@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777418714; l=1791;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=Wv0T7BRlY/etY57IYCmbdP7OGNUJqEfLohRwRHtaZTY=;
 b=XT8IsQV/NcpbmHXja8QsL7lhxDNOK+DGwKds9n4+pmWqIZ673ExEPONdT11cUL0EYvx+PL3C0
 7Po5/EMzQ5vCB4FICf7wMtQLA6KQ9zUFzGAb+XhGvBwk+v+doKObl2s
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

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
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/linux/kvm_host.h | 2 +-
 virt/kvm/kvm_main.c      | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 7b9faa3545300..7d079f9701346 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -722,7 +722,7 @@ static inline int kvm_arch_vcpu_memslots_id(struct kvm_vcpu *vcpu)
 }
 #endif
 
-#ifndef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
+#ifndef kvm_arch_has_private_mem
 static inline bool kvm_arch_has_private_mem(struct kvm *kvm)
 {
 	return false;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 306153abbafa5..abb9cfa3eb04d 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2421,8 +2421,10 @@ static int kvm_vm_ioctl_clear_dirty_log(struct kvm *kvm,
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
2.54.0.545.g6539524ca2-goog


