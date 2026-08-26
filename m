Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107AE3EDAB8
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 09:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735947; cv=none; b=oSStb1M2SFXehnhwy/yWspPxG2OBkDiKS8rn4lVxEA50Yj9lqz+3C9ssv7jks0Wih5fvIZ0eft+l9IN+9I9Jti78pc4ScIAE3rnV4tShLOcdTHYoBbLqgKKnuy7P84cEHkWbD9Qj480AVs0GXy+OndDPv+lsrm0vx4UxZDjXu1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735947; c=relaxed/simple;
	bh=RyMAmvMbBLSqvPJXc5WYL2mZUFTYUNVdM45fTpg7XpA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uZ4p0MAOHwW1035/575vydAQZqyRwzIjV9LyNdillSdK7TfGC4QlJF9krkFolOSfQ5vPy9YcZsWWQYnFNzc4WUqIZcveDG1GhEtO0gF2Sg0EIcDD87UKKibXzb+e0qWg9+/u+lHTSlDvpY6inO0U1RoZ2WA06rGLyBA3qRiHrZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WtsM0H3u; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WtsM0H3u"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1b8088203so1090070a12.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 02:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787735937; x=1788340737; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/81lA0Cpz/oRFwzMFnP0lg485AVXtJOskviG9WvcA48=;
        b=WtsM0H3uBUODEnyH7cEzp6N0nypqIzs0G0gRNlWXNwtHuS8arnEZ5C8H2pjxPsOSRd
         hVU98cIlC8Qu5jRVw92Lw74JOR4/3fPDO+E+XxEpIaw4S7u4UbvFzeGBvjhX89HeOMlu
         80j+dDNcuV0oCeMziWpJPdCJV4VrWVIIJndr+JDLAyueKMebxrP7BntmRZD6cFQ8haUd
         9j/RfhOUiaUmFPsobz6vrWW7zXYHWm5Jyuf+kAMjJvMRt/Dm7ZuuHSwsivVaf83qs3PE
         6TQK0vAey9vV2CaDgRo4x9YVHZhpOxedROOZiH4m16rDIbRc0DCsEzALgXp23Ap0SZSJ
         jC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735937; x=1788340737;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/81lA0Cpz/oRFwzMFnP0lg485AVXtJOskviG9WvcA48=;
        b=Mbw7jeOQoWRX/Ce9J4VmRVUctsbbHKjzrQWpraBCTjRwVB5fKweaahwKK0RAk9uXjh
         AXBTgc9/AjOhyTEljiqXoZB+ludk8KSHKLQW4V0q7KJPsP/NIx5x/HMUe83UW/NCKjrI
         jA0nmc6bA28pQg41+A/FVLuKxEUS3smcI6qDEbqJyqJBojUN7kZjJP2Qiu+yUlZnd24x
         TE4K8vVllGICT3+OdsQB6UsA0Wozfgv32IGX0AIUJe+DvN2TyGwlSgbP56F5+l/7fzlq
         tvDs19HEkk+c6OTTWyFalf7TfQObWbx94Z4rnLR7nppzIIZV7XSvgYw9JMMPoBminFnK
         fkHA==
X-Forwarded-Encrypted: i=1; AHgh+Rp9B73ouc5cgJWDmGNjE0U18aTyWF5vzmKGfpDqsjA8b/tEkNZOUMe2LzMv4Wy7rOSS9uxIK1Ez0Oe4ty4WcsGTvZk=@vger.kernel.org
X-Gm-Message-State: AFuF++n6ZQKrx4qvictRdcOnPAbiBqmXnOnrL2tNyMvHRQkRAJvC18EC
	ZRxkewvOLVLBxs5BlC5iU7Xx5CBA/gt9H4V8wnJCtKp4THP2Jaxztd68sPxvjjMPoFOZiRdXRV9
	x9RRUQBm12qyGK4j+RsgufKou2g==
X-Received: from plat5.prod.google.com ([2002:a17:902:e1c5:b0:2bc:ac01:8af8])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1b44:b0:2d6:ccc5:a3dd with SMTP id d9443c01a7336-2d707a71485mr102551555ad.4.1787735936967;
 Wed, 26 Aug 2026 02:18:56 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:18:27 +0000
In-Reply-To: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787735885; l=5371;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=de7l0dfCPRv0ZFRIHLiesqcC1gyIjIA61Ch8/0FC1RE=; b=+7oSxBwaRZkZFtViFndHGQONA/JOepFmLXygu7h6ctbFbnB5VS7rmsTcrycmZNVjQ7FxUAfj4
 kY06XWKTQARCDaE9SZF9BosN9IpGYMriSQ4JP3/r0vanw2IF0zOZfuR
