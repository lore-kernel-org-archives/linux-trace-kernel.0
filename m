Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DBE3294E4
	for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Sep 2025 16:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758646762; cv=none; b=ha2pjNRxLgmEC9+PC6CsR4acoPheS1NgGO2P3NNo91e8GSdrfKlbQOn7qmgg3lSxy7bb/6bUGdWTH1ym+clbOlA1eA6W0BW+4wnpEsewA8UQ+VjTDEJ1kWtFnxmfs97Z6kXBmn5DfsC1WqrjNR20gwXHvmlflOUy6AUX5M8yyuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758646762; c=relaxed/simple;
	bh=YJlkXO/ZITWmEi69lauof1/RW6YMbUVumNSLKe5TqAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gE9VyfWcWap3uzgDczfNfQXIT3Z97Xhuipz6HlruqndNPDKvLIp4I7wrW4z4c2Cv2cksbRcKN83CQ46yf6Q13F7z8WtB0qEaqFBq/OwXDNXeuYLwe8bfZ2PP6fqjddUg+uO60kyzeWVr2S5Lknwt8AHmsQz6BXrpyTHPSEh7sFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fgyMez20; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fgyMez20"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45dd505a1dfso41745745e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758646758; x=1759251558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TVJ0iQtlBKSgYr2iZSN1ZuLASEInLOEHg7PGBAMqWac=;
        b=fgyMez20JRLSwWcli1Jk0ROBACIZjvnWelepnpaDUT2/0QfaA/I+/GLmQ3ICQH89Fa
         cBIDizXdDuTbheA/BMS6DQym7S3U4I0hPT223ewd5rtWoMSHLM2hqsGmYikSQnpSJpfU
         EuLUKqI4YXOFIRDJMqjIR2sgujj2pwQEImN80E9lly+tTwjwaHoSQ9QpJBazd3AEqgZq
         DS8E986kKLRTfFf9Yn5+pgoRUTDBnc/cUt5ftnNcmr4aT8oU3VULdnpqYysHdTIbMwz9
         C2emB0FWIDYSMHHEW0aMCnTvT86Bm4hAyS2GinO1tg92whWJM9g3Jd1SyEGuI8s1RS09
         SUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758646758; x=1759251558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TVJ0iQtlBKSgYr2iZSN1ZuLASEInLOEHg7PGBAMqWac=;
        b=RNWvRCKz7zENYBqTcabVTi2yJjzQGwF5EYmsErTBUmrKD69xZyNAzE5+lXtab9KGdM
         xcFqCloPMcQuISeL56z3+0cVNbpBJ9nRc45ZMAd1CW+V0Z3nZUIxMhDHNUZJMWjioCYc
         uVhfdWZT31pk/0LlS82f4M1EBq0DaHOqiXpUINh2TmVQ1Ff9j3yEtqJ8Ut8Nqj6PVz3U
         APxfI+J5bQo0NJrI+1l8JSbZCFFH8uUSlR1+2jm9jCEUKmuvQUWHmTQNEwAEu4vftoAm
         3ZeYpt16hNtbCXBnXUVo6GssoEIFzzVZNAqGlSnImuMr2bM2X4Di5NR0QDgm5uSmGEga
         CQ5A==
X-Forwarded-Encrypted: i=1; AJvYcCVxpvsDVBfoFIuLxhneDDTRok8X34i5I5XajvtYQS3Yt5IQs1wOtJhOszHPvPMd44WELtEix4FmXXdq//156Yvmq0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwqIpgxlTkQieJAiPnPq7TqJ6gnSy8figNakFjg0ykLCHlfhjw
	lSqEalr8BWMdRAZ7nUtrJrNXYqOs7A2jIYwXcozXgYEHxALpb2EMy6JrBFSBNxaAU5Rb6uQdCVb
	U2Be1
X-Gm-Gg: ASbGncusFzyW30+S66A0A/79976002mkBhm1QI+IDNlTEyw8SonX0jXuMdMZo6yD4eK
	/Nan/BPwmKPdBqjcPzz4/SqSwGOHZLSni4n/guFXaPbzaCBdOhnV3VDutW2My9En0ikibhGNAqd
	vsvxsrTo3zPgqLrxF/BiJZZsglZkO5Kk2D8VoyYC1kwZf7FqJY5lTLLnlJKDuW1FyF+cOzwaf5D
	uzMV2kZtMHw1kTHjKORqzkPUd7TC7+9w7RadKgyN/QNnadu43URcIn2455C1x4ZZPLu7aISQde5
	0YwrkNmW18QAJQ8Nw+ONFeYSPUXQXZ8FqJG2KoCCmyFgwNm2aw1jHyKH5HKiNkOEPAZpxW0edDU
	dpiQYMyKYMEaaHDmLggVKWPx2pYarJ/O7lmxepIHCvng=
X-Google-Smtp-Source: AGHT+IH6FsdRHwPLQobQ/I7blfetgrGu9IWl79+904uwLjysCfsJwBxPJRmS0Ytnh5dlEiMpfJnu3Q==
X-Received: by 2002:a05:600c:4515:b0:45c:4470:271c with SMTP id 5b1f17b1804b1-46e1daacdc1mr36741925e9.18.1758646758594;
        Tue, 23 Sep 2025 09:59:18 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f00cc58b91sm18616483f8f.1.2025.09.23.09.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 09:59:18 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing: Ensure optimized hashing works
Date: Tue, 23 Sep 2025 18:59:07 +0200
Message-ID: <20250923165908.2399256-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If ever PID_MAX_DEFAULT changes, it must be compatible with tracing
hashmaps assumptions.

Link: https://lore.kernel.org/r/20240409110126.651e94cb@gandalf.local.home/
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/trace/trace_sched_switch.c | 2 ++
 1 file changed, 2 insertions(+)

Drive-by flushing an old idea. Take it or leave it.

diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
index cb49f7279dc80..aabae7daaac91 100644
--- a/kernel/trace/trace_sched_switch.c
+++ b/kernel/trace/trace_sched_switch.c
@@ -243,6 +243,8 @@ int trace_create_savedcmd(void)
 int trace_save_cmdline(struct task_struct *tsk)
 {
 	unsigned tpid, idx;
+	/* so that map_pid_to_cmdline indexing is efficient */
+	BUILD_BUG_ON(!is_power_of_2(PID_MAX_DEFAULT));
 
 	/* treat recording of idle task as a success */
 	if (!tsk->pid)
-- 
2.51.0

