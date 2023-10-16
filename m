Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3132D27EE0
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Oct 2023 23:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnkkJzN8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5A4C433C8;
	Mon, 16 Oct 2023 23:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697500189;
	bh=ECcUrZRXKH1RGkNt+ZfqdBaP7v9kjaK8IQAhOGMboxU=;
	h=From:To:Cc:Subject:Date:From;
	b=JnkkJzN8aGirKUq5BDpIZSLbzMPHB8QZwfVNWJQpEjGbCfUBWUGKvjgAK3zz3krmm
	 29cZmHNz0RE4ormDoAPD2Ka2A4b3A+AHxhyJnK/iZwT6ej/7tTz1TC0xBv3/Z04/OX
	 KBsuAAit69ALEcmK3W4Q1MlzqpkBUAlngCmNu7ydTmdJ+9ABhXnYT4YJQMVUwSWRbs
	 kUddGaGB3F6WbCCzhmCkRNRg5dlnQOWeTMW+95g6FaEORBj5IHLwV4NMDsVIO0cW0W
	 +TRQdikZ5YxESdA7DXMhc33Xbr2mAHuPhMPtLi2ppamMifJFanNacoBvlMlgv+4Aa0
	 2wklKTMweIGbg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "wuqiang . matt" <wuqiang.matt@bytedance.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org
Subject: [PATCH] fprobe: Fix to ensure the number of active retprobes is not zero
Date: Tue, 17 Oct 2023 08:49:45 +0900
Message-Id: <169750018550.186853.11198884812017796410.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
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

The number of active retprobes can be zero but it is not acceptable,
so return EINVAL error if detected.

Reported-by: wuqiang.matt <wuqiang.matt@bytedance.com>
Closes: https://lore.kernel.org/all/20231016222103.cb9f426edc60220eabd8aa6a@kernel.org/
Fixes: 5b0ab78998e3 ("fprobe: Add exit_handler support")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/fprobe.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 3b21f4063258..881f90f0cbcf 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -189,7 +189,7 @@ static int fprobe_init_rethook(struct fprobe *fp, int num)
 {
 	int i, size;
 
-	if (num < 0)
+	if (num <= 0)
 		return -EINVAL;
 
 	if (!fp->exit_handler) {
@@ -202,8 +202,8 @@ static int fprobe_init_rethook(struct fprobe *fp, int num)
 		size = fp->nr_maxactive;
 	else
 		size = num * num_possible_cpus() * 2;
-	if (size < 0)
-		return -E2BIG;
+	if (size <= 0)
+		return -EINVAL;
 
 	fp->rethook = rethook_alloc((void *)fp, fprobe_exit_handler);
 	if (!fp->rethook)

