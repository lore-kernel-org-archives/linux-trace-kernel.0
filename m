Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184187;
	b=Vkj/ja6/kIQg1gFXzPMxsYc1LzQgbYAf53rwx9mI5rNQTtpI0PX5EMloOw7Q6XdhWk42
	 B5kFUFIHEy99hWIIvA8WOMUffdHf9CnrbF2GTKNacy+w3ItwYgKU0pRn44OjGiDBUsvWg
	 3D1BkyNeSA2HyfrYxc+4nPrp6J1jZLRBSaZ55LAUWsU35FDhLjzi9do8JPOg/DxlNZ1dX
	 xeyZjJZrI1G4wUbhl+ORH3WHwbc59VuUQGMbY9V21WQrt5vA6kAT58Mj0ajyI6/TgpS5w
	 jARbZwu8LIU/Yxr6VbVWDm6VGAbDeSKV2ba2AhaFKuGLqPFg8J1U7mAYkQcU08RQ4oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184187;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=njLkv7L7DZ1DconmI/jK0HeR4c+4UFpisnk1zk4PbAg=;
	b=0Ybm/QVQkhfF3+vCg0fprwHAsTCP3c8//43xv1bnEEMWQ/SuuCbSAmtcJZHUijwheoqy
	 3QBTpgVDrRJsT2o2PYeTQc0E1IVL1HfkqkuBLr/J8SDNxSVwwZ8VoBroo1bFCzyS9psk5
	 EzRdQdiUbDNGCE7PETiUlJSgZ86pyZ3po0tHYSoDwF1zHA2dBZdS7W48RPK47nUS/iCVV
	 vGJjkEZULF+86d2ZIB5YeucGFZoG/rl+YyzLAxh60Xi8gnro+1Znf80wQIiqjhEjjdUnh
	 UrQg68/yWhRdHWuEJNDbbwnQA/9Q3gIsuBLY8J6pTufe2VUjxXv4e75aApf3hdrESIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I48TnUOB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D56606A326;
	Mon,  9 Nov 2026 00:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I48TnUOB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D3F61F008A1;
	Mon,  9 Nov 2026 00:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794184186;
	bh=njLkv7L7DZ1DconmI/jK0HeR4c+4UFpisnk1zk4PbAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I48TnUOBfiorg8zDOnfdQKOvRXT4daK2+SW3h8d4b7rmydwppRHjenkbyUlef6ciq
	 HtR+ibQ80iFvZzHGTJmOgJthj4V0eFL0snYim3Q43GT8WCsFsX/TfBQgVqIxoPRvr3
	 HuTUwnoTI+dX85raP9t8j2N2h4dE0pQxrmR2G4f5w1ZHj6BsCcLCh+Bq57oMuOftyV
	 rd9PF5mc+p6WuiytMbMychUv8wUEKMioRgVK62n+3mdPdpKfLvWkti8xOmhSmnAU54
	 5Uko6msr0LpfwyGmyJCNsUKwiyox61h7oHrUUuaQlr3jjQvhSRrxsipnBYq9/gBmw2
	 ZvdTI/9KkTmZw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 11/12] tracing/probes: Validate command prefix in kprobe, uprobe, and eprobe
Date: Mon,  9 Nov 2026 09:29:43 +0900
Message-ID: <179418418328.227715.10680131052179044845.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179418408457.227715.1485179201014819821.stgit@devnote2>
References: <179418408457.227715.1485179201014819821.stgit@devnote2>
User-Agent: StGit/0.19
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

In kprobe, uprobe, and eprobe creation, trailing characters after the
command prefix ('p', 'r', or 'e') without a ':' separator (or non-digit
characters before ':') are silently ignored, creating a probe with the
default event name instead of reporting a syntax error as fprobe does.

Reject invalid characters following the command prefix with BAD_MAXACT.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_eprobe.c |   10 ++++++++--
 kernel/trace/trace_kprobe.c |    3 +++
 kernel/trace/trace_uprobe.c |   12 +++++++++---
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index f65393fb1c10..f65da7b3adf4 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -846,12 +846,18 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 
 	trlog = trace_probe_log_init("event_probe", argc, argv);
 
-	event = strchr(&argv[0][1], ':');
+	if (argv[0][1] != '\0') {
+		if (argv[0][1] != ':') {
+			trace_probe_log_set_index(0);
+			trace_probe_log_err(1, BAD_MAXACT);
+			return -EINVAL;
+		}
+		event = &argv[0][2];
+	}
 	if (event) {
 		gbuf = kmalloc(MAX_EVENT_NAME_LEN, GFP_KERNEL);
 		if (!gbuf)
 			return -ENOMEM;
-		event++;
 		ret = traceprobe_parse_event_name(&event, &group, gbuf,
 						  event - argv[0]);
 		if (ret)
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index a42af0e66009..35568d75723c 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -941,6 +941,9 @@ static int trace_kprobe_create_internal(int argc, const char *argv[],
 			trace_probe_log_err(1, MAXACT_TOO_BIG);
 			return -EINVAL;
 		}
+	} else if (argv[0][1] != '\0' && argv[0][1] != ':') {
+		trace_probe_log_err(1, BAD_MAXACT);
+		return -EINVAL;
 	}
 
 	/* try to parse an address. if that fails, try to read the
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 14ac52aebe34..3745eb07bd14 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -616,9 +616,6 @@ static int __trace_uprobe_create(int argc, const char **argv)
 		return -E2BIG;
 	}
 
-	if (argv[0][1] == ':')
-		event = &argv[0][2];
-
 	if (!strchr(argv[1], '/'))
 		return -ECANCELED;
 
@@ -631,6 +628,15 @@ static int __trace_uprobe_create(int argc, const char **argv)
 	if (!arg || !isdigit(arg[1]))
 		return -ECANCELED;
 
+	if (argv[0][1] != '\0') {
+		if (argv[0][1] != ':') {
+			trace_probe_log_set_index(0);
+			trace_probe_log_err(1, BAD_MAXACT);
+			return -EINVAL;
+		}
+		event = &argv[0][2];
+	}
+
 	trace_probe_log_set_index(1);	/* filename is the 2nd argument */
 
 	*arg++ = '\0';

