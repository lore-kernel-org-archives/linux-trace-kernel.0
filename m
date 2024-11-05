Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB2F18132A;
	Tue,  5 Nov 2024 07:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730791216; cv=none; b=LwJ+/M3PAOJk31lQP5mPafJX7kaCvmcLyivJB2f/2ckg9nj4Z4Krnd341duKijTMBlGOmTDzUTl7m125+to5xBUOaMVQpNqyz1Oh62UhxElHkB68fL14wO97UNvVbMWs49j4f7S/x1Z6Z2ObNVyYiFJLWj+fhKPA/V/byMWHVQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730791216; c=relaxed/simple;
	bh=GSUZY5wJ3MLnz3npdEq/2cld67mJl9yhHojFqBMiELw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZIUTyrThZ38UEtmk0ZjpuL467cc/XE2jF4OAEM2zFMx3/VH2MlTTAUzYs9PCO5j6kkYCgFU5/IvyglNumwH2RM7+Wubz5cudFSJx+Vfpj7glFT7KvUb/r7ahBoapixlyMAXb9DeuSxhEkDnfzacESDdyPqTtQavDlssEUPSARmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cl+mHPqs; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cl+mHPqs"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20cdb889222so48608675ad.3;
        Mon, 04 Nov 2024 23:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730791214; x=1731396014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XKAHJzWLr2y1XDNxG2SQATXhIhZvmlarF7yids5u93g=;
        b=cl+mHPqsb5t9yEzj61wCet3CrIIwEyFtx6gZQiOUb9xrU4vniWmPWtnA0l2S+zd55e
         noy/3dBqf9GYNiuN1SM/oqGu7wVYdfBQIGp2Tq27XkOhACwEqFsx3/jpYZJopIu/XXOP
         7GATfN9fbbpN/QvfR3wDpfKAjpnUYFpaXyxLEe6qZy3fWMxkpFLvHPPZeubUQ2NC+/LI
         dMbXTH+YNbHckhXq3wvFbAP31U4D9BdGqCVd7K2s7kXICzypygirWhxseBxUbAcmLfQ8
         wSrP55PAEK9YSFjIGYSvor4kxTu8sZX6cDgcTy/45zXWEjT3SPUDWW5EzhzEYNB6WFEf
         XaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730791214; x=1731396014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XKAHJzWLr2y1XDNxG2SQATXhIhZvmlarF7yids5u93g=;
        b=SNszhn8dpdeJ5xg4ALhy4DuhNN/JjP5uGUep64QZeqw/vQnUWzMYtj9GpbCkuklIxC
         3ziX/b9ZhcKc5aZDHF30gqZNHOspssJ10cd4qvGwCXn4J3b4QD6OxCrYez/Q3pOEpFoW
         jk+/LW3s89cA4sQGnZFv+fo69fZXqWM/5nOBdQk5dfIUDq48sqMH8d/1Q4k7VoL3pJuU
         YkNAB1+EdmkkaY9wLwDJCqrLKI8lSvYc2qrdGYiM/hObvFbaYPfEN22VlsW09aQi6yyf
         LrMVboLv3EJZoLvevv01KApQKf68dI7hrtSIsW8vqC2TmMOFdQBUbzYO7GMpAeJKWHWB
         7sng==
X-Forwarded-Encrypted: i=1; AJvYcCVbi/hXMevIGhF+gSTWYF6OK4PpKfr6CDnKW7XqPopr8IhOXSm7+Fx+Bmo/yHE6jfmV8CdPyOyPx8YCTSFoFQWHwwpI@vger.kernel.org, AJvYcCXbxo8ki8TDRcKZiEMnt56/jYe8jYctZek9jI9/hkInvGYJmPin7vD30GP+2ktC9sSNGlOXD9LcZZH+x8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDTUspfNXpANynZp6PtPH4njFZhsz8af98q9vqfnMlEcvCp/Ip
	22pbFDOZXSYvx5/vF2bUOF0uBO630RDZ/e69FbL8I17Fz6mlEuTmYjpO6zMvRIs=
X-Google-Smtp-Source: AGHT+IGTyGQ6mhQVLXMHzHVEiazlptO3WM8T1w8o1cVcjbmhxQ1C3vsJUHmwA1HY2BlM5Hk+UpXn1g==
X-Received: by 2002:a17:902:d48b:b0:20e:5777:1b8d with SMTP id d9443c01a7336-21103ca7671mr275956815ad.57.1730791214547;
        Mon, 04 Nov 2024 23:20:14 -0800 (PST)
Received: from debian.resnet.ucla.edu (s-169-232-97-87.resnet.ucla.edu. [169.232.97.87])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-211057d3b18sm72468125ad.243.2024.11.04.23.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 23:20:14 -0800 (PST)
From: Daniel Yang <danielyangkang@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org (open list:TRACING),
	linux-trace-kernel@vger.kernel.org (open list:TRACING)
Cc: Daniel Yang <danielyangkang@gmail.com>
Subject: [PATCH] set_cmdline: replace fragile/deprecated strncpy with strscpy
Date: Mon,  4 Nov 2024 23:20:07 -0800
Message-Id: <20241105072007.426782-1-danielyangkang@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kernel docs identify strncpy as being fragile and ambiguous. Replaced
strncpy with strscpy so dest str is null terminated and not padded.

Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
---
 kernel/trace/trace_sched_switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
index 8a407adb0..573b5d8e8 100644
--- a/kernel/trace/trace_sched_switch.c
+++ b/kernel/trace/trace_sched_switch.c
@@ -187,7 +187,7 @@ static inline char *get_saved_cmdlines(int idx)
 
 static inline void set_cmdline(int idx, const char *cmdline)
 {
-	strncpy(get_saved_cmdlines(idx), cmdline, TASK_COMM_LEN);
+	strscpy(get_saved_cmdlines(idx), cmdline, TASK_COMM_LEN);
 }
 
 static void free_saved_cmdlines_buffer(struct saved_cmdlines_buffer *s)
-- 
2.39.2

