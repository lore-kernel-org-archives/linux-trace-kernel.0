Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793723955;
	b=ecd6vncZ6OBywir13NbQGlLscf9YTT5GI2INWmPiXmQcjMQLw/1vtOYcjvfv9c1ukR6I
	 05kEs/jPAQHX1FofsMNn/XW1cn2KsGaE7m3TOlooHvAC+eCRmg7sy/1WQ6mv2xE8OsaRR
	 6gyaOJi+6n5QY/I+dqoZ9KhZ7pajZavsOb0+Qbc8u0mTSSUTJIBSvRn+3+pvKj5gbrSbY
	 DXqeVmtOJHKOklB/C3+JLMXWXu0JpfI4bGFaN17sksqTzig4UtsVlWZAOsZECxIl7UY7E
	 UqwfbBpxpJ3Cr4wNldl5kOzUAOWFRPqlMeiejljtVbA7EjnjvCuxnOaAwY13i1lVy3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723955;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=BG3XUXNGfMqSZ+a+VmceyaP8SMwUJ/N4OhmMopGxXnI=;
	b=nK/VspCl+NVeOmXjOC0KUmtzhzB8sUyVwEMS9Oms1+veUn+LKRyOSiDVWoNq0tzp19B5
	 iKxO0D2U0ZiyAy6+U06WyZZ8TTDnnv6R25gxHvW7gZfyzATop3A/fXq0n4IGl9OFhLVrS
	 bGLF21SDkAqTn6fpo41Q+Wr3GSgGkrFmKSxR9AINpNNH8ChuKgu/JhBpod/JU8q/LMKph
	 MU5Ga2KezJRie0scppwJD8XvChXVJHUO2xrjLQCb83duDQNERBb/pQNDjFxKEMVH9BPR4
	 9BwSG6du/gIf34vVTstEHSZrJ2B9/ZItdHM7PK+DyFxP83vNsb+zJdNXtdv74UVqS2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="EEPDf/dh";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39753606EE95;
	Tue,  3 Nov 2026 16:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EEPDf/dh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04CBE1F0180A;
	Tue,  3 Nov 2026 16:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793723954;
	bh=BG3XUXNGfMqSZ+a+VmceyaP8SMwUJ/N4OhmMopGxXnI=;
	h=From:To:Cc:Subject:Date;
	b=EEPDf/dhT7W2hBjYPrg/nsqs3GTbPjG0gj7KyYetH6vhN0Bobt1yOz+L33XsANHM9
	 8a2Fr93Ac2KTKweHbSHf9OpBa3ea6ato2xeH8XWQ+kxF6PtsLtmw+1HPJhKU+MCtMY
	 K3UaMfXMrQmWfm0j/qdq8vYnKj/JtO3fD09mRYPf/VNQrR9fxkOwgIqgs0Lykx4o1u
	 oVKEDgWs6SoYkM0YJ/rOEFn0cUT401eXsyOt57kGKsXXWEb0E6XOEuwaaU7Swcbjnw
	 9TGIGB0uK0Qj3Ne1h/J9InaRgcFNc94rnbnVWBgIeh4Jq0CRQOSeX1MM4VC/27p0AN
	 uFOXGM/NP43og==
From: Sasha Levin <sashal@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Beau Belgrave <beaub@linux.microsoft.com>,
	linux-trace-kernel@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/user_events: cast pointers through uintptr_t
Date: Tue,  3 Nov 2026 11:39:13 -0500
Message-ID: <20261103163913.640876-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tests put pointers into the 64-bit fields of struct user_reg and
struct user_unreg with a plain (__u64) cast, which warns on 32-bit
architectures:

  abi_test.c:182:25: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]

Cast through uintptr_t.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Found with 32-bit builds of the selftests (gcc 16 and clang 21 with
-m32, with and without -D_TIME_BITS=64 -D_FILE_OFFSET_BITS=64);
KernelCI's 32-bit arm builds show the same warnings. The changed files
build without them now, and the x86_64 builds don't change.

 .../testing/selftests/user_events/abi_test.c  | 10 +++---
 .../testing/selftests/user_events/dyn_test.c  |  6 ++--
 .../selftests/user_events/ftrace_test.c       | 32 +++++++++----------
 .../testing/selftests/user_events/perf_test.c | 10 +++---
 4 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/user_events/abi_test.c b/tools/testing/selftests/user_events/abi_test.c
index b71813eaf5c04..21e1e3cca1979 100644
--- a/tools/testing/selftests/user_events/abi_test.c
+++ b/tools/testing/selftests/user_events/abi_test.c
@@ -179,10 +179,10 @@ static int reg_enable_multi(void *enable, int size, int bit, int flags,
 	}
 
 	reg.size = sizeof(reg);
