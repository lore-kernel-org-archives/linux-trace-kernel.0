Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795729946;
	b=ZtH+1PHKCEoIl8blUyi9X+eI72Xqm5jRxKaLBDtnkzn7w3xrhI8ZbJ+pNpW3e+v3NMz7
	 MWxT9nL6f1xOEYkKVGZfWkzyoasyHEeays744uxWBcTgnn+hSIkqHZ5Jv68YZn29+Bkk6
	 SARdKj9SqSukkBXgtnYujvoWk0G4kU/aYZ2zwaUgSmeFnZh76xFvbhJA/gd24M7i78XIF
	 MkOIQCjT4FBVTHHF4jP7xAUkA/BNz+4UYWLGwqUcqxsErsqFJbKg0XV5Hi/LZImBUrD0n
	 GsYRJz80oAHm/b8PhTpB1duiZLshrdNUu8yYACRMgS8/kDXakiLTRlMnTWi493t/0ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795729946;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1YnQvOR3Gw4bXN9YUJx9Lq77dYCC8vrMp788asvQVV4=;
	b=jBiqe/6HiBp1TbhUz8uGOyr8r9+bHmoQmHxisYElnd/uTOeF+RZUGaaW1rYXi9DOE8Mn
	 qQCNEwpFfOKUyfk/QYW2fjCGI0cgztqjjnYBcUNvFYZHYgw971wT+g+UpUDls5PSHdGIq
	 +rZRSR+v9P+cv99MTz6fuB0qc6prfkLtYYXK6Se+egLqwxq+y3cZ+o3hyX4k7frA2rgzT
	 +JY69N+hhyBlNS9eGc5fiKC5/vcRkpFZHufdrzb0gXjVQ5ER0L/MNq3oMEbGxdzppvW4N
	 QAJLryy7+glt6vyEiYkPxJqP7p6nKbaixx2P89++WvAy2mLinTexPPb8bF9d8Vj+7Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rhRgkBfE;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499B0606A31E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Nov 2026 21:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 499B0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rhRgkBfE
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4acb44dcd7bso6709559f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Nov 2026 13:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795729945; x=1796334745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1YnQvOR3Gw4bXN9YUJx9Lq77dYCC8vrMp788asvQVV4=;
        b=rhRgkBfEQfLvE1Z0jzXnQdFA1S7obYbq9YpsAIojpl6lupXu83Qa5rnCMEmkz7SO+t
         41S3vzCyfG8ktfvgZJWMACce9N+m7McHMQTKFOLoCo8zW/hcnfGajl6RfJrLjcTc1He2
         UfBAnxJQaKBHT416TFk+Wu/t+727QrqAhGcygteSR/r/cDp3OnG1znT4ecUN4OX40ljo
         XUG94eZFv+FQ+zjkaoVoCxXcOurqdDdhnB7oTCWhbX0yH292J6KtTZLJWPtptUHQMsV1
         qg/aLV2L14jtCGCHCkjCDVOMKXOGDAp0BLqoeYbcCGG2Vdj+H3s1vzXGjv/Ix1753Gs1
         3j3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795729945; x=1796334745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1YnQvOR3Gw4bXN9YUJx9Lq77dYCC8vrMp788asvQVV4=;
        b=Od+HRuDyQnPavGoHagqnKT+oqXFcYJPcA0u4aeO5v7mCCjbNUeaIBJwjB8NRpAiITp
         fFgS2qyvVwQyUyyyUFE55pGTIjQP+chc9+0zhnQY5AxzXHCINkLWEL3p5X5vF5xgapbB
         zwcPHgkl0omRQzC9Wfd0vP35klxMP4rJt/g0tpUvi5ya+yNZAFKW5XuBJmNle2YdTfkX
         lsUvm5OLBsxS/JpsvlyC8xX0a5lU0ZUO/oITYzBaC/F9q+Aogz+na9OySbjFy9dylqv4
         cfMW2IhQa09VPXhmyhDBRxLJuxz2rCA84EvFjttA1AEEYmkv/7FkCFQbGu+ymh1ZZQRD
         qz9Q==
