Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC3F2F261D;
	Thu,  2 Oct 2025 08:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759394351; cv=none; b=g0SC0c9mLE3L3OCfpabc5M7HeEGKpqkzROtoOCr+L+TB5aqlVntoqmB6/D0ctHtkEa2Gfg1yLrN9WtxF8nVkH7qjkMl6qe6uBR1XVIf0T2lLtZB7Z/14rT9VU4WPIB8jlMyBkYX7B9n8sZCbn4lTzPXXC6062u3rJCs7RFDaTlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759394351; c=relaxed/simple;
	bh=3Qpsm4nFL3tgcFKEF1NONo4gOR6GP4LHeXjUsz+FLlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NYBOS1AJsBQpSRwESMeKV6OgSDlk7hE7O06wY6A82Ahv1mbwZipTPolCGqjKfkkYWCVMPuYyq7dpXHZ2veePeZ8pVlc1DOEgHNjJ6ImTJEDb/rZxNdcLZV0FqdYA/LqBm3Qpyx0jN1NcwtTS6uqoh/w2I5B8OuTCU7Bk1keC5zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfaEfQu0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfaEfQu0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2EDC4CEF4;
	Thu,  2 Oct 2025 08:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759394350;
	bh=3Qpsm4nFL3tgcFKEF1NONo4gOR6GP4LHeXjUsz+FLlM=;
	h=From:To:Cc:Subject:Date:From;
	b=PfaEfQu0ZbAbM/shf4t1xes4Gk2vUBdWTp/DgaqE3OiDZqzry9t2Toz1meYeTYVjh
	 W1Pu8j8XGG4byXnNVgIFlHkO9JS+hzExYzZddJG++F6ts6CxkbIBU1r4EVha8oyu3i
	 jzlW7vkfk2ZQ7FctLHHoh7rmwHkJSJu8SgLUMVYlIknkI8DuDDbJTGFEIV0qbhxbfE
	 l1Dr2s/mR38JitRsQ8ydlAL/iKev7YllDCAjd9+xPbRUsgcxB9CHHFiOSUsURAtKOh
	 Wuzg1R7h9TbmDXF08HR+MhDTsoA+csOqkNSj2h8VFzWT5UwkZWlKiSUk8aO/kOgLUJ
	 EwXRp4uLKatMg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Menglong Dong <menglong8.dong@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Menglong Dong <dongml2@chinatelecom.cn>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	oliver.sang@intel.com
Subject: [PATCH] tracing: fprobe: Fix to init fprobe_ip_table earlier
Date: Thu,  2 Oct 2025 17:39:04 +0900
Message-ID:  <175939434403.3665022.13030530757238556332.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
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

Since the fprobe_ip_table is used from module unloading in
the failure path of load_module(), it must be initialized in
the earlier timing than late_initcall(). Unless that, the
fprobe_module_callback() will use an uninitialized spinlock of
fprobe_ip_table.

Initialize fprobe_ip_table in core_initcall which is the same
timing as ftrace.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202509301440.be4b3631-lkp@intel.com
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/fprobe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 95e43814b85b..99d83c08b9e2 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -847,4 +847,4 @@ static int __init fprobe_initcall(void)
 	rhltable_init(&fprobe_ip_table, &fprobe_rht_params);
 	return 0;
 }
-late_initcall(fprobe_initcall);
+core_initcall(fprobe_initcall);

