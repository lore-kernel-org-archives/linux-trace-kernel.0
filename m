Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794972405;
	b=UspgQhZh/EyR7xqZcYPE1N+lMMQX+UwngryaMgqhnd+c9rFC0nGYOKqoSzK6OQSYB1Nb
	 +/cpUJKpOpSGLM8onnYgWe4AQETV5gSWG8d4tSmKJ8ElmAjLPPsSg9rcNJH8ay8JgkxNk
	 IddicF5WjGTQRHoX5NA5X6m9vEFitQQjipQt5qHUxAFWePx3P1DrqRpcD4mQ+dZPsjYmR
	 NHjRXFeFyzRQUFSavLT0nYmpbCFJywe9RrByWUXrhxH+bcxcjgF5eHNl3FJ5MrqxuO7P6
	 GRd3sdqRSfBuGbZvVvHDSlG8IXtAl6te3d4xu5CcGR+7D/L3qJaP9oLsPic/jFFz27w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794972405;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jazbHSOeO1s+D04SmCfdJ3dJxyMlyxBweqHPXFLi7uA=;
	b=nhtw9bKb2jLzi6s8oApDZbWGmp9fY+SpMTd/FnKcAOmGPzOpLjW9T4n7ThqcsFd3khvH
	 fQjMU1Gd4eSr/aRxeKiHBETBXOYUDukKbi0Yo3BShGRFLjwl2s+33mZ6tbeveihEJsR8G
	 E3Yb9JuaYN387M07Ib9VcDqZvL2prc5cGTsxNHLcC6WBpiBYEGlyBTo67QHFYA/6uBdDk
	 s0zpdxEj8nlNVQFzyqiA2rTP4cvWhRu8DNDZlylqnXRS2+3r6PnZD92PhjIry60UNLWnz
	 M0FQUVjRBIiROYjrryks/e5hX4GI/nA7CPFdOpIvxxep397i74L38brDL0ilr0w7GTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fBTihxqQ;
	arc=none smtp.remote-ip=209.85.222.178
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B846606A325
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Nov 2026 03:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B846606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fBTihxqQ
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-949680e6d82so67372285a.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Nov 2026 19:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794972404; x=1795577204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jazbHSOeO1s+D04SmCfdJ3dJxyMlyxBweqHPXFLi7uA=;
        b=fBTihxqQSgl80uiOYL9+huHNub7fATEQrkP631o5o5MD6dzR7LeeFyOfgtNzl0iDG/
         LEThSq3RSRInaRjJRANhxsdGQZNlsh4+zWHW5V1tsXAZGYexA0Z2EJUXpfVl9ZWX9BPi
         pq4cPE6+q7QgvYaCukS+LUOGX729vKimMVdjbf4Tv/OJ3eie7iv9RywhaiHgYZzB0e1f
         tK9bZAiUA+bBUORFt7M/Vx7kh2FTHXv9Y22jKk1fAMYfCtOOtcMwLkAtoUP73pRiAmx+
         aYZJt8ujHUBTDHTDNLx20lAaWNvWGMBYecW9JTaJDu3PyhlbplTS8KA38HiadqEIvNod
         WAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794972404; x=1795577204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jazbHSOeO1s+D04SmCfdJ3dJxyMlyxBweqHPXFLi7uA=;
        b=DU2zGnhSl90YLWCRdXU9AX+KKv5Hrf4d21d6YvmSITf4pVvQQGd6wzwtTEcjyVZkx9
         zmsCkuueWb6TvND7PevgsDx3z+NIS1GHXK530AwoVSQM8NjVFnnUFo/86XXFyDlRmwkt
         I7iPsnYxqrz9PXVqZuTROB9+9L5U68+r1Xk8YQ/LKpChJAB9dQBH8RLq6EvXEe0QeDSf
         IV5dIMiKDsM7V0eA+PPqIeH+bFm97TbeU0T0jknyHI3s7g6VQhMx6jv8IT4ME1iWdi5Q
         TGcrkojuRejl4onXh7T5gWdmskbWeZXGvy0x8YzFsmLY29CLGbSR+nJ3ubsk+xmWSyZH
         Rbug==
