Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534179;
	b=ZzwRB/0A0zD+kJn+nz53LoD3QrGkT0U/o8PT0rFROgUgLdLeX1+59dRByJfqaR4dcu0P
	 qz46QaOAieDysTB3QWJ+lxJxGqQ1hD0Rz9ncJlYuuI1kyjhaOVQvM3/dG6L/9DkKSH1Zr
	 mMYhI8pUEhiKubTxKtZpjy5mcpzWANG1hTxnLWZqIP3YaOW/jLBrlatgo0zqEM5Ax/hIK
	 ftxcg9gH2y3VDiujr2PSDpxNRq4FYCOnMseg40ypnN77uIAKN5J/K+ihvflnGHv1Zqj0l
	 BO99hnkXXCAfsxPricms8gQVQw7cM0QCdZ0X+7jIayCvxICvA10LVGnm0H1llPGVxrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534179;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Upb9mkcI4L7fHZrxtf7TuAgSddn2CA2QS2TCt7RKQ4E=;
	b=IOGrQ76tbTixQrNOBtogJBJMUiua5f9umXpHBwu4H3SkG3qJNNP37Z4+A5Xe2HZju1bt
	 0ele7UfwUE6ZuHdKngrPUn3NRMI6b5VKPYOq3hzjDMMmw2+c4Eftl7xehLQDg2rezB4VZ
	 EnCGaJXbn6cZo3ueoHmn/kgCdvZVID/KoiFkMgS18ARjscw0XQnUmIeqz91+LNCBMHIZG
	 dX8NCEtIl6djrgOsGLViy1n/ZOXYLFkfACZwuVlt5gemQqXdnfIxxbaLhDK6oWaYHvTxP
	 4LDZhi4hXHN1KvsXWpabETTDZ5p7XHHugZWMhHqHUhQWLzMIhsL6arTMWHUdfywXgXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eQxUEQF7;
	arc=none smtp.remote-ip=209.85.221.70
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC2860A5BE1
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 15:29:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BC2860A5BE1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eQxUEQF7
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-492b5408dedso2717004f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 07:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795534178; x=1796138978; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Upb9mkcI4L7fHZrxtf7TuAgSddn2CA2QS2TCt7RKQ4E=;
        b=eQxUEQF7GA7D942C+TqQ37BgZEOmBYZvjRWGuHjvXvTPdjLqXbkFX7XFRfuwnUHDI1
         no3+shDQXbCbvdjqLzpT8fKsbp5fwRvCJ+XOsH1tS8lNT5Qctu5Gx4cHZKGJ62xpE0JT
         HVJkQdIM2h1/dnfbli+o6r4D5a6hIkWWb/fwaFV8JKeeMtRydYzyK+gJ8eX6BqhEq4yz
         DGlywhvSk1GEQTPgRbI+fiiviQt0ySak+Ga78OHyaR11PsON0p/FuF+WtBLkJn49wp1w
         8199bM6sIFLJ3jMYGBpP6jtybIvkQbgTIDIGwBY8tMO6DKqx+zlTklJyZcTNLXtHjjNn
         XKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795534178; x=1796138978;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Upb9mkcI4L7fHZrxtf7TuAgSddn2CA2QS2TCt7RKQ4E=;
        b=Wxg7gEfksaJ9oBEQCr4mn5xROcR0T4SwyYFJHFzkXCp+Th9msqWIzT1T865F7CHeGV
         m18pWaecUqLz1e7xFpHNlJmarBy+Qg+hQzYyDM46E6vPwbOPFmds27CxlprYFHIRORVh
         0FG7xvwE5qB1JgbetztGIeMxOZc9slrs4vRqkhJd5EBH0ZnVB9g7JNAj3YXgLPBoCH1e
         ARX9G22qVFzCbHDJuyouPhY5s+UPioMDw+GPCH7gHC/uLXSEsmlPBnNTAI1lIqNxbIGn
         WWTxS5tTbMNQT4WlpygINOFIJ1R1uw0Hw+2JutncAz4fFP4zhXSX7LPn8v9A7fTubB4+
         xi6A==
