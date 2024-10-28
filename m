Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB0A1917FA;
	Mon, 28 Oct 2024 07:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730099539; cv=none; b=A2cRM8vj79OYa9HllePPZy/Rc1PXVgwHiFkly9jEVa1dxCLB/jf52sygnDj6qIyOBImjJ6wuJgWCwS/AQf6VRG8bd5crL7Db9+3IxwglYUOWamXpao3lnCdJijxn+BmW3bW/REhv5T6EOJtH3GF2dOxWuSH2dqB+duokO7iUgPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730099539; c=relaxed/simple;
	bh=lCXGtBtcvfnsJggzf5kZ3rR7Y+fds+4jXs55q+WtBm4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=JQnA9WREADszwA/xU7kq9J3Mayoyk5dggunBMdPGjDSdghb76IORBLsJLOfGPyKf3S/jjatmy9Pe8Y+4nLkhescAxkDF+QpdORHU524E8xgDZBtGC9di3hI42LUiL3c91wQJgHmi5kBj4zGscXE8FUfObqkGSoi4WJWh0KfKUDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80458C4CEC3;
	Mon, 28 Oct 2024 07:12:19 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t5Jw4-000000053EW-1bzP;
	Mon, 28 Oct 2024 03:13:08 -0400
Message-ID: <20241028071308.250787901@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 28 Oct 2024 03:12:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 4/5] ftrace: Use guard to take the ftrace_lock in release_probe()
References: <20241028071228.575900713@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The ftrace_lock is held throughout the entire release_probe() function.
Use guard to simplify any exit paths.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 64997416415e..c0fabd7da5b2 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5288,7 +5288,7 @@ static void release_probe(struct ftrace_func_probe *probe)
 {
 	struct ftrace_probe_ops *probe_ops;
 
-	mutex_lock(&ftrace_lock);
+	guard(mutex)(&ftrace_lock);
 
 	WARN_ON(probe->ref <= 0);
 
@@ -5306,7 +5306,6 @@ static void release_probe(struct ftrace_func_probe *probe)
 		list_del(&probe->list);
 		kfree(probe);
 	}
-	mutex_unlock(&ftrace_lock);
 }
 
 static void acquire_probe_locked(struct ftrace_func_probe *probe)
-- 
2.45.2