-	reg.name_args = (__u64)full_args;
+	reg.name_args = (__u64)(uintptr_t)full_args;
 	reg.flags = USER_EVENT_REG_MULTI_FORMAT | flags;
 	reg.enable_bit = bit;
-	reg.enable_addr = (__u64)enable;
+	reg.enable_addr = (__u64)(uintptr_t)enable;
 	reg.enable_size = size;
 
 	ret = ioctl(fd, DIAG_IOCSREG, &reg);
@@ -202,10 +202,10 @@ static int reg_enable_flags(void *enable, int size, int bit, int flags)
 		return -1;
 
 	reg.size = sizeof(reg);
-	reg.name_args = (__u64)"__abi_event";
+	reg.name_args = (__u64)(uintptr_t)"__abi_event";
 	reg.flags = flags;
 	reg.enable_bit = bit;
-	reg.enable_addr = (__u64)enable;
+	reg.enable_addr = (__u64)(uintptr_t)enable;
 	reg.enable_size = size;
 
 	ret = ioctl(fd, DIAG_IOCSREG, &reg);
@@ -231,7 +231,7 @@ static int reg_disable(void *enable, int bit)
 
 	reg.size = sizeof(reg);
 	reg.disable_bit = bit;
-	reg.disable_addr = (__u64)enable;
+	reg.disable_addr = (__u64)(uintptr_t)enable;
 
 	ret = ioctl(fd, DIAG_IOCSUNREG, &reg);
 
diff --git a/tools/testing/selftests/user_events/dyn_test.c b/tools/testing/selftests/user_events/dyn_test.c
index 78e3c33f4015f..32f159544d0bc 100644
--- a/tools/testing/selftests/user_events/dyn_test.c
+++ b/tools/testing/selftests/user_events/dyn_test.c
@@ -58,9 +58,9 @@ static int reg_event(int fd, int *check, int bit, const char *value)
 	struct user_reg reg = {0};
 
 	reg.size = sizeof(reg);
-	reg.name_args = (__u64)value;
+	reg.name_args = (__u64)(uintptr_t)value;
 	reg.enable_bit = bit;
-	reg.enable_addr = (__u64)check;
+	reg.enable_addr = (__u64)(uintptr_t)check;
 	reg.enable_size = sizeof(*check);
 
 	if (ioctl(fd, DIAG_IOCSREG, &reg) == -1)
@@ -75,7 +75,7 @@ static int unreg_event(int fd, int *check, int bit)
 
 	unreg.size = sizeof(unreg);
 	unreg.disable_bit = bit;
-	unreg.disable_addr = (__u64)check;
+	unreg.disable_addr = (__u64)(uintptr_t)check;
 
 	return ioctl(fd, DIAG_IOCSUNREG, &unreg);
 }
diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
index decce06b9ba83..b9c75202f0bd3 100644
--- a/tools/testing/selftests/user_events/ftrace_test.c
+++ b/tools/testing/selftests/user_events/ftrace_test.c
@@ -127,7 +127,7 @@ static int clear(int *check)
 
 	unreg.size = sizeof(unreg);
 	unreg.disable_bit = 31;
-	unreg.disable_addr = (__u64)check;
+	unreg.disable_addr = (__u64)(uintptr_t)check;
 
 	fd = open(data_file, O_RDWR);
 
@@ -174,9 +174,9 @@ static int check_print_fmt(const char *event, const char *expected, int *check)
 		return fd;
 
 	reg.size = sizeof(reg);
-	reg.name_args = (__u64)event;
+	reg.name_args = (__u64)(uintptr_t)event;
 	reg.enable_bit = 31;
-	reg.enable_addr = (__u64)check;
+	reg.enable_addr = (__u64)(uintptr_t)check;
 	reg.enable_size = sizeof(*check);
 
 	/* Register should work */