X-Forwarded-Encrypted: i=1; AL+hErGPEFztMcoXHyrBImfhAjP+7K+O03i4RVU2nDBrjrlxdAMwPqW3sKivhlwrqMw3kQRFojMzyCPuF4QVUi0lg1/Gq9c=@vger.kernel.org
X-Gm-Message-State: APuU4Z8dB/2qpg7r1vVOI1TEEBzH3/2mvJeKQuViLnvNt+/pyRFCwqVw
	knBkm4H6u82hsi2qzmEn4sK0gfdJbSlqVFIy9QrX5CS8OP0HD5gWzMHA5e/QyHRkEbejCjgoWkH
	8UW8UBID5fj3jVZyMGhLqUA==
X-Received: from wrsf15.prod.google.com ([2002:adf:fccf:0:b0:4b2:1ff8:ed76])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:4b51:0:b0:49a:fbfd:92c4 with SMTP id ffacd0b85a97d-4abb3a4d650mr21945630f8f.29.1795534177489;
 Tue, 24 Nov 2026 07:29:37 -0800 (PST)
Date: Tue, 24 Nov 2026 15:28:43 +0000
In-Reply-To: <20261124152845.2233401-1-vdonnefort@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261124152845.2233401-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261124152845.2233401-20-vdonnefort@google.com>
Subject: [PATCH v9 19/21] tracing/remotes: Add trace_remote cmdline options
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Following the same format as trace_instance, add a cmdline to configure
a trace remote on registration:

  trace_remote=<remote>^<opt1>^<opt2>,<evt1>,<evt2>

Enabling events automatically turns on tracing.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/trace_remote.c | 145 ++++++++++++++++++++++++++++++++++++
 1 file changed, 145 insertions(+)

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 0a899ed5b34b..980f34a7603a 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -14,6 +14,8 @@
 #include <linux/trace_seq.h>
 #include <linux/types.h>
 
+#include <asm/setup.h>
+
 #include "trace.h"
 
 #define TRACEFS_DIR		"remotes"
@@ -1177,6 +1179,136 @@ static int poll_ms_show(struct seq_file *s, void *unused)
 }
 DEFINE_TRACE_REMOTE_ATTRIBUTE(poll_ms);
 
