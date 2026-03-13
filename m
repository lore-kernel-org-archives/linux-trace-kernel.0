Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1143750D1
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 06:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382401; cv=none; b=ZdRss7mxul1ZG4Io+sQ+xhVD6MuprCDzGm6YRbvAz0PqjvaRQgzYYIK942eE1Na0owoEdA4S01JHl7q0Sf1d0jeV6cz1TzH7tDL/bbnXlA5Qy2cF1J9GVodn5LmzdXPmBY/uoC7AXQNpIWCEyP4IYNdfkKIU8icpSjwsyRUUCow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382401; c=relaxed/simple;
	bh=bMuIvbANV6whsHe/9Uf4i1Iz6OP8YGDNiGzY3Lul/Ts=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UYulfg/PU6eDcZbw1X/A6ZdoHLDKG2WimDH1W+qlAGE/EYgSdWuccCh0qhkKwwuJd0rPX5HpAyV0wm9Hy4/Z2XGD3ifT7PSNPocVvAYdyQqIo0f3PrueyAP+GfiTxQbpk9bear+q3BK1xXm5pZcex2KPNisxFt0dkbX63TzBwqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Adlp9YqF; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Adlp9YqF"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-829ba0e63e8so789540b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 23:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773382399; x=1773987199; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QknoZXBKlPCGwx1irT4+gYrnFv4rWV1IvMUMC4bd+4I=;
        b=Adlp9YqFVZ/0kZVl1gOaiLeaP02UyV+gwAzakx1CwddnL7kBVC/leVdTcm6c1LxJTJ
         MQXYiTPquZFkfpLGQc8q+4dgoT3paEPBtRSO6T9/DJFs/Wt2tS09WvrMeY56DdJWlEMo
         6Ykr2b6QgWBgwhj2gi+fmz+mR1hC5rbmeeEF5nxdjJ72eiLtITraskG5TTLyD+EOgHZG
         RicR8o6AY1nL9abTP2kDX8b3ZUaf7+Ad4zEI3Pv9Z9XGErADj/gxPo88rvI/9fSak64d
         VPAQ/9GETTt6G2JGSfrBSkqKZm0SvNvc46PAQ6iGaF0O87LcBEGlEtj3SyM1lib7wkX5
         pxng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382399; x=1773987199;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QknoZXBKlPCGwx1irT4+gYrnFv4rWV1IvMUMC4bd+4I=;
        b=A/PpyatW2gWJtNSpGDXug+GQmHiHt07msUNbHRvVhdTQyT7lbP2K3fse+UKOHJZg3Y
         zRRJztGqURFpO083Yhs8Kifk2RSD6gF2+eZgnmQaTp+NZwxTzQOhzAMjXio0EwvRpBhv
         CPgCSL1RwZslgJXVtJd+ngMXtVpPxKIoE992oZoR5aUhBV1lbc/BiSPM/p6nH7288O8a
         D29nIumGoN8YVI1OwbMPjW5QwONOGh20Vm+z+cf0VXuhIv2m8tQQFlbbA0faQ+1/+qmD
         QPRIscJ/LkabnWHDSuasUYcx1vQ3MUN8HczaEtJDXLXfXHjJSmEL2mypMgjfxeAt2K6d
         OReg==
X-Forwarded-Encrypted: i=1; AJvYcCU0rIBMJovkg0X389NWg+aJFbuPBZwFYpyrZK2LIA3DUfnGKL2ySKFNrv4DIONLz7zcGfwq46JkFP/nZfkOydlMCdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+qKiEriReF1yBi7CdKeLIwyX8TRWquRIMz6i7Rc9HP6ZAuw/7
	xkAakMGERFQxgq58WMi+v1GkLHF33TqzpBWsJcEJ3wt797ggmcNiaD7r1Yf5feAlnRyMng94ZFG
	tbArAVGQGThYNRsZjwHpFb1kaeg==
X-Received: from pfld5.prod.google.com ([2002:a05:6a00:1985:b0:7e8:b7f1:f957])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:23d2:b0:829:6f28:1d6 with SMTP id d2e1a72fcca58-82a196f5730mr1947629b3a.13.1773382398356;
 Thu, 12 Mar 2026 23:13:18 -0700 (PDT)
Date: Fri, 13 Mar 2026 06:12:57 +0000
In-Reply-To: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773382364; l=5329;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=3sSrOJAlZS2IXh3VCeWaAhxTVEFs3kS8NsgUAhaH5Jc=; b=AN1YnbEfb1F2TkaQQpPX1DyWGYGoMBr3dXAuDgbZOWFOOvW8Ejji0gH/z7UKRx+wEouyz10+t
 GVh+DUFSNPcAaHLANfsWx2imPLwzue1iOqejIRs/eDerfBkVTX/eb7Y
X-Mailer: b4 0.14.3
Message-ID: <20260313-gmem-inplace-conversion-v3-18-5fc12a70ec89@google.com>
Subject: [PATCH RFC v3 18/43] KVM: selftests: Add helpers for calling ioctls
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
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
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
 tools/testing/selftests/kvm/include/kvm_util.h | 89 ++++++++++++++++++++++++--
 1 file changed, 82 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index fc55ad3c67485..1c0f41bf847d0 100644
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
@@ -453,6 +465,69 @@ static inline void vm_mem_set_shared(struct kvm_vm *vm, uint64_t gpa,
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
2.53.0.851.ga537e3e6e9-goog

