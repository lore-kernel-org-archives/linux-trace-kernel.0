Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFE13A4527;
	Tue, 28 Apr 2026 23:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777418719; cv=none; b=Ck/n2aC+T4D/LGxDohgL1fEtJhHubFGP+OA9DgCYg+nZVGEgBsPlDL5GUXNR2B/UJfDGPHp/0+oWRgTxZQUdjOTiLu+IMq5wOWeIQoYE3IFPPbCHD7DmVH9VJGd0hnCVUCRsWfc5WegdPY2FTRbhzqIZiqF1/p1gcBxRK31Nvtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777418719; c=relaxed/simple;
	bh=W95IiIrObMcGrhAhPOa1Lzdp+cLl7f0y7x5Z4Hm0jDM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bcht6QIghu11XoiK+1rRvccKpADha0BNKRXnzrFd5kC/9F+iyS/SZe7EeCPoTs9gA83ebrFpnPzxJU24hzp7O7OpYZfPWW+ujRa8bLv6mQ1XcJJidUyjhaOd6IvSSsKDPoUnNqrlYG+HaE5ibI9O90g3ht6/Zsl0RBNq0EDSiNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tuXGvioN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tuXGvioN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B95CC2BD05;
	Tue, 28 Apr 2026 23:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777418719;
	bh=W95IiIrObMcGrhAhPOa1Lzdp+cLl7f0y7x5Z4Hm0jDM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tuXGvioN52WoQt0JOaZJgEyfTYb1wwe1yCUqqeHib62/xvuhEUZ31BqZd44hMhToV
	 6qOrYvQ80z8gHDqsw/freo5a0rQPhmRRZL7wi6NXmfLlO8INMI9TgZSE01FxocsyZh
	 PdgbAqT9LB5AnA4k4rD9AwQcSBbDqJjqxKre+9vst80kxdHbSo9NR4JQVKjpz5/8tu
	 2ZXKwuurxDjsN6bKzHA0WGJAkjcLNVMY+jUQtW1zzPQ9WfgFctAiHu4tjULtMbefBV
	 0erieBB/MVon+2fFpzaSFknk4l6nJhG1DfdxKJmh9IL+obK+cgZZOs2M8Qbq6+2YEa
	 AgDMxdyHPupvw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727BAFF8875;
	Tue, 28 Apr 2026 23:25:19 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Tue, 28 Apr 2026 16:25:22 -0700
Subject: [PATCH RFC v5 27/53] KVM: x86: Bug CoCo VM on page fault before
 finalizing
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-gmem-inplace-conversion-v5-27-d8608ccfca22@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777418714; l=1213;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=tiTenJm2569v5eEA4Z7Xk+parAwNdRT4spl4m/ukMSc=;
 b=Ddok4n3bkINYasSG44K3iwGimZ3Lx7mZtFodZ99SfqY6+rmIB6rUmN3BUBBQoCmaMltcVCYvA
 9LeCHnRTzRhCqSGRL1TQUNOKoyvJhWw8WcEOLkkGetGbfg7UvhxOVAp
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

In-place conversion of guest_memfd memory to private is allowed with the
PRESERVE flag to enable populating guest memory only before CoCo VMs are
finalized.

Allowing CoCo VMs to fault memory could mess up memory contents. Hence, as
a second layer check, bug CoCo VMs if they try to fault in memory from
guest_memfd before the VMs are finalized.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index d3da387340a9d..8c5a3d2a7470b 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4599,6 +4599,13 @@ static int kvm_mmu_faultin_pfn_gmem(struct kvm_vcpu *vcpu,
 		return -EFAULT;
 	}
 
+	/* Cannot fault from guest_memfd before CoCo VM is finalized. */
+	if (KVM_BUG_ON(vcpu->kvm->arch.has_protected_state &&
+			       !vcpu->kvm->arch.pre_fault_allowed,
+		       vcpu->kvm)) {
+		return -EFAULT;
+	}
+
 	r = kvm_gmem_get_pfn(vcpu->kvm, fault->slot, fault->gfn, &fault->pfn,
 			     &fault->refcounted_page, &max_order);
 	if (r) {

-- 
2.54.0.545.g6539524ca2-goog


