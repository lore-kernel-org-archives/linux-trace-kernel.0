Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4A93DEAF1
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 22:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563944; cv=none; b=ZsNC9+E45idWnkPebuNyM+GivNaVF1tbcVFi+utQmT8CAe/n5qLqmHbrxjA9jfbxfydhhHdFFNoCZ16LQuN9Sqb8+WWOA31A2CzOFJS7+CFOZRdp1fxmQgXhtbA1UnZCaRXwD/84ylteeysdyqJ2Ryi9b4FOH+Bq4movEFnpLy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563944; c=relaxed/simple;
	bh=cIqWAq5WjkT3kwr//fCKAzdxhjaZz9Zb7L+/dQP6WPc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J07haQrowYpoRldQk1/X8vEDexw3i9EjqyrTeMtW8353Agt4MWzyqTD1d55noQsTgO0kuHS4/cyuoli/1lVGqVk3Gf/I0+KeMU0nnoYJDPZS8u3xgTqS0j2zrEihYYtDsdKZC5CfzTRspchE+YmsPmPOw8JKNSIIyP8o2snCouE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FzHk6KOK; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FzHk6KOK"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35c10c2d890so2143188a91.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 15:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774563942; x=1775168742; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NdTzJ2knx/A8nF/dOxU4yhfVKOq5sU9Aj61j8WPVqZE=;
        b=FzHk6KOKfWR1X/mjgGxGGc8To4iKG3hnhbURyPmyY48d/LfDxtD1tG5GNOnaftdQOQ
         6i1JJY04FnIgpzR0xmzOmkW/8K8WmNPpov8DgCJSNmOozAH70CiIE6gpHGjqP1Y1ZMvT
         C5nG4XGk3UapfOM6289GsbBnpcAIHLLPWvWzFwVYjSbLHVNwFrx3Lmf2xQjLjlRcHCmh
         xusFYLPWV9CsO0WwNDlkZijXc5wLDDGasEPiH8lD3EimtJNI9w1GjEVGR5C2KyOOMzcI
         g1A/OJGj0bxFoMEw8YDcroHKYMoTZ+GfZ32ThN/uPbxXwhI+/qDwXRR6qEzy1QEqz002
         eylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774563942; x=1775168742;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NdTzJ2knx/A8nF/dOxU4yhfVKOq5sU9Aj61j8WPVqZE=;
        b=YJxFaHkdB/5dx5wPpnhbZ5UgN5D6ZJ2q8h/t4U3BsgxislWFmUkmFgOWt1xKMfdDNl
         R4kDEG7PVxfwAPiRTQ23tcveHr46QupHuvjIra+D+X2MpaEBvw1s1A0a+vM3S0/vfrsr
         ZbI+rOd5pkLuERXdzh2RhFM4WjX6HXaFg5p4OGtzRKlrzvjP9/XituB6db2iW/xnE9em
         iXh0tXdgwI4OnJyIAdTs0ROe5algegh9D0W7YtGKY07hSm0Nm/k6WcyvRCaCyw1RqC0B
         Qdx7C8ubaayx0k92yDy4WJJDJw2NYVA9mFTjLUkVQZhqOacoueZA6k9UHoNJlHNkY8KH
         WbYw==
X-Forwarded-Encrypted: i=1; AJvYcCVUGAoVeOoEcy/PE8lqzi1NGt2beB1UzEHLE9vKgrQg8dY8P17lYtXjypREVvQWt9yJ4oDe6OCtINeYCCMEuY/HRDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVW8xBiRgaVeL3GDzKv/iSuRPKsZShcjKkBRlNqG1hbz5wA4rf
	RDrxY1qnOvoEs8dLuFfykPbAX75lZV9Seg2XPO/OIGW5lx3Rab+jJ4aeehrGtXlAwDFXk7/bGXc
	vHtXj8lPH1xrEnQAqX8lOV+9iHw==
