Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ECF39524F
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Feb 2026 22:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770071468; cv=none; b=ToJs4kR3ZEvSI5RSkGKfQlKFchVgBRCYR689DMBv4KYZPo/KDvnST9cFaegQPPlXNO4Ww3xFUn1QYJsOhf7lpOCWERs1HJgYG5ogdpUjQKjItAI9aPuILzjBlGGFx/QdByubfiacDCCfbiug2YcCuxILhfNuzAPLcwcn/9Ys0CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770071468; c=relaxed/simple;
	bh=kvbj1HjLDMT0IwbHSQ9G42dRvbYAGyIjkIvfNrjJUVg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mtB8GNH58RMDqiOlA79KWXjt8x+L0gQac8Vgny7gA+ExKd+p4tj3X3iAOQD0Fo+QgH/Sw54gSPqDLvbioYvP0BZNS4pkW6tYi5M7jJXKdYr8LC/ou5uRIiDz57uF06LnFek8zbVEf6RdjdAYlNKUG+zkR6SGYcupmN9RDKDdBd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uLw8vb7Z; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uLw8vb7Z"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c6136af8e06so3096949a12.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Feb 2026 14:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770071466; x=1770676266; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WueI9pB0RaGc94DvvPjMzgOVbMHqnAPAFns+gRj5Px8=;
        b=uLw8vb7Z3Sd1n5gD454zT17Jw7tZi13v+CfuEL7N+rJ0nZDcDuXNSFY84RXU5yCnTC
         R82zXES/0mC07JaRbIVxbN34HTRP3qSyUiNIiPKVvN8kqCs6aIngpK9pRfGmWOYTdN7V
         f/O/ZjMnWkVNzjFzS2Otxp2sQuk/8TCIKNEN2buVbjpgTyGH60X2QKvzMRg2mE9gSdrd
         pqv4XDa+LbYOl9YtsaI3PV180tE3qw9WQi5LPZQRKP1B6IaG/sqedD02Lz5Yam2STo4s
         OkPUrBwh3tw5hpDHfSaICXv69todSQjvwRaknS8AQkOthQN2DRA+Yc+FzP/9gscmtUDV
         kA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770071466; x=1770676266;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WueI9pB0RaGc94DvvPjMzgOVbMHqnAPAFns+gRj5Px8=;
        b=kNviWelpz90HIjRRWh31gP4JRYGIitIAcqbBAAU5Ahf/dYDpEMph+zr+C3YS2j32Jn
         umeCqqrrEAQv2nd70A6brPh1ZMUnBxieZNWv457X8spLaQ4RmUkyM7abCWkAsqYkUoYo
         O632pwRsqKnrjYl2CnvHQCiyQB2AVF7IiXfx9BU1eknXoJ4tszSZufUVdnUpWOpH+7Qw
         rLGSN2BtlrQ37dolzaR3npfkS8dBr0nSW+6ghGi/aCOZGDi/gAXX8G5U1Wwox0L8pSRJ
         nr6RBk2x27pUq1eybNIQYSdv9ogtbKbemkWLsaNo1UmTy9tTNWWxIOyb3Grdk1Y+WjOl
         izrA==
X-Forwarded-Encrypted: i=1; AJvYcCWSIbNpKe5O9Xvvc5WkbLxc4DF7lTZVqiNOIg4Rnsqy6cLx2zokIMTwmyKNO26HrqG5+24yuHFuKoOD+n1G3WdGm50=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFsMD3cv4aurAsW4petCGfSTHNXU/Uzmom7hWphMkCGhgh8uJe
	eR694Q7bRLAgQMPynNN3Nh1y+E5UwLhcaOLh2DEgLuMEA3Am4VI5gixcCSYlKjtSSk8z7B8BDZm
	j+gznExH5OBlpEv9o7M1nhe2rgw==
X-Received: from pjbqx5.prod.google.com ([2002:a17:90b:3e45:b0:352:e2af:ed76])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2dc7:b0:340:2a3a:71b7 with SMTP id 98e67ed59e1d1-3543b30027cmr12312576a91.12.1770071466169;
 Mon, 02 Feb 2026 14:31:06 -0800 (PST)
Date: Mon,  2 Feb 2026 14:30:05 -0800
In-Reply-To: <cover.1770071243.git.ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1770071243.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <73b986861dedf768d270a95c4fa259976b5f1d42.1770071243.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 27/37] KVM: selftests: Test that shared/private status
 is consistent across processes
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
 .../kvm/guest_memfd_conversions_test.c        | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
index 89881a71902e..c1a9cc7c9fae 100644
--- a/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_conversions_test.c
@@ -322,6 +322,80 @@ GMEM_CONVERSION_TEST_INIT_SHARED(truncate)
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
2.53.0.rc1.225.gd81095ad13-goog

