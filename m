Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776B637C90F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Sep 2026 05:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789364094; cv=none; b=CIYt1zlC5Y5TPF9gl/FFQVRx27r0VfecBxoXwgavs1DYri1gFiv7SSMlZ5+PzygL6dMWj8b2hmxMYwxY+1WAUlmEwdFWalb55JZmQnBwT1DhSmdNorh2+T9I6yQNbRNKvtp1AjvoLTTvmPlpgcCf7R+ujq2+Cuo1vW7Onww6cwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789364094; c=relaxed/simple;
	bh=PyLYiRqolXNgZ1XljJ7WLyZ//aWMD1yUwpclJVxwOeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQ7EbY/qFcoJH2vcT6DkOV8F0+ITSF+fMA1rffrSMatAizr/d7W3RY9IhwZhJxAhh2J758MbhZG0JY0dS8O81p87gsvao3jvpLxMJk9uf1qaiRkbp8NXEAqbGgVPKppRH/paYitp04PIK1oSGkizfY2IESxJJceNzLQY/jGetLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JljD1vy4; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JljD1vy4"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2dd68a16955so3929485ad.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 13 Sep 2026 22:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789364093; x=1789968893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IASBcTda1NMxT7D2tV4KSLuvYAReFfZa/VfnrrcpJ3s=;
        b=JljD1vy4GYiILbjCLDti8CecUEBnNZneIEPxtJWJ2lsmqUgZPN45wlaUd4aaumYn1X
         yV2WBiGCM5xv+O9uh77hIUS3lAn6yK4I00tCw/0vEXdNN/rWOpXjZ6kP/OeAv1blp0r3
         UMoodZVZD6ILxYwUM6CHlqsubgnuhCjfjzbFb1a4vDacn+sXF/n8vbwJDMMh0tTlBYZm
         cljfrPq7HLZ2hSYSctGGjD8bixEPgGsK4NnNTgxNgSasEENx8gxEDqr19OpFZtnp7z9b
         m+xleQurKLzUQ+f9uMlyujAL5/OWOu6Dj5r27G8y3pX6rOVzTu4r+n4ydBzjKaNX3FRu
         vktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789364093; x=1789968893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IASBcTda1NMxT7D2tV4KSLuvYAReFfZa/VfnrrcpJ3s=;
        b=kO64HHWD803EDHuURV9RTwyro8U15CSrCx+BCObKvH9LbyMXe22L0a4tcZ24q2GDFd
         NaKhOkiwe5VMFh5qO+78rUxLzh8+kcImThZistLkkH8H8nfgYWZQ3mAsTd21/aSwW2uo
         ui8DvqOxN0Tnwj8MQHo9nVctAMU4AXheFG+VTL0RnNATHwNj7H6ol7hhd9bGgUlb5qqt
         w31niJBBuXdlGh+VpsRCkjAOiwcG9w8zTbIyMnLlEV0tofYVcFMF3+UXltMZWN1SG452
         RrtC6Q/ATQgJh7WUZPr+HwERDz+hbgrTezaOJhsot8VcKbeulZAmG/1AhPGoLXXhWwtr
         5V5w==
X-Forwarded-Encrypted: i=1; AKwUvBwcAMOvmVKV0XiUwNSOZZaxyfEPrb4HmeAa/UwSlEDfbpaYhZll7qxCU+27aGTTgVkaABO9zRk3qWFgBIJ9jrwyI8Q=@vger.kernel.org
X-Gm-Message-State: AFuF++lxp5aUUEQhugCuDDFcOQUbE1qDQyqcS1MOLXVdKXj4iEYSqRkP
	m+cZbJkTfQduL69ta13Xo4hYx4nWGA+PjPF6lzc7J2b7twhG/8E5x80=
X-Gm-Gg: AYBFou2KJTKiBzB3AA+YlXFqFPS7IfwX2gciWfiR5Isfy9Ku7kl5EgGaRRHAlTTEREm
	jRiaoUaOR+P0batBeHAF/l41FWRJVWLiTO/JLorGoWqGXxwroZ1t69iflndcDYKm8e/KZtV/KNb
	RizcUQfgGDxbhrngitYDPbGUcX/tScjmAmL2KoqKE1spX7Uu8p825wI9JPjGe4h0cbCw3BCPMNy
	XxTBR/r9hZ0WFuMpcah8cDr1CA1JWoBG8oONpE8UnITA8JOuRzPLKm8Mm9pXIfjQ7kaZuA+PdhA
	v5ADQd7n/GicOSYiVrQc+LsupY+aT50OxRXlKz6/+WbkP82KSxUwit4JTzNffh9KK6Bxgmg5pzC
	NOhHvs2IEzCSHl3Z9qHJpUBYyNAOlajvxfCXtiIH8WHZvhInidcCewZl/TqA11/lc4hsaVgXeRw
	MbF0ZSkqPl4/cOYjKKoOLyXpGUcF47NTddS2uCnkRqrQQCZrfUTF6L7jDooDacpY2XHIBktingj
	JN9jkPfgJsXGjfif+urRqEjnIE=
X-Received: by 2002:a17:90b:1f8a:b0:398:9beb:a2b6 with SMTP id 98e67ed59e1d1-39dd56bf8d7mr6649571a91.24.1789364092787;
        Sun, 13 Sep 2026 22:34:52 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:3b80:bc61:4619:5346])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d994872e0sm19009261a91.8.2026.09.13.22.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 22:34:52 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Subject: [PATCH v3 1/4] tracing: Print the bucket size as unsigned
Date: Mon, 14 Sep 2026 14:34:40 +0900
Message-ID: <20260914053443.981201-2-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914053443.981201-1-donggeunyoo.kernel@gmail.com>
References: <20260914053443.981201-1-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A key's bucket size reads back negative once it exceeds LONG_MAX:

  # echo 'hist:keys=next_pid.buckets=18446744073709551615' > trigger
  # cat trigger
  hist:keys=next_pid.buckets=-1:vals=hitcount:...

parse_field() takes the size with kstrtoul() and rejects only zero, so the
whole unsigned long range is accepted and stored, but hist_field_print()
renders it with %ld.

Print it with %lu.

Fixes: de9a48a360b7 ("tracing: Add linear buckets to histogram logic")
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Assisted-by: Claude:claude-fable-5
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 8af97fd4ee2d..a3eae5c1344a 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6200,7 +6200,7 @@ static void hist_field_print(struct seq_file *m, struct hist_field *hist_field)
 		}
 	}
 	if (hist_field->buckets)
-		seq_printf(m, "=%ld", hist_field->buckets);
+		seq_printf(m, "=%lu", hist_field->buckets);
 }
 
 static int event_hist_trigger_print(struct seq_file *m,
-- 
2.53.0

