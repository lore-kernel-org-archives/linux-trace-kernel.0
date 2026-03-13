Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EF437FF66
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 06:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382436; cv=none; b=X8ndTy/rclOHaWperbxoLwMUTmTp+SWmcSPC+XbmcUyngVuGbe8CVPy62oacQ9aml2vOyJr7W9wD8W91rxpk9ZQNV1vNtgUbMOUFSh6Lkq6Ue2sSXLLptmQBbIe/rKst818PBSp+dD6MgVsDLyqnzaVlkFRhZGUEG4guzMl+5rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382436; c=relaxed/simple;
	bh=jlY63jaXZygIGaOgZtVxKiuMw6fZISJPN/Vv35T8zZM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tbslChk/fZwSzSv80A2fcLD3BD2vCSWzSFrs96LSbdWGh65cXazs92ZLO6x9z//eAKAjDiwP5/iCljnIuxbw6QgEyRBm1XjJfdAj4mn2OzY2UWM7OgNllcfPok+l596l0fVibZC4sIn0N9vkvUIAmSPmw1idFvqL4xJZcbRaAEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ENg1sZGE; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ENg1sZGE"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2aec6c573a1so7053435ad.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 23:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773382428; x=1773987228; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fvNVntiarmCGsWTxZpON78d07G8svxge2O9rBbJ0yac=;
        b=ENg1sZGEmjQ+uBR0zH/uGdOTzpH9wuOYDpp9/hLDvI2M5m8Ta/1rQpxAF+gx15fsOe
         I86TLBSt8Uxgt+zrVkhK3X8/m+zX348lFnYysOkJdoVHuh9Nd+kZJRhzx6mcm4bZGd8U
         Z5v1dLPp0cf5oNiiEJL/wyewsPguiNJPzrDkhvGx8fJqCYzPuQMDHIUzv9p8IlSFg3zW
         gkU8CR3Gfwu/ZwdSCs+QI1grgJXyUR/k9j83wkF6bIeDavDktZ5js+aIP513tNhcSpP8
         Wc57J0JfINGOtcrNYRZUYZY0x5RQl7aSd9IH3K7jPuchxwE4zguuJ/+QXXlSIQH7k0MB
         r1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382428; x=1773987228;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fvNVntiarmCGsWTxZpON78d07G8svxge2O9rBbJ0yac=;
        b=JBgRaotcI2/YueQHj0Oti9rWQOF6J8A4youn/PQ9ztzlkcemIO/LTD7GeRuDmRHNtd
         D8Auls5ASaDNsE9of/N3fMtzvJps/DdVnu1BetZXy09VmXiPDKG3mbJhCotvy2Zz4/Me
         g1yd8u4s/2W2zApW05c1X+h/VRR3HVvH3DK2cODzQykowUaotDvuS+uC7aR7ktvgjn6K
         YFjwu05b6ztQZ3sjeB2EJZAY+aTNW47n8LgC2HAO7lB1N1D7AKx8DEI2J+NyUZDEGwBj
         5bAk3q0PhQNewI1SRDyInSdUbF3rg/Z7Dw/yoQK4hsoSurMbkNuSyoT7nhyCPhHbgVUT
         BDCQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7Q0trSKpJkTKJ8aBBJoAWIC1pFXPU9PeOyT7RmyvIB2r2rKHMYLWIn8blFysKrh8N7V99RhWOCDEtPXjIYLglk7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMdjkBztxigppRk/eG4f9P6qR4a5w+no20TogXElyv+aJRqx/n
	GDN5pX1Lq60eUhKKTp/7G4QiZ7T1TGcZ+/RezBT5tUUrQnR/DEgb44Ot1EybLXweauwNBwATF7R
	QQrTlQXyyHSIRUl37BrNapKIpXw==
X-Received: from pglr19.prod.google.com ([2002:a63:5153:0:b0:c5e:84e5:d15c])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:7103:b0:366:1fea:9b54 with SMTP id adf61e73a8af0-398eccb5ca6mr1499625637.39.1773382427639;
 Thu, 12 Mar 2026 23:13:47 -0700 (PDT)
Date: Fri, 13 Mar 2026 06:13:15 +0000
In-Reply-To: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773382364; l=1221;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=0eurx45EffreZpbE0bI2YaqpEA5K0mBVUQDWvwJDhzw=; b=P4sPtMqe0bW3A7Q96bA0pVzSw64TOLkPLdYc+O7v0eJh6YS2NIabW7a1oDP/5Be2J8/so/f7T
 SM8JzRi7VZ1D8avo6F2PZFyFMGjkJi3JeQSctkzYQGnIaLBJAss2LcL
X-Mailer: b4 0.14.3
Message-ID: <20260313-gmem-inplace-conversion-v3-36-5fc12a70ec89@google.com>
Subject: [PATCH RFC v3 36/43] KVM: selftests: Update pre-fault test to work
 with per-guest_memfd attributes
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

Skip setting memory to private in the pre-fault memory test when using
per-gmem memory attributes, as memory is initialized to private by default
for guest_memfd, and using vm_mem_set_private() on a guest_memfd instance
requires creating guest_memfd with GUEST_MEMFD_FLAG_MMAP (which is totally
doable, but would need to be conditional and is ultimately unnecessary).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/pre_fault_memory_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/pre_fault_memory_test.c b/tools/testing/selftests/kvm/pre_fault_memory_test.c
index 93e603d91311c..831b612449ecf 100644
--- a/tools/testing/selftests/kvm/pre_fault_memory_test.c
+++ b/tools/testing/selftests/kvm/pre_fault_memory_test.c
@@ -187,7 +187,7 @@ static void __test_pre_fault_memory(unsigned long vm_type, bool private)
 				    TEST_NPAGES, private ? KVM_MEM_GUEST_MEMFD : 0);
 	virt_map(vm, gva, gpa, TEST_NPAGES);
 
-	if (private)
+	if (!kvm_has_gmem_attributes && private)
 		vm_mem_set_private(vm, gpa, TEST_SIZE);
 
 	pre_fault_memory(vcpu, gpa, 0, SZ_2M, 0, private);

-- 
2.53.0.851.ga537e3e6e9-goog

