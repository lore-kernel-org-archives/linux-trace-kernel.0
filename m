Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB483C1088
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 09:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735964; cv=none; b=XBKdhE835PfKTPK0btOeuNc9xI3K9tUovSYUEwVPCb8tG1FkN7DSbz1kvACWwoWxAQ5N+KrSN9Y5yyo3varvV0XF/NQNKiKk+h165dGAtYONx7xWQds61EWD1MqNvDS0SGNtyfgPAvMV20Q1skT/pLkY9U2E5DbjBOLAmAb7Y9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735964; c=relaxed/simple;
	bh=/CEIwjSGNwWClY4nJ2gvXOUmsoNiPZonugede79K7VY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BqRZGjdy1fQsBWkc4F9ZN8IJf7blNzwF8XguPZFq4QGalo5FQGdvTwpxPkMH/FImsIy1Hb1BDB0zuFt1YW7EYfWubdB9Ro9161nXORnpkz5enXeWiGeCg8lk8O4Tj0SX8V+CW7999/sxWAmW9wAjRZ8foaUlSZpoLxFK4s7seWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S0e96A8H; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S0e96A8H"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d6df0a1e18so9993745ad.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 02:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787735956; x=1788340756; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D76PmzCDeRV2p6N10w9hh+EAG0ujagtUtRrj7jnjsfc=;
        b=S0e96A8HqBK3LBCzJOnA/+yIWjNBqKpWigXfkwj3hXG+1hlRWMdo+dLQDSApkrA0Au
         W0GxzQrpu+uFv35nd7aYUNGKh1jeIhvEGSI0LEgW+wSZV4pNX61XFsyIiQhi1dWP7cpI
         D8JudCiYVXBiAYk4lF6Fnwtr3hLN3XjR5b+qiq3BSdq82WxIqtZxcKQ2BfLZb+EJuTb5
         GSeLweKA3yp60N8FIjJVrOGsTDtR6TbXk1HeS2HY7+Ej7HJa58bl38i1B3B3zIEph8rR
         guy+rr/G2MU1qwsFhmzwb5gjRIcNChiMOt2JZnRuVQTCwDnDxMkyZfHO1LLffm848dx9
         hdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735956; x=1788340756;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D76PmzCDeRV2p6N10w9hh+EAG0ujagtUtRrj7jnjsfc=;
        b=f2+sHvNANJEeccCnMpqw964rG9hDfjP5KkmgTxpjjFBkKxz2lnnSDrkfGmKB/VUEZR
         +NCRtzlosW+GZv+M0Uebc8Io7ETcCR7R2DCkIlsoURxi1lglgNwzXmWMQg9YhZ2WmoZZ
         Y0gRQ52tegr+VjyibDBys2MafIA0kMOUWzNpWscOQtWOBSJPW+uxcogVKTouFwK0V37j
         wBneq1BRTrLdeVVm+GJK+wt93Wph8W7mwLKRRx9SocTJ9xtyIUgzP7hfelKZu79hWjd7
         XdFFm9dITXd/wczXuwsTSaZyIp9SX4E/HCukrDJWcOmS1nrYFKUxUoT/sqvxXWhLLoCu
         ygAA==
X-Forwarded-Encrypted: i=1; AHgh+Rp7WHREIyQQ+k/IJup5IBPZQ945TAKbbC8HDbUPbq8u1U/iCFCiqlCJULWlVSkVFLH1Jr7kegRaNxZuZPMeMuXcYFw=@vger.kernel.org
X-Gm-Message-State: AFuF++k/78H0Ie0hTG4rky8u2lWHGRnh7FhSxnHshP9M5+xWcFCVSvRE
	Jwo7jikpgNF006fHFCCbpM8iVAh9g8sSewWHbF7tpvtnD55vDaKAtg/eNHyWhMTahwKCyvs5sFN
	eJEelvS1zNkC2GDJ+TVOdtXz7Dw==
X-Received: from plbkx3.prod.google.com ([2002:a17:902:f943:b0:2cc:b904:3255])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:8c5:b0:2d6:3c2f:69b with SMTP id d9443c01a7336-2d707aeb1b2mr107014985ad.8.1787735955894;
 Wed, 26 Aug 2026 02:19:15 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:18:38 +0000
