Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AADE34CFAE
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Feb 2026 16:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771518467; cv=none; b=myZyupO/pSjSUYLAwSpaRaBIC5qdAfBN13AT9m4HyEH1Ric0XIAIbV7UJ2Vb1dF7VzxoGdLyq2IQoIq9NG5tCLoazVHGd4O04JmULQsuChm3qx8VrNWMFLBjPXhEuRATAa/rC09ijIaVpVgkCCwidGUG4AVK8E+htFj9LP7wYsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771518467; c=relaxed/simple;
	bh=KgrBTXu77Iye3UmYdwe000SXgI76QMvrcd1NFmgU4Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EOQlb6fp5UWrc9nwpy+nOtzcGKFmk0mPS1E/Gvq92RW1ZbPb5syBzvdaaeNg6sP8uWZzYa15f5oYY+A8PbEukc7DbEmqhzbQ/2UJWrbMp+CkYpjAnWPowmyJ9EHjUlTYFY0dYTY4+DRXi2dBxG1ASGB5Ph73v2dwoBgFPjflJDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZbsMiIu/; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZbsMiIu/"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43591b55727so1142702f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Feb 2026 08:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771518465; x=1772123265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BI5owf5Lg6dz1A8TLbDN4r7HFJ4qL66b0FlE66FGWHI=;
        b=ZbsMiIu/8IYCOmc2ulT3xxkzJlFnzbhPm/HeYo89WUtmAnYKmhDwUs8PVpfc1vLlNX
         /MLbDcg/vh36GcuPUtE89+og3gRYwhpvBWT+oRaqKShBnC33lvWStP/MFOmEm2c9DZ0Z
         N+rBZmk4MWC2Rq10aDKIHZJGf4bpgdkcFkkOuCUy4exOqyi8+8O1aSNpjANrIyKZZxKa
         tF4c7CZ/8aIzLGqV1Fre5mBkVTDsmy4p/Yj13O0ud4FIepaU8PjoenqTEuUg9pOk2omd
         9Pa0vNdXJ3LgwHd3segq5PAxl4Wd7wjPg9pS+8vqUtcMzmHKT18i/b02XWMyGccCuscw
         HPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771518465; x=1772123265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BI5owf5Lg6dz1A8TLbDN4r7HFJ4qL66b0FlE66FGWHI=;
        b=CJQi1q/R+Wlzlkz8kjy7JF2D3kRjzEx1yBrtP2pSyX51APM1DL9Y2GtVRSPk/EdrnN
         qoQyomJzwNxYm3siMunnSmQSkvjaohx+vJWLxM03CzjDeGaGszlCn1qYsP9SWS21zA8Y
         PkYve/iEtjk0EbcjFeglX9HHrbTmKgoEQifr6RFpSnPudK3FDwKc7KXBEsttmz6Sk73M
         tgNgZ56nz3uSidDk6/BCiEt3bjfh8zBYfR7gw94JFr42bDJR9fqDvr3h9sYXOsV9t2M3
         uvSS6qEa1KnK0RjDuBb2xNnF7wp0UriYIYMWmqB/zSmiW9FXrmE2qcjGK0OmNnLfhb5/
         44XA==
X-Forwarded-Encrypted: i=1; AJvYcCUCgM2TOqEsinuOQm9hSvRtIzbteR+HXcWFMCfHBZ7mIXm0FEZRFXOJ1DQlZ+AQyI3dZ0lhHcNcYtsPqmp0triJq3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvXbOzlAFBlc0IjLImDx4MQIkh5Rp+Mnrx9RG3lYIsx6wQS+L5
	5eexCQrf8jMfQLfgMXektBlChtUv7zzoCn1cnVGWkxLiEHVOR9S/Zgok/ZSVcH/6oAI=
X-Gm-Gg: AZuq6aLyu6I4mjzJJa7hUQrPLeS57zMwZ7ife6i+XQLKR/V2H6bYIPTF9mzv8FhZctm
	ikQR186TT9Q+izh9fdqiGBgxo5XZWB/+ILtefRJPwCDQuyquYxiQBITDQPsWot9iLwiIru5qlT6
	JmB+tsdYybY1O02H7jAzVrYL+Y8AIxfWK4yil36M0K6qbIZfKYxxsUNM8FsmNuC3xFX2WBQGCC7
	Qr9a6cwa2cgbkD1cme76TlO8MiT/PDkbBqQAebAq8oy/rU0FEmZkE7ABjh9hJSyAe9eUO5yB20s
	ypCvGmUHYMZpqkOjhKDDVTo7ZsJUdUoLRCTwEptnGGR3hXbTXelSXnTxdZJaamlHNoBnDtHrQg0
	qr8DcMQdWzyscOwiJqPOGl6gAlQdAQBXTSpLlRxnO5pC/UNFdih0NMJsnVzH6SdHaREpaK2cV+u
	oP7qdbtmJa0+bItubXwVbb6tilZvpqbqv7czOg8hMW
X-Received: by 2002:a05:6000:2001:b0:435:96ec:679e with SMTP id ffacd0b85a97d-4379db61cccmr34207692f8f.23.1771518464634;
        Thu, 19 Feb 2026 08:27:44 -0800 (PST)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac8075sm47324631f8f.29.2026.02.19.08.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 08:27:44 -0800 (PST)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH v3 3/5] tracing: Remove unnecessary check for EVENT_FILE_FL_FREED
Date: Thu, 19 Feb 2026 17:27:03 +0100
Message-ID: <20260219162737.314231-4-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260219162737.314231-1-petr.pavlu@suse.com>
References: <20260219162737.314231-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The event_filter_write() function calls event_file_file() to retrieve
a trace_event_file associated with a given file struct. If a non-NULL
pointer is returned, the function then checks whether the trace_event_file
instance has the EVENT_FILE_FL_FREED flag set. This check is redundant
because event_file_file() already performs this validation and returns NULL
if the flag is set. The err value is also already initialized to -ENODEV.

Remove the unnecessary check for EVENT_FILE_FL_FREED in
event_filter_write().

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/trace/trace_events.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index b659653dc03a..90915e1286da 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2245,12 +2245,8 @@ event_filter_write(struct file *filp, const char __user *ubuf, size_t cnt,
 
 	mutex_lock(&event_mutex);
 	file = event_file_file(filp);
-	if (file) {
-		if (file->flags & EVENT_FILE_FL_FREED)
-			err = -ENODEV;
-		else
-			err = apply_event_filter(file, buf);
-	}
+	if (file)
+		err = apply_event_filter(file, buf);
 	mutex_unlock(&event_mutex);
 
 	kfree(buf);
-- 
2.53.0

