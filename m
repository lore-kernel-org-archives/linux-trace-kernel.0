Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125E1376;
	Sun, 22 Sep 2024 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727011908; cv=none; b=tH95NPRsbfC9YQFL74eOrLzed3QoYgOb/T4ZoSOIWje7g0nyW65vPzbHmppjSLrNTcDuQ5pspE+h9Xe6YyDSpmkJ0IUdzpI8Gdti7dQ85DTdXdPw1ftvgtyKOTjSqZ3jay4P2IvxhLeUJSnoaHGfHGPQGMc5sVnngWhWaiZYMFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727011908; c=relaxed/simple;
	bh=n1V31JdnsfrSdsVXN7bDlOoQ3BVtUu/IioetLfG4smc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=POoGWIK9WpN7XpoAashgLmaCxbZ6A7/tldOXiPUAGmOIwanmLnQpxEOKHw3pJYJZ9fLnLedOK4lEgKg8psxmiD+qKD40arik385LfIgFE0T3UjtoWtA/JewxdNskBIC1hmsdd08FaZCtEXKTpOhwUryBsJBsqfvFkItOkrSIvqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QJk/qhus; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJk/qhus"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2059112f0a7so30865295ad.3;
        Sun, 22 Sep 2024 06:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727011906; x=1727616706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FteN1NVxM87RoJV6pgBXiOh96b1d0IQZBxvTcTzb5no=;
        b=QJk/qhusejDQI7hKdSJ0T1QoaDpS+Des+HZAdTGrCXIipN9rut6PwHnVsphM2sRbDG
         U2c9fv9v1a/BCmr4LmTZBdhruBdjeq3wigm31bZM7xAOQvIKTLAFh/nozeiUcQp5+M7q
         PFHQO0hsWppshj/2hnNthgrFI1IL3icMWRJDKpDnoOuhVFWui86HldGyV80W2cbUNiwy
         c1D3/7KM+P4yBb09cdT2GnPYqbU1r7cNFlE1iaRhNJ/jsrYCyVIQmKI8TuWsvib6itih
         qE1pRpKA9glo1xDtkA64leeqYUdMqYUZLog3Dc/uLL/qiTXF7RkZ32gNa7dO6vhu8CDb
         1nFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727011906; x=1727616706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FteN1NVxM87RoJV6pgBXiOh96b1d0IQZBxvTcTzb5no=;
        b=Il4NVSyMkxV9Jl2bdRvigStcqIzHsG11QPSLDVTyhTl/A+x3gWZUiiT8/kQXkaoR7v
         2Cz+mDAt3c3CHVg0Uew2DbOxHQGubjcYu8lFE9C2HXKHPfTroEYMa8/KMSlJapTwwCMO
         802w7dB7hIgiuS9Bya1odn//siXLMS+6RkhZIhESL16fNToqMkH/Ywat2QJZV1lWCZTV
         YtxlWrVznccNyM4Q+Xw+LRFPZOw8G0i7RQaH9KYv7hCuE17Ev1SbFMaV0sfXLlz7sjqb
         YKAyd0nykmC0UaGvMQxdn/Ii0L9TCQ4V7/imrJCS175QqdCkdmz9GwQWWVdKaRmch37L
         uY1w==
X-Forwarded-Encrypted: i=1; AJvYcCV6I90KrGXq7o2a7+KVNjfpNbReBGJ57Y4GbnR/d8MlcrHJZ3ltzq0pTa5plZ9DZYmdQUKqe4v506snQP/lUjW8g5yV@vger.kernel.org, AJvYcCWDWOsEs8f2H5aOpScP7yjPLr1kiBHGCcrYRBHv+TyBm+KrlWpeiqjwGKXsjJC4bSr9YuSOhgrmYb0=@vger.kernel.org, AJvYcCXPXsC6sG+Wm7aVvOJUMb7skwIyd2UzaI9lfj6K5sPk6qKYwE2YoJJMuVoDR0aRs98m28CCLq3hSxAYGoPU@vger.kernel.org
X-Gm-Message-State: AOJu0YysC+xj5w865/M5V9fy3Z5l/zN5zO+senCF1zcTBeQwiEklvsur
	MW1JfsXBypNtUVFuc8XRUW3E1A9dl2DB7YuOZCcYqq4eQoX2pXbG
X-Google-Smtp-Source: AGHT+IHhgNAHLVFJ4uCDYFpKauQ1a4rjzI1C6yXb7CGQvMsulRV1fZT4i2gUEYjDvoot92MxL2WJaw==
X-Received: by 2002:a17:902:cecb:b0:207:6e51:41af with SMTP id d9443c01a7336-208d83fc79fmr135416405ad.43.1727011906111;
        Sun, 22 Sep 2024 06:31:46 -0700 (PDT)
Received: from 0x7f800001.hitronhub.home ([2407:4d00:3c04:81a0:f26f:1ad7:c7bb:baa7])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-207946d27dasm119972225ad.172.2024.09.22.06.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 06:31:45 -0700 (PDT)
From: "Yo-Jung (Leo) Lin" <0xff07@gmail.com>
To: 
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	ricardo@marliere.net,
	skhan@linuxfoundation.org,
	0xff07@gmail.com,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH] trace doc: document the device_pm_callback events
Date: Sun, 22 Sep 2024 21:26:28 +0800
Message-ID: <20240922132636.34413-1-0xff07@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation for the device_pm_callback_{start, end} events
under the "Subsystem Trace Points: power" section.

Signed-off-by: Yo-Jung (Leo) Lin <0xff07@gmail.com>
---
 Documentation/trace/events-power.rst | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/trace/events-power.rst b/Documentation/trace/events-power.rst
index f45bf11fa88d..7031954f7ed3 100644
--- a/Documentation/trace/events-power.rst
+++ b/Documentation/trace/events-power.rst
@@ -102,3 +102,30 @@ And, there are events used for CPU latency QoS add/update/remove request.
   pm_qos_remove_request     "value=%d"
 
 The parameter is the value to be added/updated/removed.
+
+5. Device PM callback events
+============================
+The device PM callback events are placed right before and after an invocation of
+a device PM callback during a system-wide suspend/resume attempt.
+::
+
+  device_pm_callback_start     "%s %s, parent: %s, %s[%s]"
+  device_pm_callback_end       "%s %s, err=%d"
+
+The first two parameters in both events are the same. They are:
+
+  - The name of the driver.
+  - The device whose PM callbacks get called.
+
+For device_pm_callback_start, the rest of the parameters are:
+
+  - The parent device of the device (if any).
+  - Level in the power management hierarchy the callback belongs to (e.g. power
+    domain, type, class, bus, driver). Some stages (e.g. early, late, noirq)
+    will also be explicitly mentioned in this string.
+  - The ongoing PM event. You may find definitions of those events in the
+    PM_EVENT_* macros in include/linux/pm.h
+
+For device_pm_callback_end, the only remaining parameter is:
+
+  - The return value of the PM callback.
-- 
2.43.0

