Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9352D31B833
	for <linux-trace-kernel@vger.kernel.org>; Thu,  7 May 2026 20:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778186079; cv=none; b=g7Dk5nTw3BtkeIEN+Or0WPzoj/a1lUmHcvLQbG9MEl4DCq1I4DMj+bUh1aJe+P0xdWWa/ku2KdjoELzxqP5VBg+3q1GPOqvEelKdnzPqK60ZymI7DuBoezfJa5TRDifTecOzl3D8tEQ3hHHvO9u4LtRIVhWdikP1uNkhOjjRG6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778186079; c=relaxed/simple;
	bh=sd9AdOZfu3se/q1JFWRQ37VtXfr2DAtfN5f52D8iXUA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lt0ME846rW72XgT2GePe/sPnPO8NnR5TiDAgN9O4V2ejgF0/6IIICcQ8ToyGcSXfWoG9z1+QMy+hwx/0AliCeTkf4rVX79CzM+d3DUEAjpFIbwVacI61mWWo0rxkXs05Eewn+Kzn17+ROJDNm8u3Iieo//PVIjAIoSva7pew+9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k7/kFWIr; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k7/kFWIr"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c81086bf930so1416556a12.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 07 May 2026 13:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778186077; x=1778790877; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Yn9j42pFWCYKkGf1K9Y/HlYS2+Vlbg3y86z46RrWQ8=;
        b=k7/kFWIrrlXq5vWTsV0s1YFLoTlDi3ruPLxZhUZD4Lr89rG2kFcBjn9qKf1Gi53m2u
         k6CZnennwq9GHnLQWHK8/9/Y686UVHb5FFbCmQ0oLVs8hOepscK0cY/7OMXi6l986pYw
         K/LOjfhWzk9RFEp6zHV1S+V1F8O4LuuW4MkHw6TkzNDKfCpgoTKtcto1xlXl6wfcN5a/
         rNsV8+kA5GSxBWZmFg01s7BoI6u4JaYjJOF7zRMeHMyOOOmFmqQIuV1PXcFylJOIiqxX
         hpsG/mLFRlMrUjFp5YwqmwQiCoCfiNXgEk5fPFQtjYlN4HmXRhIHrgN6xsZLKpyZEwyf
         MH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778186077; x=1778790877;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Yn9j42pFWCYKkGf1K9Y/HlYS2+Vlbg3y86z46RrWQ8=;
        b=aTKTtzrf0oQK+qWfyHFEQgBz7pFaFwVl8AzsbSqgOBaP/wijnKGE12bO7Vto4iPmK0
         QSdhG7cTByOUAVo8hRDCe8PH9NRi0Vbunjm/+YJt9t6asHVXq+XeECZpgodvcjffSBHk
         YXFNrU4urhKbbKOhB0jn8167g9zSP/gv6RDkVJoocw7kMyibXmPzAOuNK7zTWS4O4aKH
         eymlECBaBB54nXOFE2TLn0WhueDlo78YRkKcB6fl7kiwjFepQ0BQjdM+9g8moVly06ZL
         5TH2Jeampg5dOgvvTW4U966eTPzY9JQ8SAiMsIL6a2rFBKI1rZFp9/RMUUHtvdvRNn2i
         v9/Q==
X-Forwarded-Encrypted: i=1; AFNElJ+oQKQUuOam/Q+NNIrcmogRb4SSXfOs1KvMxddAsJyIqIdTPAmkQdHzSrBjUBTZu1CQ8/XgQPCLvYpSd9xjURsb5f0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoQntKyM5as4BvjgNdnXpqAAjZZBG1uiKbTRzGSaAwUFTTh0mK
	O/HdtCPlz/OZYOII5k4kfl4XhFwx7riFDM/n65Aqf7UyrOPY8+bwhSoa1cvEa2IuaSOmkM+N71d
	5bO6PsRJ4Bl25eto6f0ckmLe1rQ==
X-Received: from pgbfy18.prod.google.com ([2002:a05:6a02:2a92:b0:c79:26bb:5541])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:6a08:b0:3a0:9052:c005 with SMTP id adf61e73a8af0-3aa8be1f13cmr3709118637.3.1778186076252;
 Thu, 07 May 2026 13:34:36 -0700 (PDT)
Date: Thu,  7 May 2026 13:34:23 -0700
In-Reply-To: <cover.1778185936.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com> <cover.1778185936.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <b1ec34e503cc08fa20121e542db3c1582e86286c.1778185936.git.ackerleytng@google.com>
Subject: [POC PATCH 2/5] KVM: selftests: Use guest_memfd memory contents
 in-place for SNP launch update
From: Ackerley Tng <ackerleytng@google.com>
To: devnull+ackerleytng.google.com@kernel.org
Cc: ackerleytng@google.com, aik@amd.com, akpm@linux-foundation.org, 
	andrew.jones@linux.dev, aneesh.kumar@kernel.org, axelrasmussen@google.com, 
	baohua@kernel.org, bhe@redhat.com, binbin.wu@linux.intel.com, bp@alien8.de, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, chrisl@kernel.org, 
	corbet@lwn.net, dave.hansen@linux.intel.com, david@kernel.org, 
	forkloop@google.com, hpa@zytor.com, ira.weiny@intel.com, jgg@ziepe.ca, 
	jmattson@google.com, jthoughton@google.com, kas@kernel.org, 
	kasong@tencent.com, kvm@vger.kernel.org, liam@infradead.org, 
	linux-coco@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, michael.roth@amd.com, 
	mingo@redhat.com, nphamcs@gmail.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	pbonzini@redhat.com, pratyush@kernel.org, qi.zheng@linux.dev, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, seanjc@google.com, shakeel.butt@linux.dev, 
	shikemeng@huaweicloud.com, shivankg@amd.com, shuah@kernel.org, 
	skhan@linuxfoundation.org, steven.price@arm.com, suzuki.poulose@arm.com, 
	tabba@google.com, tglx@kernel.org, vannapurve@google.com, vbabka@kernel.org, 
	weixugc@google.com, willy@infradead.org, wyihan@google.com, x86@kernel.org, 
	yan.y.zhao@intel.com, youngjun.park@lge.com, yuanchu@google.com
Content-Type: text/plain; charset="UTF-8"

Update the SEV-SNP launch update flow to utilize guest_memfd in-place
conversion.

Include the KVM_SET_MEMORY_ATTRIBUTES2_PRESERVE flag when setting memory
attributes to private. This is permitted before the SNP VM is finalized.

In snp_launch_update_data, pass 0 as the host virtual address. This
instructs the kernel to perform the launch update using the guest_memfd
backing the guest physical address rather than a userspace-provided
buffer.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/lib/x86/sev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86/sev.c b/tools/testing/selftests/kvm/lib/x86/sev.c
index 93f9169034617..074ab0eff1e27 100644
--- a/tools/testing/selftests/kvm/lib/x86/sev.c
+++ b/tools/testing/selftests/kvm/lib/x86/sev.c
@@ -37,8 +37,7 @@ static void encrypt_region(struct kvm_vm *vm, struct userspace_mem_region *regio
 
 		if (is_sev_snp_vm(vm))
 			snp_launch_update_data(vm, gpa_base + offset,
-					       (u64)addr_gpa2hva(vm, gpa_base + offset),
-					       size, page_type);
+					       0, size, page_type);
 		else
 			sev_launch_update_data(vm, gpa_base + offset, size);
 
-- 
2.54.0.563.g4f69b47b94-goog

