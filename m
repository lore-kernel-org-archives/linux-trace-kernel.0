Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C0D3A3E78
	for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Mar 2026 18:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774894278; cv=none; b=bOZ+dbyJfAUzbNWRWXCTfIqDDBb/bJNUN8VU+vBVJ6NkU4ifcuVRKZmsyXesdJlt4PTpfgrpXCGxFtW+l/n2181r5RZ2jxTy2nk3K+UnCpajMz47y+5YY9Fw4QurvfbfJBfwfHL6b54med3zU78tjoqUr+lrw/n01GxI+my/eZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774894278; c=relaxed/simple;
	bh=nA0zVn7ervAT4GTyW+7/LWm+uXAy3AYJ4J9qpXgJKus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BrFWEulFXIeqPFQnxWkQvcLhBqOFyluYYKVQBz/Z1EJMu52emFgfHjVb2LzkfCidMqripru2A5TLs5GrxY+Ey2+ao4Hu1BiPGCp2SJwQ80SzrKbMQXnU8k4PHKsxJDEFXm6zQSbQAS7peDEbJohW8Z+koXl+kaDzcqEerh0wiWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/rgFT6/; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/rgFT6/"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6501c0399c4so2342461d50.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Mar 2026 11:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774894276; x=1775499076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcYyCpkRG3MtLfcUyY+ALP8IYZB+GcNEn0T45SwQe3I=;
        b=U/rgFT6/YhcrWiOmJQ/HxPYY+MdMozXkRf9rTiOlqjeGIhp7sk+7RBjFfCDtxgmJ5J
         mQKDFiJIO1GUr9zZxb/hkfCE6qN7QkBD9Cu2b3t06B5b4nPVFX/i2MwKZNj6oZpMy0O+
         oaHK+bhg+Q4hvRreYvyX9WiIsdHrATbLFm21gdwFrDh+BbPnBF2E/8lrkLArWmY6lz4g
         pZ+rGFEXn7U3phWNEYBF0KlGOaWMb7DQi9iovcQz+pLwBvU8CJ2ZCVgQKvKJQE9QDMdg
         8fK3q+iICaRUADFdKgMT5sMn7mV/HauxEONr7ioSWpKHYjbSzCX4zbb2lhv9lpjQIdg1
         Ctsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774894276; x=1775499076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AcYyCpkRG3MtLfcUyY+ALP8IYZB+GcNEn0T45SwQe3I=;
        b=hD8V3bssiJejlxRZQMEIzJaet+by9SMjyflU3nKAHOktDvbSU9JnI1zwcB1X58O7AX
         +jnD9TNmsbsBjupRFa+GSXdJQlnYBIeEBemSLoXZOxXuhOZq90Hwpr/0506RyaeYAJxe
         OichGtm5/Zs555oT2pG/SZ4zzdV32A0vLbmiYLCbw7tSeTMxD2kQX4AWfmhkwR09gpba
         tKRYHC5/BiGqemrrvgD0VJPAiKWBtzpIGvKA2+5sXllTQChOndSTRqj/y87hVPqy6lLD
         BXZCWdsyWbtKwY4ADBmLKPPoFQr5RGqyggVSNWeidg0TUuKelFdrtYJJiv2rkCt3UZC1
         gr6g==
X-Forwarded-Encrypted: i=1; AJvYcCVlmIc41cycYpEFGprCBgmUdXsT94FftxDhV7u3nizGG4pjTiuAPFFIVg7E0o4H8n3IIstmpzg0VHkxR68P7EZp2eg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFjd5EemjG3Yv2sFmxUtDC2s2UHlbMzfbhBTNOQTFAdIRil9ru
	a24z9LLtFevYmS5LIBuqc6eAiblhh6O4zGRi4mRy3UjSGADPjbazx1t6
