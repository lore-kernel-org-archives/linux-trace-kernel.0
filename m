Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985CE31B80E
	for <linux-trace-kernel@vger.kernel.org>; Sat, 22 Aug 2026 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787406840; cv=none; b=Jwuksn8QJ5ztT1cIqxQZNQULCXCj3wGkwUQ/yKBxmtO69K3TkFL2nU0XVxkUv+J6oF+Ul5C+7NwRPef7lP+TTygWl7s3NuGywFft380S3y+vhJLprLoINsDh4/Y5Kd7HjKf5eMN7zyH1e/oXJVq9KjKKzzh3xUlnwjVQw4HpDEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787406840; c=relaxed/simple;
	bh=KwumCbK0KC+u949MZK1dUWJ1omlUFIWu77pjxVizA9k=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lp69dQ3M+vVFgLEBDBW7ogbS9JbKxPHJr2fqkOipexsc8m4LE7SeIT/I9EaUeWlYGJsPS5YysgrYPtpUi2D12EgBgavfjMz/NeUUqtlh+jgnrEe9GPU3TcCkbzKCkXdACF0+fL8tHqInh9RlJs6UxSS2IdCLCKru2nReGn3cpmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b4PTNAwb; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b4PTNAwb"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-496b6f97676so17346935e9.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 22 Aug 2026 06:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787406837; x=1788011637; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SFWwYfK2ORvvb1ePNWqdIkWg8WHsPyZq2XD2ex3XzW0=;
        b=b4PTNAwb2J56lHyHKwn0suVtTg7T38l7z73LkKx7fqE3BvQBZk6I/2bwuIAyP9ceRW
         z+E34x1X2Y6wDZBu9yJgZErdSkrfQNA67DzZ45rwQMtDb95q7OD+beXMq9Wa0SuQpfUA
         dr2bR3ZGHmfG6TRx1+0mYl+A8IOnf9wWheZeCFgmZ6J55KEdA9PTENoP2/MVQXCIJK7u
         LlLRYX5EFgbavpNkpA2inRmSLQcZSLEEblsGas+UZrIiTbRGC6mYwiBSdd1hkAwW/uf2
         tbfDVVWIhevMIjb5Qc20VDkOyxFPeKhnLlC9jWGLJ1rUnrHXXNVSf8QrSF0T1+T2CpSS
         fIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787406837; x=1788011637;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SFWwYfK2ORvvb1ePNWqdIkWg8WHsPyZq2XD2ex3XzW0=;
        b=JhhpMSO7SOIDotc5TMvaqTQBu5WxAIkGHTrcpN8qWG+g8jCJRFe6g98rpBKruMBf7r
         yu+ja1UbTJmBvcx0QnFg/AtRy0fHmHhVBzrQ+d0D8ZMlIyhOTU17TNhpgZqHCrCtNQNI
         g3T75e/0LjG4gvj/Sh3iD6tfxwmo1fRB9bwC69jhc/A7+pUxhHiZep5MJzgBhbzAqTn0
         v1+Id9Zq94bK02x4nC0uE85uxP1PtsvoP2vnbCCDFsnJK9GsAme2jOO+RO0M0YoVke0g
         Nk4QR5d9AbXB4XJ4Pqd2hHg1//7Pm9MiaCFjBxzy/iW/PeVk5kFTL+SUXPPMwFB42dtH
         PkaQ==
X-Forwarded-Encrypted: i=1; AHgh+RqcUjJ3lyHKU4dLUhxGiPndmNGWYeABn6HC7xm560VbFqTYoiVeaLBNFwQjQZHICPheybUvrpyd6VL+5wYLmYIgkYw=@vger.kernel.org
X-Gm-Message-State: AFuF++nutDr/P4g82OpGb4YImqxjh459G/5gixdbbr4mszuJ/5tCloHb
	1ayWFSenoJ4YUf6+Bt7mFO2/mcNPMFBRRcvzJTo9XQrhRFAfekai6Qy6xZBApsmB7SlMEhsRcg=
	=
