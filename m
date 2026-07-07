Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C025437865
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Jul 2026 16:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783443571; cv=none; b=amvwx4q+UbRyObGkEVhbwT/I36Vx8YcpMlJ1XQ/lkTwO3h/MED3o2A/Dympppty2jq3WOtTLtToaCJY6VkfwWFJnIIa2kjdbPeCKRQuo7dtImge5c5Iy1faf6HfLF0MeA0w8KeRzG5h+n5vNlTP84gmL7nRglWFTWH4Hnnz8OWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783443571; c=relaxed/simple;
	bh=wVpUm1v/RMR6gvje70eJqG2PiFg23Q5lx4GrDBMwOvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gfqw40NR4U5bQoQKudHc2LHX2m4FYXkDwQeXRgc0t+nvjaVeVudJS86zDZesLqcmI1WTpQ2ySHXBdUzi9n6Z0+iLJ81JKnVsmtJ5u2VHC/96pmC6AtDwsK6YKgadh955KcIe/LBrinHGj0EsX/D7K+i5iqbuxLcMi1liGqHEOLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RyquBbzD; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyquBbzD"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8fdaabec24aso5141406d6.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Jul 2026 09:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783443569; x=1784048369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sSuBxh5hIAtEieYGaAH1R8faa2usOp5VRIGJ+Usc34I=;
        b=RyquBbzDBiYMA9bAMTD4LBYZnqJ66ZlNHLd7BE1S1Ekejk4sP87lv4R8sAOmZ3iAEl
         6v1zxmEGb4nMMD6Vv6Of+gBzXRK9zGhiF05RhiFzhla/TeTcEcXd5sH1CNR9x9Eb2Rde
         9+EfaLi7V/50SGCBZKcJ5rkH/ZU1Ixuf+itdfZS+12Pwf/zFmn19Af5qPRpb7f0UtZ2W
         fz2FzbfNX3/nWq4qYj9EZZaSejXbouwJOTFJmVJ6/2XlFaOknjXK3COheBV92sSwjIYe
         SmX2LYj4kObyBtZpJ0R7Lh1bbuaF4TtApj/4TCj7wb7oSEe98H3gnv4sP7jllN/9cVcI
         h6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783443569; x=1784048369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sSuBxh5hIAtEieYGaAH1R8faa2usOp5VRIGJ+Usc34I=;
        b=VMdT3UZqm4FqMwD2DlQ5P7QOCGBFTdqiuNkRIgixOgw85K/so4naBvFqPDhXWNKyWM
         G8HPMBXdr0j2xkPdxiBX77hLIDqCayMK+408HtBLMXqtvlzpaFzWyNfDQQM4WkLJUsPf
         t6jNF1c+ci7yLjOhbFcoHjlMcESQFKhtu3MIzYeAtKr0LNPuUtj4tAQIO1HK8R9r7TOU
         HrgfPMN5HAI68TUxiB6M6iZ8jR7q9XoRQDPndgzhaiecJrPM0EiAxyZQNAD6G0c9Ov9Y
         5sl1fW4kbXrANSpJQ5R6krg+EIFLjm4/NYqu60J2BVuoyHjDMpkzshrlOYmFSk4hPEHw
         lMxg==
X-Forwarded-Encrypted: i=1; AHgh+Rr1wyNpi7bJqXNVSYYbf+F9ANS0i562bHrrBY33aBfdA2gGlaVoXzBb3bzLBcn2odTx7z7S9uUhhRz1mnzWeFMuDmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYwxbtRRkx8Lj7Bs9mBS+uQlrFoWPoGfd2dccPfxLrOS1R/kxP
	m16mkvhcy5oORY0J4EizO4NFazKnCAKrOgC0wxfnWKzVs5o1C9GTfNsn
X-Gm-Gg: AfdE7clAB9xGjl/fBqcpgtVhk47TSCS/jk7A6zK7PPJnlVWdhUqBWiKbc0+pAzbgt4v
	0IneoIOW0uFjsre9DDOPk/kseWko5GNRWyUEkKHkw2oWpvO5LiJq93q5of5jZoL99i2aM92lKKu
	4ek6HvjuBzGD++T6C2SQGIFdP7JFfMSRhuLvmtphcDhsf6kcXSsbVSU5PDA3McsqZnRWgMWkKLr
	9qYvveShbjtanB/RYLUbcivrfK9mqPZ5J7sVoPsLi0ZQEtlP9Dmgt8Mz6Qd+KKPFlL4MSyjr02T
	afWnjqBgalSfVndUBVNd9a8702shETiEFfTpPnU7y+ZBVwlLX5cBORk8pyWF2VTxh0rkRn67prO
	IZaTBGLCjXkX6nO0taxzbj4sr1ejGEl+oCJ83xgF0bgdaxQrpaFBL33qJJDBoYhbfz7uSgCbWNo
	XUa6Lq/sN4+rl+smJXJpolDc9hR8N7tNR/J7DRYiMzwW3Kls+Renc3VEdjxJQQsK+k7zuQAqstX
	YyRvUOW6U/cKNCGeaCzqZ9tMmVZXTYV
