Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DAB374E47
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 06:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382399; cv=none; b=BQB9rkldxxNMzIYRxw2sGGr7UJvxAn97DFomWZCTnGb/DciD8XMeCJmoQPzttktiEjQwrJrlr5o5qn1Ddnc1rdZpeZwmCR05ZZwNo2TRPQnlrHJWRJS6eUs8scyzqclXSzej6LkwcWptlx+BCE/BgIYVyDbCExPdVGuZ0zL5pCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382399; c=relaxed/simple;
	bh=2bKFn7DxXybMi2Eo6xsWXzHmRVA+8uQonK2JT0DPcs8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OMmTI0Z4YLkSLWLCGDmorVOpfOiQcmHegZZh/Cc5GKeq5CsR7fr6Vb2uOFu3bTprBOrqj6dLYwG7GJ1/EJBC8gKqn4cZahPPgBmeWihDIRhbZlr65LEG0sDI9DfCGA46SQGeeg5Y0BTGjzOkYvUcnHRAkgAFwudJnVzEqhPX2CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LKnBOH11; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LKnBOH11"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35449510446so1466898a91.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 23:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773382396; x=1773987196; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=prn+/FfRoFXlGR9u8MjJ/9HdwBqMGCmRUDTQNyUT33c=;
        b=LKnBOH11nNy1QohpQxeemHKEgzIhDL6bUXYJEtRTnKBsR9AVuNhsmVvSRmnDlPV2qB
         NTkqOCVMP+2jtm5Jl+jVf9sHas3c65i0eDBT5pgQjJqQN+xosiX1mgHJQopw2U/lzBd6
         EEX6MBTjcHPD7t/sU640S3RfC/qvHfEOHLE1GaMQaoeqEbrqHsqgOTd9E86E/a65m70g
         yUKCohHUJR+imgl+b/gptUWsNxyVoFmPS0chi8foXZHlhI4EBZz5cu0uh6NYXMMiQIpi
         XtbY0yZub/iqWTQatjn7pAxc926bkh/rvfoVxeHzoDwHWMPMpZ2oBsOnGm5tnxTh85rI
         M2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382396; x=1773987196;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=prn+/FfRoFXlGR9u8MjJ/9HdwBqMGCmRUDTQNyUT33c=;
        b=k06m0JErAYtcv3zXUWe5yC097DLwlb2ialH2/OeUDeaiv/ArUafb1ACDDrY3geNHHC
         0FOxIXzM004PU0460Qk+oj3H5UZkmqmzM94cBJRexFW6QJsN77aZrkDOjsyVQtKuqMaJ
         tk3zreGZ9mLjjgJ2whM8FWhydkBKMYHW5pH/ngWRgOHfskpeusLqWbMEAKrnLtoJur32
         oFbsml9Mo9JLtQIVLp4Q2fvVuAgd8qbeEEaUxLAKnSANgNtAMqbUZV5HGn1vCIdu3qMM
         VHcrRCdjVDdKjcqXI0QAi+ESHzc5J1QcWjUu0rvj01/YzelEaRGt5gl3mGypj1+F7KP5
         1ppg==
X-Forwarded-Encrypted: i=1; AJvYcCWDVY+4WdzijX9paCAqpA/AEjofwXyr0UuemTk1k5vxGWNK0Z05wR78lQNUJRlnLVxXVmcNa7howbIxCYDYaPgTIlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXJatxlCP8wHAhwNBj2Yamb//N8zvdvPizFw82hIsHSEt74rvm
	jxbW+pCPlOsb7NAFFs1my+I+4bY5KdRrFknEFh5rOcBf3+qajNDPsy0eiOXPLHzMqmphZCqOiFH
	ducMsJsNa2XP9SNsj52w2VTPb3Q==
X-Received: from pjbli13.prod.google.com ([2002:a17:90b:48cd:b0:356:20f7:5344])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4b82:b0:359:fa1e:2bcb with SMTP id 98e67ed59e1d1-35a21e4721amr1828333a91.2.1773382396244;
 Thu, 12 Mar 2026 23:13:16 -0700 (PDT)
Date: Fri, 13 Mar 2026 06:12:56 +0000
In-Reply-To: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773382364; l=1677;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=2bKFn7DxXybMi2Eo6xsWXzHmRVA+8uQonK2JT0DPcs8=; b=UsseJW23riRqFSAIxPK8qnPAGqJurB0Ctj5jOfqiKNkUC9t+LwPGzVx/dr+QiKe6u1ukz4Hf7
 k666ysDyRPdCxyh2c6ANRQbRGBbWH9t1P6eRcebLtVxIaqwBCwgjIPx
X-Mailer: b4 0.14.3
Message-ID: <20260313-gmem-inplace-conversion-v3-17-5fc12a70ec89@google.com>
Subject: [PATCH RFC v3 17/43] KVM: selftests: Update framework to use KVM_SET_MEMORY_ATTRIBUTES2
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

Update KVM selftest framework to use KVM_SET_MEMORY_ATTRIBUTES2 and the
accompanying struct kvm_memory_attributes2.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index caca482aad859..fc55ad3c67485 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -420,7 +420,7 @@ static inline void vm_enable_cap(struct kvm_vm *vm, uint32_t cap, uint64_t arg0)
 static inline void vm_set_memory_attributes(struct kvm_vm *vm, uint64_t gpa,
 					    uint64_t size, uint64_t attributes)
 {
-	struct kvm_memory_attributes attr = {
+	struct kvm_memory_attributes2 attr = {
 		.attributes = attributes,
 		.address = gpa,
 		.size = size,
@@ -428,13 +428,16 @@ static inline void vm_set_memory_attributes(struct kvm_vm *vm, uint64_t gpa,
 	};
 
 	/*
-	 * KVM_SET_MEMORY_ATTRIBUTES overwrites _all_ attributes.  These flows
+	 * KVM_SET_MEMORY_ATTRIBUTES2 overwrites _all_ attributes.  These flows
 	 * need significant enhancements to support multiple attributes.
 	 */
 	TEST_ASSERT(!attributes || attributes == KVM_MEMORY_ATTRIBUTE_PRIVATE,
 		    "Update me to support multiple attributes!");
 
-	vm_ioctl(vm, KVM_SET_MEMORY_ATTRIBUTES, &attr);
+	__TEST_REQUIRE(kvm_check_cap(KVM_CAP_MEMORY_ATTRIBUTES2) > 0,
+		       "No valid attributes for VM fd ioctl!");
+
+	vm_ioctl(vm, KVM_SET_MEMORY_ATTRIBUTES2, &attr);
 }
 
 

-- 
2.53.0.851.ga537e3e6e9-goog