X-Received: from pgmc18.prod.google.com ([2002:a63:1c52:0:b0:c62:b045:9c6])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:a613:b0:39b:8dcb:f36d with SMTP id adf61e73a8af0-39c87b62ed8mr216909637.35.1774563941902;
 Thu, 26 Mar 2026 15:25:41 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:24:47 -0700
In-Reply-To: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774563861; l=6049;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=HTZEVC19RcC53M2zFJOXKx3E4yoW/HTjTM3xN8ow870=; b=uEc48GV8on+0fQ8uBTGhWcrb0PLgSO+WOxNKaWbY/+7Aqk0ReLt7gB+ydu3HEXGauVkuxE5ig
 nsML4IvRgkLAnNEduyZAUtxVKvwTGuIvP0C83uzA53a/ilyROx1iLj0
X-Mailer: b4 0.14.3
Message-ID: <20260326-gmem-inplace-conversion-v4-38-e202fe950ffd@google.com>
Subject: [PATCH RFC v4 38/44] KVM: selftests: Provide common function to set
 memory attributes
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

From: Sean Christopherson <seanjc@google.com>

Introduce vm_mem_set_memory_attributes(), which handles setting of memory
attributes for a range of guest physical addresses, regardless of whether
the attributes should be set via guest_memfd or via the memory attributes
at the VM level.

Refactor existing vm_mem_set_{shared,private} functions to use the new
function.

Update existing caller of vm_mem_set_private().

Signed-off-by: Sean Christopherson <seanjc@google.com>
Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/guest_memfd_test.c     |  2 +-
 tools/testing/selftests/kvm/include/kvm_util.h     | 47 ++++++++++++++++------
 tools/testing/selftests/kvm/lib/x86/sev.c          |  2 +-
 .../testing/selftests/kvm/pre_fault_memory_test.c  |  2 +-
 .../selftests/kvm/x86/private_mem_kvm_exits_test.c |  4 +-
 5 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 10b57fd4fa9ba..ff8c0c56399dd 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -506,7 +506,7 @@ static void test_guest_private_mem(void)
 		   fd, 0, 0);
 
 	virt_map(vm, gpa, gpa, npages);
-	vm_mem_set_private(vm, gpa, page_size);
+	vm_mem_set_private(vm, gpa, page_size, 0);
 
 	vcpu_args_set(vcpu, 1, gpa);
 	vcpu_run(vcpu);
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 3434f3df028b0..d975cc3047a2d 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -456,18 +456,6 @@ static inline void vm_set_memory_attributes(struct kvm_vm *vm, uint64_t gpa,
 	vm_ioctl(vm, KVM_SET_MEMORY_ATTRIBUTES2, &attr);
 }
 