X-Received: by 2002:a05:620a:4144:b0:92e:745c:6c5a with SMTP id af79cd13be357-92ebb4bd1dbmr703200185a.14.1783443569056;
        Tue, 07 Jul 2026 09:59:29 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90bb91adsm1209145385a.20.2026.07.07.09.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 09:59:28 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Beau Belgrave <beaub@linux.microsoft.com>,
	XIAO WU <xiaowu.417@qq.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] selftests/user_events: wait for deferred event teardown after unregister
Date: Tue,  7 Jul 2026 12:59:12 -0400
Message-ID: <20260707165912.2560537-3-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707165912.2560537-1-michael.bommarito@gmail.com>
References: <20260707165912.2560537-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Unregistering a user event now defers the drop of the enabler's event
reference (and the freeing of the enabler) past an RCU grace period. As a
result DIAG_IOCSDEL can transiently fail with -EBUSY while that last
reference is still being dropped, where it previously succeeded
immediately.

Two tests assumed the delete takes effect the instant the unregister
returns:

  - abi_test "flags" deletes the event right after disabling it.
  - perf_test's fixture teardown clear() deletes __test_event before the
    next test registers the same name; a stale event makes the following
    registration fail with -EADDRINUSE.

Retry the delete until it succeeds (or the event is already gone) with a
bounded wait, matching the existing wait_for_delete() idiom in the same
suite, so the tests are robust to the deferred teardown.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 .../testing/selftests/user_events/abi_test.c  | 24 ++++++++++++++++-
 .../testing/selftests/user_events/perf_test.c | 26 ++++++++++++++++---
 2 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/user_events/abi_test.c b/tools/testing/selftests/user_events/abi_test.c
index 85892b3b719cc..9e2f84d281afc 100644
--- a/tools/testing/selftests/user_events/abi_test.c
+++ b/tools/testing/selftests/user_events/abi_test.c
@@ -132,6 +132,28 @@ static int event_delete(void)
 	return ret;
 }
 
+/*
+ * Deleting an event drops its last reference, but an unregister may defer
+ * that put (and the freeing of the associated enabler) past an RCU grace
+ * period. The delete can therefore transiently fail with -EBUSY while the
+ * previous reference is still being dropped. Retry for up to ~10 seconds.
+ */
+static int wait_for_event_delete(void)
+{
+	int i, ret;
+
+	for (i = 0; i < 10000; ++i) {
+		ret = event_delete();
+
+		if (ret == 0)
+			return 0;
+
+		usleep(1000);
+	}
+
+	return ret;
+}
+
 static int reg_enable_multi(void *enable, int size, int bit, int flags,
 			    char *args)
 {
@@ -262,7 +284,7 @@ TEST_F(user, flags) {
 	ASSERT_TRUE(event_exists());
 
 	/* Ensure we can delete it */
-	ASSERT_EQ(0, event_delete());
+	ASSERT_EQ(0, wait_for_event_delete());
 
 	/* USER_EVENT_REG_MAX or above is not allowed */
 	ASSERT_EQ(-1, reg_enable_flags(&self->check, sizeof(int), 0,
diff --git a/tools/testing/selftests/user_events/perf_test.c b/tools/testing/selftests/user_events/perf_test.c
index cafec0e52eb31..5727cb5b914cf 100644
--- a/tools/testing/selftests/user_events/perf_test.c
+++ b/tools/testing/selftests/user_events/perf_test.c
@@ -85,6 +85,7 @@ static int get_offset(void)
 static int clear(int *check)
 {
 	struct user_unreg unreg = {0};
+	int i, ret;
 
 	unreg.size = sizeof(unreg);
 	unreg.disable_bit = 31;
@@ -99,13 +100,32 @@ static int clear(int *check)
 		if (errno != ENOENT)
 			return -1;
 
-	if (ioctl(fd, DIAG_IOCSDEL, "__test_event") == -1)
-		if (errno != ENOENT)
+	/*
+	 * Deleting the event drops its last reference, but the unregister
+	 * above defers that put (and the freeing of the enabler) past an RCU
+	 * grace period. The delete can therefore transiently fail with -EBUSY
+	 * until that reference is dropped. Retry for up to ~10 seconds so the
+	 * event is actually gone before the next test registers the same name.
+	 */
+	for (i = 0; i < 10000; ++i) {
+		ret = ioctl(fd, DIAG_IOCSDEL, "__test_event");
+
+		if (ret == 0 || errno == ENOENT) {
+			ret = 0;
+			break;
+		}
+
+		if (errno != EBUSY) {
+			close(fd);
 			return -1;
+		}
+
+		usleep(1000);
+	}
 
 	close(fd);
 
-	return 0;
+	return ret;
 }
 
 FIXTURE(user) {
-- 
2.53.0

