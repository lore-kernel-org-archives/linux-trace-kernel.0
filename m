Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.166.143.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910886;
	b=3M0VH8rjcVlomlb9sg8SbWabm2a1iu26o/ZyeYulQ6BhIuJHZK9rvvWVFUdKfS56eBxl
	 psueBT5SlC4Mw2XgIpQp/W5HX95wsZttGxw1ocXvXtFniF69upaOVtstyJz/g1rjfP3hy
	 edcJiQx6HFDhe3rhk7SCOJqDOwEScYuCgRR+7mPmC3RrzCA6Ir2A0Kp30pGHUfpA8nA7A
	 jtNEMsIaoE2wvIOmKECd3YRJm52xmLxi9lnIfwtDu55/4dO9EkwA9Kv7Y7rQgCd6gHBd8
	 4JV53jGMXsx45g9yOEjAYm816d0rihZHlY55g9MwRSOnVh93HxYuuzUwSDZ/GnXhv4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910886;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Infomaniak-Routing;
	bh=I+Dbrs3QptBZJl4e2yqTfL5XvkVcnY9GdfhfJ4l0xYg=;
	b=u6rs4UUvFqFUOnAPUnAlsJyxmQwfDhDBGCt9fzKT6kfMKG6RRJocmHMAvkbQJb1YkCSx
	 yWxTPIIaa4CMU0UFxYzt1sL/bNHJifPEFZ5hY4s1Two+jKey7kHtVY3seWJpnA9VM3VhX
	 I+0vE53nOx+Rp/yIX+ClQdwCFqlxwfcRDkcnoTonlJ4j/W/Ja7Y+K6c4KUEth8/6qeROm
	 bYdPL97MccAYARhvzToq+8yphg0NXqqj6DM80K1YKt9WrUcpcj+u9YOXUEo8XPGOXCJpZ
	 5ChUAaqk6II7UDTP9DC1dRXH5gRKHc3TzEkG5lE8jSG0UUBCdBnFIuso5CF3RX+H5Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=1l53FVk6;
	arc=none smtp.remote-ip=83.166.143.174
Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch [83.166.143.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122E8606A32A
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Nov 2026 10:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 122E8606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=1l53FVk6
Received: from smtp-4-0001 (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jTLP02zFfz4RJ;
	Tue, 17 Nov 2026 11:21:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1794910884;
	bh=I+Dbrs3QptBZJl4e2yqTfL5XvkVcnY9GdfhfJ4l0xYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1l53FVk6cRNQnBwUOQdyvZVIyOm1itgvF4DDsgaD0YVQJpEAKu4Qfs42uf3LnGYJb
	 6x1+mUGE/zmjTlyD6w+GFk/W3RQoXlVSvyq9t1qDrqtnztc0rPEtF5R6BRWCqJXIZP
	 u+K1uJuE09m6mdAB8+wttmNhMHPhbJbNyO8D8yDk=
Received: from unknown by smtp-4-0001 (Postfix) with ESMTPA id 4jTLNz2jpczXZP;
	Tue, 17 Nov 2026 11:21:23 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
	Eric Paris <eparis@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Paul Moore <paul@paul-moore.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	audit@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 3/4] selftests/landlock: Test namespace denial operations
Date: Tue, 17 Nov 2026 11:21:06 +0100
Message-ID: <20261117102110.2524197-4-mic@digikod.net>
In-Reply-To: <20261117102110.2524197-1-mic@digikod.net>
References: <20261117102110.2524197-1-mic@digikod.net>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

The namespace trace tests cover creation and entry denials, but only
creation exercises the quiet path.  This leaves the new ENTER request
tag untested through quiet selection and trace dispatch when audit
logging is suppressed.

Add the missing quiet setns(2) case.  Together with the existing cases,
this exercises all four combinations of CREATE and ENTER with logged and
quieted denials, including each exact namespace_op value.

Cc: Günther Noack <gnoack@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/landlock/ns_test.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/landlock/ns_test.c b/tools/testing/selftests/landlock/ns_test.c
index d4a85cbebeae..52206ad94eca 100644
--- a/tools/testing/selftests/landlock/ns_test.c
+++ b/tools/testing/selftests/landlock/ns_test.c
@@ -2575,6 +2575,13 @@ TEST_F(ns_trace, deny_setns)
 	test_ns_trace_denial(_metadata, true, false);
 }
 
+TEST_F(ns_trace, deny_setns_quiet)
+{
+	if (!self->tracefs_ok)
+		SKIP(return, "tracefs not available");
+	test_ns_trace_denial(_metadata, true, true);
+}
+
 /* clang-format off */
 FIXTURE(ns_proc_open) {
 	/* clang-format on */
-- 
2.56.0

