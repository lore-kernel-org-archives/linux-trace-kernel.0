Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795729954;
	b=R+WxbjkTNBbuAL4O87pwXQBDLIh/7suzFUs1+y7l/pBcZ9ru99uLAAbYzvou2cMpP5p1
	 IiQK/dphWttpeHFkUNW1gcdAjzHAKmS9qTOtqiUMeNe5EU51FpW2wkKz0xBRdTHT27kq4
	 fBOBkNH/KQAfjPFmnzgspYpEtuQgPcbmSyROL6T5jYSqUU6GVP9yYIMHF7f9xR3gvDuLS
	 3WX32ZaGGNrvvUGvUOqgfSB+qhm1RWGOIJWJpLd05B2g057tI6jqhq8EvTK4thEGoAlQ7
	 n/yqF+alm7fucqkUg0HITh9FIC4fVygiNhLZrWG+6uC+5soFR85Fao7fmcWs81/H9jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795729954;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RPVjfXymlZhaC+9syUEih0oV6JaxiWkxxyBiag+otps=;
	b=P3Q6+Qe5MKk35SOdPYP+wrp9y5MEZN+MjMHdqqKoRbngvcJ2J4TIlluM7ellrr6PIcLz
	 99kDqRssM9OBBBtpu11saZ4kSyFZVaIGQruYqVYXZ2VGT4B7Bmd5s3/8D5tRD5a62T9bj
	 qSP9PZz8ZgilL+idwit36TpaTrpob4coOTzrSBlA8/agihDzm1ThBjN9OsMVP7tYmRk4y
	 wVeOmRQKLRelurpzQ9RuOVyUHLYO6dMXzztao0v8/R2gITux44kvCv6A2hmWRIuXGEuIM
	 7uZ2sYfamqzvpPuke/VA91EgdfiAttgfwFRUoVwrigA6bxzWWmt7LsOjjFM9f/KVZhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A0D+bXLH;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EAC606A31C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Nov 2026 21:52:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06EAC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A0D+bXLH
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so60699675e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Nov 2026 13:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795729952; x=1796334752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RPVjfXymlZhaC+9syUEih0oV6JaxiWkxxyBiag+otps=;
        b=A0D+bXLHuzEywM/7y6O+KwNpE0sbzFoh/i8DwYTAiBHOitSTz+u0x7DkMicruESpSW
         3u1dSjDMiGxqisIfAMzZqj+V8EmPKJ6Njh4PHdEedQ5lq2M5HCB+lEqqrGPF5ASo4kY3
         zRa3a4kBSGRqvaw+50mtcF58XY+DOfDa5InYvhr5aJcRSV7AIEH3TFL3p+VBMXB25qHL
         R3/HK3P+I200tAE1lXlRc6Agpu70rTL8+Ls28oj/JFTVfqFUDDGV0GtqPQUJYyw3C9Kh
         R0hyKKHQeZaRFeSNhw3G3pl3JC7yU1+0MHW0+8km1Dnt0qVTg2Q0DyNrvofGV0TMgxIq
         DEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795729952; x=1796334752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RPVjfXymlZhaC+9syUEih0oV6JaxiWkxxyBiag+otps=;
        b=QnBgXvqKIIWxUNWa1hJYJzELA/C5u7zJe9ozAhPXN6lN5G5/R0uT6kYAwEq4/8P1Hl
         /qi1c2IOkNIMfx2mSgL6sqPsT2xmuIH1vsrpVXRd02eq/IDduuPGWYLz/0DY6Xoa7OyS
         e7/dL/VCR9sFIZbXkhZDdes5cs5ypl1SQCfVx+0RRq8v0uvRw8beBZMKOAkHjEIuozwA
         U4yk7JcZ4mN+Nr3h0MDbDeXwbwSe0POsUEwJnMbQ/5rpeDEW7iAIJWCZeFUTGN28HXIo
         f9xgGURcoX3xWMRxeo2/WXprNe5an+vu/f0p1bDdiSkXer3ThYp5WXf8QxVdP9t+wr4F
         ndAA==
