Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB1237F734
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 06:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382431; cv=none; b=AlYDi9yjJrwcsaKuh/1FhY3t6nCAAWtnLYkpMJbnvgSfmPF5147V+IevW2Ygp2657jC+7YwgWefIuhrk4z9YZVMvTpreThl5p0MFAOgcsXQB2v0GAv29du6uqfNQdSJOWD47UPH08ReYKkHKi+SKdZ89XlM+pel/+B0oTyfXpz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382431; c=relaxed/simple;
	bh=eBC3jcG3ScbW3j4TjbtW1xeOPBdtG1NgqDFJ/RzbnOk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sP4F/MBH3K6RugSXf3hz0nmhGCOqb/WUblld/Y4OFu6OCr01oij6LOkVUve5LY3gyBK+7qEbh0/N4tckAr8mVHpR0RUiyjO8A7v9IavInTh4Zf+ittD7gtRmKNpDqJj6eKm1gHW9/Z/Kl2OgcETKQh3A6jx8/2frpmCOJgM5AZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RT/qPJ3W; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RT/qPJ3W"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-359812e4fefso1865470a91.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 23:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773382423; x=1773987223; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fLaJoksD73aDG0T7R/zOcgKAGIjczNDrfVGYxHJRiJ4=;
        b=RT/qPJ3WUXjIpMvoYMYCfBnLEvizy4wWPmsilK2TUX/6+Skql5gfgYtKl6QO6NLfvR
         j413zI05X5Nt6WkrsE9xA5DbvDOh4tiHsP4rzenlE87HEdOmXJtBBbntdKePr4cqLqqu
         q37pKT/pXGeZ4o0Xk1SuBWrihPLCPnZWuV23SghGND2sSe+DqottM9sYkTTDIr2zkcr4
         Hxjl3L0ZfdtGb4+JQedownnJVbFW+TzQMPp1V8lf2EYe/wDWdzd429S1GkzB8tsOGVGQ
         AX18VuRviNPUTeqJw+XAlNRSg9vSuAU3sy9xMAXnx87d+eyHhK1ePiszUiA+dhCxPGBJ
         Mfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382423; x=1773987223;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fLaJoksD73aDG0T7R/zOcgKAGIjczNDrfVGYxHJRiJ4=;
        b=FnGXSEbnwSjpbO1SwNfU2CRntnO/XhCfVh+ovY6+JdIICo1i+doxYNIF8YThRSFReT
         POyNK8yOOHSQSjhnSrxhglP2QGC9PUI6t2AAk7VNyGoBbWeVNGxmGawRIIKPDNZu+Twt
         GRfF2xVkD38IkMuwJi6syml9kEF432WhBhDhD1/2x6aqDO0tJw0e2IhqTELzqoTQHQus
         qRste1LoNG+TuRxjLad6bDkH45uEacG/T9sEete51CIdZA104BaaKxZjQy+TdBxrdgjo
         zcL+uzFCqn06aG2Jbn0jPhxlo74c1GPB0EsbLRb3YYg0cgY9ih8Znq5Rp/9ikogq4zTH
         871w==
X-Forwarded-Encrypted: i=1; AJvYcCWee+rarViuWeARz5JVVls8ccYS+E/SRmHhotyuEVZVnHy8M8/KLrBXnGgpcpzk1wBkX0p+LuOJkIBNpC+AT7vmsJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAyTuBhCPwjKhx/181fhTZoAkHLfQj407IJ4jBm5YPWvbxru8z
	JFYxYcsCJYKg55DR9EYMTpVuwqGx2wXmKbNtTMUasqKvhqzf+AivjRPxfhsU5dbnRgOnIfIPy0d
	agIrgeTpoNXAzdOqxoGG29BIT4Q==
X-Received: from pjbfz8.prod.google.com ([2002:a17:90b:248:b0:356:3104:ed7])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4f42:b0:35a:26e:4522 with SMTP id 98e67ed59e1d1-35a11a6e854mr5613363a91.11.1773382422784;
 Thu, 12 Mar 2026 23:13:42 -0700 (PDT)
Date: Fri, 13 Mar 2026 06:13:12 +0000
In-Reply-To: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773382364; l=5246;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=eBC3jcG3ScbW3j4TjbtW1xeOPBdtG1NgqDFJ/RzbnOk=; b=xc5ePCN6yiNnnFknPRBFvGETXFBQmdy6FOAWKHysQD4E3pAN0eOpXDpm8UAoiqGBvjRU2afAk
 5MQZGwgRZcGB6WLb5SkHg2k++3ucYfdMymNP17vm85Tc0TAg7xd4UtS
X-Mailer: b4 0.14.3
Message-ID: <20260313-gmem-inplace-conversion-v3-33-5fc12a70ec89@google.com>
Subject: [PATCH RFC v3 33/43] KVM: selftests: Make TEST_EXPECT_SIGBUS thread-safe
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
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
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
 tools/testing/selftests/kvm/include/test_util.h | 30 +++++++++++++------------
 tools/testing/selftests/kvm/lib/kvm_util.c      | 18 ++++++++++-----
 tools/testing/selftests/kvm/lib/test_util.c     |  7 ------
 3 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index 2871a42928471..63e57d189f5fd 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -80,21 +80,23 @@ do {									\
 	__builtin_unreachable(); \
 } while (0)
 
-extern sigjmp_buf expect_sigbus_jmpbuf;
-void expect_sigbus_handler(int signum);
+extern __thread sigjmp_buf expect_sigbus_jmpbuf;
+extern __thread bool expecting_sigbus;
+extern void catchall_signal_handler(int signum);
 
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
index 6f7d3adb25d0a..f4aa762f050aa 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -2347,13 +2347,20 @@ __weak void kvm_selftest_arch_init(void)
 {
 }
 
-static void report_unexpected_signal(int signum)
+__thread sigjmp_buf expect_sigbus_jmpbuf;
+__thread bool expecting_sigbus;
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
2.53.0.851.ga537e3e6e9-goog

