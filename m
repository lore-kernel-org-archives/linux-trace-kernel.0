Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54708334C20
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Oct 2025 20:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732007; cv=none; b=ncV+uStK4NNzLT9fXcaeXTEGgyBr7uvDPYMQa6dw1hgeuttS8TzwpabANypu2nwcysNiFpAg0WGTJXjgLSFJpZXJEISzJyqPLtHWFC058U/W1kln00yJg2B3zQjzt6k1juN01XF8VYtMqkezgNSKeVKP6gDuMxVKZPtKiFYqdAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732007; c=relaxed/simple;
	bh=TrihwiuuxJ8YYrvlxOwVsirF8kMMYHFCCthbk+rVim0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U/UvxqrFvMvuKtuHvC/5xDlWbjN5LyC9UQa8oXhGYtJip5DNTNOb3vYcyzQj6BQ9bCMqg1hbgPXawSeXJmTBeMw+I2/cJeDN5RKJ1lX/Z4KMPwMP2qYhQVByszwHLK1SjGoJ45tVhYhVfOOREXcKLpYSMwjt7ZBzk1LlgwNPWww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vq1JZUhS; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vq1JZUhS"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33428befc5bso3162084a91.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760731997; x=1761336797; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/lNHI4Q/bFe7E7u1u54KO9h5F/sVs5DEw3rAt9A97U=;
        b=vq1JZUhScMuk1pf6GXZz9gIA03gE5BJNFZBAx3tXLX3hvL4YEp7ap5pj/fXdnnft12
         Z6sVP0inTvBX4HehqXhIS8T4Tw4QGop/eaVlvB5zI64w3gSqgxJMZgZ4oPz99kH5HXDf
         Pn5jrPbtE3W99UYreEefIdKHAtBFb8zTyzAUKoefNbFB/qONN4Hg/iV3y+dYYm0fXFe5
         7MHenbyqM/J74lpfa3LDpxKjnFi1PC0/xQfMZaHzFdVqwXHrJE7Q44ecQpI13lpaOlVj
         9x02yCuHkqWhYBVHj7GBKkSCK7JgiNM6UIXLk4oo7n5/qSosKKWiDwlyjkTM2KDNCVeI
         Vw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731997; x=1761336797;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/lNHI4Q/bFe7E7u1u54KO9h5F/sVs5DEw3rAt9A97U=;
        b=GeDXYWEhEOEta14qbK0fJsadyP1TiK+/CANUvSgalGsy6bJh2PYsCuSJC+S3SoiteL
         ihHmOSyf6+GgbbnsgSFhMUE/wdjwYW32pGJ5Vz8dcUedrH94Eci92G3B+MuK4/AamWz8
         lykVa0Z/XJh6hVq8iuDQfzHZOO872SREvbPwzyEbhan2SsVAhY2rhV0W93oVMcEqri1W
         fQWogY+Rg/WHcSetTAnb79vP7UU/zQYs6FihrfHu9o7vD88Y3eaY7C3gw0B2ihC9Vbzc
         2Ru9I20mbqj9Mbu4qxzcXc4DdqPiaqLPCSrTQlu2zrWPifMTAhiUgwlqL4TWjnLmwCWZ
         JKxw==
X-Forwarded-Encrypted: i=1; AJvYcCV4X6Rbh4jLFcqG/yMog1oFbiRD0Y8sRVX4skY1tMGxKpyGwL4dPSMuPq3P1vCeqW0x/s2LDqisx+1aRM8jJmsrqbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVHJkODro26V1roZebA5MtHmuQ6T5W4AHmNVm5lJikcAhdCrHX
	+cCUnEbYIUKXSumrJwVcfvz0/SgeyGCZm1M0cbZivmvEg2p5E73zHMNkDe1Hn9W2LvwBL0l8uQc
	ilUU3EmwIED8mVTMSyx1P+kQqdw==
X-Google-Smtp-Source: AGHT+IEJOmwwfA3Kaekqa8uydRah72/LLd/POEax3xDQXkYFm9XmuPnw9MNGeowIWx2EtPAAJiD//RyC47hEWG+7ug==
X-Received: from pjbpa17.prod.google.com ([2002:a17:90b:2651:b0:33b:51fe:1a8c])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:498f:b0:33b:da51:f05b with SMTP id 98e67ed59e1d1-33bda51f510mr5711640a91.26.1760731996748;
 Fri, 17 Oct 2025 13:13:16 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:12:10 -0700
