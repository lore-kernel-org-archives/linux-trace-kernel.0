Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178FE2472A1;
	Sun,  4 May 2025 18:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746383321; cv=none; b=r82Q6FNz8CeMFp+wZzz0jEMP1lopxp+0CFbXn5h211HyAbWDmzLJBRl4YJ3gaoDISTJZPaw0K8CGPopoI4R5CENZ/D6pjC6DjslTDOek0Yfz8yptehl6by/1QxrTH8qEvtQi0D4ORvsNEoOljo49c2cKIm8sWCW7yb0GsiQmcxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746383321; c=relaxed/simple;
	bh=6v+xVhxOY0UkacAOKqSthuE1TtEV5XtaFiVQyBzCxUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ex9olxJz4132GzpNodFh/m4qdCTLAMCLxYLEqXmxcZhNGRmg2wq2QQTBfWdqeQE1Cr/Ybt7ibAHAg5V3A1ZlreQLL1kz+cjQ21k6d47iqZbT3eyFhFrV3M/lI2vHDfazOqTWXRQTlHmmzE6NkU+zp2PDAXyWPrraG4xmh8GZ534=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ePGlyFt2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePGlyFt2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89EC6C4CEED;
	Sun,  4 May 2025 18:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746383320;
	bh=6v+xVhxOY0UkacAOKqSthuE1TtEV5XtaFiVQyBzCxUs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ePGlyFt2ir+j1Bisl0m/h88ufkTssFyaRRmekkhhv9J4LwY6xgQjsly0bb2h+H4pD
	 JHXsqul3pYZEoLdwycAxCXEl+q0XCdpuEZYJiemx+ca6NtoZKLz7kjztvdr9oOFSB+
	 NX1vLW0bTRzuykTPfprk4rjumD/I9LjZwxSB5F+sq/NywRWauKGVksuK7rPRTyXzYB
	 XCveWm4yMslL6pic6dIgkrJc5kiTCN+J0l/ITY/AtY4YmR5C6W/4a+AQVnmfeJS5AI
	 9NQ00Nbb0IT3lHdiycA0sP+U+xeGHpcVAiJ5gGozlRrknI8OPn4rShV5xtRL9nEh2v
	 cg1mnShEANXig==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7771DC3ABB7;
	Sun,  4 May 2025 18:28:40 +0000 (UTC)
From: Paul Cacheux via B4 Relay <devnull+paulcacheux.gmail.com@kernel.org>
Date: Sun, 04 May 2025 20:27:52 +0200
Subject: [PATCH v3 1/2] tracing: add missing trace_probe_log_clear for
 eprobes
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250504-fix-trace-probe-log-race-v3-1-9e99fec7eddc@gmail.com>
References: <20250504-fix-trace-probe-log-race-v3-0-9e99fec7eddc@gmail.com>
In-Reply-To: <20250504-fix-trace-probe-log-race-v3-0-9e99fec7eddc@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 Paul Cacheux <paulcacheux@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746383319; l=788;
 i=paulcacheux@gmail.com; s=20250422; h=from:subject:message-id;
 bh=Nem7XKEmMcHI5glWY7jEUqZtjAQzjhIH+nS5TNvLewM=;
 b=uErPiOew5kdUhskb+0wBgOnfEYN78yNGP/MAUmbu0StBUMwKBsonBomXxZHuwKWM5lfKnafRO
 cAMKUWkwDX+ApWIVlSff2FCh54bhhWFcLZc8sZgwXyZO/w2uej+CsZQ
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


