Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F9738E10D
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Feb 2026 22:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770071474; cv=none; b=oG+EDN6IxGDuXyWKOlcTvHWRZdbcSkDupOMKXHb3Zjs+mgqYaF+8gfBRdnKW/f5WTh/NiVaeeij+LhH6sDKRBuzBP/PoKhaX+QHn+oLhetqHxuzItuB3cMd3h59zsgAWEDNfyQz/5aWt0lFh94LaZShyBjtNHfDcojUP5Q5r/98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770071474; c=relaxed/simple;
	bh=rhPa7e2nbHKPgcSIpSn/eTrXn9i9fhs462e3RBGjlu0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JHbHOIc+WJumKVaWqlteQkvtA4/C3kt5OKW+ukFzYXhEhLdNxqKMsAAKmx1wKQCaKTJn0PuoYrsRnk+vkD3LtuzeLKocL2h4kJBRcKGCCSpkH/MgH3JVjVNATACIMcCrBUuiNpYuDFdEOzg1MbTdgP7y33QayzGvvDQAzS8NA10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WZlkgRE2; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WZlkgRE2"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a784b2234dso137638515ad.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Feb 2026 14:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770071471; x=1770676271; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+LasQi9MZpEXca97c2GcW0Xzf1pgBMgUd5URnFGTxTw=;
        b=WZlkgRE2RoL0usg+N0Dw6kSr0bsUsZF66bu/tmlIXch61TL0vpMH6l3jUkD3om6XeY
         falyvd9BwE3ihvPt6JeunSiFVSdxbu2hxJEHfFo96ZnvUlut2UjcSgqFZCA42eWt5Qrc
         Qh/DVrMMf2MobIcQxMJDa1O7EaVtXDnYB70Ac3cr0xQnLrDDkjyOa/m1Dw0ao3lxy/0k
         KN3h1cNqvLqT2EylIXSAlppNkWJUBPOxikvK6HVF2UGFn1k90R2AstiewidRb61A4RIK
         94oesHS+Q8yCA6x+B+wpWQ/WYWATkurZljY6H0gz6j4n8ikzZYSp6HUFUkzh6cxIFNI5
         Fb3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770071471; x=1770676271;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+LasQi9MZpEXca97c2GcW0Xzf1pgBMgUd5URnFGTxTw=;
        b=Ue0gZwmTzkVVoQ1iXInAJiVrY4sAT/4aiX9pR8yZD7QuxWqiW7x8YSiycEM3vsZneN
         WP//qklQnJ5UI9+OFQtocSnv14+/YAYacUWzTtdRj6gWy4b3/ZAmu1gevXYZdcJm/l2P
         3KDUtmCTKgkxmOPByXPxjNVavDOz2bTZ6RUT++3+tE987RaPl7OHNC91PHI0B7MdlLlh
         0mIDf0c+kQg0b/u2+4aBhg0s3KdZBO+rHFpZJZQgd87UZcUQf5qe1ELQVf87YQCwcf/V
         GNvhsVyWLHMon0UH216M4sHFEv0FR9t6GQmkO7PZuRRhja5ROsiwp/CQcWVsEhllbN0l
         UyCg==
X-Forwarded-Encrypted: i=1; AJvYcCUNPfww1s/TYzt4NpBFHTHQhbDQgfgLJ3/pyjC8XuqNL9D7+7SQ/d4MzKCp723Kyjcm2C5bCOCJffkDyEJcX9qPmu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY/eJihEqdwvH9RUBdhFnoN54ANtZITb9sr9Is93czmXMgX5A4
	t4y00M3QsmnRvNZXQ7K3SINPJdoIN7A2omWIP1jFMvL8rG5K1db4q7Rb1R26VyR4pE5x0yQcLDY
	8NtiTDhf9ePsFAi2xCFRtt/gzkA==
X-Received: from pltg6.prod.google.com ([2002:a17:902:6b46:b0:29f:101f:a1d7])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2389:b0:29e:e925:1abb with SMTP id d9443c01a7336-2a8d96e3de3mr134547405ad.27.1770071471269;
 Mon, 02 Feb 2026 14:31:11 -0800 (PST)
