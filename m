Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CBCCA6B
	for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Jun 2026 15:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781191065; cv=none; b=hGiawLiZTU9UkZbd2r8qPJ/RIGuvkJbnqwEZfCJvQSSg/D/Vs2HGGZfyxwVoERTFZ/clzxrzZEBCmUbhIzoVkJSLc05rhL8Aq4ngM/XPyHMAk06mJqK6nfzJda6GQIqOY0I+HbRXgvlbLebOYHBklSH04TY5LhnTuVgs7puAwxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781191065; c=relaxed/simple;
	bh=cTQejzbJd6B+XorGlBBzjfFe1SQcK2UlbO3mwM+4wqU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uXpsFxpDEWtbuRmkJoAof2VChmbFcTukYEqMWjzo5MjuYs5bTx7L1SkxVS/g+m/QVTRSVXavu6SlGuDpxb20wBBymyKF7CdEYhfkmoLcFl2wz/ahm6de1ukHKWJztkSPYjEmh/wMz1zFkg/b2hJyouHwssP2LrunVTQ/DwnYWL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQh1WmFa; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQh1WmFa"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bf18c30bb2so60637325ad.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Jun 2026 08:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781191064; x=1781795864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fkdovovqQ84FCjD2utubgXCN8OKcSIPHeiwALy2UbrY=;
        b=QQh1WmFalEcawrD4+d/UiOBH8Nq92NkM2JUkJ6EiYlilHicS8AzkO4ee0DqocopCrO
         J2NwAJGBI/mwVP3GSC7Fix+alvi3JhtaEPd8ubrYDrSslVEOLwdSYigOZUQkKr5G4PTC
         uwBJaFz7zug9BxNCIwvzCX8RHgiq3Rzu3PH0hzW8HyEdnbqvUVMDNSpKpMxR4xR8AwVc
         LNw/SoPmYI8fX1+u3bXVHCy/OubAnLIaJ6zbfaJTmUCOiEoo0fYLmbFtYy+7jcK4Ag6X
         x8ER5HbiAwMmIBqCpnf6NKWCmS90cBU3fzI/y3ELtR2y5VJQ6rDkEE34WItxeIg/WWQl
         f7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781191064; x=1781795864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fkdovovqQ84FCjD2utubgXCN8OKcSIPHeiwALy2UbrY=;
        b=e5aQnPQKM2NPyr0Rjqmwy0XWAHzBGJpfb9vYvKsYT8B3z/tvyr0vMstst5TWKG+4LM
         34wt2im+6XE+HZ9wUu+rl8KyqHgyyL2HPMjUCWJE0mkt29jzle9qTLlkFUlKTjGq0zB9
         Y0Z8STCVDRbnswEu2L4YEnRJPcapYwI38Od9gHCviHfp90jmmzWVsAR50qq6tNK3+yea
         00C74w2N93O4UpYp/zACjfdtV/mzuSS13R+l+ArksRjgVSwV5umTBBxRiMh09H7w5nJ3
         HPmSJVKT2Nu9kmLMOkAMIXmGEryAjVLM0LXvxxuDvyw8G7hPn7Jsh6dKG42tfI94YLu6
         t93w==
X-Forwarded-Encrypted: i=1; AFNElJ8/S62wFBEvCPOisdbn0i0yVf//CiKk6+IRHQYtrC5XuWFwsZEygzjFjVSG93uHDSoXRrJ1E3rS7sw9oIOjRavoxtY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8UT1+pAY9XGe1BnP92Ty3+7oF9NM1f/QyrWvnSJTkMyKTkrZI
	l/7X2w6h+KHcz5hTuIlhJ2OKkyaZfN/6tjGu7hhC2TjBEJl8d6wRMXeE
