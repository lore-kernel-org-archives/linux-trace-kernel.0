Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793667150;
	b=pLZm+l9O3srunXa28OcUEKNrm8d77csa4u/sKv+syVDQcWQXqWiNrxgVK6H4dgnO6Afi
	 NIFDQ8v8stj2iRonU27q9z21bVLRu05rCcI5nAHqIOHE9WsqVHzOteQJxlxh5RIuDTYbt
	 NWaKTz6G/oZJZTWPLktBZsn9JZd5kQtUIpFNz7KSppC0jS73K+9rPJhKAm/w+9WUdX3Wm
	 mpBvAwew0dFjLNyYTA00QC4stqqiMACAVaz2YLKA3wVu7qNQjoIEVKUmj4FyTCnJuXKnC
	 1SwLzBPvh2lfSBXPT1Owm9k1Or8KIR7IOHbL3F7zLkPdnhuALvgVaH2fHq6Yzl5j7FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793667150;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PHN9YZcJMsowYaUcF99MiiizJlDDuKpWiJxJvW9EH+A=;
	b=SbdH7uFyAWYaTBD0RARC2iC8bS3ESqr+M18VBwwKtUl9Y4KNAHnXJGzn9XaTYbf4HGrQ
	 KorDeb/NT7P0o/xDOut2HDjadx8IDT2eUQgO/CAE7P01x5ZslJ+adok3GLOcbf4u1AZko
	 5Sogc+AJ3kheeJCU4qlOCHHzjy0rEJgVsjLPaeqPj+be8Bx89mjE3OoIgiyNPizFc9uPE
	 i1420mWmAB6JmaSayKavLYQONQdwrTOrHNrhOZd4TTe9UZru+ZdsBlXxB7whGo/pRX4g4
	 XNQUaIIpmmJZHOkKSlQEjoVu7/zu7VdBKQZHMvO/jm7hL5VKBPh8XbZZphI2/tBJw1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T+4NbREi;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6B8606A324
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Nov 2026 00:52:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C6B8606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T+4NbREi
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cdb1199bfd8so1081460a12.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Nov 2026 16:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793667148; x=1794271948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PHN9YZcJMsowYaUcF99MiiizJlDDuKpWiJxJvW9EH+A=;
        b=T+4NbREil113iCWyzl/G9gT8SUZs6vj0+jBzKG7gJqt823aBka2YVz3tZ9Jw0CN4d7
         7l/a09owu1bpMwGcGrZFx93zrTgf+d87SOTo8z2FlEEBBKz8E8XZySnARheHOFgQuDE0
         wf5Nuh7gCvG5dOMO4JqPpHe8Dc3Z3AyriRuF1OFEkT4RAbLlY6TAj5i7BNlc/9Kk0zOB
         2ztuhe+6iMoPgbjMwS72LapXmgadiojXE56mBZ76o5BwoHeWm7IY3OltKL/2gBw7eAue
         vFXGF7kJz6t2eb8A6lH5m+oI9UOXOeLmpYJVsrY3bWaO/DZEq+ZERFfnfRX+vn5lpfOK
         Aj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793667148; x=1794271948;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PHN9YZcJMsowYaUcF99MiiizJlDDuKpWiJxJvW9EH+A=;
        b=Nf/aTQZZMRZs+mm/mJWOCtyuxtHNwHf1yuIkLRV+kAXaFl9x8HqZWoTD6Ac7tAQJaX
         DmOgCWpPqANeuvcbDsYgX9Nw4UNd6u3wheADKeP3h8B5cj69WUe9oCHJlZ+pFedC2rG0
         dCu1Sa1Ue/IB/NVm/nE8bSiMi5vEb0ZppcSW+sGANelIyCl/FtxqlTVitU3UUDd/1R5v
         RouI9zkUH/cT6HyPQobK4ZweMPvKI3iQq57qwjKi5fJwo9ITMg6PXrcL8V7cAeTsMT4v
         T9uRI1e3Yvl9v1JdlqNfNbfL/d/BNgEGpYD/UiVTGfwI90hxJjChQhRuTPWy2EPVjnny
         57QA==