X-Forwarded-Encrypted: i=1; AL+hErHHBO/DukKmpRckKPtuDHz8m80PHijBT0VRkidtUU4ChVIZ5jn/DHJOJzzoRt9l3BkzBtKyKgCJRL8lHahmmqDe3dk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9sp582qgv58JJW9if97RuYDFYWn0EiN7I99FWj4mUIX/IJlgoh
	HbuINfuog15/tpdwg7xASAUuoI9TPhJJE6hAI7fue1Za7F/mWMsZ7a2N
X-Gm-Gg: AYBFou0C6MnRit3RxSjLySEZO/ifDH7ICim+yyYQzFD6qCz+wSNd38l7CSnMQea2AYP
	WS6hRNaDn0vjs1WA6eVUbY1Xn7xkfUUlVFm7z/52XtizfVB6S3cxveiNnf9pvRZgQIlUisGmy1F
	uEdIg0ZFuKDpxJSGbERzPg0Zp/JVzU3wpguqqFJ1vyq2y5WNb/YJp66KkrDwfct/PPjbxrgRTKz
	KBQthJlSctqG3ScwVmbII73yuOS0qd2CoFzHv/wtWnYwMsAg8kIybgrN2xiMxma332LQJ/iceiC
	QySvBR+QoSnXO9N1R34wXoG7B7OxYaXZfH1st57oGBeZ0HAdgRQrlKM5aZKDVhE4ZsYwUUE1LaF
	klGJNuLc0s6e2/PWw7DxQ249y3F4QhOh/QpFgd2QrJVndy4YBhvAygO7fU+IjLrtwc9Xs3GzezD
	S5hWZmMs+Zyid1qU0gei/h51AxLWFKaZQjxYMI55IsqcqNUyeI4srC01r44auKR/pOUcny8/eGc
	yFdieUmnc2H9rAJajEvrITClDUVNkvqcZEafTZtQOsNoPTDAD8vD8OMzp0PdvRzU4bLfRoSUsWO
	s4QcXH7WzFcXI/dnsWqHk0N4Ck3mJrWwBwZVpPyS9QDLWLDnYsdQ1mn2raHQr/hO5sqSZTjuFBO
	JE8K4SsfrVR/+YB10PQRDTJkc0TF4/PstYIfz8TQ8Yx3nhzhtd/o2HesWuk+6P4nH0li9i8nm
X-Received: by 2002:a05:620a:4805:b0:947:7f5e:2b63 with SMTP id af79cd13be357-949995b0531mr300152385a.34.1794972404029;
        Tue, 17 Nov 2026 19:26:44 -0800 (PST)
Received: from localhost.localdomain (c-107-3-155-154.hsd1.ca.comcast.net. [107.3.155.154])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9499b75dd62sm79267485a.21.2026.11.17.19.26.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Nov 2026 19:26:43 -0800 (PST)
From: Yifan Feng <evanfengff@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yifan Feng <evanfengff@gmail.com>
Subject: [PATCH] ftrace: Do not WARN on a function probe glob that starts with '!'
Date: Tue, 17 Nov 2026 19:26:37 -0800
Message-Id: <20261118032637.80038-1-evanfengff@gmail.com>
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

Removing a function probe with a second '!' in front of the glob
triggers a WARN_ON() in unregister_ftrace_function_probe_func():

  # echo '!!vfs_read:traceoff' >> set_ftrace_filter
  WARNING: kernel/trace/ftrace.c:5675 at unregister_ftrace_function_probe_func+0x662/0x870

The callback strips the first '!' and filter_parse_regex() then reports
the second one as a negated glob. This is plain bad input from user
space, so return -EINVAL without the warning.

Fixes: 23b4ff3aa479 ("ftrace: add traceon traceoff commands to enable/disable the buffers")
Signed-off-by: Yifan Feng <evanfengff@gmail.com>
---
Tested on v7.4-rc3 in QEMU: WARNING and taint before, -EINVAL only after.
Found and written with the help of an AI coding assistant.

 kernel/trace/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index c7d74b33d36d..04ea82a18601 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5672,7 +5672,7 @@ unregister_ftrace_function_probe_func(char *glob, struct trace_array *tr,
 		func_g.len = strlen(func_g.search);
 
 		/* we do not support '!' for function probes */
-		if (WARN_ON(not))
+		if (not)
 			return -EINVAL;
 	}
 

base-commit: 7ccb044c27720d48175577080b851f047ddcfd1c
-- 
2.39.3 (Apple Git-146)