X-Gm-Gg: Acq92OEmxqMEp7dB6qMd9pjhppvin+zvM2vfpg/+8HAtMrjFpLXCQkkvls0bGd3WFaE
	Aq+C7hieTGs268WVGCum2gAkKoUmS+keUH/i/qi6wae7Gaj9/l0H1HT19VddLqsJmqEod17ifZs
	ocjyqPMJbG/HC5vNKsxfKM/LCksbY4HI4UjIyxHHaF5SDWGWN5b2qrq7Rw60eeQgVu8Fbd3yrv/
	eWKLQRQdl/C089ZknrdGzCKmv3L/LYfFdcC6/GoJOxskma1E7p/D3pCuhF/25xO2gzQsZjLTya3
	AqKOcwq3EBGhIird0muKzMpA33/dnJKYmcV+S52YNQJSKL4Zdpmuo3a5EZAIiwecNBPPqY6w9gV
	WIj/42gKxbL4FWgiwPvEhtAnCfHQbtWpAIO2dfvl6zreRJVDEA2b0VYJQI0N8UdeDETstLoKs6t
	7v9qboQQEdPjCtivXty5cdC65bC4HWoZyIELVA9SDeV1kFIxnqD1HOeng=
X-Received: by 2002:a17:903:2408:b0:2bf:2243:d4e9 with SMTP id d9443c01a7336-2c2f092dd2dmr38709865ad.13.1781191063728;
        Thu, 11 Jun 2026 08:17:43 -0700 (PDT)
Received: from yash-Bravo-15-B5DD.local ([106.51.251.74])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f85de1sm282299545ad.20.2026.06.11.08.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 08:17:43 -0700 (PDT)
From: Yash Suthar <yashsuthar983@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	tz.stoyanov@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	syzbot+2dd9d02f60775ce5c1fb@syzkaller.appspotmail.com,
	Yash Suthar <yashsuthar983@gmail.com>
Subject: [PATCH] tracing: ring_buffer: Check page order under reader_lock
Date: Thu, 11 Jun 2026 20:47:36 +0530
Message-ID: <20260611151736.255767-1-yashsuthar983@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

when there is a concurrent swap from ring_buffer_subbuf_order_set(),
there is a case of wrong read of pagesize,as the order can change.

If order changes ,the memset at end of ring_buffer_read_page()
uses new subbuf_size which can be more than old and we then
we will hit out of bound write.

to resolve this, moved the order check in lock and calculate
the subbuf_size from correct order to prevent race.

syzbot did not provide reproducer for this crash, the race
condition is logically sound and found via code inspection of the
trace.

Fixes: bce761d75745 ("ring-buffer: Read and write to ring buffers with custom sub buffer size")
Reported-by: syzbot+2dd9d02f60775ce5c1fb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2dd9d02f60775ce5c1fb

Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>
---
 kernel/trace/ring_buffer.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 7b07d2004cc6..e098eeb1d694 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6898,6 +6898,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	struct buffer_data_page *bpage;
 	struct buffer_page *reader;
 	unsigned long missed_events;
+	unsigned int subbuf_size;
 	unsigned int commit;
 	unsigned int read;
 	u64 save_timestamp;
@@ -6918,15 +6919,22 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	if (!data_page || !data_page->data)
 		return -1;
 
-	if (data_page->order != buffer->subbuf_order)
-		return -1;
-
 	bpage = data_page->data;
 	if (!bpage)
 		return -1;
 
 	guard(raw_spinlock_irqsave)(&cpu_buffer->reader_lock);
 
+	/*
+	 * Check data_page order under lock to prevent a race with a
+	 * concurrent ring_buffer_subbuf_order_set() swap, which can
+	 * cause an outofbounds memset() if the subbuf_size changes.
+	 */
+	if (data_page->order != buffer->subbuf_order)
+		return -1;
+
+	subbuf_size = (PAGE_SIZE << data_page->order) - BUF_PAGE_HDR_SIZE;
+
 	reader = rb_get_reader_page(cpu_buffer);
 	if (!reader)
 		return -1;
@@ -7043,7 +7051,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 		/* If there is room at the end of the page to save the
 		 * missed events, then record it there.
 		 */
-		if (buffer->subbuf_size - commit >= sizeof(missed_events)) {
+		if (subbuf_size - commit >= sizeof(missed_events)) {
 			memcpy(&bpage->data[commit], &missed_events,
 			       sizeof(missed_events));
 			local_add(RB_MISSED_STORED, &bpage->commit);
@@ -7055,8 +7063,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	/*
 	 * This page may be off to user land. Zero it out here.
 	 */
-	if (commit < buffer->subbuf_size)
-		memset(&bpage->data[commit], 0, buffer->subbuf_size - commit);
+	if (commit < subbuf_size)
+		memset(&bpage->data[commit], 0, subbuf_size - commit);
 
 	return read;
 }
-- 
2.43.0

