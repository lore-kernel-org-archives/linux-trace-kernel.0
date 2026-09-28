Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CE24F3924
	for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Sep 2026 17:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790615672; cv=none; b=Ju9kx5IOIvMew6Py1WtSx4Ch3m3jaSjO1YydkrlpyPZL6abk1GQecUIDEoFEEyk1eYCOt+uJar4Vz5RXDT2a7FuC8pzDZBVpgBXmFwXBPhLoy/SjXy6pCL/zerQ3y+bRUP8ElD207B49yWwbd5WyeyoHoQXpZHqzf3GL14h2ZUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790615672; c=relaxed/simple;
	bh=o59pLErvV1Eka8G0igqbbC6iIQ7emfCpQ9bDOzw+AAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M7cHmx5Q4GhiWKBEGQLvgKu9T+nkG8+4rOg3HitolWq+elV3OVotU/f0UmbK5eTCoIwYXgmUsY6vUI5s8rY+J0WKpGvTOANDBFYgpLsjDekxcp92HMtozk03JyrDE+orB+HfOKSLDcOyPKlAxD7Jmw6W+eSjbA9Oihw9d3yZnxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmMbLBhl; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmMbLBhl"
Received: by mail-oo2-f43.google.com with SMTP id 006d021491bc7-6d817a94799so674479eaf.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Sep 2026 10:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790615669; x=1791220469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=brqpvi0CsTT/mXnGEZ0fbXA8kawPBkDyjGi1skaJHcQ=;
        b=AmMbLBhlejMXSnZI3uouKyZftGnw4B8IlNH7OZfigtXEyRfw2pWiXI5IZnuaOolB8e
         rTUiP8Gdgm6s9I3Pv+45yPPEf6yQfJdP4660dcH1Px6ju3Ko+l6CvrgRIrNi9KAEOFPm
         Xi6c3Wc5q3HlAkuF81AnMxx2nv0pMhGCh9LhzVI8JdcFMvRYrrqmR/C7xbuoYa4g1ZLx
         DrZCgI9oVM/zlPfiuYJszedIqinDzvgNHz43CZAccb9SSH4czSHI+zPu4PPSBQydmSuL
         EdvuHTl9SLxOiwzSgsAQ/LOcCYMYZMi7GMABEB499pfCBuVE2jLo7dJXJKE01pMeQwS/
         bkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790615669; x=1791220469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=brqpvi0CsTT/mXnGEZ0fbXA8kawPBkDyjGi1skaJHcQ=;
        b=o+ynDgCFThfuwMecQEGWt4i1fyaea8WYjueslop9Y0dLIohtxLgvdE0Qsxh1WH3aaO
         /IWhaHG6JeK5D0MTqbZ723UvJDZYaGXdf/yxw6SV5ZoKzG9nnbSPcnp3chUSOm4XYtAq
         e+snddnMo6I4nme/THX1CVYLy2h5IRhKUcxoxnOIQVMSRtYvvGLQUm/KVQis+cyTywcg
         xdcMBY4taiPqjn9b5I9pa0BigDFScvlvn59uweXsUBNbupxv/h56hPo+InuQgRCMo2xM
         4oh/LUPeWM4ZyZvAfol2sKbGXPkOPAjwN6vsL/adoNwgv4hQs/FMfYanX99WkP4k7zZ3
         kbBw==
X-Forwarded-Encrypted: i=1; AKwUvBzf7rI2wb5idh3zU23mQJrzvfNUcGkrT4DXuOy932mgtHzZOV4fl63Kw1cEhFUMEmw75l3X7VXQe8F43kefUAYMZKw=@vger.kernel.org
X-Gm-Message-State: AFuF++lbNqegYd13NZGSdgPZX62BRvjs51I1PBHwtf74WSXEf9ZpbuV0
	rSzM5mwHeZcqxPhvQFAiVUUU+SVlvgD39/ww4rCvv2ACJb/TciPP9VHs
X-Gm-Gg: AYBFou1IstAQ/AjAqU/EiGKJd+ptiz2eUI0WVfDkGXXYxrWZa4h9MduRPRZAZrpsn8F
	PfYBiGxmCdhSIE1zLXP2/RLrgghVtBBzWmbkN+PSmZupqql2olsZCr/wvKoIkOGAPslpVuAwc7A
	iHNYia4pndxL7dYtmnj88F6mpznNwDfdL0JGn9fcCm7AG7qNPgK+pSPvkw1SjosfKBj4vxitckb
	aNzwRX60w3uRvY4RvB+iU1qYE4+D6lu3jAhCEc2gz6MpRO8XyihUuM+Hrv17pjVJESh2TMTSuGf
	llXLSrIXavqQ5WMNvGllte5cpGQQaBL7+GwuyT8r8+YLYTHc71qai/4UArQOll8CrzGl9gpq1g/
	dMEJrDIy6MAUuS/BkszgbjlZTn0PUcT9N+TFTw3cL881vprgyeddtSbTlAh3QFRuU5jjMpUBQA1
	MWx8AQ7ZQAa62DtPvjCyF1tIUoRzTnYH0c0FsBFVhOepwOp3Eiq00Pm2AgGDtLnx7GXbYosRGR2
	zLn6mHS+zsxS2Kavvy4z8bvB2oijJQKbcy74CMS
X-Received: by 2002:a05:6820:81d1:b0:6d7:9cf4:e993 with SMTP id 006d021491bc7-6d79cf4f414mr6840896eaf.11.1790615669113;
        Mon, 28 Sep 2026 10:14:29 -0700 (PDT)
Received: from archlinux.lan ([136.34.156.120])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d87d9060cbsm5492874eaf.0.2026.09.28.10.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:14:28 -0700 (PDT)
From: Danish Khateeb <danishkhateeb03@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danish Khateeb <danishkhateeb03@gmail.com>
Subject: [PATCH 2/2] selftests/user_events: Fix pointer casts for 32-bit builds
Date: Mon, 28 Sep 2026 12:14:24 -0500
Message-ID: <20260928171424.199202-2-danishkhateeb03@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928171424.199202-1-danishkhateeb03@gmail.com>
References: <20260928171424.199202-1-danishkhateeb03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tests cast pointers directly to __u64. On 32-bit builds GCC
sign-extends such casts, so addresses above 2 GiB, like the stack of a
32-bit task on a 64-bit kernel, become 0xffffffffxxxxxxxx and every
registration fails.

Cast through uintptr_t so the tests also work when built for 32-bit and
cover the compat ioctl path.

Assisted-by: LLM
Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
---

Notes:
    Built with and without -m32. With 1/2 applied, the 32-bit tests pass on
    x86_64; the 64-bit binaries are unchanged in behaviour and still pass.
    The -Wpointer-to-int-cast warnings left in a 32-bit build come from
    kselftest_harness.h, not from these tests.

 .../testing/selftests/user_events/abi_test.c  | 10 +++---
 .../testing/selftests/user_events/dyn_test.c  |  6 ++--
 .../selftests/user_events/ftrace_test.c       | 32 +++++++++----------
 .../testing/selftests/user_events/perf_test.c | 10 +++---
 4 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/user_events/abi_test.c b/tools/testing/selftests/user_events/abi_test.c
index b71813eaf5c0..21e1e3cca197 100644
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
index 78e3c33f4015..32f159544d0b 100644
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
index decce06b9ba8..b9c75202f0bd 100644
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
index 5727cb5b914c..b444d114b2f0 100644
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
2.55.0