+static char trace_remote_cmdline[COMMAND_LINE_SIZE];
+
+static int __init set_trace_remote_cmdline(char *str)
+{
+	trace_append_boot_param(trace_remote_cmdline, str, '\t', COMMAND_LINE_SIZE);
+	return 1;
+}
+__setup("trace_remote=", set_trace_remote_cmdline);
+
+static bool trace_remote_apply_cmdline_opts(struct trace_remote *remote, char *cmdline)
+{
+	bool dmesg_on = false;
+	char *opt;
+
+	while ((opt = strsep(&cmdline, "^"))) {
+		if (!*opt)
+			continue;
+
+		if (!strcmp(opt, "dump_on_panic")) {
+			WRITE_ONCE(remote->panic_on, true);
+		} else if (!strcmp(opt, "dmesg")) {
+			dmesg_on = true;
+		} else if (!strncmp(opt, "buf_size=", 9)) {
+			unsigned long long size;
+			char *end;
+
+			size = memparse(opt + 9, &end);
+			if (!*end && size && size < ULONG_MAX)
+				WRITE_ONCE(remote->trace_buffer_size, size);
+			else
+				pr_warn("Invalid trace remote buffer size '%s'\n", opt);
+		} else if (!strncmp(opt, "poll=", 5)) {
+			unsigned int poll_ms;
+
+			if (!kstrtouint(opt + 5, 10, &poll_ms) && poll_ms)
+				WRITE_ONCE(remote->poll_ms, poll_ms);
+			else
+				pr_warn("Invalid trace remote poll '%s'\n", opt);
+		} else {
+			pr_warn("Unknown trace remote option '%s'\n", opt);
+		}
+	}
+
+	return dmesg_on;
+}
+
+static struct remote_event *
+trace_remote_find_event_by_name(struct trace_remote *remote, const char *name);
+
+static int
+trace_remote_enable_event(struct trace_remote *remote, struct remote_event *evt, bool enable);
+
+static bool trace_remote_apply_cmdline_events(struct trace_remote *remote, char *cmdline)
+{
+	bool tracing_on = false;
+	char *token;
+
+	while ((token = strsep(&cmdline, ","))) {
+		struct remote_event *evt;
+		int ret;
+
+		if (!*token)
+			continue;
+
+		evt = trace_remote_find_event_by_name(remote, token);
+		if (!evt) {
+			pr_warn("trace remote event '%s' not found\n", token);
+			continue;
+		}
+
+		ret = trace_remote_enable_event(remote, evt, true);
+		if (ret)
+			pr_warn("Failed to enable trace remote event '%s' (%d)\n", token, ret);
+		else
+			tracing_on = true;
+	}
+
+	return tracing_on;
+}
+
+static void trace_remote_apply_cmdline(const char *name, struct trace_remote *remote)
+{
+	char *cmdline, *curr, *next;
+	char *events_cmdline = NULL;
+	char *opts_cmdline = NULL;
+	bool tracing_on = false;
+	bool dmesg_on = false;
+	int ret;
+
+	if (!trace_remote_cmdline[0])
+		return;
+
+	cmdline = kstrdup(trace_remote_cmdline, GFP_KERNEL);
+	if (!cmdline)
+		return;
+
+	guard(mutex)(&remote->lock);
+
+	next = cmdline;
+	while ((curr = strsep(&next, "\t"))) {
+		char *token = strsep(&curr, ",");
+		char *rname = strsep(&token, "^");
+
+		if (strcmp(rname, name))
+			continue;
+
+		opts_cmdline = token;
+		events_cmdline = curr;
+
+		if (opts_cmdline)
+			dmesg_on |= trace_remote_apply_cmdline_opts(remote, opts_cmdline);
+		if (events_cmdline)
+			tracing_on |= trace_remote_apply_cmdline_events(remote, events_cmdline);
+	}
+
+	if (dmesg_on) {
+		ret = trace_remote_enable_dmesg(remote, true);
+		if (ret)
+			pr_warn("Failed to enable trace remote dmesg (%d)\n", ret);
+	}
+
+	if (tracing_on) {
+		ret = trace_remote_enable_tracing(remote);
+		if (ret)
+			pr_warn("Failed to enable trace remote tracing (%d)\n", ret);
+	}
+
+	kfree(cmdline);
+}
+
 static int trace_remote_init_tracefs(const char *name, struct trace_remote *remote)
 {
 	struct dentry *remote_d, *percpu_d, *d;
@@ -1353,6 +1485,7 @@ int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs,
 	}
 
 	list_add(&remote->node, &trace_remotes);
+	trace_remote_apply_cmdline(name, remote);
 	retain_and_null_ptr(remote);
 
 	return 0;
@@ -1840,3 +1973,15 @@ static struct remote_event *trace_remote_find_event(struct trace_remote *remote,
 	return bsearch((const void *)(unsigned long)id, remote->events, remote->nr_events,
 		       sizeof(*remote->events), __cmp_events);
 }
+
+static struct remote_event *
+trace_remote_find_event_by_name(struct trace_remote *remote, const char *name)
+{
+	int i;
+
+	for (i = 0; i < remote->nr_events; i++) {
+		if (!strcmp(remote->events[i].name, name))
+			return &remote->events[i];
+	}
+	return NULL;
+}
-- 
2.56.1.809.ga0b61035b5-goog

