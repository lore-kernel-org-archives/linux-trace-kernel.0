Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1AE262815;
	Mon, 10 Nov 2025 15:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789705; cv=none; b=LxGFJzqyEVxPk6ROEDBjyD5dkEHf+dFRwESxZesJcwJgG0U2oRyuZESoLRy69NK2cq/XJr1rk02bXeRdLqJb9sakd39w4o8PcVCbpX/1ipI5GOo7Wrc2RW5FCDeMZjqFSYjfqv/rYFfedZ/XZJ8pT2xyFXJT88Hqsi6uhuSlWNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789705; c=relaxed/simple;
	bh=Mh0XmSrUNY/odMXbSUmYedftvZN7exzZT1LwgW9LuVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XyhHmaKysWApv9lQ0uymz0Ke6TnHc6yfkrMcYOg+E2TsFfFE2AwXDyCjm5RfPKgpZG3az875FzmGOoBcH/09rdQbeRPQnUBfji/YAZzHvPAGIIy249n/wTr/+x+EalFEWZ3PWy23Iptl9LsVm22GlalGzf6aGtKppe5ARVhe9q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xplzzdvg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xplzzdvg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55052C113D0;
	Mon, 10 Nov 2025 15:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762789704;
	bh=Mh0XmSrUNY/odMXbSUmYedftvZN7exzZT1LwgW9LuVI=;
	h=From:To:Cc:Subject:Date:From;
	b=XplzzdvgYz2gAPG+mjQZ3zvqy8XtKMB8s64MoyFdt02boqXtEaZyGdyokcNbGgiVk
	 rad5V33MdljYli614eVDX4A3rxCyIZK/NrMoxYPwO+vAmD4pTAicaWuHqeKbgoMFe1
	 bnifvd7Fsb+qXqWj8UocrBv8Tuff2AYUKJA0Mz5KneMAH5I78tub9LEem5rtqJ9/T3
	 DJtyj5P/liBn1MUX58kGK49KMGcwmX/vnu+RRUshhi8vwaMESgGKXg2t/YX1diHREs
	 ugzhF67T7Rxa75quNE4BYVDldY43Vc5o9/DvGT1/YC/iUPhUaTO/ebTvimP4fOfO3O
	 Hd/eQV/JEg0bw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2] tracing: Report wrong dynamic event command
Date: Tue, 11 Nov 2025 00:48:20 +0900
Message-ID: <176278970056.343441.10528135217342926645.stgit@devnote2>
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

Report wrong dynamic event type in the command via error_log.
-----
 # echo "z hoge" > /sys/kernel/tracing/dynamic_events
 sh: write error: Invalid argument
 # cat /sys/kernel/tracing/error_log
 [   22.977022] dynevent: error: No matching dynamic event type
   Command: z hoge
            ^
-----

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
  Changes in v2
    - Use tracing_log_err() directly to avoid compile error.
    - Update error message.
---
 kernel/trace/trace_dynevent.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index d06854bd32b3..c4dfbc293bae 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -144,9 +144,16 @@ static int create_dyn_event(const char *raw_command)
 		if (!ret || ret != -ECANCELED)
 			break;
 	}
-	mutex_unlock(&dyn_event_ops_mutex);
-	if (ret == -ECANCELED)
+	if (ret == -ECANCELED) {
+		static const char *err_msg[] = {"No matching dynamic event type"};
+
+		/* Wrong dynamic event. Leave an error message. */
+		tracing_log_err(NULL, "dynevent", raw_command, err_msg,
+				0, 0);
 		ret = -EINVAL;
+	}
+
+	mutex_unlock(&dyn_event_ops_mutex);
 
 	return ret;
 }

