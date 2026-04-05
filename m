Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A3B1A285
	for <linux-trace-kernel@vger.kernel.org>; Sun,  5 Apr 2026 16:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775407158; cv=none; b=nPWMFL5DszyURkGINIRltGS548uhJ4u24R2TRRybr8NNyS/BF/yurypiPfV3remH7ZYzM/D9mk3wvCvZlUmTdI8hJXZSVJtQdGSP4cWQUPDWsykgqOJKbFgKdZlVQ5SXICy8orjEVGEfYiVGfIw5DyQ46oJc4om7wCRGo8CY5kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775407158; c=relaxed/simple;
	bh=k0u4N4f0VkVrnvs3LQrlN9FOtkjFp5bVcDpGR9ErXNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VzQNb3WgyZMGFIFn/vGNu+2CIBqtdKH0EF78P+wurQ5YenYlURTX7osJ4XYMSWx46WvtMFGjGBadqJcf66qXBYDnMUOo0qYWhnIB1mb+v7dqdkmlVE3gyPfweq857kOuSJtmPocKWZSlwpmNnCnEHH0Ang7A8+BvG+cBfU7g+rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LGX0sbLO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LGX0sbLO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775407155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5LiNsMTv/b4oQHjiG7soW1r21z4Wr3WQGLyz0Cz6HLM=;
	b=LGX0sbLOuoFCEspzFAd0YdZ+EImCWhHlLI2+OqtAYIrL+9QXcDCLexQ5gr+JZDyF8DJM0O
	sjxKTxg4xBCzOXjWaJ3kYjhY0c7g60EiZlUS9Euh7av/Kh9RhbpTGI/yJ3S7YbYHGUMBKL
	LlJCbK0p5d0F0Q3Ab2DhQQgiRhonxzc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-4QgX8KeCME2IhG54gA-CRA-1; Sun, 05 Apr 2026 12:39:14 -0400
X-MC-Unique: 4QgX8KeCME2IhG54gA-CRA-1
X-Mimecast-MFC-AGG-ID: 4QgX8KeCME2IhG54gA-CRA_1775407153
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488b171f1a5so924925e9.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 05 Apr 2026 09:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775407153; x=1776011953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5LiNsMTv/b4oQHjiG7soW1r21z4Wr3WQGLyz0Cz6HLM=;
        b=TDzgTeIs/NscZsUZjlRao6PhKe9/cW3lS5bdhO7bz1KdeyEDW2TIL6ACp0ro2Lb35v
         mizZvxSk5EXOQvgXDEvETVTMQnjSajXYYPwOvKznG+/sciuf7qKFmyBeZQXIL5H+iWYO
         nhh+CQ0w9Wx68Sc6FcWzcIw/EH4R4sZNCvel/WSyXKF3Q4TiWVTAsm+YtLlvqw3Jt+bx
         aAIetVmBCI0kygVQ+1KmtxbiNcCQ0hWG4Q7hrd4A2dKngdAjFxXuXszc3rs9krYtPwQ3
         mMxQax2CFa/wv6y5keRGrZ9ZqLrLgUNf3UKXEzZxBzj4XrKbezt+u1+vYjkkqQXmrrLf
         AWzg==
X-Forwarded-Encrypted: i=1; AJvYcCV7PoLTs9OdQ+uyIIR5DShZxAHlQ8UFZsnGUELSE4ZJFbyXa3EzepJicKq0dt0l60dg+5z/LmmuTIaMnoWr38CCaTM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7HjcqwIVQFI31Uyl2EEnJe0jX2MTJh4AjZN0bI9JuFoR0oWYv
	qLppHNkGQv7sEipnLKbuC02f22EQ1p5V3rEY1uHL8+0lrCc4ewLI01GkwHQ5l0rgnmnX14X8LKj
	hMzk8XEXukNhovRdG2BvrxszfXPVk4AJ0tf9PW49UsqN4xbCxtUL+ERXgs8iijl+275hExJoqoQ
	==
