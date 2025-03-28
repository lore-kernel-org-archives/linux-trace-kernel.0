Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060521E1A3F
	for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Mar 2025 18:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743187161; cv=none; b=e0Ok3Uva6VC/EGEsHUnLKAOI4qPynHwK12hcQE9SBwSF1bNXO3SZvF5o1oPb3lGQ8jduI5TqKOUQQDRkaDTdm3gUG1sotXeAie2uY6Ed4u2iBHVq1fwNMD2oYVAT+mtKLRwuwANDjn3lMZSTjETrmQed0KMIBMi2z5tj0SSxROU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743187161; c=relaxed/simple;
	bh=SjUd/DHv6IJbZYAKa4kbQGHpPKnU7bcD2xgafz1puzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=fbwacAbBg902USegITBJtCgFoyPcbCjHr4h1d73w2QSEfjKK9xzT+jDDyzyKCQMzU5nFFHNphAL+GD734Q4QuibCSNj8MeoWxfE4hnZYkqKiPb8pcqFKAo+9I37bKOllZKQrvM63ynJgVs8aCvtFzFzmwcQNPNtrxIMLwWuwpk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ho9tIBsk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ho9tIBsk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743187158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sEZCJqR/jQLNoKJzMVKt342vfkUnaXZ6aAgblV+pWSw=;
	b=Ho9tIBskpNMXHDrhxt0pkiwOY0354dw43TRNNtEFzWLZA8i7x5bfOWbqltGTZ1bk/taZAY
	ivKsDqh12XxMT9GDHJvLbh6z72lm0D/5VMihFiQMxxOg4Np/2e34A53R5kqJVsOfjrhubL
	Xor3lztetE/fu6PoenWJpzETdzyd2eU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-Jz2DJsGYN4i3oD0PRXRuCw-1; Fri, 28 Mar 2025 14:39:17 -0400
X-MC-Unique: Jz2DJsGYN4i3oD0PRXRuCw-1
X-Mimecast-MFC-AGG-ID: Jz2DJsGYN4i3oD0PRXRuCw_1743187156
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6ed0cc28f7dso53478046d6.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Mar 2025 11:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743187156; x=1743791956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sEZCJqR/jQLNoKJzMVKt342vfkUnaXZ6aAgblV+pWSw=;
        b=NVEf1tLdcQHx33BTphKQiXjwGZgZVTdhXmsPiUPt10tjXhGhSFxrfswsCxr68GgWgZ
         i7+XkHeZRS+DumiaehEYqDmfwZl08H64d9gE3OFNv2ogd7BrLbH/gAMLsZL3JFbDnFhR
         ukRou3KS/FUvhZg6T4AfwPkK35OOQSd5dqOAOLn8DRPrwF4lZKGzLhmHMWUhGn6tDL+T
         JhKkCiMHyoINlVQXeD5KzaNJbrGicQmEmSiBx9yZLLxbZoeStdcY9h79ugKZHdgVfz+B
         bWt55F907hogJGkLh1liZoXG9ckjVstd4o1WHmI7cygd2VkTGTEXohGSpdknApGe0CaU
         7OSA==
X-Forwarded-Encrypted: i=1; AJvYcCXv+zgkwy5ogNZ0WdO+WfLllDmIuGVM1GzDJgNQx8IJ8i7yK9oGKbpUOgEwzQJD+LZg7qx2eagtKmTA/HClISNW9EE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW5tjhATJs8g15hc9roWjyExJQRpmnVbRvhg30PPY0WPjRl2Vf
	wBK1QnaeOA9JQ9hZAK3hB2+/EjonL6tKYNBxt6Uv8qWM/qB3RF3P1Hb18C0wRNwT/8b5grgLctl
	6mqLgN06ZBO9YzBYgCYvllbsmMhGaUTVFwq+vNjgiIUyJSqD8i0oDH2sSgUf1l8dWcOi9KA==
X-Gm-Gg: ASbGncvp6UNbUZ2XQS40bBKD31Ato1R/NUmRsLvI2+Kk56R5AvmVfYXT6pwT53NvizZ
	NULUlnk949q5CzLF5rhW0POI6YkPbPXpbLuINXOul0eO6p/aFvz3oakQDGsajbA+vs5LA2WEAn1
	CRP4MR/i69SoORikNasUVvzVgfj4B/Yx+w1aLw0tyFxDUfq3lV7U3R1xL9C7ikhM6r1ljHyiKKV
	UpT8GfDXURdTEzW2TFxv/JqX8U0NT+2+mk2sxaT52rT6J/CZIjbIsHeZdrtT4QihkO+YoKYjNHs
	HGTwnKZVmvF6pF6aqhiDMakPgZvYs5qALPb4AXWaiw==
X-Received: by 2002:a05:6214:2aa5:b0:6d4:dae:6250 with SMTP id 6a1803df08f44-6eed61e5cffmr1949066d6.34.1743187156451;
        Fri, 28 Mar 2025 11:39:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvqjKJXLG7j0auQtxO9l/y2W+hwFCUPX7pKk+CbqE7ARoNxdWNI+aRfGqS7ZOfaDY+ILj1VQ==
X-Received: by 2002:a05:6214:2aa5:b0:6d4:dae:6250 with SMTP id 6a1803df08f44-6eed61e5cffmr1948696d6.34.1743187156087;
        Fri, 28 Mar 2025 11:39:16 -0700 (PDT)
Received: from x1.. (c-98-219-206-88.hsd1.pa.comcast.net. [98.219.206.88])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eec964649fsm14276836d6.40.2025.03.28.11.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 11:39:13 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
To: mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	aruiz@redhat.com
Subject: [PATCH 2/2] tools/bootconfig: specify LDFLAGS as an argument to CC
Date: Fri, 28 Mar 2025 14:38:58 -0400
Message-ID: <20250328183858.1417835-3-bmasney@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250328183858.1417835-1-bmasney@redhat.com>
References: <20250328183858.1417835-1-bmasney@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: o4rwHprtqfTD47ThU9HPlIK0UuXrIV7-_lwlJe-Yfms_1743187156
X-Mimecast-Originator: redhat.com
Content-type: text/plain
Content-Transfer-Encoding: 8bit

Explicitly specify LDFLAGS as an argument to CC so that this can be
overridden by the user.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 tools/bootconfig/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bootconfig/Makefile b/tools/bootconfig/Makefile
index d2713902ca5c..90eb47c9d8de 100644
--- a/tools/bootconfig/Makefile
+++ b/tools/bootconfig/Makefile
@@ -18,7 +18,7 @@ ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
 all: $(ALL_PROGRAMS) test
 
 $(OUTPUT)bootconfig: main.c include/linux/bootconfig.h $(LIBSRC)
-	$(CC) $(filter %.c,$^) $(CFLAGS) -o $@
+	$(CC) $(filter %.c,$^) $(CFLAGS) $(LDFLAGS) -o $@
 
 test: $(ALL_PROGRAMS) test-bootconfig.sh
 	./test-bootconfig.sh $(OUTPUT)
-- 
2.47.0

