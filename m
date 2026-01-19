Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D45027E07E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 11:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768823150; cv=none; b=PKUISA18jswh3EeI8X7SwRMmoPeoWD9Ge7J1kSwWi+jV/fNMbUW81H2sVOfAZxnex85G8NNxWGOdcR1MuMkh1tyi6FBmtKVsZu1oBRqvf0ikSsBesMmqUsGIz0FVGAQFFw88Fxm7J+AHgvreHWxd5SHS+Rj5kZley6o0oS6+ixw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768823150; c=relaxed/simple;
	bh=MdxPX5vDGx8RVZ3ew+j6WVs+YpCVDTtm7KRBwWIvH8A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nfR1W2fYk8TrJ9dAnH/etT6XGgO2VtMCwx69jqyXLgGCdXVCXq3ZirFjKYpTA1QIXP4yiJx1/hYuxCg9VsMGJTiL6NGkPtIJxxCWiXi2823C8nYiPE3IqwXXs8vw/riH1JPYXYnxhOts+/lNdwtXfMiO4l43hIr+MHrQQJwIvUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qzvn8v+F; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qzvn8v+F"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-81dab89f286so1965088b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 03:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768823149; x=1769427949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ywd+1igsU00ra/a+wq9SjR4y0NT8aUrg5BsV8nmKV+A=;
        b=Qzvn8v+FYvfKKRcDP3Vl+wxt3lLtFGSYX04zX6IyfIn4ecpU9GN4xGabbkC0JCcyA6
         zgKLiuiwqCsGb4qFkXmF2GoWmHYEBfRNQwxM8xdiLQObWbuDqWr0dnBDp7XyZWu8cpwq
         4gPAGAJ7WjHZfj7iGyyJI2iccv1+nslLiKQAHw+w792kcecM8kIibON0RmfkfKgZ1Zo7
         Wc9I8wvLXzsiSyi1yV9mcgEeq8rvUWWALlMds5wsgS5FzuOjLplG7PUkyvOgc2imBR+Q
         JhqAKhV8NDCpbw8/Tt7fv+Rd0C9AV73d6N678lOQBMtO7NnWG51dQZumWBngTXP5YZAd
         Am0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768823149; x=1769427949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ywd+1igsU00ra/a+wq9SjR4y0NT8aUrg5BsV8nmKV+A=;
        b=E8YwoDXdQCm5mWQRv7iQOLqBj5qirDU1qhMBJJQGy3/ej/ode41ZSxaPZToaJrEBHg
         YWDISGXY28eV9bEQIqtzlkN609hNOgS/9NeOQDrUwjbK2+1Lqdjnk9+6WFa80uMI+x78
         mQmAp7IIUFEaROFb6x+oWyX0UCrx1mim/tXcxcLIKFvX31V7hMgDHIKrxbRKIggLrecr
         NHD08j1HxrhhqWYBM4erNu33bJxDwhVzRPmdyyyLC81kkk/5wuXxZw1MrlymbaJ4J9P3
         Jfi04xkmWL0OAC3owLEJtuHVbjgQzNeA1/Ju3Nd++wvGySzE1IEYKpUv3lagyTaODJpO
         tEGg==
X-Forwarded-Encrypted: i=1; AJvYcCUlI9vBoJq+GGCMmy7jZ87i30HeB0dShN+ubXjsS5a2cXvoxqp35WD39qTOv2EtqLWcRdcQLX9kj1a6LL8QrBz7ahw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFEwFgXOf1V/lRCUmvmcp7XkOv0Yb3VcyV4xoyzKJE4FPM9akX
	3M23A2lsQYWZWNG//iKySHLh5Bft02tEH+5+znxz+ou88L00SBnqW1j3Egrn0A==
X-Gm-Gg: AY/fxX5mpza4Rfn9gwKkLpfwSLQkOdkZ+uBri/ivHgqWQSCzjKU7vCW6i3LZLpP0hdA
	//4yxlz6M0YY9W3PEIeoot0qYGwFFPusQ/zGlmdvFVlKLksZz274HoqrrnVuyB73tOm8MOPDVSa
	+r31z9PoxucZDS6nB7OMDKxYM+oBXwxmwyDIL+RyiT+lHdz+PkjK+/K1VxwWjcvLzCFAE8APi4y
	iMSf0CIlXI/N12aOsSqHacpr3lbN1JkTcTDqpI7Qn6s2HC84AL256AstmMbAlbHmfiG0Ke59inF
	BS/7j+MjTS56JlVIrndEaJUM5KweLTw6D6Hqo96HuWxIxQfwDZ9K7BpvwHaxNUyCLF4Eph+XNmn
	P2wyLWdzV4kL4NqIAAvsmahdOmJs0VazRP94nu6+FJwc3tfSUY4MPLRaKzrM8Y8J5vzgSRs1g2f
	MOF9ifW9R7qS5XPGNC23llPKeKz7QPUurJvGHoC3pAzAnesTQ7s0Dp+u8MVjViI+KXaNdyfzXbm
	Pz2WZ8jyArKpVoUCLu/vlefG4F3sRbVucxq3wUPwQna/6s=
X-Received: by 2002:a05:6a00:3395:b0:81f:3ed8:fd29 with SMTP id d2e1a72fcca58-81fa01ec37bmr10340752b3a.36.1768823148672;
        Mon, 19 Jan 2026 03:45:48 -0800 (PST)
Received: from c8971f1abf06.ap-southeast-2.compute.internal (ec2-54-252-206-51.ap-southeast-2.compute.amazonaws.com. [54.252.206.51])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa108b252sm9127160b3a.7.2026.01.19.03.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 03:45:48 -0800 (PST)
From: Weigang He <geoffreyhe2@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Weigang He <geoffreyhe2@gmail.com>
Subject: [PATCH v2] scripts/tracepoint-update: fix memory leak in add_string() on failure
Date: Mon, 19 Jan 2026 11:45:42 +0000
Message-Id: <20260119114542.1714405-1-geoffreyhe2@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When realloc() fails in add_string(), the function returns -1 but leaves
*vals pointing to the previously allocated memory. This can cause memory
leaks in callers like make_trace_array() that return on error without
freeing the partially built array.

Fix this by freeing *vals and setting it to NULL when realloc() fails.
This makes the error handling self-contained in add_string() so callers
don't need to handle cleanup on failure.

This bug is found by my static analysis tool and my code review.

Signed-off-by: Weigang He <geoffreyhe2@gmail.com>
---
 scripts/tracepoint-update.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/tracepoint-update.c b/scripts/tracepoint-update.c
index 90046aedc97b9..5cf43c0aac891 100644
--- a/scripts/tracepoint-update.c
+++ b/scripts/tracepoint-update.c
@@ -49,6 +49,8 @@ static int add_string(const char *str, const char ***vals, int *count)
 		array = realloc(array, sizeof(char *) * size);
 		if (!array) {
 			fprintf(stderr, "Failed memory allocation\n");
+			free(*vals);
+			*vals = NULL;
 			return -1;
 		}
 		*vals = array;
-- 
2.34.1

