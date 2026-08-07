Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A4B46EC84;
	Fri,  7 Aug 2026 21:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786139569; cv=none; b=TvpWKd2A1fMevp7/Ur5TmnPlWL7G1ZSsjpkvGeCUQsYoXSGyuuX0vcCVGuZPK5uPZ/2XdbcwR3dw/dq2y9LtEpoppcgYlOSJ3i5UlyZUWqt3qJjfafDFVl2OSLpfyCV+XX+8rH3fk0mT+boyyH+JFbWaoW9cLhmyMefAwoyGZaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786139569; c=relaxed/simple;
	bh=H5Oy0gF2fAL2oTAVvZmzLgNPhktjGp2oky/braofGkA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LNE3NQkbJX+aHw1p+ML47lAS4xkMf9rKmfIcKRKmvAPhjaYfsw2WyepApR/ig6EfYyCUNsJ2RJL2UyI7tfM1uAVIzs1/atkWnjLT+UJZiKg6xBxdq5SQ7noDOLMJgWBYjt6v9BbaM+z7L2vsGCGDhQdjCbQwFOte/P/DVOgCYq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqYM4m6F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqYM4m6F"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6CF14C32781;
	Fri,  7 Aug 2026 21:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786139569;
	bh=H5Oy0gF2fAL2oTAVvZmzLgNPhktjGp2oky/braofGkA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sqYM4m6FxYF0P6oVPLzdGLuGff4ig1Gl0Zs7QsSaLdgcPpZ0/4+O+cHbZktVlgCXh
	 YvXIKPA/9wd340dbwouV0s/Gln3ySLW5l2R2XuMo91XM/pM3w9XA+68Fn/8r61yp38
	 BjfVqkWLfKfGsKj1TD5hbn03QcmsrIt6lrqqAHFfwZw06SIatN2LprjtW/KZQh4KlY
	 4e4AAHTRlqLfp8qG+kSywvi7wNd3jRz1xcEMuKEvy4eYplOo1t9azVlfz+Eiig3zzy
	 nCIq4NZwRYlHwARtKQ/3Zooy+kvuP9xngxNB5f5SvGbg06aN/C7A5IR7lqpF5c8ZVM
	 b1Hqi1Gx7wj6w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524BAC5ACD1;
	Fri,  7 Aug 2026 21:52:49 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 07 Aug 2026 14:52:57 -0700
Subject: [PATCH v10 18/41] KVM: TDX: Make source page optional for
 KVM_TDX_INIT_MEM_REGION
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-gmem-inplace-conversion-v10-18-2fc18ee6d3ba@google.com>
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
In-Reply-To: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
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
 Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
 Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, 
 Baoquan He <baoquan.he@linux.dev>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
 linux-coco@lists.linux.dev, Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786139565; l=3323;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=fww/oL6aOL/zYOalPjjTEuFSWzNlNDgN26Nz/nDPoIw=;
 b=UsF5OWRfMfq1ob58hfueI4ABe8ND/ASl9ukTcTiCBDkuD3ck+A8QWQy8R4fap+euJOj80T6tM
 Dq4X1R9/FqCAxtgtlm6ZxM6W3dkxnpeNt8vBhyquk2Og3YAcaafiCzE
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

Update tdx_gmem_post_populate() to handle cases where userspace requests
"no source page". To handle "no source page", populate (perform
TDH.MEM.PAGE.ADD) using memory in-place at the target PFN.

Allow "no source page" only when gmem_in_place_conversion is enabled,
because retroactively adding support for out-of-place conversion would mean
requiring a userspace update for a feature that's being deprecated.

Also, KVM supporting "no source page" without in-place conversion would
effectively be an obscure zero-page optimization that relies on the page
being zeroed when it is allocated by guest_memfd.

Rejecting "no source page" without in-place conversion scenario is valuable
for KVM developers since it helps newcomers understand what exactly is and
isn't possible.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Tested-by: Shivank Garg <shivankg@amd.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 Documentation/virt/kvm/x86/intel-tdx.rst | 4 ++++
 arch/x86/kvm/vmx/tdx.c                   | 8 +++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/virt/kvm/x86/intel-tdx.rst b/Documentation/virt/kvm/x86/intel-tdx.rst
index 6a222e9d09541..d8d9409120e61 100644
--- a/Documentation/virt/kvm/x86/intel-tdx.rst
+++ b/Documentation/virt/kvm/x86/intel-tdx.rst
@@ -158,6 +158,10 @@ KVM_TDX_INIT_MEM_REGION
 Initialize @nr_pages TDX guest private memory starting from @gpa with userspace
 provided data from @source_addr. @source_addr must be PAGE_SIZE-aligned.
 
+If guest_memfd in-place conversion is enabled, pass 0 for @source_addr
+to represent "no source page". A source page is required if in-place
+conversion is not enabled or not supported.
+
 Note, before calling this sub command, memory attribute of the range
 [gpa, gpa + nr_pages] needs to be private.  Userspace can use
 KVM_SET_MEMORY_ATTRIBUTES to set the attribute.
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index b272c20586a74..7654a9f5fa128 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -3189,7 +3189,7 @@ static int tdx_gmem_post_populate(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn,
 	if (KVM_BUG_ON(kvm_tdx->page_add_src, kvm))
 		return -EIO;
 
-	kvm_tdx->page_add_src = src_page;
+	kvm_tdx->page_add_src = src_page ?: pfn_to_page(pfn);
 	ret = kvm_tdp_mmu_map_private_pfn(arg->vcpu, gfn, pfn);
 	kvm_tdx->page_add_src = NULL;
 
@@ -3235,7 +3235,8 @@ static int tdx_vcpu_init_mem_region(struct kvm_vcpu *vcpu, struct kvm_tdx_cmd *c
 	if (copy_from_user(&region, u64_to_user_ptr(cmd->data), sizeof(region)))
 		return -EFAULT;
 
-	if (!PAGE_ALIGNED(region.source_addr) || !region.source_addr ||
+	if (!PAGE_ALIGNED(region.source_addr) ||
+	    (!gmem_in_place_conversion && !region.source_addr) ||
 	    !PAGE_ALIGNED(region.gpa) || !region.nr_pages ||
 	    region.gpa + (region.nr_pages << PAGE_SHIFT) <= region.gpa ||
 	    !vt_is_tdx_private_gpa(kvm, region.gpa) ||
@@ -3266,7 +3267,8 @@ static int tdx_vcpu_init_mem_region(struct kvm_vcpu *vcpu, struct kvm_tdx_cmd *c
 			break;
 		}
 
-		region.source_addr += PAGE_SIZE;
+		if (region.source_addr)
+			region.source_addr += PAGE_SIZE;
 		region.gpa += PAGE_SIZE;
 		region.nr_pages--;
 

-- 
2.55.0.654.g21b8a5bc05-goog


