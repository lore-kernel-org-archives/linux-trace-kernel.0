Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E03739A041
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 22:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563913; cv=none; b=dAJQ/SbAJRbYH54O3JH91azzouOimjgK5tB7czoohf+s5q4M0steis9Hz98Wc7nDc3Y7ztJPv5HJLec5K5gfRUrFqK8W10V3YJCWWkezJZL28M20hCHS69Ai2WUJ8kUJSC6CzRBuyLoZViHE3qMnONRl2zIj1EVJ5CX30idQ+VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563913; c=relaxed/simple;
	bh=yYG3YivBMJIwRv071r6L32F9EbPt+b8iDngttvXtDfE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sYfcFNK+gfu7IOMxKF/xQ6iPi1FYOBlAE+vruV9SR6gskNx/Wl+Rz/PJ9cmEeYRwq/7JunlAXW+yIgWurGco561nSO6tgJnhp1pfx8WaVSjRsu2vw03r4sfXxOd2hsjcedd3U4n+uTgUvZ7yKnn1AwcV9A0pDN03oUMm+pnUGmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NMlAKuvt; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NMlAKuvt"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82c89d4ce16so636934b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 15:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774563912; x=1775168712; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iJLCurHGT9Ozv2z9SVGQ9QgPs5YFI09GMd1yNupksws=;
        b=NMlAKuvtpPAYUI0wjNA0cnhXmsf7+GmeGnPu6Hyf8qg9pFtdArS/7poCQNwm7WUHUt
         Yp6+aO1oeL4eoZNQgoeCFASSavxBFycj8GFJrnBvVpjumR9YK4GDM1FZWjZGZxrH+gqe
         wcodTSwwwVHJjL8o6S7m1sBk3t0NczhP3VsPHsnlnvS5bjZo9BWQF16FEi6E/qZDEGti
         FDujIxqVYZelZwRxfnG6iyvx9sWNDkJZACzQxP3BH98HLiA0z0zN32MNfCUXYScRMDrP
         SVhJYAIWkJHNMJSg+Eub3x4GCLqlcJQH/HHW8EqgVQaPN5khRDCP5CIsypDV3V9WlX1t
         jbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774563912; x=1775168712;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iJLCurHGT9Ozv2z9SVGQ9QgPs5YFI09GMd1yNupksws=;
        b=CKTdHVyh/3DOZ1TudkZwet33N0AB5GwkM9GmdV0z1BjRbv8cQeeWDjcuBo5q3XTYk6
         6I8vUEmyt3KQ/sPxf5lKbV7L02cpQfhu6kifirofd1kfYCTV4qbGK9tvLAedd0kxKo5N
         +Ne9BO37RGiuGQPrM9VRVtuhSie8vOZa4e6mUyNqgPyyVSFx/c3paPxF63z4qU0BQ7+M
         9p1JuFb6+xt42FV5oV+ftzfmBq+D+asQnZTikuB59wRUsgSf6mubBPLsnQHB/nr8wWlL
         evezmzWaZjepLNebQs2qliddmHG8d9QMqLFRySBMxhsP2EnWKFsmPBQ0iTI5o2MZqJbT
         +XuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQnNk2QjylVOPv3hGRZPYFFPj88tAT84tWoiVTSvP3+ulTxxg78gzcbsRGaVmuLuikANLg5yl9RAKBvbrcUanhRcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfoWaTBq9Miz7ONBMp/M5Gb+FYYQtq7B4F+7eeytcCuxs0C3OJ
	uQU9MVE/XAaT+smjea1zEHU9QPEoUuOL8FrN9PSeQddfYftSOSy1ZidlqltPZwle+UZmsUgLtUU
	EtRjywkQEveJC8wAcgqAU/xOWWg==
X-Received: from pfbbe3.prod.google.com ([2002:a05:6a00:1f03:b0:824:a502:8fea])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:ab84:b0:81f:4884:4fed with SMTP id d2e1a72fcca58-82c95d2f63dmr173790b3a.7.1774563911494;
 Thu, 26 Mar 2026 15:25:11 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:24:32 -0700
In-Reply-To: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774563861; l=5492;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=lS+IBAVYXwyHlv6WRF1Ol2Kaf5AEubNCdwiCGV0mlpA=; b=UaxYPJnJsXBYpB+JCRQ8jNBQhVVjBXkwA8wKaHeliaKJ/42jC2aJMtTG8w6UgKW7fyU8fJPka
 BfSgymmQNisA+eaG58gYT/0dNC446XTbQbd/0mLQJ3e1SiqrLkjcNug
X-Mailer: b4 0.14.3
Message-ID: <20260326-gmem-inplace-conversion-v4-23-e202fe950ffd@google.com>
Subject: [PATCH RFC v4 23/44] KVM: selftests: Add helpers for calling ioctls
 on guest_memfd
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

Add helper functions to kvm_util.h to support calling ioctls, specifically
KVM_SET_MEMORY_ATTRIBUTES2, on a guest_memfd file descriptor.

Introduce gmem_ioctl() and __gmem_ioctl() macros, modeled after the
existing vm_ioctl() helpers, to provide a standard way to call ioctls
on a guest_memfd.

Add gmem_set_memory_attributes() and its derivatives (gmem_set_private(),
gmem_set_shared()) to set memory attributes on a guest_memfd region.
Also provide "__" variants that return the ioctl error code instead of
aborting the test. These helpers will be used by upcoming guest_memfd
tests.

To avoid code duplication, factor out the check for supported memory
attributes into a new macro, TEST_ASSERT_SUPPORTED_ATTRIBUTES, and use
it in both the existing vm_set_memory_attributes() and the new
gmem_set_memory_attributes() helpers.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h | 94 ++++++++++++++++++++++++--
 1 file changed, 87 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 1e00bfa59dcd5..a539a98f79e08 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -333,6 +333,16 @@ static inline bool kvm_has_cap(long cap)
 	TEST_ASSERT(!ret, __KVM_IOCTL_ERROR(#cmd, ret));	\
 })
 
