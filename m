Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA31338F24D
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Feb 2026 22:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770071447; cv=none; b=SYJD2vef3kg3I2Aqgs1l7/ablpcyqhf+0X8lN60nsXNVrOX3IX7dz/dnD5gwq8i4Hjvi5MRsJGoELodDF+6HDK8WSa8opzOOldxXgW2+lMbYdtmSM9WZhe5/l/AkRuPtVDNZamIFI8UYP1jk6o3ULYJLuXYGUDb18e2mLgQm4Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770071447; c=relaxed/simple;
	bh=/dWMpq6vE/7HkK6yE2U3JYfQaSrCbMYJZFUDKCzqBMc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XF+cfiYCjGFcGCGoh4jYf2u35Mfcb5RxmFjqo1XTYlSoI8RqRGa0PngjqhUglRCZd4msL0EKJDvDSTYU19c3NLXSaA6NcDyG/1j/wgQx0NGxFKur0mwYTCoCO/fHvVoe07zu4ApCBsrnhGWexqneShGO0l/fbgBsN46yr/JvCzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U2DNGNOK; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U2DNGNOK"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-29f1f69eec6so53882765ad.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Feb 2026 14:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770071445; x=1770676245; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CUQIYjzitQKlRJasc2c/7ZSNL/xGsJJinByZkwdMusA=;
        b=U2DNGNOKK6otz95PiYFOKVgsyHNIQksSRnlIaN0j1ex2jxeIcj+eK8l0oZXluImRe2
         KJrav+HclgFkFfqEHH9nArdsKVMIxHlsNWiUCzzjOu01yEq4L2QX6U0rr42CtAvI7qrq
         qcQyETwdeL+KTiki3XKuE0PmG5LATgTz7T3u29aaGg/DsiBqP9knndX7/h53DH+6tUgn
         GGxQue5e15fkWwZ6ZLkAN6OgOGP/FXI+q0dW6uMcLtU4wAvcZCkDD2HUXs38lmrNH214
         boQAo11jZcIE6Ztx6p1aeNut1Kpz32ZxJfhudElzesC62yhZ7CuIhlqzIt09+/NwXsUl
         uN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770071445; x=1770676245;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CUQIYjzitQKlRJasc2c/7ZSNL/xGsJJinByZkwdMusA=;
        b=J2rv5DBWi4RAPEN7PAonOnpVgrcED0ps91EcgTLQiJ8FLa4j6hbIRI9HR75mEpwJzf
         75YwtSv/w5lNtvDbJ6YTJ4vgIrGJnBeGPlKj3sGTP6vtrmYSHBfCxCU/P1FIyF3iv7DY
         6Nv+hPDlwfpCWfeo4IXxWzrI0A2pD92C24mqID5nfQIzDVXMR2r+IrLLHISMzLQnm66S
         74yVRo3Y59mtxnkP/vqjVyhDGyOMP4n2lOvVfaoUiAinctLv0Do1LTNxeOW2VNuu8srf
         Kvuz64+fz31bPCJzs40wsOwfFjHGC9TN6jAoYv1WkTqbXZO9FFjQNwvSR1GSi6HWoHHp
         EJgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQ819YDyd81GhqdPLESGOhvruhUZ1YIBMAXmDNtD5lN1Ld9Ec2BrzVaWE64anVVAqVHsPRv+jfvkspZQ2YU05D890=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvOlZInyvgNnxAQVrtebZihNcerJ5dvfcTmpRKZnSIFNLFHY2D
	zepJB94L3crUMPkEZutx3emLLjMUkvy0go3qol6Sv5sehfbNKW3siUcRDPZQvORVN1oSy6QBGem
	InIlg8t5FEK0Nd7M55/zG4MHGQA==
X-Received: from pjva4.prod.google.com ([2002:a17:90a:d804:b0:352:d931:fa5b])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2e4a:b0:33f:f22c:8602 with SMTP id 98e67ed59e1d1-3543b3d64fdmr12780204a91.26.1770071445347;
 Mon, 02 Feb 2026 14:30:45 -0800 (PST)
Date: Mon,  2 Feb 2026 14:29:52 -0800
In-Reply-To: <cover.1770071243.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1770071243.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <fe1dc8685c351c07c7a13b45b610ac74b7f52c9c.1770071243.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 14/37] KVM: selftests: Rename guest_memfd{,_offset} to gmem_{fd,offset}
From: Ackerley Tng <ackerleytng@google.com>
To: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	bp@alien8.de, brauner@kernel.org, chao.p.peng@intel.com, 
	chao.p.peng@linux.intel.com, chenhuacai@kernel.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, david@kernel.org, hpa@zytor.com, 
	ira.weiny@intel.com, jgg@nvidia.com, jmattson@google.com, jroedel@suse.de, 
	jthoughton@google.com, maobibo@loongson.cn, mathieu.desnoyers@efficios.com, 
	maz@kernel.org, mhiramat@kernel.org, michael.roth@amd.com, mingo@redhat.com, 
	mlevitsk@redhat.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	pbonzini@redhat.com, prsampat@amd.com, qperret@google.com, 
	ricarkol@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, seanjc@google.com, shivankg@amd.com, shuah@kernel.org, 
	steven.price@arm.com, tabba@google.com, tglx@linutronix.de, 
	vannapurve@google.com, vbabka@suse.cz, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com
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
index 1d69baf900a2..6daeb4f945a0 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -914,7 +914,7 @@ void vm_set_user_memory_region(struct kvm_vm *vm, uint32_t slot, uint32_t flags,
 
 int __vm_set_user_memory_region2(struct kvm_vm *vm, uint32_t slot, uint32_t flags,
 				 uint64_t gpa, uint64_t size, void *hva,
-				 uint32_t guest_memfd, uint64_t guest_memfd_offset)
+				 uint32_t gmem_fd, uint64_t gmem_offset)
 {
 	struct kvm_userspace_memory_region2 region = {
 		.slot = slot,
@@ -922,8 +922,8 @@ int __vm_set_user_memory_region2(struct kvm_vm *vm, uint32_t slot, uint32_t flag
 		.guest_phys_addr = gpa,
 		.memory_size = size,
 		.userspace_addr = (uintptr_t)hva,
-		.guest_memfd = guest_memfd,
-		.guest_memfd_offset = guest_memfd_offset,
+		.guest_memfd = gmem_fd,
+		.guest_memfd_offset = gmem_offset,
 	};
 
 	TEST_REQUIRE_SET_USER_MEMORY_REGION2();
@@ -933,10 +933,10 @@ int __vm_set_user_memory_region2(struct kvm_vm *vm, uint32_t slot, uint32_t flag
 
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
@@ -946,7 +946,7 @@ void vm_set_user_memory_region2(struct kvm_vm *vm, uint32_t slot, uint32_t flags
 /* FIXME: This thing needs to be ripped apart and rewritten. */
 void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
 		uint64_t gpa, uint32_t slot, uint64_t npages, uint32_t flags,
-		int guest_memfd, uint64_t guest_memfd_offset)
+		int gmem_fd, uint64_t gmem_offset)
 {
 	int ret;
 	struct userspace_mem_region *region;
@@ -1029,12 +1029,12 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
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
@@ -1042,11 +1042,11 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
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
2.53.0.rc1.225.gd81095ad13-goog

