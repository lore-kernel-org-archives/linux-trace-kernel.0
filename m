Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719503064B7
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Oct 2025 20:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760731969; cv=none; b=hdD1OdTQufW6a5k0Sa739jXoH9lY7DdwVTOTSxoXhZQgY5P5hIwZmVX9qRn2ISFmrZAqxCCAedQSUgb2KLNcoeBiTMNKJfb7BWaUwewE2RAwI1RdxiABm1/8Pv/amv+X5hMbuJIeAiknZ+77zXbsq0VMx2eo9e2dtzFB/5CfzlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760731969; c=relaxed/simple;
	bh=cwrAgKoOfoFmDzsB8GfouVjdDaQE4lrV8AsgVEuqlvI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bl5qr3jWtGrVvPKkMR7rhkliSsGWD8FQZbKe5YRfd3G9BQtaFoEyt0fyAyrpLh7XpULWg7aTZUxGlhNCz9OR/zAeXnbXbz0JwFMBDXInuWMaQBUXKvtfjdgCmPzX7Om6itTB9vJ/MlYdXiHKuiNOKr89xKedNuv5U4ILyL5Ni9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MXn6fijT; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MXn6fijT"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-29085106b99so24174765ad.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760731965; x=1761336765; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kctxz4bkwPEMxjAo5uv7zMkhZ7DomPYpJw8TjHTwuwc=;
        b=MXn6fijTk5zfppuhelhljX6A3t/1mAok4nn+OItA1YOiK7sNzRcgeMZam9Y3wAuO9x
         DiXbL8Py+OICYKWM2mJQ9XiITrVZST62sEg+hVfxIBr9Q7Q4WesD8WU19UXwlFf/uhtS
         9nFc7VIrLLcsMpA5iNIiPScP/NbPFM20N78M5CuMIJTDwdiIhBL3hqOZZLWPDebvDG4T
         10J+dSm2KqBdWBsjM3maHkHIoLh8rWcDR3ZBFR/ypecLBbbKTQ4p8yh1aY0pTWIaBWJD
         KSn/9zT2SgnYebDpEsOPirPIEBzP2OkZ55eZCZrIqS1YKgPy4xAamUvwfVCZU9crPKG/
         PX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731965; x=1761336765;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kctxz4bkwPEMxjAo5uv7zMkhZ7DomPYpJw8TjHTwuwc=;
        b=bF4GglQNeYX06aotCOF+zte8UuQfZEq9qvplfDjrHLpBEVAMiWstk/o66s2WaOLZ0U
         8Z8jK0nDR6mubp1VH9SpFwShDqCXaze9u6A6FYfZ7jHiLqDb/GnZ17A6rPyjExZd7JJu
         eGjOi5b1725Az+WcagRk/zUfFgj1S5LncD7MHvfYR+ViyMrym7U+XJFa0xTMoE+2hBkO
         OpC5yYcN4aFVOzzZaWk+9431ihYhKCO5Rpo8HojE/bhfb3bX9/gYPZoI8xyT9lM+vzX3
         sHWYtNmdSFk8cTQrvilrjQEeMUMQXlzmwFy/LtyRBjrXbL6XHlFSX0G3EWClMAQs556a
         3x1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXdq2AyI5YouHnM5dG8nQoA1ajS4NqwyvUtKhkXufS7u38J6BBLX2W7kDJ3HyghA5vzODBEM3OT93vA9Bqhh/spg9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxltFJJ4E3KZVsbv/SoP1Xw2QQWNsMuKD9Q+DJdE1JaeU1TJfE2
	LJHeWT5GvuOA3IY7PPUrgR1l2uqFC3AqC/nonLMvFmmDIIV2c07Rw94FLGNlmSx+28Eg8ZyzVcg
	2BQtt73z6K6cnmPcanoij7frLtA==
X-Google-Smtp-Source: AGHT+IFw3NgbtgTZNOENDz2gBk436xq9cSXbkfHKeXAn9g3NU8+yq1Zt0gAdx01FZUaxcKcWB1HdYR90j/8QeZ03Wg==
X-Received: from plar10.prod.google.com ([2002:a17:902:c7ca:b0:27e:4187:b4d3])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:ce8d:b0:290:52aa:7291 with SMTP id d9443c01a7336-290cba41df2mr57184855ad.53.1760731965412;
 Fri, 17 Oct 2025 13:12:45 -0700 (PDT)
Date: Fri, 17 Oct 2025 13:11:51 -0700
In-Reply-To: <cover.1760731772.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760731772.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <98bee9fff5dcd28a378d81f8b52a561bca8e7362.1760731772.git.ackerleytng@google.com>
Subject: [RFC PATCH v1 10/37] KVM: guest_memfd: Enable INIT_SHARED on
 guest_memfd for x86 Coco VMs
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

Now that guest_memfd supports tracking private vs. shared within gmem
itself, allow userspace to specify INIT_SHARED on a guest_memfd instance
for x86 Confidential Computing (CoCo) VMs, so long as per-VM attributes
are disabled, i.e. when it's actually possible for a guest_memfd instance
to contain shared memory.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 5e38c4c9cf63c..4ad451982380e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13941,14 +13941,13 @@ bool kvm_arch_no_poll(struct kvm_vcpu *vcpu)
 }
 
 #ifdef CONFIG_KVM_GUEST_MEMFD
-/*
- * KVM doesn't yet support initializing guest_memfd memory as shared for VMs
- * with private memory (the private vs. shared tracking needs to be moved into
- * guest_memfd).
- */
 bool kvm_arch_supports_gmem_init_shared(struct kvm *kvm)
 {
-	return !kvm_arch_has_private_mem(kvm);
+	/*
+	 * INIT_SHARED isn't supported if the memory attributes are per-VM,
+	 * in which case guest_memfd can _only_ be used for private memory.
+	 */
+	return !vm_memory_attributes || !kvm_arch_has_private_mem(kvm);
 }
 
 #ifdef CONFIG_HAVE_KVM_ARCH_GMEM_PREPARE
-- 
2.51.0.858.gf9c4a03a3a-goog

