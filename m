Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B33E37FF53
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Jul 2026 18:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783447372; cv=none; b=ZFqELsI+VklVGLrbIu8otAksWUtCMIKWF9TUA4qW4vPj0Yc6cUdpBnpg2hYNUFmHIlmjcOnrbDxpELdoci1iXqYTnwRbIexrWjudzn1w/PGGVbMsyxYV1hPDklaEBabAvhPjQ/znYmYU4wrBZ5JwE3snOwXCbVPFjxIqcD2mmrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783447372; c=relaxed/simple;
	bh=//cvW4gSOO1r60LHv9TAkyXpGY3vFsGKdM0tUjAHR9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z/zlOKj7V1CT3Jqt2hYAzUedDf7qV1WcNCqRfdwBJu/rJ1yhEm1rlE/gAvLPRp9NsHuPquvHwdSrcrT3l/rxJfoBCe7S2mdH4VfLg+IWeuRi9YHz0e0DGL8JZCXiSD7wWG3rBo8Hodh00L9jl80fKDol3vbEEvIaYsZevoqJjbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n6t5I1NR; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6t5I1NR"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-667971437d6so471423d50.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Jul 2026 11:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783447370; x=1784052170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=70oQwU88o+IMY5KYIKx2if+Hd1u/ko0kAaOQAuxSTHY=;
        b=n6t5I1NRJkw47+b837qKCHe75XMsE3tZehx5vwvwIDfuHR3DymyGeLKERc8wTuMMAA
         oSEAnAepSI3k848Y3XsDWenwqfY7J1z/AEJzCXzroCRF3sasztTAQ3t45k92UF6qxazr
         HALCKr9F+Mr7+TfLHy7uFJACoeSyqb9JjWsk2hz7m07ZTEeskC/W1tyvySiuA+LqxIs1
         KapRBwgWFjfu7+82XFHud2IFCleKsdWLA7gyOfJYBxzjztAa/0BhJyl04Rd7M2o2Wodx
         Sx41GQ4BoEfs+/4nAtZMo/RNJBoCZpkOKmErqmdyCvkAd7ix75sIddzFnXsEOpiY/Iwp
         SZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783447370; x=1784052170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=70oQwU88o+IMY5KYIKx2if+Hd1u/ko0kAaOQAuxSTHY=;
        b=Fn7RtxEtgJY3zv81oArmsJ5dKvXvqyVL5Ny/sF459trZljxKznr5vd5ooCE1tCBkpW
         I8r8Lc3JdT3vq+zoeZujJKf1R0d8gHW8Lu8dlYgkVjqn2f5CEJ7NS4mgJA3BhcP0hHWo
         4OHgBTHlKxeAu3QI1d0dfA1URymSWuw1nw0SYnFI1tU0VjoEclsJLqfV38Hi4/RQpdrV
         jKW+GCS1LJuF94E38YrzEuPXtgt6ONF8u1+Kftlyd6+91FjXfVsKN20kWJS2WLANmFwy
         OiuMV6nQzJ9CkS8Lresp44yk+946p2iCSbhOsSyIc4Kn0/2CYR7EFWRnlMrXwhTrWA/z
         UCzQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqsd2v+g5STQIIKh8gMijOJUGRRKdcw37qsqlvB6+VvAbDpMnVGvm9o/bKlKkTArQn3eLguf54pGmsKaMTUdNE6kZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvbRRelAoqM/RojpNaRvI944VgHSWxRNv1YCRGysC944H/OH7A
	SjJLNcYLWQIMmmEfSMdjOQj5oGM0lYn1QWLseVpLRwonrBw0IYn1mNrKDSzLG9ER1Fc=
X-Gm-Gg: AfdE7cmSdMIpljYH4xiic6W5JCIX9JTyWZvKePx9xUa8W3Hw2kGrRajWkRUKlDuFYZg
	soK2KzPl7rL1exkuevpyVJ5FyKZ9CUej+Cl3sc0FWQDZ9TTpZK215+oQOU/98cYGPOHlMmnzDc2
	M4LQc29Trpc/N4hjkPyLeiK4uBnZyVP8Obqbj/mzbYz9qt+n6y+yxR4cqcl2yTsQ9RXVtz0On3a
	XkvejwN7EVKAcY6BWhj7juSBz+s1fy2OwOd27DwBA/maC94B105s+jj2bdKdTgzET4F252zvJ1x
	+6T3HW2F6NRsBWSr1lWi85+FsuGJcY5lb1PnHq+XsH7eLknUcpsX4EIqH+fxR97JnRmGD0ECIjX
	6IpFLDAzDg3Zx73tbH562FfKAoZn7mCjncP7+q6fqc2/lhaNtE+6pbXZ1dv0jqsTwh+h8nF40We
	M4S6R2z4G8yTEok+Xt0CkloNwFyVho3vxRByy99OMoY4wpgc/0unZSz+k6BDCyv/9b0vsEadWpI
	lBHx9ExAgUisYc6m5cfdSrWW45ULJ+9
X-Received: by 2002:a53:d015:0:b0:664:d786:3321 with SMTP id 956f58d0204a3-6677fc69000mr4400946d50.62.1783447370059;
        Tue, 07 Jul 2026 11:02:50 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46e27d555sm165184196d6.7.2026.07.07.11.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 11:02:49 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Beau Belgrave <beaub@linux.microsoft.com>,
	XIAO WU <xiaowu.417@qq.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] selftests/user_events: wait for deferred event teardown after unregister
Date: Tue,  7 Jul 2026 14:02:40 -0400
Message-ID: <20260707180240.2887081-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
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
This resends only the selftest patch; the tracing/user_events fix that
was patch 1/2 of the v2 series is unchanged and being applied separately.

v2 -> v3:
  - abi_test wait_for_event_delete(): only retry the delete on -EBUSY,
    treat an already-deleted event (-ENOENT) as success, and return any
    other error immediately instead of spinning for the full 10s timeout.
    perf_test's clear() already discriminated on errno this way; the two
    now match. Reported by Sashiko automated review.

 .../testing/selftests/user_events/abi_test.c  | 29 ++++++++++++++++++-
 .../testing/selftests/user_events/perf_test.c | 26 +++++++++++++++--
 2 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/user_events/abi_test.c b/tools/testing/selftests/user_events/abi_test.c
index 85892b3b719cc..b71813eaf5c04 100644
--- a/tools/testing/selftests/user_events/abi_test.c
+++ b/tools/testing/selftests/user_events/abi_test.c
@@ -132,6 +132,33 @@ static int event_delete(void)
 	return ret;
 }
 
+/*
+ * Deleting an event drops its last reference, but an unregister may defer
+ * that put (and the freeing of the associated enabler) past an RCU grace
+ * period. The delete can therefore transiently fail with -EBUSY while the
+ * previous reference is still being dropped. Retry only on that transient
+ * failure; treat an already-deleted event (-ENOENT) as success and return
+ * any other error immediately rather than spinning for the full timeout.
+ */
+static int wait_for_event_delete(void)
+{
+	int i, ret;
+
+	for (i = 0; i < 10000; ++i) {
+		ret = event_delete();
+
+		if (ret == 0 || errno == ENOENT)
+			return 0;
+
+		if (errno != EBUSY)
+			return ret;
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
@@ -262,7 +289,7 @@ TEST_F(user, flags) {
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

