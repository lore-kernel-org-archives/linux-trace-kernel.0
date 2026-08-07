Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F1847ECC7;
	Fri,  7 Aug 2026 21:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786139571; cv=none; b=bFXXuln33el3nCfDYsIq2y7nECymY8O23oe82eTdL6iixaT/WaVC51zcbPBDH411+MMSTLUJa9XraCsJFfoM9nsXs8t/J8CAMab79Yb0ZaRVu6oQvhmOynqDaJ+6figkrTDJaRsKr51tODoROq7SeYu4FCGxiqk641EJRWhimoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786139571; c=relaxed/simple;
	bh=ja9kgTXKp8MbX00Y/A8nmdYFnNNk9zdQafFLcm0bclI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UHm26juRFRjypkx2uuUkdE7W5GGdi3L39K01u84oj2K7+ecHjUnvJP/GUrJt6ZaJUEbn2H5SS2uR0YZdyINB5GM+wpQr7MYuiW02ntOK28O9Z5YMyAevh16G5fFHn4R04BXC9BLujdOFgjm1toFnMWDR/O4oiDW7XIwy42oIO2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmySTGsR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmySTGsR"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 254EAC4AF51;
	Fri,  7 Aug 2026 21:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786139571;
	bh=ja9kgTXKp8MbX00Y/A8nmdYFnNNk9zdQafFLcm0bclI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HmySTGsRTcnihovYOPx1lxO/Ls40k2h2IAJ8TQlBfnR9z2KNBGwixBjawbcMG0bNe
	 Nd2Hvy+1nGRU1kOymNzytkzJWDQMCeNg5uavp1EM4X9GcP7g4cjMkxhRPslm8uk2NZ
	 oPUN3j52wuvWdDdzzs9+nfsWSqNAVZ7wk38M3BcCcku/aQ4KqKobwO1jaruiRKUPOM
	 2f3VGcaML/YTvl7V3xS9mKZwPp6nEkB22BmmBCNKGE+wsZdLv3bD1Ja4QzBUEsXPYt
	 rH4eObflxWbB6/dWi+63V/R81A9ClRBtmQag1sxc3Lku8ndkJq+uyZ+k1JA0YzxXVp
	 Dz3lMN6HSmDyQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01091C5ACDC;
	Fri,  7 Aug 2026 21:52:51 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 07 Aug 2026 14:53:13 -0700
Subject: [PATCH v10 34/41] KVM: selftests: Add helpers to pin pages with
 CONFIG_GUP_TEST
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-gmem-inplace-conversion-v10-34-2fc18ee6d3ba@google.com>
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
In-Reply-To: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
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
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
 Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, 
 Baoquan He <baoquan.he@linux.dev>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
 linux-coco@lists.linux.dev, Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786139565; l=2727;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=hcW1DlqCdnSzmI45o3LcgBosQ7tTRCZf45DfrB9G7us=;
 b=D/7W5Lg+H24nvcVwXqYHutKeJIxMyV63gfZOGX1T6+gdFLZZ9D28ih82o1BmY8o8nFoq89D/n
 K2P0seUgnSjCPz3zEhqVM2qdMNqrM3HR/dEYV4zwyHiGOF6w0Es1Ifb
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
2.55.0.654.g21b8a5bc05-goog


