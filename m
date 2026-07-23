Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9D741E6A7
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jul 2026 09:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784798963; cv=none; b=SSWEIhgMnRSKPTGIksFxhTuU+ykCBdOKcCiaT2BMwZlqIYzTsCI4m+jKDvrgObI8hhYyLXPi/92gZ13OQIUupiOYTllj5OEj8M32N/KpmSeFIQI411oySlwZL3+2wUiFqVwJKVojEarxkUDmWZi5DCI8DQG+5evND7SkmEaZSlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784798963; c=relaxed/simple;
	bh=tA6m9s5zReGUdsGIW22NnvqTyJx9+4d2lqkc4NI1fns=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=adrf2zKeRI9/gUpzKVJeYrPkWFcaMe/yLmwnQuD9FSpEwAIhDCYxo1/+HE5VRq9izbWIfFyXArM+NE+i7J4wD9nwzzHLo64ru1O2g6RukdhUW3iBIlU8KXGK03hwmmRgIQkkmE9GuRFl6aRHc1tJRvtrsvV9mYX1z1aMsvjuSeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAOoOeUi; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAOoOeUi"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cab973140bso5631375ad.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jul 2026 02:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784798954; x=1785403754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PZrPBqYijdzfKMBuONSSs1WTwIYrhiqirWSevn+t5ro=;
        b=EAOoOeUiNxjvHVzJ89m/YMBT32UODpK6b7zKFFv8EDErb+j/sGkvkP8+kUkMk0sBYB
         Oc1pfYJqWDWz9v6l6kGppVfvWKPwoR+rn63C8KAcaNI7pkm4JlgDmb4TTpDHw40Y4sc7
         C2hkD4Srvij21TRW2JB50LHYXFFgLWW6OMx9M9mIDZbyLoaf3gVrSxo4XVx0zTEwES8w
         w7tuqllqY/qqj2rR6BkdPvItLy/nmXDs44RyUkWikWsg/aYUc3Qw9NPBVxF5P/lpC9Zf
         /gFyxomHPnSiIiAjiyEizpJY+zJ8zMkSzEGpmYfFuoWZT/cZIvaNee05WowdvTWR6680
         zdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784798954; x=1785403754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PZrPBqYijdzfKMBuONSSs1WTwIYrhiqirWSevn+t5ro=;
        b=Rs3dgwvWLGBRCElVZ9HgdHRcLF/Osw6jGrRRbaQE5kaBDlR2yx7ZZxHDQxQYRxM7dj
         C8uAoxIXDsOeUO/vsHyoovICSYUNvark0P0ZRR8me1KxEQ/YiDCL6tyO8XmfQ9TYu0dj
         d10qoVEhWtrb/tSYf+7p+yfp89JlTYpv/cxqLWgz5WTPBaZsrejJ/DlH4YotAx4Uj9V0
         6n0U4NkH7C3YgfF/A5L2P9dOGOIeePToIfpHtO90nRHSNUxx+fu4zJ8XnXpv6EurtuHz
         uCxREdlUmEhQh0w0qDxPUwWaPlijbo5oE5d1xKC6dQTMHW++z6Gk9Z3D2kdIgD/pV+iX
         smSQ==
X-Forwarded-Encrypted: i=1; AHgh+RqH/XLv/ITltqIVWJmWWQgQtd45JmEmdk3JoOGmX7LjqbaY0Ob5UNT1MYmf8f0j+VXAcIGmWqbS5PNNrJhrunIvYjw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf4MkDdZ0lseHzSSV+UBLpT/i0ZOdwcjaQ1qSrbmO9QH61c2Wi
	PWs+XrLJUVyiWzQI/Bm7xTq9lE6w9Uxw8zdv91FQAhWsdA/rdx2eREqi3TXswNfJkpNOpA==
X-Gm-Gg: AR+sD11QzMPqOTY5gDdzJeNdKPasx0JOZoMVCDlFK15bitj+avjuKHLAWSmM2sUTqYD
	jXJuT/cbn5K/NHvBEcivFCPYpnQIkvn2hTRWY6tOe69YK5739srNpE2rU6FElLp4baBklSTrec/
	+6p86ItwCpYKowk7bA733YzccvJiIvtdgUYPhGK1roQa7EOjJ7sQ7YNRqNvbUqU1RTyGweWv3B3
	xNyqtJaqDd18+GSvX7vgCNEzq7MdnzIXfabaIYmNOnGoq0IZuQil5Lrf3yhgSyw+HAIkhHjuR8M
	x5JROKSiCDF+x2+wLJhENc68Nl9xKVAK38/TRgTvlIXM63OR8BDGW8huEFuMgDw0+TzoRbNrgRv
	wKsCQazKEnZjx/3Hsx9dupVwg8iaUTbhbfOjrwswSSSaCXIOnIp7qjuPdaiVWkMchx6kf13Bl9l
	hZhqQ4h059Oqm6gmlOCg==
X-Received: by 2002:a17:902:ebc7:b0:2ca:ce91:f027 with SMTP id d9443c01a7336-2cfa6c875ccmr27647445ad.36.1784798954032;
        Thu, 23 Jul 2026 02:29:14 -0700 (PDT)
Received: from PC-2B0BA31200898.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efa388fsm30298125ad.12.2026.07.23.02.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 02:29:13 -0700 (PDT)
From: Meijing Zhao <zhaomeijing100@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meijing Zhao <zhaomeijing@lixiang.com>
Subject: [PATCH RESEND 0/3] mm: trace: decode architecture-specific VMA flags
Date: Thu, 23 Jul 2026 17:29:02 +0800
Message-Id: <20260723092905.761037-1-zhaomeijing100@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Meijing Zhao <zhaomeijing@lixiang.com>

show_vma_flags(), which is used by VMA tracepoints and %pGv, names
generic VM_* bits but does not fully decode architecture-specific flag
positions.  As a result, trace output and VMA dumps can show a generic
"arch_1" name or a raw hexadecimal value instead of the meaning assigned
by the target architecture.

This series adds symbolic names for the arm64 and sparc64 meanings of
VM_ARCH_1, arm64 MTE flags, user shadow stack flags, and protection-key
encoding bits under their corresponding configuration guards.

The original submission was rewritten by the mail gateway as a
multipart HTML message and had a disclaimer appended, causing the vger
mailing lists to reject it.  This resend uses a mail transport that
preserves plain-text messages.  There are no code changes.

Meijing Zhao (3):
  mm: trace: decode arm64 and sparc64 VM_ARCH_1 flags
  mm: trace: decode MTE and shadow stack VMA flags
  mm: trace: name protection key encoding bits

 include/trace/events/mmflags.h | 43 ++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

-- 
2.25.1
