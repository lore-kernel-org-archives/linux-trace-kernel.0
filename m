Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CBA3BF66C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Apr 2026 23:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777419216; cv=none; b=jgJYpE2cl8ZSrHsHVxRq80KhEEn3lbVwzJUxEUEBghAaAMSbS1OsAFd0XQe88LfADAYO3k8t+VtZTsWyl6QEULlrcwZTevCa54fQQn3nJhLYvGVwfW67jduhp9xpFHqQlfmetHsD5WFAcEfGFdGqak8LqV6jQj1Ga6HKnwEh9pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777419216; c=relaxed/simple;
	bh=bSl0Ml6IHrW3qDTTj/PbwouszbUAxe7p9oC9LS2cUxY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QHS78twguUGFlgqPwhFf0T1HRWNYAg/deyM32SZsEm9LMjqefSeDIO4HWN4omz6YiNE/k3t/jy1M//qFuV/m/SQ3WdoqahSwfOyXMMBLRfjT/xyxvfXjQvZ2P7KiL9t6q1+bx98CUKhL5t3ELugX91DPktPlF/PXk/VBy39bTuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sXRzH1+O; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sXRzH1+O"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82f0e12d375so6894310b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Apr 2026 16:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777419213; x=1778024013; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MEO36girPr+drwE77RQ8xryHhyT8L0VbpSDbMsS1X7s=;
        b=sXRzH1+OczfbNcKFVhNcp6upBhWHCvRIareDLQHL8T56l/pOUKYeOlFKfF56KkPtf/
         ZbvS7+2b8mhGRFZHHFTz5ALKnsh+Mt8aNu7uG1va55ieUscJXqU8ibpkjgX2l0E8sEL1
         yV254JpSqWrx8l6fMqeFuh8zsJV/PwqRM/3xMYnpi3YAk61sLh8IOXilG81WBy4IYSXo
         1XRzGwbIp+yZpzS/YFzYJgkRoHLQ70aOmGDwUYYLKEE1FUA++QwFjW1a7LW5wgzPtk9J
         ZcYkdu3+WKOVjXv0UEa8E6GVBbCEYoITbiZXcJwt/z8vRyDBnxqBlqon1AN7JYZfAfvQ
         FFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777419213; x=1778024013;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MEO36girPr+drwE77RQ8xryHhyT8L0VbpSDbMsS1X7s=;
        b=HNdnZui8QD1mgfBedB9PESsqMBN45vd0wogJ6KZhEqdC5Ic3SCBXrX8bCU4F5Sfhl4
         JlH/U8hwoEZfyAu5vXlquSuqyBlncvDl1owZpB3At/Kbbhqg0IF4JxwxvhL0rVKLkrKu
         RmMHEpz5Hz+pHfvOVT5CYBZIEVfEJUg/ih/el9xcxj4hozcorVP06gr7bY9JzM+pr6GR
         gg+M4jI01OpH0MjOC55QjyA6KouaXP7SxN+yDuFp1SPgCMm1IhPGS0hBpzkBIxxR9AZi
         tusEMT0TM1+ZiGR8ZfC9xYeb3szDYWSt+jn5c3icdxjhWqFgGcRzL8gW7LLbQBkpCTTG
         V4mA==
X-Forwarded-Encrypted: i=1; AFNElJ+ERGa9oxbtAiA5MyPmJQOIoam0NghB+YjhpxqTdxttqWA76m/u86xCvNXU11e+71nRu+TdtcQ6kP5VPbR3SX9boMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwATf6DJBwfH8K0+O6o2BWXSOr8mkdmKCMwY0XFfHbMuEueax2S
	yCGg6oOZWGbipxdRS3jskjUpoMJHyeDNCza8i5Ylwp8SMwb9VitSe8yY5kKYAcw8clKvVXfZII0
	IZaJIB/69ne+2+++tW3Pzj7gK6w==
X-Received: from pfoo12.prod.google.com ([2002:a05:6a00:1a0c:b0:82f:bc93:4ae2])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1993:b0:82f:120:fd6f with SMTP id d2e1a72fcca58-834dd919817mr4905304b3a.0.1777419212551;
 Tue, 28 Apr 2026 16:33:32 -0700 (PDT)
Date: Tue, 28 Apr 2026 16:33:23 -0700
In-Reply-To: <cover.1777418884.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428-gmem-inplace-conversion-v5-0-d8608ccfca22@google.com> <cover.1777418884.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <8c0dc96e0776bdcffc4d2e1a9d7336f106289a48.1777418884.git.ackerleytng@google.com>
Subject: [POC PATCH 3/6] KVM: selftests: Make guest_code_xsave more friendly
From: Ackerley Tng <ackerleytng@google.com>
To: devnull+ackerleytng.google.com@kernel.org
Cc: ackerleytng@google.com, aik@amd.com, akpm@linux-foundation.org, 
	andrew.jones@linux.dev, aneesh.kumar@kernel.org, axelrasmussen@google.com, 
	baohua@kernel.org, bhe@redhat.com, binbin.wu@linux.intel.com, bp@alien8.de, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, chrisl@kernel.org, 
	corbet@lwn.net, dave.hansen@linux.intel.com, david@kernel.org, 
	forkloop@google.com, hpa@zytor.com, ira.weiny@intel.com, jgg@ziepe.ca, 
	jmattson@google.com, jthoughton@google.com, kas@kernel.org, 
	kasong@tencent.com, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, michael.roth@amd.com, mingo@redhat.com, 
	nphamcs@gmail.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	pbonzini@redhat.com, pratyush@kernel.org, qi.zheng@linux.dev, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, seanjc@google.com, shakeel.butt@linux.dev, 
	shikemeng@huaweicloud.com, shivankg@amd.com, shuah@kernel.org, 
	skhan@linuxfoundation.org, steven.price@arm.com, suzuki.poulose@arm.com, 
	tabba@google.com, tglx@kernel.org, vannapurve@google.com, vbabka@kernel.org, 
	weixugc@google.com, willy@infradead.org, wyihan@google.com, x86@kernel.org, 
	yan.y.zhao@intel.com, youngjun.park@lge.com, yuanchu@google.com
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
index 1a49ee3915864..8b859adf4cf6f 100644
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
2.54.0.545.g6539524ca2-goog

