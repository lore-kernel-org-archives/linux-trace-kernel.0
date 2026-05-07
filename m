Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98264BC032;
	Thu,  7 May 2026 20:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778185372; cv=none; b=ooqkvWrAMToFbhhNNdHw0fIice/FHHIDvX6Oo4IgvOWc/qaI8g9BrpztMaGQTQXR7kMjsmNsID02LxwNGHSUXN2rfmqi5jgb8n/KljanCaHjXdn4EDiqlhtCxGZsow87iQG7g7swdMk5uVuqxpOLEIS0hbSWzOqDEwao1D3Pp6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778185372; c=relaxed/simple;
	bh=wb2CsjdVWQPunqgfq8q1u+5NI+J7zzN9yC4lznoz+lc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZIaE0ro/9xsbkYidBwTJHGW79/nrQa7uWcPUsVTYDfK4DYJRA7STbwTbaiHwoMFLGC0ZAux4sweBuUE081wNKzeWrAuY+acDFM5fnF8+fhMEZdAqAptfI8sQFvmZ6b08nK77M3bs1qOVI+uUmyCZIUUfcBVeeS5Ia/+/8Z+JUrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5WLqvCW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5WLqvCW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8591C4AF51;
	Thu,  7 May 2026 20:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778185372;
	bh=wb2CsjdVWQPunqgfq8q1u+5NI+J7zzN9yC4lznoz+lc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=J5WLqvCW3p/mqhxEODo4yVtRVM4C9m7oUVW4uODfzu5rU7irFbAiBo7Hb0T/DPfLL
	 2dcOlguLdf/tlAOJshiPhyiYsx5NZiGZ6Xo3aRpDLGKatORzyVS8BhkYzwo9wPr/UF
	 6qR9Lj8eEBdMoyZLNWO/45dcEwbJ9l1wIIwpi8yr0+2uVV67zzChhq1HNVr+VAp/yE
	 wSF3kE080gGRPnBwELHjbWGETRZd8TaMe7oTzzgl3tmSXh1YecF+o1wG/q5YxltaGA
	 9yfqEgOzHrA1/vQCd+53lrSG5PGQKPOBd8IBOv0OKenez1QMl6Z4obbglZgefXNAa9
	 DfBUdmn9AzMWw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934C2CD343F;
	Thu,  7 May 2026 20:22:52 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Thu, 07 May 2026 13:22:53 -0700
Subject: [PATCH v6 34/43] KVM: selftests: Test that shared/private status
 is consistent across processes
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-gmem-inplace-conversion-v6-34-91ab5a8b19a4@google.com>
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com>
In-Reply-To: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
 brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
 ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
 michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
 qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
 shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
 willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
 forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
 aneesh.kumar@kernel.org, liam@infradead.org, 
 Paolo Bonzini <pbonzini@redhat.com>, 
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
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Youngjun Park <youngjun.park@lge.com>, Qi Zheng <qi.zheng@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
 linux-coco@lists.linux.dev, Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778185365; l=3473;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=MrxYeYSTma0Mb5XDzsYrqnIjX6xeEwn3G6JnrRNoe3g=;
 b=0VEP4skWhIQasWMjxcAcMDpcs459UKxYi8KdDS9s3bb1dg3rVTnuVx6nr1Q387wZ6AyFWuVYZ
 xPqbT2t+67dAu32GIEYRnXHMoOH2qaV3dFEzK28LeXpEH9K3ovaObhs
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Sean Christopherson <seanjc@google.com>

Add a test to verify that a guest_memfd's shared/private status is
consistent across processes, and that any shared pages previously mapped in
any process are unmapped from all processes.

The test forks a child process after creating the shared guest_memfd
region so that the second process exists alongside the main process for the
entire test.

The processes then take turns to access memory to check that the
shared/private status is consistent across processes.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../kvm/x86/guest_memfd_conversions_test.c         | 74 ++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
index 960b2da8dd16d..4c33e21f04972 100644
--- a/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
+++ b/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
@@ -323,6 +323,80 @@ GMEM_CONVERSION_TEST_INIT_SHARED(truncate)
 	test_private(t, 0, 0, 'A');
 }
 
+/* Test that shared/private memory protections work and are seen from any process. */
+GMEM_CONVERSION_TEST_INIT_SHARED(forked_accesses)
+{
+	/*
+	 * No races are intended in this test, shared memory is only used to
+	 * coordinate between processes.
+	 */
+	static enum {
+		STATE_INIT,
+		STATE_CHECK_SHARED,
+		STATE_DONE_CHECKING_SHARED,
+		STATE_CHECK_PRIVATE,
+		STATE_DONE_CHECKING_PRIVATE,
+	} *test_state;
+	pid_t child_pid;
+
+	test_state = kvm_mmap(sizeof(*test_state), PROT_READ | PROT_WRITE,
+			      MAP_SHARED | MAP_ANONYMOUS, -1);
+
+#define TEST_STATE_AWAIT(__state)						\
+	while (READ_ONCE(*test_state) != __state) {				\
+		if (child_pid != 0) {						\
+			int status;						\
+			pid_t pid;						\
+			do {							\
+				pid = waitpid(child_pid, &status, WNOHANG);	\
+			} while (pid == -1 && errno == EINTR);			\
+			if (pid == -1)						\
+				TEST_FAIL("Couldn't check child status.");	\
+			else if (pid != 0)					\
+				TEST_FAIL("Child exited prematurely.");		\
+		}								\
+	}
+
+#define TEST_STATE_SET(__state) WRITE_ONCE(*test_state, __state)
+
+	child_pid = fork();
+	TEST_ASSERT(child_pid != -1, "fork failed");
+
+	if (child_pid == 0) {
+		const char inconsequential = 0xdd;
+
+		TEST_STATE_AWAIT(STATE_CHECK_SHARED);
+
+		/*
+		 * This maps the pages into the child process as well, and tests
+		 * that the conversion process will unmap the guest_memfd memory
+		 * from all processes.
+		 */
+		host_do_rmw(t->mem, 0, 0xB, 0xC);
+
+		TEST_STATE_SET(STATE_DONE_CHECKING_SHARED);
+		TEST_STATE_AWAIT(STATE_CHECK_PRIVATE);
+
+		TEST_EXPECT_SIGBUS(READ_ONCE(t->mem[0]));
+		TEST_EXPECT_SIGBUS(WRITE_ONCE(t->mem[0], inconsequential));
+
+		TEST_STATE_SET(STATE_DONE_CHECKING_PRIVATE);
+		exit(0);
+	}
+
+	test_shared(t, 0, 0, 0xA, 0xB);
+
+	TEST_STATE_SET(STATE_CHECK_SHARED);
+	TEST_STATE_AWAIT(STATE_DONE_CHECKING_SHARED);
+
+	test_convert_to_private(t, 0, 0xC, 0xD);
+
+	TEST_STATE_SET(STATE_CHECK_PRIVATE);
+	TEST_STATE_AWAIT(STATE_DONE_CHECKING_PRIVATE);
+
+	kvm_munmap(test_state, sizeof(*test_state));
+}
+
 int main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));

-- 
2.54.0.563.g4f69b47b94-goog


