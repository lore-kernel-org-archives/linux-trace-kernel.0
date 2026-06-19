Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CD030677D;
	Fri, 19 Jun 2026 00:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781829111; cv=none; b=QmfMgG8tnL2wRXDmVffW4Us0a7dkEdFuODf3iYLdnWKVPLtVNSlxIIu4dY2UGJ8dDKgsw0ATqzja6bGT0Y5tbuUGQs1bBL3Z8xBKLV4JO/ehyyamiogneZmFu8f0wuBuvLdFoeDKDUmKCT29MZDHqWI+2ErjEuaUyQr8VKALe9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781829111; c=relaxed/simple;
	bh=ItFZe2J8b/FkfBi7IEIghaJRZ89f2FS8escwB5wbEzQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p2I5SQurYO6jkQh+2H9eV8Jq57UAe/3wXNrWTjB1FcCtK/mwOYRR4Z5/oI9kSoEQ3O0lHDBdoC/A9Mnr952Ia6uDCEslCzMo+iIclk2e/EACVG0lFNPhcWnwJ/LkesAL5jdl24mZf09oGPX7XXOQbYcAERN06ds2TAAw5slGbQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Byu2QWuL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Byu2QWuL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3427C2BCF5;
	Fri, 19 Jun 2026 00:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781829110;
	bh=ItFZe2J8b/FkfBi7IEIghaJRZ89f2FS8escwB5wbEzQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Byu2QWuLi9j3dCh5oO/ctyJwUIF8n/6QBsbTyZL7yfrXU6BTD4UVAxj1hVSo+PoEY
	 0RJRltfIQIhNKdz7b7Fp6lFBnrzHmmvdd5LIMftwI6iUexnWxM/ylbZC6ifmmGPDMe
	 kbxrgQaKBiy6kkdVtqb0pm9BWHzO4bdVjvyi6jMzFvqshMiZG3f6EwBj3p9qqeEiSX
	 As0B+8pTqqn+6jHehVI5QnDOPLGs7CRm1ZBRqPMQyWnIl80VFxpGKQGPyWjWuZR5y8
	 zkR2Uwxnw1UZzBhyvEMwR/WsTdorJye7oJiXzB5iBuaDgDhhEStAHjfI6Fnrd4cdtz
	 B5EHo7ZkLQTYw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17C8CD98FA;
	Fri, 19 Jun 2026 00:31:50 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Thu, 18 Jun 2026 17:32:15 -0700
Subject: [PATCH v8 38/46] KVM: selftests: Add helpers to pin pages with
 CONFIG_GUP_TEST
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-gmem-inplace-conversion-v8-38-9d2959357853@google.com>
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
 brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
 jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
 oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
 rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
 steven.price@arm.com, tabba@google.com, willy@infradead.org, 
 wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
 pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
 liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, 
 Baoquan He <baoquan.he@linux.dev>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
 linux-coco@lists.linux.dev, Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781829104; l=2608;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=eBlcmMJUwicy3ntzVfnpN8EDTehTOXcHYk5D1gd8UVM=;
 b=5fyin64Hjqlo1S7ClAIWBCDyTnP20mDfOl97InAQpsAxAuURqQ+pm7PYQU9WxWDFAWWIUTJcT
 aeBUR+zPgAQCYD1KOBwPkVowTutZO8/a7ZhbVrFMiSAozwMTFSGH8ef
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

Add helper functions to allow KVM selftests to pin memory using
CONFIG_GUP_TEST. This is useful for testing scenarios where some page has
an increased refcount. such as in guest_memfd in-place conversion tests.

The helpers open /sys/kernel/debug/gup_test and invoke the
PIN_LONGTERM_TEST_START and PIN_LONGTERM_TEST_STOP ioctls. Since this
functionality depends on the kernel being built with CONFIG_GUP_TEST,
provide stub implementations that trigger a test failure if the
configuration is missing.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h |  3 +++
 tools/testing/selftests/kvm/lib/kvm_util.c     | 23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 323d06b5699ec..79ab64ac8b869 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -1195,6 +1195,9 @@ static inline int pin_self_to_any_cpu(void)
 	return pin_task_to_any_cpu(pthread_self());
 }
 
+void pin_pages(void *vaddr, uint64_t size);
+void unpin_pages(void);
+
 void kvm_print_vcpu_pinning_help(void);
 void kvm_parse_vcpu_pinning(const char *pcpus_string, u32 vcpu_to_pcpu[],
 			    int nr_vcpus);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index b73817f7bc803..524ef97d634bf 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -18,6 +18,8 @@
 #include <unistd.h>
 #include <linux/kernel.h>
 
+#include "../../../../mm/gup_test.h"
+
 #define KVM_UTIL_MIN_PFN	2
 
 u32 guest_random_seed;
@@ -639,6 +641,27 @@ int __pin_task_to_cpu(pthread_t task, int cpu)
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
+}
+
 static u32 parse_pcpu(const char *cpu_str, const cpu_set_t *allowed_mask)
 {
 	u32 pcpu = atoi_non_negative("CPU number", cpu_str);

-- 
2.55.0.rc0.738.g0c8ab3ebcc-goog


