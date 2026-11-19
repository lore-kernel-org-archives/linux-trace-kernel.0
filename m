Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795057745;
	b=NsuRlM2Chog4li4t5w0w0SArate1cWUXZ+4TNByOGYxWmLi5dzo2TZT+hP2hN3W9LLHl
	 jx1tti9nhUnwruagmeVJ6vvQJaXBDEIIcw4nsswzBNkQwwMlugRhU0FvFvHVyZajpqk8T
	 1xG7Ts81rp1SEYpezjMd8uW4s6DWC3hd/mCIV702lnDLeRsL4dOOigu9Pvsr/dSc5gd66
	 2KUbXUI9dM33PE8sy2iswbyWbz1lD78KCrS+uBoVPIr4kL6P2mpZUbSsHtaGOSGE9Npou
	 hqR+scYfZEqOJeJLzubtXluOQSd6dLrXy1rz5m9dXrlIWZhMvqaGafG6DUCpiETOEYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795057745;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=r7dnxHtK8RkgCgZSr6np7k+vnrFRmkzlCepNeeA4tmg=;
	b=bIxk7gsSMCQ7ZEoxUhb0QzpW2RJH34SfSVjMEFZYU6XfwHQj3tQuUAJECg9VcH5cHhzC
	 ZDcZqjp+/CqXo9r8xsspXXwoqMSknvmrVxMkROg+oUMtvmlcIKOzJD7p9WY6axdYf+C73
	 JTv5BCx62aCzq3T0AAH9jl6njhb0b5yHov0YQefAa7W4PZYyQ+HROt8ecxkHL9btaoffE
	 lVuFdvGOjjh07M/6uTTH/t9q+r82f9AYY3vr9SDP+EplQ96pskwIh0W+Ik2ZsoFy+9NEs
	 YC9dKeG+r20hM0s8HIjMncYcmb5meU92E11V3p1nDlsoHw74DjXavoduYrrwBVz9vJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D87I7va0;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AC9606A32C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Nov 2026 03:09:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30AC9606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D87I7va0
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1b3a05f8b5bso2274578c88.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Nov 2026 19:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795057744; x=1795662544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r7dnxHtK8RkgCgZSr6np7k+vnrFRmkzlCepNeeA4tmg=;
        b=D87I7va08/wwoduX335hDH7kRaGyO2QauSdljCbfwvtVNeqkYXqR5ZmB0QDcFwlD2V
         dgF7JKXPZcN9xxEInSwljqBKzOVIaLZcZgpPcD2bJu36IC7l2YG/EQE7YO1dUcSyBa50
         +E8xBTMqjfMQ24WeUn7lyKs+4mms80/9FfWTyjpfs2LKT77Pdf3rTRVhmpQD7OkWZfIL
         nRJIXvZ7JoLzv8wNyKKEZfN0LFRJSJdKAe8v+eFoPxHe9iBdI/0cHZP6T9UhOEqmwoRe
         jzJEucCdYbYax5E7J09n6Mv1Y5tv4+soECOcVr61VyyvTRyhVJzdt+zxWzSSz+5lo1kR
         PFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795057744; x=1795662544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r7dnxHtK8RkgCgZSr6np7k+vnrFRmkzlCepNeeA4tmg=;
        b=gGGHyKpWxpvqK6QDQ+NeWWiiRA92m4+3yW0VPj7Jd5EhEOOaDh5B+Xjz0iLFQm4PXR
         d4RNB9RQ/uxQbYBl4zu1IFkZp5DBo+IVfU0QKENBdMF8O//tP5YQRXzIMAqkEUarWPvV
         HxvfJu+OMkh9CxbMC4pD0neTYqKapRC4QHU5iVDBSvUibej1R0uOtOCpPEAVxdD76muY
         aczQL/KfGlScfEA7vrfoSEN9eWXRFPO8rt7FhHFxw7FrkJ0gKZqXZxY3CSSmFEAMQAYk
         E35Xgoc2L5UORhjkbGWK8l9zOthofpg+NLoYhip4kkVKPOOoMuo8e2TQlK/AEJKd0MhQ
         MM0A==
X-Forwarded-Encrypted: i=1; AL+hErERMhnU0uZ5l/CO7Sst4lYBjYEt3zZDqIYenuH/huV71dLYEB1BFFHQY0rl3zj97lytLJLdNFCl4U/VA3AzfrIOIzI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Y5gEccAe7IgKBdWHzyPuo4BVcsQ2kBIxjTmLV8EQdh7sUSpl1
	50epx3rwwhp4RtZA9xXt6r8gN6dlrOWI06MZy/X2R8hOku+O3ZDxEPuF
