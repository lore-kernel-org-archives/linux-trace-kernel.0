Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D6E385531
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Feb 2026 22:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770071450; cv=none; b=ryJg9e2pGvBlE8vzARGc9UPw64AjIKU5Li9jNdkhqPhDNbqzYiWuMMGfYqsJ2yCb4lqvM/VqHvuVpru/8tMUlKAhiHhi5PQHiUh6knj0uVemLt4f2B0LvYy/B82SN1YKMZObKX45hqziVset7ehTFlhofyhJjDBpRCxI93AUA8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770071450; c=relaxed/simple;
	bh=cCejNhvt76UNSe20VwpAkdKK8YRqq35Jr/Lc5Fy4AxY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Infg4+ioJaP+dKQkK4jIoCYIjM17I4p7/3UrJJgslUroYlxh3Bs671hONAax/aRKfGkAnJJXSIwTNu6N2cNgqcLLEbC11hSwSl2ZmFLAGh26ry9Q2KKcrBlKnRmG5bwvUnKR4tGAfupfvk7Eg5BAVztDJiKlgu45la2O+pHoWjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n+M0JWyC; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n+M0JWyC"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a0b7eb0a56so44616815ad.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Feb 2026 14:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770071449; x=1770676249; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lp6r0BczMMAAPO3s3DGH7VMU4KkeGwOWlm5O8YplfuE=;
        b=n+M0JWyCykfRozAVeM1Q0Je/kEkSeWjro10HhV7cXZmlxHb5Xh46Txto6wIpuFn08C
         YAXRDPw/ATJ6AuZkWL9YGHtylKi9oXMqTaCq41lQQAgowH74K5Pqmq7foF1n6021nhr9
         cn4l7nKUwA7Znz/hJ1Br9hDGUTbtxskzbUeYRpAluxSlFmtA1TbyS+7VumKrxjquZoPF
         2XCKQ2eIRlGSRkUy/VA6AGyBuDostnFtXnsUoa9aUMWgNujz34/HMZtpEZ16Tm5f6elb
         6Xaf7nizrbfT6PUBpVNStxV8YXB7399cPaULXoVWn0gvcFLI9miHxgraAybYwgFIQKlS
         6g9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770071449; x=1770676249;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lp6r0BczMMAAPO3s3DGH7VMU4KkeGwOWlm5O8YplfuE=;
        b=Hehxb3ELjw7ubXcRPk0q9+gO6FkzblIjMVu2QI8Ow97C7zlnEa8yl4DwdUJgzwAfyz
         l6HfzGO0Vu0e0CVfPhlhrN72f0sRVaWeSnfzzINhtsr+gyINml7OuahdTMSVxVG27OPW
         wJxZl4AXU7KgAoT1oIcEd/0ajzz/jngYk1MAUN3KArxSvoEBat/VuKoZBh/nhh2EPqhI
         XJX7IYYv7aPKdBO5IXkB/mIfc3lbdAdIVl9BqtR7CUc7BSreET3WYD6W8CpWKw6fWd0B
         xdS8052GJMeVUHnlG0yMokrctsSIDLLCbsr6frRjJZJhlLwaaDAFrKUm9AUED1ECvtb/
         x3fA==
X-Forwarded-Encrypted: i=1; AJvYcCVpgCP+V8ePV88SYgQTAsMicuv3xK3VdepcjZwMHJkx74zA8mQ7D7y/bvJ+Z8q6Ua7UFxKxyesO+7Sx3tHkyvl7sXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqT/DGbvIhiEyrEOQ4eV8B7KSerhvAzI9XpqUtMyxI8Niotj0o
	UCVd04iDSfbl6bIO1hvYrCnlXZtePfNYenfW2oWxSK/UK9srKFDGa3HbMVY8h/CbJIHXPtvljJG
	4D+WFZADe+X5sbeaLobbEZCMRyA==
X-Received: from pgct17.prod.google.com ([2002:a05:6a02:5291:b0:c63:5610:9a42])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f64d:b0:295:888e:9fff with SMTP id d9443c01a7336-2a8d7ed95f4mr145055055ad.20.1770071448632;
 Mon, 02 Feb 2026 14:30:48 -0800 (PST)
Date: Mon,  2 Feb 2026 14:29:54 -0800
In-Reply-To: <cover.1770071243.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1770071243.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <d0bb3886b0ebc4eea92f468136bda50bad6d3968.1770071243.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 16/37] KVM: selftests: Add selftests global for guest
 memory attributes capability
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

Add a global variable, kvm_has_gmem_attributes, to make the result of
checking for KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES available to all tests.

kvm_has_gmem_attributes is true if guest_memfd tracks memory attributes, as
opposed to VM-level tracking.

This global variable is synced to the guest for testing convenience, to
avoid introducing subtle bugs when host/guest state is desynced.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/include/test_util.h | 2 ++
 tools/testing/selftests/kvm/lib/kvm_util.c      | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index b4872ba8ed12..2871a4292847 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -113,6 +113,8 @@ struct guest_random_state {
 extern uint32_t guest_random_seed;
 extern struct guest_random_state guest_rng;
 
+extern bool kvm_has_gmem_attributes;
+
 struct guest_random_state new_guest_random_state(uint32_t seed);
 uint32_t guest_random_u32(struct guest_random_state *state);
 
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index ce2b0273b26c..4f464ad8dffd 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -24,6 +24,8 @@ uint32_t guest_random_seed;
 struct guest_random_state guest_rng;
 static uint32_t last_guest_seed;
 
+bool kvm_has_gmem_attributes;
+
 static size_t vcpu_mmap_sz(void);
 
 int __open_path_or_exit(const char *path, int flags, const char *enoent_help)
@@ -488,6 +490,7 @@ struct kvm_vm *__vm_create(struct vm_shape shape, uint32_t nr_runnable_vcpus,
 	}
 	guest_rng = new_guest_random_state(guest_random_seed);
 	sync_global_to_guest(vm, guest_rng);
+	sync_global_to_guest(vm, kvm_has_gmem_attributes);
 
 	kvm_arch_vm_post_create(vm, nr_runnable_vcpus);
 
@@ -2332,6 +2335,8 @@ void __attribute((constructor)) kvm_selftest_init(void)
 	guest_random_seed = last_guest_seed = random();
 	pr_info("Random seed: 0x%x\n", guest_random_seed);
 
+	kvm_has_gmem_attributes = kvm_has_cap(KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES);
+
 	kvm_selftest_arch_init();
 }
 
-- 
2.53.0.rc1.225.gd81095ad13-goog

