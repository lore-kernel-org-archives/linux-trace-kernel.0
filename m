Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915BE286881;
	Fri, 19 Jun 2026 00:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781829109; cv=none; b=eA+L4WYIimja5i3RLNpbe/0Ae2uz/9TB0ixWLQbwX9du8+FIMN3dv+dXzBRrUX9CUECH+XrndJ979PfRx+XU80eNM6Hmx5o61WORhvurLBt5ZOJ3KcXfxdukBiDSNztQsyVSAvGGYOfJhO1Z6WfuP+KkC3sqOG163B7Rj4niJXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781829109; c=relaxed/simple;
	bh=06Cmm6ZSLGzEQ2JoFTbuetSxgKF6eUVAuIaVVaESzyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LqT8wkVo6EYcowPJvkLZM7AVV5UV3y1VUVRFNfnNEGAARAqsinP9eXeRP6+pxm75Xt/qij0248wShGyL35TbJofxZtZ+CbbyNf9o7BAtCH7/F7YvTG9g9Mhy741woVXh5TLnkLCV8Ku0CmRFA2FnMjPZ1bUnKRnNHaKeUjLUzMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBHKb5w7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBHKb5w7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 649BBC2BCF6;
	Fri, 19 Jun 2026 00:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781829109;
	bh=06Cmm6ZSLGzEQ2JoFTbuetSxgKF6eUVAuIaVVaESzyY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DBHKb5w7mAb6WxW4rdHhJJopk9XYnPIsm7bvyJ/MocVumyEj+R0XblO9jzhP4+Czn
	 G+tXrezlavb9AeFH2TGtdk0mrdX4aIgoJIKzwYqIVBBwx5pc2jnUwR22YyCRLmZdb0
	 5cFSZrmh109Ih/tp+IbLP9s7/spJ/f7CKrLdiMZbctNsz2SSk822U0fwVhXDest0lj
	 9nf6QWlXBCSh/qhf5Npp+T7849kiEFMg7PZqryRs259ZIf9+LH1O+DvvqlmOscN479
	 LuK5Rfslxpi7/GTDVZbxBJcs+vBR+4fH8EDUaVpaT4Bvm3kQLZSn9rW8ggldnCAbKh
	 uo74MKjEK/6MQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C49CD98FA;
	Fri, 19 Jun 2026 00:31:49 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Thu, 18 Jun 2026 17:32:02 -0700
Subject: [PATCH v8 25/46] KVM: guest_memfd: Enable INIT_SHARED on
 guest_memfd for x86 Coco VMs
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-gmem-inplace-conversion-v8-25-9d2959357853@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781829104; l=1553;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=jzuj9zrl4qNuPFG8VNS4kO3hGida658cbqNcxlJaaaI=;
 b=pZ4fcSOhZu72mBX5CyHFKeu02FSiqennFh2LxM3kmpKV0MfpFcGGE0hZqpIFXdLwsMB3qy+P5
 IMDWN8ve9rUBaMz64S0aMs25PfZyWw3I5wDY3CCgG+CuQGOPU5+pPjE
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Sean Christopherson <seanjc@google.com>

Now that guest_memfd supports tracking private vs. shared within gmem
itself, allow userspace to specify INIT_SHARED on a guest_memfd instance
for x86 Confidential Computing (CoCo) VMs, so long as in-place conversion
is enabled, i.e. when it's actually possible for a guest_memfd instance to
contain shared memory.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 arch/x86/kvm/x86.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2fde594e86d72..57a543dadb851 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -14116,14 +14116,15 @@ bool kvm_arch_no_poll(struct kvm_vcpu *vcpu)
 }
 
 #ifdef CONFIG_KVM_GUEST_MEMFD
-/*
- * KVM doesn't yet support initializing guest_memfd memory as shared for VMs
- * with private memory (the private vs. shared tracking needs to be moved into
- * guest_memfd).
- */
 bool kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
 {
-	return !kvm_arch_has_private_mem(kvm);
+	/*
+	 * INIT_SHARED is supported if in-place conversion is enabled, or if
+	 * the VM doesn't support private memory.  If the VM has private memory
+	 * and in-place conversion is disabled, then guest_memfd can _only_ be
+	 * used for private memory.
+	 */
+	return gmem_in_place_conversion || !kvm_arch_has_private_mem(kvm);
 }
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE

-- 
2.55.0.rc0.738.g0c8ab3ebcc-goog


