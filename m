Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686361;
	b=PB+wPSIHcjqfugfcL+Pm16aJQ5jbTQjr8Ztn2fcLOyF06QbUVauknfslBq7OktelPGD9
	 GvYuR2mBG5ich/MbSz25yOoEAqma+3MBqSKOjPlt0evlVmGYcCINafpR1z219J7Lh369G
	 sQWq31BJ4jqiWrXlWVF9daT0ZIGi9gYKfB8o3UZWzX8RYtiNiModaXhq8FIgylhlKoVW1
	 +Nj2LQYhaZkr7FZuQeebFOHbyO0WH/VsLBAOWpsgJv9dHvcklIMVfGKo4CcsAbQLPCHQd
	 x7QFMKQzzH7xUeCYMfCG953ZXCPKZSZR+y5IsKQlHtnL6q3un21gW2K4uvg1qO+nxaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686361;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kEf2B9QYpi3ckJDBCR/s09wzAUjGwxpz/3KtgUVx8/s=;
	b=LuU6X88hiWNpMCYk4AkX1ZQiubiOP/6pRvywxQ5fsPZgbpY0DUcFtHyw+sjmtEzkbMQn
	 c/k4xbZSKIXD6ldQaDTXetp+T0KDNdzaBr2/lsmCqTUWkfJc4PgyQQnyKy3XcYfxD0YWY
	 s+IPqwNz6b1cwMPaFdoT0sy4mraZ1/D9PaurwBIy90SE1XiUhGA8SwrOGndq1ApanaIhw
	 WDUvN3TXe2UXYSBwJsmC/cgY0aA+04AodgDn8t5lpSXfg83ypm+4NemAcq1fGyoKoNHaE
	 eC6Qv4WOFBndIfG4tahTmb66iOaQVM8KbMutJTa9TLMakOGvxxrQRHuLGi6TF/cueKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=epNIjQ67;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D774C606A327
	for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Nov 2026 19:59:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D774C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=epNIjQ67
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48b001cd92bso1491992f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Nov 2026 11:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794686359; x=1795291159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kEf2B9QYpi3ckJDBCR/s09wzAUjGwxpz/3KtgUVx8/s=;
        b=epNIjQ67nCN3j7wLAT7F/mQhaZcAZaFpGbT9sEyMcTUT10Ob81+mPa/O8MX3E1hUU5
         jk5WPbgcZ9mhEoktRxGqidHA+EwmVOubKe4261DXsWhZ/LbKRj4vef6wVToiW8hxK5n8
         7eCRornhAole6nBV/nY4TMAs08cTMpWYExHjwAiDKB4oTu8B0HGHRkpICP2Z+LgnopAn
         k8HYEhBuaUkoqyka3MPupohJYTqB04ofUspDvdnGKr50YJdVnU/19aKaaHqQq2VlnY3i
         UXpPIRDl0KIsZaeLYqUZj+naeNShP8N+7JlWp/THRL/i8QhPPNcOrliM3JgVlblvplmL
         +CxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686359; x=1795291159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kEf2B9QYpi3ckJDBCR/s09wzAUjGwxpz/3KtgUVx8/s=;
        b=OhlVij7/ZyNWB9RUbx5+y5We6MzDR4/2jwb1YqI+INRXVFsuS+3flI8+2ioLCjhh7J
         uU5ppI/v1RWE2oqGP62gZZO+dJz1MMv7LGWOIvgxYFJPIW9lTTPSNX0nlyAf//hUIYHH
         bgUpcKpxSV9k1vtqqyGguk8rxgJgh4J2+5CWH0LpdohhGeURO8fwDaBh3Cpw4M5bd46Z
         mGrGXf4e6sFkaesqZuIjcdlhoVzgcAIJb5p6e6RNmgb68D8C768Ipajlkkj3bPqGMy+7
         nVY/egF+8lvc+7ZFmurkSM5L9Xi9oW8D17x8QV0OGY7tqXjlmrFk49we/EhK2B0p9iIb
         sWRw==
