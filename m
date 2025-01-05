Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BDC1369BB;
	Sun,  5 Jan 2025 12:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736081271; cv=none; b=c4nJSydfNekk0Z+XI9W0HcjXcD/GD/hkR0QRBHxKKDaGCydMMpw8iE1gMS64Ot+L8lA09Krq86nOC+DM9cLXX27az9tIbhyTa5BwU06/et+4NPlZ9A6djHFiLuowNv4gVSImy2Cbjj7c/CU1evM9QvEMIGVguMs6IDuzY0KDlXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736081271; c=relaxed/simple;
	bh=SUhZ7GEHZtJZaDdirrowKcn0d6YjA73MGwSKIo7qoU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gt7DcaNYlm6WwcQey080r8DNYW8WCtGlvSYzrm4DtwoqPuli4Ajn/g6dMl4YpHrdgkaX7UFhYP5nnIm+cycAEz7FMOiaLvZ1iKHcyI4dt9VjSI6nQX8l54d/FNerPqn8iiX/xqSYfBvyU3dyFKUKiXlvke1e0jY82zdGatF47P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ijc/UoKP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ijc/UoKP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A360BC4CED0;
	Sun,  5 Jan 2025 12:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736081270;
	bh=SUhZ7GEHZtJZaDdirrowKcn0d6YjA73MGwSKIo7qoU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ijc/UoKPIQd6vzvLxb1a5qXjwaNqvV/JLAsZ/svhfgISqlSxVLkfD39CH4RfS9T2K
	 IHmX5/tUhWC49hzPzPvE18lr0UO+p1LwEcXnZFnlfdIa2KCCSejEpimv2puKXoNURt
	 BDR6n7P0D0rcIYT7JLAXguargpVDsR2YFCcjoQh9M9LJTB2YWm/hDTcweJylRYi52P
	 LRSLMsolO8gARTogF9+dzOhwoM8WFqEC9nJv6Y45hG53+i95be1TmFUTmrAsu266rS
	 VPvou5ie+C64xpWen9bUFjUgZ8fiqSgLexAxtTSWAa93I2ubGvI3igZLu0JSBwbOTD
	 WjBsymFCg+R3Q==
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
Subject: [PATCH v2 1/6] tracing/kprobes: Fix to free objects when failed to copy a symbol
Date: Sun,  5 Jan 2025 21:47:45 +0900
Message-ID: <173608126490.1253657.340741438044767488.stgit@devnote2>
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

