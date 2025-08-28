Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AA72D0626;
	Thu, 28 Aug 2025 07:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756366451; cv=none; b=OOL8FbGlf4YJBwp1vpBgvGhsRjCPW+/03B69/P9LhAyvP3cL9M57VtvgqJUo+n4KP4XELyGFqnb60LGsqg3uZD0nhi0Krf2Ru0Y4QYz5ERGTeKc01tW/t3H5f9IwbcgSiw4cfe8OLv3H+PKdwqq5N8mFy5+Xp7utzq8wpzgmJUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756366451; c=relaxed/simple;
	bh=KunA+ClFMMc2AGmooKotn9jUWmNj9tiso6TLGErh3uk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c5FtKjt2mlCTqDA6oGlmuuqFeRN4GD+yr4/NswzgKGLEKmxgT+6nURIoSh7icASbFGsy0xOOqiBNE+x7mpdpwplKTQ7ITbKIxrldJ0Yn6vTfU7HS6HxknRpdbG7aQNJ9Fi4BOdaVi8U1qRJ2PVJobMcAb+yFv/fx8peVziMAtow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VfaMs52u; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfaMs52u"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so697543b3a.0;
        Thu, 28 Aug 2025 00:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756366449; x=1756971249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j+wvbIZSOArG9eklWNCAJ/EwS6c50oTh0cISY2nYyU4=;
        b=VfaMs52uGvNjg5Hmj9IxtqqJCQgpfoztu7/Fa2c5oeUViIChZoH1X55eW6uZ8GGjxn
         lo8PqWIt7gVgRCgWgjdGwgfSaXfVMS2Dw+nGy6la9yOrNPOK8cROwwsiY4e2ufHDn8qb
         K1Hxa2VksEFJzXXVyWE0I5WufF25fPZePXioq+bO5tTUWEtypQ/2iDyBt2Q7Pn0CcLRy
         r2+YsfamI494HcIBfBDkJT8bRXfu9nceCqZJjYAUEkt1wl/Ce7m7aXl+gy17BNt2yUXQ
         iBKbxl0cazKTeBj9j9gKECTeApDL9Ubv2oYao9AQpXLPiWYbU94efcIovwSxEMC9H3lG
         c9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756366449; x=1756971249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j+wvbIZSOArG9eklWNCAJ/EwS6c50oTh0cISY2nYyU4=;
        b=fk+Il8zc8oZny5jYujEaA/4YOQPIlQ3uU/L8xSLedw4G5/mNlgTFIyS2rxGp8H1yNZ
         VSzr+xZ4x9JaTgwBtaIRUGNM69R4JF1Nvh7ygGqBV3W3rj6Sus/DcfYLsxt447TCcobf
         /ctrPsMjTgc6wRBJ/i87Dt4SAX4NoIa9jZNTwpTs9stLeqcqBrCbkUFfdXxxpH5Qvivo
         4cNyHQ4ant46IWOsBPseRr43Dov6HnJWLorUsGoTHORJ0UjxcpDOxaJWdD1WTiq7uh2i
         NxPAZlxehWCA8YjmL2q6Rq8BZdKETqgQIBlqvKGmbeD4eaeFGnXDtQUnRI+vwqBOFL/Z
         4zpA==
X-Forwarded-Encrypted: i=1; AJvYcCVBmjWKXZWLf/m1qhAPheBmjctgzPK6tQMGV5IPOnmwERAhVylYTcBFR78FNXMTmer2iJlhRc2BRkEbR473wOHQ9XQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsqdl8RlOm5KIsnWRRXVtSKfFLThYmXoxbowbjn5ZAI4J9hKbb
	HFx0kNnTe11W/vR0oCa7qbZf8VFqMCVnaJI2rSfB4o7mwHkcsGs9zX7B
X-Gm-Gg: ASbGncvDJBHxC+Ipqw2q/KAiHAxlHqNO/YbzxMYC7ED5l56J2r3749GuICZAYTl2zw2
	gGtrBH2Q3iaso42/CJXwM+/hR0XV33r7sJ6N35h4aYxOyKRDHVCOt4i5LlS5OpuuSJKjxhJ0CDO
	q+xgJy+ToYMS3G2k3UlR6kS7N9Yw8wsrNxz/hNBH/s9DyxnJB5WZn6pBvjj6lg6VFdZouAQmLWD
	wrk+bYmYaP7sSj9QKk+h+wv/V0WhSMoFh3/MZdv8SNHD0GvL7Nj94L6DM5y2B1XQTSZuiVC+UtO
	Ig3xXtUyVqs9+gSPJKBNpcCKWdiaBv8woQpej/k7hQNdTNOPKm0qEps25vxWI7xkj/gScT99xXK
	9LoISY4jgc78JP4MGsORWTO4V5pSYEkW8Yec/J1SPaan52uSU1Q==
