Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EA4E572;
	Sun, 26 May 2024 10:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716718287; cv=none; b=evlGDnCAo7rxdeLWqqYDScFkecvsXpCFGAB9bHOWIfrsyDTJherCxAEK3plskgn6LiUEMMXblW7MQ4FzoWRA9l/9etL6653mxrxiDBx6tAw8xwDNrfVDb9WUQ8avT3WXBdpNhb7FV683+X/zqHwR7KB+AjmGvD9YVP2iHe9lgtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716718287; c=relaxed/simple;
	bh=RiDiiRL4D9ZYJMcdrUXWd2Q9FPZ3gwM3t30z+w+Axb0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hc4kfbI6FCCp66T6s8d6ORCgNhlbYu4HH/WHGviHDyjdx0zMCObL6df03zyI3nplRqkYl08PA4XRL8ZTEzgpZHZ5MZ1PYPKDUXn/bJQggtSG5GVDo8BL5GAqkiiWhMfX2WFIcCcFvkJVHXrCv6mVbCGUx7GnQqC+W6ONv1bjBdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRFXsUd5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRFXsUd5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F92C2BD10;
	Sun, 26 May 2024 10:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716718287;
	bh=RiDiiRL4D9ZYJMcdrUXWd2Q9FPZ3gwM3t30z+w+Axb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uRFXsUd5iaQ0e1CD4VyDidVjGIpHr+UQFLkCZqKFg/YABE7Evvp04U0bgcMQAWqLW
	 Snb7/AEsNSwE8sJI44rxLvWfRZt5slxI1EkREL1hC5l8uXTkY4vbkVbdJRkAZsXVTw
	 9rhZ6ys848pS7UhB0+9D68801I2NI6UtzHxlu6g5U3paSVdzxO/SX520r1Nj2gGEJa
	 5FlhF1ILuyNGGUMDL3mDB4Ex6kLSNuh3aacH4U7uJscvLF/bd/zJ2E5lWPekMt/+0n
	 NKyW/KNzo/8LI663Y2TY/3zGe2OvYHKfxG88fyrVH/sJ/BxB/Zzr5Vct0CcP+zNNC/
	 19I+vXqm60K8w==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 3/3] tracing/kprobe: Remove cleanup code unrelated to selftest
Date: Sun, 26 May 2024 19:11:23 +0900
Message-Id: <171671828374.39694.1028722916245719966.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <171671825710.39694.6859036369216249956.stgit@devnote2>
References: <171671825710.39694.6859036369216249956.stgit@devnote2>
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

This cleanup all kprobe events code is not related to the selftest
itself, and it can fail by the reason unrelated to this test.
If the test is successful, the generated events are cleaned up.
And if not, we cannot guarantee that the kprobe events will work
correctly. So, anyway, there is no need to clean it up.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 4abed36544d0..f94628c15c14 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -2129,11 +2129,6 @@ static __init int kprobe_trace_self_tests_init(void)
 	}
 
 end:
-	ret = dyn_events_release_all(&trace_kprobe_ops);
-	if (ret) {
-		pr_warn("error on cleaning up probes.\n");
-		warn++;
-	}
 	/*
 	 * Wait for the optimizer work to finish. Otherwise it might fiddle
 	 * with probes in already freed __init text.

