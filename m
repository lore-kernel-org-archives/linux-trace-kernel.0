Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F066218E9B;
	Thu,  9 Jan 2025 14:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736432983; cv=none; b=GOj0+CFWg4ts0szsxn9alAWq+m51Qt6/FuJhwpz+99hp0LF9cJGhYsu89525h8/8BpUY57PB0DXICsf+sjRsWXdMI61CTXmhG9suWbRHHg+f8Xf6yzvHTxojLLK2xl3xFuIZif0irI/tXbMSFQqBtAl0q7Diy6XHBZ6cwNzyA2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736432983; c=relaxed/simple;
	bh=UGqyRego3CSkhxGP6XCMC0PE3sQ0pcJJxh8ZAmU14NI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IZoVsBof+HfDAeEKzcCtksKFZJzcMt3JX5f2GCZBb/kzcNUWhJrHj4aSwDG+Gx05j2VAeq0dGzAQaWN+oTXFnLWMnBxXdnzO5Pbu5CiNwUzqTyf9f1PE6M9+NBOlQqC+r921Hapm9Xu6i1SG9VlGwz2bby+LMAsFBvu2hV6kT/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sx+4tr25; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sx+4tr25"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CC0C4CED3;
	Thu,  9 Jan 2025 14:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736432983;
	bh=UGqyRego3CSkhxGP6XCMC0PE3sQ0pcJJxh8ZAmU14NI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sx+4tr25kkdC4zD6l2mFbJh/DzuzZtajm1I2aVB3myJ//4AQ3jihFO4cXcKAI/6gY
	 QvbQTo/q+IdV/p/KNwUrdqUauF17+QgwfjziV5WzJbUJywp88JC4fAr0Yv7VAJvKMB
	 LEwVOknksKSgr1rAtMWa3VFlvSjyrDQbR3KOpBhCxemKHh/xjWZgaLfE618LH/iErW
	 9QGJzZnxbDXmaZcgO+C22cO5z+Ms1bAq9ERKM1lf0LAf62XliyLtD36oIlSxz17Eso
	 PVy68XC2NEoVCBKtcFtZ02ME+1J/dVLSY2WaGOWS2+C2YgB6NaiF6SAKQP1rRgxM0D
	 XwR7j4bNlzcUw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v6 1/5] tracing/kprobes: Fix to free objects when failed to copy a symbol
Date: Thu,  9 Jan 2025 23:29:37 +0900
Message-ID: <173643297743.1514810.2408159540454241947.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173643296599.1514810.1580554610685712071.stgit@devnote2>
References: <173643296599.1514810.1580554610685712071.stgit@devnote2>
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

In __trace_kprobe_create(), if something fails it must goto error block
to free objects. But when strdup() a symbol, it returns without that.
Fix it to goto the error block to free objects correctly.

Fixes: 6212dd29683e ("tracing/kprobes: Use dyn_event framework for kprobe events")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_kprobe.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 263fac44d3ca..fb9d4dffa66e 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -940,8 +940,10 @@ static int __trace_kprobe_create(int argc, const char *argv[])
 		}
 		/* a symbol specified */
 		symbol = kstrdup(argv[1], GFP_KERNEL);
-		if (!symbol)
-			return -ENOMEM;
+		if (!symbol) {
+			ret = -ENOMEM;
+			goto error;
+		}
 
 		tmp = strchr(symbol, '%');
 		if (tmp) {

