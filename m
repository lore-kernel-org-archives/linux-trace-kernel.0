Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E52252905;
	Thu, 17 Apr 2025 15:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744902475; cv=none; b=A6N4lCQpB1h+qrhzmuHU/1Sh3h4RtnAEgSujvpKu1LE7rQ2Qx0qoajt3UVdlkcw2Y6XjKq2P36aPaVQte/DZ8QJqqnk/QSCYH10vFCxXoonrHk826GJbzVSb8FHF7eJl6+S6rfE2HzFIdNa/w8wSDfdq+UqGt8ULmlkZ6c4BHlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744902475; c=relaxed/simple;
	bh=l2G9SIlOjiYGdNKHPZBjPNDB9Y6expiTEh9Ez2pi1XU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=tJWqLvxBrZ9NXyDoo4zyBqCiMW5nmR5BD4WldKs0rfKdH0sH4A+fN47FmkQmATCJFiwySAxFFfh7GTUEytPLWnS26zz577JMCPPl3+WzkwJZXLUi+fWPJUp0aHd6nl4t9uiAI87UUmRgidCGNIsxslWStP6GOfklsSxdb3Z/h9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8198C4CEE4;
	Thu, 17 Apr 2025 15:07:54 +0000 (UTC)
Date: Thu, 17 Apr 2025 11:09:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] ftrace: Reinitialize hash to EMPTY_HASH after freeing
Message-ID: <20250417110933.20ab718b@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

There's several locations that free a ftrace hash pointer but may be
referenced again. Reset them to EMPTY_HASH so that a u-a-f bug doesn't
happen.

Fixes: 0ae6b8ce200d ("ftrace: Fix accounting of subop hashes")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 66bf4512ec04..39ccbb3b9693 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1297,6 +1297,8 @@ void ftrace_free_filter(struct ftrace_ops *ops)
 		return;
 	free_ftrace_hash(ops->func_hash->filter_hash);
 	free_ftrace_hash(ops->func_hash->notrace_hash);
+	ops->func_hash->filter_hash = EMPTY_HASH;
+	ops->func_hash->notrace_hash = EMPTY_HASH;
 }
 EXPORT_SYMBOL_GPL(ftrace_free_filter);
 
@@ -3443,6 +3445,7 @@ static int add_next_hash(struct ftrace_hash **filter_hash, struct ftrace_hash **
 				  size_bits);
 		if (ret < 0) {
 			free_ftrace_hash(*filter_hash);
+			*filter_hash = EMPTY_HASH;
 			return ret;
 		}
 	}
@@ -3472,6 +3475,7 @@ static int add_next_hash(struct ftrace_hash **filter_hash, struct ftrace_hash **
 				     subops_hash->notrace_hash);
 		if (ret < 0) {
 			free_ftrace_hash(*notrace_hash);
+			*notrace_hash = EMPTY_HASH;
 			return ret;
 		}
 	}
-- 
2.47.2

