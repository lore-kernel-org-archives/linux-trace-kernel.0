Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152101946A4
	for <linux-trace-kernel@vger.kernel.org>; Fri,  7 Jun 2024 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717766381; cv=none; b=lQCbDYtALnHDbUQBL1RDbA34hheam5mrITWJ/qn5ohQloaQScZ1sVkqsSWxx3/A+v+M/ErmqtJAjFoA1GGg57BTTTpzqQUJxHFTCzM8xcNmXorp0rAIBsqWy+1xMmzRXQQZ7ozSSaCsFQnJwmIyQ87NJAceCX0Xz9Ptg53fWIrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717766381; c=relaxed/simple;
	bh=OSQEU8WQvHs9CqN7OWfxsw7wbc722N6psOtPDT3lTF8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Y8J+XZPRaji4SEqxEmIhupAtigwOHnahWe2xWPWKL/ANhjO7gVwW0G7fssOY/TjHdKAEpLsgMcKsh6nYi7vn6MTjUTBhPUwedy86aNhsMukxvS3LBknmigTbQC91wLzilfdahEXI+HGS8TNSl8adHksb9sOyAAPbW81AYCFjx7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=infogain.com; spf=fail smtp.mailfrom=infogain.com; dkim=pass (2048-bit key) header.d=infogain-com.20230601.gappssmtp.com header.i=@infogain-com.20230601.gappssmtp.com header.b=eyOK//9/; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=infogain.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=infogain.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infogain-com.20230601.gappssmtp.com header.i=@infogain-com.20230601.gappssmtp.com header.b="eyOK//9/"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52b936c958dso2515240e87.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 07 Jun 2024 06:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=infogain-com.20230601.gappssmtp.com; s=20230601; t=1717766376; x=1718371176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xf2Z7kV+qRW7ecMxgqkQxiQuL+vRhmaWLr9eKOKWDn4=;
        b=eyOK//9/cHQ/JbHBaEpOB0WLqjZFGMmAD8aGjohIN35LRNp5Zh3WvRvBwWIZ7b7A8v
         2RGeH6RTkbaM4OdPsB1Oj12fV2Oqko/wiX2+vXW2M+Gh3nffylwL/mbwPVuGTnVxAtsV
         hVbNB3nBfoAp2lAAAZ7rW3P6qVccfxLxDI6yOeQcsJ4QMwBSC8b94ruo40yykfCw1z/q
         57a2ISoWkyErTQEUvJFgSNtjVeGs/1ztf2D19G+eHDr7eGcyfZpr8u2HnZ+w4SwpDQOK
         8LoG1BtQaEJqJBKOghzonvYJKykjWF3g92zU7dnHrih6IXq4hxXW/HddTbk1ToBElVYh
         j7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717766376; x=1718371176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xf2Z7kV+qRW7ecMxgqkQxiQuL+vRhmaWLr9eKOKWDn4=;
        b=j/p3PQ+XfrKVqRkSdeNFyMuSRc3DOl2oR3aBXQfucs2SzvdUs6TA3kXew7iAgsopAO
         iHqN1Ih5qsOJjn+zaIfYvErEH4tAUjfAH/dAqHtxNR0pVBdWYK2xSStIV6SImQsrA4+o
         v08l4VsgSWRnwv7gkiNpF3XGvvvgUB+H7YGdo+U0XmJSLl9zjsIxypplXAvcsDOWor1F
         fXZGBXhbQZxWC0muQV5SARZhA/m7BcU6deWi0cSbpRcuBrpBnqI8/tyHSiCdhSauzUUP
         UaeMWhf4DjSjNVO8hWXYk6MEinNfXCc3CpH9zwUO9ePGbjilHnMogdu6ST4YjaEIAwSe
         cR+w==
X-Forwarded-Encrypted: i=1; AJvYcCUK9WZm4xIryLq7XVmT0UFLO8Tb3Tpt4+Meyh2d9tSjYudu+Cedo+Nc6w8YrZ2+MEXHs7eNGZfe2quTrDSlnzm2mMyoEQnoqwdACY5NEnoGNmF2
X-Gm-Message-State: AOJu0Yxofu5/90+tA95jMcNKMbjlAkjOGcrjGUW1JERMNLdZ3BAPZuCc
	p48Kn7AcvwhK9373RDlCI/P1abOpXvwl1V67v30Ywm4kzdxxY0R4CzZiavyyY2c=
X-Google-Smtp-Source: AGHT+IET/hXJen46ojUBBSZb/7cDiS407ZVhwJK05+QzuBKflaYCF2qbs6nnMd5MnR1ezeKPhG7+jg==
X-Received: by 2002:a19:9141:0:b0:52b:b19c:306b with SMTP id 2adb3069b0e04-52bb9fe0af6mr1587753e87.63.1717766376197;
        Fri, 07 Jun 2024 06:19:36 -0700 (PDT)
Received: from localhost.localdomain (apn-31-0-0-232.dynamic.gprs.plus.pl. [31.0.0.232])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bb433d15fsm530443e87.285.2024.06.07.06.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 06:19:35 -0700 (PDT)
From: =?UTF-8?q?Wojciech=20G=C5=82adysz?= <wojciech.gladysz@infogain.com>
To: song@kernel.org,
	jolsa@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: =?UTF-8?q?Wojciech=20G=C5=82adysz?= <wojciech.gladysz@infogain.com>,
	syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com
Subject: [PATCH] kernel/trace: fix possible deadlock in trie_delete_elem
Date: Fri,  7 Jun 2024 15:19:30 +0200
Message-Id: <20240607131930.12002-1-wojciech.gladysz@infogain.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On bpf syscall map operations the bpf_disable_instrumentation function
is called for the reason described in the comment to the function.
The description matches the bug case. The function increments a per CPU
integer variable bpf_prog_active. The variable is not processed in the
bpf trace path. The fix implements a similar processing as for kprobe
handling. The fix degrades the bpf tracing by skipping some eBPF trace
sequences that otherwise might yield deadlock.

Reported-by: syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9d95beb2a3c260622518
Link: https://lore.kernel.org/all/000000000000adb08b061413919e@google.com/T/
Signed-off-by: Wojciech Gładysz <wojciech.gladysz@infogain.com>
---
 kernel/trace/bpf_trace.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 6249dac61701..8de2e084b162 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2391,7 +2391,9 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
 	struct bpf_trace_run_ctx run_ctx;
 
 	cant_sleep();
-	if (unlikely(this_cpu_inc_return(*(prog->active)) != 1)) {
+
+	// if the instrumentation is not disabled disable recurrence and go
+	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {
 		bpf_prog_inc_misses_counter(prog);
 		goto out;
 	}
@@ -2405,7 +2407,7 @@ void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
 
 	bpf_reset_run_ctx(old_run_ctx);
 out:
-	this_cpu_dec(*(prog->active));
+	__this_cpu_dec(bpf_prog_active);
 }
 
 #define UNPACK(...)			__VA_ARGS__
-- 
2.35.3

