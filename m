Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60DF376461
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 06:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382402; cv=none; b=dw9p5fAqEsDXo6+vdr0EUlZTSQO0WlrSPqzq/FQ23hwwwe8iuyvCBgi4cNvT1O2ULPFbr/K9n4u2g7HPwJMqKndoLzIh1Q147W94tMdOiWYQIK4LWG35HAP4fxvwz+yuLWFSrMAtuohTuq1fCCQirlc9qtJ5tz3vFCEDlhDlfpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382402; c=relaxed/simple;
	bh=VCCSpA3AS6hHm+ENDcF9qJ8iBl7sQQf1o45kkgk5fZw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ALQwliKS5/WNR4WuG9FU7iW+fgWve2coNQBARjS/mLw15FF0tg/qQTm21FMeIY60FZtGV15RSN7hyGFXsHsLYoX19xftEF64b8UYMBOAh6sLmPQV9YdLBb8tGr8jZvkJmdFcXiHZkUFhKOqR3iQSQBlkeHEOMYQp5jGDE3Th3v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fYgG43c5; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fYgG43c5"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35a032cdd78so8139646a91.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 23:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773382400; x=1773987200; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qgXFoz9ekKe+3sYo8ozU6H5YkwmF/X37i5aAwoxFjgg=;
        b=fYgG43c5ESftIYTZqQiebsO7uErm4AZwi+ZduXB0aJEhAl9YjA3jBXJz9SsLX+oRyG
         rDl9cilE4qeRALLJoWkC7xg1juOs5jY3hMEC3xVP13VQZK4L+U5iElNNZjuqdnyu8s93
         POXbGmFPVkDCv6QMDRJDfabVUn3RcDrXQmaYSv0TGrWg+0USPKlkMpNqd4chgjMA9uDb
         Cw/ch3awjvSbHldaqmLOpBWDZlnIIBsm+i2DJmQWrpYWrFqJPOIBscIADL5H9RMhiyep
         LcyW0wOkysbG+5bDv+lRZV6aHEVzzrC3MJT4uHldRRCSNuFYvE2BDqN26aAfLmd3x2aL
         NKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382400; x=1773987200;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qgXFoz9ekKe+3sYo8ozU6H5YkwmF/X37i5aAwoxFjgg=;
        b=rYqgmml4nV505DU2vgr1/X4Z2Ap6A3iaf4R/RO0BCMLM2ED9mU7ntT0KX52fxL6FDw
         WN/NnFf2fs+RKAGfn4BU8k9PhLdZf3sexPX/VyRFd8D+Ub1IBES6/P1Arw3kUwL+VzeZ
         k580utybMQHBbdfvYQ49h51Ko+ZH+beZ8A6kHvRUTj0cOxTw2x+/+sixzo8Wj43WvhPf
         HrGqrVnBF+oLTaKMjo7pd5JH8swmca/AgLutYmpky0C6dFEIW2bHf29k4triiA7dtDdW
         sfhj8jEAnqyNKVcs86rWXVa24E4J3mLLGjyHty+kJ+FtrGKDmoJaZAwobePDOB6Nu6Ln
         V3XA==
X-Forwarded-Encrypted: i=1; AJvYcCUrCscli8AzdDt6g54SlYYkh93wdr8f6QiQ+MDHIt+v/Ya57Mv/fkMlVrksTZyFgC4DkCS2EoB5IB1xX2A52u01Ed4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH6iAjTp38jilZtbbIwsSHimrmqMvAnxc0Z4RsY6VxsbZHLUD/
	Dl8BGVVqmZT6eHh3a6H4DY4s36chfyRf363hzO7KyhdO0sj3EbXDSzrJImHm4EDbizC2ciyTCzG
	wwI2zbu+EQP/ULjsbc0Jecras2A==
X-Received: from pjst18.prod.google.com ([2002:a17:90b:192:b0:359:8c74:aec4])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1d03:b0:359:8f13:667d with SMTP id 98e67ed59e1d1-35a22055567mr1949026a91.27.1773382400064;
 Thu, 12 Mar 2026 23:13:20 -0700 (PDT)
Date: Fri, 13 Mar 2026 06:12:58 +0000
In-Reply-To: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773382364; l=3774;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=VCCSpA3AS6hHm+ENDcF9qJ8iBl7sQQf1o45kkgk5fZw=; b=iXgh6mA1Etl3js3hch/keoCikkJCcLY3s1QnWww0YCaa/ZORCpXXO+66olCvqtMLrfcOFvoR6
 DMDJaFSivFLARj0oi3HU+1SYFbao41Lxm0jgSldlNi7OwRzR7QVwiTK
