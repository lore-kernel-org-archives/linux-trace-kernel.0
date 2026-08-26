Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC48E3FA5E4
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 09:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735959; cv=none; b=DeJwuZznhlcjczK+TUu2Bfu5Dc1VVVaTARMa+IQ+QjvHM3kELTfY7Amtu3OnKq2XjPnTY8p1Rn60eCFD2zuXueL3yGiST+WAhmnB93gtCd5KYqEod+ghD0X0q7teORg82dkuCipaW24CTh6sSfpwFuBX1WRyc/jVeHEqVlULlAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735959; c=relaxed/simple;
	bh=oKhUk7AQ/XVnJUDFQGQ0T3PCQ/fs9vSttvSiNTvu8TA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hdaXxHY9SxKa/CBWbGdV6umRsOgIlRYdio94lR9x7wvrIJI+03LjquQwtPu4NjGpanaa+0RmB3WgXMxSjas9zn0Zsi5bfSfEfB62RC6o3E6PrGUfLapsDZfE3UbNqqchdvAZZ3v/p8+E21nN/fJFhDh+XqGaa6H8uTMfqFkgJr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O3ifuuQ2; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O3ifuuQ2"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cc73f47bdcso10165285ad.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 02:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787735951; x=1788340751; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L7znZB4+fu5SSeJJtVXjdDiNwNEk+mtdzszQFSpw4D4=;
        b=O3ifuuQ2/RyPIwriTbi7ftfBmep7EjQrGC6UZD94k3IT4W+Dc3yqTf59gvdUQTa3QP
         RZGziMDwMJr3yvdBJF9MLRmAbl0ZsAIl3qrwzea6sNcYkZfldm4TOVobX359+srnLdE/
         aK/2CLJ2lcrKOBQ7Kw1mPnlZVjbh0FTBCIR0IrUxTfrUWsEBO+H49CfRQQGTR/wuK32M
         lDFE+gnB/3GAzpwJ9cXw3lH2DDN0pN2NZ/3c/NBuwDeLh7J24//gOgKxGUnrZ2xwlh0f
         JjBJOLPDrlHOkBtsynSvqnyakRuWgrafyBmWr3M/zn3t5VtZIEsQ8c0kn3bv42YRnIA3
         Kxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735951; x=1788340751;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L7znZB4+fu5SSeJJtVXjdDiNwNEk+mtdzszQFSpw4D4=;
        b=JvCKsvVOpj2Q5b2QCrU8VT7nlT3FROh9y84203Fd33ClFqPT9SMSCnCzCDSkt1oQ/g
         4o4xvGiZp4WNnS8j6S5RBJNl17oajv3d8queEJyRfQHT3atoJoe2gFQEvFs6db3zU9a7
         0kEqI5OIW/nMWOY1Ipx7RZGc0ZHoPIe6UVDd1kNlpM3WuySk6lOgQ3rVNwZp4jwLgqcV
         S3NkHN7xhZCUgCs9qoJEwwQt7neQTxdXd443EVCtPWkMaWUrauyHuUCGehfi6g8yIZOV
         sEv6cR4GcIwKosumWMw9fchxeM3wMkLIBifaNqqG2PeCxHlDrOP1nUxxaHRuBx7gEjxR
         u9gw==
X-Forwarded-Encrypted: i=1; AHgh+RpwMvRpPvF4hXokMajEn7tTHN7WPXW6gwGdKxVoaQ2qPPUDg32O7NhzSXtew81CkieM6muoxP8CAX39gqPNDIxoMDo=@vger.kernel.org
X-Gm-Message-State: AFuF++m4tkr5nX51jy+pYXtp9hsADmo6SbaFWfwtIKXjB9I9Hhy+BMJA
	NLYFBFRUbsJJmw9+zXfZmW7kajJd6gujPS3/Ezu0/7hXHCV9idwhvTGFY+8xpXd6HnFpBmPbU+a
	iY8uuqBFzuqaHkJml/yso99pnEg==
