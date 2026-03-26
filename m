Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC0839F17E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 22:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563915; cv=none; b=p90+/Wt2OdHddspaU0lVJCkpvkzmQhtxkt7ab+bihLgKslohDMXA8CZxCxYm82NksHRr1ptY/4m8PxZBdIJk7g2qCVfnH+WlUtBB34JmAnZumq+2xlefVfqviaSfPMezMR4GkVD74/bYfR7CwnEd1Ii293/BPUqIRyvDh3LXKb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563915; c=relaxed/simple;
	bh=zRxx5/gHPS2JHJuJIs+5pNbq2l0ZSiKHaA8Zk5RuA84=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZwZVfbH5W4glrjw03IxQZE88142C38Sv2st/M7lhd7i9xKt0BXX44ysxMeaD36vSSBsxvSISPAcfV7R7wVhWrxGeFPVwtzyw/AyiGIPxKqwKPdVvKxvLgDDY8yuqbNS3Z5zqwCs+6SN433vn5xC5AKAegUBam57hEnY3p2q+pyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KwXe5RzR; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KwXe5RzR"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82a6906e35fso2987579b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 15:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774563914; x=1775168714; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o5T9NfG8XOkzMLDmEFGNVKs1ndpz9+nD9vrw6ykVGHU=;
        b=KwXe5RzROVPyZibr32Aj2hqkgVYzHv0XOkJkpNQ4szZwLtR718oNlgrPSPvMXTCDwQ
         asRGOn1zZtACT8VlJ58VutWFJPPym8tVxhBd890SHGdS3pwb2U6TDRD/OFnt9RnUpRrH
         7sa/9n/oz5Ich+YGZwYoBlZ+qoApA3K0ay8MZpNKiFHRjRJg1HcJqCyz6i2AeYUHVVSq
         uuC+xZduxs/hT3R4mrVgLjgA3BzblYuUpJOZlNKbpNuMUbWTCCKTpfoyHhz7PsM4IMXa
         OkiGs0SrQToqjUwgYugoNorgtlJ8uo/pOkDsY7BAH92VCBE/Um82nLh7d/6MMPeOPOo2
         vfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774563914; x=1775168714;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o5T9NfG8XOkzMLDmEFGNVKs1ndpz9+nD9vrw6ykVGHU=;
        b=tMjIO4a1yMBAr5PgRopA3Q/IWfNCiHhDry3/OkR3fW9pvGBOyL+zxrwqe8L66NAWw6
         qgBMIBQbZW+p+Q/DNzw0b8Gn96um4L1Fso0GeL/MErfNYCjtlXEptI5bqtKuidRf/zjW
         KEkqLRGNYO+KipQjO3C7osEfVR4AI7USfa6oQUnxfHuOrcMcCZCMP0YH4lNvapDMW2Nw
         7VL0Uor7/XeLzTO+oO+mNvXdRyhM8VcLlKoFLhEdDpDZF3HuevO5QOYK3DxQOeNFIGdt
         i+Bt2nzR8aqt7MCFQi7vbqgKOZIUErwC5zC/cm8R0tCcTcK17SjfFSUH7zhsaTsRcr5Y
         1y+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGq40jKBVurC9NfHEegQnCoZ5RgSMlxqOcm1ltFlwBszGm4CnwCjqyMSnMYinjOk1Pa9U6zhUKv/D6yZww1iEowIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YypahzuRgoIp9wiDKGsJKlMfVahSe5hXhsbh2cbzvoCed2cEVF+
	idnvSyZ6cTMGl0MNuj/+c+rrw7RBvdUpqOqxnupj81xoOVyXD0BfaCFnn9OBfFtKx0p359F6Gap
	KMkLHTDOmwT21XHpRJMlVHUHQFw==
X-Received: from pfjt19.prod.google.com ([2002:a05:6a00:21d3:b0:829:7eec:794])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:ab89:b0:827:2792:e401 with SMTP id d2e1a72fcca58-82c867801f0mr2756930b3a.15.1774563913210;
 Thu, 26 Mar 2026 15:25:13 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:24:33 -0700
In-Reply-To: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774563861; l=3775;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=zRxx5/gHPS2JHJuJIs+5pNbq2l0ZSiKHaA8Zk5RuA84=; b=VbHUBBR0WU0omOVPBuMXZyxIW6ATPi3tjRPVcgfbz9ptdEr9eML7Tg/j/U1YitZYGTOZMkqw9
 iofJmFKNJQICGz7MXZMzJC3tsckH1ROc9T4vFF1M+jcA/cyGvgNFUVl
X-Mailer: b4 0.14.3
Message-ID: <20260326-gmem-inplace-conversion-v4-24-e202fe950ffd@google.com>
Subject: [PATCH RFC v4 24/44] KVM: selftests: Test using guest_memfd for guest
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
2.53.0.1018.g2bb0e51243-goog

