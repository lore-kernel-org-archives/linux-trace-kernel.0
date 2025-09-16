Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8B32D661A
	for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Sep 2025 05:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758001345; cv=none; b=RJQ1uLsOjN8t0Ba9IFlm7MgUcm8ccMVqRf62oy+7os9/swquejyHGZD2+/ocE0njLCJ2pWmo3ijN+VyYYhm5pyylVzc7o5NT5wCd5wXlQUXXCDZjdvN716NnRlclsef2buxZCyBzUh0o6oQzvSGRJOGPVRjEaZ6Jw3jbbCQ9Msc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758001345; c=relaxed/simple;
	bh=d2Ks+Ez2kkiMgnmwiuOB1yzGYoU50hvL0gFy9bbawNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S0+qgAOP6d4X7RsJHJ1n3j5S80ZT4zMwt7ebOsdvoA8glEeI5XE9CJGw6U2+CJtVWxOXwDv4lv93mMX5e/zYhuSOI7iWRc+lTalY/kDcx9EnpnB8pGJI3dxvJez4y3O1DOBPX0e1zrPjPoIXilGbAxU1N6OX1m5N6LtdIo2ozk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLdtZX/c; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLdtZX/c"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b54acc8c96eso3379892a12.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Sep 2025 22:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758001343; x=1758606143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5OrphTQTPcPloMHaTWuSR0TqiJdZDQyGVN8eE5nU/kg=;
        b=fLdtZX/cIxnrc7ADRhhzQS1AQUgaMPH/yx69Cvr/3wJj7pAnYlP7BVb3vtFMmmtgD8
         kG2qfDKXTf3Z9BISLpCcgHw3E6rHS87OexD93ed98M+1jd6zo47KSaz5WtnPhCYjElWc
         wbWgqdcbVaShig0+q/FXrcNBMyu2O3an634R0YmPHaL/Y3NWciWfO1UsqkG8PqYmyMrX
         5oj0u3anQocWmwX8OlvMcDB4cy3QHmBWrO7WB3cNR4ULh0yC3Xt+PWr0PyVV5oU4gmKi
         vW2j3Vqp4nL19bzZZYwUkP+F7cFjhPFGS8JEqEXK9eA3ImWyHUAkTdv0fBYhI91DcNaV
         BGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758001343; x=1758606143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5OrphTQTPcPloMHaTWuSR0TqiJdZDQyGVN8eE5nU/kg=;
        b=LUPDNnW0O4l8GEsfkjq6+pyQWZGUQzJde0iUpl/alfT/zqrsmS/3lJkqkGAmVF/G0u
         6nVSsWRKOOa5nDt1pf/AZtUxmMGQybGTZgjO3vaZW6YKvoz2YxV9gjvwhuwJC4YF2gLH
         q6M8P0u2UZIXV50qdE41Er5ImSQVvmzQYVxkATLCkr/Ddd5EcoLzB4c3sPOBKEANIS9d
         hSXOI6wbtsssV9JJdc34pGdZNkpxzOBoq/z4Pcc/1Urs+h/WCsmhX/HEMTgxMIdmy6NJ
         bUwNaSJrFCfEYOxwhQmqkYgfOkXEBLLG8ASZly5fxQjJ8CQLjkPMR4INmw79dznLCrsH
         qHAg==
X-Forwarded-Encrypted: i=1; AJvYcCUlljj+RWb8jiZkEFiUzdxnTCPC8tkU7hapYCXObsLJKFy+/LsaoRnw+omtHY0b1t69zclERSyA/Yd/QM7sP15BRB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWPuplnAVZMagWDAOTRsVpNZ9Rb9dyNq0WRc8E5cghZEXVQPnL
	1i8Wj4wijCuEyWJtWa3hiQXygI3biEb46cc2ZQ5tRa4vOjjaSVQCGeIs
X-Gm-Gg: ASbGnctRr0j2oGa5uIOPFIJJUj8nsB4SG0yYTzHB2QvrqYiZYfu+vchSyWyoYc5BnZl
	XCiuOrE8Wgeh1iPpgOUTEa0i9J75pfmVLKB8NU0snoqW+OYDhHBaUZYYMbAHT6m8jX2am3TwRJh
	C9XfvULnR4WewZKg9gqRXwnZtfc/Aursh0J3Eu2AtEz+6exeMhi2uuZGs+ha2Yo0MdI0ZwU9vWd
	3DSXylCi6aEf48evNH/O/zDNKX5zYU7FsPwRtezMruSy3M/1Md4WsDq7pLxS8Klw2J9YtVJgLo3
	41+fahtPR3wlkqAjlNdv180GDNFJf+k6LBdijXTOdwmCiRjGBQQe1BYVk+wa4P4HKrM5vgExTz9
	trrFbfSP0ryIlqdIK2lejht8eEg==
X-Google-Smtp-Source: AGHT+IFjkDAeBD3m3VhlVk8jYHDU8nrvwEkAOBqjFcy5ibI78SkWM7xIqAKJtkrXYmtLfgV7adazMQ==
X-Received: by 2002:a05:6a20:939e:b0:249:d3d:a506 with SMTP id adf61e73a8af0-2602ca077cbmr20640551637.57.1758001342621;
        Mon, 15 Sep 2025 22:42:22 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77654a55d08sm8626719b3a.77.2025.09.15.22.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 22:42:21 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 817F84227236; Tue, 16 Sep 2025 12:42:19 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Tracing <linux-trace-kernel@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Tom Zanussi <zanussi@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2 4/5] Documentation: trace: histogram-design: Wrap introductory note in note:: directive
Date: Tue, 16 Sep 2025 12:42:02 +0700
Message-ID: <20250916054202.582074-6-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916054202.582074-2-bagasdotme@gmail.com>
References: <20250916054202.582074-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1552; i=bagasdotme@gmail.com; h=from:subject; bh=d2Ks+Ez2kkiMgnmwiuOB1yzGYoU50hvL0gFy9bbawNs=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBknfpirH3M5u7rrglCKnIn7+0dSGWyln3SvTbzr6rjLs ke2dA5zRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACYiycrwP5Yv/PU6v5fdOt+8 b4b73JbunH4qInOCllbor/XsKwNX7GVkWMJ47OTmLQ1GPuXfZziWlzSuSPl91IG/8dll7j8xDzk F2QE=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Use Sphinx note:: directive for the introductory note at the beginning
of docs, instead of aligned-text paragraph that renders as definition
list.

Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/trace/histogram-design.rst | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/trace/histogram-design.rst b/Documentation/trace/histogram-design.rst
index 4faff1669b77bd..ae71b5bf97c6c7 100644
--- a/Documentation/trace/histogram-design.rst
+++ b/Documentation/trace/histogram-design.rst
@@ -11,13 +11,14 @@ histograms work and how the individual pieces map to the data
 structures used to implement them in trace_events_hist.c and
 tracing_map.c.
 
-Note: All the ftrace histogram command examples assume the working
-      directory is the ftrace /tracing directory. For example::
+.. note::
+   All the ftrace histogram command examples assume the working
+   directory is the ftrace /tracing directory. For example::
 
 	# cd /sys/kernel/tracing
 
-Also, the histogram output displayed for those commands will be
-generally be truncated - only enough to make the point is displayed.
+   Also, the histogram output displayed for those commands will be
+   generally be truncated - only enough to make the point is displayed.
 
 'hist_debug' trace event files
 ==============================
-- 
An old man doll... just what I always wanted! - Clara

