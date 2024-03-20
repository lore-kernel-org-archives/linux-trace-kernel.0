Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA822C698
	for <linux-trace-kernel@vger.kernel.org>; Wed, 20 Mar 2024 08:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710922242; cv=none; b=tRl/SxbNShjZmR72sQeh6g4MbDgLeWKRzCb1/8ttGsInENylSdkhwBn3Z3LgQW3jE2lQeAhSgHAMiaseExo1pUB0YHQp/n9QIMoLkOkkzdEm+Wq0R0B+wTAZNlPGiKNf7mUT4nClrtgZUtzvYzLI19RPwkGx1qdwrlEuYBeeNdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710922242; c=relaxed/simple;
	bh=YZ+9lZAtN/z5L+c2tm2pEM66vlZSYVbbfwLXsuUZWfc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HNKnTrj2GWxlrNKvE75trERhrffvFHP1vbAZQooUzPP1dqy4u5NSCGwtKkBDaRcWVngMqtMk0oUdLPgP+ZSPCNWIvtIStsr+Nk6CogDaq4kZz1N5STPy/zHEkxWxNGaunYwtwltOKYl2UGyr755gkPVn+nhXiYf2qNRnSzH7EGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glcHefts; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glcHefts"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31BFBC433C7;
	Wed, 20 Mar 2024 08:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710922242;
	bh=YZ+9lZAtN/z5L+c2tm2pEM66vlZSYVbbfwLXsuUZWfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=glcHeftsiK0WjWLn6+zi4EfmspT3yocIWGHaz6fayeCyJ2xdYCC0qjH2gBkttRXwa
	 yETj8coYTOGOQQNxyVsOZAVmdvHXZJrdtpc+l1fhaq3awQcyCuQFixYlliRqDtFMAD
	 O6dPNxGM2qpPBnP5AiDN0Td2vhD+Uqs9x7cE7k16jGMM+p42ifoyArj4LkPRiQa3jG
	 g+9qDP3v9tAspv1cO/HoaVpVrpyNMDIPIglJoE3hON1wiAgh5IZG1MLXGCMMSiaBjD
	 1jkxm/Y7yLhAfjtqgVsUGqghVxTpAzYXETXnIXcpSMcHAfD/cf6+KQmLQ8lAy4+Fhl
	 +CyL3QblAblSA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: probes: Fix to zero initialize a local variable
Date: Wed, 20 Mar 2024 17:10:38 +0900
Message-Id: <171092223833.237219.17304490075697026697.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <b010488e-68aa-407c-add0-3e059254aaa0@moroto.mountain>
References: <b010488e-68aa-407c-add0-3e059254aaa0@moroto.mountain>
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

Fix to initialize 'val' local variable with zero.
Dan reported that Smatch static code checker reports an error that a local
'val' variable needs to be initialized. Actually, the 'val' is expected to
be initialized by FETCH_OP_ARG in the same loop, but it is not obvious. So
initialize it with zero.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/b010488e-68aa-407c-add0-3e059254aaa0@moroto.mountain/
Fixes: 25f00e40ce79 ("tracing/probes: Support $argN in return probe (kprobe and fprobe)")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 217169de0920..dfe3ee6035ec 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -839,7 +839,7 @@ int traceprobe_get_entry_data_size(struct trace_probe *tp)
 void store_trace_entry_data(void *edata, struct trace_probe *tp, struct pt_regs *regs)
 {
 	struct probe_entry_arg *earg = tp->entry_arg;
-	unsigned long val;
+	unsigned long val = 0;
 	int i;
 
 	if (!earg)

