Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9E52472A8;
	Sun, 31 Aug 2025 10:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756635511; cv=none; b=X9oWjHwigAiIBQRZlE1dxDyWYLGNNj4hCsloGtlWGgFxBTJWuHCLgdeCaFj0uVBb48qDCjmkwNRk1f86qIuYbxDBnnoyeQI3D5Qi3U2f7L2HbBxoPP9JK5QV0hWHvN/NizXZlzICHUu5HlZq3lgZwChrMtb4K8e1QGvxIkMb0qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756635511; c=relaxed/simple;
	bh=D3PAz7xolElE1kPDF1ZM09nYrEAsUXU4EAkgU2JL/Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g6rrGC7+Y0BmySiy3fdX8CS30nBL+vPytWpNfSFpw8mNkpiBMoe475uRxtvpoF/OgryGYdVMgFYUh+6P+t7AuEW0FeXhN2ioqRoFi8BHaDMNznXwSN5RewWGnYg6VYRmPwgx1dIwgol2/VFpIbO9ruG2+qLmseu40r3585xFlRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRDAp72j; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRDAp72j"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7f74b42ec59so190897785a.2;
        Sun, 31 Aug 2025 03:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756635508; x=1757240308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwLs+yd7Js8fsBQIKUi8xZzZqVUjN83bbv0x9rLvc8Y=;
        b=cRDAp72jqE4I4fzo9ONUe8fhVkkqt5lvy3Hl1+dEgWkZaKaOQkQpzl8jUy4bAxOcVU
         NVuZpbCVoiLyFFTbj6hOpXPP/mVkKMUazdPCi1GAui3Is/vXLR0E/QceQd9Hx4Vszbyl
         Aoejxw+FLiEEtU47phG4zT+l6wMiuj+BdiZtbtZtk9UuHhPcLHkgHJRE48As82ptbLji
         TCDZFQupYQK3PkNpLQJn/yVolXhDMJ/loY+Uv2gvWCwOLmnzg+GbisgIw28DdSSWIJRZ
         4nO2cmX0d9L+5aSj25PQVZTHgHe4fwvV37JGkz0TWsmljERmSk7jfVdB+cDLAeRl8RNl
         9Rkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756635508; x=1757240308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwLs+yd7Js8fsBQIKUi8xZzZqVUjN83bbv0x9rLvc8Y=;
        b=M+B3f8n4uhqB1CC3yD3QG0h55XKHIud73l+bpLDnePW/aB/lkhEcAQxGdchr5+06v7
         Q8bVZdkma62Xtg4B5oGWPS7p5fasTDP8knBx/c9qrMxZWA6kXLIRN93ou/BfmaHBch8s
         bj8hFob4EauLC9SKOFNNokI68ruOWEBvi1wLtTYnmW2YUn+8gOeDs8neH6poP6tovz9H
         ZUJIh4/K6UAOQYoVQNC4IJTOPKEGIY+e/qBKUnsU4RyGUns4F5s77sYS7GpZWTE6FVaX
         haovwLHgZHEwOaQYFKJ/wy6fhqt0rPQ69TWzxPV0fj9xrcsgHRc31ppG9IjkR3CIaDzb
         gwLw==
X-Forwarded-Encrypted: i=1; AJvYcCWRC4xaa0cbodTdYNXN6Jm5dwb9a7Sx3cZ9/bipt69Ip9XeM3ZAcH9p/B4wZG0W9jnUPCRLgUNiv9M=@vger.kernel.org, AJvYcCWUS8vqbygqreihSqAACPSE2P74G5QQO2QEZlX7Pi/B0yOYlL5fMyC58iXOYGyHhLgAB3HoDR17lX4/S1Fk1+bBmRTD@vger.kernel.org, AJvYcCXB2DhMG2/7c1/SjO+YdSDrUD6EKdL6OtlvsB93ZmRhzKDUYkHMPKxFS8FiD/E+0WM4LWq1BYfHt0dxI2w4@vger.kernel.org
X-Gm-Message-State: AOJu0YwrHhbbvwRpv+FkxeW29yyC9BY2WTAUBWVCYPLRUIs+djJaCXVT
	WW8VHxUgBzO48Hsvz6B8NHxHxgOSYiAuNJxdGEfIieYD0Ra5EywjWB7e
X-Gm-Gg: ASbGncsGYb+xfKeDFheDoN3xemyTpgNeGSqCsMWt09ra4kWczNo+gOVnwiiotgB0OxC
	V0gnG8S96qH1S5voV5FbDBoTCqyO+eyloIiHoPTQRzCoGcLnCmgllmbWwXRZbyfZtFkPyfwruCn
	2SXvdFR2wG6S0dFds082/unDXj7XaF9YcFr11Qc1jG9m5Ak1lHmzOp9XEvwpIDgc6vaVY3fGTW6
	JiX9dIJnNMbaDPRy7P0fGBDRfniGDS8nuAK8LOonGuanHZJzcBRiJjz+K1xOSS/HeHjlaaqqJCA
	Wwda7y7PMWnrbiTVa3owjjg5aDEZNrtmYK/1f8FVtGMl/r8y1xZCwNRHV1jy29QK9lCN2IWfpf8
	HxUTtChgHP7y593fsd713r7WYbX6j6bCXjtpuChHtqlVwug4HUTuTZWB9syvEZLy5VcSfwmdKw/
	rSfw==
X-Google-Smtp-Source: AGHT+IH/eV42QnaFtl89dVVjuVTpB+Zt97KCO2m8CKyT/G4y34cLbd7mLHdxEz/Q63Z4Y96xfRXdZQ==
X-Received: by 2002:a05:620a:6081:b0:7ff:9fdd:c34c with SMTP id af79cd13be357-7ff9fddc7abmr418325685a.67.1756635507955;
        Sun, 31 Aug 2025 03:18:27 -0700 (PDT)
Received: from seokw-960QHA.mynetworksettings.com ([2600:4041:4491:2000:1bcc:1b67:3f57:d21e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc16536012sm480262785a.66.2025.08.31.03.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 03:18:27 -0700 (PDT)
From: Ryan Chung <seokwoo.chung130@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	corbet@lwn.net
Cc: Ryan Chung <seokwoo.chung130@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 2/2] trace: fix grammar error in debugging.rst
Date: Sun, 31 Aug 2025 19:17:29 +0900
Message-ID: <20250831101736.11519-3-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250831101736.11519-1-seokwoo.chung130@gmail.com>
References: <20250831101736.11519-1-seokwoo.chung130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Ryan Chung <seokwoo.chung130@gmail.com>
---
 Documentation/trace/debugging.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/debugging.rst b/Documentation/trace/debugging.rst
index d54bc500af80..4d88c346fc38 100644
--- a/Documentation/trace/debugging.rst
+++ b/Documentation/trace/debugging.rst
@@ -59,7 +59,7 @@ There is various methods of acquiring the state of the system when a kernel
 crash occurs. This could be from the oops message in printk, or one could
 use kexec/kdump. But these just show what happened at the time of the crash.
 It can be very useful in knowing what happened up to the point of the crash.
-The tracing ring buffer, by default, is a circular buffer than will
+The tracing ring buffer, by default, is a circular buffer that will
 overwrite older events with newer ones. When a crash happens, the content of
 the ring buffer will be all the events that lead up to the crash.
 
-- 
2.43.0

