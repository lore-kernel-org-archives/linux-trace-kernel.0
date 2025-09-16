Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D7E2D6E54
	for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Sep 2025 05:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758001347; cv=none; b=gT+guY1TZIQkjEuI51y303Fu8l5U9DZ0UO4ACl6QrAiHBo9MscWVvY/nMnUYny/08etSFjqMcxLVGD2WIqT6+O95/SZq11DdA9hJ+xKXgfLKVm5n7C9f8RapdY0o09c2MpG3uihE+KW95Zq6z7aH9TGRU7VWJMEPX8Ni0z46Ndo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758001347; c=relaxed/simple;
	bh=8NBytuejkgmSFrqx+1YX5XgCxvOHNVzzXPSqQWyrZzo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f3DdasYP1GOkn8lox16tWwzQu8/FH/DDxgVlBL0V6p8lsrgLoezs6uG57HCrGCMKUiegvCmLAeAONJvOtdsRDIkNG1DxeMPnZG/JrqCyg8xT7ouWJJWX8FYsIPLN8TKjvGOeCb2pRPbGLo6UnNXAqtdLkQs7k1Cn+P6w0/l8ub0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0f8yKj+; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0f8yKj+"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2677a4d4ce3so15882555ad.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 15 Sep 2025 22:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758001345; x=1758606145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KA+efhhVzcVIxn2rganxCwFW/bnQtqIpNxQbWngi1b4=;
        b=A0f8yKj+jaxcoCmllZ2x5eXF8IMyM7xTtOWs2/ZicTp/+e9Q3vSHOh3x6xOSxJT8Mw
         PiSb1XdaYPFF5qslnsUEVZpaUkpNZi20VbfSIb+4W9udajEeGc84DLarOqc/50gQNytc
         1gG3zFP74XD9Skx4I8hfI2kNujqnbGHYx5970/cxVXsgOlRSihtnZDySeUz4HRsALh0J
         WlU43lm3I6/29StbJaHPgttID3niFtNBUrl5nsIQOYHs80hlwJF/Y/Juzm23aY0uhq7w
         KOzEBX008GHkLV45jiMVW8sskl6/ui6EBbZM7JYgBmVqPoQfCpKcJ4nfM9hvGGjc5Qyk
         IGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758001345; x=1758606145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KA+efhhVzcVIxn2rganxCwFW/bnQtqIpNxQbWngi1b4=;
        b=Lm4B/ON9jXmKlhSpMIMwkFzpy1WMHxix4Oyr/bt0kEJwzgmZDh65TJG+rHTbdDKTDt
         zP/FVTHRId/kZwbEPYUG+jQ2E8iv/T9wbCZhsQASmr4eKWeGb5JKdYEs9vb3lqnfD+v5
         QpcGTWk1lzMghfG6MN/mznVHKGrMsdn1QUPwW3ZgH0TedaA1bdSMKEx4RQQ6ELQ9pLOe
         QFu4BgvNpBXi/0N5jKJHt7N0UgHbwD5gZDtYviGCx1xVP4AdTBbWFI8cYUQKXSVwSquQ
         /M0ZqK+GWyFbF2ACCLHejRnUEshcvciwGfGPkNCN2mSzf0b4wYwBLCXvTGNeweVCxOvV
         OvTA==
X-Forwarded-Encrypted: i=1; AJvYcCXcqMjxxhQviS2Al3LqpnFcLP22+gG8YHqzilZDfvIsi7oiuXK2zhDfAjPhxYCeJCaKvxAm7EqKlM4hrSpPTAWTlBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxccKkt0+V7fSCcm3qOscdEdX+81B33ggforwpG4IFwu0sEbEEB
	boF8woufwk8b4R34s4sA3dijgPLtRoVW5nA+IZT7af0y8K13a9jAAOqu
X-Gm-Gg: ASbGncsjFOB1KZObW/zub9M4cJgMTAm1+CkgXGPItCqE3H1wzawNZjk2lVz56eYxZgr
	xLnu49gf7TZTZLVCw3RaLvUwJKEABUrGeBoZ/0crSv01a1BmguXW40WyqzQw60rthhpMKSz/Djr
	yrc9TNk98GW4+qK9wwf7Dhnbt5H1M1Z/u2XnHdH7ragsRKkriu5y4R/3lSEwTjvrJvho3et34hU
	qXwdRYFyHVe2RV1baArKH6vKp+vK1zV5iZF2clJbttJKTg8twLxiGraVBw9dSDiicyQra824b8d
	5QzU3vlpfVD6H6ZzOrytiw6eQQu0zi8SX4SnAWaWmgpMSgDZ1A2Y0XD+dz3Lz+PNW673v4bPB4i
	lx7z4uw0VnfNvRsyaDb3ntaFrHw==
X-Google-Smtp-Source: AGHT+IFrvIySj9YPlWQ7FIJlVK7g2Kv/lcrzGY3U0M775dmnSq64Cf2O4rtx9zaA9FHckbb8B+VGPQ==
X-Received: by 2002:a17:903:2a8e:b0:265:8a76:4b0e with SMTP id d9443c01a7336-2658a764cc7mr81319825ad.53.1758001344772;
        Mon, 15 Sep 2025 22:42:24 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ea41d3e19sm420977a91.11.2025.09.15.22.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 22:42:22 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id D7949420A809; Tue, 16 Sep 2025 12:42:18 +0700 (WIB)
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
Subject: [PATCH v2 0/5] Histogram docs formatting cleanup
Date: Tue, 16 Sep 2025 12:41:58 +0700
Message-ID: <20250916054202.582074-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1149; i=bagasdotme@gmail.com; h=from:subject; bh=8NBytuejkgmSFrqx+1YX5XgCxvOHNVzzXPSqQWyrZzo=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBknfhicfRauZvBo4uYlLUIb20Nvtl0TDdOsWM48iYF3M dOSwzqPO0pZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjCR916MDI+19HuUF1g8Cmj5 nM4xi6Wo3dhrWX5D4OZahUjvUCXfp4wMdz4IRZx++SphzznlPz/r4jX/BatGHomaefLr4ev32wO yGAA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Hi,

Here's a formatting assortment for trace histogram docs. The shortlog
below should be self-explanatory.

Enjoy!

Changes since v1 [1]:

  * Apply review tags (Masami, Tom)
  * Reword patch description for ftrace cross-reference link (Masami, [5/5])

[1]: https://lore.kernel.org/linux-doc/20250911042527.22573-1-bagasdotme@gmail.com/

Bagas Sanjaya (5):
  Documentation: trace: histogram: Fix histogram trigger subsection
    number order
  Documentation: trace: histogram-design: Trim trailing vertices in
    diagram explanation text
  Documentation: trace: historgram-design: Separate sched_waking
    histogram section heading and the following diagram
  Documentation: trace: histogram-design: Wrap introductory note in
    note:: directive
  Documentation: trace: histogram: Convert ftrace docs cross-reference

 Documentation/trace/histogram-design.rst | 151 ++++++++++++-----------
 Documentation/trace/histogram.rst        |  38 +++---
 2 files changed, 96 insertions(+), 93 deletions(-)


base-commit: f44a29784f685804d9970cfb0d3439c9e30981d7
-- 
An old man doll... just what I always wanted! - Clara

