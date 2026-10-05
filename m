Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C374A1E07
	for <linux-trace-kernel@vger.kernel.org>; Mon,  5 Oct 2026 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211211; cv=none; b=QiufuQuw11YxwFI9IK1GIH4RmxinqJWQyE5T34XZAM4TBnfMe5IUSfIKBeX0PK+C3H/2Xi4QI/GPHD/D+I+ce7D3Z1weTFRLRd89misguHNpdPQAqZZIVd4aRXd1x9rkyE0NnF3XBpiDNPdxRq8Xql4V4Hfzj+dLhuoaSIOvmMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211211; c=relaxed/simple;
	bh=S7/Ci4iNCC/4LxPbXH5ym+tI8d8LLyVWUE3rJubNJxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqzTT9sRHIf5iOVqRM8j24+idadO6LBJ1BsZmbRf5qFSF03wHxUbR/m0bn/SRAq5NfZv+jpE5fhuslL+4MVBj1EsPnF6DauoRzT96RwrVicTjrwdM7BdBtKGwDQM0dUcLjaoYRAcG3GYDPiGH/SD/7+T+/Dipz3rUhZe0hrxWpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XrEPhd1H; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XrEPhd1H"
Received: from jeffbarnes-ThinkPad-P14s-Gen-2i.corp.microsoft.com (unknown [52.177.6.198])
	by linux.microsoft.com (Postfix) with ESMTPSA id 06E1E20B7169;
	Mon,  5 Oct 2026 07:38:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 06E1E20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791211140;
	bh=xWIFQRjVQEI4kSv2gPPutiiP0ePhm42qw7G/0EfM3EQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XrEPhd1HAj1IcNw9GTIOmpN4J/azDzvQ1ciUKY4xsYzC5AuT1/59uTq0sxSiDCjfN
	 UvmNAK6im+BRvHTC0TJfW/HAxIA5wuAX12dq2/8ww+aleGu5uBXngxSp6N+/q94m1/
	 jD7iU/0APFlrMe65Dclb3h0CYOkqUoT5HdA8ZBX4=
From: Jeff Barnes <jeffbarnes@linux.microsoft.com>
To: linux-trace-kernel@vger.kernel.org
Cc: mhiramat@kernel.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com
Subject: [PATCH v2 1/2] selftests/user_events: Test registration from existing threads
Date: Mon,  5 Oct 2026 10:39:43 -0400
Message-ID: <20261005143944.752112-2-jeffbarnes@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005143944.752112-1-jeffbarnes@linux.microsoft.com>
References: <20261002153934.798176-1-jeffbarnes@linux.microsoft.com>
 <20261005143944.752112-1-jeffbarnes@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create two threads before either registers a user event. Have the first
thread register an event using a shared enable address and bit while it
remains alive, then have the second thread register a different event
using the same address and bit.

The second registration should fail with EADDRINUSE because both threads
share the same address space.

This test fails without the accompanying kernel fix because each thread
can create a separate user_event_mm with an independent enabler list.

Signed-off-by: Jeff Barnes <jeffbarnes@linux.microsoft.com>
---
 .../testing/selftests/user_events/abi_test.c  | 125 ++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/tools/testing/selftests/user_events/abi_test.c b/tools/testing/selftests/user_events/abi_test.c
index b71813eaf5c0..7aef3078556e 100644
--- a/tools/testing/selftests/user_events/abi_test.c
+++ b/tools/testing/selftests/user_events/abi_test.c
@@ -11,6 +11,7 @@
 #include <errno.h>
 #include <linux/user_events.h>
 #include <stdio.h>
+#include <pthread.h>
 #include <stdlib.h>
 #include <fcntl.h>
 #include <sys/ioctl.h>
@@ -258,6 +259,130 @@ FIXTURE_TEARDOWN(user) {
 	USER_EVENT_FIXTURE_TEARDOWN(self->umount);
 }
 