X-Forwarded-Encrypted: i=1; AL+hErFhLdU4YQfEGBBiKTB4+EIgyxu7cf/rzzuOU+0hv8yxs+5fMoMK/qBUQtJ23E2wF4gwSZ8oQQrGqzuSzSJZade6XEo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/6kHI+ULFObF/Cogj3HjckOryqFidVqfHGIXcTUlRddWJplhAu
	MsqKe98UgHL4+3dg9dcZ+X8CbxVBqCZ+L9V9uhJaerlJz03gHZkVDihHaSji9g==
X-Gm-Gg: AZFdTZcRKOFY2G6YqNwFdFJlVRGeiUxb5eSELt7eequ+Kd2uh3ihKRLsdWbg7pBJqDF
	Ge5TDkjoCAq9m1X+IwPP6MiIdKpo9ofBr5qWXDw9oi/WfnSy92EBm59bED6/C9PSQB+yT8mn7/e
	Mf+XSXvZ+P6q0AWrbiZwHSygTlOIc6G6VBN3NYGtgHUSRSsuxdgUiOwcPXsXbDuU/3Jpo12tRHe
	8PPmvq23lg4DwqrBndN8dLDMdDuSdkk4PUEc7ryi5Pl85JWNPn4auVLq3Pve3WYaQfuJGpZxKSL
	zkFem4b7CH+3CaakSHtjDovlK144CBfZcE60PvOZUS9mUVtSYbZsgzyJXBnzY/0F2TalWBB+qvy
	kXdYq/oPmt9RSn4ZYctmbYujLFdo6BPHFqpSvDZB/KGvCaHtZc9+xuiHmurhimT1lbl1WHpeKnL
	9qHGNtmN9Zt1oV9+zdx9+9D2i/NiSA9dRkY/zoW/LwB87qOXrdmtbIExU4RsF6PlU9ACNZ2ikqG
	6c8QBVSyrPDbKFYCAyyVYuCmONi0xNR/SWWqT7DWYAaamicvbBJCKPRKk7u/UU/rX+16jmvOTTm
	gP0954/2JwJH/6yigREQi+IJrYhf6NJhr4LgsyuXTVFj40l0tPBAyfKXSZzYNq/fhUsP39wY+OF
	X6gXQkkSKESdF7A==
X-Received: by 2002:a05:600c:828e:b0:4a1:e6a9:4086 with SMTP id 5b1f17b1804b1-4bb88785a99mr427460815e9.0.1795729952237;
        Thu, 26 Nov 2026 13:52:32 -0800 (PST)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884ab091sm889543065e9.11.2026.11.26.13.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 13:52:30 -0800 (PST)
From: David Carlier <devnexen@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH] tracing/filters: Fix MATCH_END_ONLY on dynamic char arrays
Date: Thu, 26 Nov 2026 21:52:28 +0000
Message-ID: <20261126215228.1205862-1-devnexen@gmail.com>
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

regex_match_end() takes the string length as "len - 1", which holds
for __string() fields where the length counts the trailing NUL. A
__dynamic_array() of char does not have to be NUL-terminated or
filled to its length. The xfs namespace events copy name->len bytes
with no NUL, so the compare is off by one:

  # echo 'name ~ "*.txt"' > events/xfs/xfs_lookup/filter

misses "foo.txt" and matches "a.txtz".

Use regex_match_end_str() for dynamic strings as well, which finds
the end with strnlen().

Fixes: a3291c14ecf0 ("tracing/filters: Fix MATCH_END_ONLY filter matching")
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 kernel/trace/trace_events_filter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 42a57cb57ff9..68a20f5d68fa 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -2076,8 +2076,12 @@ static int parse_pred(const char *str, void *data,
 
 		} else if (field->filter_type == FILTER_DYN_STRING) {
 			pred->fn_num = FILTER_PRED_FN_STRLOC;
+			if (pred->regex->match == regex_match_end)
+				pred->regex->match = regex_match_end_str;
 		} else if (field->filter_type == FILTER_RDYN_STRING) {
 			pred->fn_num = FILTER_PRED_FN_STRRELLOC;
+			if (pred->regex->match == regex_match_end)
+				pred->regex->match = regex_match_end_str;
 		} else if (field->filter_type == FILTER_WITHIN) {
 			unsigned long func;
 
-- 
2.55.0

