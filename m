Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794446911;
	b=o62eOVytDhw9C3Eru0P8PxAA2YP+wuvXt2HdXT4NNOQVj93anMlIbUjfHt3jmenJOhwy
	 hgCav93Ye8trfxH4HxYIORl4iQEeeNmAwtiiSEepGsBUoK42ctQxFz/CZm6xaEy2rrSwK
	 v7Mf0D6KaBxDqSOwBdBGArCEOZq8ZCx36Zq2LwnsWwUj+65Ed4FIH9cO7k8hHHMdkLSBP
	 QFXWG+kMVDbJc8OAWZHHetOA1yeRoTG/Ss8JbcJJ/hAqP7+1ueUdGbt1LsFMnZNXQzLgF
	 jOmyrW2bLWu+xFm/RFxnJfCAMEZR2wkDdFqXD+y8hgJ1ol6D21/BGoSSnxYI9SsVAfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794446911;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=EL69zpnXTdiiGn+399fnLQ95HNutCve3uZ+VvY6ocs8=;
	b=uhOSwEFgIdnHWckDzMrj+x4QW1CuhC4GMJ4ueoNnGziLliCuzPjSyBAZW6bYdIQ+Is4M
	 IR4tlZlBSf6hTxRi7ATPq5jGB2R6WA5vKRHtgECPw3Lx3mtVeC7QxY9sBkNNYwKp0LWiP
	 KIgS+v68JekgWrEMqsPybQeh9dxKW10BOuvzVYMcDT0gOhmJY0AtC7QNNHhzj+UeydobD
	 3FP0qPiC04+0lTz0MgiJzfn99a50FI2YcbpXLudng5MPun3BztV/124N5o9h5FS1kjpWS
	 DQox/lpnf3BsgEgm+BMjOcgAxeTY1j4T7RBetsUEngS0ansGIbgAuZBLNg4GRy5XvCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mM4MqIqK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4ED606A323;
	Thu, 12 Nov 2026 01:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mM4MqIqK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016331F00A0D;
	Thu, 12 Nov 2026 01:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794446911;
	bh=EL69zpnXTdiiGn+399fnLQ95HNutCve3uZ+VvY6ocs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mM4MqIqKi9yYtIwkDVVWOtqnwWMiXSv+t4SX9Lg5bkvIXspfdEpt8E3Iaj5/hL4OV
	 NRmjsSyXPOtNRd28QREEDEdgWvI4uZeohb31WpUq3Unz4kkCLJDs4it+YJD+sCc5i6
	 xOqyCGtPm8jsepN/kteMGDHct5kTQh6wkxIJRJoRld4Q7FbrO6DWO3m3gtIWz6sZjb
	 JK+w2b1G2mniy/ky2Jb0FMLav+cC42K1HEcArFgdjyOhddvw5LWVzrrh5N7uahx8Ni
	 0yjFCfyek7YjbtnzWdMMmoTvjVqml7AA8fOUY03j/k7fU/hXduYSqDg207d350DfXU
	 Xrgdgs93wdU0w==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 12/13] tracing/probes: Validate command prefix in kprobe, uprobe, and eprobe
Date: Thu, 12 Nov 2026 10:28:27 +0900
Message-ID: <179444690767.345731.1526332209646753028.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179444679892.345731.5271591537517106679.stgit@devnote2>
References: <179444679892.345731.5271591537517106679.stgit@devnote2>
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

