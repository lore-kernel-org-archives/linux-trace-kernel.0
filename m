Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F4531A063;
	Mon, 18 Aug 2025 12:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520062; cv=none; b=YasGIbMLBmxV0uT+Vqxs7a02Dy3A/nz2Hd3WW9u5OzBo6I7J4xy6+hGjfCDcVIA0VngiTVAElJiiv9ZKCLOHYBs1Cp2EDpnUkmGVIBDernQuyjeRj1RagZC36UPzMB4lslD3AlrtTZY7yvV3oDB4WCs9+yumcv1EEFsJ2PFH+Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520062; c=relaxed/simple;
	bh=3q58Sea1h8GESEoJDAomrwW47aGk7SLAtFtQaQd+wR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KoFpXIL7Z5H0WnAbuUFkrBNzgvnBQGr/wvu8tpuTAz75X7D4MMbk6z4gn06St1hHO4Aa4ybuOWmcQawKX8lKoKuXcn/nBdiaCj1hyu+8gm+0h1Df2CpJM/oWdKGZh1JDwoq3FDNceKMP7YuV6SzrVEVL/vikZOH7jNVmK0M6XpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/SgB8vL; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/SgB8vL"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2445824dc27so35725265ad.3;
        Mon, 18 Aug 2025 05:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755520060; x=1756124860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tLz55VslHZUWc+WNK7/9dQX6EPjwj3Sye3rvttPVWBA=;
        b=H/SgB8vLBYvu9pPiyXiOq1Ps1sK2+jCQQ2U5N7YaizLQJnv1JK646l9R5upPRmUlud
         LjfY3XeR6cV9AKnpXAIpQGD1V5CU3iUUw+jg93SxHnaknyTi0oN8wj+vnp73+D9EMf3O
         7DUY4GGJYRPOpn/SHI43YfIfDIELW2+B+3idZvLLb/+piLtOCxOIhq4XLrouZbyjQly2
         QkCwaLiBeUbLwYOuP+MhwfBNoy+Wxo/N+1vmcBukTSZ+Q34rUeFEQEfLYrAo1jonwDF1
         Z0e+rEq+fQ3V49R4wjH5oLp3By5i2eajPqAdQrTp3ZYWHLa55/XRo7S+RDTH9PiYUdSo
         dj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755520060; x=1756124860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tLz55VslHZUWc+WNK7/9dQX6EPjwj3Sye3rvttPVWBA=;
        b=bEu4a9q9bTvHTC1Yi3isPswfhRF5tKMy1dLaU1yvoITf3dvvLiS2cxbzJVAAx7qRW3
         T0hlCtXU3OVem3+o7Uz+KLnG2gvNfI7HC+HEqI8NzzGxNVF/AtvhAYbeTyIRh94fww4m
         AT8PR4rn/yOQwViQ6Js7N5lZUZhou7l+2ODVxa02gn6FtN5h8l+M8SwmnFNcVbv4mB5P
         RIjSpl1uE9e0hZm5ssavhU8Xkj4eEeXfy6gjSdOPpwvWk40PBBLIs4fo2OyaX+LaH0W5
         Kg4h7+xFLgQUOrSgf3MskSvhjG8eNs6YkVueq4MxLabEjY6RRnnJofhi+9fomVyFD8tR
         LywQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCd+3o2xx3ImzcnE6PxQX3BrW5N7eM8NjUXT3iMEd2/XTfYFKt1p8Zu+ShQx5+w1ZmqM3x+WJ47NNYaAADiH6RbQuo@vger.kernel.org, AJvYcCVzAqQVByCq4s5GH3tVtbhKZ2MQRZY+TpXwaOw0vyYYRqkOKa59xtAto1OWugDIlemcRlYhJpLfL9RLEBc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/9Co8lGEsRYX98rijcJNs9jjYlrfXGsWEii8RtVTsB9AIh6ue
	Pc8GYFuvBE8Eda7VotcQ7zYAm7XL5q3v2guotGR16ZQ+c97+RVuZ2mZ0
X-Gm-Gg: ASbGncu3NbnPbD4tyRbdXlu3myaC07mjafXXjSiYb8Szcws/fNcn7+1zpYUBItBGuoU
	+3DeEJbrMkOXIGdam0NtRdUm6I423G/ncEmovJho3hqFB10KO1YhY0EyKxJzKj4R1+oBG6mNmbV
	nKuzYmobEzSFrGcCi2C0Ihd8yDqbO9IV8Ty9NPeal1899EJigEMG+Ekmn2oXAFooDKilqmfVRhp
	CKUl8nUVrH1Cnso7cAxLb30TvTllguy8xbVi+gtyPVgChzGSi39g7YodEn53VB2x8kM/kl+3PDT
	WYgCYj3PtdwS8EjIEQe4Gaoqdg+MJDFe+i5QXXMCqBvv/AcnReA5jz/xxq9MlNeq8oKEjD/yXjq
	8ibVXQJ/xtYXg1SerKnosiQIhPNemi3hQ0b8QD8ZAn0WD
