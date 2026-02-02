Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ED339A812
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Feb 2026 22:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770071484; cv=none; b=I9X6k6Rw4ZVs7iob84wx8G3HBluD3n4yV5/Z35A3H9W6n2QoFZ0EU6CqhihhPLyUj2HUJc/rjJHwDL/LMDFxHOP489TUI0aESkNX8fj6KC9CRYVF5TPoBEg1fJU7T2kvMtT3u9IqjP0svAIketsd0Xm0I2i50HjQgrPhypHjD4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770071484; c=relaxed/simple;
	bh=wZXv+TME0sdMIhDs+Vvo3czPB4m+Wo6+UTulHpD7Eis=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Zi1gxvFYwXJLiR/16vZGWPn+v0G3sCab1ROPF0tqU0NWnXIHZV2BaYb07phiUdtT4nvBV2TtOqaywQJTB9DfV9OftTGTlkzUpmPx2oh4WenB8tBod7eAEfDIg5XdR4pJTpF9IFK1mpF2HeW1yzIziPgTg3vwRIzGMkzJgoelSgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QV5/suOB; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QV5/suOB"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34e70e2e363so5189001a91.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Feb 2026 14:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770071482; x=1770676282; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=N1fK+k68a0pGVmVUxE1g8z3cUW6Ywik4PxEWV42uRsg=;
        b=QV5/suOBX4WSnbGYtepvDhDcmlpSuxyjI9al/ql+nwoKBf+5RBHU0sUD3Z1H60kQl0
         R3pkoDYhJSXBr0AFReFabkd+l7nVkBpvNy29q+pCiSnOIatRv5DQCu8wKDyl2A9s/srF
         xWtN1suRfXUEOaX2Pxdzt8Vow0YbAqi5+Z+AEpuQI+Jr/1bzyDX7JiI1Xp3y2+60vU66
         Ue5/Nk1B11FrTLDoA9T0Z0x90YvgzpguPaBzLz3p6TE8z8mnAlqUabghmh0nr9wjjhwg
         fS85vWr+yET3M3KcYBsbcY9el7NOoHEwMaAOdpfBDy+Goks5r16P40RXqQXbBXSA9KVv
         VIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770071482; x=1770676282;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N1fK+k68a0pGVmVUxE1g8z3cUW6Ywik4PxEWV42uRsg=;
        b=hOLINoWTlmd/Tt61Z6LMS0CHRAz/LNkrhlsCUrP/PLM1ltCLAkWt+J6E5nkzxf28kz
         UAQfO0kPULEm/nWQssr+tnhW2spPETN+6VbN6rX4n7hx42jrCWaKBKJLkY0+ULAejaxR
         2TpOQSHzjoEzDdjFpuT+UOZof4/2J4T+jCfiIO1UKI0mrSMSUgTk4PQg+1Mbf0DZkuXa
         QCRORiUqY8notiBgOWP9mnVGAqrMK1GLyO6LDvPy75HtlLrN//rUxNsPUMah/R9Q/MX+
         se7LJl0naqjRAZlkD+OCXRctU2A1IQXyhXBm0i+/YMkhIyGF48Dc3wpsSPJOOQVkELKU
         l5YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzFJwCAX0R3uH2vYEb/D0M1s9nlWUlvk430qcy2uAzYrevR9jWnxdn9jdDzW66vQyI+GvopYM9sWAG+faQEA7vgVU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+tcjThmaI2UnWCxhzl0GOaE7ptDgZ6KX2k7/yVTYeI6+u3OtJ
	RXZMjEnTaZw2u9pGaRb6pZL5DjXf1JXauivJBDSUcFZ73SIigXK2DDIu2MF0FRCZumk4HQYga+f
	M5hj7gwYKeMFPlaX48+zz1G6VZg==
X-Received: from pjrz22.prod.google.com ([2002:a17:90a:bd96:b0:34c:fbee:f264])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2b8c:b0:340:bde5:c9e3 with SMTP id 98e67ed59e1d1-3543b3ac8eemr11759602a91.23.1770071482558;
 Mon, 02 Feb 2026 14:31:22 -0800 (PST)
Date: Mon,  2 Feb 2026 14:30:15 -0800
In-Reply-To: <cover.1770071243.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1770071243.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <c418c8a29a5849b3b0da5350a26b92d2f2829823.1770071243.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 37/37] KVM: selftests: Update private memory exits test
 work with per-gmem attributes
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
 .../kvm/x86/private_mem_kvm_exits_test.c      | 36 +++++++++++++++----
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c b/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c
index 13e72fcec8dd..10be67441d45 100644
--- a/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c
+++ b/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c
@@ -62,8 +62,9 @@ static void test_private_access_memslot_deleted(void)
 
 	virt_map(vm, EXITS_TEST_GVA, EXITS_TEST_GPA, EXITS_TEST_NPAGES);
 
-	/* Request to access page privately */
-	vm_mem_set_private(vm, EXITS_TEST_GPA, EXITS_TEST_SIZE);
+	/* Request to access page privately. */
+	if (!kvm_has_gmem_attributes)
+		vm_mem_set_private(vm, EXITS_TEST_GPA, EXITS_TEST_SIZE);
 
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
2.53.0.rc1.225.gd81095ad13-goog