X-Mailer: b4 0.14.3
Message-ID: <20260313-gmem-inplace-conversion-v3-19-5fc12a70ec89@google.com>
Subject: [PATCH RFC v3 19/43] KVM: selftests: Test using guest_memfd for guest
 private memory
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
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

Add a selftest to verify that a memory region backed by a guest_memfd
can be used as private guest memory. This is a key use case for
confidential computing guests where the host should not have access to the
guest's memory contents.

The new test, test_guest_private_mem, creates a protected VM, maps a
guest_memfd into the guest's address space, and then marks the region as
private. The guest code then writes to and reads from this private memory
region to verify it is accessible.

To better distinguish between the test cases, rename the existing test
that verifies shared host/guest access from test_guest_memfd_guest to
test_guest_shared_mem.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/guest_memfd_test.c | 57 ++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index cc329b57ce2e9..10b57fd4fa9ba 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -406,7 +406,7 @@ static void test_guest_memfd(unsigned long vm_type)
 	kvm_vm_free(vm);
 }
 
-static void guest_code(uint8_t *mem, uint64_t size)
+static void guest_code_test_guest_shared_mem(uint8_t *mem, uint64_t size)
 {
 	size_t i;
 
@@ -418,7 +418,7 @@ static void guest_code(uint8_t *mem, uint64_t size)
 	GUEST_DONE();
 }
 
-static void test_guest_memfd_guest(void)
+static void test_guest_shared_mem(void)
 {
 	/*
 	 * Skip the first 4gb and slot0.  slot0 maps <1gb and is used to back
@@ -437,7 +437,8 @@ static void test_guest_memfd_guest(void)
 	if (!kvm_check_cap(KVM_CAP_GUEST_MEMFD_FLAGS))
 		return;
 
-	vm = __vm_create_shape_with_one_vcpu(VM_SHAPE_DEFAULT, &vcpu, 1, guest_code);
+	vm = __vm_create_shape_with_one_vcpu(VM_SHAPE_DEFAULT, &vcpu, 1,
+					     guest_code_test_guest_shared_mem);
 
 	TEST_ASSERT(vm_check_cap(vm, KVM_CAP_GUEST_MEMFD_FLAGS) & GUEST_MEMFD_FLAG_MMAP,
 		    "Default VM type should support MMAP, supported flags = 0x%x",
@@ -469,6 +470,53 @@ static void test_guest_memfd_guest(void)
 	kvm_vm_free(vm);
 }
 
+static void guest_code_test_guest_private_mem(uint8_t *mem)
+{
+	WRITE_ONCE(mem[0], 0xff);
+	GUEST_ASSERT_EQ(READ_ONCE(mem[0]), 0xff);
+
+	GUEST_DONE();
+}
+
+static void test_guest_private_mem(void)
+{
+	const struct vm_shape shape = {
+		.mode = VM_MODE_DEFAULT,
+		.type = KVM_X86_SW_PROTECTED_VM,
+	};
+	/*
+	 * Skip the first 4gb and slot0.  slot0 maps <1gb and is used to back
+	 * the guest's code, stack, and page tables, and low memory contains
+	 * the PCI hole and other MMIO regions that need to be avoided.
+	 */
+	const uint64_t gpa = SZ_4G;
+	const int slot = 1;
+
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	size_t npages;
+	int fd;
+
+	npages = page_size / getpagesize();
+	vm = __vm_create_shape_with_one_vcpu(shape, &vcpu, npages,
+					     guest_code_test_guest_private_mem);
+
+	fd = vm_create_guest_memfd(vm, page_size, 0);
+	vm_mem_add(vm, VM_MEM_SRC_SHMEM, gpa, slot, npages, KVM_MEM_GUEST_MEMFD,
+		   fd, 0, 0);
+
+	virt_map(vm, gpa, gpa, npages);
+	vm_mem_set_private(vm, gpa, page_size);
+
+	vcpu_args_set(vcpu, 1, gpa);
+	vcpu_run(vcpu);
+
+	TEST_ASSERT_EQ(get_ucall(vcpu, NULL), UCALL_DONE);
+
+	close(fd);
+	kvm_vm_free(vm);
+}
+
 int main(int argc, char *argv[])
 {
 	unsigned long vm_types, vm_type;
@@ -488,5 +536,6 @@ int main(int argc, char *argv[])
 	for_each_set_bit(vm_type, &vm_types, BITS_PER_TYPE(vm_types))
 		test_guest_memfd(vm_type);
 
-	test_guest_memfd_guest();
+	test_guest_shared_mem();
+	test_guest_private_mem();
 }

-- 
2.53.0.851.ga537e3e6e9-goog

