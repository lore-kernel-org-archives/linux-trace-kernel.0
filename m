Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B26A253B71;
	Tue, 29 Apr 2025 19:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745956285; cv=none; b=JJneZEMpdsrBYvpe1/O2icbBCAC763jV+lEoI/R77eQVfPknzitpB9pb/Eiohs4/Ev0ISosiY06oLBxVRYo+gqUOTygK7WlJLswCblzKP/7Bu2lPuM7fHRVI3ail1f8RO84iKcy6KUGNxr6L3zD3K2m8rtg7z8ELjl0RJvPSP9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745956285; c=relaxed/simple;
	bh=MQZ6hbGt//4FbhLB0Xm1vDwPqGiHpColuVWx2Z50Eqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HjB5KcreOf6kXvIAxz6NY7wYEhOr+hqUixgvEP7H5T8DDwI2MEZlFgNKGFJcuDMWtb1IFcDgeVrLphUzJebzut2XW2xXz+gMka2L0pX6t9oaygctItrYyaW5jIS/Ch2haEz+IDfGJCkz0Ar61k95X2Qeg+D17daj1QWbdpnMWOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rbg4QEmn; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rbg4QEmn"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2240b4de12bso94640835ad.2;
        Tue, 29 Apr 2025 12:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745956283; x=1746561083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RIDQIy8tP+iQrp+SJ899KKPpAiNauHHt2daVbB0nYIo=;
        b=Rbg4QEmniMKJFfPCkfUgV7GycGBv9qbWR27qMkvQXYJhoeim+IXVio1/8yKux6/7Mq
         G7prUH46xvsI9n2iUt7SiDSGPZevr4KQMWRRVhOosfidQiTtopc+UqvyYH42NG+kRxiU
         qHXmH0lnOv6uYZ6yc5QqrnGid4EIv7OKaifULXrEoWAyUmIAEXB3TWhXun5bFOwBMOHq
         CTlr9uyg/8i2KZtfgGDXxZ0y+ToHLllDtGV8F2xxTCpAQk936hc+EwTI2RACDDeU7EsM
         ZY/RjAnq9QJVcTSLXoG9LoMFG6RTkwrL/uZ9doxgif9cwV1NiHhX/KoQ9CDc91TqXnWL
         XOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745956283; x=1746561083;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RIDQIy8tP+iQrp+SJ899KKPpAiNauHHt2daVbB0nYIo=;
        b=F3mBHxggmqTJnx76r7MLLq8r/GT6LjZJ9NbrE9o/xwztLSUKzJ73OOSSuKHm2Zawep
         vXALLgygOl5SZleZoMYNMa2MsEUSEu/zSlx6knq9rpDBAXdAnt908Y9XxFuHLaK+D00O
         dNVVxw36PXEhMaOEy++s84dadpnXKc+tgM1o/ix7fEShpz+UL7f1CWB+ou2nSoKDV9WH
         slEs0GSwJuTn7OIW48i6iTlYiBblhFuLv2WsZ0OK4WuuHsGFCNxlI+4ns4zSQA73UAUN
         lsB1UK38kuK9HGDhbJdGMULQv5zoZRrB/HnvNDsB2VloWXg/WjERaLkrMP1X0wEffEUF
         7eSw==
X-Forwarded-Encrypted: i=1; AJvYcCWEL6kQ5L7Cr8ac1p7OK/24mpCIL5CH9WAYw+7fc+K2C4wa8M/hPC5VQfDstdYX+CpdaidSGOyy+kR+Qk8=@vger.kernel.org, AJvYcCXnhxf76fgFC4+D3MhwGnNeTi+dZZWgDUaU48YJZtp5NCRHWIYJccJRvdFQYH3gWKYUM8UpUyfwg5CPC2y3o8tKvYTH@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi81a/1s+TYC0OVGflkPHPGDucUswzfe73KrZgSnu7+//VJfzA
	UJl3TS2G+DH8Djy1emWHstoIuLXbO2WHBgbnEKo/C+RGgiSH7jgJ
X-Gm-Gg: ASbGncs2vw8LCEHYN6VahWXriCFLcNA9AlJNm2sQ4KMS/ba8SJGYORzz2gtNAvoAw7f
	QxewFYQM+Xoe3flQyIX4dahouYAdMHy6NuIJUyX7LhRP0cV4TB7EdN3StQ7v8hi+WdRx+p3Mekx
	jIQlJIHVozrbk7JLZyytQ40KeEINAJaA71c0y5cQtiOmUWM4lsJdu0afswarbF6XRAQsndVgz9o
	nVYs7RFYkuEgiBWn6F5doyLz4SIHDAV/nvbSPhY9Go4ufNPGlgfcV7j2I7j/yoyWq7qzrrfllPn
	hW/9EmNjWsxz1z9TvbIKGrhHDTiI0Bi4wATV4o4c
X-Google-Smtp-Source: AGHT+IHZjdqY7yZCz2uVIQvXAPfIe8Qulbzil3UiILhzk55Gk4SXFd+yDlV+kTzT8Qp05gkX7FKc4g==
X-Received: by 2002:a17:902:f785:b0:224:de2:7fd6 with SMTP id d9443c01a7336-22df34fc944mr8926045ad.25.1745956283367;
        Tue, 29 Apr 2025 12:51:23 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db50e7c1bsm107270045ad.107.2025.04.29.12.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 12:51:22 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>
Subject: [PATCH] tracing: cleanup upper_empty()
Date: Tue, 29 Apr 2025 15:51:18 -0400
Message-ID: <20250429195119.620204-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of find_first_bit() use the dedicated bitmap_empty(),
and make upper_empty() a nice one-liner.

While there, fix opencoded BITS_PER_TYPE().

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 kernel/trace/pid_list.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/pid_list.c b/kernel/trace/pid_list.c
index c62b9b3cfb3d..549c299530a4 100644
--- a/kernel/trace/pid_list.c
+++ b/kernel/trace/pid_list.c
@@ -81,13 +81,9 @@ static inline bool upper_empty(union upper_chunk *chunk)
 {
 	/*
 	 * If chunk->data has no lower chunks, it will be the same
-	 * as a zeroed bitmask. Use find_first_bit() to test it
-	 * and if it doesn't find any bits set, then the array
-	 * is empty.
+	 * as a zeroed bitmask.
 	 */
-	int bit = find_first_bit((unsigned long *)chunk->data,
-				 sizeof(chunk->data) * 8);
-	return bit >= sizeof(chunk->data) * 8;
+	return bitmap_empty((unsigned long *)chunk->data, BITS_PER_TYPE(chunk->data));
 }
 
 static inline int pid_split(unsigned int pid, unsigned int *upper1,
-- 
2.43.0

