Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794558539;
	b=T4JMI1YMN5ZULoYiNPv+7Ghq763YbvpU0A3Quf02NVZzdwtCfOOmejWnmxiefT+2zrpu
	 dorkzCpY2fQq6onCcVeIsQO1yTxdfgQ6bY3lqgO4C2d/sjugNIAiDY/DyqZFkybdKVG1s
	 itvK9l3nBbGESS0Mv+J5HV3Ljo7IWOQ8guLkpdTZ61KSSVzeneXywJAPgRC44NIuE3OfH
	 z6KI3wav9GxcCEu8Df4VNkAyATX0YuJZ8+qMyXXZkNNo2uzezS2vZe52MwSAj6uKSjQNx
	 iUgsBWyQCJMv0DDP2PyPVpjCXTcjSvaVP0OuIpc+p8zvyT97YJW2TsbVJyo9O2Kyz1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794558539;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=hrc31r43l/ddBqmzi23AaElB9YOcZwjk1KgJOeh5OAk=;
	b=paovYbUOBTCrDvK2jZgQvnf2Qoe6Egx9GnEb8GFo6a6xHzmMhV7L6CdWuPAH7VUoblNK
	 pUKDXf6twIJo+siMMzMl1tdRo8qehzHHz3r0QD+o09EwTYRvTofr6LXThZRsyCzmlMZmy
	 YSHLBPw8N6ZTlLRqN03dSh5LQxwJeE304xS6GAE6e99zO54amirQ5LTcdYeuf0uFN0Smr
	 lhcLdQi4cev2A88ty9oIXMmGTEtYeWNahd8UE6lhTIgx13M/6xWd5W/s9k3ECUGRSZ7bh
	 z9ULXXK518+USaLmbE4TF5M6x3eIn0VmGqWBvVi4YI7lEsnNS1rvQhHGjmfK4F1+1hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R+H0u2zp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3F1606A881;
	Fri, 13 Nov 2026 08:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R+H0u2zp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358821F000C4;
	Fri, 13 Nov 2026 08:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794558538;
	bh=hrc31r43l/ddBqmzi23AaElB9YOcZwjk1KgJOeh5OAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R+H0u2zpKFyWDkJw290YVZP4EQNJcdWfBoo+idV954Rtf6fjCXrVvq5TLTgYWGH0F
	 AEsj9giKqH1H2Q7Iy2izQtWySW8kCixINCpayV0omsXVItoln/8K63ivbtDyg8rnCx
	 VSFLl774ByooUkCAfjUZuDjmXUmjKWu1jaw8p/4WoLWpiBv3p0l1lcKyeVPUz558LI
	 Zh0LA2tD1Fq3tE3P9S8edb3EAJ+4IoX8hxq/Qy/Ebnw+qA2nOGjWCRJDkyogN3KgnZ
	 pvs+jtbCqGglgQbyzTHggg3TtD8hc9RUfJMgRGDsoE8t5Be0+xm7ZfK5vBQwmWC/v7
	 FirWUehxrZYpA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 06/13] tracing/eprobe: Disallow attaching eprobes to fprobe events
Date: Fri, 13 Nov 2026 17:28:54 +0900
Message-ID: <179455853457.403392.14549390017750529531.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179455847934.403392.15146485751358774349.stgit@devnote2>
References: <179455847934.403392.15146485751358774349.stgit@devnote2>
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

