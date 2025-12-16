Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41797487BE
	for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Dec 2025 03:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765856743; cv=none; b=B+hqolbeAVpgOynpntedzV4hTUcFjMvmQTQH4AXO80fmtqaiv5ZFYaQdAxvWD2Ftk8kSohW1WLlqlJOc9Dwnk2LDYnSav4xevEpaUrXABxDlX3eUFK+fQQjgRrO4uTYI8vr/zz34fR4ZovSLR+g1tPEESTIWUQm4SMrmV6Zh+b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765856743; c=relaxed/simple;
	bh=iFf2II8cdC6H7B8M2fxvM1oJQFy3s+nfeSytxjbUIyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L0wQPAoRJeowGcNTEY8TyiEQLmhxOTRNjzsF8X/HRrn8x7a+clhmQcB3yQ4TepuOHVANseoiV1DMq2V2jtz/AOX6msR4h6IxePgow3fsYkpAHQIDN2mIBsQ/hPgZ07yhBKYi/05oXakJ8hzYwFMeckEh3sPJUqhbi/LflpMqksg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDA0iH8W; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDA0iH8W"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2a12ed4d205so6452415ad.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Dec 2025 19:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765856740; x=1766461540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZvJOPUtRZ1N4I7r+r/TWrvy168fwptcWtoImLBBG/I=;
        b=gDA0iH8Whqxs/Pj+1KOSxgKMjmqmWY6qnbJkUCMR6wR6q72gl0XrURPoU6cYCe8VwV
         bZfbNTzrl3SKA7GZYSd2Q3BTx19rNi2PQIvtl2i6kszmmjlKLkOpR3WLN1iMfRZowS+s
         qAD7s0yL3X2LzDnTfvYHKx0Bp+U8/cj/kQYYZIypzloBLxN6WmbRYtPFjWUCl8CrjN1q
         PR4o6L85tsMFXQzvnf5XVkUt+nR68oNlITc4gcazJlm+BlKqYZdD9vwdv6RN2hUZtfny
         9mVqlwDnnvfSOE79B9yT3J1XlqlJPJpM6WOVaTTDmyR9u92ku8zTD9A7Osvs37moZSbD
         Yc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765856740; x=1766461540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ZvJOPUtRZ1N4I7r+r/TWrvy168fwptcWtoImLBBG/I=;
        b=LhyothyhMwRpJYflbBnOBnQadIbVoS5LnFHOz6kcErOOP0cMfetUnJsJOtzUwRrWXE
         WrauShb6RtB+2+a/JAvBnjKK2IMxiv5TPXU7NN9IwD4JtKpJZ89NJNetHt/3Wa8BgHEy
         ICiXwilm6QwFw0iIH70rHhn82YFjf/NWjuYZAOPCvx77HCVD4PKJTUY9CdQAPTkEdGpa
         Hnz/BoOYPr/IBBovlpJ4w8wUpratCRKbyE+KvkJ/iPFqbEyFQC0P2v0Q3dg8PvWaCjQ1
         CRAw5J9T90dsJT7JVK6aL424rXBbkUAXrKvEYtZVL6JNurLwO3dK3tMttLqJKYkD001q
         wptA==
X-Forwarded-Encrypted: i=1; AJvYcCW9E8jNRZgwfS2BqgCFJG6exTbR+018g+HGc+9vvydaq/7HGOLN2blkGoSHoP4gFLlUej6cnsoRhD5ZQvmTnxrzNog=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsJ8NyJFKvw5E7OXDU8vg/zhc3peaAA0NQ8aTBQ5qGUJszCC4z
	RXs/TNFydMGHyh3Vy/HsSG6CD3KSd0iNNFI9JYQ9tTa/2cCMEx91LyP+
X-Gm-Gg: AY/fxX6oYSA0IhbuHhHgIQcFAC5PHmhPKTU7qur3T5v3TYJtzPinwqPqQ7uYRjfMgU+
	B8Lx9S/zluaMGVtk/73ghOY8fhfuwa27E3vvf514TAmlWhkg2AMt9toTQKe1N7KSsuEEdMhgZqz
	kSePdx334dUqkbz8YP8lFJULpRgYaquDKpp4y/vGRMstEA3cC49LZ2jPfRVCuvnFYB449Q7zsG4
	8QHfhpx7QHdLOj+V5w66vwiNPfp7QxypjXHETRLnFbIjJYRsZFIWtUozEhDr9PpoWdo22h3IdZZ
	17FBZArsHf15EZRW5s471JULNkia5KIcZe+/S0fOLpYmXDVgUVOGzOuSh97WBTyiqtlT2Vn3rJV
	nfJcGxKsLd7Cx3j4IZo3QOOgY3wRRV2KwfNO1BLvObd6mXm+pn1kf/pRNacvsK5fT86N/2AatI1
	5lBE8a5jI=
X-Google-Smtp-Source: AGHT+IFZIRQhwZJy3hLoh4zOo4H1RMGZyUoHQEWpbdmNrDy4m2ZISZyhEnRmgEkoaPbcsftKzZ/YiQ==
X-Received: by 2002:a17:903:384d:b0:2a0:dabc:1383 with SMTP id d9443c01a7336-2a0dabc1a00mr78660505ad.14.1765856740379;
        Mon, 15 Dec 2025 19:45:40 -0800 (PST)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29eea06b651sm149516365ad.94.2025.12.15.19.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 19:45:39 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	menglong8.dong@gmail.com,
	ast@kernel.org,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] ftrace: fix address for jmp mode in t_show
Date: Tue, 16 Dec 2025 11:45:33 +0800
Message-ID: <20251216034533.111090-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The address from ftrace_find_rec_direct() is printed directly in t_show().
This can mislead symbol offsets if it has the "jmp" bit in the last bit.

Fix this by printing the address that returned by ftrace_jmp_get().

Fixes: 25e4e3565d45 ("ftrace: Introduce FTRACE_OPS_FL_JMP")
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 kernel/trace/ftrace.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index bbb37c0f8c6c..d4c41fb76a25 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4492,8 +4492,12 @@ static int t_show(struct seq_file *m, void *v)
 			unsigned long direct;
 
 			direct = ftrace_find_rec_direct(rec->ip);
-			if (direct)
-				seq_printf(m, "\n\tdirect-->%pS", (void *)direct);
+			if (direct) {
+				seq_printf(m, ftrace_is_jmp(direct) ?
+					      "\n\tdirect(jmp)-->%pS" :
+					      "\n\tdirect-->%pS",
+					   (void *)ftrace_jmp_get(direct));
+			}
 		}
 	}
 
-- 
2.52.0

