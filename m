Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFC83D3CF0
	for <linux-trace-kernel@vger.kernel.org>; Mon, 25 May 2026 07:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779694807; cv=none; b=R4IqXRt+DrsPyWyzM0gsKnuvf+ZAQuxlMm1Pa2+fxZcHnGSPenwrP9+r3HWm2EiH757X2Lcn/rMnPPlbtTJsUMtA2aIZYDqK8atIlDa4yRjld8MJibx6WMq4sZn6uqOlCa/ycbV/kxnw/1w47tJA7XwF/d7J2zd7VolVFIXqpK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779694807; c=relaxed/simple;
	bh=TuYinzCvpQo9yp1p6ENBagF7t+X1tH5ZlFKbxMWO1Xo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I8iZNqHsHbuWIfZ5NbvUEqjHBC5nJtZtSsS3cV1C+I7hQPIz29AF+iJed8Ku0JWHy8TIgVk7kaCFqTbMOIVsxkYLucKAeGZuVkxEwvuzfGZ+5dyhZXO1eea+1HI4Rtz8nmrvK6UBl/Z2en1VN8/PfTiaawV/8t38GjQuGuDMBJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMlNDL5t; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMlNDL5t"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36608b2f2dcso6121303a91.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 25 May 2026 00:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779694806; x=1780299606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hP0h3uyWU6dU1yKMvNk/lERhRAyC4X4EG12EIvwIk8A=;
        b=fMlNDL5tGd3YElg8CpZA2gsyOb7jeUhWy1gd6wFO/UbuCs+GWwl6JQADzDIVpgNv2Z
         1cQtuSzgQJEYDssBNl7wTbliJj9BaLsCdG+byu6NlA9nCplDOLK58AItstDmdaWl3cHt
         2rvxLFj8B0lcoM5tPj8mFp17HWWco66QY97TW1e5V0pJJ/YbVjXldv4ye4m70KHf6NuU
         kI48aB/kqG+6dUJmC7IRhW7SKh+UyPT0rii+c/u5QZMg52F+XNKhFmzlroXuu8ZZLuby
         NRG60HVQldiXuTSpFH1aUmlquszKLFXgdR7Z5cofaCVQ2btpQaUVoMxHouQilv47olWI
         0reQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779694806; x=1780299606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hP0h3uyWU6dU1yKMvNk/lERhRAyC4X4EG12EIvwIk8A=;
        b=S4Fqsk/I5DsGEhstfP2Mii0EchR2SWwtrMLaiv1F/qHfRIVRvjOflBh7iRPoiYf5H9
         fY/yeOnHks+/UysVSP6gK0Q8aTtCYq2n9g2QMtGPQZNs5BxDfGmWVO7KOe9d5MPN85Tr
         eHOfg6u0ME+4yVpEklCjxmgTauLGJKJSxrDECy//Z4IE8B2/fXbUsrg11br2yFm7plVX
         PqlNfM0wt1tCpVpds+QPQEkqwKPnUc7lpuqRJVK6Nu+KjU2ZfVvzFJ2es5znGFgxOYGO
         JxCebXWF29TWEJboGXCM2BfJchf9RfpQPIIjzKVdgyqqQr9ROqzf+DhISHpauRaH7aM3
         QtIw==
X-Gm-Message-State: AOJu0Yyl/89J7v8JNrerykyRlUHJNAVfINVDn/vBX7oT73Ty4cLxtSsN
	ZinwTzQEBqaaQuEfdWy0WfjqsEoJDqxnGgLsjawxaKtNxi3hCgWa0ktx
X-Gm-Gg: Acq92OGzOTt0QQE7wyAG+BzWt4gWNZR3H2+CcRYftTFII8fjhwaZu91sdQDwGNn/3GN
	laAM+YRnuLulIcnI+EDQudX36ssp4eTyPWJuTSjnYHCKi7uqtf7sUboqlb9htXtaAhNdHjH1MKF
	IhquBXwtykZBZSUk/XcjdAcPMwWhTQOPJWnvR+FfjLPI7CL8Wb+1OSQug+3OWxx5jxW7zpoPHqK
	1zW2U4mHb9OMeY62fBqtwO8361pz6HETbuF5JGDjUX/KjFHWhuvRWvsLnq5HjQ33tRra97/kiWT
	Lb2cYZDal2F5laZp4RyBBj8hM/0FN8CTcB/di7vf6pd7+AUlmB/3n9YZZpDAr2Apga+crx0qyje
	CG5K+BbQCHqT9vU34wSg7FUGAjPcCB5ljV+H00sdUydb57ytV4Coq9YSrdUgYxtedTosdWCblbX
	fuq3WsNzCg4WrGNB+/psmIQoGBoxyUAGh7xv+EVA==
X-Received: by 2002:a05:6a21:69a:b0:3a2:d79c:416c with SMTP id adf61e73a8af0-3b328e4f02fmr14170602637.32.1779694805695;
        Mon, 25 May 2026 00:40:05 -0700 (PDT)
Received: from localhost.localdomain ([2408:8607:1b00:8:b4f2:93ab:3f87:70e7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164aed7c9sm10298358b3a.13.2026.05.25.00.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 00:40:04 -0700 (PDT)
From: Li Pengfei <ljdlns1987@gmail.com>
X-Google-Original-From: Li Pengfei <lipengfei28@xiaomi.com>
To: mhiramat@kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	linux-kernel@vger.kernel.org,
	cmllamas@google.com,
	zhangbo56@xiaomi.com,
	lipengfei28@xiaomi.com,
	lkp@intel.com
Subject: Re: [RFC PATCH v2 0/3] trace: stack trace deduplication for ftrace ring buffer
Date: Mon, 25 May 2026 15:39:07 +0800
Message-Id: <20260525073907.2355900-1-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260525155841.b15adcd50d25485aab287043@kernel.org>
References: <20260525155841.b15adcd50d25485aab287043@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Masami,

I went through the Sashiko comments on v2 [1]. Per-finding response
below; v3 will incorporate the fixes.

[1] https://sashiko.dev/#/patchset/20260522104017.1668638-1-lipengfei28%40xiaomi.com

Patch 1/3:

  - memset() torn reads against lockless readers: agreed, the
    reset path is not well serialized against tracefs readers.
    Will tighten slow-path synchronization in v3.

  - seq_next() not advancing *pos on EOF: agreed, will fix in v3.

  - atomic_read(&resetting) without acquire: agreed, will switch
    to atomic_read_acquire() in v3.

  - Plain reads of entry->key: agreed, will use READ_ONCE() in v3.

  - atomic64_inc() in NMI-safe hot path on 32-bit GENERIC_ATOMIC64:
    agreed, will move the counters off the hot path (local_t /
    per-CPU) in v3.

Patch 2/3:

  - TRACE_STACK_ID not in trace_valid_entry(): agreed, will add in v3.

  - "NULL from kzalloc" comment: wording bug, will correct in v3.

  - Reset memset synchronization: same fix as patch 1, finding 1.

Patch 3/3:

  - Selftest missing 'function:tracer' in '# requires:': agreed,
    will add in v3.

  - Selftest wiping the ring buffer via 'echo nop > current_tracer'
    before reading trace: agreed, will reorder in v3.

I'll send v3 once the changes are tested.

Pengfei