X-Received: from wmlu19.prod.google.com ([2002:a05:600c:2113:b0:493:ae35:2761])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4f06:b0:499:a5fc:207e
 with SMTP id 5b1f17b1804b1-499b8340754mr196385025e9.8.1787406836660; Sat, 22
 Aug 2026 06:53:56 -0700 (PDT)
Date: Sat, 22 Aug 2026 15:53:22 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=3648; i=ardb@kernel.org;
 h=from:subject; bh=2f7AvVCI5x1tX97+DCcut0s/Ah4Z634pXHbbbq7B0rk=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIatz5WXxBeue7y3/sIvrsfxld8u+ud3712Ssecfy8Xo4Z
 /z2HZaKHaUsDGJcDLJiiiwCs/++23l6olSt8yxZmDmsTCBDGLg4BWAiP98zMvRtO33wRsLJ8H2u
 zLVsqfNVVy7rWL3p0aqaHzyLTcMu3S9h+KfBcnOJYGSsFldpb0TP6S2Bt7lMSs58us+6yehx6eU XX1kA
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260822135323.795946-11-ardb+git@google.com>
Subject: [RFC PATCH 0/9] arm64: Allocate .text and .init.text together
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Ard Biesheuvel <ardb@kernel.org>

The arm64 module loader has to deal with a couple of corner cases that
may occur when .init.text is placed out of direct branch range of .text:

- ordinary direct branches from .init.text into .text may require the
  use of a PLT entry (i.e., a trampoline aka veneer), which means not
  only that additional PLT entries need to be allocated for
  cross-section calls, but also that .init.text needs its own PLT
  reservation, as the one in .text will be out of range as well;

- dynamic patching of the ftrace handler into .init.text code needs its
  own dedicated trampoline as the one in .text may be too far away.

- recent compilers may omit BTI veneers for static functions that never
  have their address taken, and so additional veneers will need to be
  added to .text in case cross-section direct branches from .init.text=20
  require a PLT entry (and therefore a landing pad at the target end).

This is unfortunate, because it is actually somewhat unusual for .text
and .init.text to be so far away from each other: only when allocating
either of them (but not both) exhausts the 'near' (PLT-less) module
region, the other will be allocated from the spillover region, which is
not in direct branching range, and therefore requires PLT entries for
cross-section calls.

This series addresses this wart by allocating both of them as a single
chunk, and freeing the .init.text part along with the other init
sections at the appropriate time. This ensures that the two regions will
never require veneers for cross-section calls, allowing the arm64 module
loader to be simplified.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>
Cc: Daniel Gomez <da.gomez@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>
Cc: "Adrian Barna=C5=9B" <abarnas@google.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-trace-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-modules@vger.kernel.org

Ard Biesheuvel (9):
  mm: execmem: Add API to split an existing execmem cache allocation
  mm: execmem: Allow huge vmappings to be avoided for execmem caches
  module: Place MOD_TEXT before MOD_INIT_TEXT in enumeration
  module: Allocate MOD_INIT_TEXT from the MOD_TEXT ROX allocation
  arm64: mm: Permit permissions changes on huge vmappings
  arm64: Enable the execmem ROX cache for module text
  arm64: ftrace: Revert "fix unreachable PLT for ftrace_caller ..."
  arm64: module: Combine init and core PLT entries again
  arm64: ftrace: Simplify PLT handling

 arch/arm64/Kconfig                  |  1 +
 arch/arm64/include/asm/module.h     |  2 -
 arch/arm64/include/asm/module.lds.h |  3 -
 arch/arm64/kernel/ftrace.c          | 13 +---
 arch/arm64/kernel/module-plts.c     | 63 +++++---------------
 arch/arm64/kernel/module.c          | 20 +------
 arch/arm64/mm/init.c                | 19 +++++-
 arch/arm64/mm/pageattr.c            | 13 +++-
 include/linux/execmem.h             | 11 ++++
 include/linux/module.h              |  4 +-
 kernel/module/main.c                | 22 +++++--
 mm/execmem.c                        | 47 ++++++++++++++-
 12 files changed, 124 insertions(+), 94 deletions(-)

--=20
2.55.0.860.g4b6b3295ed-goog

