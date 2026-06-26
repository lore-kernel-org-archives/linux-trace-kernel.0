Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC70E3BED7A
	for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Jun 2026 21:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782509056; cv=none; b=P/9OhjWsShPbkIRZhb7T+Gk91xE19M/Nb3fz/1+Kv9KBMdwFn2mrHVoS1afyTS07lE0o3+vHmlA16fdvR8KHp/m0XNbOYgp7C1T21Ak+K1/fjoPMKFxnLZ+ZngoEJbT1DlAMhzKCJ/t+WRMSceUO8pWFg73Q1u2nv0MIE2+bpnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782509056; c=relaxed/simple;
	bh=00MRBuxa3FWZnfDB2SvqS1lgldde5UEn8/OJq75iKo8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nql1U1/b+OyviDZj3IpOfWTxVAHssHfcatvotXHVJOLBC+Y2oHNV8cadtbqioqvZZdM0CS95zSfsFadKVbCMRBbIM/OGuqJ6ZXCTZOj2QboHu5ZrCRlLpNQGSm1Z16hwbYTw1ryeuBLZ3wZOkYNHcdVStmnF7JD/xvROKCoxez4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2k8EVr3; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2k8EVr3"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-464192ab2e1so973676f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Jun 2026 14:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782509053; x=1783113853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S3t0mt+Q05txvUtTd7ClxKUUskNCd9Blxrzu7AO6iDQ=;
        b=P2k8EVr3Bt6GZwBGlEnRAER2VvfHbTRxD0QUrpMC4Atoveon5d8mVrWAkPXiAdzSvY
         pNFuq+YxmhplpzQsFgo/0KpFs3KTHDevdqVdpUM15cDOCOwR2OB8VgI6zfeU0CCSVDG/
         mmeZmCTOz9NziCJL65IFZ7odhUacFigLvrIVGhu1JYLJRaVz5v/nyYMmxKFzU8kkq1sx
         AXSaydKFs74flKe/ShP0/aV0ZiULVTw5fS8E4Rrboxm2/JB5pdtf9XOIbYsgis04LJmz
         S0zYKEAFt1omnG2vPu4q66CXniTQupoi8ofS8dVF9FEXwkj7eY39i9JY91LvNhs4PoF6
         t4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782509053; x=1783113853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3t0mt+Q05txvUtTd7ClxKUUskNCd9Blxrzu7AO6iDQ=;
        b=DqtuMAsq75aE601wo9NQ/1JMQQnHkHM/uhkqs7WCSwvl/3GaydFpUzAt3r4X8jJYtc
         fIPHMg7qfMmrMpL800XRMbcqJ/dd0LN9DwbbeBsKGQg7U1ZUwUXmErHLcP7HSet5FlqP
         2stDUoeAkGxg/fVnmP2QCcEeNcp9yLU+l/32XXcbm9rm9OLp7inzeaNHq3i1eJZ4/rpr
         GjhBLbyND5b2AfbOct1q5hn5Op9lLwJ0C4gA4+Ywa7OdVN3t1x2FcU7e9c1wnXsjo2Gc
         lLzdWWP7OOzGH9y/z3cINuKhLgPSmxkJwuzz47lelj3h2gxztPyzOSEOJjahRkXjY1QQ
         aRuA==
X-Forwarded-Encrypted: i=1; AHgh+RqEYPEyYzBXDFqPbno9UjY+0OaDehrIZKqr62QMfmSooNzmANOBizrtb42s9zShk3HZx8fkmXkLSq1dbxy8W6hiiDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgvBqqwRHbvns6+xNg4yxRS91fQFBDsRXczSSyFXMWocLhdvfH
	a3W8TT/ueqI4qAoiBGcyCCNSTn7zj+i3+fvrnBKBLMLNQaO3+N2eTdPg
X-Gm-Gg: AfdE7cnQMCbcOXOXqE/t5UPOZmIql3HKMcfhNXm97QVST1vzrHqE85PLyXgZ/2xkW4X
	W+Q29dS9qEVxzI95iR5nKiYbQ/iiyjQn9OxGQLTHSv7Frx/JaOoU0FqNYyrQ8AePlDkjjv8RJeN
	nMjyw9XV997vGR4SROu/9wQl0ItS9zOq6C9S4c3lwA9gUenNcbwcjDYA8bNw1pk4FmvEXL/nHY6
	iQ8uZPxQiUjmcTTPWoo3IfhitkwRTJgi8fToM0SHDKKf0J3loZN/+6Jo6vZmJ+uYYVTMyiyvDNe
	AOg6z1Z+I3TRIsnWfgG3N88BPYSPd4UgmYK0hFsthBycPrhcQ3HcjF9jMcrSt26V8QFXWufta+C
	OLm1RRUsgYbeeyfHxOzBbmcy5RsGAJIXKGQMVcov4dqo18ZZeHshOr1Lcv6+F7xQ5N8/64kauOE
	00RwRCclaqEQD8F6AhbOZVynfMgD3kZUnrVMBJXAwu4Rj96vgZEUrgySPoErmOthnqOcopCg==
X-Received: by 2002:a5d:5e09:0:b0:46d:d6b2:3957 with SMTP id ffacd0b85a97d-46dd6b239c0mr14518214f8f.44.1782509053173;
        Fri, 26 Jun 2026 14:24:13 -0700 (PDT)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46e95f3d71fsm11505686f8f.12.2026.06.26.14.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 14:24:12 -0700 (PDT)
From: David Laight <david.laight.linux@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: David Laight <david.laight.linux@gmail.com>
Subject: [PATCH rfc 0/2] Improvements to ftrace comm[] handling
Date: Fri, 26 Jun 2026 22:23:54 +0100
Message-Id: <20260626212356.64150-1-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RFC because they are untested and I want to send them before going
on holiday for 2 weeks (should still have email access).

The first patch avoids a lot of 'potentially unsized' string
functions by embedding the char[] use to hold task->comm[] in a
structure.

The second adjsuts the data structure used to cache the task
names in the thread switch code.

David Laight (2):
  tracing: Embed 'char comm[16]' in a structure
  tracing: Keep pid and comm[] in the same structure

 kernel/trace/blktrace.c              |  28 +++----
 kernel/trace/trace.c                 |   3 +-
 kernel/trace/trace.h                 |   9 ++-
 kernel/trace/trace_events_filter.c   |   2 +-
 kernel/trace/trace_events_hist.c     |  26 +++---
 kernel/trace/trace_functions_graph.c |  10 +--
 kernel/trace/trace_output.c          |  24 +++---
 kernel/trace/trace_sched_switch.c    | 113 ++++++++++++---------------
 8 files changed, 101 insertions(+), 114 deletions(-)

-- 
2.39.5

