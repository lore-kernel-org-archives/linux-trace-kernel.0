Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1A9386453
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 06:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382447; cv=none; b=IqmfVmVwaka/ra+2kTOumKxUuFSpzp9NW2b1svNTkFwWT/bK1GO7q+mplYC36aZ9qM4oZ5GvSjVFYksBUUhsEsF5CbCz0KXUXoTqWZ2Z2nZXOypyFSKbfwwKJZH4ENGm/DuUipWBHT/xXFFVkrfQT3tnutMFql4i9+dlBQLKTDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382447; c=relaxed/simple;
	bh=jMppRVlQD15qfnbHJ+Ggg+oye4+7onduPHPctp/bZDc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=udF3lH5GM64bG7XYaoUzT1OK6X1FOpMgv06Zp9DjB2Uw6Rkp7gd1tahfJt6+oQ3aabQow5LgBhSSOiQr2YxIbwwK0Lo9p94uMPpuatFrFHpRiLshvZi64DbaTDE9xNIOyWCLgG22lDxIrOm7p4f58D1KRy93uhhxJC8qmgIYTJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uM8r25Xz; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uM8r25Xz"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35641c14663so2075554a91.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 23:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773382438; x=1773987238; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=flzVJbpKSMnnP696xfvyJEPIAPVlhNt4vM9KSgemnu8=;
        b=uM8r25XzYUu57Q/sqb9YC8t+Ztg8G9cLy5V3fO7kMnH/gVpCjqT87ye60xidwCB680
         4ya41EJKugrv9B3lOU61qhtNFdvbECAkiUWNlutOPOsTp4aSGvLVnpmG6Hs3mlJXCXJQ
         bDckbACf1yMQcsg8mInD01EuoAaFVICkYwezKF2osNNnqVxaOS37Jsi9sA4IyPvVOi1I
         WQa2/7qz4NlmWxCM7Vb0xebAq1Ve2spjoppbsgafQbNR9f7uTd+FCY5jSiW3C6C0Xj9k
         UTZRy/xzu8rAx0DSAf6Sg5kK6Xbbl+nQ30UupoWcU99baipShHk7gPb1O8WcUDHHEIEP
         wpeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382438; x=1773987238;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=flzVJbpKSMnnP696xfvyJEPIAPVlhNt4vM9KSgemnu8=;
        b=l8Tvo3yi1QCwETyIznpq5FtpbveJC1d+Dy2nIyZTrWA8WQsjM0tbcbT50UP4+5F6TZ
         5yvgCmY9V6k0XAqfA8Nj8EawLXLClcckmJRuBeG+wvX+ZQ83Pp4sW7YP6PakIL5b9pxY
         Tdnath1fH95ohGoRG/Kj7jTdiWNaOxIqGgASsUfNaxHSxaKbuWqjuZk2Y2Z5FEQhTa+e
         JEGXhlAH840zsnDR1DxWSioj6BUz/u7kPDXStM4izo5VOh16h0wXUGFknoBQ9/Pik/ny
         D8Z+yd0m+YXOu/5fjEknVvqwrATx8F/z/vwFoGrbx6d/UDDC2VwD2cVNt5Ke8jQSKeSc
         g1nA==
X-Forwarded-Encrypted: i=1; AJvYcCXqPIfrzumljsi+/e9GxadHRZcuM6opUrUCXXGz0it796/yQRR4eAO+pSzXG80nRC9H8Yf0xelmtnK9WergZ+fsusY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF1qM5pX2oVmFK0sCMClHNaKJwIxs09limGMxIDmaqXkwe56MR
	qeik7w6lU5y8Ar8OVjRjLlvx8dNKUtMnO2Tt7dgDl3yJ737awwhp0CSdc5YzjMxC5C+tFN8nVic
	dNTcsf4wPZrMnM8S501zcfuL1Hw==
X-Received: from pjbft17.prod.google.com ([2002:a17:90b:f91:b0:359:fd48:da4])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1dc7:b0:359:855f:ff96 with SMTP id 98e67ed59e1d1-35a21fbebbemr1940093a91.17.1773382437393;
 Thu, 12 Mar 2026 23:13:57 -0700 (PDT)
Date: Fri, 13 Mar 2026 06:13:21 +0000
In-Reply-To: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773382364; l=4259;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=jMppRVlQD15qfnbHJ+Ggg+oye4+7onduPHPctp/bZDc=; b=qJakjE/0CkAGoXvxJZjY5873T5pbsePJFjPkxQm8krMJzwe6/h+o4LklvbaEU1rmc+z8bMhj6
 rmTNm9YuHMWDdN0AzIP1wjb/NP2XF3MYc5O4S47Km/oeAvRBdI9lVOg
X-Mailer: b4 0.14.3
Message-ID: <20260313-gmem-inplace-conversion-v3-42-5fc12a70ec89@google.com>
Subject: [PATCH RFC v3 42/43] KVM: selftests: Allow flags to be specified in
 set_memory_attributes functions
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

