Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794558565;
	b=PVB37hIosWpxe8WrEYA69cQtI2Onqk/Piz3A8VtIel+AqQ9kmOFrWBCX7Lb83hkQrsuw
	 fh9K8yGT+6nPU4/9aJ0qHtkS/rDDkbRB62UI8VwukY1DOLZrZ0tBGs/knDbes+ZFqHWHQ
	 UM6VfXkYVvPQy0MWcyyUqngMH8GBJEgB77tXz6bHelM5LBOqSYUKUfsE7amI5jreApAs4
	 6mGtbu1LsukQ8itB3IyCU1efft5KPn3joz0y99oRS/Fc6vEkdDPEvvbQgFunzwxfeUVAt
	 NlCh58+WamLXI5raHiKo3iWAjfS5gVSI37K6ccwtCcSswmcKk02FvIGDFDcjuBGKsGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794558565;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=z9GgusmlU10VYCUu7LsiHTqFJ2RVaMIYAS6xl76o+Fs=;
	b=n1qH0K8sRiYut5I/tClmO/TGf7kL0wZ6tjGhEQ1VVM5OZfAIQMuQjks39GoFgkDyHAoI
	 iFiaAreZdTwIJ+AiosxV2hIooRShN0wrWiVlYVfkErH31ed0/4XfunR9gmOKI/EPhfqGV
	 SLcMHhsa9Zj1G0Wp/pcXgHQCALro5xJ8WApsimp8IGD8cNIg+DOSw8XklDX4aEbXKk2Cn
	 8xMB5wZTWIgXgcXYtlE2TXQE3zrJtaIC+rsQzKl5kBGCL8acuIbl4tHyfu1bYLa5/Ycjl
	 C+89xwKZOi0NU0v2ck05soMrg8LuV5RtnOs3oZKctTGHFLYkHOaazIP15sKmJl/ntWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ldk2xgmN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEDC606A336;
	Fri, 13 Nov 2026 08:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ldk2xgmN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD291F000C4;
	Fri, 13 Nov 2026 08:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794558565;
	bh=z9GgusmlU10VYCUu7LsiHTqFJ2RVaMIYAS6xl76o+Fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ldk2xgmNPuKDedpR6xYqbG2GkjPDRMYHr711MU1DsI07N9xNpLyf1x5UeANg6mjgy
	 bL8Y1V6BjK88A0MJfANsD6IqbeQF1x0XkKKGRzGoxEiOXZVkXPNbkA7Gpgg1jeDm28
	 P1IWX/dsU2LiEiPvRnpTDqddjImK0C/ylCV3RVC1u+1WerOCmOV+USAZh7lBQUfXur
	 ujyq89v7j0iYraVM69oWsdo4ignD0gg4Q8zeO3tP6KDcQ0zC5uoVjmIMn0XIAWOmcq
	 WPB0c+qYCotOtfQd0PHIQR/m8yHV/8TW1ELFZXeu1xJl6LSvaz+S0JyZ/jfjIn2Nw5
	 agE9T3kLdPxoA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 09/13] tracing/uprobes: Fix memory leak of tail in __trace_uprobe_create()
Date: Fri, 13 Nov 2026 17:29:22 +0900
Message-ID: <179455856197.403392.16569431894958507645.stgit@devnote2>
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

When generating a default event name in __trace_uprobe_create(), tail is
allocated with kstrdup() without __free(kfree). If the subsequent
kmalloc() for buf fails, the function returns -ENOMEM immediately and
leaks tail.

Declare tail with __free(kfree) so it is automatically freed on all
exit paths.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-204240@kernel.org/
Fixes: 97e8230f89a3 ("tracing: uprobe-event: Allocate string buffers from heap")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v2:
 - Newly added.
---
 kernel/trace/trace_uprobe.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 14ac52aebe34..fb7991543db7 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -701,7 +701,7 @@ static int __trace_uprobe_create(int argc, const char **argv)
 	}
 
 	if (!event) {
-		char *tail;
+		char *tail __free(kfree) = NULL;
 		char *ptr;
 
 		tail = kstrdup(kbasename(filename), GFP_KERNEL);
@@ -717,7 +717,6 @@ static int __trace_uprobe_create(int argc, const char **argv)
 			return -ENOMEM;
 		snprintf(buf, MAX_EVENT_NAME_LEN, "%c_%s_0x%lx", 'p', tail, offset);
 		event = buf;
-		kfree(tail);
 	}
 
 	argc -= 2;

