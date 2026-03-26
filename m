Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774793E3C72
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 22:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563956; cv=none; b=AA0mDEsMh2cNEkMdLDV8nr7eDi2DDC5xloCV7T22WgKFR5+mVgju0SYiVKqf/ypA9jnN0QZRzTa0cQyK53AK2Y1T6PHYJIJrV/CI8EqbQxiCXWRO+Kk/WanUURa50mNCnZWT3n37v8jTSlIdCWab4M7obi6/512D1Y06mB68uX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563956; c=relaxed/simple;
	bh=ZhM8xOm5+doKADQlrumIE2RLmxJeg0RcHplnkyjK7i8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L4kIBgv8mFM0lbEYixnq9+m3Eq+hM6a54Oen/FLI+v/LjzfL0kkT38FdF4mYWAp5ZH8AvEaC/W+p7odmMjdE/BmN1qUqWNI0sVbuiM/e1Iu0B1iceVA8QXFszX54407wZpoLerEeXu4uv5g7qrnzdXYTcORJuMbmn+hs32kVtZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O/p9iK6F; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O/p9iK6F"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2aec07e8aafso10287915ad.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 15:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774563955; x=1775168755; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HYq3s+F9mgPwmWrETdAju7b1wzJHYtnrsY9IbvdmqE0=;
        b=O/p9iK6FUUUjsmcIGFyX+3MexKMppjm614iNBml3tIr+yiB0RLkBcJQD6MIrCr69FS
         8FeRFfclcPETMHdmrwupP7aTdXWJIredVdSEwp4an1JgHYddB4NjLW+sFqMPSiwlJjgM
         pjECbPsDeTUf1bLmYaVbueY3pMuUyxnJoRks3UYa3Q2BeYSQ2QB26385Ewes0jOJGrQF
         TY+O8L0NmJyd6H4QWOe2F4gx6vTycii4ZygbzhDvTXAPeJgkZfqfGxmKFqLEUDy7wUG/
         1ZmnwOGHGfheBShB3t0aspteIqswcDQbNIfHLmlVebcaiBSqBogBsxDxTscd8FPTAvoF
         FGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774563955; x=1775168755;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HYq3s+F9mgPwmWrETdAju7b1wzJHYtnrsY9IbvdmqE0=;
        b=eQIR5r523Y8hEhnS+ED2T3Qon7Lrz4yUjONHUjtEQLj5bnKwlyHjosk2o2L3DwU+Ql
         8GQN26dNCPrLK9kE9R7AGJ3m4N0rds9XwMI2uyBDc4oOW8OjskgTNY+1RlQob51ezlVM
         B1jRujqez7EW+LP5md1b7Zxil6LlFm02XiNLfLMAhrWgsCZX9k/KTQVW4+qR4eHSd/cC
         qjZ5eO2/5p5aHR+d9kKBxSdb9HnivsBMAZT24uFVy+iggEEGJcZSQyLQne7iVki4HE7V
         cKY8NXOGR0J0cciX5nYMWR3vol96Rlao+fyf5j8LYH4PfPW4KoZu8kbiNNUIE8ldMbfW
         UUJw==
X-Forwarded-Encrypted: i=1; AJvYcCVK54TzOz9y1gNIv8EyMu2ch0ePYtclARbao1yqffKLHMKtFWyUtgcquAhXWwCIJhMfEnevEfsYO3q5u1fPV6rQkWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY8v+TVnS52f6SLBAHCNaenoAV2z75kMWAT+H8l0tgwbmKx8d/
	BeKC1UjqGnhPBJ3tfyCzGnmhtI5wn4HHGWuLauKaDiOIgU1HJG6/0hXG1vEGf9oIYJTvwZLx/9O
	g80FIDNTbBivA9CSyt1khgBoDug==
X-Received: from plpw13.prod.google.com ([2002:a17:902:9a8d:b0:2b0:6121:c2d1])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ccd2:b0:2b0:5520:f497 with SMTP id d9443c01a7336-2b0cdc0f454mr2752855ad.9.1774563954612;
 Thu, 26 Mar 2026 15:25:54 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:24:53 -0700
In-Reply-To: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774563861; l=3745;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=ZGSq+gTFZDY/anw9T28+HYi6HmGJV6iDHsC4BSDh08w=; b=bl10NJA+tRza4190u7kAzLQjI0OEISMmC1hhtBIOQpOao11zciKPixnzxzkJzUPyjzD9rwpIj
 X6HVw8GptTzD9pYDEM6AtX43w8wyaJLsoqTW8KTBj/fh9MfJfpHu8EW
