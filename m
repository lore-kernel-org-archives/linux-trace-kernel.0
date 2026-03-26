Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFEF3C3439
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 23:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774568227; cv=none; b=QXLL6FGYArfmwUlZZU0VD2+a1knrThDNsl+5/PSLL7/ARfQwWCWXEC3aUG1EvH3FhX1zlrFCNyVIhV6ehsqJwqEahkeiY00q1cyCk0VC4nLXYXPRTeBRg+jRiaqPDyzFlY5G6Yx6DRvQN0G4reMCC5b1KmRcIGeyy1c/LDd0HG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774568227; c=relaxed/simple;
	bh=4kN6A4roXpuUCdc9Yp+JZTflHlL0xWy1WzOJQpEHZbI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mL0dfTJII5R7qKjYbWVMUIRLAWQpQ3S4kMfjz625fvlxXZF2rAW0QtL+NO7kaYdbW82lgowTKHyqjiwsu4oG9f50S/fHTQTMCyeVhbeSrWGc8MgOOruCQsp6e3e/F6F1JGWyAW/YG6AzExyVQRO2kRg0JWF61eqcFZTUwCR0VG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QwdX9l6A; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QwdX9l6A"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82c613194caso1215705b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 16:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774568224; x=1775173024; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SLjwHN4/NEPHQ5GPdLGfuv8Jy0iItB0IfnGqB+YcFdI=;
        b=QwdX9l6A2nZ1rjHtjmIM/rxj6SBc4nWuP8xQcaV2ip76VDKgJe5aHucqUMmEx048pf
         Km3PjU8yvfGVNZx25+PEUf4g8cG9/btfEt5CBI4J1WvJRyQtX0SIPY4JUZmHwidJwErT
         Tyh7sAO+odP9iVvkBhF71G8/Mf/JDcx0ILlp5IyCc4eD+Et6lwwuLjFTwy4wb3smqhGx
         5oiQGqnePMkREj4GaNcWERADYx5qp2YLnJC3UYRjG9rMAnU1X1KLzBvu7pSMLufhI0NY
         s4H9u0g7xdIDC5Y+b45UZAY1gDLPeSfuoIsbTqVgmqXLg/5G7k2mzx1aG9BQtCWx+n0o
         /FHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774568224; x=1775173024;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SLjwHN4/NEPHQ5GPdLGfuv8Jy0iItB0IfnGqB+YcFdI=;
        b=H5J+yqaH/rNLS51IFbXbvQV3pnaI0+xstjmHrJYgy+m9tR8mfivKXPet4UPmn13mT3
         lK3FHHRRid8JKJMtq79gi0V11gyHpTJV4vUb+fUz5q5aWlj7DHdCIWTuqsCDUg1caLDg
         Cu5+/6SWUp+aMK5mMzOkCdh1TvyMPTV4VQwIySOgqNV8qyQ9vo/+oHTFvwXbYBlhkrpH
         saen0Yw6j4BNKOejNLkK7bvdCFtYMLDWsh6lB3IrkzxzL0JFUOIm+L4Py41JOXPmJ3iL
         pm726WYCfFWjPmO9UJxCtHt9uAnT8ajq9O0vEUVvZKMqNXcQUOG66QPoXkbe36AJp2UK
         GUBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHR8TsqUe/T9uSgmpgeTs+Y1XBFicIPhXRXnoZPGiznUqYFzTLdV1eC76daK2CKcm1GME/lObNvObqI+lylQ5ko0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTn++MY9xAROpPZalpNPKKbO8DvE9Oou1ToJ5MHcymy6Ds20Oj
	502p31PNj32012P5mtzoU9/MC7mUkMTbZ+9D0nu9N3kHevagHTNN9jiSiCOJiNmCM3g5ExVK+hv
	IltmjZA6tW/uVh7Bdd9I3a8jqTg==
