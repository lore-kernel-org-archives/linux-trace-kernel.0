Received: from mail-yb1-f231.google.com (mail-yb1-f231.google.com [209.85.219.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B212E13DDD3
	for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Feb 2025 01:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739236322; cv=none; b=RXsufi5Il19DCmOmQtp873JO+wJudo78nLIq67pwV3dVWQfHn3SqpcyoCFPCtguqVt8n2TjTqZL4j1gcVBPUghZrBgAk1z4CDdT+vP0yY+k3qg7s/XxLR58hPagNjbUxdnRQPGCStgnDJV1u7MJl6POruJK87TfgZPsCSl/z06M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739236322; c=relaxed/simple;
	bh=oU9Vjn3evzRPUU1ySr2p52/QBxUL2dgFlJRN4hhi2OA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bvS91EK3Jqj0ACuPz52GChNkOd5JwmLuMOF1KSzqe3DsGrs3KVErWxP1Da6IDtDtffcfZ5IzBnz67p70x0bsmgTOuIL+JIntB569Qeb0T/occozBcDHqT315DTgzNyulHT0Heqmqtvsg1oe1m7FT8q3rvAV7Xbrwmc6MmzWHV+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=TRWPi7RS; arc=none smtp.client-ip=209.85.219.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="TRWPi7RS"
Received: by mail-yb1-f231.google.com with SMTP id 3f1490d57ef6-e5372a2fbddso4169405276.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Feb 2025 17:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1739236319; x=1739841119; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3iAwoF64/JM2pIwpdGlzRcSNqotxPNvi07pp5nAGXxQ=;
        b=TRWPi7RSYTUYaLIN/vGFb6NOdidXEOdiJc3Fb0cvvxLBvZWm0q2qPG0ydkR4ODC5K0
         aq3o2SrVOs4SDbf0w9pucatFNUZ3QyqFndyLsX56yRr3bNxfE1AAXYRQMqfa5Y3jiZV7
         6BhFnDGRHWo7lcOtmL3pCI+ntToUb2P9gyrwV8thYdIteX636HzygXkbTUDUF08b+RhL
         mnXerdnnwrBtv2VzACZrrikUZEZ/2ZVEw2wRMDW9Jvs/bnj3i3bmC45OPAX8Xj9k0uO1
         O7DXDItWrOJFtApEXLmwxD5OPzFkZWUU7YViRapHGzDtXrJrqL/uDGPYjPf0Mw2Ng4KJ
         MEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739236319; x=1739841119;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3iAwoF64/JM2pIwpdGlzRcSNqotxPNvi07pp5nAGXxQ=;
        b=XJkyuq9cVVycg/05E1NnOb60p/AO8OSc3xMVdUUqW9Qd1DxDKagX2j/j16B85kafR5
         6aoB+HZXZ4clyh9sUUnmk41OufZUWRUMwY/ChbL3bwUb7OqZCHE88yp/j4TaIwG1+7WP
         nRS1nn9eQ4h8a3y/t+/iDVjElP3MM8ztLhfhxX3qeFxNEa87/j4PMQD5DvHlQqhW9PyC
         80JedooD7UcgzwCqgzKIsxhmvcRNHwa48ne/k8BmndNIEPwn/0gVSu8Xlhk8Got8iJdC
         FUaRX6pNzVhSmDSU97V/OLcZXTaVMZRT+AL5fGhLr4GPdo3DMM4F8f+uWektAkwvM7CP
         Jj0g==
X-Gm-Message-State: AOJu0YxCJcF7e2FefWRLLIzEp9XlaeyK2JLPQlpLyqR/XhaI6zk0cwYf
	FXPeafR0AHntgAS7QgT3OmB1/UE3OQPTDAtEyYzlsqWg0JrsLf5gDn+9X8QCnja5a9ZlvQyuIMn
	ZYEf7faUYaqzZ3ltYH3z5+5xeEKq2D6ryMSCd7ZsanJtkDroY
X-Gm-Gg: ASbGncsvToQlq9DOJeTwNkV5xjrgXWv5tvmX9Z7JjRVnug1FdWiTeg82ikD+N5cz/K+
	sKdVZdAgD/G08PFV+eYfPPvXC7LHOcsh8Fv7OTq8YM/x1Z6EqRY/3dnMlJw3xvL8+Z/fKbBuCO1
	gtQ+JAXbaC+PZmgIzQTh5R75z3zOchDflJaJEBHyDdrDOpuAT9eAp86por95lrOXM+ncrP5NL2d
	L2n9LCldw6dAHaL5IBVynkjyJ7r1YEk6tr5TWCiwgbBqXDJ+QAuoEOEx+ompqlSOYGiVLvWUtMH
	YvRPgbaWDHWHtPlicPJU0zbe
X-Google-Smtp-Source: AGHT+IHDqPaAL1oOpE9xog6VFP5KqOBuXpBE/UI8ohiqN1xWDezpBCEIb/+T6ncDTp6f/vCO9VGHG3+5hg6a
X-Received: by 2002:a05:6902:1684:b0:e57:6644:ea3f with SMTP id 3f1490d57ef6-e5b4618d4edmr15451390276.15.1739236319502;
        Mon, 10 Feb 2025 17:11:59 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 3f1490d57ef6-e5b42316cf8sm541504276.14.2025.02.10.17.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 17:11:59 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 5DB67340283;
	Mon, 10 Feb 2025 18:11:58 -0700 (MST)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 61FC0E41340; Mon, 10 Feb 2025 18:11:58 -0700 (MST)
From: Uday Shankar <ushankar@purestorage.com>
Subject: [PATCH 0/2] kbuild: rpm-pkg: improve debuggability
Date: Mon, 10 Feb 2025 18:11:53 -0700
Message-Id: <20250210-debuginfo-v1-0-368feb58292a@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANqjqmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIwNL3ZTUpNL0zLy0fN3kFOMUSxND88Q0I0MloPqCotS0zAqwWdGxtbU
 AC8nod1sAAAA=
X-Change-ID: 20250209-debuginfo-cd3d9417af21
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>
Cc: linux-trace-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

This patch set aims to improve debuggability of kernels packaged using
the rpm-pkg target by producing debuginfo and debugsource RPMs that
contain a full set of debugging information for the kernel. The
preexisting kernel-%{KERNELRELEASE} RPM is also shrunk by moving all
debuginfo out of it into the new debuginfo RPM.

The first patch is just a bit of cleanup to keep rpmbuild happy, and the
second patch contains the main work.

This is technically a v2 for the following patch, but since it's been a
while I didn't mark it as such

https://lore.kernel.org/linux-kbuild/20240910014327.1726214-1-ushankar@purestorage.com/

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
Uday Shankar (2):
      scripts: make python shebangs specific about desired version
      kbuild: rpm-pkg: build debuginfo and debugsource RPMs

 scripts/package/kernel.spec       | 31 +++++++++++++++++++++++++++++--
 scripts/package/mkspec            |  3 +++
 scripts/show_delta                |  2 +-
 scripts/tracing/draw_functrace.py |  2 +-
 4 files changed, 34 insertions(+), 4 deletions(-)
---
base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
change-id: 20250209-debuginfo-cd3d9417af21

Best regards,
-- 
Uday Shankar <ushankar@purestorage.com>