X-Gm-Gg: ATEYQzx2kvB5uBfaqz4nHrIILdqzlM8DBOxTCaXR8GATHIhxxFLJrn3fURTutX0mL6E
	PfyWuNoAjhavmlFRbjxaslvu9e6PCbXNu7uc06F336fGgeRAqyRe2wA75kjMdjjkNe/Uj8Xs9cl
	g1dpQcJcK1hdpO7FF0kTS/mJewPtvK7ZXddSVfMXxY4l5n5DTwkn+y5vzsjhqWhYaB3tvxDHGyF
	+I5DtrWcy8aK09F3msR47+7quXsorrd9SdzN/k6GlWHTjl6vMI7fSxrpSl9k9zuv9jWoyeSOBxT
	x/0KKtkIMrSQcpvf3lJhJlsx5zScAIk3DUP/sRcMnh13lFLGi37TWB9jDh3KFo7sxXvqwdF4eeq
	uqMpvbT7ZztIUO8lyhH/MJm4YmS1d4hvFzYmDQAH+0huXGw61Yvv+qJ66nfNHc48Pqc10vAc1xA
	7X8m4v4czdeRZTw/x6GUR3KVpZ/mYcu+a/t6TkTeuoVAJNr54V2m8GCP7/ZTB6IY9HbKXmUgSNq
	J31U23B6kR0QkMEDuoPWe8bueMydFdzzoAZWhNudA==
X-Received: by 2002:a05:690c:c364:b0:79a:b440:5c77 with SMTP id 00721157ae682-79bddcecb1amr118078667b3.17.1774894275945;
        Mon, 30 Mar 2026 11:11:15 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cb4521761sm39104447b3.0.2026.03.30.11.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 11:11:15 -0700 (PDT)
From: Wesley Atwell <atwellwea@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Wesley Atwell <atwellwea@gmail.com>
Subject: [PATCH v7 2/2] tracing: Preserve repeated trace_trigger boot parameters
Date: Mon, 30 Mar 2026 12:11:03 -0600
Message-ID: <20260330181103.1851230-2-atwellwea@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330181103.1851230-1-atwellwea@gmail.com>
References: <20260330181103.1851230-1-atwellwea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

trace_trigger= tokenizes bootup_trigger_buf in place and stores pointers
into that buffer for later trigger registration. Repeated trace_trigger=
parameters overwrite the buffer contents from earlier calls, leaving
only the last set of parsed event and trigger strings.

Keep each new trace_trigger= string at the end of bootup_trigger_buf and
parse only the appended range. That preserves the earlier event and
trigger strings while still letting repeated parameters queue additional
boot-time triggers.

This also lets Bootconfig array values work naturally when they expand
to repeated trace_trigger= entries.

Before this change, only the last trace_trigger= instance survived boot.

Signed-off-by: Wesley Atwell <atwellwea@gmail.com>
---
Changes since v6: https://lore.kernel.org/all/20260329184254.1813273-1-atwellwea@gmail.com/
- split trace_trigger= handling into its own patch
- follow Steven Rostedt's suggested bootup_trigger_buf offset approach
- account for the terminating NUL when advancing boot_trigger_buf_len
---
 kernel/trace/trace_events.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 249d1cba72c0..dd26e838d4de 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3679,20 +3679,27 @@ static struct boot_triggers {
 } bootup_triggers[MAX_BOOT_TRIGGERS];
 
 static char bootup_trigger_buf[COMMAND_LINE_SIZE];
+static int boot_trigger_buf_len;
 static int nr_boot_triggers;
 
 static __init int setup_trace_triggers(char *str)
 {
 	char *trigger;
 	char *buf;
+	int len = boot_trigger_buf_len;
 	int i;
 
-	strscpy(bootup_trigger_buf, str, COMMAND_LINE_SIZE);
+	if (len >= COMMAND_LINE_SIZE)
+		return 1;
+
+	strscpy(bootup_trigger_buf + len, str, COMMAND_LINE_SIZE - len);
 	trace_set_ring_buffer_expanded(NULL);
 	disable_tracing_selftest("running event triggers");
 
-	buf = bootup_trigger_buf;
-	for (i = 0; i < MAX_BOOT_TRIGGERS; i++) {
+	buf = bootup_trigger_buf + len;
+	boot_trigger_buf_len += strlen(buf) + 1;
+
+	for (i = nr_boot_triggers; i < MAX_BOOT_TRIGGERS; i++) {
 		trigger = strsep(&buf, ",");
 		if (!trigger)
 			break;
-- 
2.43.0

