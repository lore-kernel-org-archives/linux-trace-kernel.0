Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824B92E736D
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Jun 2026 21:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780348557; cv=none; b=NY9jG6Nyzv/CKdSQa4EwofRBRgoD1Guh085KFQZ9l8XJb0Yy/AhkoL/F4sptq969eZXEWri5b6kHl9EftjzsLLqwSm7XZ9xsywl/gTv0rm76wOIK4sDIdsyCbqpZQavSFCvESf/KJHDHxRu/GxTgXmGBQu0XcexSP0kM6gJKpyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780348557; c=relaxed/simple;
	bh=FYckr4FFZBlaLk+9y89W4SP3wfP6O5lMdB+oeUjRrYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PfaT8Nwr/O/fSvk+AJiN+UMVxw7q0bt9QLXL6HsHpCxKaCGg6+5NKaL//YRxAyI2pPf6M9jZs0C0ysdJ9RheJWzIZKEc30G86v4IGNOl3VXe7tlNScXMZH4HGzUHyTEydsQpuUHMAoLn7cD+9doXP6q7F+6TfWGjpUqtC/E+pRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QqxDnKU4; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QqxDnKU4"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-91564c3a968so131699185a.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 01 Jun 2026 14:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780348555; x=1780953355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GS7uQD7/dVRcIOKlI8X91PbNQiNSL1LkFvltxQgrYVM=;
        b=QqxDnKU4beitalgZmdD3hJNz563RNopqdEq4ZefNTmNwbgD2L1Ml3QdoPVWBwLJb39
         bAaRV3SY4XvnkS7oYlGzbhIBgwdhg3dTGWZrpPLVYV0+TV2BCk6GS3UO/kUHVcYP7DZQ
         XSgGasHqogbgM3TWov2VO53Z1K2P/hFYZQjK6kph/pWNzwxHKUPpaVQ77RpeEM8P4Njd
         cuCBsEwvxHpUFZbBUPFpqXXcMWQ5tAZ1ObS7nYmUSudB5ekl43LECSpvLuPVQ53fUugV
         Hdpkb+JV2M0y6ISOnZ52Ml5dKlG0oQsqZFsxT7xL5nltsHcnZjjwqhS+NYCEBsUvj1g3
         7kCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780348555; x=1780953355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GS7uQD7/dVRcIOKlI8X91PbNQiNSL1LkFvltxQgrYVM=;
        b=jg7R5siUzj2DfL41tr1nx69+mAD3v2w4GqsKWXbalQIB0QhePtu/NBUV2uVWcLLWhh
         Sa1INsynhybXHe3wgypQgMePvFI95/ssYZb2RO/pVonRE8kgz1OtMu60MuvcAHyIvmSc
         igFkKpez2lHLN2+3c0OqIb+Bbcffrrtn4UeMfKwiIMuDqTBeUfvh5PbOyL/1ReY4VGK8
         Vbyo+RB/9p2wLkuk7qK18+igy4yF6ol7uCVToyDIsu/QmuuVFAeUhbJ02aUre4qKNMCX
         jqJ4ZkV7jNv3sRy6Y95mgy745oPyh/p3z4pIpLjEuaT/4Y0d6EF164shxBzNrrTRaQqr
         YHpw==
X-Forwarded-Encrypted: i=1; AFNElJ8OK0lC6SOJYbFxvRK3bgwZCeiSx5sZzRdv1y9bKefmO+X4RRmhBohky394YtscgnD/OSdooPwrHdCeMF2QAFs2z8M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcf5mIEQHeEL4vl1fKgitZkm0qqLRy8YriVQCAsgeoXpOEE5fo
	pv8bg2jLwq8my+n7vu4zrXDeRu86eiKJwtkMBwo7uM9DbAWTv2dsAiDk
X-Gm-Gg: Acq92OEiJ0V1bJtnxaXcAIVqqz+BIkMnDjZbIHYeCOaIqQwfTCY9Pwit3etdNxhHkZq
	2p886NxFW8NVfGa+yD7YV89OHr71lNeL/Gvt3O2W51N0klnbGv8/2eYiwFq6m5BEW6WfZlnrB19
	hyjUbd5bJHY2UddusAuHgQhKRWZBb+0hUs4StuK8HAZSphRoAAhibCWxoYqraG82UJFvgmJ8e8N
	zq+f4zhOpR0y46qXtZn5EhL41CcwlQMWkIgMLeuy/fTPF9DmRFKtjvgV0lquR3qw7wxtd3ETMA9
	uGCzUNHPIckDyPdCaKyuCKCTscwZyXF1C0jfTwtVI6IklYXXMcjESHbxjtTw1tOADCXNiQbP7Xe
	v8EOSrNG5gJk8nx+y6QOq7PJ5iSr6kB4Grc55ylQ3yXem/c6kMZQHdbQSxPcFLzOkAbhVHLW9XQ
	dY+krdYx3lziCZ/Zj3RYXY00eNTJ7R2pycelBxZAPsmoRAmq+r6bzVmR0AnzX+SoDlxhmhy9KbM
	6uyKwwqudKmfq97TKUvWbS0PESAbo4GGDqpUMPz
X-Received: by 2002:a05:620a:254a:b0:915:4217:bf0b with SMTP id af79cd13be357-91577e8f337mr194682085a.19.1780348555533;
        Mon, 01 Jun 2026 14:15:55 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9153265d794sm1099641185a.47.2026.06.01.14.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 14:15:55 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	"Luis Claudio R . Goncalves" <lgoncalv@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] rtla/timerlat: Add tests for option parsing with attached arguments
Date: Mon,  1 Jun 2026 17:15:37 -0400
Message-ID: <20260601211538.381649-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601211538.381649-1-jkacur@redhat.com>
References: <20260601211538.381649-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests to verify that numeric arguments work correctly with both
attached and detached formats:
  -p 100        (short with space)
  -p100         (short without space)
  --period=100  (long with =)
  --period 100  (long with space)

These tests prevent regression of the bug fixed in commit eefa8af46ff7
("rtla/timerlat: Fix parsing of short options with attached arguments")
where -p100 was incorrectly parsed as multiple separate options.

The tests verify that:
1. All four argument formats succeed (exit code 0)
2. None trigger the "no-irq and no-thread" error that occurred when
   the bug was present

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tools/tracing/rtla/tests/timerlat.t | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
index fd4935fd7b49..1a63301f5d70 100644
--- a/tools/tracing/rtla/tests/timerlat.t
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -42,6 +42,16 @@ check "verify -c/--cpus" \
 check "hist test in nanoseconds" \
 	"timerlat hist -i 2 -c 0 -n -d 10s" 2 "ns"
 
+# Option parsing tests - verify attached numeric arguments work correctly
+check "verify -p with space" \
+	"timerlat hist -p 100 -c 0 -d 1s" 0 "" "no-irq and no-thread"
+check "verify -p without space (attached argument)" \
+	"timerlat hist -p100 -c 0 -d 1s" 0 "" "no-irq and no-thread"
+check "verify --period with equals" \
+	"timerlat hist --period=100 -c 0 -d 1s" 0 "" "no-irq and no-thread"
+check "verify --period with space" \
+	"timerlat hist --period 100 -c 0 -d 1s" 0 "" "no-irq and no-thread"
+
 # Actions tests
 check "trace output through -t" \
 	"timerlat hist -T 2 -t" 2 "^  Saving trace to timerlat_trace.txt$"
-- 
2.54.0

