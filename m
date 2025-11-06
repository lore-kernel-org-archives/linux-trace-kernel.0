Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF468340DA6;
	Thu,  6 Nov 2025 16:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762447948; cv=none; b=sTjRDKSqd+ac5jEnD9T4MJ9lI2/45avYnzsAXjSOfwv0/c4CSMgYgJlU/Diqx1iViPz3aRQS68ZPxpsbQzLW2OIOk5u5QlhARO0NtzC6OTj6Mub+WoY+rs+pASfU+0lTui2ZdXXYyJGmrJnVoQqfd9rS3bYKVioAp2uuCmMZQSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762447948; c=relaxed/simple;
	bh=weAJhuC10feYNFY9qthmfAnotjPTt4YAJNN9S5QOm8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P3ZgpBUjxf+BW9EpAjgOOBP6CnGscUzlNQ/MEYLmvNOk/9tOaVeLPAMUbqiRF8wvxM81DNJeQ7gwMr7Lule7G2uD55VGbQILSF4gLA19mvGqBzzhYx/ivs8JxD+B5T+EQ9sKqOpa2yh+MyyRAL6dbg98vs066vcB3FH9QJQdU8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FB++twEG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FB++twEG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095FBC4CEF7;
	Thu,  6 Nov 2025 16:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762447948;
	bh=weAJhuC10feYNFY9qthmfAnotjPTt4YAJNN9S5QOm8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FB++twEG02v+nfF4QL6n85ODQ4n+KyfojrKIciWLD3sdv3+w8WtswouXkw3K63Ewq
	 0kKzVRZn2wtumnviRWCasm2NVBJXSDnsBd7K49dV28brz7tKD3hdrGTngnDnircnGv
	 JCqaf9EZUtVsO4a36/kRvMaeDUMmQbbz8X6iswcPWbkCuaitZ7vO4B9umBh/tGdmFt
	 h+dX5bKy3FUiESKkn/D9q6ZPUJcgTH2HMtycnj7+rjUKgAj2e5CSvzW/I22iONe8kN
	 IbQ3IGhhXKMXyF8kxSP2RiBFpKOheDfMSlzjl/DCD+6CnCYf7HrbHZZarhdCe1O2i+
	 9t8euNK/dptpg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Beau Belgrave <beaub@linux.microsoft.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/2] tracing: tprobe-events: Fix to put tracepoint_user when disable the tprobe
Date: Fri,  7 Nov 2025 01:52:24 +0900
Message-ID: <176244794466.155515.3971904050506100243.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <176244792552.155515.3285089581362758469.stgit@devnote2>
References: <176244792552.155515.3285089581362758469.stgit@devnote2>
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

__unregister_trace_fprobe() checks tf->tuser to put it when removing
tprobe. However, disable_trace_fprobe() does not use it and only calls
unregister_fprobe(). Thus it forgets to disable tracepoint_user.

If the trace_fprobe has tuser, put it for unregistering the tracepoint
callbacks when disabling tprobe correctly.

Fixes: 2867495dea86 ("tracing: tprobe-events: Register tracepoint when enable tprobe event")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_fprobe.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index d4e78d1ace12..62420eec677f 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -1512,6 +1512,10 @@ static int disable_trace_fprobe(struct trace_event_call *call,
 	if (!trace_probe_is_enabled(tp)) {
 		list_for_each_entry(tf, trace_probe_probe_list(tp), tp.list) {
 			unregister_fprobe(&tf->fp);
+			if (tf->tuser) {
+				tracepoint_user_put(tf->tuser);
+				tf->tuser = NULL;
+			}
 		}
 	}
 

