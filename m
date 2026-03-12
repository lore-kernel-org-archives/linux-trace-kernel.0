Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606B33CBE96
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 15:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327972; cv=none; b=Nqh+6+l9p0UADismdQkBDu7yXM64W62fMP5qlowkTnovn/U/AsEklGgw4J+Mm06APF6lcvsOTzzzb7h2W04ex6OXhz9XEz0WkvMnCWWPxbcPLVlhu8A3/maEiyj7zlGWNac8+ANppTiBvq8q7YvrLUpuy7vXe3MWAdRDKvZnzhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327972; c=relaxed/simple;
	bh=125sLLSuTjGvTctK7MlteCpnWZ8dRR2FA4yiyluzt3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=azub25jOco1htM8MPu1yl5NfBIc6luue2hkzHjIl8bXiIxUJ4qyZyoJrN0X7J5mtq/pfmqkT5905IYA4yCpqYDL/Ng7yOsmuncwvVlz9Amzo3BwYDixvR8WRiE808ipyZLslT6JpF3fsQG+46bbwpnQzqW9KaaDWh8WL0Tx376k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=qriZE8Ot; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="qriZE8Ot"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d75d698ee6so689711a34.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 08:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1773327970; x=1773932770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ivFPtRhxMTnjNuXFN8NVkjaiUTQi0M7fKGRjGo1VpY=;
        b=qriZE8Otp6ZKq7LmiNfXcf+J6N7VXqdY15d3zwo5BsyJpkuIwfepd1XrkNQ5S6YD8v
         M3swYhftrC359Gsm4ktK9GwGv2ZIaOYqGUVjeCcpAy4+9l8YHUqvCVpvJ0uLoaB1HLsh
         txTRfQ2Qc4QZ2xnKVAsCkVw26n04MSaz49H+hWgCfK3kDz1QD7WnMl1EgYfWDMfftcSN
         XdSbLUtB4IQsswl8AL3k0omaICmdq26pfn91gB1nYhY7KqKyooYkrv2jnaNl34v8ZxMS
         eBPcKUuU8xpNECnqyT5rYdO4v6amsgooWNmt65D6HXG+Sh8lMk7BxTzQlccEUNPxPaOh
         8lPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773327970; x=1773932770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3ivFPtRhxMTnjNuXFN8NVkjaiUTQi0M7fKGRjGo1VpY=;
        b=KFysX6XIIw+QJdhap5Qcj3kKa0r8gT128Oirh1ggricm4Uy6QJEQKqjmyYeiyYmxkj
         RcujPiUVwxtEMjc1UehqObawjYegO3Z/yD2vg3BADdcnSPVPCEL/oZRSHW+t8VtexKar
         ljeyjO4N0cCC+PMV6NmynOqqjpOIG3GDzaCeqDJa+dTOoL3siIBucyceXamI0M7tG+Xj
         iw1lvsGOExNGegtNxCAYgcFK3iS4QhzAuTeIoXcKKT5f4hOojxsag0OJkixH59SxtK9e
         9aGI9KxRDr3e/NN2yO9QVj1mtkxa0lhV0bV0r6JmAVBtuGVgXFkR/uMF072Et2i1A1d8
         bgkg==
X-Forwarded-Encrypted: i=1; AJvYcCXf+DyuDcegvY1T869oPM7WqbbwYSSKmxewuvz1OfTEBekmdihHtX9JhySdNQIMMd1/6NNCJw08oaPBYFpldRiuDao=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrMv44YXyUOXAX8LHmsf3Z08t3bwe/7WL+X6X6sPEFA5BBLOON
	ChXGLEHvYGXGoUBKFDmwEKVrLQkNh+baR0pByCnwSPMe+18HPcp2Cy+C5+jymMRFr4A=
X-Gm-Gg: ATEYQzzKnUkHxOHYrQj9DktqZ0eEV5QtXnt7T3d4aTmrt0f8OpdBP24t1A+ZgMJNtTW
	sIAK/Fy+ZKnAhD0Ym+Ouu8/e2AvZHLai3F1tmNLIPLdv7VYbd6ex/abC1tNhC2PlWstowS81FKS
	NxTA5JlM4VO9K7Tq2DxkE1cS1IBm8z9/nCgkT6qasH2VuZPXtDyp3gCADKD2bzWz37WihCMvVks
	qWo2fQyAB99MGbOWYuN660tnNeKv5snVN73uQNu8LeNwHus06Fxyk64LNYMXdFWb42rZkMdHojJ
	vrPIne8fyjDZc/+KwO1dD2smsqCOUTsi69T7P/GzPnpNDXuFTnpzXMypE102kAf18iAff8MlhUu
	L8uaTppROGbA9XYRAka3KWXN2+hoarrNK+mF3jz6uTcqIH+W2TiUrZS4AJXjC7Cx2/APLo/fZzq
	BBd57ps9eJTmqk/GDi2g/n32nWSFnIRpXfLeGxZ5nEWPhuGVKy0zQVFVOosC5N1AJwdw==
X-Received: by 2002:a05:6808:4fcd:b0:467:11ab:cd6a with SMTP id 5614622812f47-46733422f3fmr3665303b6e.2.1773327970368;
        Thu, 12 Mar 2026 08:06:10 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76aedae57sm4321776a34.28.2026.03.12.08.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 08:06:09 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 12/15] i2c: Use trace_invoke_##name() at guarded tracepoint call sites
Date: Thu, 12 Mar 2026 11:05:07 -0400
Message-ID: <20260312150523.2054552-13-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312150523.2054552-1-vineeth@bitbyteword.org>
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace trace_foo() with the new trace_invoke_foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_invoke_foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/i2c/i2c-core-slave.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-slave.c b/drivers/i2c/i2c-core-slave.c
index 02ca55c2246bc..04de8908de5fc 100644
--- a/drivers/i2c/i2c-core-slave.c
+++ b/drivers/i2c/i2c-core-slave.c
@@ -89,7 +89,7 @@ int i2c_slave_event(struct i2c_client *client,
 	int ret = client->slave_cb(client, event, val);
 
 	if (trace_i2c_slave_enabled())
-		trace_i2c_slave(client, event, val, ret);
+		trace_invoke_i2c_slave(client, event, val, ret);
 
 	return ret;
 }
-- 
2.53.0