In-Reply-To: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787735885; l=3994;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=/CEIwjSGNwWClY4nJ2gvXOUmsoNiPZonugede79K7VY=; b=VKI0jpmA2fGtPo3ALkYanD2hZxdvdB4CI9YcTqovPUoBOfqUWyj8zXw9hejtH2j8l1NI1Y3qO
 tqEtPmAd+YVCTNJdT2Dv6V42I0jNgs6umWAkWlD4JbtNbw1o73F37Lt
X-Mailer: b4 0.16.0
Message-ID: <20260826-gmem-inplace-conversion-v11-40-0a15d8a799aa@google.com>
Subject: [PATCH v11 40/46] KVM: selftests: Provide function to look up
 guest_memfd details from gpa
From: Ackerley Tng <ackerleytng@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Fuad Tabba <fuad.tabba@linux.dev>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

Introduce a new helper, kvm_gpa_to_guest_memfd(), to find the
guest_memfd-related details of a memory region that contains a given guest
physical address (GPA).

The function returns the file descriptor for the memfd, the offset into
the file that corresponds to the GPA, and the number of bytes remaining
in the region from that GPA.

kvm_gpa_to_guest_memfd() was factored out from vm_guest_mem_fallocate();
refactor vm_guest_mem_fallocate() to use the new helper.

Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Shivank Garg <shivankg@amd.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h |  3 +++
 tools/testing/selftests/kvm/lib/kvm_util.c     | 37 ++++++++++++++++----------
 2 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 3cfe243d7c8b0..795c9eb311071 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -428,6 +428,9 @@ static inline void vm_enable_cap(struct kvm_vm *vm, u32 cap, u64 arg0)
 	vm_ioctl(vm, KVM_ENABLE_CAP, &enable_cap);
 }
 
+int kvm_gpa_to_guest_memfd(struct kvm_vm *vm, gpa_t gpa, off_t *fd_offset,
+			   size_t *nr_bytes);
+
 /*
  * KVM_SET_MEMORY_ATTRIBUTES{,2} overwrites _all_ attributes.  These
  * flows need significant enhancements to support multiple attributes.
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index b1456ed76e27e..1188d0a6c0a5f 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1332,27 +1332,20 @@ void vm_guest_mem_fallocate(struct kvm_vm *vm, u64 base, u64 size,
 			    bool punch_hole)
 {
 	const int mode = FALLOC_FL_KEEP_SIZE | (punch_hole ? FALLOC_FL_PUNCH_HOLE : 0);
-	struct userspace_mem_region *region;
 	u64 end = base + size;
-	gpa_t gpa, len;
 	off_t fd_offset;
-	int ret;
+	int fd, ret;
+	size_t len;
+	gpa_t gpa;
 
 	for (gpa = base; gpa < end; gpa += len) {
-		u64 offset;
+		fd = kvm_gpa_to_guest_memfd(vm, gpa, &fd_offset, &len);
+		len = min(end - gpa, len);
 
-		region = userspace_mem_region_find(vm, gpa, gpa);
-		TEST_ASSERT(region && region->region.flags & KVM_MEM_GUEST_MEMFD,
-			    "Private memory region not found for GPA 0x%lx", gpa);
-
-		offset = gpa - region->region.guest_phys_addr;
-		fd_offset = region->region.guest_memfd_offset + offset;
-		len = min_t(u64, end - gpa, region->region.memory_size - offset);
-
-		ret = fallocate(region->region.guest_memfd, mode, fd_offset, len);
+		ret = fallocate(fd, mode, fd_offset, len);
 		TEST_ASSERT(!ret, "fallocate() failed to %s at %lx (len = %lu), fd = %d, mode = %x, offset = %lx",
 			    punch_hole ? "punch hole" : "allocate", gpa, len,
-			    region->region.guest_memfd, mode, fd_offset);
+			    fd, mode, fd_offset);
 	}
 }
 
@@ -1689,6 +1682,22 @@ void *addr_gpa2alias(struct kvm_vm *vm, gpa_t gpa)
 	return (void *) ((uintptr_t) region->host_alias + offset);
 }
 
+int kvm_gpa_to_guest_memfd(struct kvm_vm *vm, gpa_t gpa, off_t *fd_offset,
+			   size_t *nr_bytes)
+{
+	struct userspace_mem_region *region;
+	gpa_t gpa_offset;
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
2.55.0.887.g758fc8c411-goog