X-Mailer: b4 0.14.3
Message-ID: <20260326-gmem-inplace-conversion-v4-44-e202fe950ffd@google.com>
Subject: [PATCH RFC v4 44/44] KVM: selftests: Update private memory exits test
 to work with per-gmem attributes
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

Skip setting memory to private in the private memory exits test when using
per-gmem memory attributes, as memory is initialized to private by default
for guest_memfd, and using vm_mem_set_private() on a guest_memfd instance
requires creating guest_memfd with GUEST_MEMFD_FLAG_MMAP (which is totally
doable, but would need to be conditional and is ultimately unnecessary).

Expect an emulated MMIO instead of a memory fault exit when attributes are
per-gmem, as deleting the memslot effectively drops the private status,
i.e. the GPA becomes shared and thus supports emulated MMIO.

Skip the "memslot not private" test entirely, as private vs. shared state
for x86 software-protected VMs comes from the memory attributes themselves,
and so when doing in-place conversions there can never be a disconnect
between the expected and actual states.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86/private_mem_kvm_exits_test.c | 36 ++++++++++++++++++----
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c b/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c
index cbcb5d6d04436..ed1bf27d149dc 100644
--- a/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c
+++ b/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c
@@ -62,8 +62,9 @@ static void test_private_access_memslot_deleted(void)
 
 	virt_map(vm, EXITS_TEST_GVA, EXITS_TEST_GPA, EXITS_TEST_NPAGES);
 
-	/* Request to access page privately */
-	vm_mem_set_private(vm, EXITS_TEST_GPA, EXITS_TEST_SIZE, 0);
+	/* Request to access page privately. */
+	if (!kvm_has_gmem_attributes)
+		vm_mem_set_private(vm, EXITS_TEST_GPA, EXITS_TEST_SIZE, 0);
 
 	pthread_create(&vm_thread, NULL,
 		       (void *(*)(void *))run_vcpu_get_exit_reason,
@@ -74,10 +75,26 @@ static void test_private_access_memslot_deleted(void)
 	pthread_join(vm_thread, &thread_return);
 	exit_reason = (uint32_t)(uint64_t)thread_return;
 
-	TEST_ASSERT_EQ(exit_reason, KVM_EXIT_MEMORY_FAULT);
-	TEST_ASSERT_EQ(vcpu->run->memory_fault.flags, KVM_MEMORY_EXIT_FLAG_PRIVATE);
-	TEST_ASSERT_EQ(vcpu->run->memory_fault.gpa, EXITS_TEST_GPA);
-	TEST_ASSERT_EQ(vcpu->run->memory_fault.size, EXITS_TEST_SIZE);
+	/*
+	 * If attributes are tracked per-gmem, deleting the memslot that points
+	 * at the gmem instance effectively makes the memory shared, and so the
+	 * read should trigger emulated MMIO.
+	 *
+	 * If attributes are tracked per-VM, deleting the memslot shouldn't
+	 * affect the private attribute, and so KVM should generate a memory
+	 * fault exit (emulated MMIO on private GPAs is disallowed).
+	 */
+	if (kvm_has_gmem_attributes) {
+		TEST_ASSERT_EQ(exit_reason, KVM_EXIT_MMIO);
+		TEST_ASSERT_EQ(vcpu->run->mmio.phys_addr, EXITS_TEST_GPA);
+		TEST_ASSERT_EQ(vcpu->run->mmio.len, sizeof(uint64_t));
+		TEST_ASSERT_EQ(vcpu->run->mmio.is_write, false);
+	} else {
+		TEST_ASSERT_EQ(exit_reason, KVM_EXIT_MEMORY_FAULT);
+		TEST_ASSERT_EQ(vcpu->run->memory_fault.flags, KVM_MEMORY_EXIT_FLAG_PRIVATE);
+		TEST_ASSERT_EQ(vcpu->run->memory_fault.gpa, EXITS_TEST_GPA);
+		TEST_ASSERT_EQ(vcpu->run->memory_fault.size, EXITS_TEST_SIZE);
+	}
 
 	kvm_vm_free(vm);
 }
@@ -88,6 +105,13 @@ static void test_private_access_memslot_not_private(void)
 	struct kvm_vcpu *vcpu;
 	uint32_t exit_reason;
 
+	/*
+	 * Accessing non-private memory as private with a software-protected VM
+	 * isn't possible when doing in-place conversions.
+	 */
+	if (kvm_has_gmem_attributes)
+		return;
+
 	vm = vm_create_shape_with_one_vcpu(protected_vm_shape, &vcpu,
 					   guest_repeatedly_read);
 

-- 
2.53.0.1018.g2bb0e51243-goog

