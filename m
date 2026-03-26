Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581D93DE436
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 22:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563942; cv=none; b=RUL84JO2X/28gafOnOROZ27PDWXvad9Yx7z1hQu4zaDjuHQHqCyfAxlOa05mw5zAy9k744ok6QJp5JQdB09eyoLiNYKmxp7So9DQoWCnE5m1KvR3CjqtkntDyRlxGMzWg7FWG5r4EHUzIa5AwqeAO39BCQRN8PWwppLxg1e7O8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563942; c=relaxed/simple;
	bh=Iex+2GjcnFztYZs6o03UC8jgSSpVm69SQTPm4qzz0wo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I+mFBreLt2puniOGy6UAV/y4vSK1lHdyqF3NZUS0OYiOwiKJIIrQYD11Z0pMM5IV/GinpheWgnJYo8QxG4nvhPOy0dlH/Cf2mRlC9MHHFtlEYBSCBijMqe0XJuBlzOwVyM8Q5MvJh7OLyQB4E7Rx+udAhF4DQf5VGeqaLp0B7IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=obRr/MHq; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="obRr/MHq"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c70ea91bfe1so1031031a12.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 15:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774563941; x=1775168741; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T0kEUH0AVz9474H95ZJeKVlqpWC9wv6k4l4eJTTe5z0=;
        b=obRr/MHqDMcqmfjRy/dL/0BbOOexLUPkxNiYBJWQid5PfniHx96F+lKJT/9vu5Kr1O
         KH4fa8LaxMiGi4v9+vYGBn3f5+urmrTsgAraof7lJliRqhcqdwOj50QI5CpuJ+xNE24X
         LS44YGrkIHzerfvg5fXfrlzR/sSXXuDNR+/9N19vpMZw7rjLOwGyI9LfjOL3oMU/L2u5
         tRocl/+thgNql/3+yIwjaaYxCDoxCrqNbrA/uLP7g4wbnkqcV77JA+57rV5qKB2/hx2f
         1ay47f88rHbo2Gnm91nECEpYWLdHWj/lzyzBeZBzDVy+32okDbqOHYYoWWnk1wR5EaLw
         Sotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774563941; x=1775168741;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T0kEUH0AVz9474H95ZJeKVlqpWC9wv6k4l4eJTTe5z0=;
        b=r3wLP+um+7/nkhj9Q4ZSofgTngnuiYadRgjNv0yy1kTYghPvk7JaLBoTIf8XDSIOVE
         4FOWQKLEanqASkieRn1hvHGyrFDwD3uT6o4fkZW0zwBsb3SukNTFVQsKHYh3g/kHdjaB
         xcf+xviXjjOg99mmfdruHecTM6QftkIUmb3cEH6jilMlRx/DC8GHhl3ZUgwNS9I+WTLT
         Kosw1ECU0fgzB3rPoUVmYGM4EQJJZzJ+qj0jRSbwl6AHHzSYlL2WlnSMuvGTb0gQSG9h
         s1RG+lvDe5SuhijYqP1ZJaaYI9kznyatMJhya9yuNDX8Y0JClEQ9+LhHbU9flo5VRTr2
         Cjtw==
X-Forwarded-Encrypted: i=1; AJvYcCXAAezyEC4wZTDK4Y3LKng96xxtRF//eU3V+NZvVIdStwz96Jrh51kK7VjcyVMTr6s42BgfI97g2UDdMCYzlTdTaoI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0j9sP6bXOc6F/8eTTTtmMjVWHLYlqLgNz1uZ8Z1v+RW4TFeXn
	QP9oox9ixfukl5H3iBmbFMPwIbc2z9JtD/c1L37cKzF3Aewf5zmTafoQ+U5NBYsd5++za72Sre9
	7QPW58DzVFedJpOZHy+kDNi42uQ==
X-Received: from pfbbe3.prod.google.com ([2002:a05:6a00:1f03:b0:82c:70d1:f303])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:210c:b0:39c:cdb:5d81 with SMTP id adf61e73a8af0-39c87b616c8mr305023637.32.1774563940116;
 Thu, 26 Mar 2026 15:25:40 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:24:46 -0700
In-Reply-To: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774563861; l=3936;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=Iex+2GjcnFztYZs6o03UC8jgSSpVm69SQTPm4qzz0wo=; b=LFg1NDSfx+bum67XPaMfMmazQlzXZqxkRIG8TginmY6+F7SKNrf7qVkCww33oClPBp0A+AaN7
 OS52FCGGuuqC+V+eBWfg0ZX4o+q1AYjZII78BhV4qnGvy49q3S5we2t
X-Mailer: b4 0.14.3
Message-ID: <20260326-gmem-inplace-conversion-v4-37-e202fe950ffd@google.com>
Subject: [PATCH RFC v4 37/44] KVM: selftests: Provide function to look up
 guest_memfd details from gpa
From: Ackerley Tng <ackerleytng@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jroedel@suse.de, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

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
 tools/testing/selftests/kvm/include/kvm_util.h |  3 +++
 tools/testing/selftests/kvm/lib/kvm_util.c     | 34 ++++++++++++++++----------
 2 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index a539a98f79e08..3434f3df028b0 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -427,6 +427,9 @@ static inline void vm_enable_cap(struct kvm_vm *vm, uint32_t cap, uint64_t arg0)
 	vm_ioctl(vm, KVM_ENABLE_CAP, &enable_cap);
 }
 
+int kvm_gpa_to_guest_memfd(struct kvm_vm *vm, vm_paddr_t gpa, off_t *fd_offset,
+			   uint64_t *nr_bytes);
+
 /*
  * KVM_SET_MEMORY_ATTRIBUTES overwrites _all_ attributes.  These flows need
  * significant enhancements to support multiple attributes.
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 404efb5318f09..6deb6b333a066 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1291,27 +1291,19 @@ void vm_guest_mem_fallocate(struct kvm_vm *vm, uint64_t base, uint64_t size,
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
 
@@ -1717,6 +1709,22 @@ void *addr_gpa2alias(struct kvm_vm *vm, vm_paddr_t gpa)
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
2.53.0.1018.g2bb0e51243-goog