X-Mailer: b4 0.16.0
Message-ID: <20260826-gmem-inplace-conversion-v11-29-0a15d8a799aa@google.com>
Subject: [PATCH v11 29/46] KVM: selftests: Add helpers for calling ioctls on guest_memfd
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
Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Shivank Garg <shivankg@amd.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h | 94 +++++++++++++++++++++++---
 1 file changed, 86 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index a091c495442a1..575032e9791d2 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -392,6 +392,16 @@ static __always_inline void static_assert_is_vcpu(struct kvm_vcpu *vcpu) { }
 	__TEST_ASSERT_VM_VCPU_IOCTL(!ret, #cmd, ret, (vcpu)->vm);	\
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
 /*
  * Looks up and returns the value corresponding to the capability
  * (KVM_CAP_*) given by cap.
@@ -418,8 +428,16 @@ static inline void vm_enable_cap(struct kvm_vm *vm, u32 cap, u64 arg0)
 	vm_ioctl(vm, KVM_ENABLE_CAP, &enable_cap);
 }
 
+/*
+ * KVM_SET_MEMORY_ATTRIBUTES{,2} overwrites _all_ attributes.  These
+ * flows need significant enhancements to support multiple attributes.
+ */
+#define TEST_ASSERT_SUPPORTED_ATTRIBUTES(attributes)				\
+	TEST_ASSERT(!(attributes) || (attributes) == KVM_MEMORY_ATTRIBUTE_PRIVATE,	\
+		    "Update me to support multiple attributes!")
+
 static inline void vm_set_memory_attributes(struct kvm_vm *vm, gpa_t gpa,
-					    u64 size, u64 attributes)
+					    size_t size, u64 attributes)
 {
 	struct kvm_memory_attributes attr = {
 		.attributes = attributes,
@@ -428,17 +446,11 @@ static inline void vm_set_memory_attributes(struct kvm_vm *vm, gpa_t gpa,
 		.flags = 0,
 	};
 
-	/*
-	 * KVM_SET_MEMORY_ATTRIBUTES overwrites _all_ attributes.  These flows
-	 * need significant enhancements to support multiple attributes.
-	 */
-	TEST_ASSERT(!attributes || attributes == KVM_MEMORY_ATTRIBUTE_PRIVATE,
-		    "Update me to support multiple attributes!");
+	TEST_ASSERT_SUPPORTED_ATTRIBUTES(attributes);
 
 	vm_ioctl(vm, KVM_SET_MEMORY_ATTRIBUTES, &attr);
 }
 
-
 static inline void vm_mem_set_private(struct kvm_vm *vm, gpa_t gpa,
 				      u64 size)
 {
@@ -451,6 +463,72 @@ static inline void vm_mem_set_shared(struct kvm_vm *vm, gpa_t gpa,
 	vm_set_memory_attributes(vm, gpa, size, 0);
 }
 
+static inline int __gmem_set_memory_attributes(int fd, u64 offset,
+					       size_t size, u64 attributes,
+					       u64 *error_offset)
+{
+	struct kvm_memory_attributes2 attr = {
+		.attributes = attributes,
+		.offset = offset,
+		.size = size,
+		.flags = 0,
+		.error_offset = 0,
+	};
+	int r;
+
+	r = __gmem_ioctl(fd, KVM_SET_MEMORY_ATTRIBUTES2, &attr);
+
+	/* Copy error_offset regardless of r so caller can check. */
+	if (error_offset)
+		*error_offset = attr.error_offset;
+
+	return r;
+}
+
+static inline int __gmem_set_private(int fd, u64 offset, size_t size,
+				     u64 *error_offset)
+{
+	return __gmem_set_memory_attributes(fd, offset, size,
+					    KVM_MEMORY_ATTRIBUTE_PRIVATE,
+					    error_offset);
+}
+
+static inline int __gmem_set_shared(int fd, u64 offset, size_t size,
+				    u64 *error_offset)
+{
+	return __gmem_set_memory_attributes(fd, offset, size, 0,
+					    error_offset);
+}
+
+static inline void gmem_set_memory_attributes(int fd, u64 offset,
+					      size_t size, u64 attributes)
+{
+	struct kvm_memory_attributes2 attr = {
+		.attributes = attributes,
+		.offset = offset,
+		.size = size,
+		.flags = 0,
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
+static inline void gmem_set_private(int fd, u64 offset, size_t size)
+{
+	gmem_set_memory_attributes(fd, offset, size,
+				   KVM_MEMORY_ATTRIBUTE_PRIVATE);
+}
+
+static inline void gmem_set_shared(int fd, u64 offset, size_t size)
+{
+	gmem_set_memory_attributes(fd, offset, size, 0);
+}
+
 void vm_guest_mem_fallocate(struct kvm_vm *vm, gpa_t gpa, u64 size,
 			    bool punch_hole);
 

-- 
2.55.0.887.g758fc8c411-goog

