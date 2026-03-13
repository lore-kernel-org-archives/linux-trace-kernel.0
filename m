Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3F437F8DB
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 06:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382426; cv=none; b=mDRJEUEEHFVMJglBkSAEbinyA3Y1QPS3P3T5PdqVC2uf/4rOujYh69j5xwkNlhPgJXuln2FAXG2yOWmgZ9bYQ4wD/fjyEpfFziPEGI5srGPXym+wwd+KGHxTIbhI19xSSX2ASU/wwizAkPpYbb2A1GUlBsj/b5GTLHxANzJWjWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382426; c=relaxed/simple;
	bh=aSgpCJ/+CEz5WLnq+ZIsNaLgtlURyDcAX64hYkmBOv0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ta1Y2x7+R09fNf8vZIu5uNZFIMvfs3eugs18VmPzNAIz3bOtu+N7eRovkikFrk5F/+uXzOzH57p2SWXmrOmaGnKyvtmsJVGLy6vh6mcASvpr125y3xIb5Je8XcPLghfwVCtvPQIsrodKdL80fxnOHjtwy7yIO1Hs80b+SP0qqI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kqRUu7Fx; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kqRUu7Fx"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2aecd4f7c37so4373645ad.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 23:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773382420; x=1773987220; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9BzVYsA3kNACHoMy8wwuYISEzNkcuCvKxQpW69pzKj8=;
        b=kqRUu7FxhBohrsFdkDVnlyyGqYOg926If7Tl6G0csOaNToi6R+5xs1g+vdjBQJTnQR
         g3VSFLuBHI2n3BYOcAZuyZDHdcVWRnMYvN+cUUcWengTb0xQNMB7RPikJxWsfmlaLxNc
         7ybBa7F2dL+bNKI/X7JpgPCYg/+4f0Cdx61PolpJQozOgjuE4auBasSKApx6oXpiPP3I
         n9PiblrQEI4L96kfPJU1xUtF8x2htBdB1WreVDz6iqZAqN20bnHIzAZMncH0Dc+8QI+6
         FrDnd6PR/xQq2d6FBr88aEOHKmeVCSyQ8xbgystmf4kY3Wu0GiZOsSTuJjmN1coiti1S
         LF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382420; x=1773987220;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9BzVYsA3kNACHoMy8wwuYISEzNkcuCvKxQpW69pzKj8=;
        b=mMoBSMMdB7pft9O3NXnK4oVbmwd8vx0ue5GJb/XTZ/VUfEPTc+k+EX374qtq3Th1Dp
         N2hKvOwJJe4O78ddHkzBt76b1UIqWvECc+B8dF00X/R5o7wjUoYJnaeYiUrvazm6Y/hV
         8X51CiDOsADJPR50gf9geFbquCYjHkKYLmYLoolqtonTxVtHBGR8x8/i6Q0FFjnPsxFz
         LK9jMZqWsc9/kd03mB8i90L63uxjN0QVgkgz3gN2kFKlnyAekgyBipnWpDbCXih79E+C
         Jo7ev9NPVmSKL10JShvEdmT+r9gh6/Jr5PujwS4E62ZDnS4w+oW8L+9IKRbfdODjKAMt
         ZGBg==
X-Forwarded-Encrypted: i=1; AJvYcCXwzTT/cO9Mz6oplbv72Df5dxSMPoJxk56+lIdgmMiNMpFJ8E8qLUTfXXLkJ28GIsEyznlklsX+p/87IoHN+Ps+QKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2lG3G0ipqR/Tj6RzJ+v1LDQ4bpzlDJxBjzgmmarGhcx8JMUU/
	LXxEZ1CjBBAYRwLh+6+NJr6wtkz/n5AXXwreWKouJllgp5HvdZp2+wu9Vqf/6nYwmlqlkfaa6vg
	RqEwl9aJzhRxKfek81F0fLmpf3A==
