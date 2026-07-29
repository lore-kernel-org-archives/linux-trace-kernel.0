Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5972F8E8A;
	Wed, 29 Jul 2026 00:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785285309; cv=none; b=ochU9Urro0pIfUYbKuQycJSZCYZs7aPt6mE2JQVBXimNHOjfX3Om7aD41Nu79u5LKk++wkYZSrnJ0Hht5EFBQJIxL78Hy/bOhVYljiyhMZZ2ahQX0d3FmXFsTGM0EAXtHnXkphZFrfK7KNcVJbyFWAy6Znp9WBz1nmKNCwRa9T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785285309; c=relaxed/simple;
	bh=52/0Vt0dpEJnwhXlNQX3zcqGfpEYR+Me2/DktYpv8cM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qjuw57kZsYclHZpyL1TCIAmIRPkbO2Cyurtf5AdKIoi0xElTXjKnjLEGIjkCRwavhxz+9pGbe5MFVXc0FqHRx8q1efNlQzReuTi8jR/CmJTMinHE5bf2zEYPPSgAv+RFB6B1liJE0N2Rj4BOQGi15zFGh33sR8yMoGKC1IjtDyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPVjul0X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPVjul0X"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D447C4DE12;
	Wed, 29 Jul 2026 00:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785285309;
	bh=52/0Vt0dpEJnwhXlNQX3zcqGfpEYR+Me2/DktYpv8cM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UPVjul0XnKVXb0w0p/8nBc3nmi0afcCo+9Fca4oumSzLg6LfYd3rvmTl7TsPRUyqe
	 WInJVuT4kRktwFp+2dE+fVC9BIz17PWvegt47oxdB8NhJRdFVtHTCewXDxdJocYNqB
	 JxOUnDTIUKeHhO4jlnZUaCjT8fz3tCx9WiHSRGsg1dNUPet+OKQyXW4P/wDkio/+nS
	 DeU6qxzc8lBVUScfCszuEr1Gf3DOpW8ETfRgrCSQUfzYqo5xSvDFpIX+7d2q0HicRr
	 4GTGWSNuQjEh4/m6eu/yxlp7GO07aDFA8GM8offjBlVbKJtw7Or0LMlESkSdaXKUOj
	 nebQEmOdh7fpg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DBDC54F52;
	Wed, 29 Jul 2026 00:35:09 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Tue, 28 Jul 2026 17:35:20 -0700
Subject: [PATCH v9 21/41] KVM: guest_memfd: Enable INIT_SHARED on
 guest_memfd for x86 Coco VMs
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-gmem-inplace-conversion-v9-21-35f9aec2aed2@google.com>
References: <20260728-gmem-inplace-conversion-v9-0-35f9aec2aed2@google.com>
In-Reply-To: <20260728-gmem-inplace-conversion-v9-0-35f9aec2aed2@google.com>
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
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Vlastimil Babka <vbabka@kernel.org>, Baoquan He <baoquan.he@linux.dev>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
 linux-coco@lists.linux.dev, Ackerley Tng <ackerleytng@google.com>, 
 Xiaoyao Li <xiaoyao.li@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785285305; l=1641;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=xqYH05bSCEd1Bk1hXIslSXCmEIZh87KnzlPOeglC0VM=;
 b=bL9eALDZa5rrVw3e+oDoxAYk2lxBzN9/H13NtfJOfT/y/F4v9X0ogrXYkcZ82AmmYuS5rPP89
 NZtt7tORv17DBB8S6dcZfZB7MvYLXrBe7t6xg7XcoiTHiOvXZz1Okf1
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
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Tested-by: Shivank Garg <shivankg@amd.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 arch/x86/kvm/x86.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 52de3ec7c7f73..79538dedfad68 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10623,14 +10623,15 @@ bool kvm_arch_no_poll(struct kvm_vcpu *vcpu)
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
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_CONVERT

-- 
2.55.0.508.g3f0d502094-goog


