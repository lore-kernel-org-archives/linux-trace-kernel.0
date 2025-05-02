Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4891D254AF6;
	Fri,  2 May 2025 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746191769; cv=none; b=JYR2UugXTAqUtsMPOsoM6uujPqshoycnH+lWEX5gnc9wLNALYHxTANcxiLpMbgJ/vEIHNtXe/NBo3IXm52HjQcYwJEFfENgfus2fbpntEJk7flrBwfYgKJmjgfR6+TgwEE133tJ2VeDmbyHCKbrUlQ+SKTqtq2W0Qk5Sb5TIUmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746191769; c=relaxed/simple;
	bh=TNGKJsHFD9W/hweRfsyrGNZ62fbkiaEiQ9aAoscBr08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b8oDh74LFFeeGa6RXO7UW6ZS6/BaqsTdw6ZHXdZ9gTVJ9dRltZNqInXbmu/nRX2+9SFZ79baxCTX1/hbaNJ8iMHyx/b/d35hGGpl7Kya5Sgs5y55fuIcxyiKFF9Vq5Qz/PcV93U8lq6g6/E9VPyWQerpIzPRxuQBwqSz+vjUu5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUb1uSA4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUb1uSA4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2021C4CEEB;
	Fri,  2 May 2025 13:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746191768;
	bh=TNGKJsHFD9W/hweRfsyrGNZ62fbkiaEiQ9aAoscBr08=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JUb1uSA4Xftxk0q+8kdYpdMf/nINyybwvVRTvy8qexEEgDRpTi1S3Gw2tgLhzQbeL
	 GztTkyacQn7AdQHYfSjMr2GKqWv3IO7N+mT+kE3RLfmbnM9tjv0BnuZEbKrPveugy5
	 kVdpnOhYN+ExEOwdrM1cYbelTmBguSzkijEEwNvEdxXdfu+vHuDtoRLMXF/GNdKnme
	 7v4W3KuLbmGx1Knz1HFE7pfdKx4J7aNjCfHBmg9JPVh5K6CoPWtIZ2GKtsboLrhA6t
	 CuJpJoayuAbqT5ryB3tTASG+UZB5UP3cs8bJPFv6l6C9NyYEMcPzSPlnS+r9M6u5TN
	 ut8Ez0zE0YIzg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C621BC3ABAA;
	Fri,  2 May 2025 13:16:08 +0000 (UTC)
From: Paul Cacheux via B4 Relay <devnull+paulcacheux.gmail.com@kernel.org>
Date: Fri, 02 May 2025 15:15:53 +0200
Subject: [PATCH v2 2/2] tracing: protect trace_probe_log with mutex
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-fix-trace-probe-log-race-v2-2-511ecc1521ec@gmail.com>
References: <20250502-fix-trace-probe-log-race-v2-0-511ecc1521ec@gmail.com>
In-Reply-To: <20250502-fix-trace-probe-log-race-v2-0-511ecc1521ec@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 Paul Cacheux <paulcacheux@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746191767; l=1822;
 i=paulcacheux@gmail.com; s=20250422; h=from:subject:message-id;
 bh=JoafqU4uAGl3ydwos4FNrWPAGaAC2MqNPKDgQHWMZCs=;
 b=KcHSfL163DKlJ1NliuUUMQWzwqr+MsVP+H2ve6fE7oWXWJIIhlwtWCk5QHPT/9rTaAJKOXtz9
 bdzZoYkn6hnDJpyf2/hgWq0lNlOdrSgxB9BIXHG4TaBqtYSIu27wspw
X-Developer-Key: i=paulcacheux@gmail.com; a=ed25519;
 pk=8UguSecyECHKHp0YLS7hTEDob0ctFMr3ygBTeAmrFHs=
X-Endpoint-Received: by B4 Relay for paulcacheux@gmail.com/20250422 with
 auth_id=386
X-Original-From: Paul Cacheux <paulcacheux@gmail.com>
Reply-To: paulcacheux@gmail.com

From: Paul Cacheux <paulcacheux@gmail.com>

The shared trace_probe_log variable can be accessed and modified
by multiple processes using tracefs at the same time, this new
mutex will guarantee it's always in a coherent state.

There is no guarantee that multiple errors happening at the same
time will each have the correct error message, but at least this
won't crash.

Fixes: ab105a4fb894 ("tracing: Use tracing error_log with probe events")

Signed-off-by: Paul Cacheux <paulcacheux@gmail.com>
---
 kernel/trace/trace_probe.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 2eeecb6c95eea55502b83af6775b7b6f0cc5ab94..14a7a0b59cd20a8bc43e3e7c653e986081f924c8 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -154,9 +154,11 @@ static const struct fetch_type *find_fetch_type(const char *type, unsigned long
 }
 
 static struct trace_probe_log trace_probe_log;
+static DEFINE_MUTEX(trace_probe_log_lock);
 
 void trace_probe_log_init(const char *subsystem, int argc, const char **argv)
 {
+	guard(mutex)(&trace_probe_log_lock);
 	trace_probe_log.subsystem = subsystem;
 	trace_probe_log.argc = argc;
 	trace_probe_log.argv = argv;
@@ -165,11 +167,13 @@ void trace_probe_log_init(const char *subsystem, int argc, const char **argv)
 
 void trace_probe_log_clear(void)
 {
+	guard(mutex)(&trace_probe_log_lock);
 	memset(&trace_probe_log, 0, sizeof(trace_probe_log));
 }
 
 void trace_probe_log_set_index(int index)
 {
+	guard(mutex)(&trace_probe_log_lock);
 	trace_probe_log.index = index;
 }
 
@@ -178,6 +182,8 @@ void __trace_probe_log_err(int offset, int err_type)
 	char *command, *p;
 	int i, len = 0, pos = 0;
 
+	guard(mutex)(&trace_probe_log_lock);
+
 	if (!trace_probe_log.argv)
 		return;
 

-- 
2.49.0


