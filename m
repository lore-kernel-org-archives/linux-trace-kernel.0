Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D5D3DB97A;
	Mon, 20 Jul 2026 10:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542372; cv=none; b=gZjzGoZATdQATgi+Afvv1liV5wuiRSAJwRMHDAjSby4i4331dlyd57o+Plpp6oMOhtZUtMxH4i1Xo9R0R0LwtIrDyZ6SmTbuImPkL7bt20kl5oWtFoW6WGEWrlLY521rQrE9v7hejvY2fYVINmFIm1VtuSXZP5FgiVRc2oXWtIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542372; c=relaxed/simple;
	bh=Pq9Aj2PpjMdyraoMOlDwZjHrqvrQlJ5+jJWqtZcvKo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uxor6rYC94g/2/t3intSSqWbMLgmky0DNP22PekuXCn6iosJHrf0/aNLqUb7iH+TP1K30He/lcjMFhYZu1gzz+jjkKR7DuSbu5rLbJ8yfP/PfOaYvPGcNGVhkfZMaV4fAND8OiNuSaBrf9Td2BVzdUk2pxODTlDrYSfWT/PZae8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4s0tY9C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4s0tY9C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3011F000E9;
	Mon, 20 Jul 2026 10:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784542362;
	bh=Wj6Eht4nV+LXDmswAnUY/xG6xO9bB65RpQzx+KrkowI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y4s0tY9Crx6M5T5mC3+8z/WeARVA0oist9bWt48uMysQ66Ws1dEgE3yolJgaQ9Sbq
	 RmkjbcpGmWDvDjZa/tHhS6khOjQdQxhBWsUwooXFZ+jTPD80e6KamdnWaHAnp6KtU5
	 9BlJ7tXkzrv1YCyl660lPPx8+QHqBJtF/AVs4RaYwYEe03/5tLuYnkQ8VvHCIhWloJ
	 4OPA6QINZn89K0Ja3UahbXPHsvubtXlrKyn3fokvhJ3XeRWLCnoy1JWF4DdcCAsiTe
	 pG3qfnYqd687CeBxGVOFuA4oGPbWUTmbMuUVXsrDTg3fIzIyFMt9qR34P0OYpH8Jvt
	 WoM6Lp/WAlsGg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 4/4] tracing/eprobe: Fix exact system name matching in eprobe_dyn_event_match()
Date: Mon, 20 Jul 2026 19:12:38 +0900
Message-ID: <178454235856.290363.14872590900774231133.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178454232006.290363.11301475407231432622.stgit@devnote2>
References: <178454232006.290363.11301475407231432622.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

eprobe_dyn_event_match() checks if the target event system in argv[0]
matches ep->event_system using strncmp(ep->event_system, argv[0], len).
However, if ep->event_system is longer than len (e.g. "eprobes" vs
"ep/event"), strncmp() still returns 0 because the first len characters
match.

Check that ep->event_system[len] is '\0' to ensure exact system name
matching.

Fixes: 7d5fda1c841f ("tracing: Fix event probe removal from dynamic events")
Cc: stable@vger.kernel.org
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_eprobe.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 50518b071414..bcd97cb24ac9 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -172,7 +172,8 @@ static bool eprobe_dyn_event_match(const char *system, const char *event,
 	if (!slash)
 		return false;
 
-	if (strncmp(ep->event_system, argv[0], slash - argv[0]))
+	if (strncmp(ep->event_system, argv[0], slash - argv[0]) ||
+	    ep->event_system[slash - argv[0]] != '\0')
 		return false;
 	if (strcmp(ep->event_name, slash + 1))
 		return false;