+#define __gmem_ioctl(gmem_fd, cmd, arg)				\
+	kvm_do_ioctl(gmem_fd, cmd, arg)
+
+#define gmem_ioctl(gmem_fd, cmd, arg)				\
+({								\
+	int ret = __gmem_ioctl(gmem_fd, cmd, arg);		\
+								\
+	TEST_ASSERT(!ret, __KVM_IOCTL_ERROR(#cmd, ret));	\
+})
+
 static __always_inline void static_assert_is_vm(struct kvm_vm *vm) { }
 
 #define __vm_ioctl(vm, cmd, arg)				\
@@ -417,6 +427,14 @@ static inline void vm_enable_cap(struct kvm_vm *vm, uint32_t cap, uint64_t arg0)
 	vm_ioctl(vm, KVM_ENABLE_CAP, &enable_cap);
 }
 
+/*
+ * KVM_SET_MEMORY_ATTRIBUTES overwrites _all_ attributes.  These flows need
+ * significant enhancements to support multiple attributes.
+ */
+#define TEST_ASSERT_SUPPORTED_ATTRIBUTES(attributes)				\
+	TEST_ASSERT(!attributes || attributes == KVM_MEMORY_ATTRIBUTE_PRIVATE,	\
+		    "Update me to support multiple attributes!")
+
 static inline void vm_set_memory_attributes(struct kvm_vm *vm, uint64_t gpa,
 					    uint64_t size, uint64_t attributes)
 {
@@ -427,12 +445,7 @@ static inline void vm_set_memory_attributes(struct kvm_vm *vm, uint64_t gpa,
 		.flags = 0,
 	};
 
-	/*
-	 * KVM_SET_MEMORY_ATTRIBUTES2 overwrites _all_ attributes.  These flows
-	 * need significant enhancements to support multiple attributes.
-	 */
-	TEST_ASSERT(!attributes || attributes == KVM_MEMORY_ATTRIBUTE_PRIVATE,
-		    "Update me to support multiple attributes!");
+	TEST_ASSERT_SUPPORTED_ATTRIBUTES(attributes);
 
 	__TEST_REQUIRE(kvm_check_cap(KVM_CAP_MEMORY_ATTRIBUTES2) > 0,
 		       "No valid attributes for VM fd ioctl!");
@@ -440,7 +453,6 @@ static inline void vm_set_memory_attributes(struct kvm_vm *vm, uint64_t gpa,
 	vm_ioctl(vm, KVM_SET_MEMORY_ATTRIBUTES2, &attr);
 }
 
-
 static inline void vm_mem_set_private(struct kvm_vm *vm, uint64_t gpa,
 				      uint64_t size)
 {
@@ -453,6 +465,74 @@ static inline void vm_mem_set_shared(struct kvm_vm *vm, uint64_t gpa,
 	vm_set_memory_attributes(vm, gpa, size, 0);
 }
 
+static inline int __gmem_set_memory_attributes(int fd, loff_t offset,
+					       uint64_t size,
+					       uint64_t attributes,
+					       loff_t *error_offset,
+					       u64 flags)
+{
+	struct kvm_memory_attributes2 attr = {
+		.attributes = attributes,
+		.offset = offset,
+		.size = size,
+		.flags = flags,
+	};
+	int r;
+
+	TEST_ASSERT_SUPPORTED_ATTRIBUTES(attributes);
+
+	r = __gmem_ioctl(fd, KVM_SET_MEMORY_ATTRIBUTES2, &attr);
+	if (r)
+		*error_offset = attr.error_offset;
+	return r;
+}
+
+static inline int __gmem_set_private(int fd, loff_t offset, uint64_t size,
+				     loff_t *error_offset, u64 flags)
+{
+	return __gmem_set_memory_attributes(fd, offset, size,
+					    KVM_MEMORY_ATTRIBUTE_PRIVATE,
+					    error_offset, flags);
+}
+
+static inline int __gmem_set_shared(int fd, loff_t offset, uint64_t size,
+				    loff_t *error_offset, u64 flags)
+{
+	return __gmem_set_memory_attributes(fd, offset, size, 0,
+					    error_offset, flags);
+}
+
+static inline void gmem_set_memory_attributes(int fd, loff_t offset,
+					      uint64_t size,
+					      uint64_t attributes,
+					      u64 flags)
+{
+	struct kvm_memory_attributes2 attr = {
+		.attributes = attributes,
+		.offset = offset,
+		.size = size,
+		.flags = flags,
+	};
+
+	TEST_ASSERT_SUPPORTED_ATTRIBUTES(attributes);
+
+	__TEST_REQUIRE(kvm_check_cap(KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES) > 0,
+		       "No valid attributes for guest_memfd ioctl!");
+
+	gmem_ioctl(fd, KVM_SET_MEMORY_ATTRIBUTES2, &attr);
+}
+
+static inline void gmem_set_private(int fd, loff_t offset, uint64_t size, u64 flags)
+{
+	gmem_set_memory_attributes(fd, offset, size,
+				   KVM_MEMORY_ATTRIBUTE_PRIVATE, flags);
+}
+
+static inline void gmem_set_shared(int fd, loff_t offset, uint64_t size, u64 flags)
+{
+	gmem_set_memory_attributes(fd, offset, size, 0, flags);
+}
+
 void vm_guest_mem_fallocate(struct kvm_vm *vm, uint64_t gpa, uint64_t size,
 			    bool punch_hole);
 

-- 
2.53.0.1018.g2bb0e51243-goog

