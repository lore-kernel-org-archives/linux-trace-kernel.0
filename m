Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534161;
	b=DepJ0eOde9aqDzLAAI4fu483ZSxPMWmgAgpHdeZOpY79jlS/vmxXiLV4WroGs5rD5iTu
	 u6vGNW9nx+VTWnywei4A7Kmz5PZe85U5JqgtniSUqu+GITfrrj7PrVVQ3DuaEiNsrKOMX
	 EYiUh3MGij0diKnpTveTcnvXv9W0uz7gAP6aNHh97Wy8tz/8yNhZSjOZRFOpF3QDkWPgg
	 fR4N5CZxHTkMwhs+fjwtuXQ/AllODiaLqecn4XKUzhqzvoAFldLhCPGW7leTO2WkLMJKx
	 niTuT5be7pGW/53aOGvv325niuk7deUr3oRQBNUAVWWIBHoujmA8LZKg4gQLUK4owVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534161;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=mQt8eIxPOUGv0YkmUsKHVGbPLTXxWDgibqzukp2v6tM=;
	b=tm70zbppnXveuY7GCwh3oFwk+7IJCyjAjBupKggccj/I0jNNoC2qzBKaZnikjc2Rxs+t
	 she6pJv9xgqx3BQGkZzKpztu+lFQ17PdEPkkvQ3Vt8u+uL6vqx1QtF88y/lFZPYJq0sM5
	 U8q1ipaJIiBNVTjl4xsHXuE+9DuAOMTo58m5lm4eotKv/STYMnnv5hmkrlJM1O90N39eq
	 sFHDigWutEmk8Ezaqg6mlOMnWaKGhRTJ6RDyuw3gMaCtFxf4OJAYxuQ9u7j0m2Mz3xnT7
	 qJ7RBlTMXY8g4KI94LzbXz06S2qbEzHx6XnFRngbohu0+iUDaUTvSagQ+WiP1eIUUVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jFjMtkib;
	arc=none smtp.remote-ip=209.85.128.72
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1542606A687
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 15:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1542606A687
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jFjMtkib
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a359b714f8so28359485e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 07:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795534159; x=1796138959; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mQt8eIxPOUGv0YkmUsKHVGbPLTXxWDgibqzukp2v6tM=;
        b=jFjMtkibiB4ai7juQDrqRK/oAr9NZZfhrTHrqpULqJtsAgrwO/kgvuXTqqPKhHsKIb
         t85uiSpWs5wBRshY9oT9whWAKM47XgJzwKsuzPTBCa8IzXTmhS9KOLyYVz53uQKre6x/
         0Pm9VAj0ia2LIgtkLhH5gNAnS+BL0uPYO3C4sAalmGBhlnO+ymkJKpYeKVoyndExK8Dy
         bgLgOvd0VMAR0urjL2k0dOCihq1IZREUciZz/a4TUm7D8Bly2/YKTeauFkJNP0qDVwyd
         wCP6O1QcfxS95sbpk/n9Xljt3weALIa6784CdD+J+kcpb+eUhKB06zWwDgtfdD4cYU35
         Bqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795534159; x=1796138959;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mQt8eIxPOUGv0YkmUsKHVGbPLTXxWDgibqzukp2v6tM=;
        b=TCDIK4MVgHmoep2JOdj/BFvJqbIOMez7ev3TDb/VLSNXZzLklWdg5TcHZ+IWLmh3pk
         wFWRqhTv5/69mOvkbvicHtgi6QBos7sJTN/bq6pELKZru4S50qodSp8ePSPgPi863YaD
         JIrFMBwg41BpVo0A1MCa/M7wxDtULZqtWSNo1XcHkwn71WOm5Ra0liUaVxnTs4cC5xNF
         EPlq/jBa10BfawjydJDELlbBKjpV8/AwpGIWUX6WMVN7gNbxP4VTJHJE2gdm/ZsnJnh5
         TUTINQD08lG3hfbHo2qPIl5Dabes4GEcL9iLZC2Ub9eA5+JpIGZJ/3usSKd/FtLqi/15
         Zq9w==
X-Forwarded-Encrypted: i=1; AL+hErGjTONHmIYwPSlQ6fANC3gJVHRFVAW3wNiCdzQm7gi86T2syorKjJSBCcYOAuCTnWrRI/SqNavOrTJkT6MfVvkgaRc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9qwr9DeM6cg5rxc00FwuuuA+xDZZq+cAaRu+U8GrjD9DXuWRjM
	+UOEik4r/RGDUXsegUmU2g093yhVeQVfyeVLMt54nZc1Kh5PA1spUzgbyryuadUHSfqk4Rm2mnl
	Y+Y0kgv5UT4N2RYdT59W2rw==
X-Received: from wmot5.prod.google.com ([2002:a05:600c:4505:b0:4a1:fd4d:ad4e])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3547:b0:4a2:a6e:80f5 with SMTP id 5b1f17b1804b1-4bb888098bfmr307202465e9.11.1795534159139;
 Tue, 24 Nov 2026 07:29:19 -0800 (PST)
Date: Tue, 24 Nov 2026 15:28:27 +0000
In-Reply-To: <20261124152845.2233401-1-vdonnefort@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261124152845.2233401-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261124152845.2233401-4-vdonnefort@google.com>
Subject: [PATCH v9 03/21] tracing/remotes: Use kstrtobool for boolean tracefs files
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Use kstrtobool in trace_remote.c where possible. This is more user-friendly
as it allows a better variety of input strings.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/trace_remote.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 8a1a0c4ea626..bd1b26cd981a 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -235,10 +235,10 @@ tracing_on_write(struct file *filp, const char __user *ubuf, size_t cnt, loff_t
 {
 	struct seq_file *seq = filp->private_data;
 	struct trace_remote *remote = seq->private;
-	unsigned long val;
+	bool val;
 	int ret;
 
-	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
+	ret = kstrtobool_from_user(ubuf, cnt, &val);
 	if (ret)
 		return ret;
 
@@ -1151,10 +1151,10 @@ static ssize_t remote_event_enable_write(struct file *filp, const char __user *u
 	struct seq_file *seq = filp->private_data;
 	struct remote_event *evt = seq->private;
 	struct trace_remote *remote = evt->remote;
-	u8 enable;
+	bool enable;
 	int ret;
 
-	ret = kstrtou8_from_user(ubuf, count, 10, &enable);
+	ret = kstrtobool_from_user(ubuf, count, &enable);
 	if (ret)
 		return ret;
 
@@ -1235,10 +1235,10 @@ static ssize_t remote_events_dir_enable_write(struct file *filp, const char __us
 					      size_t count, loff_t *ppos)
 {
 	struct trace_remote *remote = file_inode(filp)->i_private;
+	bool enable;
 	int i, ret;
-	u8 enable;
 
-	ret = kstrtou8_from_user(ubuf, count, 10, &enable);
+	ret = kstrtobool_from_user(ubuf, count, &enable);
 	if (ret)
 		return ret;
 
-- 
2.56.1.809.ga0b61035b5-goog