X-Google-Smtp-Source: AGHT+IE0Bj834whDXotueWX71WpNaH0hF1RPeXxQmdcXuHEqPvv59XyUYnfM+JaBPoGK6bm6cgZ0lA==
X-Received: by 2002:a05:6a20:7d9a:b0:234:3932:2958 with SMTP id adf61e73a8af0-24340c47a88mr31770311637.20.1756366448736;
        Thu, 28 Aug 2025 00:34:08 -0700 (PDT)
Received: from localhost.localdomain ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb8afb7bsm13182613a12.16.2025.08.28.00.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 00:34:08 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH 00/17] mm/ksw: Introduce real-time Kernel Stack Watch debugging tool
Date: Thu, 28 Aug 2025 15:32:33 +0800
Message-ID: <20250828073311.1116593-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series introduces **KStackWatch**, a lightweight kernel debugging tool 
for detecting kernel stack corruption in real time.

The motivation comes from scenarios where corruption occurs silently in one function 
but manifests later as a crash in another. Using KASAN may not reproduce the issue due
to its heavy overhead. with no direct call trace linking the two. Such bugs are often
extremely hard to debug with existing tools.
I demonstrate this scenario in **test2 (silent corruption test)**.

KStackWatch works by combining a hardware breakpoint with kprobe and fprobe.
It can watch a stack canary or a selected local variable and detects the moment the 
corruption actually occurs. This allows developers to pinpoint the real source rather 
than only observing the final crash.

Key features include:

  - Lightweight overhead with minimal impact on bug reproducibility  
  - Real-time detection of stack corruption  
  - Simple configuration through `/proc/kstackwatch`  
  - Support for recursive depth filter  

To validate the approach, the patch includes a test module and a test script.

---
This series builds on the previously proposed RFC[1] and incorporates feedback. The
changes are as follows:

Core Implementation

  *   Replaced kretprobe with fprobe for function exit hooking, as suggested
      by Masami Hiramatsu.
  *   Introduced per-task depth logic to track recursion across scheduling
  *   Removed the use of workqueue for a more efficient corruption check
  *   Reordered patches for better logical flow
  *   Simplified and improved commit messages throughout the series
  *   Removed initial archcheck which should be improved later


Testing and Architecture

  *   Replaced the multiple-thread test with silent corruption test
  *   Split self-tests into a separate patch to improve clarity.

Maintenance
  *   Added a new entry for KStackWatch to the MAINTAINERS file.

[1] https://lore.kernel.org/lkml/20250818122720.434981-1-wangjinchao600@gmail.com/
---

The series is structured as follows:
Jinchao Wang (17):
  mm/ksw: add build system support
  mm/ksw: add ksw_config struct and parser
  mm/ksw: add /proc/kstackwatch interface
  mm/ksw: add HWBP pre-allocation support
  x86/HWBP: introduce arch_reinstall_hw_breakpoint() for atomic context
  mm/ksw: add atomic watch on/off operations
  mm/ksw: add stack probe support
  mm/ksw: implement stack canary and local var resolution logic
  mm/ksw: add per-task recursion depth tracking
  mm/ksw: coordinate watch and stack for full functionality
  mm/ksw: add self-debug functions for kstackwatch watch
  mm/ksw: add test module
  mm/ksw: add stack overflow test
  mm/ksw: add simplified silent corruption test
  mm/ksw: add recursive corruption test
  tools/kstackwatch: add interactive test script for KStackWatch
  MAINTAINERS: add entry for KStackWatch (Kernel Stack Watch)

 MAINTAINERS                           |   6 +
 arch/x86/include/asm/hw_breakpoint.h  |   1 +
 arch/x86/kernel/hw_breakpoint.c       |  50 +++++
 mm/Kconfig.debug                      |  20 ++
 mm/Makefile                           |   1 +
 mm/kstackwatch/Makefile               |   8 +
 mm/kstackwatch/kernel.c               | 260 +++++++++++++++++++++++
 mm/kstackwatch/kstackwatch.h          |  53 +++++
 mm/kstackwatch/kstackwatch_test.c     | 261 +++++++++++++++++++++++
 mm/kstackwatch/stack.c                | 289 ++++++++++++++++++++++++++
 mm/kstackwatch/watch.c                | 177 ++++++++++++++++
 tools/kstackwatch/kstackwatch_test.sh | 118 +++++++++++
 12 files changed, 1244 insertions(+)
 create mode 100644 mm/kstackwatch/Makefile
 create mode 100644 mm/kstackwatch/kernel.c
 create mode 100644 mm/kstackwatch/kstackwatch.h
 create mode 100644 mm/kstackwatch/kstackwatch_test.c
 create mode 100644 mm/kstackwatch/stack.c
 create mode 100644 mm/kstackwatch/watch.c
 create mode 100644 tools/kstackwatch/kstackwatch_test.sh

-- 
2.43.0

