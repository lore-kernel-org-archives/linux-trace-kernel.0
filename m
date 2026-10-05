Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DD547986D
	for <linux-trace-kernel@vger.kernel.org>; Mon,  5 Oct 2026 10:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791196935; cv=none; b=QN8cQTplJKqqdSTFru/hekvw70N0spopHkHAg9AVfs0rh8YC8lHurv3a0sjG5+0uGaR1Qt6gR2XRKft67meIp67yfZoyhg3LrdWBXUwiFXpY8UJaNwvBi2NP/jkEWKbjcXPRA0Oypa/XO4N3C8Xb3YLj7gs7KATfYXtGoaxUQog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791196935; c=relaxed/simple;
	bh=+c5COAnNFvbEoUdyXXW3nbaU/kfXy7h+IIzi6jvXZyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MGONNo5+DtP788VnPKnMzFaq9RcLPqzRSh2OsuuDCxviBn6V4CKHROWeTItOUDh/+Op3ZoOkn8Xb4mVEKvqrGop6JTkSg185XT7CA06atnc6/NcHjvm2Kj523vV78Xw+a9I/DGXYfmW9rOLGsrDUDOjZoXM3uZjr0APQz5Dx0os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QajWOpzN; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QajWOpzN"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4e4a4d77e5bso945876b6e.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 05 Oct 2026 03:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791196931; x=1791801731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8W0+fYbRDHfh9L0kglCj5tuLWYsPG45RuqeUrhtLXE0=;
        b=QajWOpzNeAsU4LXlltRo5ehIyMkgRGzpBfGhR32f5gIXaQs31SJF2POdexuVJPdpWe
         RT8SJMh8ybj0Lrd1oOpeBA7hP+df3kFFqIkHcSS5/KiUkCqfo1pEXG9BEsVcvHBj7Htf
         vDcKTn5sgaLe2Z5QBIJIMa8w3PK/rwp3bVsaTdFpsg5lLbzvRqc/gcfzjI9VEO2RNGT1
         NwzF0JkEMPXIOTixFfswKs3+z2Ypsdn9prXNFsITzcokV3ofFf1pGCMzji3/RFVC/Bxq
         LeXzRpHw5xwtB9z7+7/560aSi6BV0O5ZV82sOLHtRvpGG+lalocfmbhdM9KGdq5K16Qh
         XJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791196931; x=1791801731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8W0+fYbRDHfh9L0kglCj5tuLWYsPG45RuqeUrhtLXE0=;
        b=eb/z5hHl7AiBBVyecWKWZ7+E4sA/2e3YLN34X768dJrrE0IkhhiG0MxpdJflZHQJzO
         FVDhMG3TZPOWJoOujcVPMhs9uaUx4jLnaOV31XNVndBXbKUxXeRJcxX42aDAb1x6ZOtn
         nzEiI0h2Nde0Hc4Yu2IGoC4aT9IBSMXx/+EZNB8Hu+36aGqCaGl3rh2p9107cGxQu1Q8
         HQoF4Lq4QiD05xuqMIb1Q4htzuQnqzZSSrVOrOtzSFqzqruC1MapmHRI0PuLxEH5VWhC
         QbFMu5+Wpk/BM1V4GyxeoN9cMppPDtgOfibsbkWhRtt0jmfBIxWwHtLAN3tdOIuvddCr
         bkKQ==
X-Gm-Message-State: AFuF++nqVefyFeriuRe9e2v6awMlarXkmIFXta8/mrfg2pl0zteNrNIn
	CfbsF4dcUybsau7tvspD9KG/WbAKMBOzIIw5EmucJt58CLPhtmBMmX7j
X-Gm-Gg: AYBFou1/jpmLlYVFVPsazuzbzz3VJg0GiXIXl0Q6vrhRsOdWnjMQK7S2O6uXFjQUT0b
	V1Sl+ehmP+lQxYgIsXEim2zyvy/j957VtlnsQ1+1hsGsm5VLNk+gg15FRfX0O/KdWhkFXcdiN7a
	NcyVEz6npiHfu84GstyL+t4cEeGoMIbuuYH9+NoSI9gxucCqbiHogZzFvJixzzjLE/OUaAi/W+p
	mpztAgKfR4OWRobTWFC1PeJMKsgKnyt6A7y+t5KNBYsh/8/bIBAC6/I+T08GoJxQpWm9ELPzWGs
	c0PS7pl9kZw9toIcwYinO8bCq2J6VGtfLWdSNREdhZxqBr4KT/2wHSJsTRyDRte3wsnplfl0hgQ
	Q8yHXV2z7/VafwxXpQu5Z+M7jiQiJXJQcYws84oX+2zMMZ3AhlQt11ewkrkek4+WC9dfNhfGJVD
	F/x7ftNnTZtTvkJe/GL9TQ0Ob3Ip29tXMCnqqjV+PY7CCUp8lGj5UNmWRipjqbDkLcr4dTluAMO
	nDtLuShDi8R
X-Received: by 2002:a05:6808:2203:b0:4ca:9850:4dd8 with SMTP id 5614622812f47-4f3080f790dmr10412563b6e.10.1791196931437;
        Mon, 05 Oct 2026 03:42:11 -0700 (PDT)
Received: from sheng2080.cmix.louisiana.edu ([130.70.15.5])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4f5249d7c75sm9588989b6e.12.2026.10.05.03.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 03:42:10 -0700 (PDT)
From: lzhan011 <lzsx618@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] tracepoint-update: check the section end before reading a string
Date: Mon,  5 Oct 2026 05:42:00 -0500
Message-Id: <20261005104200.1787946-2-lzsx618@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261005104200.1787946-1-lzsx618@gmail.com>
References: <20261005104200.1787946-1-lzsx618@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: lzhan011 <zhangleizhen645@gmail.com>

for_each_shdr_str() evaluates strlen(str) before checking str < end, so
after the last string of the section it calls strlen() on the bytes just
past the section. Check the bound first.

Fixes: e30f8e61e251 ("tracing: Add a tracepoint verification check at build time")
Assisted-by: Claude:claude-opus-5-5 ASan
Signed-off-by: lzhan011 <zhangleizhen645@gmail.com>
---
 scripts/tracepoint-update.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/tracepoint-update.c b/scripts/tracepoint-update.c
index 4c4b66901..ad5f691c1 100644
--- a/scripts/tracepoint-update.c
+++ b/scripts/tracepoint-update.c
@@ -74,7 +74,7 @@ static int add_string(const char *str, const char ***vals, int *count)
 #define for_each_shdr_str(len, ehdr, sec)				\
 	for (const char *str = (void *)(ehdr) + shdr_offset(sec),	\
 			*end = str + shdr_size(sec);			\
-	     len = strlen(str), str < end;				\
+	     str < end && (len = strlen(str), true);			\
 	     str += (len) + 1)
 
 
-- 
2.34.1