@@ -239,14 +239,14 @@ TEST_F(user, register_events) {
 	struct user_unreg unreg = {0};
 
 	reg.size = sizeof(reg);
-	reg.name_args = (__u64)"__test_event u32 field1; u32 field2";
+	reg.name_args = (__u64)(uintptr_t)"__test_event u32 field1; u32 field2";
 	reg.enable_bit = 31;
-	reg.enable_addr = (__u64)&self->check;
+	reg.enable_addr = (__u64)(uintptr_t)&self->check;
 	reg.enable_size = sizeof(self->check);
 
 	unreg.size = sizeof(unreg);
 	unreg.disable_bit = 31;
-	unreg.disable_addr = (__u64)&self->check;
+	unreg.disable_addr = (__u64)(uintptr_t)&self->check;
 
 	/* Register should work */
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
@@ -263,13 +263,13 @@ TEST_F(user, register_events) {
 
 	/* Register without separator spacing should still match */
 	reg.enable_bit = 29;
-	reg.name_args = (__u64)"__test_event u32 field1;u32 field2";
+	reg.name_args = (__u64)(uintptr_t)"__test_event u32 field1;u32 field2";
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
 	ASSERT_EQ(0, reg.write_index);
 
 	/* Multiple registers to same name but different args should fail */
 	reg.enable_bit = 29;
-	reg.name_args = (__u64)"__test_event u32 field1;";
+	reg.name_args = (__u64)(uintptr_t)"__test_event u32 field1;";
 	ASSERT_EQ(-1, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
 	ASSERT_EQ(EADDRINUSE, errno);
 
@@ -310,9 +310,9 @@ TEST_F(user, write_events) {
 	int before = 0, after = 0;
 
 	reg.size = sizeof(reg);
-	reg.name_args = (__u64)"__test_event u32 field1; u32 field2";
+	reg.name_args = (__u64)(uintptr_t)"__test_event u32 field1; u32 field2";
 	reg.enable_bit = 31;
-	reg.enable_addr = (__u64)&self->check;
+	reg.enable_addr = (__u64)(uintptr_t)&self->check;
 	reg.enable_size = sizeof(self->check);
 
 	field1 = 1;
@@ -367,9 +367,9 @@ TEST_F(user, write_empty_events) {
 	int before = 0, after = 0;
 
 	reg.size = sizeof(reg);
-	reg.name_args = (__u64)"__test_event";
+	reg.name_args = (__u64)(uintptr_t)"__test_event";
 	reg.enable_bit = 31;
-	reg.enable_addr = (__u64)&self->check;
+	reg.enable_addr = (__u64)(uintptr_t)&self->check;
 	reg.enable_size = sizeof(self->check);
 
 	io[0].iov_base = &reg.write_index;
@@ -401,9 +401,9 @@ TEST_F(user, write_fault) {
 	void *anon;
 
 	reg.size = sizeof(reg);
-	reg.name_args = (__u64)"__test_event u64 anon";
+	reg.name_args = (__u64)(uintptr_t)"__test_event u64 anon";
 	reg.enable_bit = 31;
-	reg.enable_addr = (__u64)&self->check;
+	reg.enable_addr = (__u64)(uintptr_t)&self->check;
 	reg.enable_size = sizeof(self->check);
 
 	anon = mmap(NULL, l, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
@@ -439,9 +439,9 @@ TEST_F(user, write_validator) {
 	int before = 0, after = 0;
 
 	reg.size = sizeof(reg);
-	reg.name_args = (__u64)"__test_event __rel_loc char[] data";
+	reg.name_args = (__u64)(uintptr_t)"__test_event __rel_loc char[] data";
 	reg.enable_bit = 31;
-	reg.enable_addr = (__u64)&self->check;
+	reg.enable_addr = (__u64)(uintptr_t)&self->check;
 	reg.enable_size = sizeof(self->check);
 
 	/* Register should work */
diff --git a/tools/testing/selftests/user_events/perf_test.c b/tools/testing/selftests/user_events/perf_test.c
index 5727cb5b914cf..b444d114b2f00 100644
--- a/tools/testing/selftests/user_events/perf_test.c
+++ b/tools/testing/selftests/user_events/perf_test.c
@@ -89,7 +89,7 @@ static int clear(int *check)
 
 	unreg.size = sizeof(unreg);
 	unreg.disable_bit = 31;
-	unreg.disable_addr = (__u64)check;
+	unreg.disable_addr = (__u64)(uintptr_t)check;
 
 	int fd = open(data_file, O_RDWR);
 
@@ -160,9 +160,9 @@ TEST_F(user, perf_write) {
 	__u32 *val;
 
 	reg.size = sizeof(reg);
-	reg.name_args = (__u64)"__test_event u32 field1; u32 field2";
+	reg.name_args = (__u64)(uintptr_t)"__test_event u32 field1; u32 field2";
 	reg.enable_bit = 31;
-	reg.enable_addr = (__u64)&self->check;
+	reg.enable_addr = (__u64)(uintptr_t)&self->check;
 	reg.enable_size = sizeof(self->check);
 
 	/* Register should work */
@@ -224,9 +224,9 @@ TEST_F(user, perf_empty_events) {
 	__u32 *val;
 
 	reg.size = sizeof(reg);
-	reg.name_args = (__u64)"__test_event";
+	reg.name_args = (__u64)(uintptr_t)"__test_event";
 	reg.enable_bit = 31;
-	reg.enable_addr = (__u64)&self->check;
+	reg.enable_addr = (__u64)(uintptr_t)&self->check;
 	reg.enable_size = sizeof(self->check);
 
 	/* Register should work */
-- 
2.53.0

