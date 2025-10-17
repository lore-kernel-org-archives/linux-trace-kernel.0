Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D24333737
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Oct 2025 20:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760731979; cv=none; b=ocjTsXfsegtkWFeWKIMUNvI7S9WL7y4iSd7HxNy1orS4WApgq3fvncfO/5N9H5fglVxnC8iAutULR832kuyEUMRhL3ZQh62LcfhuQIZ/Val0zoZ/BNgVdgXOvcXeabBVQSlZtaHSC8k0EDGSSnJDBA0K4gSqFApXk2RRRnObZ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760731979; c=relaxed/simple;
	bh=eIbxZrVN1pAWsN0RH46X0rZKRHOISLVxuCVUWKrhWp0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rC4+8SgGupSe3n85tUfaeyluAXQ4VWTXbBCbLInRjdoaQENAwdSDWUJcOQXdNmyVOv/Av6Kw5lKAf3aN0PtWspwFL2+m6ql8rlN3JLSzZJeGuHMt1x3Q30l+D1sz2xNmoHaOACae4ngRA4mjn3bXyjwA5r0R+RVsi4grspxLrW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4y2H2p0Q; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4y2H2p0Q"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33bbbb41a84so4082070a91.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760731974; x=1761336774; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aywn3p1OuroHc7cbdG3tEKHp3pq1LL6GKGiRpb5Sgiw=;
        b=4y2H2p0QnD/C7+3kXfssJnDCbuH3nTgPvIgi66cDzL/th0GVP7cJsgafTnSOwlOqlZ
         ddppvYF4He0Vy3SvWZyOmOdO6HoInSZPvttfNjRKt+65dDqg2QDUuW9a0mUf+RHzWBf9
         UHKW+BVpDLTiVFBlzQV207cT8rD+9C/QCR7nbClF7E8W2K+llBWHjMap/TLSVfjmVoak
         EhmjqXp99X05SFlYN869UTWKeXnD7yVSrt6cfWw0EoP8D1SW3eoAOepd/5apsiPW1ohk
         N3TB7nPfYkPoDTM+EMmT7j9xwMBlDOSeHFizeGPBH+i1AjJqA0ofHLuMW7EKUTo8D1BH
         wfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731974; x=1761336774;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aywn3p1OuroHc7cbdG3tEKHp3pq1LL6GKGiRpb5Sgiw=;
        b=rrdLY5fMb4cLlutnbQ4/K683JWc6D03bWoWACgbT7rQ0yl2xPxMFPSh14aFrkKjvqz
         3l0/4R8ufLxRoRsMrIonLx2ikNvdx49cdwfW4NEAQTJpeMGMuiqFCX5TcsIGHZEuS92V
         Wk19XABGMfBWgTdn5WpLcbqnIwyPSMutTAylEgg1/u9IQyA6vDgA33NWYqy2AFdPJAU+
         cRfeoufktmH4MTuqGkkcICQMRmDnp2WXMpBPI4UVcpMFH5QEceGS2OCizkJdRE9MWQyZ
         IZTbmywQ3tQzAoar+6pnj/Vzrs9bdQk72U5dVuVQbkuf0KpEilhO0vwXu/UvxXvv5v6A
         /7oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRUY0AyT35Wvru52RsGVo3XrVMOq1sGDLmdDFRMrxap+mHlZiSq1/HibGPfKAY43ta0Z5AiAHL8Y872RPP6NsWTDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5uhBEMjWu+XlKMS4Q4SbSl/ILPhZ9JSHUE7BqjLuZYq7dX6OS
	tpNNYAop2SoPQkmtXVgbAlxnE2l/n6XZI+EyTP3vOPq8KNUgYDipVLdXCiV0qwxuGleVXqNywO7
	lPQq2LuU6SrCZmRPCE3kO0n44rw==
X-Google-Smtp-Source: AGHT+IGCFLZDb5cyrEN1NOozFPEt/0O+VXA7q/ZXGXzCvaMHmS50bIpyR021wTre8w3PZtNhA8jj0eOMny4OOvLYpA==
X-Received: from pjyl20.prod.google.com ([2002:a17:90a:ec14:b0:33b:8aa1:75ed])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3f8d:b0:33b:be31:8193 with SMTP id 98e67ed59e1d1-33bcf85d59dmr6510945a91.6.1760731973870;
 Fri, 17 Oct 2025 13:12:53 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:11:56 -0700