In-Reply-To: <cover.1760731772.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <5656d432df1217c08da0cc2694fd79948bfd686f.1760731772.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 29/37] KVM: selftests: Add selftests global for guest
 memory attributes capability
From: Ackerley Tng <ackerleytng@google.com>
To: cgroups@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Cc: ackerleytng@google.com, akpm@linux-foundation.org, 
	binbin.wu@linux.intel.com, bp@alien8.de, brauner@kernel.org, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, corbet@lwn.net, 
	dave.hansen@intel.com, dave.hansen@linux.intel.com, david@redhat.com, 
	dmatlack@google.com, erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, 
	haibo1.xu@intel.com, hannes@cmpxchg.org, hch@infradead.org, hpa@zytor.com, 
	hughd@google.com, ira.weiny@intel.com, isaku.yamahata@intel.com, jack@suse.cz, 
	james.morse@arm.com, jarkko@kernel.org, jgg@ziepe.ca, jgowans@amazon.com, 
	jhubbard@nvidia.com, jroedel@suse.de, jthoughton@google.com, 
	jun.miao@intel.com, kai.huang@intel.com, keirf@google.com, 
	kent.overstreet@linux.dev, liam.merwick@oracle.com, 
	maciej.wieczor-retman@intel.com, mail@maciej.szmigiero.name, 
	maobibo@loongson.cn, mathieu.desnoyers@efficios.com, maz@kernel.org, 
	mhiramat@kernel.org, mhocko@kernel.org, mic@digikod.net, michael.roth@amd.com, 
	mingo@redhat.com, mlevitsk@redhat.com, mpe@ellerman.id.au, 
	muchun.song@linux.dev, nikunj@amd.com, nsaenz@amazon.es, 
	oliver.upton@linux.dev, palmer@dabbelt.com, pankaj.gupta@amd.com, 
	paul.walmsley@sifive.com, pbonzini@redhat.com, peterx@redhat.com, 
	pgonda@google.com, prsampat@amd.com, pvorel@suse.cz, qperret@google.com, 
	richard.weiyang@gmail.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, roypat@amazon.co.uk, rppt@kernel.org, seanjc@google.com, 
	shakeel.butt@linux.dev, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, tabba@google.com, 
	tglx@linutronix.de, thomas.lendacky@amd.com, vannapurve@google.com, 
	vbabka@suse.cz, viro@zeniv.linux.org.uk, vkuznets@redhat.com, 
	wei.w.wang@intel.com, will@kernel.org, willy@infradead.org, wyihan@google.com, 
	xiaoyao.li@intel.com, yan.y.zhao@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="UTF-8"

From: Sean Christopherson <seanjc@google.com>

Add a global variable, kvm_has_gmem_attributes, to make the result of
checking for KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES available to all tests.

kvm_has_gmem_attributes is true if KVM tracks memory attributes at the VM
level, as opposed to per-guest_memfd tracking.

This global variable is meant to be used by the host only.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/include/test_util.h | 2 ++
 tools/testing/selftests/kvm/lib/kvm_util.c      | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index b4872ba8ed124..2871a42928471 100644
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
index 19c0445c0b296..c9c59f3ecd14f 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -24,6 +24,8 @@ uint32_t guest_random_seed;
 struct guest_random_state guest_rng;
 static uint32_t last_guest_seed;
 
+bool kvm_has_gmem_attributes;
+
 static size_t vcpu_mmap_sz(void);
 
 int __open_path_or_exit(const char *path, int flags, const char *enoent_help)
@@ -2321,6 +2323,8 @@ void __attribute((constructor)) kvm_selftest_init(void)
 	guest_random_seed = last_guest_seed = random();
 	pr_info("Random seed: 0x%x\n", guest_random_seed);
 
+	kvm_has_gmem_attributes = kvm_has_cap(KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES);
+
 	kvm_selftest_arch_init();
 }
 
-- 
2.51.0.858.gf9c4a03a3a-goog

