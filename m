Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794818740;
	b=sffsJ6v2xVS8gVUQGyHHj1HQVohFdNebLJqCqL1RDb3VRiPWvzU9uf1AvJSnHmF6MHie
	 yIVTm9dIbfFW//vqKpQu3s7NI1vMx0zH1H1EI9ejCTyQPemhzddM/q28XUwjVMGjVNdOB
	 bCFYkLzNJ0XrhBvaqwM82rMUqxZaSW6rsOA3dgh9IGkedt7EFl7FBFgvvOFBmFLh/mMdg
	 LkNSbxEQ6ykfBJ/j5XfE0aLKUCwq6N9Zxe7AikKQDj1mxXp/v9a9RAB0Yq4vIr0tF01eS
	 fKHXHbYIWXrj/d/rKGLja/xAkQciLo8lAifY0gYw45J6HvkN5oywBFpBF9AhLrvpLQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794818740;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=emDL7nORVU/zbyIvHyGwsh10d6MuJhOn1sH+gqeM88I=;
	b=YwqkdMPS1S4dfwfX0OoohLkTAFAN/Bxl7hcY5hPhoM6e1bh4ER8dpZhdxMZQm/wCY9kX
	 VRu0/V/tPUEBkhmpEIN3BA83z4BFHaRSpX9lAozfpu51B/REJuXHgdxhN6X7UT9oq+wFb
	 jxsMb0NRTIrfCEbBkIcPfOwSEdi+cxFKlyHpP1T1twnOQbB30ZhKuBWLjbkEdY4mHbUwJ
	 xeJ3GUxC6I0JlKwaK/u0AwczSx04t6sKI8DhPkdx9xB+ePR63q0iTxg6zOVkWtY4bSn4/
	 w7UxDl8kdB5CA0IZ1SUblDNX/s/X8+g1ZX7XWsN5toH4z4xteEVn0ue/0WuW0vINpVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V3iAl4E2;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919BA606A31C
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Nov 2026 08:45:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 919BA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V3iAl4E2
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb64c99d2fso18288735e9.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Nov 2026 00:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794818739; x=1795423539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=emDL7nORVU/zbyIvHyGwsh10d6MuJhOn1sH+gqeM88I=;
        b=V3iAl4E2hXEYSgvA/XvsNIrye2gOhNXJVwQl80U1wTT4Vz8QXLkc+4DmZyFg19+Jjz
         Phyn/8RJ3fClE4rkvKT3dKYpHMpicSb8+DU7KmzRNFipKaCuIdjmd02aa8LG2P252ZF1
         sm3QiVsa2ZS/JsKZWckvd+HnASbHhutJwJVoJJmx6MXoKVO/oZcd8n6UbH8p1ejFvbxs
         lzT/BDbPc3LfFoupNjsuChL0BW0/w+4goGmLMP9Eu9prqOOHJqVWUvc/j8qgZfVYQP9E
         hYFPkQ6qfofBwAIDZ/Z/GIwJuj5WV7Nq8bvxdX0yZRsVNKwLhQIiaiExyqIIpxULcWZz
         kXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794818739; x=1795423539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=emDL7nORVU/zbyIvHyGwsh10d6MuJhOn1sH+gqeM88I=;
        b=haF8l+yx4vvdV8ZU+ZSzdhGeCf+75gyFRYPXKXJ4zk5WvY7/icqlfeBz1T5xhb6RbH
         yYxX6e5zNkyW0PitdxoZVmaulASo7bARepxYfAI2IfP50E8Q4LoBW1ijY26ccV5ZFSmd
         vVRJBqV4c9EFVvJKnm4OYOvO76K4L1yTa+ydmzCO4Wd5EkF1ioMSkE79xXLEqT5VtdPH
         eX/P5F16L3KhUHtjLrSBdYnNuRFVX3ZLgzxSxm1o3NkQ8FUjiK96FAOUWqHwdufuf86o
         +JlPoNj03MGxPzEslwoPngq95OMi6QLvFtE93+EsX9i/eNxyjDoY4ZMkZTBDBDXRCozW
         +c8A==
