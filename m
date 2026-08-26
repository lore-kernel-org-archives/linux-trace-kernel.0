Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4633B9DA6
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 09:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735968; cv=none; b=EMUDjWWDq2VZ/uM0yXOCJOkC2rXtc+ArWI/X9EMSZvHdBfWW512qyHhBXjzm+f/ZxRYS+Z5b0KUVnnyJpF4JDnOCfbNm48gXpLKoZl2hJtuypq8gGm6yf0x5MS486mNDn8hQr1fbq6JN1tHBoOHAETBiJfRnLuqDfAR1NE9DLgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735968; c=relaxed/simple;
	bh=Fuuvvm9TGdHzuyGqmCG/7y25PwPAioa9a5TcO7RLGpo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TfrRxzTgXYYPZhstuvDSJiic6MEb7q1OMVS4W/nic+3cwnRuNWhXM55N3p3ap6JTCx8jfaZrr6q52TD7JdcBXm3jyvaK7qP26q8WBGRtvlsPZLfHMxXt+vdbA2ejY2X1jvY+VXasRQ3+KWKzdBKIm7Z/BKS5YVD/VT297wbde5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k0jJjNeF; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k0jJjNeF"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ce7dfd33ffso6581355ad.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 02:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787735961; x=1788340761; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AXWpWryZ0kD4G5nvWBMzBSxCtH4Le24D342gsqcLpvE=;
        b=k0jJjNeFLc2D82MWHL6TxpzlDdpQSBQrY+rxF+X/4IDQwLDdfAZ9gOmpPQmxwFWJr1
         wnpmmMGiTtgv7H34zZwzpv/OnCV48K1S177DPll4DDMX3yk4eJU6ZfV7s2iWweghHJ+W
         Ne9rSyMaG+hlMVtQWP4hfT/XBPWxY7EOpDvxaWbH1L/8dT2ByxoNkN/EaPnM3SY2+J8c
         dcQ4WSYWdhDTTGr1xR6obzvrYhCVTZUCPetn6E78sj+YGaLoJ8YscvUfdFZzfuUnFK5H
         qG74jS5u17OEzGANXPkcFDBGvmHK5q0QFA6Ow/Z0o/lfhJO7ROTVj8PC5JnAPN7h15Y2
         52XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735961; x=1788340761;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AXWpWryZ0kD4G5nvWBMzBSxCtH4Le24D342gsqcLpvE=;
        b=Cm7nKCP5sEr8oqhcht5Ossqj9Gup/Wu0nIJ6d/tCsYer4OBnwY5OqxjcTFPNcbmd5T
         OzxMejoOUInbOTIKI6ToksSiRkq3a35Yvh8UFdAMamNPZX0aV37rppLkOr5MZKFZwyXD
         AzzsuUpFVBV/XwaGmvbYXjFVnFBFD0AqRY/1ayQUFxCILJCi2HfyiUsAfn5LFjwWWqAG
         r8CsZRaBN00qEzCxowGCdYtzc1ig2WeOipJJRnJP3SGw6WEMh1Dvrhr3ncv0kXCQ1KAX
         YXRdGBbBd0m8lGXbbGOVL39+iIWzHemclqfwOTEtILIdlihUUVCWEyhdZEUqwFiKZn10
         sWZQ==
X-Forwarded-Encrypted: i=1; AHgh+RpgW1x+TK/TbJr20OxtYvTGMbLvD5TSYpjo5jHiwst+Yrt+6ee6erF99BL8TNIJB74QJnCvUbtlViJy6xbh4YTITTA=@vger.kernel.org
X-Gm-Message-State: AFuF++l/fU5IRTOo+TuwQT1aGt71Ea3a/WLk1eBtThvzcW6Mu3MhFgoP
	xklOZok1fXlFHNxxfIYayejEpeKuWdhEw029iXSRlUVbRkP3OsVKnQpEn3YZfMLee5++wwrjTtQ
	71cwC7Tf0C0siCM7zNytSy441uA==