Update the set_memory_attributes-related selftest library functions to
support specification of flags.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h | 36 ++++++++++++++++----------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index e4de0050d1ab3..a89a4f85aefdb 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -459,13 +459,14 @@ static inline void vm_set_memory_attributes(struct kvm_vm *vm, uint64_t gpa,
 static inline int __gmem_set_memory_attributes(int fd, loff_t offset,
 					       uint64_t size,
 					       uint64_t attributes,
-					       loff_t *error_offset)
+					       loff_t *error_offset,
+					       u64 flags)
 {
 	struct kvm_memory_attributes2 attr = {
 		.attributes = attributes,
 		.offset = offset,
 		.size = size,
-		.flags = 0,
+		.flags = flags,
 	};
 	int r;
 
@@ -478,27 +479,30 @@ static inline int __gmem_set_memory_attributes(int fd, loff_t offset,
 }
 
 static inline int __gmem_set_private(int fd, loff_t offset, uint64_t size,
-				     loff_t *error_offset)
+				     loff_t *error_offset, u64 flags)
 {
 	return __gmem_set_memory_attributes(fd, offset, size,
 					    KVM_MEMORY_ATTRIBUTE_PRIVATE,
-					    error_offset);
+					    error_offset, flags);
 }
 
 static inline int __gmem_set_shared(int fd, loff_t offset, uint64_t size,
-				    loff_t *error_offset)
+				    loff_t *error_offset, u64 flags)
 {
-	return __gmem_set_memory_attributes(fd, offset, size, 0, error_offset);
+	return __gmem_set_memory_attributes(fd, offset, size, 0,
+					    error_offset, flags);
 }
 
 static inline void gmem_set_memory_attributes(int fd, loff_t offset,
-					      uint64_t size, uint64_t attributes)
+					      uint64_t size,
+					      uint64_t attributes,
+					      u64 flags)
 {
 	struct kvm_memory_attributes2 attr = {
 		.attributes = attributes,
 		.offset = offset,
 		.size = size,
-		.flags = 0,
+		.flags = flags,
 	};
 
 	TEST_ASSERT_SUPPORTED_ATTRIBUTES(attributes);
@@ -511,16 +515,19 @@ static inline void gmem_set_memory_attributes(int fd, loff_t offset,
 
 static inline void gmem_set_private(int fd, loff_t offset, uint64_t size)
 {
-	gmem_set_memory_attributes(fd, offset, size, KVM_MEMORY_ATTRIBUTE_PRIVATE);
+	gmem_set_memory_attributes(fd, offset, size, KVM_MEMORY_ATTRIBUTE_PRIVATE,
+				   KVM_SET_MEMORY_ATTRIBUTES2_ZERO);
 }
 
 static inline void gmem_set_shared(int fd, loff_t offset, uint64_t size)
 {
-	gmem_set_memory_attributes(fd, offset, size, 0);
+	gmem_set_memory_attributes(fd, offset, size, 0,
+				   KVM_SET_MEMORY_ATTRIBUTES2_ZERO);
 }
 
 static inline void vm_mem_set_memory_attributes(struct kvm_vm *vm, uint64_t gpa,
-						uint64_t size, uint64_t attrs)
+						uint64_t size, uint64_t attrs,
+						u64 flags)
 {
 	if (kvm_has_gmem_attributes) {
 		uint64_t end = gpa + size;
@@ -532,9 +539,10 @@ static inline void vm_mem_set_memory_attributes(struct kvm_vm *vm, uint64_t gpa,
 			fd = kvm_gpa_to_guest_memfd(vm, addr, &fd_offset, &len);
 			len = min(end - addr, len);
 
-			gmem_set_memory_attributes(fd, fd_offset, len, attrs);
+			gmem_set_memory_attributes(fd, fd_offset, len, attrs, flags);
 		}
 	} else {
+		TEST_ASSERT(!flags, "Flags are not supported.");
 		vm_set_memory_attributes(vm, gpa, size, attrs);
 	}
 }
@@ -542,13 +550,13 @@ static inline void vm_mem_set_memory_attributes(struct kvm_vm *vm, uint64_t gpa,
 static inline void vm_mem_set_private(struct kvm_vm *vm, uint64_t gpa,
 				      uint64_t size)
 {
-	vm_mem_set_memory_attributes(vm, gpa, size, KVM_MEMORY_ATTRIBUTE_PRIVATE);
+	vm_mem_set_memory_attributes(vm, gpa, size, KVM_MEMORY_ATTRIBUTE_PRIVATE, 0);
 }
 
 static inline void vm_mem_set_shared(struct kvm_vm *vm, uint64_t gpa,
 				     uint64_t size)
 {
-	vm_mem_set_memory_attributes(vm, gpa, size, 0);
+	vm_mem_set_memory_attributes(vm, gpa, size, 0, 0);
 }
 
 void vm_guest_mem_fallocate(struct kvm_vm *vm, uint64_t gpa, uint64_t size,

-- 
2.53.0.851.ga537e3e6e9-goog