X-Forwarded-Encrypted: i=1; AL+hErE1d335KPbsezWzz28TlXT/Wt4DDLlxO1GYCc1D7SR18VHKMJibQ0Vx3zkYs+Wxiyj10XgRAv81jgPGre6G4bvnfAE=@vger.kernel.org
X-Gm-Message-State: APuU4Z94/WHJJ9wUKyrZLpCdMOG/H2avc2bSuJpE5BjqVP8nacUbloaO
	+Khhmy41g/7nzSxPyT5slN8gk54vWOI4wD1PXOMOT5LzpBzxDFAw4jEIkZmAwQ==
X-Gm-Gg: AYBFou0x2DIv5LQZHDid1KWiOndXaDzJhYQUilvbRFGrClq3OSSOTCus5ZCKpLhU4jn
	3N+o9+tVWxgSssKbshDfMglabhQCSPangEBqzWx+wk2niWQI3XbOiSIunAsO5YU4IxLVPsFszWl
	2ttubyMKBq6K7KRFTSWlkd9qu1j5kuTbFf5DqBKBGK5Ol12dPMVKVb9qaaSgwkNNZIJmqp7UTJV
	hgK8YYEbmJtnFm1mYNauYcAWz/+XI5D+IHy4LYErtOqSO1xkgC00LI3vTCgUe99VUEr7l/Rjx2+
	3g7fJygHRaQOCIKlFOrF+n/Rfq1Nhnv3KTagVe2eYxhAV/LWdaPRH24YtaQxiGT2wSMPfqp3T7m
	OF3mRWPboZq+VYieRhQaq0YcFNHwpYJTUnNQKg5ZRmiY5WPJ2FFHjh289Ty4OxqpjfyEMpcITRE
	SUn1sMEf5iyBd/3t3H555VByzmtOwenW7R3iwhS7N/TuWSmr8f1dzQvr6OH6N9+bmnYAdgueILM
	oCtpz+1oWh3aTDIVIpeIqUvw6QEQB5ctZ8r4NHvYe+M4ULXZk8ebKcMe/kAUQWRcSHrS5CDQCem
	e15s98WwFak0hulz0ueM1O25EpAkSiaMc6+aLOiEmx9fb/XLcWeKK2g5pu3NgMeWqR9qaD3ydv1
	lVK8aKn9ITvxU58Ylg2hpIgEo8oIkukqJmwc=
X-Received: by 2002:a05:6000:3103:b0:48e:5cd4:aa60 with SMTP id ffacd0b85a97d-49c71783077mr13999489f8f.42.1794686358935;
        Sat, 14 Nov 2026 11:59:18 -0800 (PST)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f782396sm12989691f8f.24.2026.11.14.11.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 11:59:17 -0800 (PST)
From: David Carlier <devnexen@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] tracing: Reject .function on the function trace event
Date: Sat, 14 Nov 2026 19:59:14 +0000
Message-ID: <20261114195914.2678414-1-devnexen@gmail.com>
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

For the function event, parse_pred() handles the .function suffix
before the ftrace_event_is_function() case, so "ip.function == schedule"
builds a predicate with no regex. Setting it through perf then
dereferences the NULL pred->regex in ftrace_function_set_filter_pred().

The "ip" field of that event already takes a function name, so reject
the suffix there.

Fixes: e6745a4da964 ("tracing: Add a way to filter function addresses to function names")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 kernel/trace/trace_events_filter.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index c10951bcfc5f..11bb751c4388 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1743,6 +1743,12 @@ static int parse_pred(const char *str, void *data,
 	pred->op = op;
 
 	if (function) {
+		/* Function events already take a function name on 'ip' */
+		if (ftrace_event_is_function(call)) {
+			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i);
+			goto err_free;
+		}
+
 		/* The field must be the same size as long */
 		if (field->size != sizeof(long)) {
 			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i);
-- 
2.55.0