Date: Mon,  2 Feb 2026 14:30:08 -0800
In-Reply-To: <cover.1770071243.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1770071243.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <106c16f75862ed98989f1ae8ebaa06ecbc4a39d9.1770071243.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 30/37] KVM: selftests: Provide function to look up
 guest_memfd details from gpa
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
	yan.y.zhao@intel.com, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce a new helper, kvm_gpa_to_guest_memfd(), to find the
guest_memfd-related details of a memory region that contains a given guest
physical address (GPA).

The function returns the file descriptor for the memfd, the offset into
the file that corresponds to the GPA, and the number of bytes remaining
in the region from that GPA.

kvm_gpa_to_guest_memfd() was factored out from vm_guest_mem_fallocate();
refactor vm_guest_mem_fallocate() to use the new helper.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |  3 ++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 34 ++++++++++++-------
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index e767f9a99a7b..b370b70442e8 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -404,6 +404,9 @@ static inline void vm_enable_cap(struct kvm_vm *vm, uint32_t cap, uint64_t arg0)
 	vm_ioctl(vm, KVM_ENABLE_CAP, &enable_cap);
 }
 
+int kvm_gpa_to_guest_memfd(struct kvm_vm *vm, vm_paddr_t gpa, off_t *fd_offset,
+			   uint64_t *nr_bytes);
+
 /*
  * KVM_SET_MEMORY_ATTRIBUTES overwrites _all_ attributes.  These flows need
  * significant enhancements to support multiple attributes.
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 4f464ad8dffd..61adfd7e623c 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1258,27 +1258,19 @@ void vm_guest_mem_fallocate(struct kvm_vm *vm, uint64_t base, uint64_t size,
 			    bool punch_hole)
 {
 	const int mode = FALLOC_FL_KEEP_SIZE | (punch_hole ? FALLOC_FL_PUNCH_HOLE : 0);
-	struct userspace_mem_region *region;
 	uint64_t end = base + size;
 	uint64_t gpa, len;
 	off_t fd_offset;
-	int ret;
+	int fd, ret;
 
 	for (gpa = base; gpa < end; gpa += len) {
-		uint64_t offset;
-
-		region = userspace_mem_region_find(vm, gpa, gpa);
-		TEST_ASSERT(region && region->region.flags & KVM_MEM_GUEST_MEMFD,
-			    "Private memory region not found for GPA 0x%lx", gpa);
+		fd = kvm_gpa_to_guest_memfd(vm, gpa, &fd_offset, &len);
+		len = min(end - gpa, len);
 
-		offset = gpa - region->region.guest_phys_addr;
-		fd_offset = region->region.guest_memfd_offset + offset;
-		len = min_t(uint64_t, end - gpa, region->region.memory_size - offset);
-
-		ret = fallocate(region->region.guest_memfd, mode, fd_offset, len);
+		ret = fallocate(fd, mode, fd_offset, len);
 		TEST_ASSERT(!ret, "fallocate() failed to %s at %lx (len = %lu), fd = %d, mode = %x, offset = %lx",
 			    punch_hole ? "punch hole" : "allocate", gpa, len,
-			    region->region.guest_memfd, mode, fd_offset);
+			    fd, mode, fd_offset);
 	}
 }
 
@@ -1684,6 +1676,22 @@ void *addr_gpa2alias(struct kvm_vm *vm, vm_paddr_t gpa)
 	return (void *) ((uintptr_t) region->host_alias + offset);
 }
 
+int kvm_gpa_to_guest_memfd(struct kvm_vm *vm, vm_paddr_t gpa, off_t *fd_offset,
+			   uint64_t *nr_bytes)
+{
+	struct userspace_mem_region *region;
+	vm_paddr_t gpa_offset;
+
+	region = userspace_mem_region_find(vm, gpa, gpa);
+	TEST_ASSERT(region && region->region.flags & KVM_MEM_GUEST_MEMFD,
+		    "guest_memfd memory region not found for GPA 0x%lx", gpa);
+
+	gpa_offset = gpa - region->region.guest_phys_addr;
+	*fd_offset = region->region.guest_memfd_offset + gpa_offset;
+	*nr_bytes = region->region.memory_size - gpa_offset;
+	return region->region.guest_memfd;
+}
+
 /* Create an interrupt controller chip for the specified VM. */
 void vm_create_irqchip(struct kvm_vm *vm)
 {
-- 
2.53.0.rc1.225.gd81095ad13-goog

