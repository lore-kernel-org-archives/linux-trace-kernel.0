Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D922D023;
	Mon, 19 May 2025 07:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747638189; cv=none; b=tSdU1RS0Gn+pFMkXfJ7tvne6mrWkh7hLcv9BwOR7O0CFmerydHNeAoGf6CWBs7lCAAGUYz8HBtyCWR+HkL73bfFqKvIOEmM1h8PwXq4k4JD+O2+yGcXrxMwERmWQcvS0S5vF4io+24BUzQtslQljRGL8IJq0CvWeCowNIkZsRkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747638189; c=relaxed/simple;
	bh=+QQIyZeptuE1kjagxs/WlRzY0nIq8xahaCDnJ9NuxCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lW1qBPRvCo6OgCNH013L2mZRkcadanRHcpCkCMUUd4pjoZWUFZQ7oP1fFZK7sRwAwLOCbOOJsTIntaEKj7BKGY3ZoxjszLjXKmseFwno8rHee9+2TvSvu3nftmJw6OaIWNLDIYeDY+/rPxIrzZ48NMowxJkvB2U3hE58eD+WuHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiOp+wsw; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiOp+wsw"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ace94273f0dso697204166b.3;
        Mon, 19 May 2025 00:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747638186; x=1748242986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OLWLfExUQbf5HOnVzoeVJtfvCzuwwopKWrDaQj0e3/A=;
        b=iiOp+wswHf50VTbivoi6KWimSRMd66cT3qGnhSQ+aeYEvf9pbxmjbrKkSE0lclaqjz
         7v2RpiPsVdyAtvZ8n+ABWjUJqt+7JQ/avbbwIt82OxLVETnwqSHXR3y2XdQMFBygDPyr
         VZXuix7F9s3TKKXsctxuDvy5F7gqMjfPJWH3+r+aABZFoZp9NgAtCt11yAp/+qlu8U0s
         1K9N9+fdLKw9uF7weJacsWfmwwOVeDWya7mmofy3m5PIjFTCsNEibLVGcjj6T8eZE9IF
         fkyeRWkSU5mz+A9WR2aLxD6hsNa5a87lO1Y2hOsomTed6QBeV2aoNxkT87YuwdE9yIvo
         s5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747638186; x=1748242986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OLWLfExUQbf5HOnVzoeVJtfvCzuwwopKWrDaQj0e3/A=;
        b=jjQCxKjLRuYCo4Lg4OsuvE5JDpBtheWcIvG9vhXcNlQ6IKJqEW21dND8hLvwmhNXu1
         fUZLxiiQCfyX+80ULeQs26kZUWGeM4LqzmdSbad9z5hSFlsSSWDT40oY5CCtH7VHAxxG
         PnSld3KGeQo9zH2Ylr+Q8o681OBrqyocVIOe/LG6ycjYW/B3rjGNRFPnxqpOaUwXvhJ1
         oFVTszf3xgK38DKEMT+BYUbC4+8dIw1YNq9Z0YCCMX8EXhvIer2od6ALsx/XukI2A+8+
         ZNbCVgme+3sXeVogMHSEX9cbisKNxYC9/folpyRJDH/V+3TacQKm3Zr5nWI1J5C0e1We
         pwYA==
X-Forwarded-Encrypted: i=1; AJvYcCUQlsCBk/fYEx2AExZZFCr6V3g/ghWeN7L8nqFjqdsA7ESrvFFuj6ISH6PCPiYKeMrV/uXpq2v16rNcrQwngP/bWe8c@vger.kernel.org, AJvYcCUwXU9ZNScGYxjjAnVAUwGFo2Wmxe26n4fgxkJvGzeT12oBZWmkgtUQmLf6xghBNMTpPfnYKtQlPrak4V8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyphcxW+Vx3gbfMo/8Cb+fneEkWoETBVtdU+YkrBb8mGeCl4GHX
	H2EMWpqVpzG3YOO7EvW01WusxCuXPIRKybKyKw5QaS7Tx7mgJ53OliHa
