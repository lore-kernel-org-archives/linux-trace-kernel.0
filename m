Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD0A23BCEE
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Mar 2026 21:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773091653; cv=none; b=NC5W7k5NALqqlle8eYhL6VR8FDJvAJQXhXmdpkqviIRmXCLB+49xV9Ns25LKSEazhDOR035JkyY8ZDQjJjsd+ohduOXQpqoLpHydc16uBriZAM31858IHD7fx6xjoZbJ2hQJFVIDaVItfrLnVAxLgSa/FNlPtf5jnI2/vaBFc4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773091653; c=relaxed/simple;
	bh=Ywv/x9EhLwlHPf9krwL6fJZT4wCkg8aoD3Bhobn0fAk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d8RBF7KwSSOsIB/Ujy+k+u5cbe9nu40z9wsVSvs0QQktQ2BYYqLGRzpy7rzNoSYoq6xdSspvdrEiimxY1tq+MTcdOnKY5NvEXmkC8Gwxqt4uoB4PLYy2XXm0VDa6iLybpVv/nStoxOUzJzuWm3pRY/hhjN57fa8iNhTbyALRfJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxYhMajW; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxYhMajW"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-67bb39a1122so846152eaf.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 09 Mar 2026 14:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773091651; x=1773696451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FgH6nxj6mipRLEO/qlV2727swuhWygQwIW/mErrecfQ=;
        b=bxYhMajWlTLTG9KZ4aUIuoryrQgKH0Znj55TvIgYHynlPrdHB07m6USnLQGqd6LzBk
         fKQUcsFKb/aZJYKPOjVMk6MWM+OavB001UtVDWkrPyfJpldb9tc/upg2RO1mleODtTgN
         8UmI4QfOiDdLq7E/fnHg316ofOEFZOamLM4roqp+lbj5Eay9GRvG5TlgFZZq11WCOlOS
         8m5ef57EMe8T57w4q7LbHivL/7TSjlRvyNub8NlSWoMF4CjFCfqE4A8wkAAuarGrhQeF
         9F5YOkDpCXq3c0Cep4Z1zKEnpDwowjMF/hvxshFVqHKqGQaIikvwEZvBJfwqB68Nk9Og
         X1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773091651; x=1773696451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FgH6nxj6mipRLEO/qlV2727swuhWygQwIW/mErrecfQ=;
        b=KeiQSQQA/E8N/Nb/TwVKrn3sRpph2yWIFs71hHXxMd8WQk6dqlJ7D8zs8jWaWvhbwZ
         kSs6a/uR0opCnJoY71O+nImilmJSZ8zrfMje+hpsJWA+G+NbkGm5VFYF3dsl7+j52ZyZ
         0KtxooKhPg9fcDzAJOzUHyd8x7haGrUUARZxlc/9Dh/0ywCDJl05sI5CmV6QL7ImrTkG
         cj1766KNmLi1gqlStDHpbvIIvpDUovuaSisuUeY8OZZwoPnFPdMmFY7JVt4Rhyg6Yww7
         bmDDQadOc9K7aJ/8KfvfwjEnJaV1KoFGFNI4k6soI3G5u16my96I/qCu63rPNmG8Fon+
         tBsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXI5dZV6T+0fiBpzOBzKLj0QXUz7J3UWtSLBfuagIVG7W3Hyq3lzLCFjvXtI00cyJT5kdXnXrZMx7ATIV/m8LiBcwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiFz54rQpMb3LVJGe8/o45XaTTUnhSb85f7igjhIOvMj3GL441
	cIbHUdTwwkoLPd+3mT/KRxrd4vBI5noy8G7Hk1T4bZDMzbEZDHm6DrIZECTVeR8/7KQ=
X-Gm-Gg: ATEYQzxkA0unVxBG0g1mr3tMZcGLSCc4jRdk2nl9Nefp4lxNhsHuYnddqEzG0Lr0k9C
	0wnKJavzp9q5090oNXKaTA3MM6Iu6sGc0UEgU6b0b4vupzNxA5umymdt4qgCNzt7X6JFNubsj2e
	mY+vp/NbkBKncWi7gp42xC6j+fsmk+bBW3gPqpsbbZa7yI6Tg7fMx/PVfEVRSpK6i/nJ998iW3H
	eXpWfqERXQ34S6rhUTaAHdClYTdBMvShNVPLdGcdS57JCrL2LFYFQkwRTmef63dc3eR2P1F7gi+
	Dz94LwQuPWTutxvjcnji7o0QKQv9I6/3k84b0H2JhwGxlOUbWQpukjR8LWyU6Kgci5AIBJs7H2B
	JAqT5lLu5pwbIpHrLUKcGK4TCmueRigsEngp2WV6Fdiczw364CV7VO/fqiRBl2u2exiMFfO4Tcq
	jbh1JRvBblxhGmXnJ8bRbBRBNTXY28stRFyqYBnmT6WvoEZDjhrVSgTgeLY1427W0CpKYeG3eXQ
	VFM99elQ92ezSqW8kqs2831e9p+EtQMfo3zqW/POqGwq5GC
X-Received: by 2002:a4a:e842:0:b0:677:4fc0:a852 with SMTP id 006d021491bc7-67b9bcd4c6fmr8270896eaf.34.1773091651461;
        Mon, 09 Mar 2026 14:27:31 -0700 (PDT)
Received: from localhost.localdomain (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67bb3bb67fbsm2639289eaf.15.2026.03.09.14.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 14:27:30 -0700 (PDT)
From: Wesley Atwell <atwellwea@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Wesley Atwell <atwellwea@gmail.com>
Subject: [PATCH v2 0/2] tracing: preserve repeated boot-time parameters and drain deferred trigger frees
Date: Mon,  9 Mar 2026 15:27:00 -0600
Message-Id: <20260309212702.13622-1-atwellwea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 preserves repeated tracing boot parameters across the affected
early parsers.

Patch 2 makes deferred trigger-data frees drain correctly if the cleanup
kthread never starts, and restores the review-requested comment context
around the post-mutex recheck and synchronous fallback path.

v2:
- Patch 1: no changes
- Patch 2: restore the dropped mutex recheck comment and clarify the
  synchronous fallback drain path

Wesley Atwell (2):
  tracing: preserve repeated boot-time tracing parameters
  tracing: drain deferred trigger frees if kthread startup fails

 kernel/trace/ftrace.c               | 29 +++++++++--
 kernel/trace/trace.c                | 23 ++++++++-
 kernel/trace/trace_events.c         | 23 +++++++--
 kernel/trace/trace_events_trigger.c | 79 ++++++++++++++++++++++++-----
 kernel/trace/trace_kprobe.c         | 23 ++++++++-
 5 files changed, 155 insertions(+), 22 deletions(-)

-- 
2.34.1