In-Reply-To: <cover.1760731772.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <19167e80b65bce484d91c7ba4d1967a7d12ef90a.1760731772.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 15/37] KVM: selftests: Rename guest_memfd{,_offset} to gmem_{fd,offset}
From: Ackerley Tng <ackerleytng@google.com>
To: cgroups@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Cc: ackerleytng@google.com, akpm@linux-foundation.org, 
	binbin.wu@linux.intel.com, bp@alien8.de, brauner@kernel.org, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, corbet@lwn.net, 
	dave.hansen@intel.com, dave.hansen@linux.intel.com, david@redhat.com, 
	dmatlack@google.com, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	haibo1.xu@intel.com, hannes@cmpxchg.org, hch@infradead.org, hpa@zytor.com, 
	hughd@google.com, ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com, 
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com, 
	kent.overstreet@linux.dev, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, 
	maobibo@loongson.cn, mathieu.desnoyers@efficios.com, maz@kernel.org, 
	mhiramat@kernel.org, mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com, 
	mingo@redhat.com, mlevitsk@redhat.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, peterx@redhat.com, 
	pgonda@google.com, prsampat@amd.com, pvorel@suse.cz, qperret@google.com, 
	richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, roypat@amazon.co.uk, rppt@kernel.org, seanjc@google.com, 
	shakeel.butt@linux.dev, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, wyihan@google.com, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

From: Sean Christopherson <seanjc@google.com>

Rename local variables and function parameters for the guest memory file
descriptor and its offset to use a "gmem_" prefix instead of
"guest_memfd_".

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 26 +++++++++++-----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index e35c65a173606..8b714270cf381 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -912,7 +912,7 @@ void vm_set_user_memory_region(struct kvm_vm *vm, uint32_t slot, uint32_t flags,
 
 int __vm_set_user_memory_region2(struct kvm_vm *vm, uint32_t slot, uint32_t flags,
 				 uint64_t gpa, uint64_t size, void *hva,
-				 uint32_t guest_memfd, uint64_t guest_memfd_offset)
+				 uint32_t gmem_fd, uint64_t gmem_offset)
 {
 	struct kvm_userspace_memory_region2 region = {
 		.slot = slot,
@@ -920,8 +920,8 @@ int __vm_set_user_memory_region2(struct kvm_vm *vm, uint32_t slot, uint32_t flag
 		.guest_phys_addr = gpa,
 		.memory_size = size,
 		.userspace_addr = (uintptr_t)hva,
-		.guest_memfd = guest_memfd,
-		.guest_memfd_offset = guest_memfd_offset,
+		.guest_memfd = gmem_fd,
+		.guest_memfd_offset = gmem_offset,
 	};
 
 	TEST_REQUIRE_SET_USER_MEMORY_REGION2();
@@ -931,10 +931,10 @@ int __vm_set_user_memory_region2(struct kvm_vm *vm, uint32_t slot, uint32_t flag
 
 void vm_set_user_memory_region2(struct kvm_vm *vm, uint32_t slot, uint32_t flags,
 				uint64_t gpa, uint64_t size, void *hva,
-				uint32_t guest_memfd, uint64_t guest_memfd_offset)
+				uint32_t gmem_fd, uint64_t gmem_offset)
 {
 	int ret = __vm_set_user_memory_region2(vm, slot, flags, gpa, size, hva,
-					       guest_memfd, guest_memfd_offset);
+					       gmem_fd, gmem_offset);
 
 	TEST_ASSERT(!ret, "KVM_SET_USER_MEMORY_REGION2 failed, errno = %d (%s)",
 		    errno, strerror(errno));
@@ -944,7 +944,7 @@ void vm_set_user_memory_region2(struct kvm_vm *vm, uint32_t slot, uint32_t flags
 /* FIXME: This thing needs to be ripped apart and rewritten. */
 void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 		uint64_t gpa, uint32_t slot, uint64_t npages, uint32_t flags,
-		int guest_memfd, uint64_t guest_memfd_offset)
+		int gmem_fd, uint64_t gmem_offset)
 {
 	int ret;
 	struct userspace_mem_region *region;
@@ -1027,12 +1027,12 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 		region->mmap_size += alignment;
 
 	if (flags & KVM_MEM_GUEST_MEMFD) {
-		if (guest_memfd < 0) {
-			uint32_t guest_memfd_flags = 0;
+		if (gmem_fd < 0) {
+			uint32_t gmem_flags = 0;
 
-			TEST_ASSERT(!guest_memfd_offset,
+			TEST_ASSERT(!gmem_offset,
 				    "Offset must be zero when creating new guest_memfd");
-			guest_memfd = vm_create_guest_memfd(vm, mem_size, guest_memfd_flags);
+			gmem_fd = vm_create_guest_memfd(vm, mem_size, gmem_flags);
 		} else {
 			/*
 			 * Install a unique fd for each memslot so that the fd
@@ -1040,11 +1040,11 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 			 * needing to track if the fd is owned by the framework
 			 * or by the caller.
 			 */
-			guest_memfd = kvm_dup(guest_memfd);
+			gmem_fd = kvm_dup(gmem_fd);
 		}
 
-		region->region.guest_memfd = guest_memfd;
-		region->region.guest_memfd_offset = guest_memfd_offset;
+		region->region.guest_memfd = gmem_fd;
+		region->region.guest_memfd_offset = gmem_offset;
 	} else {
 		region->region.guest_memfd = -1;
 	}
-- 
2.51.0.858.gf9c4a03a3a-goog

