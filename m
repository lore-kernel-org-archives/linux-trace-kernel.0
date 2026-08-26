Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEA33BFE3E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735968; cv=none; b=jRjoCrmg9MIBA0UU2UM+CHSBJaHzfukvAiDLKaVOkbKL8qb7YbpnFq+BkCHT1pDNUYy5NvjkDpoOSbYGOQJ3ZWb5r+Pp/84hkpKlw7tbLIXoA2aSrlWjQkYAgeLAoGDKkbeCtif9W337bX37iNlW04CMQx+MPCdcCSX3fQtmS9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735968; c=relaxed/simple;
	bh=zBxULgvDHXazZ5SMZOlYLubW+VhR2VpJTUrx3o4CGAE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B4LWItPgL5Z5SfiFVVztDOSfK6ZJoE0SeE6EQE9YsZLzDQde2C2SVvNeklImKnttKPm0jKsqaOmCf8uvugowvtdPpdVtNcE6ElWe+YpbmOAhHJOXS4IOrGI2Eb07qQulXpxw2+5rhn8KxaXmnhMBbutS7wAQ5aqnCXUT0P/RycE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vZwFmzEW; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vZwFmzEW"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ccb6823efcso9256265ad.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 02:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787735960; x=1788340760; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y+F0RPt2BIQhoyPunxbW8b7PnDA004/ENVxwXm2SdeA=;
        b=vZwFmzEWqfFY1KFRob6r8DClY0K1Tg65Oagb3gsz/2h/lczmMaVfVdc0Lux8OXsIRe
         V0ImJrnPvnlWb8yDAeJvcNMWWIvQeGbeDmD+1NBix24c4A9XbfPUrDonMnvfJ8shGILL
         eLyUgceTFuiM7gAxhBe46lyzvWMSAUyQvvikvFwRx0dlgq+TtnfkBj8CRGRzgEaNzX7M
         QPxcOaXzJ2oc6A7HxEvoRkbKbipQInibG8/hAO/+4NYkmSLZcZ+DZ0HE1tS8JmJtKLvL
         QUuB/tllsInA6u2hIKa7VaDazUzaTo9hmS8TMy7YrzsxIJJT5JA8WnEu+y4pcNJ2NstR
         vqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735960; x=1788340760;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y+F0RPt2BIQhoyPunxbW8b7PnDA004/ENVxwXm2SdeA=;
        b=m4Wsfp3M1d+Qlg7S/4iUybXWfMy6NuWG54T/U7jn+j69X97h84+HuWHoYdopa4WbCz
         HUwE2IMzHljoxrXg5TFRPVxaukX9waQim2duq+pplOM1r+gdwJC3DWZcqT8Ekzz/nZjR
         wsYKw2m0EB4KJhIJ2JfaItjZK3Ic4KN4VJxdDTVLoopzjPpqav70w1FkNRsTj73bK4bT
         ThipvHvnOJj7kuzogR1Tak9tS+CzkKAdScaW4aak2G0B/bQBQtsDdOTA873/uc46PLSW
         b3+H1m7Kov45A8EDJk9ossVwOEzCUe0+7nNcbL17EAji+4w9Yxsa/1tjXGK4kb/PakUH
         +cSA==
X-Forwarded-Encrypted: i=1; AHgh+RqzQNeRaVHp7jodiu6j873tgUnG+lh8p8NE802tkM3VLl1wc5eDTgbYQgD5mzubVh5GIP4SfwfoDuzOa9o3ypwFUb4=@vger.kernel.org
X-Gm-Message-State: AFuF++mKbW2DbZGuGDcMNAq/pagvpeLjD19DlocHhKbUMiax5p88YYbp
	XpHUta4PkCzquj0I+nUi3VJJ+CdTob8TiKUp2XtWJ2RjwGZw2k4P00yEgvPkTglCjsL+71LAXAP
	1NG7gmkgAehUOZqholU2HHJ3PNg==
X-Received: from plbmo14.prod.google.com ([2002:a17:903:a8e:b0:2d7:ffd:f2e1])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2341:b0:2c7:ebfb:618f with SMTP id d9443c01a7336-2d707c1020emr84178295ad.14.1787735959205;
 Wed, 26 Aug 2026 02:19:19 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:18:40 +0000
In-Reply-To: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787735885; l=5392;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=zBxULgvDHXazZ5SMZOlYLubW+VhR2VpJTUrx3o4CGAE=; b=+mJZCtE3M/fpif61DFhZWRV1ZVlRrS/x8em+v7Rtj8f6DsVsyejLGAIvq4yHWa8TuuNUlbwVB
 Awqh72Q64bmCf7zIodrA5VJ3FcKFjlgLjcwCp6uM5anzbVnjZMTBAOM
X-Mailer: b4 0.16.0
Message-ID: <20260826-gmem-inplace-conversion-v11-42-0a15d8a799aa@google.com>
Subject: [PATCH v11 42/46] KVM: selftests: Make TEST_EXPECT_SIGBUS thread-safe
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

The TEST_EXPECT_SIGBUS macro is not thread-safe as it uses a global
sigjmp_buf and installs a global SIGBUS signal handler. If multiple threads
execute the macro concurrently, they will race on installing the signal
handler and stomp on other threads' jump buffers, leading to incorrect test
behavior.