X-Gm-Gg: AeBDies2elQP5pIktdVGaRoTB33HTy5tIZ47ek7aLIhvSxcjCR00TO4WF78DQaUBmUv
	NP0NuQFaBuTMWsteErRrynez0VmlN85BMstFeJHgM6B2215HrQ9+41wjShFz0x30yKd2kNkUeZ8
	mklU8tJnt/P/eKR2U9MsczlMmwgaVA8K+++odxYdl/TosCHczChNSjjI0mVrkdwj31c9KkrfiYV
	+YAvwo+P799C6jioDLWeMdbWxSwK9YzZiqjY8lpz3HDA7NGeXLyTcTvCXUMSVeKGfXpPRqiix2o
	HpkUugQ/s0d76MYf5XRXnLBz28uShX/IF9rgmzMiUlR2rnc5jfVZofWB+j2Q35BzmQi4NdOtwn1
	vRr8Q64v/lHgT1E/GCpgP8F2Y5NqBGeT/hUs=
X-Received: by 2002:a05:600c:3b23:b0:488:869c:edaf with SMTP id 5b1f17b1804b1-488996df052mr129887875e9.8.1775407153030;
        Sun, 05 Apr 2026 09:39:13 -0700 (PDT)
X-Received: by 2002:a05:600c:3b23:b0:488:869c:edaf with SMTP id 5b1f17b1804b1-488996df052mr129887685e9.8.1775407152541;
        Sun, 05 Apr 2026 09:39:12 -0700 (PDT)
Received: from costa-tp.bos2.lab ([2a00:a041:e223:1b00:fe51:8bb:7986:c897])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488980e3b55sm72143575e9.8.2026.04.05.09.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 09:39:12 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: Costa Shulyupin <costa.shul@redhat.com>
Subject: [PATCH v1] Documentation/rtla: Convert links to RST format
Date: Sun,  5 Apr 2026 19:38:45 +0300
Message-ID: <20260405163847.3337981-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vzQoKeBQNb4Vars-szYGjQ_ggOKRzbFCVv-R3t1XZ8g_1775407153
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Web links in the documentation are not properly displayed.

In the man pages web links look like:
  Osnoise tracer  documentation:  <  <https://www.kernel.org/doc/html/lat‐
  est/trace/osnoise-tracer.html> >

On web pages the URL caption is the URL itself.

Convert tracer documentation links to RST anonymous hyperlink format
for better rendering. Use newer docs.kernel.org instead of
www.kernel.org/doc/html/latest for brevity.

After the change, the links in the man pages look like:
  Osnoise tracer <https://docs.kernel.org/trace/osnoise-tracer.html>

On web pages the captions are the titles of the links.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 Documentation/tools/rtla/rtla-hwnoise.rst       | 2 +-
 Documentation/tools/rtla/rtla-osnoise-hist.rst  | 2 +-
 Documentation/tools/rtla/rtla-osnoise-top.rst   | 2 +-
 Documentation/tools/rtla/rtla-osnoise.rst       | 2 +-
 Documentation/tools/rtla/rtla-timerlat-hist.rst | 2 +-
 Documentation/tools/rtla/rtla-timerlat-top.rst  | 2 +-
 Documentation/tools/rtla/rtla-timerlat.rst      | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/tools/rtla/rtla-hwnoise.rst b/Documentation/tools/rtla/rtla-hwnoise.rst
index 26512b15fe7b..5930bbca4522 100644
--- a/Documentation/tools/rtla/rtla-hwnoise.rst
+++ b/Documentation/tools/rtla/rtla-hwnoise.rst
@@ -100,7 +100,7 @@ SEE ALSO
 
 **rtla-osnoise**\(1)
 
-Osnoise tracer documentation: <https://www.kernel.org/doc/html/latest/trace/osnoise-tracer.html>
+`Osnoise tracer <https://docs.kernel.org/trace/osnoise-tracer.html>`__
 
 AUTHOR
 ======
diff --git a/Documentation/tools/rtla/rtla-osnoise-hist.rst b/Documentation/tools/rtla/rtla-osnoise-hist.rst
index 007521c865d9..6ddea2c6d490 100644
--- a/Documentation/tools/rtla/rtla-osnoise-hist.rst
+++ b/Documentation/tools/rtla/rtla-osnoise-hist.rst
@@ -59,7 +59,7 @@ SEE ALSO
 ========
 **rtla-osnoise**\(1), **rtla-osnoise-top**\(1)
 
