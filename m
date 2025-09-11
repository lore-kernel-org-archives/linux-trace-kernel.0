Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B17633F9;
	Thu, 11 Sep 2025 04:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757564735; cv=none; b=Pi+6MZ4A4f8BOf54HIc/LwpuSXZ3ZdUjMklnczBLRiq0Lv+s5LYfJWXwF55sOepuz03FoKsgpR0pFMR85jnrXZcXbdSjSztALpcOqUV4Gc4xBrBfbJcfjUjhMLVAu7hQti+DF+N/JEyATVyWfrDbGO3T1gJepmWa5zp72t7O4iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757564735; c=relaxed/simple;
	bh=PCapEjPmI5m+nD84bxhh8bD0msN75z0bb/HI8QQDCj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=otKqr7dKceXLwLNdJ90Gkf7es8X0zHyQv4Fni+gRQpHbDqg5oZUiEXZUHtFYRONtmq7fk1vhWQydRQolrm00BpIbMZQN+RQm0/Qmh1vQmlcBI+JxyUUPHlklxDbP7wpJaUcdkxNkqTI5S468UgTlenoO3gcQzMQj9rf3O14FDvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/zRrM5o; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/zRrM5o"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24cdd95c422so1597835ad.0;
        Wed, 10 Sep 2025 21:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757564734; x=1758169534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sn0fDpbrxJOdsZ8BiLim0jUfus1eeCGt+uywtEWxVhg=;
        b=W/zRrM5oUD0KGlSW/ig9oZPhsuHZ0fFEsC54x/dlpEm6nlHnbddv62XDJiGHn22oeb
         hxEUpwlqD+g9pMIJ+3J74G1SXuIDSpaLr2h6aG25gP5H+xCcDTDttjr9Jbf1e+htNgxD
         6jAmCEQqGu0ZrNeyuwGtYmBQzNOU7gTDMINDlIIcSQ+UfoWDARCyXu37WC1sLPq3SXDy
         lB0thlxBKt0niZMN+ndexahi2SuFA1ZUQ+4swCQktG+IP+anLBmvgfP04G286WM0xPF9
         zC6JHGqs9Lj6vO1xfynJMi1tUEphevwpUNwDGhoo/8Fr5EUjWyzl1G4lqlym+A1Hi3uW
         r/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757564734; x=1758169534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sn0fDpbrxJOdsZ8BiLim0jUfus1eeCGt+uywtEWxVhg=;
        b=Ck/4rASc13bUlPMnbbXwA/qxHgcnsduFxFjjogWWu6bRM0TMSLA19xevgWi99zTg8w
         +nt7oT44pAynVocZaSt1RLtgP7bdk+3kv50dd6khr0CKjjEIpt0vkhcA+xxE+7j4TTml
         HPaHPgkPp32mPRG82881/4+3xIJIlVYnUXke0DmS62SBN4wjU6eH/O6hao+xJQxAeex1
         aytfle7ACJlPhFQxD79avpk7O5jELj1QBMXMjbT5t0R0or+YNvldcD2XcT8xnb8vo9yn
         68lp7qaaYx3TIWUAGZTyKWhmh/tP7y8jGw805PeeglV8STzpe5hhQ7mtBaiss28uWuOJ
         uHbA==
X-Forwarded-Encrypted: i=1; AJvYcCXtCKHIxqKoS0wlMIEQTN7XVp70xXZ3mztkMNM//aTO1X11JU74aFuee5QfqiyE6XDBJNnYpKS/lJc=@vger.kernel.org, AJvYcCXxXepJYwfvJWFDzvtakmtEzl8R0A8CswByhAeT0R9websDHkmuZkr9TGjP9zfKqhuQ2fKkXwQpS2fzmvrs67L5ge1q@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwbmtd2Jno6XVArEm0Bsf+LZ49u17+VouxPna1AgYLJAdKXs/z
	U5ocSCAhg/7QQPk3QUXIPJ3rkzdzQsb0C+rxJJXQ56NaSVxa0Rdfgox+
X-Gm-Gg: ASbGnctHgXg43P2o6XQ0E3NJdpdTNxvHIkKZug0VlsePbxNGRqsjXUYdHDuJZ8LQ1IU
	MfObVoF4+VCmZWv70n+9M0lSWuHGDdUTpnm53u5uQuFAjJBC6GrYHz5hUGwWj8Lg05kBF2mXVgU
	jWp/9LbOK0jfl8IFYURAbDs8mHqt3wPKjcrNaYPWV/ZMEYFi+iTIOoes6D+UQwLhpxZ63xyGpIc
	hOkhLZ6g/Q4YaMz6URrqTd35N1zdC6OE/UB/8o4ByEaYWaLvsqXBihmC7IuOeYS9ODe/CQ3hS6R
	sZcGgbZwNSM0g1zA/ZU8K6RPeVWcW7N7uAcw9FoGxmK5LhHf5JyOLh4Twga8aIwrGRZQROAl4j7
	7YHU4ol8p8tbMBZj2S2hiRdTE3pT+9TBnwMl1
X-Google-Smtp-Source: AGHT+IGwA7u7kHvYy08QWn2RBRYK8+HxOZDkMhU7OlqshMYpfA+qxBXfNqX636KO5Oe1y7G8nlywYA==
X-Received: by 2002:a17:903:3c63:b0:248:a26f:e25 with SMTP id d9443c01a7336-25174374ae2mr239240435ad.52.1757564733532;
        Wed, 10 Sep 2025 21:25:33 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3a84a80asm4215895ad.90.2025.09.10.21.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 21:25:32 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id C0D3641F3D85; Thu, 11 Sep 2025 11:25:30 +0700 (WIB)
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
Subject: [PATCH 4/5] Documentation: trace: histogram-design: Wrap introductory note in note:: directive
Date: Thu, 11 Sep 2025 11:25:26 +0700
Message-ID: <20250911042527.22573-5-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911042527.22573-1-bagasdotme@gmail.com>
References: <20250911042527.22573-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1443; i=bagasdotme@gmail.com; h=from:subject; bh=PCapEjPmI5m+nD84bxhh8bD0msN75z0bb/HI8QQDCj0=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBmH/C6U957+ZXJqVYJYRkpbnJn4rsl+s4QnTF+zt8H0j YjuM7XujlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEzk1TRGhjtvfDe+0T2tLy1e ZLs4fu2Ml02P9D/t3fXAx+/s5pgdoSqMDHeXm3/faywbtPTeMSfRJXOLi3w6DqozKSY838sUu97 7MC8A
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Use Sphinx note:: directive for the introductory note at the beginning
of docs, instead of aligned-text paragraph that renders as definition
list.

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

