Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5A01F4C89;
	Tue, 22 Apr 2025 22:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745360026; cv=none; b=lJwbTthOkkbiMocCnR7cK2kyW0fNJt0jkMjacoG/vzcH9Z86ASJ+lbjhvP5iOY01caAZ4In4ds7ftrePLhqeDvGh53i6rK6qUfx+IvqD1bjic/I9ljR6icqPH8+DJpTbcKG3gV+fABz2Kvd2sVDjUtKIbiYGZCarnzGJO0qeV04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745360026; c=relaxed/simple;
	bh=2obRGwXlBRysm8AbFOXoZVE94f6Ml0lcT+OEatZK84U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sDaoxybj1zKQV6fkyApWCeTDNoIyywKtG1PCIyjEJtB2N/VF1Mqibimg7yQaTQODO5u4xj78GEIz3FJCn7NLjQLBuldvcKoTPBmcnHLowE5mQI52nG8WN6NSzvRnodnTZC4gIZ8sSVpt3V+cMmBkv/PWzzdPWZCOqg8LYeXn3Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mpl6YTk2; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mpl6YTk2"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39c14016868so5720062f8f.1;
        Tue, 22 Apr 2025 15:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745360023; x=1745964823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iwTLs8vyjaixVoEy0LGRFn0VHa9cgDvSb9/8SZSpeMw=;
        b=Mpl6YTk2pg4Vn5ZO7hE7Yv68o+juiXYZfXO8+/JI+xI+8hsQ+J8Sy3wE1wG1BJn1HE
         nOQLuRlAeotBX1YRz90V09aU4HuVpxAClAzJI3/DrGRFM40Gggi89LYxI6MqTtFY1pic
         CvzIkJ9SSbDu96rcLRkXucx8FEpJPlFNVjPWPm7G0wVXNjE3ADZZhBX4/9A5I+q0+EwX
         ck1KLb76tE6w6CgIy023rceU3SVqW3+GCZv3FwUAMBl4oP0tleK74U/CwI23ue89ey25
         pYsRQrCcm7n31Hhi8aCxKbW7LIuvBO+knGKogemjtNZaTXJzcnUCbLLLYHVvrec0kqi/
         L/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745360023; x=1745964823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iwTLs8vyjaixVoEy0LGRFn0VHa9cgDvSb9/8SZSpeMw=;
        b=e7rl0cNGb8RhSvlSC1tEd56rnCCZR1BnFWuAfeossuGK4l52pB41ddtJBdQ/bvFb9P
         i6gg5of3Fh9GJZm3nwPcYh98orHZdxYKB0A1y+8TaER0ZqFLGwqugXeGgroyFaLlBtjY
         DW18cBQ5kYv2qWEsMYR8zzvuSOPHF8j4vRrBUq3xeQCRWOcf3UhsKAf9yTe31w/0Ekcr
         oOr5wgkjNBn20y3L+u+XgQhF3JjBCc5UnRXYeBm/O6qNb3GdRX5UGwKSGyXUPRdi/rNu
         7A2xUWY3TikMUXYgmAZ9CC5yJLMsjGg2sd7/7Imp441AE2gIwG9YtlFFH4cZQHwc6Da+
         ydIA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ+cKPSJCzPPPqOHSKDh2H09VNZbGevNXX5mK4P/oLiC/a1xb1aJnQ/6hKS93k7jQ8wD3QTCNHKXuM7ZaHWTPbcuIn@vger.kernel.org, AJvYcCX1SqKljIblU907l6p2F7QFcKwpplIl5rZ79/bBwJCx1QCKIs2iFbZWGQ/+F72HTr4LyEO6nLM1y6HS1mQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YztL8bhCsYyF2imrV+sgXX8fxvjij+hRjYgP1FDaes0F8+VpVt4
	KZ0nRriHcU8Do65TxWFN67PWieUWGBqe7H3l5Blu4ItIMLoJEIdY
X-Gm-Gg: ASbGncuVJWRlN+tLbmpXO9zZau76497r97rYpEJJiNohlTcawSrOEqbXki/GqXDRlro
	4LXiolmvIPMYVa4V9YrTTq1yT7gWoT6FSdF34AIll3T/fzPREZyRtuP3ASBqVJcxH38ObZQQsUo
	mpXQA/TXz1oA1FWcwH4dDY0HhjW96r+CTutJVODrnMsxFZdui6yj9A3sqne0yhqbtvBmoxzBi7l
	shYq1+b+ann9d0YRiBH25z4T7pywa5s/ttFvjm7PAEYnHpOeyRD0pKNzs6ijQFrKfX29atlOogo
	uq4uzu2dr6VK4l0jz/CECfLpIAGixOg/qKeb57SJ7w==
X-Google-Smtp-Source: AGHT+IH5ULUWPnGyzZaHR77dCGEg5eVgzbcwRGCPylIqEYuZnUp99wTWpNNkTECMJ238M4dGfJjdfA==
X-Received: by 2002:a05:6000:4903:b0:39c:1257:cd41 with SMTP id ffacd0b85a97d-39efbb1a9e3mr15222553f8f.59.1745360022636;
        Tue, 22 Apr 2025 15:13:42 -0700 (PDT)
Received: from localhost ([194.120.133.58])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-44092d16ca2sm3239815e9.8.2025.04.22.15.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 15:13:42 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	asami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ftrace: Fix null memory allocation check
Date: Tue, 22 Apr 2025 23:13:35 +0100
Message-ID: <20250422221335.89896-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The check for a failed memory location is incorrectly checking
the wrong level of pointer indirection by checking !filter_hash
rather than !*filter_hash.  Fix this.

Fixes: 0ae6b8ce200d ("ftrace: Fix accounting of subop hashes")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 kernel/trace/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 61130bb34d6c..6981830c3128 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3436,7 +3436,7 @@ static int add_next_hash(struct ftrace_hash **filter_hash, struct ftrace_hash **
 
 		/* Copy the subops hash */
 		*filter_hash = alloc_and_copy_ftrace_hash(size_bits, subops_hash->filter_hash);
-		if (!filter_hash)
+		if (!*filter_hash)
 			return -ENOMEM;
 		/* Remove any notrace functions from the copy */
 		remove_hash(*filter_hash, subops_hash->notrace_hash);
-- 
2.49.0