X-Gm-Gg: ASbGncsgecjIDiekHOW5H40IhxgawG7QTPNtsa1O/A5eD28ZZvEixnUPNlN1VZgx7tS
	aSHZ1BNasQIEuU/Bgbj+lcBlTCehu8KzVQv4wqxOc54pK2h7dIFeBMC15F4eaJYam1vsk053K+D
	dQVfw2qtEekQBo9+SY/GWBfO8HejQrI4LxS8f32vLV2ATvM/D0xrTvC6QUb5DGZsgEPVlE/50bE
	rX2fTx3E16/QbCpjQgKrkr0dJcLcrJIg/c5FoEg+FUzeHi7XqOuDRWcBIFJryWR+4KvKbgSD/nO
	MTo1OsnI6shrEC0SHvJy6khsB1qxdCxAPmZDga0wT6aV9YifB0QpRw4Qmaw12Wd/ajhxaNsYP2u
	b7hOPetwfWERZgBmeVEuEq+Zk23M51gYJk/MA4jl0yA==
X-Google-Smtp-Source: AGHT+IFxEaxVZWJ++4Aj8pJPSQPmUS3xe7T18VyMANUL9xOorj1BIjynIQKF94bNWVBPWojKoEJBkw==
X-Received: by 2002:a17:906:f74f:b0:ad5:557b:c369 with SMTP id a640c23a62f3a-ad5557be832mr484511966b.33.1747638186468;
        Mon, 19 May 2025 00:03:06 -0700 (PDT)
Received: from rafal-Predator-PHN16-71.NAT.wroclaw_krzyki_2.vectranet.pl ([89.151.25.111])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d277a1fsm543268866b.85.2025.05.19.00.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 00:03:06 -0700 (PDT)
From: Rafal Bilkowski <rafalbilkowski@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Rafal Bilkowski <rafalbilkowski@gmail.com>
Subject: [PATCH] trace: Protect trace_iter_expand_format against overflow and ZERO_SIZE_PTR
Date: Mon, 19 May 2025 09:02:40 +0200
Message-ID: <20250519070240.256200-1-rafalbilkowski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a check in trace_iter_expand_format to prevent integer overflow when
calculating the new format buffer size, and to handle the case where krealloc
returns ZERO_SIZE_PTR. This improves robustness and prevents potential
memory corruption or kernel crashes.

Signed-off-by: Rafal Bilkowski <rafalbilkowski@gmail.com>
---
 kernel/trace/trace.c        | 4 ++++
 kernel/trace/trace_output.c | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 5b8db27fb6ef..637bd1ff9325 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3596,6 +3596,10 @@ char *trace_iter_expand_format(struct trace_iterator *iter)
 	if (!iter->tr || iter->fmt == static_fmt_buf)
 		return NULL;
 
+	/* Protection against overflow and ZERO_SIZE_PTR returned from krealloc */
+	if (check_add_overflow(iter->fmt_size, STATIC_FMT_BUF_SIZE, &iter->fmt_size))
+		return NULL;
+
 	tmp = krealloc(iter->fmt, iter->fmt_size + STATIC_FMT_BUF_SIZE,
 		       GFP_KERNEL);
 	if (tmp) {
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index b9ab06c99543..42560027001a 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -979,6 +979,8 @@ static void print_fields(struct trace_iterator *iter, struct trace_event_call *c
 							  iter->fmt_size);
 			if (ret < 0)
 				trace_seq_printf(&iter->seq, "(0x%px)", pos);
+			else if (ret == 0)
+				trace_seq_printf(&iter->seq, "(0x%px:<NULL>)", pos);
 			else
 				trace_seq_printf(&iter->seq, "(0x%px:%s)",
 						 pos, iter->fmt);
-- 
2.43.0

