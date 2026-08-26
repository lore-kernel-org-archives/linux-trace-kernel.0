Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8916F3F9F2F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 09:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735957; cv=none; b=EPAzN9toY/6yRyp60FB/Mcvv+22OtaQmmABlcfsAnT+3KBlDOViQcpbVBoHrsLwnjX11jYaaHUDc3ceHQh/n99Y1xHInuEqr3X9jvm4PLsVLL8iZqEEYjEl/iAl2CosMw2SkI1SVctcOlSbazKyiMzPMZIOukRnlKXEnVrXN+Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735957; c=relaxed/simple;
	bh=bCBoNCNRCJeuLkIkQJRWsNkJ8uDQ/K6p9Vf7UpvmeSI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ATJdl66jhZPgT8l8j6580MiE3ZWEn8sIc/83EKn07QmWor6pFN8EHi1gqIEHvkEcCeIOtPMRUOVmofpUfkJz+UOxjjtAm5nru+1IlBLB1EPd4lTuK4pEiPH3nv9qqET8/YHSeKDubruwVuBdkIXdEdBWwq/v5BCPmncNKG3ypgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=klBcK/NE; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="klBcK/NE"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-848d21bbb55so1001859b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 02:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787735950; x=1788340750; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ip4vM408PsiT+R6udna4cozvVeqGNG7oQO0VV4Lz3WE=;
        b=klBcK/NESLyEwUXHLj7KejEXevqeuJEEXgwKz5dqYBfYNKjcFMB257mx7WJ+vbE3XQ
         giW+DcyHUp1vaW7GCL4pu3sJsEoUIL+FVEgjg96awOsMayD2zIzRCidKidw5/I9S9Fsq
         yXltBBsImQRRVIG2WqKlnYEBzyTfMJZOJx5ZwVtyR3D9xPzWmX3nnqtsQL2mXkw2NTgy
         qzNOvmCfFpNlbQwHstfkqBFOfRkoG0NML0RBd7p7FtQ+oUY9x+UoF1ygjdg9Anup4UAE
         RowwSphBcXaiptd3gZJm6+5vcep5TQhadCx19hhNY4VO4iR2Wi+EuDJErYCUp/IqMFr9
         DMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787735950; x=1788340750;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ip4vM408PsiT+R6udna4cozvVeqGNG7oQO0VV4Lz3WE=;
        b=ddvnivoNfuN+l3kAA2o8Mt1BtyXA643IFu/aAc9UWUXWz5MuI3+z8PrkDluDOrbFD4
         1VLdeIpe226a7UZNkjFJKHetSYfNwYRl0D+xeWEuLE91UcGrr7ToJScAUdfdCA4ep/rU
         /TkePRoEl6AErh6kNkHRbC3MCmg5nnPM607/WuslY58vK5SUxe3iGmsCLrZxQu2jcLmy
         /VKPq9j1seXwgG+E0/XJ6SWx64c/fYy8FGB/KcR10WRyFlJvQ8NdC5MIXIK6aQ7t3O6F
         qk5pBbz7H/3pvpgBPuy+huVmkp6LcQzqbiGdHARLOTGoadmNcbT7HT3X/4SJjN6N8EF4
         s7lA==
X-Forwarded-Encrypted: i=1; AHgh+RoEqExLNGiNeXitLPbu3J3jOtnAFxsvLzlcL9ctIROE7hUF3Mf4hcaWvApOWPDvfci0/CU546l35yX/LpNYR9kgXNM=@vger.kernel.org
X-Gm-Message-State: AFuF++k063zmS1GyaGbYNUTgvSCQIyx412BOJuKtG/xNELlityXHu0d5
	PMKEVXc9NG4FCGFkYsmAwazkRM/5tAVkkkLxnJIqHexGL1nyQOLGIiRi72Ih+eI/C4P6aFk9trs
	x9WQwZXp31Cww+S3yff3RTt6BRg==
X-Received: from pgvm9.prod.google.com ([2002:a65:62c9:0:b0:c8b:6fd:f93f])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:6c83:b0:84f:a82e:d32f with SMTP id d2e1a72fcca58-85371cb0dd6mr10170051b3a.3.1787735949013;
 Wed, 26 Aug 2026 02:19:09 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:18:34 +0000
In-Reply-To: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826-gmem-inplace-conversion-v11-0-0a15d8a799aa@google.com>
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787735885; l=5042;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=mgO9cNUJjKY+AKFX9MzbbDfHmswDZG4pLv666WpGGk8=; b=4sXWR8XsmwnCwhSpArHLWN49pbbGfoT0AtcPlI36HRG/9GlMeMoVWb/i6RtUbq1xqd13MsZps
 yhnSFfxp2j3CfnwMrDrkdGOUO/3A2kREKcloGz8OlQCALrg5kqnLxLv
