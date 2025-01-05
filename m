Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AF736C;
	Sun,  5 Jan 2025 12:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736081293; cv=none; b=cIzHhYx0iPclIz7Fk2F9xEPO9qmpYqjaoXdQYbKbuhztzG6VbAJVrmVjy5Mhh7mg4XzUYuBUdRPWc/PQODS0pDay9tg++lygTdLtheIZf8soTK1jpM1332q49kPa5J/JPagbpe6JKaCdL6hkGva6TGpNWiadchtg9zuQOn8YKFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736081293; c=relaxed/simple;
	bh=+pxLLLe29dzlgSbN6WDsHwCIQvOgeEupwWyEX6Or1L4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wa3C/2yW+JAKambfCSRyrLzukfKY+imVrJxjO6SAoz2evgY5cDnQWaL0glIyi7aXhnYFHbUoMeTVyH0WBVdXhVlN1yS+NXahWm8610wIeaXrKJbYNRca96jhDJbnJ3lfgLcNirWB3smOuuHZlbQXGiBftoP/3Gq4dzPTRKroVPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKnVP1rW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKnVP1rW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64A4C4CED0;
	Sun,  5 Jan 2025 12:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736081293;
	bh=+pxLLLe29dzlgSbN6WDsHwCIQvOgeEupwWyEX6Or1L4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uKnVP1rWgV8GRmTLHV+ayljgggD7L77b+U5IoOTlyZ1PiGmOAOiXW4KyHGZr/EKtt
	 WfVwXhmKCLuigI5PwHvwRLYoCZB68FhHf+2XrWoug3lWTaU7Nb5M2o6Rcr19K/WZH6
	 9G2F+7dnnindL7voIt3MJSgfyFNJb6xFBtXs9ZEsV9s4z0KIZ5glbMHbNQhqxDEdWt
	 Gundn53DLvJAsZX/ZYHQOcUytUk9/bvjIFqd8lJNJqgJNrJ9CVwIp67PcZA1+z6GMM
	 YHk3TV5NGvUSli32DhfYZNGcDZkt0MWfNQq/DXQIB34jSkoaI2Pep4KfDACAFxU8Lv
	 wna+QB84jT0Bw==
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
Subject: [PATCH v2 3/6] tracing: Use __free() for argv in dynevent
Date: Sun,  5 Jan 2025 21:48:07 +0900
Message-ID: <173608128743.1253657.14202571481200245375.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173608125422.1253657.3732758016133408588.stgit@devnote2>
References: <173608125422.1253657.3732758016133408588.stgit@devnote2>
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

Use __free() for the args allocated by argv_split() in dynevent.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v2:
  - Rebased on probes/for-next, which reverts previous dynevent guard patch.
---
 kernel/trace/trace_dynevent.c |   23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index 4376887e0d8a..630d9695b2df 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -74,24 +74,20 @@ int dyn_event_release(const char *raw_command, struct dyn_event_operations *type
 	struct dyn_event *pos, *n;
 	char *system = NULL, *event, *p;
 	int argc, ret = -ENOENT;
-	char **argv;
+	char **argv __free(argv) = NULL;
 
 	argv = argv_split(GFP_KERNEL, raw_command, &argc);
 	if (!argv)
 		return -ENOMEM;
 
 	if (argv[0][0] == '-') {
-		if (argv[0][1] != ':') {
-			ret = -EINVAL;
-			goto out;
-		}
+		if (argv[0][1] != ':')
+			return -EINVAL;
 		event = &argv[0][2];
 	} else {
 		event = strchr(argv[0], ':');
-		if (!event) {
-			ret = -EINVAL;
-			goto out;
-		}
+		if (!event)
+			return -EINVAL;
 		event++;
 	}
 
@@ -101,10 +97,8 @@ int dyn_event_release(const char *raw_command, struct dyn_event_operations *type
 		event = p + 1;
 		*p = '\0';
 	}
-	if (!system && event[0] == '\0') {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (!system && event[0] == '\0')
+		return -EINVAL;
 
 	mutex_lock(&event_mutex);
 	for_each_dyn_event_safe(pos, n) {
@@ -120,8 +114,7 @@ int dyn_event_release(const char *raw_command, struct dyn_event_operations *type
 	}
 	tracing_reset_all_online_cpus();
 	mutex_unlock(&event_mutex);
-out:
-	argv_free(argv);
+
 	return ret;
 }
 

