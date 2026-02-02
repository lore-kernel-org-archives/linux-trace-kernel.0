Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF5A396B7A
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Feb 2026 22:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770071474; cv=none; b=NzHSkYMw0MKkiIUgXP/8aiWfY6j4IT2HX0tbLCkQZ+nK/OXIynR3JShX8z3KP6XrpDNW5wg1TaVkkPgHfnCj3XQ3gha0QgyPbMmDS5Kiey95U4YkshPDB59SZp327HamkY9rAHzzkyHoJE5d621AttHGtEzBy1BEpiv5lz4j0D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770071474; c=relaxed/simple;
	bh=x1atF75Hn5gLjDEUUE3PPYTEHPi6ChyyJRVn0RyGk6g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E94j0JccKrinPos26t9u7exGMO2SQMR2vvHAipZGib0E80cDRdgtiIGO4qNnjP6pM/SwBh86mcUcFHzZ18HD8JXXutVGxSqD7OpTgpnuASmdaegvYsn061V8CFjDaSosvJC8zxvfLPvdrE4VSwcGTVZCIfhTwQRnJ9GGRJ8307w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AB5gi4r9; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AB5gi4r9"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a79164b686so50092465ad.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Feb 2026 14:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770071473; x=1770676273; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=73PJKeje0iNAIR1GNYFpAd3eH7mcL0ce4UoR56h3BJs=;
        b=AB5gi4r9x5lRuzxun9qFGNv5gjkA2zf2GxtLdH7q3n+9NNRO5vjlnVKbrb5c4L/WIS
         bCPH2gvPxzwdaTMSmariXlJdd1VpT6urYMg5V2u8Y1Jh1fl/GFOx6pFyCWSp9gsKbNQd
         Fyn5rtRMIN/+ZGVgNnuLZoYTR9oFa5gFN9IHwWOycLNihKB2/ha689/hSMDBKlFn02Zi
         Jxj8YLyvW5YFPnwGWJS/6GddEqLJdwpU0wCpnTrO+GNKpcAy2r9NT9pG51RM7atoWnKr
         PorFTrL6STDD8KsObvtIpFsflf+F76W7ycFVpdBXd+XSZrIyqxwImBUaBdvX4H0d93IZ
         GvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770071473; x=1770676273;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=73PJKeje0iNAIR1GNYFpAd3eH7mcL0ce4UoR56h3BJs=;
        b=jkL/06x0HSD4m5XO7mHE/s91cMR+hKHZ4uhU8kCRKfvoqgwupLWSIZx1mOZ9/Vlq1V
         odt3gWfl0c1Pn0VWqdFHhUNdMKUmMGR7uc4JPkB0E+7hIx7AuLv33bVKsmZ+xxmK1+mE
         ITkqIrJsyDjMur4CP7lTwPOdBkVvhMRl9t9lSiPrN9XKHyE1mAqWetEY476y68BiGtQa
         13tQoUyDf9xv2OoTCkgy5iCpGLJsbUAvGclDns/taFfGq1YCkgRpRIAwYY1CvsnqzCUj
         BVH6ecy8NiqCZnn5zlwAGZsf+0rxT3+DOpQP4PxEuyiIs0d47Mk1d0ijaWgxdOZuxK7S
         4qzA==
X-Forwarded-Encrypted: i=1; AJvYcCW6k2sGrVTa6jdJA4H+B4WFW0XJIA4nqhuSxWCdK1PW4XE3sBgshT0w1pVZza01s4hxaSiUxte0wfTQPLUZKnW5SGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnFHwrqd3gHqS+Djz9pTF4IaogO7i2y67vcD6vB0b8I5/4EorB
	ikuJlnW26XPP5QU4V6w2LrzKN6eEjxYH1NXWSQULwHHv2+R/mWOuuQStriVHM9QbVa23u3XUQqR
	At6Cagm1WqJidfcLpu1njUtzX1w==
X-Received: from plrp6.prod.google.com ([2002:a17:902:b086:b0:2a0:fb30:5444])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2bcc:b0:2a0:fb1c:144c with SMTP id d9443c01a7336-2a8d9592d8dmr118922235ad.5.1770071472890;
 Mon, 02 Feb 2026 14:31:12 -0800 (PST)
Date: Mon,  2 Feb 2026 14:30:09 -0800
In-Reply-To: <cover.1770071243.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1770071243.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <040ace047bcc73160b7a2f479049319739359bbb.1770071243.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 31/37] KVM: selftests: Provide common function to set
 memory attributes
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
	yan.y.zhao@intel.com, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

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
 .../testing/selftests/kvm/include/kvm_util.h  | 44 ++++++++++++++-----
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index b370b70442e8..33905f2ed5c9 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -433,18 +433,6 @@ static inline void vm_set_memory_attributes(struct kvm_vm *vm, uint64_t gpa,
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
@@ -508,6 +496,38 @@ static inline void gmem_set_shared(int fd, loff_t offset, uint64_t size)
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
2.53.0.rc1.225.gd81095ad13-goog

