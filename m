Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C51207656;
	Tue, 18 Mar 2025 11:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742297267; cv=none; b=pIr/dEHndp1IAZC+U0bvXFydOalMnfF5APY0y41IcpUmga3nva+s69PgOUZ064HoCcsNr6d0CbdDzbm2nC0d1u0qwa+B7z5GOOA/dsjgzGU+c6h1BRVjHPKKZvNwRYQJFr2B/Pr98epxrFKnWcsx/+sOzRf7InD21bhYLKB3eFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742297267; c=relaxed/simple;
	bh=7grknlphHpAkNnmLwLYUSBqyQUugIdELO0U72gMOS/w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WJrGnp2ykySECnvpX4fhwoWRmioNj2PGOxpRKKf7UPW0pNkxSG/HrSZW4G+CBhmIGKTrOGQ8SV503tv7UW/qUz+USN9GgLt1VQlcpFQ0z9Cahsqjon30Wb1BplQ5zOqgMNYdu4CXxI9wq/lBndKZBlJAAjivmg5gR+CskMHWzrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqpOCCaT; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqpOCCaT"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-300f92661fcso4927565a91.3;
        Tue, 18 Mar 2025 04:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742297266; x=1742902066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IcvcsPCsb52a0zF8mgEmM6gyp48rWfVJrSpx8wGcdyI=;
        b=iqpOCCaTZxS7pdt6yQLsENCjJ+XH8Nhqq/HTH1kvD1/Y0jXxgPxYLhBRw+OQNA9B9P
         OG23Be7oOu6sOT5Ng08fuS7pytstzr3xD4/sI74EOaU4ihEVeUQDOCT1aNx5N4Hhe7hJ
         9Uj1GL2HIr/dO4LxonOELveM5OwjvGihRzDXV7p01n93LK7ADOS/s4jvtKJS0g7bYxFf
         8UMEng3QMUCCKzvpsF6ScY9PRkkebv5TO9BYt61HUiyLHnjg7ATqpdJgTvHRRaQsRQXN
         BjraNHmOufqROAh5HSTkNzGqx+4AFvKfHNRwaEz8sbVa4xRg/8HzBJo6+R9EjGQqGs/m
         lgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742297266; x=1742902066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IcvcsPCsb52a0zF8mgEmM6gyp48rWfVJrSpx8wGcdyI=;
        b=ZZTeGYMWDPuTJ3yOcFJPawfE5VGedwv9U9aVXl7AHyER3HHupzaSXHUX2Z0FXgpfja
         MhzVlLqQz4m8Ht9yoYpM5BFIUPcg79tKKKp5M0VKxdiTcIcnJQN2Aeg9PJ97c+g1F577
         pPNN8/NNcyhfQYi4buJKdiM3VkFLX1D6q0ep7z6EPaIpGS+fzu3o/DqQic++lr/2h6nq
         WuH5hl2XkRZDqq65BM+uYWkEN7ZN6W9fhI28KaRxLhntv7tbR1oQhSEHuK0kPX4p1ZHv
         bcfrEbmKzNnPKJMJiaNCxK2mEle1cw3udplpdA1lYdxNjhSV6YrRT/SHDAR75KJKuvUx
         LvgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPKC0SGmsX/tteITsivH2efitIMP8RQC/APwhug0jwlv909HGSqu4f4Wua48pnZYb+epe6Ye/bYoZSUJ6CDYzGMmTW@vger.kernel.org, AJvYcCWMxTszBbeOYfrC6QLDXGN/T3cQTnP+yXL+2tSTlcpJ6fSlFb8XSIP4mvndEb/5mDRMWTl430JOPYhq540=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoYok6f5xR3BNu+OAvKMgEL593sW/8U6PdfTbwqVOY3TSiVOU2
	rqY52zqopU7uAemxG1gF13DfnXYeFNIcIpwpyMYlP9Fw1KG4+S1odnVRJdjNeWPKPg==
X-Gm-Gg: ASbGncsmKx0+jl7GFBx4Y4NsKYb35pANzxY6+RO7tV0BS8ZFT2Srb7yPfAryuIPShoZ
	q2pGD5R6Phhh9IC/pYXc2W+5770bayCg67r7pV/7YkG7l0/T/h4XORQfWVN3Deuqrm6sZdvfuAa
	5HdY32EEblv77CpFLruINp9EnijnuMNQ+IQ4naVBXFPBYm3rT5hGYg8PULFEkhHjIF2y/lmvH64
	YwX1AS4bPb1pz2Q7LWD2LSHZIQNl2VzYp+p4uVIKyW5S1xzqkvhQyCOy0FEF1yjCfbqJfBPAN9v
	ZbAi5JtGGu33vb7wUpSwYMlXbqfTsJD+IWR9YKczqB/dM5DT9GoU30/EvIdttOdovxNM
X-Google-Smtp-Source: AGHT+IE++RFcy6kw6hUjKVp1ZoCBUNo8R8FXnlvnWyV9smNvJP8u/r5hHiAs8ThA5ytPoND6N4rDHg==
X-Received: by 2002:a17:90a:e7ce:b0:2ea:5dea:eb0a with SMTP id 98e67ed59e1d1-301a5b0065dmr2577387a91.4.1742297265271;
        Tue, 18 Mar 2025 04:27:45 -0700 (PDT)
Received: from localhost.localdomain ([183.242.254.176])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3015353462asm7885564a91.27.2025.03.18.04.27.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Mar 2025 04:27:44 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: linmq006@gmail.com
Subject: [PATCH] tracing: Fix error handling in event_trigger_parse
Date: Tue, 18 Mar 2025 19:27:37 +0800
Message-Id: <20250318112737.4174-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to event_trigger_alloc() doc, event_trigger_free() should be
used to free an event_trigger_data object. This fixes a mismatch introduced
when kzalloc was replaced with event_trigger_alloc without updating
the corresponding deallocation calls.

Fixes: e1f187d09e11 ("tracing: Have existing event_command.parse() implementations use helpers")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 kernel/trace/trace_events_trigger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index d45448947094..8389314b8c2d 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -995,7 +995,7 @@ event_trigger_parse(struct event_command *cmd_ops,
 
 	if (remove) {
 		event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
-		kfree(trigger_data);
+		event_trigger_free(trigger_data);
 		ret = 0;
 		goto out;
 	}
@@ -1022,7 +1022,7 @@ event_trigger_parse(struct event_command *cmd_ops,
 
  out_free:
 	event_trigger_reset_filter(cmd_ops, trigger_data);
-	kfree(trigger_data);
+	event_trigger_free(trigger_data);
 	goto out;
 }
 
-- 
2.39.5 (Apple Git-154)

