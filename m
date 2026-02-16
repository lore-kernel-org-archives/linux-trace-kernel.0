Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB26530E834
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Feb 2026 13:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771249393; cv=none; b=FjSSWqUzRw5PJgyu8XAs1rNiHHbYYEAogfWlfZ5wlIbVAMz4WhbHOGPhqJKWUIcmQEJ5rxLcAWVZ+Zcox2z9MXhoZeayKIHkyepw+LkhC2/lTzFWxQJ4+0DoV/5PzI9/5aRnbk+7Banf9LbyuM2scrjnRFWWdiqgFu5kc7oMzE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771249393; c=relaxed/simple;
	bh=KJwpMUhbsmLePIcgVFzyOrsUa+2IV8OxHWYQmxoWDOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3/wp0OarNCJGJVUp7uvh5oubswZ3ceC8F1a5OyQwfIPq4vNivr3DZvUXUwbYJ2TcfBs95+aTxP6bhuc3IjIHrSwdHCJBvz6/Tk9K0DNbqpssepoDw9GRofrSiDs5nQZPTeWcNdSTeopCiXd80g6Eo9qUgLHFwsUwU2xaTzNp0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QOpxNdVb; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QOpxNdVb"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-437711e9195so2222828f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Feb 2026 05:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771249390; x=1771854190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JPwPVqvwveog74YxYE5rN1bA4FdwdVXGOb+2Uf2Xb8=;
        b=QOpxNdVbj8MxSnNobKMQ/91aGC1Z0kuk6juLfzjxbJQ7jq15zRmXvvsOz9t66SdBmM
         QfY81C4qUMiL1sI9vb6Dpr7izIrdMfWv+u7UJVqvdyyXgUxsTQICT8JsPKuXVDuekXUT
         xZUS/RcHm9Ok0fRpqL+XwBxe6Pme/iy6BZ3hrH6m4SwJnzmZhXFarQJ1tc7zcaV2mACV
         8NXXGt5TBYlR2zaqnVG1bkTTjYXWwXa6x1aowAJc0gVgGXatKRiDir5ogQYe1hK6aY+a
         5/Ry2YAk8fMR6vtS1Fm2JTgDPBR+hr8uuRjP3CLE0IHyn78LdfRw6T60QSfZgLAWMh43
         NN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771249390; x=1771854190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1JPwPVqvwveog74YxYE5rN1bA4FdwdVXGOb+2Uf2Xb8=;
        b=uYf7zIEOR0Mu5RjgAyqkK3dCpAJM7x9qJDs5XSGD7zPsPzQC6KXKUGiSsWGJK2tHjW
         212NUezd9onZJdDWmiCZoetv/vhr275z3J7YFlgpdp/K9bKC/sfQ9GweOUrykCidpvJC
         hX9b6tth+AKCSR470gR7sTAledSb/Y9lsVzSUTg7KT6pFgKklNO0ZxiYR0s3cKoMHxV0
         R45XBMAdksC8tx+baa1ztzaqv2eLbw8HuhLjww2OGHWtTXW8N9vNXI7hwLIIxyPjzoPr
         fAyGaYGpG8wlCGkBh7D1cvUpGWBbzclnwQwTHW21G92kL3NNzdZYN0AlQaE/QJLQ1mUH
         snKw==
X-Forwarded-Encrypted: i=1; AJvYcCUyo10eCP71mWuUIzGYmXNIe8nHgmQIaio6T/ncCj6kbBDC1dCAMiMPywQPQhKriv2/YJSXz8gy4jT1+6Dm0L8zW2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFzlOuEHj1kPJqS6HhkTNqbMQjPeI+h0YOqp9681UlZTus30cU
	V+GA6KeoBsX6EWEW1Ad1o0Q0MYysW4Wezwug+wFfShkAVc89+3Fjti1yhaFqpGcDmgM=
X-Gm-Gg: AZuq6aL7NIKZefQAQXeUIjwovb64w5bsYvPSYyh8gjQ72Ls8AkdNZ8WfUbV5SdVC+jC
	sXN3c9Zo1DooJyUiunvmyS5K0guz9+dV24H32Tq6MuZglpDOUAdWj6Zs/Bx3SRv8lq08qW71907
	TYs9llT14YV/+wRTRDrVA61wwMMoHExxTd4dUCJbGoYvFZLGanJ1Eo3v5Uc3ZRbSjY+GgDBYErk
	31/9P4qX4OtxXHu3wGank3lM04bNb2c4ze6Y/H5J+eQwgmYQ4B43z6BxUg1vEeFMBIwFXTRcA1J
	4mdD40z7B3NX+bwviPC7symRbXo2YUPu5mg/duIr3oy1Lq778euSBlgoFL7FYkgWF9xTsWOo3Tk
	o/st9p4BYdYt6PC7ec1gUOBVKjvyt55k72kLxhygB5+4qufj7eWVpTbe+c8fwfbB4CvHVdGSq3n
	p3sXi9cm31Xf7FXeO5Q9/dNo7/mdvxjwU9eaDNhrF9
X-Received: by 2002:a05:6000:2382:b0:437:719d:a740 with SMTP id ffacd0b85a97d-43796af9f04mr18671659f8f.49.1771249390407;
        Mon, 16 Feb 2026 05:43:10 -0800 (PST)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a6ba57sm22103738f8f.15.2026.02.16.05.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 05:43:10 -0800 (PST)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH v2 2/4] tracing: Remove unnecessary check for EVENT_FILE_FL_FREED
Date: Mon, 16 Feb 2026 14:41:58 +0100
Message-ID: <20260216134247.1311631-3-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260216134247.1311631-1-petr.pavlu@suse.com>
References: <20260216134247.1311631-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The event_filter_write() function calls event_file_file() to retrieve
a trace_event_file associated with a given file struct. If a non-NULL
pointer is returned, the function then checks whether the trace_event_file
instance has the EVENT_FILE_FL_FREED flag set. This check is redundant
because event_file_file() already performs this validation and returns NULL
if the flag is set. The err value is also already initialized to -ENODEV.

Remove the unnecessary check for EVENT_FILE_FL_FREED in
event_filter_write().

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/trace/trace_events.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index e8ed6ba155cf..2ca76b048638 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2153,12 +2153,8 @@ event_filter_write(struct file *filp, const char __user *ubuf, size_t cnt,
 
 	mutex_lock(&event_mutex);
 	file = event_file_file(filp);
-	if (file) {
-		if (file->flags & EVENT_FILE_FL_FREED)
-			err = -ENODEV;
-		else
-			err = apply_event_filter(file, buf);
-	}
+	if (file)
+		err = apply_event_filter(file, buf);
 	mutex_unlock(&event_mutex);
 
 	kfree(buf);
-- 
2.52.0

