Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04F41C862C;
	Mon, 28 Jul 2025 02:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753668797; cv=none; b=olar3wiyx/Pa1pym2Pl70I5LAME1QkyTDIcZcXBs9+/Uv+FdHzhGZl4HLahkUCfL/9rkVuOQRbbbaRtpHQBqOZelTu9Q40cqwo6AcS6TQkUgmduwD+7Mw8R9hAM1apEjyvh6eNH8/YZXjQJcUhB3Jjbas7kjXgY5T6JHMLQxJhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753668797; c=relaxed/simple;
	bh=FXMtPGsgzG9uF6/+09gEkzGKNwIgnHDiKaw3uPBQcks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gO1fxa1p7twl5+S54jGecY0flkKQmQHCdTEgFZBnPhe6tI2CAp/YfXBkUiNURTHYEn52FPafDGJcsVaxnd7vE40rmL4Bo9eloQ2YvgAH/sHPbJKAKs6tbpkQNtG3r6uukv+PlNJzzjmg3nfmRSPW8pK0TAQ1+KI4xrdm1O7MMT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2ft8nFZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2ft8nFZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059E7C4CEEB;
	Mon, 28 Jul 2025 02:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753668795;
	bh=FXMtPGsgzG9uF6/+09gEkzGKNwIgnHDiKaw3uPBQcks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y2ft8nFZFfgCOvbWATNMSzKFrcUVb68K1YiehubfznbdjL/fNcPch4ey8ItFHeYu7
	 ceii2IaBmVTbXhb2C5+4vHEy5+IEYrn+cWjl4Ywh2daFIQ0LW32xc0Zu++4B0g+QBd
	 vm9IsSCmyG5G0js7UEHdTFRSb6dE71PpAxT6c8UdvQkAnjgQQU6rw/LhkVVTVKM22G
	 LOepWe3xWVn8Lm3O8c8wBdxRzxY+Wu3gJ3WXxtiqtNlOaIQWAAxUag1h41c0KJrV5j
	 VwnjNH6r1BF6Dh3oYNDS1U76JrolF8sIVDRp9c6rz4pitdxCXPtQ+oNz8naJthOTxP
	 rRkJTstND1mNg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: trace_fprobe: Fix typo of the semicolon
Date: Mon, 28 Jul 2025 11:13:12 +0900
Message-ID:  <175366879192.487099.5714468217360139639.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
In-Reply-To: <175323425650.57270.280750740753792504.stgit@devnote2>
References: <175323425650.57270.280750740753792504.stgit@devnote2>
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

Fix a typo that uses ',' instead of ';' for line delimiter.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_fprobe.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 9d14a910fbf7..b36ade43d4b3 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -1404,7 +1404,7 @@ static int trace_fprobe_create_cb(int argc, const char *argv[])
 	if (!ctx)
 		return -ENOMEM;
 
-	ctx->flags = TPARG_FL_KERNEL | TPARG_FL_FPROBE,
+	ctx->flags = TPARG_FL_KERNEL | TPARG_FL_FPROBE;
 
 	trace_probe_log_init("trace_fprobe", argc, argv);
 	ret = trace_fprobe_create_internal(argc, argv, ctx);

