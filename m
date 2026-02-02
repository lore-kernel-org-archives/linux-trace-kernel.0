Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF449385531
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Feb 2026 22:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770071452; cv=none; b=FDd5efzX9jeVmf7dJ1wIYulQGP0b0z+0YUpYbIItP/jW7e1Do0q5x+key7+8oOEjImeJzaowyE004La0FmxxcA/Bi5zyRWZqy/TPh7odDbsKAInXmOKv3LRUvN7givhunQkAKYPUElWvSGQdiAVJ6WQ+DFFoV7AqTxavfJgroXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770071452; c=relaxed/simple;
	bh=BOuDl5FNJBY78R3/sjP1Z8mI8xgIety+sC9BdjeSYJs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uFphlNwfsSAV0sBgZ/AvdqP9vBG7WV7o6Urizf2lN28dRVeW7Pjd5Y+HmxWUEooSJSTQciXYT8Na9euufNE7VeUbyF25Cyc/B+g2/+hf6vATkGAN6g5p8NYxRa5h6UcXNHh0U2QnjFKlb3luCjQKGVlzXE0v17hSuYVmb36rQ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kEJ7qLtn; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kEJ7qLtn"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-34c93f0849dso197631a91.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Feb 2026 14:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770071450; x=1770676250; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jVz8/vXYYvlyUGSqOW3ETp8FRnG4u38fEDm5kewK59s=;
        b=kEJ7qLtneBDaaD2aHAJ0fLEy+gDo6dP25vK3BfiW8MCDNecQEoNNAkLTl/k8QsYtiB
         4PK6k1+LYlOq3NtR8kdePXTAwCDpl+GsMpJBnaSYMBn/L4LsKG+vTGvdanLc+A8od3IR
         LpsAJInIcvFvIb1Pit+RQNv9pO+el9JSeY7zWC2VIuIN1GdpCXRFt/ulMgYFOdk2bO4B
         IZQYKs0NH7kWiF+VCCnVWtKY1B7M8o2G1AWHULl4Wr0lJr1NQ6NI2XtKMo9mU6ZyaFzH
         X7swscfxcx+f+ekd/WDxyn3sg1/Q0qBl1JbI+hASQ2Atpp6gcRg6RnAVgXQpxuyb2or2
         NiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770071450; x=1770676250;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jVz8/vXYYvlyUGSqOW3ETp8FRnG4u38fEDm5kewK59s=;
        b=RsErLm78dNiUS+Myc1u4rPL7U8m9xTlQFMrGz/TxWRgcxV/KEqQENQQmpi1ptbeVib
         ueNOhqXHOIRnVGntdfNMOYq0axIC3xfL/z2D3Nf6LJDN20HPF9rLWGK/1XUjss1loKVa
         d1eG5iqOLmOSnNUoNolpWvenwr5qQv17PxU0wzdbErwsi5hIwPEmp0Oin8VSXQYhXy+u
         3ZeIucx1TyP2o0IpW6sp1No85ERd03W6fn4vdTDDYXdnrc81/4nN0HfaCjx4fUkEFJ7o
         SRgWx1jJ2irnQh8XhXSOH8SQ5p+ZO08V2u2w8YzFwb+FLmOaSv5QFWN2hFtbi2khs5C8
         VWeA==
X-Forwarded-Encrypted: i=1; AJvYcCU0migOeaQKdOxAGXBQ/qhgd6vkgC/YuH6tvLDgFkRHGv5INMkva3t+UckQoGkiicScQS0F8Lhd4EU1XX26fNuD+zY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdGpOGTqU0B9W22ME7wLeF3v0x8ldW+a0/Pnoi1bpUWK6tPlkC
	pmYAjDbnsmj/QAQvpK9s5Tp4aeMo3Lfr5ng7jTKlmHWA0Vko1pTN8AFHBqf/+UHBZ0DurYG1ur3
	gqYMrTr3vPy4uAkBIJ1dEnT8XAw==
X-Received: from pjtw2.prod.google.com ([2002:a17:90a:c982:b0:352:925c:a29c])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:28c3:b0:34c:2f01:2262 with SMTP id 98e67ed59e1d1-3547769019fmr617275a91.3.1770071450254;
 Mon, 02 Feb 2026 14:30:50 -0800 (PST)
Date: Mon,  2 Feb 2026 14:29:55 -0800
In-Reply-To: <cover.1770071243.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1770071243.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <544fc9c8c519560d8622ca1def8dbc676baf2d73.1770071243.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 17/37] KVM: selftests: Update framework to use KVM_SET_MEMORY_ATTRIBUTES2
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

Update KVM selftest framework to use KVM_SET_MEMORY_ATTRIBUTES2 and the
accompanying struct kvm_memory_attributes2.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index a64aae271a6a..872988197a5c 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -397,7 +397,7 @@ static inline void vm_enable_cap(struct kvm_vm *vm, uint32_t cap, uint64_t arg0)
 static inline void vm_set_memory_attributes(struct kvm_vm *vm, uint64_t gpa,
 					    uint64_t size, uint64_t attributes)
 {
-	struct kvm_memory_attributes attr = {
+	struct kvm_memory_attributes2 attr = {
 		.attributes = attributes,
 		.address = gpa,
 		.size = size,
@@ -405,13 +405,16 @@ static inline void vm_set_memory_attributes(struct kvm_vm *vm, uint64_t gpa,
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
2.53.0.rc1.225.gd81095ad13-goog

