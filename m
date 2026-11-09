Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184142;
	b=EAIAmyS4svqxO+cydsjNeopYVur6Yk3y8mXeyQ3AsIvbsW5dlHoc2g66j0btlaZYx/wU
	 HuEpKAZZ2yhvKLE8WEbypN6vKej7fz6V+VKVV2CdkrBEABFvoPc4CSZAxCZG67XK33/77
	 6kBOLtQJ5pvXBpIb0cfLO/VwRxYNeRz8aHQ9skPXJv6cOwRIR1CEUUFGNT2Guj4Yh9tEV
	 +Qc/WevGa4lO9GJtb4LlSRiDQrkLHX3WdNUC4DED4nb+X98Nw/XjSCrOLSeh9ARmnI4Bx
	 taeLQJaTTUM40bJCHb/WUE4PZUg6JCo4tAO6Uc3FljTKvaNIWSkoDQQ00+HNf+YTspg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184142;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=hrc31r43l/ddBqmzi23AaElB9YOcZwjk1KgJOeh5OAk=;
	b=TgsY2AgPHbcrcMKnAZKV6i75Zo7mYMLgqK3g/hnIVXqsB0drB7qVC8xy53TwS/Ejot2A
	 lh6yzBo+S8KqyLUO810npecbz+GhKJPjMomNPOSCV5roHxpDbnYe9rWQBel1Cc6UYRppq
	 GIYR1pcxDcoGzQhoWdO3fGUUUxH8SbzFc9MSaWISSJwfC7z0Y/i6Z1c6KBbRqL+XgFrpv
	 4oUzMZQWecNvaqGRQV4UGxSnyalhIS+YnDVQNiaWTXnfHsicBx/OoGp0pZtVB8h+tM+sH
	 ucs6UrFp8Wv+KxjOriw9lwCJZkrUzE43wjj+Dxq++n7+n1dDKiaZXMPCJxtgeF38fuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fvpz80nK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CC4606A31C;
	Mon,  9 Nov 2026 00:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fvpz80nK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6B21F008A6;
	Mon,  9 Nov 2026 00:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794184142;
	bh=hrc31r43l/ddBqmzi23AaElB9YOcZwjk1KgJOeh5OAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fvpz80nKFJTHnHiP913Fgw3MSNWFeoHmpV/n7e2V1c0vp2w0pXPLEV1Kd27nVflPg
	 GP7THopkS5R9S5NSe4fyEGvU3UEVz4GoW9cvfdRVHkZaqVfDph4A+H1RyPLRUXSDsi
	 5ibMZ1/yEKcEznYJovhYqsha4bl91tq93JUT7ovThWWz7Mhn6mfbG6nHCV2z6NkjEP
	 LnXgKIuCXkM4izUX4uX2d2I+byznqR5E/qSvQH2kPjLJhYID7Cth31yl6VUGX4Zk9u
	 22eqpxiCYkO4nuGPxAwN6Rtf9f4rwEpgQXL8jf8lrIaPga8JOxoHjr3kuUbIyZOHe0
	 j1dTPeWiHseAA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 06/12] tracing/eprobe: Disallow attaching eprobes to fprobe events
Date: Mon,  9 Nov 2026 09:28:58 +0900
Message-ID: <179418413870.227715.13320068204464144566.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179418408457.227715.1485179201014819821.stgit@devnote2>
References: <179418408457.227715.1485179201014819821.stgit@devnote2>
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