X-Received: from plbkb13.prod.google.com ([2002:a17:903:338d:b0:2d3:768a:b66c])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e550:b0:2ca:1479:d9dc with SMTP id d9443c01a7336-2d707b64aecmr85060725ad.12.1787735950795;
 Wed, 26 Aug 2026 02:19:10 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:18:35 +0000
In-Reply-To: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787735885; l=2738;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=oKhUk7AQ/XVnJUDFQGQ0T3PCQ/fs9vSttvSiNTvu8TA=; b=E3s7CyKmuQ7u5Mqr0j0RmOVbgjxJwnqa6vu50TWR1xpcdjjO+0Nj9vghzwKHhtDd1aD8uPwMQ
 5K1FBJ/M+TkCu5I+2+SMQWquWdJ3o1KIoWaNX0et7JTlybJ0RWLUVFk
X-Mailer: b4 0.16.0
Message-ID: <20260826-gmem-inplace-conversion-v11-37-0a15d8a799aa@google.com>
Subject: [PATCH v11 37/46] KVM: selftests: Add helpers to pin pages with CONFIG_GUP_TEST
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

Add helper functions to allow KVM selftests to pin memory using
CONFIG_GUP_TEST. This is useful for creating test scenarios where some page
has an increased refcount, such as when testing guest_memfd in-place
conversion.

The helpers open /sys/kernel/debug/gup_test and invoke the
PIN_LONGTERM_TEST_START and PIN_LONGTERM_TEST_STOP ioctls. Since this
functionality depends on the kernel being built with CONFIG_GUP_TEST,
provide stub implementations that trigger a test failure if the
configuration is missing.

Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Shivank Garg <shivankg@amd.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h |  3 +++
 tools/testing/selftests/kvm/lib/kvm_util.c     | 25 +++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 575032e9791d2..3cfe243d7c8b0 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -1206,6 +1206,9 @@ static inline int pin_self_to_any_cpu(void)
 	return pin_task_to_any_cpu(pthread_self());
 }
 
+void pin_pages(void *vaddr, uint64_t size);
+void unpin_pages(void);
+
 void kvm_print_vcpu_pinning_help(void);
 void kvm_parse_vcpu_pinning(const char *pcpus_string, u32 vcpu_to_pcpu[],
 			    int nr_vcpus);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index cd468b2bb8343..b1456ed76e27e 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -19,6 +19,8 @@
 #include <unistd.h>
 #include <linux/kernel.h>
 
+#include "../../../../../mm/gup_test.h"
+
 #define KVM_UTIL_MIN_PFN	2
 
 u32 kvm_random_seed;
@@ -645,6 +647,29 @@ int __pin_task_to_cpu(pthread_t task, int cpu)
 	return pthread_setaffinity_np(task, sizeof(cpuset), &cpuset);
 }
 
+static int gup_test_fd = -1;
+
+void pin_pages(void *vaddr, uint64_t size)
+{
+	const struct pin_longterm_test args = {
+		.addr = (uint64_t)vaddr,
+		.size = size,
+		.flags = PIN_LONGTERM_TEST_FLAG_USE_WRITE,
+	};
+
+	gup_test_fd = __open_path_or_exit("/sys/kernel/debug/gup_test", O_RDWR,
+					  "Is CONFIG_GUP_TEST enabled?");
+
+	TEST_ASSERT_EQ(ioctl(gup_test_fd, PIN_LONGTERM_TEST_START, &args), 0);
+}
+
+void unpin_pages(void)
+{
+	TEST_ASSERT_EQ(ioctl(gup_test_fd, PIN_LONGTERM_TEST_STOP), 0);
+
+	kvm_free_fd(gup_test_fd);
+}
+
 static u32 parse_pcpu(const char *cpu_str, const cpu_set_t *allowed_mask)
 {
 	u32 pcpu = atoi_non_negative("CPU number", cpu_str);

-- 
2.55.0.887.g758fc8c411-goog