X-Google-Smtp-Source: AGHT+IFJoG7GUVCeL6hd8WV+Y7zmj5hS4uZb+5DVZCLwiS19xWtblwl3S9dqyVSmUGAeTUCsZgEg1w==
X-Received: by 2002:a17:902:ebc2:b0:240:10dc:b7c9 with SMTP id d9443c01a7336-24478e0ed44mr102410085ad.9.1755520060020;
        Mon, 18 Aug 2025 05:27:40 -0700 (PDT)
Received: from localhost.localdomain ([2604:a840:3::3008])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d57f12esm79236705ad.157.2025.08.18.05.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 05:27:39 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: akpm@linux-foundation.org
Cc: mhiramat@kernel.org,
	naveen@kernel.org,
	davem@davemloft.net,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [RFC PATCH 00/13] mm: Introduce Kernel Stack Watch debugging tool
Date: Mon, 18 Aug 2025 20:26:05 +0800
Message-ID: <20250818122720.434981-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces Kernel Stack Watch (KSW), a lightweight
debugging tool for detecting kernel stack corruption in real-time.
The motivation comes from cases where corruption happens silently in
one function but only manifests later as a crash in another,
with no direct call trace connection. Such problems are often very
difficult to debug with existing tools.

KSW works by combining hardware breakpoints with kprobes/kretprobes.
It can watch a stack canary or a selected local variable, and detect
the moment the corruption actually occurs. This allows developers to
pinpoint the real source, rather than only observing the final crash.

Key features include:
- Lightweight design with minimal impact on bug reproducibility
- Real-time detection of stack corruption
- Simple configuration through `/proc/kstackwatch`
- Support for recursive functions with configurable nesting depth

To validate the approach, I have also prepared test modules and scripts
that simulate corruption scenarios.

I am sharing this work to seek feedback on the idea and the design.
Any comments or suggestions for improvement are very welcome.

The series is structured as follows:

Jinchao Wang (13):
  mm: Add kstackwatch build infrastructure
  x86/HWBP: Add arch_reinstall_hw_breakpoint() for atomic updates
  mm/kstackwatch: Add module core and configuration interface
  mm/kstackwatch: Add HWBP pre-allocation infrastructure
  mm/kstackwatch: Add atomic HWBP arm/disarm operations
  mm/kstackwatch: Add stack address resolution functions
  mm/kstackwatch: Add kprobe and stack watch control
  mm/kstackwatch: Wire up watch and stack subsystems in module core
  mm/kstackwatch: Add architecture support validation
  mm/kstackwatch: Handle nested function calls
  mm/kstackwatch: Ignore corruption in kretprobe trampolines
  mm/kstackwatch: Add debug and test functions
  mm/kstackwatch: Add a test module and script

 arch/x86/include/asm/hw_breakpoint.h  |   1 +
 arch/x86/kernel/hw_breakpoint.c       |  50 ++++++
 mm/Kconfig.debug                      |  23 +++
 mm/Makefile                           |   1 +
 mm/kstackwatch/Makefile               |  11 ++
 mm/kstackwatch/kernel.c               | 248 ++++++++++++++++++++++++++
 mm/kstackwatch/kstackwatch.h          |  56 ++++++
 mm/kstackwatch/kstackwatch_test.c     | 237 ++++++++++++++++++++++++
 mm/kstackwatch/stack.c                | 222 +++++++++++++++++++++++
 mm/kstackwatch/watch.c                | 240 +++++++++++++++++++++++++
 tools/kstackwatch/kstackwatch_test.sh | 122 +++++++++++++
 11 files changed, 1211 insertions(+)
 create mode 100644 mm/kstackwatch/Makefile
 create mode 100644 mm/kstackwatch/kernel.c
 create mode 100644 mm/kstackwatch/kstackwatch.h
 create mode 100644 mm/kstackwatch/kstackwatch_test.c
 create mode 100644 mm/kstackwatch/stack.c
 create mode 100644 mm/kstackwatch/watch.c
 create mode 100644 tools/kstackwatch/kstackwatch_test.sh

-- 
2.43.0

