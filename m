Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5375A19E97F
	for <linux-trace-kernel@vger.kernel.org>; Thu,  8 Jan 2026 01:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767836427; cv=none; b=hhR3QyKGESVKGZTEQ+QzqEeiIaMerflNXYc/BdQFI4oz+Fa2eDdTNI0ynT4Dq2xi05oJSLHKG01cIsZmnF+IcY+5S8CItNbDYP61hgEJzG8Vdi28lnycPAiLkKooKRRWxsHoAwvCA1CmdgBSFBoU3XUhFX6WWYdgg2FiX6XNYqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767836427; c=relaxed/simple;
	bh=vuu8rpEp3S06Oc8G0sBhUEsm2mtpfc3cgNKFFNrgqa8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=irnTsGBzOS0fx0s4p9i3PdOs+/a09IbpWxP6NZ1g/jFWpBLXEgXfiNAUZGefk2fiB0HhrPImLi/ZnvAiimPCE3HlI0NVn06tLx2FDdGfvrPJJ8Qgg8p3Wu7YN6Zxi9G0myXpjvnyEIn/HfWZTm/HGqO0dkA9U6CFVNUOuN351DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYfSB+bQ; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYfSB+bQ"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a1388cdac3so19383645ad.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 07 Jan 2026 17:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767836425; x=1768441225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+5mcvgrMOXwrLkHuTPd2Da7/Tt+HGO4BUi5SFbBwRTY=;
        b=HYfSB+bQ8OlUXivwWU4aIVk5GX4luIVrG+cVkH1jmKPigORcnIHZSl7WdEcPtd5+KG
         djEVP3z6pLGxcL9ZDPzXfgak6+oTfVe9w8wDdcaU7dAwM1s5JEBgxAn872J9Eyvzy9qa
         y/8sZQdhVvlnA/K0veWxIHnY0liYNFbFcdH/Bm+y13c2mSjK/JuX/woBgoK/jpnMafP9
         Y0EqcpASuiWlamfvO4JtGJM0j1HIc98jCeloa38DqssGlYSrikV8E7OAZJGFVyhbgK6g
         yVCWP7JNRUDHTKTyRS8iDNNkMJyRbf3D3LVUf3X0y5Fc94WgFW/uEP50QKrjjFlQqq+V
         K1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767836425; x=1768441225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5mcvgrMOXwrLkHuTPd2Da7/Tt+HGO4BUi5SFbBwRTY=;
        b=KmftQDqb7APVQbWzRF8M/uyYIV4O4iOV5RuZsRg1HhHQHkzS9ehdnfRxmTyXET1bEq
         /lnJz1bexCMI8GA5W4MRsmwOntz7rL6DIO9YblpnZofB18Knxden0OuY3qA6E8dLwAnJ
         D2/a6k2h+cPJawNUng22sDV+Ef8KCoglaAru+iZ9wGBoYK7J3Y1NxANiFwC5wbvoptpr
         z1AHYVF7yBspjnToHWf6fgZO55N/Rf/bmlpEoH4DcZRnzPGAOgnSDrtOnivxeHC2AKx4
         F2w7uWld+jLwY5Dd7SfiIAeMr0UpOuVRzUBrZrqbe5jRQkvoeJ1sr09jvGaUmwPAhV7u
         eg9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJX/+3/kPqExU4nsEhwI7I0E2l97KJsTgjP3zSbbg6TGRRWf1T8szUcdR9WFm7WRu/lIAUmP2jRQLzqTL7aauAnvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+EBnltZfdEGhTkOVqc98TTDkX71QWcm5KUNCyAJClVZDtBdVo
	eD4GvWPgjOrxxkW/M5PpGznLqoSsgPKrJSjEpJXwrqXY88Pd7S0kFEQ8
X-Gm-Gg: AY/fxX4FXQ1H+v3F3pwiB4rslPrhRc30cXbbs2hjREfrHxQZFieQXvZinicaxqfmHDV
	PSe7YZKqtsSOrj/cOomV38xuU4CzqVhh6+dXpQwBZqFOBbpLEiMlsmX/RUrT2KVBmNNX8QTHT9T
	f529squj8SP1dhN0rWKztzYrEGfaKCyoT7GYqbMGSbW52xXbzcLshn8jCDVtcEcu90rHqrGm2DA
	yc/CYDTDI6kYaSS8jkqx0C5y4xzdjp+e2qyGiror5U5+4BmbvCDMHbMDuS15aZVHaMg8KHVJViq
	JpcT6C3pP4ZLK19toaVXs0e2+TQhQujvqR5zforqBIDpJZH7nRZvUxFmef27R9PPZM7ql8bYQyv
	hwBgXjx3wv/4wo+XE2E3V7RJOYJuhv/D0IJSYEZSIxIfHSpCZcxB01wSqqr07S7jFYQvKxvVlLq
	rqqSjW6jAeJGM=
X-Google-Smtp-Source: AGHT+IHaTaN3lZQ3gqStmgI90rwkf+/u4N8abTIKk8/rXVaIjJMWuLcUysfTvfTFgqwmviThGfHaVg==
X-Received: by 2002:a17:903:2ed0:b0:2a3:bf9d:9399 with SMTP id d9443c01a7336-2a3ee48ada7mr38032545ad.35.1767836425529;
        Wed, 07 Jan 2026 17:40:25 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f7b19ebsm5970522a91.3.2026.01.07.17.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 17:40:16 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 890EF42805C9; Thu, 08 Jan 2026 08:40:08 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Tracing <linux-trace-kernel@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 0/2] PCI tracepoint documentation fixes
Date: Thu,  8 Jan 2026 08:39:54 +0700
Message-ID: <20260108013956.14351-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=649; i=bagasdotme@gmail.com; s=Zp7juWIhw0R1; h=from:subject; bh=vuu8rpEp3S06Oc8G0sBhUEsm2mtpfc3cgNKFFNrgqa8=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJnxnDssn7T6t/GnLni365aM/W725UJe9TUvyzea6Cxc9 rBp7UbXjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEzEJJThf5pY0vn/s/5nXklV Uf9dLDDnWPPpWf9idjktihNPTFDd68zwT+th7CEzjy039pzeMWe3nk/9keRQE+GSrHVsMivzNvS zcQIA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Hi,

Here are two fixes for htmldocs warnings on PCI tracepoint docs as reported in
linux-next [1]. The shortlog below should be self-explanatory.

Enjoy!

[1]: https://lore.kernel.org/linux-next/20260105160000.0368ec8d@canb.auug.org.au/

Bagas Sanjaya (2):
  Documentation: tracing: Add toctree entry for PCI tracepoint
  Documentation: tracing: Wrap PCI tracepoint examples

 Documentation/trace/events-pci.rst | 4 ++--
 Documentation/trace/index.rst      | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)


base-commit: 29a77b4897f1a0f40209bee929129d4c3f9c7a4b
-- 
An old man doll... just what I always wanted! - Clara

