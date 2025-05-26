Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9271B87D9;
	Mon, 26 May 2025 13:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748266930; cv=none; b=OnRygGG8Hz7RiqRhfE935YsFbGJJR3Dk/QhUTsjrZNx4Pe7WYlgdGY/Nd2YaMLRxLY/Wv1EAWKQScl1v3gY4AtSZog5ZrResORPmpX984cz+BvdgBiABeWRuIWmrnlUNV1wreFu2vswVUC9PmX0vP3e73SMUlZGI9zSa5zA4g38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748266930; c=relaxed/simple;
	bh=N3jCi3khROE9TVxPRzpAHw/qGx3uAUp6MOKY3QNCs4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JVTC6gmCYN1PDkwaYWdNh0IDXHOx6MZr+nwmcHkC0+P7dI0RHllXFpOQW85/XOphMxNmI/FfNhXPepyVi/W/nY8hzn2oWIXNV0ZrYT+/i8vC+oHvJGI0InpTggC/lisMmQzZkbSVEeHiW3pyeWb9iw4zzxS3A7POhGkn9RFd/v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mN2HstQS; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mN2HstQS"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-742c9563fafso1463295b3a.0;
        Mon, 26 May 2025 06:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748266929; x=1748871729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=frQ0f0BJwDjiH9T/6GPovLUqHWLGL0+6wkcrVa4bH0k=;
        b=mN2HstQSR2AhpcSfn4fg3YSHDDSLzbQJJAK29f/IWKhQg2DrctltXPsNeJe+y6qZ6A
         y3O0lUaJzdes87oK+x7apoA3vHjaRGTjJhswsmCXO74Dtjsu8jGQCZ+iIfKCvoZPHzia
         IeFbTSzGwkuCgRA2qX8awdzJ+m/7FXL/GdGXGChi0GdwKId+lZr6lVrVD7q7NUvTmVmJ
         P953UWiE02L4Rk6+nmNBn6BbejpJpD14fRdVw0okOrr46ecsbioO2y3D13+EHIcXSLc7
         9E/VBwczEXrPQPXrKa5c2UWF0xC/mz6tDB+NUtM+8eSnjjZHGccgauV7ZPxEkf4Oev5i
         +l8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748266929; x=1748871729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=frQ0f0BJwDjiH9T/6GPovLUqHWLGL0+6wkcrVa4bH0k=;
        b=gHIM1JqHj07HBZioHPGTUDJqsvcy/uj158Lce1t/inDnpzEs5Ecgw6kBDEHng57JV+
         TNyo8YO/XFfApO7q5sTu/+6JMh9Ez6Ri9QVPqyG6SNhPvzzRMJiZG4ffxRejapIr02ch
         EaeQiJRR1xM/X2vf2abx3SKqbSsbnuwyE/Fngp/oBGK9oLBJDhPQyGyaRceu3IoeQIN2
         cc0S8er6IjEKBdljjzf1Nuc+lG3fGCIp5FcnPgyXAXXgsj5M1ruBIdXsQXVCDdlK4nch
         7z2aoknXqeHJRF/w5YTvE2Yz/vtgStK+vinTQ/zdXOAjABDvWozMtAz/TyjzJNlAYNvj
         DRLg==
X-Forwarded-Encrypted: i=1; AJvYcCVnGBNj0beZGCs5Eh8J+Y0Z0HMKF3eZprCat2JDwAK3cyL3X9o9AYSNH6Hzp2PPm0FGa2dqMt/ZtCaN4OThN7nvXji9@vger.kernel.org, AJvYcCXzjW8EtSvbdIqGmwHo04XuAQIGl3XypqOtP0+MhsyrNDClXmj8UKL4uE+pn0Lam1pthIZkp5LX5Hc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTECNIXHAqhBFRcUWbrKJeVfw61dqz28kxUSEIFO9WxkF/ImE7
	fwgLhfLxeODW/KAsW1VpKxoCKY2ghUjnjOLIcK5L7opEWdxB5qeGHj/c
X-Gm-Gg: ASbGncu7sTalR1P3pxI+zMzACo30x1Ji5zT+cQ7xx2ditVQ6kc0VnXVnwVlhLC7NEDO
	KFGF5YBuw9kpTaM4/AkSZ0RHAHkH0uHdz1yyWjZygKcDYB/PJY3UyemmzkWKwmnn170fg304qBi
	vqvAeReZGXqf1AC+FVP56cPHoASNlHTTKFSo5JhCJ5lVqvMyrPGjpvITThx07C/Eid0I49BDIg/
	WWfs1cI0anItFIxp59mBCSXpJMKcUiwp7FMugxgJD/vjHoKv2jRChxuMvz6WtTk2N54F4quXcTA
	JwQEWbY2mA50QhfrZBQm+JyMDYz2TNIkBax5qLSof6lBCdWMWj+dndLl5oe73BCDmj8MQoKUfvh
	Qf4JA5/9AHCZZxclh3Fs=
X-Google-Smtp-Source: AGHT+IEQyBevUUoLQg/Z4I8nbFN8HgNhcgvl1vZj+oKXKoJFa4vLR50xWZEaVrPbo0btIVShWkj6yw==
X-Received: by 2002:a05:6a21:38d:b0:209:ca8b:91f2 with SMTP id adf61e73a8af0-2188c2992cdmr13559656637.19.1748266928668;
        Mon, 26 May 2025 06:42:08 -0700 (PDT)
Received: from localhost.localdomain (183178125027.ctinets.com. [183.178.125.27])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb084936sm16872453a12.56.2025.05.26.06.42.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 May 2025 06:42:08 -0700 (PDT)
From: Runji Liu <runjiliu.tech@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	corbet@lwn.net
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Runji Liu <runjiliu.tech@gmail.com>
Subject: [PATCH] docs: trace: boottime-trace.rst: fix typo
Date: Mon, 26 May 2025 21:40:46 +0800
Message-ID: <20250526134046.1042-1-runjiliu.tech@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace misspelled "eariler" with "earlier" and drop the stray period
after "example".

Signed-off-by: Runji Liu <runjiliu.tech@gmail.com>
---
 Documentation/trace/boottime-trace.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/trace/boottime-trace.rst b/Documentation/trace/boottime-trace.rst
index d594597201fd..3efac10adb36 100644
--- a/Documentation/trace/boottime-trace.rst
+++ b/Documentation/trace/boottime-trace.rst
@@ -198,8 +198,8 @@ Most of the subsystems and architecture dependent drivers will be initialized
 after that (arch_initcall or subsys_initcall). Thus, you can trace those with
 boot-time tracing.
 If you want to trace events before core_initcall, you can use the options
-starting with ``kernel``. Some of them will be enabled eariler than the initcall
-processing (for example,. ``kernel.ftrace=function`` and ``kernel.trace_event``
+starting with ``kernel``. Some of them will be enabled earlier than the initcall
+processing (for example, ``kernel.ftrace=function`` and ``kernel.trace_event``
 will start before the initcall.)
 
 
-- 
2.43.0

