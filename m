Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF98146A7A;
	Mon,  6 Jan 2025 16:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736179392; cv=none; b=gAniU8ATM+g3XlNlF7V9ypruRhHk+XOHe76s4ASccjE7du42eRKghxB3SC67TQKV+45hWOXRZkR9nMdTrD4m0j+6+Z/BQW6ZpIHqi7uHtADrEEYtwHhoNO0VZ2sKgQ470vLL3tHNG5X9CfBn1f4Hc0gfRqLQ4TzUb/WyX7p+7WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736179392; c=relaxed/simple;
	bh=SUhZ7GEHZtJZaDdirrowKcn0d6YjA73MGwSKIo7qoU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=st6+0Q/rWEDLtzbV4NzTcAsA85kaAwSD4ttuhhgcvaVe9/BVV4DuWaXosOKU3Ny5hqZppe85Tj7u0YTsFy0qUYFmYyyoSzksKwAviy3ejmpoaU9qiGI8E1U2ntWjfV3FePQj0EK2tnB+u2AMA0dfSFP8tHBZvA6jbrZ+8Bsm6rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i53hYmes; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i53hYmes"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6411C4CED2;
	Mon,  6 Jan 2025 16:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736179391;
	bh=SUhZ7GEHZtJZaDdirrowKcn0d6YjA73MGwSKIo7qoU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i53hYmesxM5h79rgVgiNHVXOnK3CldP2s9gq3IuZ337leCi65pIcTtwZgiYbqFqtx
	 UyimxR+HsjF5pmohA02mQ1AcCMctmc1KvvInlcsL7dN4Ui1SkDF2KxGdMnBfL0NbSp
	 eoM3gteoDhsyqVcUrx5KZ8kTWHQ+nbWSZcUY2nh5Ao/7hoCL2v7PZqdLBdctw3zE1E
	 vE2X6c0aBiMVXt72KI1h4wY3Roi3ZnwfsP7wyE40sPyjvdiK8hBirQ+hrPpiEbN0Hy
	 EpJO75GlHe8XMrftNk5JAd/myhcM4eqFJ7GdgGsEt+yEH3WiNtkZ9F6Bf/qslL8ac9
	 EYOFGsUzC96Mg==
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
Subject: [PATCH v2 1/7] tracing/kprobes: Fix to free objects when failed to copy a symbol
Date: Tue,  7 Jan 2025 01:03:05 +0900
Message-ID: <173617938514.1366315.1168667357486645838.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173617937395.1366315.17590944219163017504.stgit@devnote2>
References: <173617937395.1366315.17590944219163017504.stgit@devnote2>
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
---
 kernel/trace/trace_kprobe.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index bae26eb14449..4c3e316454a0 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -935,8 +935,10 @@ static int __trace_kprobe_create(int argc, const char *argv[])
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

