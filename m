Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D62D2CAB
	for <linux-trace-kernel@vger.kernel.org>; Sat,  8 Mar 2025 03:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741405584; cv=none; b=UoQFEwjlEsgTUJ+RukSkkoWAUKiOec8ufQIVI97XfpdWPI2gFxg8l90wyKOllBQ6CP/W3RxeL2+20bycy0Km6FnedQDfGrEZBkNpTcrgLrpwvB9R8QQvj/DmYXK5hw7nuQV1k6vnR8Y3jdwM0+vdTMAE0/YChArP9i04BmKE+/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741405584; c=relaxed/simple;
	bh=X06PB3T3m5fg4A+Qjq0ItNARSzcDwsDKDNPLQ22yi04=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mMWdk7/6cFylQ6dsz/GzuzjOM+9JRnpSjgrFf0SpW5alknTa1RQHWCdNObyj2gIESVudL5IPxHu/0aHi1kPlu3tsrpEitShl4DX/oWfAJpDjskm8V8VOLqbsVlIqXNcbA+nuS9TG1r9gpr8UG6Ajs1Yf0BTan7pR0IabLNr6kUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--liumartin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MxMdGLHZ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--liumartin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MxMdGLHZ"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fec3e38c2dso6994853a91.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 07 Mar 2025 19:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741405583; x=1742010383; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GA6M0g+rvKz91pMPmDBO89woKCgOmvhJSGNhdL2Qrhw=;
        b=MxMdGLHZD3AAN7n4JIvpRins5I3McRJUXBKO4l8a+Na04W3Sxbie1mSUyD7XIYNrAY
         TTQskrzA4P/+tv1U9NqFXl0kkJt/YSmv0+Ue85oXb+Fth2IWrahBSUbqzF0ww6bBS8o6
         D1J/a+1SnPZ7Qfa2fgfgwIl3ZMKt3MEcC4qkH72WvTVkTRGfPdTohZJNGHik3nP0ehwc
         Wgg1O96lHgzOW8e3dgAkHuPpUwZ2o0pa8qLbCJJ3YRuVugJuvAGauvyHyKTwcEdjveYv
         M+zljtbRtSvdMYftfhJbRFgQjd5rN2l9d1bnB23NfwYw8SoN1jBs/240H5Z8Gnfs7QNn
         CBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741405583; x=1742010383;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GA6M0g+rvKz91pMPmDBO89woKCgOmvhJSGNhdL2Qrhw=;
        b=P//BO96zLqV2OaDCSoxxrE9S6J33/BnEN2rfqSjSLMIdm4mZkXsSVEVwy2mGovYCqh
         57MTOSiOM/KI8h4FCnJSg7cwqOl62yp4plkRSThuLOAc3EvmWfFQHWfHPfhYsvx2n/uF
         O2fRrxJy+iNZWBrEl5zGvPH2AW9qylLzFuhrbP5VIIpIxfoI7ZSMs759BUTH777J3g0x
         bKGf2Ga+J6ECzgTdz3ic38WkMALoSkaPmogOidL322DGr3yZENi28E7W5yIbibvAowka
         VrogoC+fHxlXw81y88h60fO8d/8TPo4ffIWsNpORiueBETrvWybRVUcfcYBeMrbiMJip
         E5ww==
X-Forwarded-Encrypted: i=1; AJvYcCWKXYiPfBMfQ7i+zxjaXm5SM0GWm1IUT3FuwDj07TFe4qlSnuTpCtRpiHAM4keSQCwaMLp3LcTbUbLHIciEPYzsKmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG6g0pOOv5dTjBLpF/vKNO9SCc1syUXi5hgsaO/yQnuvho0dSs
	oHImJII7Ih/hX2I/8eg1slkureH1gV7SzS9nqee5E/AiTKsyQBTIQU3MkEm5hMo1P6eKcmwbgzj
	7liWu99O8Dsh0PA==
X-Google-Smtp-Source: AGHT+IFyfo1BUqJAhhHtjvCd7JQ6sFBCeGHbyX297O85/jRc8vXv2lLZ9VO7j8vZyQ9dp834rWXS6pRG9yvO51Y=
X-Received: from pgbdq25.prod.google.com ([2002:a05:6a02:f99:b0:af2:4e8c:1cc0])
 (user=liumartin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:1594:b0:1f3:48d5:7306 with SMTP id adf61e73a8af0-1f544c663camr12188527637.31.1741405582722;
 Fri, 07 Mar 2025 19:46:22 -0800 (PST)
Date: Sat,  8 Mar 2025 03:45:59 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250308034606.2036033-1-liumartin@google.com>
Subject: [PATCH v2 0/3] Add tracepoints for lowmem reserves, watermarks and totalreserve_pages
From: Martin Liu <liumartin@google.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Martin Liu <liumartin@google.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

This patchset introduces tracepoints to track changes in the lowmem
reserves, watermarks and totalreserve_pages. This helps to track
the exact timing of such changes and understand their relation to
reclaim activities.

The tracepoints added are:

mm_setup_per_zone_lowmem_reserve
mm_setup_per_zone_wmarks
mm_calculate_totalreserve_pagesi

Changes in V2:
  Fix coding format error. Feedback from kaleshsingh@google.com.

Martin Liu (3):
  mm/page_alloc: Add trace event for per-zone watermark setup
  mm/page_alloc: Add trace event for per-zone lowmem reserve setup
  mm/page_alloc: Add trace event for totalreserve_pages calculation

 include/trace/events/kmem.h | 78 +++++++++++++++++++++++++++++++++++++
 mm/page_alloc.c             |  4 ++
 2 files changed, 82 insertions(+)

-- 
2.49.0.rc0.332.g42c0ae87b1-goog