X-Mailer: b4 0.16.0
Message-ID: <20260826-gmem-inplace-conversion-v11-36-0a15d8a799aa@google.com>
Subject: [PATCH v11 36/46] KVM: selftests: Test that shared/private status is
 consistent across processes
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

Add a test to verify that a guest_memfd's shared/private status is
consistent across processes, and that any shared pages previously mapped in
any process are unmapped from all processes.

The test forks a child process after creating the shared guest_memfd
region so that the second process exists alongside the main process for the
entire test.

The processes then take turns to access memory to check that the
shared/private status is consistent across processes.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Shivank Garg <shivankg@amd.com>
Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../kvm/x86/guest_memfd_conversions_test.c         | 118 +++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c b/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
index b7a54d2a90928..a972a09c5c6e5 100644
--- a/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
+++ b/tools/testing/selftests/kvm/x86/guest_memfd_conversions_test.c
@@ -2,7 +2,9 @@
 /*
  * Copyright (c) 2024, Google LLC.
  */
+#include <pthread.h>
 #include <sys/mman.h>
+#include <time.h>
 #include <unistd.h>
 
 #include <linux/align.h>
@@ -326,6 +328,122 @@ GMEM_CONVERSION_TEST_INIT_SHARED(truncate)
 	test_private(t, 0, 0, 'A');
 }
 
+/* Test that shared/private memory protections work and are seen from any process. */
+GMEM_CONVERSION_TEST_INIT_SHARED(forked_accesses)
+{
+	enum test_state {
+		STATE_INIT,
+		STATE_CHECK_SHARED,
+		STATE_DONE_CHECKING_SHARED,
+		STATE_CHECK_PRIVATE,
+		STATE_DONE_CHECKING_PRIVATE,
+	};
+
+	struct sync_state {
+		pthread_mutex_t mutex;
+		pthread_cond_t cond;
+		enum test_state step;
+	} *sync;
+
+	pthread_mutexattr_t mattr;
+	pthread_condattr_t cattr;
+	pid_t child_pid, parent_pid;
+	int status;
+
+	sync = kvm_mmap(sizeof(*sync), PROT_READ | PROT_WRITE,
+			MAP_SHARED | MAP_ANONYMOUS, -1);
+
+	pthread_mutexattr_init(&mattr);
+	pthread_mutexattr_setpshared(&mattr, PTHREAD_PROCESS_SHARED);
+	pthread_mutex_init(&sync->mutex, &mattr);
+	pthread_mutexattr_destroy(&mattr);
+
+	pthread_condattr_init(&cattr);
+	pthread_condattr_setpshared(&cattr, PTHREAD_PROCESS_SHARED);
+	pthread_cond_init(&sync->cond, &cattr);
+	pthread_condattr_destroy(&cattr);
+
+	sync->step = STATE_INIT;
+
+#define TEST_STATE_AWAIT(__state)						\
+	do {									\
+		pthread_mutex_lock(&sync->mutex);				\
+		while (sync->step != (__state)) {				\
+			struct timespec ts, stop;				\
+			int ret;						\
+										\
+			clock_gettime(CLOCK_REALTIME, &ts);			\
+			stop = timespec_add_ns(ts, 100 * 1000000UL);		\
+										\
+			ret = pthread_cond_timedwait(&sync->cond, &sync->mutex, &stop); \
+			if (ret == ETIMEDOUT) {					\
+				bool alive = (child_pid == 0) ?			\
+					     (getppid() == parent_pid) :		\
+					     (waitpid(child_pid, NULL, WNOHANG) == 0); \
+				TEST_ASSERT(alive, "Other process exited prematurely"); \
+			} else {						\
+				TEST_ASSERT(!ret, "pthread_cond_timedwait failed"); \
+			}							\
+		}								\
+		pthread_mutex_unlock(&sync->mutex);				\
+	} while (0)
+
+#define TEST_STATE_SET(__state)							\
+	do {									\
+		pthread_mutex_lock(&sync->mutex);				\
+		sync->step = (__state);						\
+		pthread_cond_broadcast(&sync->cond);				\
+		pthread_mutex_unlock(&sync->mutex);				\
+	} while (0)
+
+	parent_pid = getpid();
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
+	TEST_ASSERT_EQ(waitpid(child_pid, &status, 0), child_pid);
+	TEST_ASSERT(WIFEXITED(status) && WEXITSTATUS(status) == 0,
+		    "Child exited with unexpected status");
+
+	pthread_mutex_destroy(&sync->mutex);
+	pthread_cond_destroy(&sync->cond);
+	kvm_munmap(sync, sizeof(*sync));
+
+#undef TEST_STATE_SET
+#undef TEST_STATE_AWAIT
+}
+
 int main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));

-- 
2.55.0.887.g758fc8c411-goog

