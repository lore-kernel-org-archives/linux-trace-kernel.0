Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DDE347D0;
	Sat, 16 Aug 2025 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755353455; cv=none; b=VHY+aWKwhE/N1xn4d67LbSXEl12LZ5qso04UG6FnqYi/bQ54Q6hQpHdJkQKpETz1bC6iHNdc+TVW8kJ/KH685ajlMQReKauSTG3KZcajX/p1/1MOWweATLJ4Ukd277MqtWd7TXh8GG33Hj3FtKhPfAfvxcrR/NftPXBt7dtC9oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755353455; c=relaxed/simple;
	bh=A2IijguzmvCHTThiAi181MW3ax9cyNUVOD8hxWfvK6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R/pIM+wO8w7tN5EB8TmYxYc8ht+cT218H3De8XC/O2I2fn76YBCT1DdENCbqd66vW8k+MW/OHbFweRvGlrntBlx++ZYwCziFD6ieJlEEQPmi8T9pB3tzOpuBrPJ3CzyII3NFD/qnGbSkmdExNH2n0uzFWdGJch5NKIoHG5XQLXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S11BFUxr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S11BFUxr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0CFC4CEEF;
	Sat, 16 Aug 2025 14:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755353455;
	bh=A2IijguzmvCHTThiAi181MW3ax9cyNUVOD8hxWfvK6c=;
	h=From:To:Cc:Subject:Date:From;
	b=S11BFUxrqISZ7PjB6vyIt4f632pwnvgJUGmlSbLHWtwPqFb/eKGmaM9qGhmIp8+IP
	 056Am6990PQ+vuEQS2Aps3bLabPSYmGa3vHfzVRclmMnbMmsTAR5Wpd+GejgPYqRUL
	 7qqIZ6MUuVzmORhfyDGi82H6Oi1TaPJj0YsAJ5jvcYf6PQJcWx6+n0jrwj21RB9kl+
	 hmAUfE84EtuDLgA4FF1LyOQR4Y+8G0BtSFLTA5Ar6nexW1PUipnQEGI4HPzFmj9ILy
	 Bwr4gdqXlPgmuPsUcJElJHJkTRC5HxRgkpo/vAt0Z4Gi0KydiPl4aQkYAnedyQUs4Y
	 DLY//0LSsuKTA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Ryan Chung <seokwoo.chung130@gmail.com>
Subject: [PATCH] tracing: fprobe-event: Sanitize wildcard for fprobe event name
Date: Sat, 16 Aug 2025 23:10:51 +0900
Message-ID: <175535345114.282990.12294108192847938710.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
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

Fprobe event accepts wildcards for the target functions, but unless user
specifies its event name, it makes an event with the wildcards.

  /sys/kernel/tracing # echo 'f mutex*' >> dynamic_events
  /sys/kernel/tracing # cat dynamic_events
  f:fprobes/mutex*__entry mutex*
  /sys/kernel/tracing # ls events/fprobes/
  enable         filter         mutex*__entry

To fix this, replace the wildcard ('*') with an underscore.

Fixes: 334e5519c375 ("tracing/probes: Add fprobe events for tracing function entry and exit.")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
---
 kernel/trace/trace.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 1dbf1d3cf2f1..5a6688832da8 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -2204,7 +2204,7 @@ static inline bool is_good_system_name(const char *name)
 static inline void sanitize_event_name(char *name)
 {
 	while (*name++ != '\0')
-		if (*name == ':' || *name == '.')
+		if (*name == ':' || *name == '.' || *name == '*')
 			*name = '_';
 }
 

