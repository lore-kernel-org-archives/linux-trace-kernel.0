Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB693B95F2
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 16:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281693; cv=none; b=L1lnBGbFzEA+GbL8ceHvLOoR1MOnDYX5D3KUYOfeVTxlF3vyWFIqOLKMc8XxUJmPVEwY7o2fHK80TYlo922jkmcVcG4a5ElzgISqdaMglAERfSRJryoEVI6+m+V4k3Xd74BumUX1JYKqC7T64xiwQRyYAfLa4Tt6OYOODWnaQtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281693; c=relaxed/simple;
	bh=F6O9RM5RWYDbuGEigv+0eVBvS1g36eOTG/dr1zB+7Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HkE2BpLGSY/c2TOOBcCtbyxEzv7ebnzgtw1tODpk5rE286+VKgZJ5kOcaUqOs/+v99Zicdzcay9txUONWJ6EtDXwAsPUSTGm7S3Bx3vP0KQr/4XKBd5J/j6Ht2JXvnu+OcwdE125N8MYp7ngp7DacBJ95v3dDgXY+KYaVMCJMTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=tQzSNPtH; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="tQzSNPtH"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7d750eeaec3so1228879a34.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 09:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1774281691; x=1774886491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evO293Sdaw2AMQFWujbeilLvnGlR8j74Ybb8MMUf0FA=;
        b=tQzSNPtHXeGHglQAz9Wt7Z4K1HBpA5+SwfBQmd1UiP0BIZy9gAQy3k7FmVUhCJrd87
         3AL0qbAtH7xLtXOsD3MVt75VGyp1EPE+FBq+Q+kAbA+lRpEPFe1CZ+Ku9Z4X1Pom0aEe
         KWw2HYsSgRAR0wIiky8YUyMFd53BX6uQF6jGIaRrDwfChApiAKyY1N8+AI4ipfKIiUmy
         xJx00qdxHCxud4vOYuJCcG6bFhwDyRXIhnhumsr/bcHsIO8/NCQlDSN0xQEqL/NByssc
         PkKz4jryEGfselH0SUKjmx0O/zjmnFHI2qz0aIkB3VQPDkdBMy1bi3hwPA/h1hgjpTw5
         CKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774281691; x=1774886491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=evO293Sdaw2AMQFWujbeilLvnGlR8j74Ybb8MMUf0FA=;
        b=Om2ltdabid8MzQxPXgTPpaMoIhZ56K6xWzWUzMkjQYE6si+y99L8irPBejpgZKQvTW
         hM24a7k6Ls+5lSmIWeTdeGhjBGma4nkvzn2Iyzs9hFZJBR3D0GE+26Dl9PTdEYOW+HQr
         ZcNAvnC0lin/lFGc1A8RDLxtmpn0WCu3J74UnIKkPF7IfbmTDqhTmnrFU2YNuqBR+Nlg
         gWdkVN1n97Uuyee1QKKFh5rZjJsaycmQHmuHgHREs25dzc6PjobBwxG5jj7KJt05PTH4
         l1B99UiAuk4hweK1Hpnsw3eZUTBUkfkEkB2Tv0rXwxUtiizk1u+mApp3lwllq8MGfWul
         AuPw==
X-Forwarded-Encrypted: i=1; AJvYcCVQsspSK0UXTH0F/sViZg07HQUyiM9sKWb5Y+Nd8yzl+joLkJBEl3v5DTfGKsmxSfKSJsvvSJH9qLK5NgJuH9fOL+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YztlBKdhcEVd65zm4J0umE9jjTIJgepsN885e/XQCJW+AlIhXox
	IFo7pzH1a73v8EoQqF8atwF9gYcEjDXhJPxyE4jpc9cumnmqbbNSwAmEWEcGmXa2tb4=
X-Gm-Gg: ATEYQzzZGmEX7TSto8dlDJsKpGZwe25KVb398IS4ShrODHOnktbD8z8vYg7JPHCOqwA
	IImdduEfAVjAFfHyb+lt1PdYGwVSINXfaHboHERvgZnSXlrkuSLY3XR58n6jmbTxWzYjgDafOk+
	lEdXqRFJ7M59GrbqwumjTrerIemjEtM9BQI8uWGDb71xpOxXJteixMdhl2EXKa6sIN671i8TnYN
	/iZBsaC1nvpD0dspt9YWrpTWE4gDwdBlp4uDqv57JWTtRd5D3pDnHlYSw83WO9yzcI+RK4x8gLG
	QMYiORtCxYUPeqwKee7I4abG8TOXoZuaceiOxhvWt6/zylLRuXRIXUKNFfApr0fLdusQ6XjVMxa
	qmGIxn48oXZD2tQs0axImps5TFbTKkBxPxiNQXGFvePiGzGyqhzl00R9b8HOyi2CcXT5/000WSE
	bqLP1N4CHBg5gaTnCz3/eBCQGVEc4CS0r3vdccuj8PyqhkWA6iLMfmlJjo2WVhKbY7tA==
X-Received: by 2002:a05:6820:2016:b0:67d:e9ce:cb3e with SMTP id 006d021491bc7-67de9ced1f2mr3792594eaf.40.1774281690800;
        Mon, 23 Mar 2026 09:01:30 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc9088df1sm843364185a.25.2026.03.23.09.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:01:30 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 13/19] spi: Use trace_call__##name() at guarded tracepoint call sites
Date: Mon, 23 Mar 2026 12:00:32 -0400
Message-ID: <20260323160052.17528-14-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323160052.17528-1-vineeth@bitbyteword.org>
References: <20260323160052.17528-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/spi/spi-axi-spi-engine.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 48ee5bf481738..02bbc5d0cfc50 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -953,7 +953,7 @@ static int spi_engine_transfer_one_message(struct spi_controller *host,
 		struct spi_transfer *xfer;
 
 		list_for_each_entry(xfer, &msg->transfers, transfer_list)
-			trace_spi_transfer_start(msg, xfer);
+			trace_call__spi_transfer_start(msg, xfer);
 	}
 
 	spin_lock_irqsave(&spi_engine->lock, flags);
@@ -987,7 +987,7 @@ static int spi_engine_transfer_one_message(struct spi_controller *host,
 		struct spi_transfer *xfer;
 
 		list_for_each_entry(xfer, &msg->transfers, transfer_list)
-			trace_spi_transfer_stop(msg, xfer);
+			trace_call__spi_transfer_stop(msg, xfer);
 	}
 
 out:
-- 
2.53.0

