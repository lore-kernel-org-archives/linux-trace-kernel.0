Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794446884;
	b=4YSn5hJc2YFQQZvL1086YLNZwI56eRIpIQS18cUhybmxfXSFbVVTLTG0aglBdOwRmqFd
	 Ae2GSiP1oQs5j68YrzSjOsqCvBhWhQZioZjqzQ9gRqaeEeoazW3/qHt4vHoMcFkYI+tbM
	 4hZzJ0VLaoyG180nHnjKe7rKE1kgpHlyVl/rU21m/vvpaLc10HX5BEjq8c/6g+Cy1mPgk
	 zH9F2ZnxGKq29qwyjtoPlKnz6j7jrzChnXKnXjLKLt7H/s9qe/ZemI7fNFHaTw/hMkDnf
	 s0d/K/1zAIQMhQsqDJfuN+7wl+XgcXYzXLgT1Et1whDerJaP/xRiUixGIt2GgaF8AHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794446884;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=z9GgusmlU10VYCUu7LsiHTqFJ2RVaMIYAS6xl76o+Fs=;
	b=LXbK1sxfH7tS8FBz6ndQHtInI7nvO5oJsrogcNRko2NQGb8Q6/5PFiSTGQehfeJ1uM1A
	 i3s5JF1oJ6ECcY5T+7pmijDoZriBS9AspYSHvmuaw5yk5YlduaCcInFaOy3HmS/BWU9rx
	 KOSIcom8HYDjZF94yas1H5RbETQA2HSgRpHjrWU2vf+lt0DeKbLwlh2SLTPcge+IBLVCK
	 16ZxuG3gKjA2aS0vzMwpZeTzjHD0qWXwqzWgI8ZMSKvpSq3I6PdOBOyAQe4XB4ZZx1oY+
	 5glQqGIXDHsrA9IDPrZONOEPxWQMrCDkd2Gr/cSk8Dw9+li/HhiC1VnbZ8XmdKXfxUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VtbnvNxS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4615606A321;
	Thu, 12 Nov 2026 01:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VtbnvNxS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24911F00A06;
	Thu, 12 Nov 2026 01:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794446884;
	bh=z9GgusmlU10VYCUu7LsiHTqFJ2RVaMIYAS6xl76o+Fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VtbnvNxS4Gn/l32oMwCwscqL/809xVZdXvvzVEepX6u13cOO2tNoeOUaLopeUP/I/
	 R9PVH3Rj4u3nAKASM9DV5n5Hoe8SeAotJmcuvrtmmc0hhi8r78Rg/bnyFnnsCaDMN7
	 6iN1H3b2vK7fyOTg+mb26LpAVqJaKuMvB9gnRzFRpsOTMNLFfZ/I0H6H9JY6KUtnIv
	 h8HPI0DARDRBoDsMOxQIu2xamGq8wRwy4qKAIenogZxQvizBzTEX0regrE5Cz7L+PA
	 dhS+9zpMHCMHCTqt1y7Aj0hspFiS0R/hDhvD5geU997s9Ptru+AEFFPJhiqXnqM+kw
	 4ozH+08y8HJyA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 09/13] tracing/uprobes: Fix memory leak of tail in __trace_uprobe_create()
Date: Thu, 12 Nov 2026 10:28:00 +0900
Message-ID: <179444688044.345731.12892767299503363577.stgit@devnote2>
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