X-Received: from pfblm12.prod.google.com ([2002:a05:6a00:3c8c:b0:829:7245:b797])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:aa04:b0:824:a8f2:7de7 with SMTP id d2e1a72fcca58-82c960a6bcdmr260470b3a.60.1774568224072;
 Thu, 26 Mar 2026 16:37:04 -0700 (PDT)
Date: Thu, 26 Mar 2026 16:36:41 -0700
In-Reply-To: <cover.1774568083.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com> <cover.1774568083.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Message-ID: <fd0d2a694fb71dbcb69a9af7f92474e1896b3f48.1774568083.git.ackerleytng@google.com>
Subject: [POC PATCH 3/6] KVM: selftests: Make guest_code_xsave more friendly
From: Ackerley Tng <ackerleytng@google.com>
To: ackerleytng@google.com
Cc: aik@amd.com, akpm@linux-foundation.org, andrew.jones@linux.dev, 
	aneesh.kumar@kernel.org, axelrasmussen@google.com, baohua@kernel.org, 
	bhe@redhat.com, binbin.wu@linux.intel.com, bp@alien8.de, brauner@kernel.org, 
	chao.p.peng@linux.intel.com, chrisl@kernel.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, david@kernel.org, forkloop@google.com, 
	hpa@zytor.com, ira.weiny@intel.com, jgg@ziepe.ca, jmattson@google.com, 
	jroedel@suse.de, jthoughton@google.com, kasong@tencent.com, 
	kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, michael.roth@amd.com, mingo@redhat.com, 
	nphamcs@gmail.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	pbonzini@redhat.com, pratyush@kernel.org, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, rostedt@goodmis.org, 
	seanjc@google.com, shikemeng@huaweicloud.com, shivankg@amd.com, 
	shuah@kernel.org, skhan@linuxfoundation.org, steven.price@arm.com, 
	suzuki.poulose@arm.com, tabba@google.com, tglx@kernel.org, 
	vannapurve@google.com, vbabka@kernel.org, weixugc@google.com, 
	willy@infradead.org, wyihan@google.com, x86@kernel.org, yan.y.zhao@intel.com, 
	yuanchu@google.com
Content-Type: text/plain; charset="UTF-8"

The original implementation of guest_code_xsave makes a jmp to
guest_sev_es_code in inline assembly. When code that uses guest_sev_es_code
is removed, guest_sev_es_code will be optimized out, leading to a linking
error since guest_code_xsave still tries to jmp to guest_sev_es_code.

Rewrite guest_code_xsave() to instead make a call, in C, to
guest_sev_es_code(), so that usage of guest_sev_es_code() is made known to
the compiler.

This rewriting also gives a name to the xsave inline assembly, improving
readability.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../selftests/kvm/x86/sev_smoke_test.c        | 24 +++++++++++++------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/sev_smoke_test.c b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
index 8bd37a476f159..7e69da01cecf4 100644
--- a/tools/testing/selftests/kvm/x86/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86/sev_smoke_test.c
@@ -80,13 +80,23 @@ static void guest_sev_code(void)
 	GUEST_DONE();
 }
 
-/* Stash state passed via VMSA before any compiled code runs.  */
-extern void guest_code_xsave(void);
-asm("guest_code_xsave:\n"
-    "mov $" __stringify(XFEATURE_MASK_X87_AVX) ", %eax\n"
-    "xor %edx, %edx\n"
-    "xsave (%rdi)\n"
-    "jmp guest_sev_es_code");
+static void xsave_all_registers(void *addr)
+{
+	__asm__ __volatile__(
+		"mov $" __stringify(XFEATURE_MASK_X87_AVX) ", %eax\n"
+		"xor %edx, %edx\n"
+		"xsave (%0)"
+		:
+		: "r"(addr)
+		: "eax", "edx", "memory"
+	 );
+}
+
+static void guest_code_xsave(void *vmsa_gva)
+{
+	xsave_all_registers(vmsa_gva);
+	guest_sev_es_code();
+}
 
 static void compare_xsave(u8 *from_host, u8 *from_guest)
 {
-- 
2.53.0.1018.g2bb0e51243-goog