X-Gm-Gg: AZFdTZd70XuDPjPMIgWTeUzDo+Hx3pXGljYqJCKG07hB141zX+2QDalF9JWy9yjjUHn
	FfvAuf9J7DkMb9gF+Cp6rT2V0/2zszOne6eQVijLjnHlD33YTtT/L4s+tC2p8HdJJTGygVpwf9A
	TMKVjWJ9qEKmyEDwUNWB/f1K45ui8Pp0xY2CIhKH+kZjcFJFwJTx0RY+gSrog7FZZFWzWQYLr0n
	qK8Hy+xXyVdkuDNzfcIvDTFVgFDhh26wdTGy8ts9WjGGWeM4wa1tAckWBHjDbpejJ75RJTvMPni
	bIVVRrUIkc8X+0pLZCBp+U3KS1pbkpZtVZIggXR6O2PVVxPcpVtd5BxZ+ArgBl0inqjWzrJv5QS
	RSTWbALmi3rjMbnt9w0HtcocW6FWxn6I2JqNZl17pGDtWo107Vy0jjptXdDzips3WK/ltw9FvD0
	DnWQvHmI3ndi29C3jre/dMNiwebZgnLcsco7fX7rV9r7yK+sEIKWcLisqXKuyOAVq3RdGyRrQmE
	dmiszqj7WlSjTjNA/oHcVjk0LRXybgp2EhAShUzzm/5yX8fw+5z3/VpFMp2FbA2KGmWVuCOCXZo
	GOwg+CKFTdjF1JvsFXiffcdfuK6afp9mUIyeAObxFIdGr0z/8f5EZYuayPRHfIH2yeQmh8pMxrz
	e8Ch2aJt1GqFK8B4yWu+k+1nO0HtYhU9VV5Dxw8fAB+MJ+QXLQ/PAX7rgMhc4T9Cd3gqXgRRQ
X-Received: by 2002:a05:7301:428b:b0:36e:b05e:9a74 with SMTP id 5a478bee46e88-3828161a511mr4153472eec.30.1795057744246;
        Wed, 18 Nov 2026 19:09:04 -0800 (PST)
Received: from localhost.localdomain (c-107-3-155-154.hsd1.ca.comcast.net. [107.3.155.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3843559c264sm1991115eec.22.2026.11.18.19.09.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 19:09:03 -0800 (PST)
From: Yifan Feng <evanfengff@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yifan Feng <evanfengff@gmail.com>
Subject: [PATCH v2] ftrace: Reject "!!" in front of a set_ftrace_filter command
Date: Wed, 18 Nov 2026 19:09:00 -0800
Message-Id: <20261119030900.37343-1-evanfengff@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
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

A command written to set_ftrace_filter with two '!' in front of the
function glob triggers the WARN_ON() in
unregister_ftrace_function_probe_func():

  # echo '!!vfs_read:traceoff' >> set_ftrace_filter
  WARNING: kernel/trace/ftrace.c:5675 at unregister_ftrace_function_probe_func+0x662/0x870

The command callbacks strip the first '!' and pass the rest as the glob
of the probe to remove. filter_parse_regex() then reports the second
'!' as a negated glob, which function probes do not support.

Return -EINVAL for such input in ftrace_process_regex(), before a
command callback is called.

Fixes: 23b4ff3aa479 ("ftrace: add traceon traceoff commands to enable/disable the buffers")
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Yifan Feng <evanfengff@gmail.com>
---
v2: keep the WARN_ON() and reject "!!" before a command callback runs (Steven Rostedt).
v1: https://lore.kernel.org/linux-trace-kernel/20261118032637.80038-1-evanfengff@gmail.com
QEMU, all 7 probe commands: one WARNING each before, none after, other results unchanged.
Found and written with the help of an AI coding assistant.

 kernel/trace/ftrace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index c7d74b33d36d..44a861f021be 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5846,6 +5846,9 @@ static int ftrace_process_regex(struct ftrace_iterator *iter,
 
 	/* command found */
 
+	if (func[0] == '!' && func[1] == '!')
+		return -EINVAL;
+
 	command = strsep(&next, ":");
 
 	guard(mutex)(&ftrace_cmd_mutex);

base-commit: 4405c18c95d2d0f99f6c581ef0ee8591a1aa6ccd
-- 
2.39.3 (Apple Git-146)

