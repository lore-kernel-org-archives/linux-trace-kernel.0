Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6221EA71;
	Tue, 11 Jun 2024 13:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718112660; cv=none; b=o4811k7Alcaw7i+m0tLTySKCYyx45j7TYr9dVej3/euo3+eOx5yHY4kxO7hoUUvBD8Tp8uBcl3sVxjD/c8jAb9/y+W5jWN5NIqDHRUr8WzMtPMG69gyYXgiOpm7OhnN4FeKgJWcEPgZD05jL3MlJ9OIosfV0hRbJtvnbfTc803E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718112660; c=relaxed/simple;
	bh=chQfDDDwE1HHIt/Tao3ujNwT5+s91AYPvAT7zRChhQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BATvht8dxWzhGXAV8TzNS0R41j/wx6i8wrmaydJXcdWwHKq0OcAazxAHG5aotJWovjD/IkWLPHHWgGCOu1W60d9L15w0hydIAdW0fLJ1q6nRVN/lwn2Tdvkh1j6IZumZW3/IZKMpZ8vxWKjh4UfQD1BMHoVDY9f2BEwRAMK/ey4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VQtLE4Z/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VQtLE4Z/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C88CC2BD10;
	Tue, 11 Jun 2024 13:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718112659;
	bh=chQfDDDwE1HHIt/Tao3ujNwT5+s91AYPvAT7zRChhQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VQtLE4Z/ukMuGnfHUBZAyuLG808oDUiXw+fyvmn5mrMAtvsRmap+Z2s5Lz8LQ5+wO
	 Zw3aENhdaIy/jjbbIqwST6xYu2TkxYUV5Ez6tg6vAtkpbiv1Z2tFshwqbFAxp9CdSE
	 S4TC2JvLyVADhQc+JBLSh6j4dyXJRKeiAA1Ny5b0kcH8iI2VxSWByLe18zXj+NaNgb
	 fmHQGwLOqnW+/v+Vvy0P2y7YsCNojnBfs1SkYdV6ikDeKNnm3MkbcOec05csLv0Vps
	 nm9TT1mVj+bBB/pxS657kz1kFLJf2lgM/UPiPun6eFdMr8n1ZiCRWUYifWSNwsSaKl
	 3zu8720wUHJMQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH v3 3/3] tracing/kprobe: Remove cleanup code unrelated to selftest
Date: Tue, 11 Jun 2024 22:30:56 +0900
Message-Id: <171811265627.85078.16897867213512435822.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <171811262833.85078.12421348187962271050.stgit@devnote2>
References: <171811262833.85078.12421348187962271050.stgit@devnote2>
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
 kernel/trace/trace_kprobe.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 8c5816c04bd2..7fd0f8576e4c 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -2114,10 +2114,6 @@ static __init int kprobe_trace_self_tests_init(void)
 
 
 end:
-	ret = dyn_events_release_all(&trace_kprobe_ops);
-	if (WARN_ONCE(ret, "error on cleaning up probes."))
-		warn++;
-
 	/*
 	 * Wait for the optimizer work to finish. Otherwise it might fiddle
 	 * with probes in already freed __init text.

