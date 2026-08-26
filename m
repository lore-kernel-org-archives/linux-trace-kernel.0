Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CC93EB7F4
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 09:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735945; cv=none; b=YYEUxa/e09v7LyaaPLCZ2aFROHzpg+68RqOAAo55HCxOolBG5NiNlcx/DUbwjmB1LTgSbZBwQepkmBIJE6bHSm/05lco85LEKXjJ50fv2BHtdWE3c/xNNhD9qZf44nquv7DaZo0SLhmP4rLlCBcs5pQOW4vBp8yBMYUoFNYzYFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735945; c=relaxed/simple;
	bh=l73U6b9QMJm++wnVRVWmusR6Da3x6x6ObMPGHhXOFXY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=drC1QAiOImRdtxyjrTidnyO1TPFk2agbkxEwCuD24yeZiGIyI/y8bGxISiEZAAWMWK/v/QqpEAmF0IGFttWw+WS8CNnREbVeBjzrosI80CgupF0OrRUyb6BuIcd1ic6zdRsEY2AvKz2hwQaaY2U+BteYqLo97fNyRvru9yY0tRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hp8PoZeN; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hp8PoZeN"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc11b5dd54dso1479489a12.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 02:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787735935; x=1788340735; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BY70MMIKZKRKauwOTq9m7n2x1FHu0Xdv6rM2Gy5jXqw=;
        b=Hp8PoZeNoBVI2R9ac4X5p9AeLdrgcMNnDXIJ+q9GxagJee8Uy4jEH9f+CDWUuvIlHA
         oXW9KA0dyb/5ogzSoYxLNyWI9vSeWt7L1k7ALSU+DzcxsGqCASiMyOrFO7j7hN1wf3Fn
         bM+Gh53SDdURYczkvY594FRyIQJbo5NvSaOFNvoRH6ITWSgmNn++IWtlxmU3fswsHnLU
         kk+2Ww4OBpa8Zdvd/ilOBIHEGvn5ajbzBew/Xq7JZ5xUZWXl+rN+5oNH8AvWSXucM066
         arYjqzDdded+sM4/DJ9Z2rzwbLWasI/EFr0saOCdxkbZqiXnQ+yGo3j5fEsYVMno/h/S
         79Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735935; x=1788340735;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BY70MMIKZKRKauwOTq9m7n2x1FHu0Xdv6rM2Gy5jXqw=;
        b=OouFDdxOae8PqhuTEzQ8vwzZ9iXEwjop3R4UskXr4zq9a0ODShuV3/+v54x9kCfFt5
         hg7eneSRYbUggaQw5kclLkFNVNnjxgZZheoCvx9Tjzu+fI2SWBrl4FpxpmwT8P/mgwdz
         XLogAVNGUTxaiDe6D6Cd5k+knv+f2yY8ccGErDdOxn5F8UWHvgLldoknNakRkJBt4C2/
         Sh7LxjqMb2nmlBvrKYuwTR5KKDaOGTEGIwvue0yUlRmvXuSQS+TqV1/6lONtqrJQUXeJ
         wRDv+MYi0DBOtvT/xqm+0ScYShh1ozihRUWKbmpO97QUQzIV6x+IaLv6Ncr+5ush+cYk
         IuTQ==
X-Forwarded-Encrypted: i=1; AHgh+RpGaTzKxjKeGqmusLZIJdsJ5E0o+/oM10vqmB+wz2J8HFhKPSWDPDffi6ZNjZ2+PeBJEHCmNOib/LNMjmoczIx1Vfg=@vger.kernel.org
X-Gm-Message-State: AFuF++k29IBpbEOs6SofrF2bOuoQwr0tqD+YGXAKIlWYlDXEIuT58vt+
	78Zw32XHWv5yoZdlLLpmcn+fMxyFq4lpuSYAJ0TA+tfrQ2Ae6oRYN3qbIEj/kVfV71EzlMfe3Ho
	1uakfruMVTArYec4cMsijLWraPw==
X-Received: from pgnd15.prod.google.com ([2002:a63:734f:0:b0:cbe:6339:419b])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:9202:b0:3c3:64cb:9b99 with SMTP id adf61e73a8af0-3cf76283ed6mr11221625637.6.1787735935314;
 Wed, 26 Aug 2026 02:18:55 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:18:26 +0000
In-Reply-To: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787735885; l=2380;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=Q/A6Dc0B0gRna9abP7QnB2WrkUxTYkjcUX3FbTtwMJI=; b=2YkTIc1SmD00N2MMdJmLmjlME4gtBWUYhIUyh7O71YGRuPDt2J8tpdmJsRGiLloiJb86kHa1e
 IiS094M8sscCQIJsw6CDHW3d9k4k2B+zvtFayWaStH6wkSP2zGMskI9
X-Mailer: b4 0.16.0
Message-ID: <20260826-gmem-inplace-conversion-v11-28-0a15d8a799aa@google.com>
Subject: [PATCH v11 28/46] KVM: selftests: Add selftests global for guest
 memory attributes capability
From: Ackerley Tng <ackerleytng@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Fuad Tabba <fuad.tabba@linux.dev>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

From: Sean Christopherson <seanjc@google.com>

Add a global variable, kvm_has_gmem_attributes, to make the result of
checking for KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES available to all tests.

kvm_has_gmem_attributes is true if guest_memfd tracks memory attributes, as
opposed to VM-level tracking.

This global variable is synced to the guest for testing convenience, to
avoid introducing subtle bugs when host/guest state is desynced.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Shivank Garg <shivankg@amd.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/include/test_util.h | 2 ++
 tools/testing/selftests/kvm/lib/kvm_util.c      | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index a6a3e16578959..d5825211f2727 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -116,6 +116,8 @@ struct kvm_random_state {
 extern u32 kvm_random_seed;
 extern struct kvm_random_state kvm_rng;
 
+extern bool kvm_has_gmem_attributes;
+
 struct kvm_random_state new_kvm_random_state(u32 seed);
 u32 kvm_random_u32(struct kvm_random_state *state);
 
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 08d0bbcd421ea..cd468b2bb8343 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -32,6 +32,8 @@ static void kvm_seed_rng(u32 seed)
 	kvm_rng = new_kvm_random_state(kvm_random_seed);
 }
 
+bool kvm_has_gmem_attributes;
+
 static size_t vcpu_mmap_sz(void);
 
 int __open_path_or_exit(const char *path, int flags, const char *enoent_help)
@@ -527,6 +529,7 @@ struct kvm_vm *__vm_create(struct vm_shape shape, u32 nr_runnable_vcpus,
 		kvm_seed_rng(kvm_random_seed);
 
 	sync_global_to_guest(vm, kvm_rng);
+	sync_global_to_guest(vm, kvm_has_gmem_attributes);
 
 	kvm_arch_vm_post_create(vm, nr_runnable_vcpus);
 
@@ -2311,6 +2314,8 @@ void __attribute((constructor)) kvm_selftest_init(void)
 	srandom(time(0));
 	kvm_seed_rng(random());
 
+	kvm_has_gmem_attributes = kvm_has_cap(KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES);
+
 	kvm_selftest_arch_init();
 }
 

-- 
2.55.0.887.g758fc8c411-goog

