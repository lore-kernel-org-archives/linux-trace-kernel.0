Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3548C1D9346;
	Tue,  7 Jan 2025 11:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736250620; cv=none; b=UBZ6n2HYjRtkZBhI/H2vvh/lwXf1Y+BAHKKVvGHigOiU8tNQUglo4g/21th5IBUIEttYOOf8YiEfrMpct1LnEvIpBAPP/i7HkbHSawX/jUWJKHCyAyN4CdCwxSPXynr9nlPfbReHjlgHAbkU5t6fWUHbaG+tyKyM7V8+dtQNBDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736250620; c=relaxed/simple;
	bh=6QyVNa11BsehG9ROF+5/Jw9ETQ4uZvxVJBFzAmC3XNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CcS2FUiwourPoBpuWajt/4WRAW+Pc+pruqY2xVy+1wb53GJK+jce13urke0m/6cqTQr3ZxLB18P9mDIi1ObvaVTr9+0SNp6QYdko0mam0vQX8y/cKHe8x9LuwL+hJW6iNNbPH9cmq9h92q6UVJd2oUcfftFYc9YsLUtGjgICXo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNjH1AOM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNjH1AOM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75EBC4CED6;
	Tue,  7 Jan 2025 11:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736250619;
	bh=6QyVNa11BsehG9ROF+5/Jw9ETQ4uZvxVJBFzAmC3XNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jNjH1AOMNRChGUkPn6vZgXsglPcBbaRi9w78CRZ0yVS3AmumOrg+bW/62tx9SjWvu
	 bEZ44UARWY8d4JAZMPmeL3JeKfTaNxZByXmcsHp6tfbJaOdfnnpV7y5y2iDbIxpT9L
	 4kv6qHbWnqjJnOaVRUzMso6zsqJeLRT3mkcpz1OdIz7fLahIqchh3lfIKuo3kfEt1S
	 sDkgMaqJ0Rn5AsWnH841qoV4z0o6sEcHKi2GcrtFbMJTCCEflx6TQWJWw+EYLrYW+B
	 CKM1NgvRp+PToCBWf+9UEGz+5Nklw1gDrvyQM5m5UquhxFWD1+DfBLkWc4tayhnDE9
	 OrTy0dCdo3EdA==
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
Subject: [PATCH v3 1/5] tracing/kprobes: Fix to free objects when failed to copy a symbol
Date: Tue,  7 Jan 2025 20:50:14 +0900
Message-ID: <173625061422.1375434.3546795892167224013.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <173625060316.1375434.11048027439794595989.stgit@devnote2>
References: <173625060316.1375434.11048027439794595989.stgit@devnote2>
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