+struct thread_registration {
+	pthread_mutex_t lock;
+	pthread_cond_t cond;
+	__u32 enable;
+	bool start;
+	bool first_done;
+	bool second_done;
+	int first_ret;
+	int first_errno;
+	int first_unreg_ret;
+	int second_ret;
+	int second_errno;
+};
+
+static int reg_enable_name(void *enable, const char *name, int *saved_errno)
+{
+	struct user_reg reg = {0};
+	int fd = open(data_file, O_RDWR);
+	int ret;
+
+	if (fd < 0) {
+		*saved_errno = errno;
+		return -1;
+	}
+
+	reg.size = sizeof(reg);
+	reg.name_args = (__u64)name;
+	reg.enable_bit = 0;
+	reg.enable_addr = (__u64)enable;
+	reg.enable_size = sizeof(__u32);
+
+	errno = 0;
+	ret = ioctl(fd, DIAG_IOCSREG, &reg);
+	*saved_errno = errno;
+
+	close(fd);
+
+	return ret;
+}
+
+static void *register_first(void *arg)
+{
+	struct thread_registration *registration = arg;
+
+	pthread_mutex_lock(&registration->lock);
+	while (!registration->start)
+		pthread_cond_wait(&registration->cond, &registration->lock);
+	pthread_mutex_unlock(&registration->lock);
+
+	registration->first_ret = reg_enable_name(&registration->enable,
+						  "__abi_event_thread_a",
+						  &registration->first_errno);
+
+	pthread_mutex_lock(&registration->lock);
+	registration->first_done = true;
+	pthread_cond_broadcast(&registration->cond);
+
+	while (!registration->second_done)
+		pthread_cond_wait(&registration->cond, &registration->lock);
+	pthread_mutex_unlock(&registration->lock);
+
+	if (!registration->first_ret)
+		registration->first_unreg_ret =
+			reg_disable(&registration->enable, 0);
+
+	return NULL;
+}
+
+static void *register_second(void *arg)
+{
+	struct thread_registration *registration = arg;
+
+	pthread_mutex_lock(&registration->lock);
+	while (!registration->start)
+		pthread_cond_wait(&registration->cond, &registration->lock);
+	while (!registration->first_done)
+		pthread_cond_wait(&registration->cond, &registration->lock);
+	pthread_mutex_unlock(&registration->lock);
+
+	registration->second_ret = reg_enable_name(&registration->enable,
+						   "__abi_event_thread_b",
+						   &registration->second_errno);
+
+	pthread_mutex_lock(&registration->lock);
+	registration->second_done = true;
+	pthread_cond_broadcast(&registration->cond);
+	pthread_mutex_unlock(&registration->lock);
+
+	if (!registration->second_ret)
+		reg_disable(&registration->enable, 0);
+
+	return NULL;
+}
+
+TEST_F(user, preexisting_threads_same_address) {
+	struct thread_registration registration = {
+		.lock = PTHREAD_MUTEX_INITIALIZER,
+		.cond = PTHREAD_COND_INITIALIZER,
+	};
+	pthread_t first;
+	pthread_t second;
+
+	ASSERT_EQ(0, pthread_create(&first, NULL, register_first, &registration));
+	ASSERT_EQ(0, pthread_create(&second, NULL, register_second, &registration));
+
+	pthread_mutex_lock(&registration.lock);
+	registration.start = true;
+	pthread_cond_broadcast(&registration.cond);
+	pthread_mutex_unlock(&registration.lock);
+
+	ASSERT_EQ(0, pthread_join(first, NULL));
+	ASSERT_EQ(0, pthread_join(second, NULL));
+
+	pthread_cond_destroy(&registration.cond);
+	pthread_mutex_destroy(&registration.lock);
+
+	ASSERT_EQ(0, registration.first_ret);
+	ASSERT_EQ(0, registration.first_errno);
+	ASSERT_EQ(0, registration.first_unreg_ret);
+
+	ASSERT_EQ(-1, registration.second_ret);
+	ASSERT_EQ(EADDRINUSE, registration.second_errno);
+}
+
 TEST_F(user, enablement) {
 	/* Changes should be reflected immediately */
 	ASSERT_EQ(0, self->check);
-- 
2.43.0

