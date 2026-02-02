Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE76337649E
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Feb 2026 22:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770071454; cv=none; b=eyD1wjf3e6eR68w2R001yIw10aHKUroMoP4UGeSSQUwPnbSTH+Yo5mzHNjcoUmpWy4hMygzY1PAIERvvXnOjOW4PCVNV5juo+rqL8JbHCFF8q+EyFeSwVtSVfRzOVn0gxmyORFpmnizSXNquaRW0Db68vLHj+a+m+5we+s3Rt0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770071454; c=relaxed/simple;
	bh=Uvsd6bdAGEnmGmQd4Ry1auq6/yFlAXHgE1LCGfhg7pw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T33I1Ut4cMdF470In/X6m2GhwWS06dAgDSK/7uyhZ0jHOtahQDIpNA9X2wxCBPTfGkU/l7wiFiu3DU/egDbPYLn1+a6Rre9b55CT7eDePmk3cgrinXI8gHy76dYP4KSD3yaHITvbBWClMIkP60D/to+JDCncf9I9KfJwAHV7DUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d4BL/RcN; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d4BL/RcN"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2a7d7b87977so46416055ad.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Feb 2026 14:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770071452; x=1770676252; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7RNUoiBoMC2uoky/O8FKXZwuVtbvGjbMSNbY2NDZ1UM=;
        b=d4BL/RcNLEmmqdCryKOs2zZ872MLQLfC0QDT3brKbHUvvUN5ne3pajotchiDlPqrvI
         LPvKkEoCV7WQPNRwPqTTPnN8+KuolTnOrZhdqT6wnwoD8Z9nGr3bAhWyAeEI/DenPhhD
         kFvIa9QSTerWlK0FhaV/AiQPLt3hPfbU6IPOiXAcesAwy0oCAVgL69nH+XIY7+1M5QYm
         2PskjDRQi2WDt8CE9VRkvzWiLCmhvHxDVBCJo1VOMhueFFaDLNO9aAMj75GBh9mdadVv
         fowPOIke2OnHFmge3fVlE3ZsCVIuv5OF9ZB8I0rnn2MTPNhpCv3rMG8sx5thsuTGynEL
         6slQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770071452; x=1770676252;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7RNUoiBoMC2uoky/O8FKXZwuVtbvGjbMSNbY2NDZ1UM=;
        b=V7NiiaNWo2XoMvPyxPgjc5Rbpk5tGHqLjbCvEaQ+adKnHX1qPvHA3XuwMEeUzrkQSA
         bIV4GPjXiZwAMj6Ig4I7jcs0EJodlxp6Lggeq7y1x8/kBvEp+g2lHdQRSeM1g3xL17N5
         dTcoSspl4Ax8d6AeJq1pwYdSyblSYwNENFx8XHL6Qa4/fUhj6IYwDa0yskSCtLtBPIgy
         YrEJzMv/NilWy3I3EvONojojjhkh83/SvDeN0fQ8PhE3aX1DCK0ljaZ8CUoH25dRnyQs
         zpA5WmRmnRAiFfPeS41R9e5a3A2HyZDfUj53HgQKG/XpoHeb6mV3hQbY/oxTA9USpfqg
         vVPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwetZE1sAC3ehjwpf5fhPf2jZHhcw3MP2Rmuhllo1kbjQEpy3XeKEJYegGimzsAdB+mHdBbk/Dgw2qjtuQfq7TlpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGDEaAOUd3LdnmYtjuM99EKVucyetxURPwW53Pr7MoE2MSPBDE
	AlXU5cn+KFpq7dJqMjEYhfs45lBFcOApmSN5xbRHH3Ujulq5shswYnsPk4TslDg7D8FbS3MKLTB
	eFZfP6u9QlyI7iLuxU1eCww+3Qg==
X-Received: from pjtg1.prod.google.com ([2002:a17:90a:c301:b0:34f:8d56:3f70])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2b8e:b0:34c:c514:ee1f with SMTP id 98e67ed59e1d1-3543b310da1mr12317430a91.11.1770071451845;
 Mon, 02 Feb 2026 14:30:51 -0800 (PST)
Date: Mon,  2 Feb 2026 14:29:56 -0800
In-Reply-To: <cover.1770071243.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1770071243.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <48396066e5d65920166b09cc9b02ec8a376ef619.1770071243.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 18/37] KVM: selftests: Add helpers for calling ioctls
 on guest_memfd
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
 .../testing/selftests/kvm/include/kvm_util.h  | 89 +++++++++++++++++--
 1 file changed, 82 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 872988197a5c..e767f9a99a7b 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -310,6 +310,16 @@ static inline bool kvm_has_cap(long cap)
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
@@ -394,6 +404,14 @@ static inline void vm_enable_cap(struct kvm_vm *vm, uint32_t cap, uint64_t arg0)
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
@@ -404,12 +422,7 @@ static inline void vm_set_memory_attributes(struct kvm_vm *vm, uint64_t gpa,
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
@@ -417,7 +430,6 @@ static inline void vm_set_memory_attributes(struct kvm_vm *vm, uint64_t gpa,
 	vm_ioctl(vm, KVM_SET_MEMORY_ATTRIBUTES2, &attr);
 }
 
-
 static inline void vm_mem_set_private(struct kvm_vm *vm, uint64_t gpa,
 				      uint64_t size)
 {
@@ -430,6 +442,69 @@ static inline void vm_mem_set_shared(struct kvm_vm *vm, uint64_t gpa,
 	vm_set_memory_attributes(vm, gpa, size, 0);
 }
 
+static inline int __gmem_set_memory_attributes(int fd, loff_t offset,
+					       uint64_t size,
+					       uint64_t attributes,
+					       loff_t *error_offset)
+{
+	struct kvm_memory_attributes2 attr = {
+		.attributes = attributes,
+		.offset = offset,
+		.size = size,
+		.flags = 0,
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
+				     loff_t *error_offset)
+{
+	return __gmem_set_memory_attributes(fd, offset, size,
+					    KVM_MEMORY_ATTRIBUTE_PRIVATE,
+					    error_offset);
+}
+
+static inline int __gmem_set_shared(int fd, loff_t offset, uint64_t size,
+				    loff_t *error_offset)
+{
+	return __gmem_set_memory_attributes(fd, offset, size, 0, error_offset);
+}
+
+static inline void gmem_set_memory_attributes(int fd, loff_t offset,
+					      uint64_t size, uint64_t attributes)
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
+static inline void gmem_set_private(int fd, loff_t offset, uint64_t size)
+{
+	gmem_set_memory_attributes(fd, offset, size, KVM_MEMORY_ATTRIBUTE_PRIVATE);
+}
+
+static inline void gmem_set_shared(int fd, loff_t offset, uint64_t size)
+{
+	gmem_set_memory_attributes(fd, offset, size, 0);
+}
+
 void vm_guest_mem_fallocate(struct kvm_vm *vm, uint64_t gpa, uint64_t size,
 			    bool punch_hole);
 
-- 
2.53.0.rc1.225.gd81095ad13-goog

