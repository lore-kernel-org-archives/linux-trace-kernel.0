Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795115532;
	b=ihM+SYThdRLBAxhb/sa1FD+9ITZn7GaNaxzd4szqukkoliU9g7BwlLxzWg5Sy0BSzvf/
	 UQ59HRu6lcU7Q0TDAWm0LHTyyJYx0wniVae5sBWSa/I1rLVvbQTPTxpUZ6vJnh1MbWTon
	 mGWG8UVh8QL50jzB+jEExJ21BZ1v5OVZTVr8atH+zBcyOFL1rlzKfMJoNlHrhroAo3Y0s
	 UhywI8SDpoDrXqxYV0YfSjtZULhsr9GEhQ+WLqOnGzZNDxAokyR0MZH0Hyacwrgk6sonu
	 y4uFgpChqwIczntrairxbJToVf0cRPfe24y2t9H9tuIu2aF+CxEwVMgwS/TUzQSAs1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795115532;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dwyCEAim6gO40kqqOYIgTnUKBWLi3TPB7gPBoByislo=;
	b=MhKnO4vCoSvK+U5leQzVJ/Y0B3jwtu/fJ7KbdyT9/xQMYiBbg8Rk2RRSW4KBF2batQw7
	 m3w9R1h1hTdpdHW05tDi57fqiu9sN5BK8q75LYSXtGxgL0efPDS/QOh8+MU55UvHnQsrM
	 xQEF+3KbiPdy4S8tu0YymJtDB51sdCSiMS8UnFDqpkKRVJ/HwMkUpa2tG1dwdvAhsV4vY
	 Wng5CSxw5TkouZyjc0wm+aLkQjAXVNm0cFGxcjLXnUO8biWvvPFhArp4NCavxvJy5Hawx
	 z6tj8iJJQMTmgeY5aYfX2rSXl4q6wiHwedIPxtKPg2LC0YJriWMH/fS2KaZ/AFcsCPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pXpu3izc;
	arc=none smtp.remote-ip=209.85.161.52
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281D6606A325
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Nov 2026 19:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 281D6606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pXpu3izc
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-70b875f6f1fso58460eaf.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Nov 2026 11:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795115530; x=1795720330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dwyCEAim6gO40kqqOYIgTnUKBWLi3TPB7gPBoByislo=;
        b=pXpu3izc7Z7+QIGVR5RmK4NW+4or6x/sMwnUnYRDs6ZZ3IVnr8H8RVHn4Dg6Y89K71
         GZRTCbBxoDrZMx78Wo5HQK28LI+n24CTOIdrwK46Ci1fXN3EO7vT+zTQP+5lx24a7UKP
         VUUGa/YLMSEnPQtfwUx1Vae5F53hT0MQH3ITneMcCgfuO8c4qktdm59vQAsIjos3s1MX
         0hP7YVvQrKrYCIqpcomf0ZPMpJqHPtuL6wztotAk/Lvcycc259i90qKqodCEzgXKfThr
         7CHOZyw8bPnJhi51ZBdxqysc/3aN7C23P+eFn4t9sUOvs0bT1RGVZtlEkNcjTOhxDUCe
         FjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795115530; x=1795720330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dwyCEAim6gO40kqqOYIgTnUKBWLi3TPB7gPBoByislo=;
        b=hxR6rJtJwXTi7X+jYPjlxgKAW9yOEu91WBNrXhajrLWd86kGV/R1AhpT4xFrs7Thq1
         Rh4HY5CEdMPtKFAuFDhenNB3q9af+KRHQ6hyDWBeOZQhyXkECN0ZVoev5E1wmbapTgZV
         Wmpg06Olh/Dsfna3TlZX/lVMFPbtBoqlyIOnYX1oRnmFnq5c3BmUHkUq5V5SRGrLUXX6
         daEXZPG7+5grw8dXFutB3TOtdYI9G6PVgXuza6ID0ZWB7JT1nQ7Eh8sI4+l88giAxZ/K
         foMPHA1aT7lvJtwueoI4+n7GNU03R6LG1mIs/sAfU5agUETdJDhDJmoEwsvKmqHXPXQs
         kNfQ==
X-Forwarded-Encrypted: i=1; AL+hErGBCPKrdQJbGd+sCJ0PQPobg4zMj2BwvVfH2BjkgTDS4JaZIkGCPxWGpsuMS18GuU19t6LVW9MzI3tAurnIdyzeJ5E=@vger.kernel.org
X-Gm-Message-State: APuU4Z+QFUYH+2+uqJquHfC4WXSMcevhZOe8S1j/sGF6vGZFx8p//Hlb
	UV8eo4BSgNIeViuK6Yp56wUMXG3JlZTRcd4Tv79GQC+5wTuyW+ghxG/q/ozSfxtq
