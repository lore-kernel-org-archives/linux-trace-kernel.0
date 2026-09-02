Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A74037B020
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Sep 2026 06:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788331535; cv=none; b=tGDAQ91QnuB2px11ur8pU+tB9xN00+gPMJ2/qi0cY8IDXaf1a4PB2sAMqjRARDBnc7iFol2/FiuZSKJWvMm0lau8Fp/+Z/GZeL7G9ot7/MLohOAUOSZkwM7Drt8Z2777c+o3oU6wbIxTmgKoFJMm3T0o74v5bL8GgMJ4IGr6kpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788331535; c=relaxed/simple;
	bh=qkpzPnGgNjozNVl/OQ4FxMb8JZeE4UQpJXJz079VkrE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JGCnFBHKzId3xpYnhpTNbcT0BSYHOkHWIBFfJ3lSYyXqorYugd6utUFeXjfbzyeaqT2+38HRqFXZvSsyWPEBS3BaL84fIVhgDwm7Iu1w/w2Omr8j1MD/XdeKKV3A98EHzt/5AwD1oAFOO3A81E1yMYC06w35a/rswhdexd/EMlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzdevgID; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzdevgID"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d53197d8b5so6181895ad.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 01 Sep 2026 23:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788331531; x=1788936331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A1Ijfwz6wl79jsZ8nek7Aw8mUO11NOUio6A8OmunRuU=;
        b=LzdevgIDv0QVC96lRAogWGBEqylEn/nkYJ71V/fCkv+d6rTcGvcd/UCcaqzYcLq/6o
         vY96JnjaH/tek6cI0AzhJMEIxO7hX5bKPFVxGuPpsGGcusaY6UvggvteZhsYXtQswADf
         +CmlFb9ULGuxJS2jxF8FD8eNF87Y290l5Kiq0OfQu4oTVM9NcDHod/VbYhiX848O56dZ
         n0NmHnWaD69djq5/7evaXOTW55lkP2VH9Yra37Ruc9trfUzKJBgE/d5nGRn4yCh100bg
         tARYUR378AWMYGIZ/DmT75hyk9JMP1XMA8WxD5RJIM6//zYYo97sgtLvCWqo7bnyavWV
         jREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788331531; x=1788936331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A1Ijfwz6wl79jsZ8nek7Aw8mUO11NOUio6A8OmunRuU=;
        b=YdR0qJZrFspataWezafa+ZaJxX3JFlSpVzDxobIGP3DdOkJttlzvmY2NNfMTt7R+L9
         ArFqD92HIElWKkxS2cys6At4oivrU37Vn6AtnbPO5GhzsxEcrcXZVL2ix51bSZV2vHsG
         OtuZBPYRxB7ModglcvI1Y2gEddE3+EHADKRgCIUZMaqWquMUl7a3M1k743SI1NNvYyn5
         DfB6zyZ1JILTCJcuj+km/x1ZuQjRHWKHJ1LeQNY4lLOvFzWeuKDgP322oC25pC4wtc/s
         WKo2fHmRJi6aTyaOwK/NKIrfLhQK/sG5grYAI5uljVd/n74k1u/fBJ+vq96jWOjCWI80
         YacA==
X-Forwarded-Encrypted: i=1; AKwUvByQbLBel4vHo2cg2v+eSGfle9+3/NZ6GTHtd45q9UrUp6sIeOoN1ms6vEcEHELZyIFrB+TQ+IWAspaofKkOb3d5OYg=@vger.kernel.org
X-Gm-Message-State: AFuF++m1b6uqPUX28BsGnAe6gwZbJ7IOewgPSL2bckILPfXVVVWlBW18
	JEYlYR5MorX2dbSC5lUxt/usbv+Mf+qvt26qV/dZlq5CvfOjx7BTIhzi
X-Gm-Gg: AYBFou3Odbb+Mo7qGjFZHUUs006NXP1fBmXnBUDNzAsEMczh1SgbhgvDrmp2GBcFuEn
	I94dKUaekTGjGG4ZxlIToZxwDF7B/Uc42GXhrQaUvyLi1+3qo0mmn6W9VOqRvtb8sUuhDNLmb+p
	8cSnXgxYLwNUeWP/HM/YCo81t7MnXCaqn4aerVLWnmr/5jhXkqBMwTBz2+H4T1N5pyUXf5ZpJ8b
	JIAGocNFi5JreL9gOnfPbPggrUYA3+TEa49HJI/RPfSFq/AHz9m86JxNTfXSZg2myqDSoI6PY4I
	upm84LBYVd7oVYU6UC4bhsV90mNxzYftORkUA4WsKnOAXRg80L6XxrtvgqqvX3l392QTqpOUy7v
	jUnLCJRN1lLxs99OPgbPck2J26Rzvy5c3Zjt8OuE4uN0noIyRj9D2PWoM3XgMbnBmIwDR97G53l
	05/8XwiHBasvLN4AProuNfXKb2LoffA3jDb0/zmhY9F2u2xxL+eWs1/hiqry8jT6p6EnUZN7Fxa
	InRvTnlOBBuiGQy
X-Received: by 2002:a17:90b:4a8e:b0:38e:4114:d8c7 with SMTP id 98e67ed59e1d1-39aedcfc81bmr3925777a91.0.1788331531419;
        Tue, 01 Sep 2026 23:45:31 -0700 (PDT)
Received: from PC-2B0BA31200898.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3990bd1b395sm11051480a91.1.2026.09.01.23.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 23:45:30 -0700 (PDT)
From: Meijing Zhao <zhaomeijing100@gmail.com>
To: Lorenzo Stoakes <ljs@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Meijing Zhao <zhaomeijing@lixiang.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Wandun Chen <chenwandun@lixiang.com>,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] mm: trace: decode architecture-specific VMA flags
Date: Wed,  2 Sep 2026 14:45:07 +0800
Message-Id: <cover.1788330432.git.zhaomeijing@lixiang.com>
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

Changes in v2:
- Rebase onto v7.3-rc1.
- Fix the patch 1 changelog: "bti" and "adi" are descriptive trace
  names, but do not match the two-character smaps mnemonics.
- Cc Lorenzo Stoakes.

Meijing Zhao (3):
  mm: trace: decode arm64 and sparc64 VM_ARCH_1 flags
  mm: trace: decode MTE and shadow stack VMA flags
  mm: trace: name protection key encoding bits

 include/trace/events/mmflags.h | 43 ++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

-- 
2.25.1
