Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794446857;
	b=ZeI/RHuHL0Xswf6wgETLPLbqsPAwOAP9ZdIQaUIVUn86K53NW+Uri0vz+ncXTbIs8WrY
	 m1w48SuXUgrmqV5baB2bSxdxRyOTOI0JVTIK9ODdbvxJwJ0So3+cPo6a9lX8NzHJT/tTR
	 a4q6XB/0wZqbPGvt92HAB1rEs2A0GHe8kfnNo24xUv4g4k19fWI7y/rhnQFSrU3BlCoO1
	 zlBJy9ueYueLTzTjrogYPUWx7yLd6c1shConnjyaoQzm3vA+lWGW94nbBEIa6WBxl5avL
	 8dHKE0rDnoODG9akypIxrHx76sR4dNpYIcQ82de92/FTacEhyLTk68zXcZReKJaH56Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794446857;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=hrc31r43l/ddBqmzi23AaElB9YOcZwjk1KgJOeh5OAk=;
	b=P/2OjEhgI1ILi3ACdPJyROIzMTeBwJHpbUMn4dmLwkZfFBa8dWbi+qhEQK1dZAnKDg/u
	 YUfjEe2SN0tWJuLELFVXGFo6xLO/G0HGw+QoqGp39j1c2bOzU/Z1poTp3EPns8cHtA5Et
	 DtOa+gtKL+SDMrO6CqD0xDkqwaY5WRe7Shr4i6Ba7dCx/cxRYUyWHeeX5ZiKudzhn3STr
	 c2xvoMFdPOZQbaAb6UzhgkR8JR/3g63NNbjIXmLZTSMEkyOIqgV75naN7RyUUk+M4JF5h
	 RJCzhUdzgWoh1YyCL77w0X2CxLKtybC7kx9MPB7Q4Xv/Z8Z0nbl+Xetr82rZKHsGALQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cRsuFmqC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1359D606A31C;
	Thu, 12 Nov 2026 01:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cRsuFmqC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DB91F00A05;
	Thu, 12 Nov 2026 01:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794446856;
	bh=hrc31r43l/ddBqmzi23AaElB9YOcZwjk1KgJOeh5OAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cRsuFmqCMz695Um+x9D+bp/xqrW7MiW7zpxVTpIJhQgOyFO3O35M59H3n3p+NHAkd
	 O8RffNHR1Em6Pf0b6vBU2iWhRNqjWX2qJMz81iQjm4+iAerYsuhZAI0BHhIFKTT0Hh
	 QpPRGXNVa5EznC986EKxYVPYYJQv8d42H0QEUgo/2GE07gmSIlMTIx9b8BGHyXNLQN
	 uSmZ9UT7qDpC5/mRXOnFBgjxb/eqHfCnwtOMPbhnJNJ1qIHXazozI4g2wfbPe2inaX
	 H6wIGeGqBnIsBU8kUIg3yLlEJ3qXQse8A+t5WqZWbtYJ7or0aisB7L1owvmXa+0xWs
	 nRf505XpmQBAw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 06/13] tracing/eprobe: Disallow attaching eprobes to fprobe events
Date: Thu, 12 Nov 2026 10:27:33 +0900
Message-ID: <179444685330.345731.15745036038049281337.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179444679892.345731.5271591537517106679.stgit@devnote2>
References: <179444679892.345731.5271591537517106679.stgit@devnote2>
User-Agent: StGit/0.19
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Event probes (eprobes) are not allowed to attach to other dynamic probe
events (kprobes, uprobes, and eprobes) to avoid recursive probe chains
and lifecycle dependencies. However, when fprobe events were introduced,
TRACE_EVENT_FL_FPROBE was omitted from the exclusion mask in
find_and_get_event(), allowing eprobes to attach to fprobe and tprobe
events.

Exclude TRACE_EVENT_FL_FPROBE events in find_and_get_event().

Fixes: 334e5519c375 ("tracing/probes: Add fprobe events for tracing function entry and exit.")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_eprobe.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 9defe86f4e8f..f65393fb1c10 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -762,7 +762,8 @@ find_and_get_event(const char *system, const char *event_name)
 		    (TRACE_EVENT_FL_IGNORE_ENABLE |
 		     TRACE_EVENT_FL_KPROBE |
 		     TRACE_EVENT_FL_UPROBE |
-		     TRACE_EVENT_FL_EPROBE))
+		     TRACE_EVENT_FL_EPROBE |
+		     TRACE_EVENT_FL_FPROBE))
 			continue;
 		if (!tp_event->class->system ||
 		    strcmp(system, tp_event->class->system))

