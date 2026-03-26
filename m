Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBA8358396
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 22:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563948; cv=none; b=e6fHfDPWvWwql+CSFVhjS8WFBg+KOjhy2GwunW6SBgrmiriOcmsEf3YjAD0GDMyp08Vse+brozN7C1GlQksjbBa3qRlIf8sjHtFQKlF73p7P4W628XSKlTnQ4LKnFv9CvZfqjHlb+Af4JY5YWS14+COjNyRQuUEPw06FDYmg/1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563948; c=relaxed/simple;
	bh=UdkBDo4oFBkXTHel5o8ZsFzPW+C1nVjCh4r6CInrjXo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rg1dvyCwCRcIaDeKL17OWzsht4fwErKSHrYPkSR0lVE36Vqlw17Eu49FNYjs3IP8+DzujeMG3WtGqnnB31xykq9A6EoPqMms5lu27AcA6rlagYRWRrYKn3En0DmWDZGE8bzDYhUg5KyvGCPQOGl61b15JzmlT2FHW9WzmrxOvyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gS5d3kjc; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gS5d3kjc"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35bea322389so1723003a91.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 15:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774563947; x=1775168747; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uxISHYd3W3FTll0OYwaGPsDXdAUGKJkLGuwa2uoTRP0=;
        b=gS5d3kjcf9ZAX9djM5DGOv++dr5JvMipK8mGdW92aRPH5nq3Xny31A8F3wSQlANyuo
         xQpnmNBU589AewtFsGb75RO3Sxe8YtEeqxTa0kNMF1DAmD85/yIfe6sKomOlSxqWxckT
         W4EhblZkuSmRG2PSzWVKPhsXj/MK2WjJW0cCV7KjSwhVMHbmsYpD0pf2OZq9rOyMvEDY
         ztaDcDUpMQ+E3e3qL0Vhi1Srk0uE/U/V0Zn+IqbhCkRaMhcWFnrng7IOFBwVmMlsaKNc
         1jJs330PH4YktYt5n5U5vjIX8/oxWMkYQFr7Or474mluGLReIypIji+RzMkOoTj9DpVQ
         NPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774563947; x=1775168747;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uxISHYd3W3FTll0OYwaGPsDXdAUGKJkLGuwa2uoTRP0=;
        b=Odx26yrCzT4YAgNIcBBi+bKV/fQUw6fnfDcU6Kc9zLn+CAbyjP/RK5Yv/3iHeMDxXk
         B7iPeHJCEKDEvcggHdsTEdnWnZORQ+nLtTHhv/kaIF4Ijxj3GHP1tHKFml0MNu4oao6f
         T2fzQanQKEvtt2bE0BFPVvlyO7oAi+9V58MGrNQ9TsAtv88ysud9rlzrPKV8NwBbr6KQ
         tk7AK+TnALdx1SdcxTMb8RRZzP60fwiv9M5Dhk/2maja8zA/OFv9zUgIBuyynd0SHn84
         qwBx1ULxCENX7AUIfaowZL4jkk9svBCZmqpSMjcUeXwIyY7VPiYN/zt4gawBVHssJ6jL
         WVLw==
X-Forwarded-Encrypted: i=1; AJvYcCX3WkygPIU/wvlHEfZ6Qmb46o3PD4DHVPH3pmjvWi4q8D/jlmdKhq/o7ZiFBlDlSGvHFYfqPfD1MzDJBNjATQqjF9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPFMe+aKRS0JjVNevjqo0P345J1tjVfcHMTXDDQrQ88Emd/BPU
	y+hN8JEddyTVSemrNMO59vq8rdP1JMJEQD/PJl8YvYmgLp6KDQQ8n03Uaf67SLfLi+bvGNz7man
	eSEJFu0czQV9/ZrUVl5BHDoO9Jw==
X-Received: from pgbcr7.prod.google.com ([2002:a05:6a02:4107:b0:c74:42:899a])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4c:b0:359:8eaa:7f42 with SMTP id 98e67ed59e1d1-35c30056c25mr252326a91.18.1774563946580;
 Thu, 26 Mar 2026 15:25:46 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:24:49 -0700
In-Reply-To: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774563861; l=5283;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=UdkBDo4oFBkXTHel5o8ZsFzPW+C1nVjCh4r6CInrjXo=; b=ekDVL11JYYjJUYvymKIHGTVycixyPeCaJxJvIY0KEoHTIw9VHcxDrJTqDhJsHWWpAaHT93McN
 K08mqT17n/eDM86iL0+q9pH2zxZ9JI8j/SugMW+LvhwJ33ZMYZTlGvK
X-Mailer: b4 0.14.3
Message-ID: <20260326-gmem-inplace-conversion-v4-40-e202fe950ffd@google.com>
Subject: [PATCH RFC v4 40/44] KVM: selftests: Make TEST_EXPECT_SIGBUS thread-safe
From: Ackerley Tng <ackerleytng@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jroedel@suse.de, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	Ackerley Tng <ackerleytng@google.com>
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

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/kvm/include/test_util.h | 32 +++++++++++++------------
 tools/testing/selftests/kvm/lib/kvm_util.c      | 18 ++++++++++----
 tools/testing/selftests/kvm/lib/test_util.c     |  7 ------
 3 files changed, 30 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index 2871a42928471..82f6b371fe767 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -80,21 +80,23 @@ do {									\
 	__builtin_unreachable(); \
 } while (0)
 
-extern sigjmp_buf expect_sigbus_jmpbuf;
-void expect_sigbus_handler(int signum);
-
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
+extern __thread sigjmp_buf expect_sigbus_jmpbuf;
+extern __thread volatile sig_atomic_t expecting_sigbus;
+extern void catchall_signal_handler(int signum);
+
+#define TEST_EXPECT_SIGBUS(action)					\
+do {									\
+	struct sigaction sa = {};					\
+									\
+	TEST_ASSERT_EQ(sigaction(SIGBUS, NULL, &sa), 0);		\
+	TEST_ASSERT_EQ(sa.sa_handler, &catchall_signal_handler);	\
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
index 6f7d3adb25d0a..eaa5a1afa1d9b 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -2347,13 +2347,20 @@ __weak void kvm_selftest_arch_init(void)
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
@@ -2365,12 +2372,13 @@ static void report_unexpected_signal(int signum)
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
index 8a1848586a857..03eb99af9b8de 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -18,13 +18,6 @@
 
 #include "test_util.h"
 
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
2.53.0.1018.g2bb0e51243-goog