X-Forwarded-Encrypted: i=1; AKwUvBxswz/lGoburGYoLE3Zw1/5xKdYmxXq94Z9gqLjyR+B8bJUavm6GxXUnIGVk+MYcUgMZC2gdCIxUUWHicEPJj7aH6k=@vger.kernel.org
X-Gm-Message-State: APuU4Z8dm6XWNHbEIgEUe9lfRWGqMmJI7xhtehdoe/4y+3QNya9fCq/w
	d/6uz9EzKB8dmc2au9EbdQbf8FgG8k/g66+q308gHVhfQCJ5SzLscOdh
X-Gm-Gg: AYBFou24SeoaBXmnbS5jmfy3ev4eiyCmwUuyaynxianoWgIoJHLFpB7oiaT/CoJ8W2W
	j2BLu//OUVTh2W7L7bgmVIM6IJSee5+5xEbohvi1iUnGs7Yekkh2cyILljNWBtDyHfN3ad2f4sK
	nOIIJ+2FjlbPFbAlX1M91yZoG540U1/KN5DacbSAVYFtEkivbuIAWJs3VrjUqx75871avgP6ce2
	xRhddHMjDvS745wopJHDOqycMKdOcXSwz1hOhX5TTDUUD7YGGHOK35WZA2eHpPLSuHSjjaU+yWw
	HnrBEYDNIZ0cmxXzddalINAwQjyOpfYQmOHSAi7J6ol9YS/wevIH8kEGgGrkMQZsTr/ox063diP
	Z9ciqsm2mTV7X0xZK3kCvAeGKsS6HfsRsqMRn/PzfpLRJQQKHZUzYDPx/SEPJRLxTaaMQuE7x7q
	mR69pKlp9YTJnD/zVu4bLFNUm/2Rm06sZLvTWEVBsJo+hCaz9KwN25rwwh83x/KPxs4wrxJvfkT
	AJSMpw08aLYAwF5i1KiKb8WduLrWGkyjBnce8usGF/CjKjBUTt36ui43UGy0UFt7vjQO3ZZIyCx
	4YrhSWhRcmM9psWKPclZkecMlZA=
X-Received: by 2002:a17:90b:2c8d:b0:3ac:b048:fa13 with SMTP id 98e67ed59e1d1-3ae8987e32amr9469960a91.67.1793667148284;
        Mon, 02 Nov 2026 16:52:28 -0800 (PST)
Received: from localhost ([211.249.71.105])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c5aa69fsm1428198a91.2.2026.11.02.16.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 16:52:25 -0800 (PST)
From: Jaewon Jung <jaewon8868@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2] tracing: Keep copying markers when one instance is stopped
Date: Tue,  3 Nov 2026 09:44:30 +0900
Message-ID: <20261103005219.3236380-1-jaewon8868@gmail.com>
X-Mailer: git-send-email 2.43.0
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

When several instances enable copy_trace_marker, stopping one instance
can prevent the remaining buffers from receiving markers.

Continue copying text and raw markers even if one copy fails. Return the
last write's result, keeping -ENODEV when no destinations are selected.

Fixes: 7b382efd5e8a ("tracing: Allow the top level trace_marker to write into another instances")
Signed-off-by: Jaewon Jung <jaewon8868@gmail.com>
---
All writes are now attempted regardless of errors.
The last write's result is returned. Would this approach work?

Changes in v2:
- Drop the stable Cc.
- Do not save earlier copy errors. Return the last write's result.
- Rebase onto trace/for-next.

Tested on x86_64 QEMU:
- Before: Copying stops at the first error, which is returned.
  Later live buffers receive no markers.
- After: All buffers are tried, and the last write's result is returned.
- Existing text/raw marker and instance selftests: 6 PASS.

 kernel/trace/trace.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 08614af8fad1..0b66c55d378b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6330,8 +6330,6 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 		guard(rcu)();
 		list_for_each_entry_rcu(tr, &marker_copies, marker_list) {
 			written = write_marker_to_buffer(tr, buf, cnt, ip);
-			if (written < 0)
-				break;
 		}
 	} else {
 		written = write_marker_to_buffer(tr, buf, cnt, ip);
@@ -6409,8 +6407,6 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 		guard(rcu)();
 		list_for_each_entry_rcu(tr, &marker_copies, marker_list) {
 			written = write_raw_marker_to_buffer(tr, buf, cnt);
-			if (written < 0)
-				break;
 		}
 	} else {
 		written = write_raw_marker_to_buffer(tr, buf, cnt);

base-commit: d7ff48d92a0f28bc0612da47c054efbc28c19562
-- 
2.43.0

