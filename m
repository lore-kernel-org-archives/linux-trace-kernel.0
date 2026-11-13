Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794558593;
	b=nCjH3ccLGk64e8jdl4X+sQGt9MPY13ae71V5468BLWrxovp6n4S+tT+i8pvAfGEFuDJS
	 8G2DF16ZTnA8ZFPB/1Duhmf44aB5flT4mEzJvrpgolZr69iGAisnLFEnjnPibRwHNRlGW
	 GUBxXhfuDLkRzOqxlP+rG+MNOpoKtf6iyfPHC1K67893q7wqxhGZ9I5IEXpXr0ahlkEn3
	 jIdIUO29tTTW/JzM9ZVLXONwVH1cRCG31QpAasQavMyvHRn8YZ/jEKej2q5zuX0SGCPxE
	 iDzbHU2awVOZh4YzmaHflOhL28qHxJeDwsvXLtMjW0gSL9TocbRP1a3kU1GrhMHkwsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794558593;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=EL69zpnXTdiiGn+399fnLQ95HNutCve3uZ+VvY6ocs8=;
	b=uJ450GTQCehDWbqiLdNsRigcKi0GgVUshpS41IjY9A0DPtxwKOeQnuBaRcpUOZ8GIdme
	 UspzVhgu9I12I+Qwx6bquXK9V0P9OzpXn4YXcXJ7ko7JPopzwHvqCeN3WsWvtZ1vdYmSc
	 A5Ah/bJgTow58OGsFr2PfRKa7r2arqSLeEYwMC8GDPeRmEhWwHDjztUxTsyyO3wNKRD+W
	 uBtthSnXnGPZBHGRQtfeGP6V7CtI96WEIabvAjNkIM0BMeTmqaByFEa1WooJp4k6QdZfs
	 G5/nvlM7qadalwt7Zxf4R6LU/QfhSgw8yZtaMT6+wGUrdSjjTaXXngPnCgBFr6Ejy7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UaebWFD5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16755606B606;
	Fri, 13 Nov 2026 08:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UaebWFD5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04A01F000C4;
	Fri, 13 Nov 2026 08:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794558592;
	bh=EL69zpnXTdiiGn+399fnLQ95HNutCve3uZ+VvY6ocs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UaebWFD55QMggVZH4H8Imo7ARIRBFXcPk55vrcOKCbWaDnEwPKJEVFvfZo0G7g4aX
	 ExPNeRewXPX2lhUBiJIVXqxMGLaMfNUthKh/6UIG02MiXJTaBkHRndKFrwLX3ndKWr
	 XDIj0KnQO2u6p8QHEkR1flOOSKJAto2pZKkyATPsCrdQj/3JqmnEsh9RDaMt/YfPcP
	 T8TkzPlJvSBayY5/moQ+/006vT3pYFsDwqN68Yfi2D7nJVJLpYkVmoDRs9ZGoFo0x/
	 j+AieKrzIMcOh47F11tq2EuLAW5TmmfYPh8rhJx8Xkm+JEGQNXA0v8tzrclbI7nBpL
	 hdHzS2vRCjjOA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 12/13] tracing/probes: Validate command prefix in kprobe, uprobe, and eprobe
Date: Fri, 13 Nov 2026 17:29:48 +0900
Message-ID: <179455858883.403392.10636919602331829398.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179455847934.403392.15146485751358774349.stgit@devnote2>
References: <179455847934.403392.15146485751358774349.stgit@devnote2>
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
index fb7991543db7..9f8f81a36192 100644
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