-static inline void vm_mem_set_private(struct kvm_vm *vm, uint64_t gpa,
-				      uint64_t size)
-{
-	vm_set_memory_attributes(vm, gpa, size, KVM_MEMORY_ATTRIBUTE_PRIVATE);
-}
-
-static inline void vm_mem_set_shared(struct kvm_vm *vm, uint64_t gpa,
-				     uint64_t size)
-{
-	vm_set_memory_attributes(vm, gpa, size, 0);
-}
-
 static inline int __gmem_set_memory_attributes(int fd, loff_t offset,
 					       uint64_t size,
 					       uint64_t attributes,
@@ -536,6 +524,41 @@ static inline void gmem_set_shared(int fd, loff_t offset, uint64_t size, u64 fla
 	gmem_set_memory_attributes(fd, offset, size, 0, flags);
 }
 
+static inline void vm_mem_set_memory_attributes(struct kvm_vm *vm, uint64_t gpa,
+						uint64_t size, uint64_t attrs,
+						u64 flags)
+{
+	if (kvm_has_gmem_attributes) {
+		uint64_t end = gpa + size;
+		uint64_t addr, len;
+		off_t fd_offset;
+		int fd;
+
+		for (addr = gpa; addr < end; addr += len) {
+			fd = kvm_gpa_to_guest_memfd(vm, addr, &fd_offset, &len);
+			len = min(end - addr, len);
+
+			gmem_set_memory_attributes(fd, fd_offset, len, attrs, flags);
+		}
+	} else {
+		TEST_ASSERT(!flags, "Flags are not supported.");
+		vm_set_memory_attributes(vm, gpa, size, attrs);
+	}
+}
+
+static inline void vm_mem_set_private(struct kvm_vm *vm, uint64_t gpa,
+				      uint64_t size, u64 flags)
+{
+	vm_mem_set_memory_attributes(vm, gpa, size,
+				     KVM_MEMORY_ATTRIBUTE_PRIVATE, flags);
+}
+
+static inline void vm_mem_set_shared(struct kvm_vm *vm, uint64_t gpa,
+				     uint64_t size, u64 flags)
+{
+	vm_mem_set_memory_attributes(vm, gpa, size, 0, flags);
+}
+
 void vm_guest_mem_fallocate(struct kvm_vm *vm, uint64_t gpa, uint64_t size,
 			    bool punch_hole);
 
diff --git a/tools/testing/selftests/kvm/lib/x86/sev.c b/tools/testing/selftests/kvm/lib/x86/sev.c
index c3a9838f4806a..d3a7241e5fc13 100644
--- a/tools/testing/selftests/kvm/lib/x86/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86/sev.c
@@ -33,7 +33,7 @@ static void encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *regio
 		const uint64_t offset = (i - lowest_page_in_region) * vm->page_size;
 
 		if (private)
-			vm_mem_set_private(vm, gpa_base + offset, size);
+			vm_mem_set_private(vm, gpa_base + offset, size, 0);
 
 		if (is_sev_snp_vm(vm))
 			snp_launch_update_data(vm, gpa_base + offset,
diff --git a/tools/testing/selftests/kvm/pre_fault_memory_test.c b/tools/testing/selftests/kvm/pre_fault_memory_test.c
index 93e603d91311c..3b2c4179d42ee 100644
--- a/tools/testing/selftests/kvm/pre_fault_memory_test.c
+++ b/tools/testing/selftests/kvm/pre_fault_memory_test.c
@@ -188,7 +188,7 @@ static void __test_pre_fault_memory(unsigned long vm_type, bool private)
 	virt_map(vm, gva, gpa, TEST_NPAGES);
 
 	if (private)
-		vm_mem_set_private(vm, gpa, TEST_SIZE);
+		vm_mem_set_private(vm, gpa, TEST_SIZE, 0);
 
 	pre_fault_memory(vcpu, gpa, 0, SZ_2M, 0, private);
 	pre_fault_memory(vcpu, gpa, SZ_2M, PAGE_SIZE * 2, PAGE_SIZE, private);
diff --git a/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c b/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c
index 13e72fcec8dd2..cbcb5d6d04436 100644
--- a/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c
+++ b/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c
@@ -63,7 +63,7 @@ static void test_private_access_memslot_deleted(void)
 	virt_map(vm, EXITS_TEST_GVA, EXITS_TEST_GPA, EXITS_TEST_NPAGES);
 
 	/* Request to access page privately */
-	vm_mem_set_private(vm, EXITS_TEST_GPA, EXITS_TEST_SIZE);
+	vm_mem_set_private(vm, EXITS_TEST_GPA, EXITS_TEST_SIZE, 0);
 
 	pthread_create(&vm_thread, NULL,
 		       (void *(*)(void *))run_vcpu_get_exit_reason,
@@ -99,7 +99,7 @@ static void test_private_access_memslot_not_private(void)
 	virt_map(vm, EXITS_TEST_GVA, EXITS_TEST_GPA, EXITS_TEST_NPAGES);
 
 	/* Request to access page privately */
-	vm_mem_set_private(vm, EXITS_TEST_GPA, EXITS_TEST_SIZE);
+	vm_mem_set_private(vm, EXITS_TEST_GPA, EXITS_TEST_SIZE, 0);
 
 	exit_reason = run_vcpu_get_exit_reason(vcpu);
 

-- 
2.53.0.1018.g2bb0e51243-goog