-*osnoise* tracer documentation: <https://www.kernel.org/doc/html/latest/trace/osnoise-tracer.html>
+`Osnoise tracer <https://docs.kernel.org/trace/osnoise-tracer.html>`__
 
 AUTHOR
 ======
diff --git a/Documentation/tools/rtla/rtla-osnoise-top.rst b/Documentation/tools/rtla/rtla-osnoise-top.rst
index 6ccadae38945..b91c02ac2bbe 100644
--- a/Documentation/tools/rtla/rtla-osnoise-top.rst
+++ b/Documentation/tools/rtla/rtla-osnoise-top.rst
@@ -54,7 +54,7 @@ SEE ALSO
 
 **rtla-osnoise**\(1), **rtla-osnoise-hist**\(1)
 
-Osnoise tracer documentation: <https://www.kernel.org/doc/html/latest/trace/osnoise-tracer.html>
+`Osnoise tracer <https://docs.kernel.org/trace/osnoise-tracer.html>`__
 
 AUTHOR
 ======
diff --git a/Documentation/tools/rtla/rtla-osnoise.rst b/Documentation/tools/rtla/rtla-osnoise.rst
index 540d2bf6c152..decd9e11fcf2 100644
--- a/Documentation/tools/rtla/rtla-osnoise.rst
+++ b/Documentation/tools/rtla/rtla-osnoise.rst
@@ -50,7 +50,7 @@ SEE ALSO
 ========
 **rtla-osnoise-top**\(1), **rtla-osnoise-hist**\(1)
 
-Osnoise tracer documentation: <https://www.kernel.org/doc/html/latest/trace/osnoise-tracer.html>
+`Osnoise tracer <https://docs.kernel.org/trace/osnoise-tracer.html>`__
 
 AUTHOR
 ======
diff --git a/Documentation/tools/rtla/rtla-timerlat-hist.rst b/Documentation/tools/rtla/rtla-timerlat-hist.rst
index f56fe546411b..dab75677b06e 100644
--- a/Documentation/tools/rtla/rtla-timerlat-hist.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-hist.rst
@@ -104,7 +104,7 @@ SEE ALSO
 ========
 **rtla-timerlat**\(1), **rtla-timerlat-top**\(1)
 
-*timerlat* tracer documentation: <https://www.kernel.org/doc/html/latest/trace/timerlat-tracer.html>
+`Timerlat tracer <https://docs.kernel.org/trace/timerlat-tracer.html>`__
 
 AUTHOR
 ======
diff --git a/Documentation/tools/rtla/rtla-timerlat-top.rst b/Documentation/tools/rtla/rtla-timerlat-top.rst
index 72d85e36c193..05959f1a4661 100644
--- a/Documentation/tools/rtla/rtla-timerlat-top.rst
+++ b/Documentation/tools/rtla/rtla-timerlat-top.rst
@@ -127,7 +127,7 @@ SEE ALSO
 --------
 **rtla-timerlat**\(1), **rtla-timerlat-hist**\(1)
 
-*timerlat* tracer documentation: <https://www.kernel.org/doc/html/latest/trace/timerlat-tracer.html>
+`Timerlat tracer <https://docs.kernel.org/trace/timerlat-tracer.html>`__
 
 AUTHOR
 ------
diff --git a/Documentation/tools/rtla/rtla-timerlat.rst b/Documentation/tools/rtla/rtla-timerlat.rst
index ce9f57e038c3..63718c52aa3f 100644
--- a/Documentation/tools/rtla/rtla-timerlat.rst
+++ b/Documentation/tools/rtla/rtla-timerlat.rst
@@ -45,7 +45,7 @@ SEE ALSO
 ========
 **rtla-timerlat-top**\(1), **rtla-timerlat-hist**\(1)
 
-*timerlat* tracer documentation: <https://www.kernel.org/doc/html/latest/trace/timerlat-tracer.html>
+`Timerlat tracer <https://docs.kernel.org/trace/timerlat-tracer.html>`__
 
 AUTHOR
 ======
-- 
2.53.0