X-Forwarded-Encrypted: i=1; AL+hErExTqyn33UCWwShnsiBSXoj59Gi8PebD6WjozsfUhhL+8qMNyXONjZZSzgxDjkrZ1smJrv4/pLOZ2uWsSUORkDq7OQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9JJsNGjJQk/zZzOqNm9D6yTeCXhqtdKKYBuno5aE3SrlZ6oypu
	mruVO9K3f4D+BRpZ4GhvaL5IbhpcPQErcmiAQsGnV9UAPwSS7h9QBtjI
X-Gm-Gg: AZFdTZcZk3oR6R8Svv7DgVSeXJWzeF1/AQ0EeKVOLYJSbQS/Im0mxwiXy2G8vImBF3x
	828ZrLPWLfkvGOZiWTVAXPMCBgKvsKw277UABkIzxmP1S8iH0BZpz5vIig/OtRn5TGVHm6fjUzd
	WHadeasPknaRiy3P4UV3mj23f+ltLr4NxPSFpXoi4RaHG5W/FK8zxuT7PaK+8b/JYqiBk/WRmUT
	WGlNivlnqRFPG54cMrsESSNCYFukPqwck5iH53nKXg1YSsoeVcfd4+v7pLrdS6S2QxPdnGzIMQL
	v1jhXSSVh8jgqaGY3vnp+jWf7CD0FfWFi/P0mKsIv8Mlugcf8CR1q5rBQjr3egYKuMqFskyW7kY
	9nrGWQfpka3QxjPykiXV1eTmPJu/Bp7tOSrXbRRC35cnNSY+5w03E/E9DjxxWFVx31hwLYs1i9x
	P2VubmaCfxbs4aiZyFKjgC8H5V+Zrv7YKcc86UYDSRV2vDtKcpY05MiTKOTb+F6mHYYKEaqOfTL
	0zpd9uHXPrlW1AY4KwbZfknWMUwWk9yuVjDjGzrg3hZlgn2WXraHI1GyegZBGn3JVW9gK5hHmUE
	XhXYoj9joU2hXr1l/J4ls0mYes323k7K8Z5lZPgdmkej2KJfySsym1Hft0SEaUE+l8ho74vQjBg
	UIb/uAROlF+MfzknUbVoFwe8jQPe8g6v8obg=
X-Received: by 2002:a05:6000:2c13:b0:4a6:dfe3:fd93 with SMTP id ffacd0b85a97d-4abb41f4dc6mr41417768f8f.40.1795729944154;
        Thu, 26 Nov 2026 13:52:24 -0800 (PST)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b8b7888sm42820523f8f.42.2026.11.26.13.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 13:52:23 -0800 (PST)
From: David Carlier <devnexen@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Huihui Huang <hhhuang@smu.edu.sg>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] tracing/filters: Fix glob matching on zero size string fields
Date: Thu, 26 Nov 2026 21:52:20 +0000
Message-ID: <20261126215220.1205315-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "buf" field of the ftrace print event is a char[] of size zero,
and filter_pred_string() passes that size as the length. The regex
callbacks take a zero length as a NUL-terminated string of unknown
length, but since regex_match_glob() was switched to glob_match_len()
it treats it as an empty string, so a glob never matches:

  # echo 'snapshot if buf ~ "st*r*"' > events/ftrace/print/trigger
  # echo start > trace_marker

Use glob_match() when the length is zero.

Fixes: 0a6070839b1e ("tracing: Prevent out-of-bounds read in glob matching")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 kernel/trace/trace_events_filter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index a9d77df3e19a..42a57cb57ff9 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1118,6 +1118,10 @@ static int regex_match_end_dynstr(char *str, struct regex *r, int len)
 
 static int regex_match_glob(char *str, struct regex *r, int len)
 {
+	/* Zero is reserved for a NUL-terminated string of unknown length. */
+	if (!len)
+		return glob_match(r->pattern, str);
+
 	return glob_match_len(r->pattern, str, len) ? 1 : 0;
 }
 
-- 
2.55.0