Make TEST_EXPECT_SIGBUS thread-safe with the following changes:

Share the KVM tests' global signal handler. sigaction() applies to all
threads; without sharing a global signal handler, one thread may have
removed the signal handler that another thread added, hence leading to
unexpected signals.

The alternative of layering signal handlers was considered, but calling
sigaction() within TEST_EXPECT_SIGBUS() necessarily creates a race. To
avoid adding new setup and teardown routines to do sigaction() and keep
usage of TEST_EXPECT_SIGBUS() simple, share the KVM tests' global signal
handler.

Opportunistically rename report_unexpected_signal to
catchall_signal_handler.

To continue to only expect SIGBUS within specific regions of code, use a
thread-specific variable, expecting_sigbus, to replace installing and
removing signal handlers.

Make the execution environment for the thread, sigjmp_buf, a
thread-specific variable.

As part of TEST_EXPECT_SIGBUS(), assert the prerequisite for this setup,
that the current signal handler is the catchall_signal_handler.

Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Shivank Garg <shivankg@amd.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/include/test_util.h | 30 +++++++++++++------------
 tools/testing/selftests/kvm/lib/kvm_util.c      | 18 ++++++++++-----
 tools/testing/selftests/kvm/lib/test_util.c     |  7 ------
 3 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index d5825211f2727..75e98ec14107f 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -83,21 +83,23 @@ do {									\
 	__builtin_unreachable(); \
 } while (0)
 
-extern sigjmp_buf expect_sigbus_jmpbuf;
-void expect_sigbus_handler(int signum);
+extern __thread sigjmp_buf expect_sigbus_jmpbuf;
+extern __thread volatile sig_atomic_t expecting_sigbus;
+void catchall_signal_handler(int signum);
 
-#define TEST_EXPECT_SIGBUS(action)						\
-do {										\
-	struct sigaction sa_old, sa_new = {					\
-		.sa_handler = expect_sigbus_handler,				\
-	};									\
-										\
-	sigaction(SIGBUS, &sa_new, &sa_old);					\
-	if (sigsetjmp(expect_sigbus_jmpbuf, 1) == 0) {				\
-		action;								\
-		TEST_FAIL("'%s' should have triggered SIGBUS", #action);	\
-	}									\
-	sigaction(SIGBUS, &sa_old, NULL);					\
+#define TEST_EXPECT_SIGBUS(action)					\
+do {									\
+	struct sigaction __sa = {};					\
+									\
+	TEST_ASSERT_EQ(sigaction(SIGBUS, NULL, &__sa), 0);		\
+	TEST_ASSERT_EQ(__sa.sa_handler, &catchall_signal_handler);	\
+									\
+	expecting_sigbus = true;					\
+	if (sigsetjmp(expect_sigbus_jmpbuf, 1) == 0) {			\
+		action;							\
+		TEST_FAIL("'%s' should have triggered SIGBUS", #action);\
+	}								\
+	expecting_sigbus = false;					\
 } while (0)
 
 size_t parse_size(const char *size);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 1188d0a6c0a5f..cac5624e99774 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -2316,13 +2316,20 @@ __weak void kvm_selftest_arch_init(void)
 {
 }
 
-static void report_unexpected_signal(int signum)
+__thread sigjmp_buf expect_sigbus_jmpbuf;
+__thread volatile sig_atomic_t expecting_sigbus;
+
+void catchall_signal_handler(int signum)
 {
+	switch (signum) {
+	case SIGBUS: {
+		if (expecting_sigbus)
+			siglongjmp(expect_sigbus_jmpbuf, 1);
+
+		TEST_FAIL("Unexpected SIGBUS (%d)\n", signum);
+	}
 #define KVM_CASE_SIGNUM(sig)					\
 	case sig: TEST_FAIL("Unexpected " #sig " (%d)\n", signum)
-
-	switch (signum) {
-	KVM_CASE_SIGNUM(SIGBUS);
 	KVM_CASE_SIGNUM(SIGSEGV);
 	KVM_CASE_SIGNUM(SIGILL);
 	KVM_CASE_SIGNUM(SIGFPE);
@@ -2334,12 +2341,13 @@ static void report_unexpected_signal(int signum)
 void __attribute((constructor)) kvm_selftest_init(void)
 {
 	struct sigaction sig_sa = {
-		.sa_handler = report_unexpected_signal,
+		.sa_handler = catchall_signal_handler,
 	};
 
 	/* Tell stdout not to buffer its content. */
 	setbuf(stdout, NULL);
 
+	expecting_sigbus = false;
 	sigaction(SIGBUS, &sig_sa, NULL);
 	sigaction(SIGSEGV, &sig_sa, NULL);
 	sigaction(SIGILL, &sig_sa, NULL);
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index 4dff72f6bd346..89d6d1b572959 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -19,13 +19,6 @@
 #include "test_util.h"
 #include "kvm_syscalls.h"
 
-sigjmp_buf expect_sigbus_jmpbuf;
-
-void __attribute__((used)) expect_sigbus_handler(int signum)
-{
-	siglongjmp(expect_sigbus_jmpbuf, 1);
-}
-
 /*
  * Random number generator that is usable from guest code. This is the
  * Park-Miller LCG using standard constants.

-- 
2.55.0.887.g758fc8c411-goog