X-Gm-Gg: AYBFou0MvG6mcWDL6xrpQCEMD9cyljbQUSRvQE+KloM9GpSJ1a6Fph362SSfTn8DvM1
	vnlGv1wKGlmL4tMbDGswKuYw9ue7uRdg8hywBLoZD2jPbz1ZurrnjS2qbCgCpnQpXNJZuMLez4o
	/M1XISqzfCnnPNFHZi9Om+Buwd0N1r8rg8SN6A6aNw8Zcq2N65eFHhI+mjli3/H28H/gQY8nQV+
	QetoZi4w9mEhxWdk3rUynos5mijisq6kkJICgbifU8HaWv0VUY1sP5EPLO1IQUxiKPdMRFLx32E
	g1+hQumYZNWV0zAyZJSqqJCjSbsMhqJQzhukxfZQPP9SnjQrs9f7Gmq+dgQYdYfsgOnD4rmAMAX
	pMpwTQEnxjgjquZ1tQmn86y90Hw6dIyOwrCWsQW1C4wyFpocDu5heeJj1Gtt1oU0KGynKuwMx4E
	XfWDvACmoOvPElq+YPG4ca+69Id2su0htKvvve3n3rPjzYRyQWaZhtegfYQ4S1vM1jwXTIgrKdv
	BxFkb0Bu906CaA/evPOyIkc/gvDwFZTiuGSP7ye9NOXjUJ9MDS/tTAxJKaSovY4QE4LEYT6tx1k
	FzH0mcUaY8Ynsn49t4VQsEmzTdDmHF8aiL8zhAStIuZxGs77WfFcF59kJGKriAMCeeRhGbVDmG3
	h96B1g+Xv8nLFHIFODc0UgJ6IQzcgtlhJpfjtV7CbybRHWYqQq398OajeHrk=
X-Received: by 2002:a05:6820:3510:20b0:71a:efbe:ef21 with SMTP id 006d021491bc7-71b3920c4e2mr444880eaf.5.1795115529905;
        Thu, 19 Nov 2026 11:12:09 -0800 (PST)
Received: from FKXX2DL94F.bytedance.net ([72.29.204.230])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-86316910337sm293858a34.23.2026.11.19.11.12.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Nov 2026 11:12:09 -0800 (PST)
From: Yifan Feng <evanfengff@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yifan Feng <evanfengff@gmail.com>
Subject: [PATCH v3] ftrace: Reject "!!" in front of a set_ftrace_filter command
Date: Thu, 19 Nov 2026 11:12:05 -0800
Message-Id: <20261119191205.32892-1-evanfengff@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A command written to set_ftrace_filter with two '!' in front of the
function glob triggers the WARN_ON() in
unregister_ftrace_function_probe_func():

  # echo '!!vfs_read:traceoff' >> set_ftrace_filter
  WARNING: kernel/trace/ftrace.c:5675 at unregister_ftrace_function_probe_func+0x662/0x870

The command callbacks strip the first '!' and pass the rest as the glob
of the probe to remove. filter_parse_regex() then reports the second
'!' as a negated glob, which function probes do not support.

Return -EINVAL for such input in ftrace_process_regex(), before a
command callback is called.

Fixes: 23b4ff3aa479 ("ftrace: add traceon traceoff commands to enable/disable the buffers")
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Yifan Feng <evanfengff@gmail.com>
---
v3: add the comment above the check that Steven Rostedt asked for. No code change.
v2: https://lore.kernel.org/linux-trace-kernel/20261119030900.37343-1-evanfengff@gmail.com
QEMU with the v2 code, all 7 probe commands: one WARNING each before, none after.
Found and written with the help of an AI coding assistant.

 kernel/trace/ftrace.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index c7d74b33d36d..4e4337243797 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5846,6 +5846,13 @@ static int ftrace_process_regex(struct ftrace_iterator *iter,
 
 	/* command found */
 
+	/*
+	 * A double "!!" confuses the parser. This isn't a boolean operation,
+	 * simply reject it.
+	 */
+	if (func[0] == '!' && func[1] == '!')
+		return -EINVAL;
+
 	command = strsep(&next, ":");
 
 	guard(mutex)(&ftrace_cmd_mutex);

base-commit: 4405c18c95d2d0f99f6c581ef0ee8591a1aa6ccd
-- 
2.39.3 (Apple Git-146)

