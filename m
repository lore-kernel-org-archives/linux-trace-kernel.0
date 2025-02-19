Received: from smtp.smtpout.orange.fr (smtp-71.smtpout.orange.fr [80.12.242.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35F61F5859;
	Wed, 19 Feb 2025 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739980396; cv=none; b=Gr9p0JNU74ag1C29PWbNdV11vkAbOLautLx+f0lCl0kE4rwe6kzB9USgwy7Eye3Y5TDpRxB8YDJU9xEsqqpcxf3dgCpNn0e2UipWu2zsN8zhMwTiIQ+ir/uU8OtU6DhKXbG/E+Z2stOVHML9+PhZ7IMRehSuTWOdmipWDdTsHqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739980396; c=relaxed/simple;
	bh=Xa8cLWNo6MQoPtkyy2sS//G8kPvIovPGhvQYZ/Tdrjc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YB95qG6WnOUu3UoRn9f+aB6+Ui7V4M/PDHDl2+wPlfeqvbzICCFd7elVxLc0/doUI8AQcMobUqR9nM+qjc9evpAdyVBYjLZGOTZrYmIOvkVMw70P4GDfpK7rdJDtiklMkBRcQdgxlORuoghfzwDBWToF9t0blHMxJ6l/T+k57hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Cf9NEfrj; arc=none smtp.client-ip=80.12.242.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Cf9NEfrj"
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id kmEZtrRX34oeSkmEcthrp6; Wed, 19 Feb 2025 16:43:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1739979823;
	bh=XQ8xneqsJR4U2f2+Cb3h0f/Qqrrbkj3alXoGimUGJEU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Cf9NEfrjidve30jAN28I9mNsYgvDLIUTGNXoGbr0ILVHdxkoBii8SbKqntJAYgzKT
	 yAa0A0YxmjIlZZOUKjUwFM65yd/COOO/OOnhiw+jVE4axlOvhLYw7vfhq4yTtNJrrN
	 IivLFFlH59CQ8uoWoO6QIkWI6D8opciBZdtChjjUuJCcwDspCuWnCXDW4FgUwiPhd+
	 Mmji+Bg6jAljVM96gMjAK3WMsDKuz1lBrRpTM7AQwcgs7eTe9SgiUSIueHPpPt77Y0
	 BkNPXoc3pO3Q+EbXqDext+T9sf1CWLOUve9oeOElK4Lo47tymFNYiwZWW6fSyr92nT
	 fa4BHqMrWsYHw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 19 Feb 2025 16:43:43 +0100
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing/user_events: Slightly simplify user_seq_show()
Date: Wed, 19 Feb 2025 16:43:33 +0100
Message-ID: <845caa94b74cea8d72c158bf1994fe250beee28c.1739979791.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

2 seq_puts() calls can be merged.

It saves a few lines of code and a few cycles, should it matter.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This is a left over from commit 7235759084a4 ("tracing/user_events: Use
remote writes for event enablement")
---
 kernel/trace/trace_events_user.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 97325fbd6283..bf2b5311d947 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -2793,11 +2793,8 @@ static int user_seq_show(struct seq_file *m, void *p)
 
 		seq_printf(m, "%s", EVENT_TP_NAME(user));
 
-		if (status != 0)
-			seq_puts(m, " #");
-
 		if (status != 0) {
-			seq_puts(m, " Used by");
+			seq_puts(m, " # Used by");
 			if (status & EVENT_STATUS_FTRACE)
 				seq_puts(m, " ftrace");
 			if (status & EVENT_STATUS_PERF)
-- 
2.48.1

