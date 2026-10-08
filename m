Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CBC397691
	for <linux-trace-kernel@vger.kernel.org>; Thu,  8 Oct 2026 16:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791477688; cv=none; b=FnSe/SQnZiCzai6w8IbBhjFaCfnVzqIEPkBJAS2ZJo55fAP8MlSt+bKqzAqBQeGBL1wRj+NCISWghSmtlETBQUlt6z81Th0zGpYuohrhQDlLcmwZvkUHpy1SFM1vAUQ5ga5OVn7EiaPMZkM67x0+Hy14KHxQxhstX3TTnfK+CGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791477688; c=relaxed/simple;
	bh=HBh16VW8/lHAFmRTJaInOGmIL35BcI7Q3Wis0Frt2Is=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YnQtbzWwh8gRDlMdZXwM1JuV7KyAurbMBtWR5/HPYeVloztcQSvYU15nKcNLAiDejhwfYdJx/4l4DqZ+85jMNMwn5v+J6uqtYxkb4yY4Z1rPIwOyS27nqYxrIHNXBjEN77j4/nauXH51umMagCRgLKadKstf9jMqpK23rZj33mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XokWZy/7; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XokWZy/7"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4af173320f9so3050381b6e.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 08 Oct 2026 09:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791477686; x=1792082486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lkLLpJNGORGXxC7hkGQnF64CfJaOXfvTgZluzK41nQo=;
        b=XokWZy/7QPE7dd9xspIP9V1ypEhPT5dENRP0SlzXCOPp0BSMpLWHs5TlI3Vph2tABJ
         xorJz+Gc7JOQV0fz+uf9Uv1o/XOct/eyu5oDUMarqmTxHeYN0I+sgKFKb7hZv2zdRfCS
         vfudubPOzvzdEprV+KutaO5IRjIg2ooQyOj21er5zHHb8FPHmjJyfXv+9KLg/oes2U5n
         hp57YrKuV1SeFLE6WkvtvJW1i9zdLgH/ge4kzKhc6myzqnX4TKcLDTkY5FNxi41a1nBd
         qMcXK9WNRAL8HqKiRxtYn5tw1ieiM0o0xDeT6Nsnc/4S2Bh22freJCncpzT/ACxP16VI
         oy1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791477686; x=1792082486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lkLLpJNGORGXxC7hkGQnF64CfJaOXfvTgZluzK41nQo=;
        b=uNVlhA4Tla9FmekPbitqC63bKUCq2xLdEKcMiOzj8mN6U1BUX5iG8vCjJuKL5hjR2x
         rCZSicqJ6a8ryUrtm5Qmqrvdo23wdH88dmR4Y3kQwsEOsSiOcUy5gHTx0IiMSGf6C2G3
         Xu9WxGFzvAxwgvzZp9iEU0+CzPCKDn2lNR2+jmteprnkALm9pUGVNdxAeSlp/15ekpFF
         J1QRKMs5+W8qoKpohXFAgq3LajUyrpmcAn/ne2DgOp7haZuueiE7BgDD6sUVElHatx5D
         4l2waTSAOIxkpHSg87KpSQCr/3UIjEdFYs9NrqKMU2lxEK8NKHlGfYV3ETJTpKqXAdxn
         dooQ==
X-Gm-Message-State: AFuF++n3/O6cUJKu7g5Bv5xNRi+js8d0afJJ+HuA8q7gX+TOdoRBS1qL
	p4BeLA5Xlyy0YQ87aShC1/81oHSKoFSEDVD8ltgM2Z3inRYTLQd7Zr+m
X-Gm-Gg: AYBFou1OBA3ZgBs82WJGcPvNzEo1K+lh8V5ufoYxj16WqmVOInp4E2aI/0q14FV9208
	xZ9uQd19OfZ9/eeJEhXXEM/CAzMmdmLLg1iBinvzmXBBPwSWStH8oiLkwAlkH0cmJKw4WSGy6D5
	bc/plVK8PX/kZGyehEYZQ45tWBboWebPTyhWFQl7E3bEtzJYH8ow9d0wD04lmaSDGtSCj7O7OJd
	EaPui16uXszogUzD09WslNnlc3a229wqBQezIKrIuUr8v5R9MdsEhw9HE6V2y1BYWVkpVfU3jrR
	IEVYqojmM69UZ5mlX3vHKYyrf2HXMP6xWFm/Y3q7+evgKn3bRONF0ozkBGe+Hjh2rHdGcVVjy0N
	lyJQBGlWQpqnJPZjJbVTj73z9JnUoiSLDaGq9rDGcEy1JE2tqS5HKeGpaosxKvHyizTUVnwdnpE
	r/YIqO74hk4w6l/ANSxNRN1Yo00Ot4+CWW09QrF2172BaDxCL69F7JpXNBCACXNUtdMhZopBjTE
	VtI7Bxwk/svUJVjAFrvVPA=
X-Received: by 2002:a05:6808:1927:b0:4f6:1e12:e37d with SMTP id 5614622812f47-4fc46f93365mr6574978b6e.63.1791477685995;
        Thu, 08 Oct 2026 09:41:25 -0700 (PDT)
Received: from sheng2080.cmix.louisiana.edu ([130.70.15.5])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4fc48e3de37sm6249298b6e.9.2026.10.08.09.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 09:41:24 -0700 (PDT)
From: Leizhen Zhang <lzsx618@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] tracepoint-update: do not reuse section pointers from a previous file
Date: Thu,  8 Oct 2026 11:41:16 -0500
Message-Id: <20261008164117.3670267-1-lzsx618@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_data_sec and tracepoint_data_sec are static and set while scanning
the section headers in process_tracepoints(), but are never reset. When
tracepoint-update is given several files and a later file lacks these
sections, the pointers from the previous, already unmapped file are
used, which crashes:

  $ scripts/tracepoint-update --module a.o c.o
  AddressSanitizer: SEGV ...

Reset both pointers at the start of process_tracepoints().

Kbuild currently passes a single file per invocation, so this does not
affect normal builds.

Fixes: e30f8e61e251 ("tracing: Add a tracepoint verification check at build time")
Assisted-by: Claude:claude-opus-5-5 ASan UBSan
Signed-off-by: Leizhen Zhang <lzsx618@gmail.com>
---
v2:
 - Use my real name in the From and Signed-off-by lines. No code
   changes.

v1: https://lore.kernel.org/r/20261005104200.1787946-1-lzsx618@gmail.com

 scripts/tracepoint-update.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/tracepoint-update.c b/scripts/tracepoint-update.c
index 5cf43c0aac..4c4b669011 100644
--- a/scripts/tracepoint-update.c
+++ b/scripts/tracepoint-update.c
@@ -163,6 +163,10 @@ static int process_tracepoints(bool mod, void *addr, const char *fname)
 	int idx;
 	int done = 2;
 
+	/* Do not use the sections of a previously processed file */
+	check_data_sec = NULL;
+	tracepoint_data_sec = NULL;
+
 	shdr_start = (Elf_Shdr *)((char *)ehdr + ehdr_shoff(ehdr));
 	shentsize = ehdr_shentsize(ehdr);
 
-- 
2.34.1

