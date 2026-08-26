Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A37411F9E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 09:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735973; cv=none; b=f/VICmjxRf4xCtFFJd89v2Sfp8LZYq4/dSwkr1LKqP9r6C6zEe8uL5YQb5YQ1yYSP524cHFOQC7+UUexI2tnQ30sStQndOl3R7F0Q6lkx6dhuKzmIC1nltv8fT+G9vDyTgrVzzqNMGgwXS/JhMxXY+PhWIHBlQCIlZ/RkyTOZ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735973; c=relaxed/simple;
	bh=xmXonNwGKLAtUb2bwJBWmuOd5wwpGb2FmAnXuGqWg5Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KinMr7r3ZRe4e+FuNNoKQSLUsMxauepT6/0NpqZuWgv1k5sO7ke/dNwip3h4RSODSbUofRTX20UFcU7735LRskQoYpHNELnOuHeGFxWzjEFjnPZxvX1gkC9ZulfNp8RHk2Ko5XkHT0d4yqX5UcwSxOGW/eW6m/eaNgr6ulHrBEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pyK8BfrC; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pyK8BfrC"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cfa4e4684bso18095385ad.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 02:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787735967; x=1788340767; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zHYRx/PxkM4WDh18sJtaYTvnxr7wQel9FcKfTX+J+bs=;
        b=pyK8BfrCjXa56unxV6LGbrPo40HmGrqElhsAuAYn9N/TSzabet8+g1FSXAodFXx4+k
         3ZaFAs8i5KanRZX3YTl6bJ2/jCaBY8+/3saadMmpBu/ho8IxtM2Mwhxfm8iJOwS5TBi+
         fDg4gYGPPT2NUGu3R1X4tgnxHSTt1h6+bTWX5Xu6iaNThvo276bJ4k5ItozfxJuElwb3
         TDkWchxnmAfGs4ewbCncoaFgIq3kSG3Hdpm9whNRtKBYB8L26u1VEwSJ96kPdqAkzw0O
         6eKkurpvG6zb1iS7zwAvB5wFxo29XKs1gmvkQ+hQbqRfAFPbyYPf2qfysEGPXvFR1qhU
         72/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735967; x=1788340767;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zHYRx/PxkM4WDh18sJtaYTvnxr7wQel9FcKfTX+J+bs=;
        b=iPoIeIGw5llP2idibKxBW3yCE1yqI8kE2FyzE60s0RwzBLA/FlG7CsU9qdXUpBH3jw
         A8kBTsfnFi6Ch7wHPxagzQ3bLuniKtipAkq5gRo7O/2+nfxUL3SmAJ5rj1DfdqypNMtt
         SVH/NSbRxO80QM8s1ISMdN3b9bh4QHtO9nH+h4VJiSxCsiOQzCwpv8WmFydKryLgRF5g
         Zg5iSQNOWHidiMmEi1x0KpNGnoG8CONTbIdshOzKC2gtD5/qB9NH/H4CyDUQZpsAm44L
         LqaxpdJd29KcN6YX6euHURKLHz58SGlMLUi4dVQLy/Aqwmby4tCET0eT7F6pLWwOD6EJ
         mXdQ==
X-Forwarded-Encrypted: i=1; AHgh+RqKCKMHD/r80uwjJKAZe0xRuF4FOmVCluaFhDGXOwm+GLQCt+L1Y8QtNzPoNtm44xljwtsqQbO6WZMQh8fGT+ZnhEY=@vger.kernel.org
X-Gm-Message-State: AFuF++ln0tz3Fu90MTXExm9bsiktjx4rY1MHOqs5UN61543H58KegdLW
	rG79lEwlf9Wf/D5H3JFZWE4kegUCtFgXtlR0961DbZOYI2eiAQUfGjneCoOHLnP5f2u+1w/KsaL
	6Cy/dsn95VY6pa7BhdFO7BPLmgQ==
X-Received: from pliy16.prod.google.com ([2002:a17:903:3d10:b0:2d6:df8f:1c1e])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3c46:b0:2ca:4f33:e86f with SMTP id d9443c01a7336-2d707b416famr96063915ad.12.1787735966143;
 Wed, 26 Aug 2026 02:19:26 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:18:44 +0000
In-Reply-To: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787735885; l=3875;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=vQ9v01kvEacWoPdLuKsaPZxtunAeY0dQj48sYbjG7N4=; b=gbSXqT9glzhdzcG2yGJgFOkdSClBH/STykulhxs5pk8VoHTx7tcW5OXCdDyC3bBspy0Sm3l0M
 Smrl3PHW5YSBsLqrwOgzhnFVcWIiLWq5w/qaGmstHG1iOBhSjmBT/ar
X-Mailer: b4 0.16.0
Message-ID: <20260826-gmem-inplace-conversion-v11-46-0a15d8a799aa@google.com>
Subject: [PATCH v11 46/46] KVM: selftests: Update private memory exits test to
 work with per-gmem attributes
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
Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Shivank Garg <shivankg@amd.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../selftests/kvm/x86/private_mem_kvm_exits_test.c | 36 ++++++++++++++++++----
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c b/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c
index e6d16e9d61200..f7228e0f1ac61 100644
--- a/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c
+++ b/tools/testing/selftests/kvm/x86/private_mem_kvm_exits_test.c
@@ -62,8 +62,9 @@ static void test_private_access_memslot_deleted(void)
 
 	virt_map(vm, EXITS_TEST_GVA, EXITS_TEST_GPA, EXITS_TEST_NPAGES);
 
-	/* Request to access page privately */
-	vm_mem_set_private(vm, EXITS_TEST_GPA, EXITS_TEST_SIZE);
+	/* Request to access page privately. */
+	if (!kvm_has_gmem_attributes)
+		vm_mem_set_private(vm, EXITS_TEST_GPA, EXITS_TEST_SIZE);
 
 	kvm_pthread_create(&vm_thread, NULL,
 			   (pthread_fn_t)run_vcpu_get_exit_reason, (void *)vcpu);
@@ -73,10 +74,26 @@ static void test_private_access_memslot_deleted(void)
 	kvm_pthread_join(vm_thread, &thread_return);
 	exit_reason = (u32)(u64)thread_return;
 
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
+		TEST_ASSERT_EQ(vcpu->run->mmio.len, sizeof(u64));
+		TEST_ASSERT_EQ(vcpu->run->mmio.is_write, false);
+	} else {
+		TEST_ASSERT_EQ(exit_reason, KVM_EXIT_MEMORY_FAULT);
+		TEST_ASSERT_EQ(vcpu->run->memory_fault.flags, KVM_MEMORY_EXIT_FLAG_PRIVATE);
+		TEST_ASSERT_EQ(vcpu->run->memory_fault.gpa, EXITS_TEST_GPA);
+		TEST_ASSERT_EQ(vcpu->run->memory_fault.size, EXITS_TEST_SIZE);
+	}
 
 	kvm_vm_free(vm);
 }
@@ -87,6 +104,13 @@ static void test_private_access_memslot_not_private(void)
 	struct kvm_vcpu *vcpu;
 	u32 exit_reason;
 
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
2.55.0.887.g758fc8c411-goog