X-Forwarded-Encrypted: i=1; AL+hErH9Y2VX2swqDq/YE7EzjL9qH1ROo10WCbi7IUoAmkBKhepwTXFatyHYA7QQiqjKvQc6Wq5s0t0ukvlxGUgAzkeJy/Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z/QFFmbfX/4+tnfadOPnMJGEY4YKMWqro1diFwKhCdop1HbKAlU
	sYjD95OOWPzjlgLE/fzkfm2dn0CmsR/s5JzmCorbCiAeSj7oaB1w4u0x
X-Gm-Gg: AYBFou0rzVe/dPohbazMjQY1WBkA5MtNLYrzFVODaVgT4lw8Hdx6ppjymFz2yOVDBgq
	EirKPcI2kgdYLIfU2Wusr+Kl9CNUWqcf2z8PTsrU7GM9WqzO2wJ+qFNcemQQcAHVWya0Jp5qk0f
	0/3g7eB4OBI8gCN6Eb/XzjLbo+3OpW1a3h5yLzU5fCK2PHL1Yfi7v5AB2D1nfaxyprUpZkU3nbS
	rMo1S4TyhOCGvecu9xp0WOelBJMoAhUSae1oXMBzBacrfrt8Nw848F8kWiVnVTWNuONTR7qVx8x
	s07mmEpZwSHpTzfQ98wfuEcwlpiOwk1QenPIJuwGduBen9nwVDJbUPsBuBDGUidsy0H6m2Rs7am
	J6AbUd/IsKW4FUaj6yyZzK4M2EIWc1n0V3/EQbq0omUM0IRzF/MW1UEuji9al8H8+aVy6cBTzOM
	TV4TyYYpmluZeLB3UJaE4UBYKy/HKceLyBfP3X79506MuuGruIooFfyiwCMe273qHXsjReTpdMR
	euDTsEQ2HCcOKbD4LTdbHURzeHpsoC9FIdMB98pnwPrYhS0ncMyUUXHTJBhWoiMvOeJTGRDxLK2
	chUodqTswj++yHX4Vf3F1QGG+oNio/zs9g==
X-Received: by 2002:a05:600c:190d:b0:4bb:69d8:3e92 with SMTP id 5b1f17b1804b1-4bb69d841bamr93333585e9.29.1794818738636;
        Mon, 16 Nov 2026 00:45:38 -0800 (PST)
Received: from thinkpad.lan ([2a06:c701:474b:1700:73a2:10bb:45b8:8892])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c605e5b2fsm22404536f8f.40.2026.11.16.00.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 00:45:38 -0800 (PST)
From: Avi Weiss <thnkslprpt@gmail.com>
To: rostedt@goodmis.org,
	gmonaco@redhat.com
Cc: mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH] rv: Fix empty tail container detection
Date: Mon, 16 Nov 2026 10:45:30 +0200
Message-ID: <20261116084530.87088-1-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.53.0
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

rv_is_container_monitor() returns false for the last list entry
before checking its enable callback. With CONFIG_RV_MON_DEADLINE=y
and CONFIG_RV_MON_NOMISS=n, the empty deadline container can be
last. Enabling it then calls a NULL callback through
rv_enable_single(), causing a kernel oops.

An empty non-tail container already enables successfully: it is
marked enabled without activating any child monitors. Preserve this
behavior regardless of list position by checking the tail entry's
enable callback. Keep the tail check before list_next_entry() to
avoid accessing the list head as a monitor.

Fixes: 8d7861ac507d ("rv: Fix out-of-bound memory access in rv_is_container_monitor()")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 kernel/trace/rv/rv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 29f155c6968b..a142e877e940 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -222,7 +222,7 @@ bool rv_is_container_monitor(struct rv_monitor *mon)
 	struct rv_monitor *next;
 
 	if (list_is_last(&mon->list, &rv_monitors_list))
-		return false;
+		return !mon->enable;
 
 	next = list_next_entry(mon, list);
 

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.53.0

