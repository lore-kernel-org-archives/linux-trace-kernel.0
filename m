Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48877254AF5;
	Fri,  2 May 2025 13:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746191769; cv=none; b=oHF0cgFLNJ1Epr8Fwdgau72SuwcX8Lgk8onjLR0AhWSFsX6A4cD0mbt1c6hMw7EbzZ8z4Yg5YRa8/JUcogJonYiyF02dtph2hwTiudOB33WeJk+4drpzrMjJkDOp7OWdRykAzx4oY1fmlIZhiIuc+rvkO0MSX8tR7cmCHvrlTis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746191769; c=relaxed/simple;
	bh=6v+xVhxOY0UkacAOKqSthuE1TtEV5XtaFiVQyBzCxUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZkjJ480pdfjZWiJ3yodXQmhF1rABvOD4Ak41hTTkrO5DTFuDGxpjARu+LiLvNGHRCOsoRhV6SiJZ8mqW7iKI/8qVq4Mt4mxgWIMhW4E97Wpp22umSOgSU/OM+0o2gDAh1yXIo7bFZfIV9hQXM+V+zNbmyUodom23TWhGPmzGsnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFfYsuZR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFfYsuZR"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C959CC4CEEE;
	Fri,  2 May 2025 13:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746191768;
	bh=6v+xVhxOY0UkacAOKqSthuE1TtEV5XtaFiVQyBzCxUs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jFfYsuZRzaZl/t3B4KZhhIjCc0eeYNeaOhn3DHLSEeE5yqvSgOXr+wOzM2qnYq0X6
	 YEdtkKwd+0GXo9QpVCWQoXSi3Y/ITqheBdDVm5S89DFr7KeWH0ONiYRdyjKwZ5g/uq
	 Nz2aQVI7ucWZbsVGthyqDqmyyyRxik2/XOHqoglNAXnJYasxeNL/oR9NtVYGpgyWfV
	 VMw7vnH9TpYAyH0lhFa16wPl4VzDkrLre2LjXKDV6RfVYo8+fwvssBdXdEYXabwOn+
	 PzODZ4IJd2/s8RdBU3K+s0OQv/QotrfLvAuYHXbFJ2BuqbnqDi5Gfzw680Lo0y0Ye7
	 cBDaHYiLbd4QA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB1AC3ABAD;
	Fri,  2 May 2025 13:16:08 +0000 (UTC)
From: Paul Cacheux via B4 Relay <devnull+paulcacheux.gmail.com@kernel.org>
Date: Fri, 02 May 2025 15:15:52 +0200
Subject: [PATCH v2 1/2] tracing: add missing trace_probe_log_clear for
 eprobes
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-fix-trace-probe-log-race-v2-1-511ecc1521ec@gmail.com>
References: <20250502-fix-trace-probe-log-race-v2-0-511ecc1521ec@gmail.com>
In-Reply-To: <20250502-fix-trace-probe-log-race-v2-0-511ecc1521ec@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 Paul Cacheux <paulcacheux@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746191767; l=788;
 i=paulcacheux@gmail.com; s=20250422; h=from:subject:message-id;
 bh=Nem7XKEmMcHI5glWY7jEUqZtjAQzjhIH+nS5TNvLewM=;
 b=KYKG2TOWU5FBONQSxiwPiN1wLq7a9XhDN50L9Kbh9e7FpkO6aMz3g23Ztn47NNi6e7iybcHGw
 7Hp1gCDmBfCDcnoXyC04q2UmUHOAg1G6R6PbulVP2t8ZQYh/FD0XP/4
X-Developer-Key: i=paulcacheux@gmail.com; a=ed25519;
 pk=8UguSecyECHKHp0YLS7hTEDob0ctFMr3ygBTeAmrFHs=
X-Endpoint-Received: by B4 Relay for paulcacheux@gmail.com/20250422 with
 auth_id=386
X-Original-From: Paul Cacheux <paulcacheux@gmail.com>
Reply-To: paulcacheux@gmail.com

From: Paul Cacheux <paulcacheux@gmail.com>

Make sure trace_probe_log_clear is called in the tracing
eprobe code path, matching the trace_probe_log_init call.

Signed-off-by: Paul Cacheux <paulcacheux@gmail.com>
---
 kernel/trace/trace_eprobe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index c08355c3ef32b4124ac944d7e3a03efb66492269..916555f0de811f03feed9d923c63078b0e4c993b 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -969,10 +969,13 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 			goto error;
 		}
 	}
+	trace_probe_log_clear();
 	return ret;
+
 parse_error:
 	ret = -EINVAL;
 error:
+	trace_probe_log_clear();
 	trace_event_probe_cleanup(ep);
 	return ret;
 }

-- 
2.49.0