X-Received: from plda6.prod.google.com ([2002:a17:902:ee86:b0:2d6:6745:22e7])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:22ca:b0:2d6:fd55:3a9d with SMTP id d9443c01a7336-2d707a55a21mr87469675ad.3.1787735960956;
 Wed, 26 Aug 2026 02:19:20 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:18:41 +0000
In-Reply-To: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787735885; l=2538;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=Fuuvvm9TGdHzuyGqmCG/7y25PwPAioa9a5TcO7RLGpo=; b=+J4GD33/HdpdrEFr5MrH+KM1LHa2vckCr8RaWwO2SO5eEYH0A5e7TGCzVEy+C6S/XAfzoI+YF
 gewtvjSJTvnBccflyC8pq4jmTvD+cMIRcYwK2FB6Bp6gHJiHCOw27HK
X-Mailer: b4 0.16.0
Message-ID: <20260826-gmem-inplace-conversion-v11-43-0a15d8a799aa@google.com>
Subject: [PATCH v11 43/46] KVM: selftests: Support guest_memfd attributes in private_mem_conversions_test
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
	linux-coco@lists.linux.dev, Ackerley Tng <ackerleytng@google.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="utf-8"

Update private_mem_conversions_test to support environments where
guest_memfd tracks memory attributes.

At guest_memfd setup time, initialize the guest_memfd as shared to align
with how memory would default to shared when shared/private state was
tracked at the VM level.

When handling a hypercall to set attributes, use
vm_mem_set_memory_attributes() to send the ioctl to the guest_memfd instead
of the VM.

Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../selftests/kvm/x86/private_mem_conversions_test.c   | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
index cf50e9a332c5b..0c94e36575a5e 100644
--- a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
+++ b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
@@ -306,9 +306,12 @@ static void handle_exit_hypercall(struct kvm_vcpu *vcpu)
 	if (do_fallocate)
 		vm_guest_mem_fallocate(vm, gpa, size, map_shared);
 
-	if (set_attributes)
-		vm_set_memory_attributes(vm, gpa, size,
-					 map_shared ? 0 : KVM_MEMORY_ATTRIBUTE_PRIVATE);
+	if (set_attributes) {
+		u64 attrs = map_shared ? 0 : KVM_MEMORY_ATTRIBUTE_PRIVATE;
+
+		vm_mem_set_memory_attributes(vm, gpa, size, attrs);
+	}
+
 	run->hypercall.ret = 0;
 }
 
@@ -383,6 +386,7 @@ static void test_mem_conversions(enum vm_mem_backing_src_type src_type, u32 nr_v
 	struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
 	pthread_t threads[KVM_MAX_VCPUS];
 	struct kvm_vm *vm;
+	u64 gmem_flags;
 	int memfd, i;
 
 	const struct vm_shape shape = {
@@ -397,12 +401,16 @@ static void test_mem_conversions(enum vm_mem_backing_src_type src_type, u32 nr_v
 
 	vm_enable_cap(vm, KVM_CAP_EXIT_HYPERCALL, (1 << KVM_HC_MAP_GPA_RANGE));
 
-	memfd = vm_create_guest_memfd(vm, memfd_size, 0);
+	gmem_flags = 0;
+	if (kvm_has_gmem_attributes)
+		gmem_flags |= GUEST_MEMFD_FLAG_INIT_SHARED;
+
+	memfd = vm_create_guest_memfd(vm, memfd_size, gmem_flags);
 
 	for (i = 0; i < nr_memslots; i++)
 		vm_mem_add(vm, src_type, BASE_DATA_GPA + slot_size * i,
 			   BASE_DATA_SLOT + i, slot_size / vm->page_size,
-			   KVM_MEM_GUEST_MEMFD, memfd, slot_size * i, 0);
+			   KVM_MEM_GUEST_MEMFD, memfd, slot_size * i, gmem_flags);
 
 	for (i = 0; i < nr_vcpus; i++) {
 		gpa_t gpa =  BASE_DATA_GPA + i * per_cpu_size;

-- 
2.55.0.887.g758fc8c411-goog