X-Received: from plbmm6.prod.google.com ([2002:a17:903:a06:b0:2ae:bcf8:c324])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:234e:b0:2ae:56bd:5318 with SMTP id d9443c01a7336-2aecaa40072mr17899725ad.22.1773382419519;
 Thu, 12 Mar 2026 23:13:39 -0700 (PDT)
Date: Fri, 13 Mar 2026 06:13:10 +0000
In-Reply-To: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773382364; l=2718;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=v6F0/65iA3JRUfC1QmgBIJnF3zWWs+e6BseTT95B4p4=; b=nDXRIWwyxZomGeHvQUbNSLIecKS8Wq8s9llOyXJlEhoEZMP6VGk4bIHOCwNtANyHljL1bm+gl
 fTm6mXcMhorCTRUTgCnXGkDb7ONsIJel+g5ciJ2+ew9GVxZir+k0FG5
X-Mailer: b4 0.14.3
Message-ID: <20260313-gmem-inplace-conversion-v3-31-5fc12a70ec89@google.com>
Subject: [PATCH RFC v3 31/43] KVM: selftests: Provide common function to set
 memory attributes
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

Introduce vm_mem_set_memory_attributes(), which handles setting of memory
attributes for a range of guest physical addresses, regardless of whether
the attributes should be set via guest_memfd or via the memory attributes
at the VM level.

Refactor existing vm_mem_set_{shared,private} functions to use the new
function.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h | 44 +++++++++++++++++++-------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index f05f5ebf0c569..e4de0050d1ab3 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -456,18 +456,6 @@ static inline void vm_set_memory_attributes(struct kvm_vm *vm, uint64_t gpa,
 	vm_ioctl(vm, KVM_SET_MEMORY_ATTRIBUTES2, &attr);
 }
 
-static inline void vm_mem_set_private(struct kvm_vm *vm, uint64_t gpa,
-				      uint64_t size)
-{
-	vm_set_memory_attributes(vm, gpa, size, KVM_MEMORY_ATTRIBUTE_PRIVATE);
-}
-
-static inline void vm_mem_set_shared(struct kvm_vm *vm, uint64_t gpa,
-				     uint64_t size)
-{
-	vm_set_memory_attributes(vm, gpa, size, 0);
-}
-
 static inline int __gmem_set_memory_attributes(int fd, loff_t offset,
 					       uint64_t size,
 					       uint64_t attributes,
@@ -531,6 +519,38 @@ static inline void gmem_set_shared(int fd, loff_t offset, uint64_t size)
 	gmem_set_memory_attributes(fd, offset, size, 0);
 }
 
+static inline void vm_mem_set_memory_attributes(struct kvm_vm *vm, uint64_t gpa,
+						uint64_t size, uint64_t attrs)
+{
+	if (kvm_has_gmem_attributes) {
+		uint64_t end = gpa + size;
+		uint64_t addr, len;
+		off_t fd_offset;
+		int fd;
+
+		for (addr = gpa; addr < end; addr += len) {
+			fd = kvm_gpa_to_guest_memfd(vm, addr, &fd_offset, &len);
+			len = min(end - addr, len);
+
+			gmem_set_memory_attributes(fd, fd_offset, len, attrs);
+		}
+	} else {
+		vm_set_memory_attributes(vm, gpa, size, attrs);
+	}
+}
+
+static inline void vm_mem_set_private(struct kvm_vm *vm, uint64_t gpa,
+				      uint64_t size)
+{
+	vm_mem_set_memory_attributes(vm, gpa, size, KVM_MEMORY_ATTRIBUTE_PRIVATE);
+}
+
+static inline void vm_mem_set_shared(struct kvm_vm *vm, uint64_t gpa,
+				     uint64_t size)
+{
+	vm_mem_set_memory_attributes(vm, gpa, size, 0);
+}
+
 void vm_guest_mem_fallocate(struct kvm_vm *vm, uint64_t gpa, uint64_t size,
 			    bool punch_hole);
 

-- 
2.53.0.851.ga537e3e6e9-goog

