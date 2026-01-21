Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49C33D2FEA
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Jan 2026 04:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768970642; cv=none; b=qEUggSrv6Xbc7wmENOBJDBfx+Bk4h0IfDVtVu2apLufXAMpJSoLpy3yuJGDFegLIT7xihtkIH0cwP1wg7Jg9JzP0k0jOOgGPE1bpaMhBFeVnlba9IkjFjmo2zUwUXb/SURASs8iCRP7kfJ8Zrfv9YSuCuC+kug31fztWHO/6ets=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768970642; c=relaxed/simple;
	bh=FhC8RW2prkqyszPdQGspTuPQvjqHT3cnRjk7WqnWHUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YLc7hS+udQdjsTPIKYQmTdWoWAVSbwO7hNmGIsWXRu1QxpnTJar4HpHrPgU58ZP2o9qULMRH4x/FspNwI2utA8UglTmRbqkXP58Rx+R4LOUR96KnohkN0Ki6BMWPElY6yrHb2331ZM0dkpquOeOLAIjlAyp72V297ie8Cbi/EFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWT7qKPc; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWT7qKPc"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a12ebe4b74so58330825ad.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 20:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768970640; x=1769575440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FNRRtAkD4CMLbrIwXeb2fCZrWubFbnyI5Z4ZT4ZtQP4=;
        b=IWT7qKPcH8ddSwu19c5PvA/cqk5sdtgK6oSaKrLQb5d421ppQpaEAPbBMznNaFqXFJ
         xg7VtoCq32HQbGXswCQEaKg6ch6kHMnL1rGo6MSmUlPAS80aDhzYNtMUf67ULL3L/Jxm
         GTbupBkVG3s+h38OO9YLZfEouaylKope7oLTPld8U11cOgptKLMJDUY8hC7onqVy//gy
         hVWsS4mhBfqXhdqmKovqn0wuAze9R2q8mrv70U0bEHDULRfG1Ziru+v6dBY7nlktHEjM
         6E4wsngKjHtwAOr901AXRVv2/7lZSNJZY5F+2id1g6ds9x/oOZ5TkGjhDoyvfPhmo2XQ
         VQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768970640; x=1769575440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNRRtAkD4CMLbrIwXeb2fCZrWubFbnyI5Z4ZT4ZtQP4=;
        b=mkZh2iTniRCBaNUhqKntNTInO7EBh154rTbDWimHX0wza75KmfgJv3u8Q3QwX9kDOG
         qMIDgvqZKZkgXJ1q48kJlJn/xVPrnsHIayuvvtUKIWFsuZs6U9oVxtDfpNZwtQQVVpzY
         VSBa8jyspntk2uVkmrWEM71P8tzGt2tNmCxX+t0sbtxGcLo+1vPFnFlSg+UYvAaZwvbp
         ltbrB0Vqmwt6FDE8lwHKl33/gNmaWVBTwkdAOSIVj6tOM8PiQoHKY/NIP2PDOecKBrcQ
         DVWMR2jXH/O0MWp8Av817BKoXte9aNIjyjMe+D5NEBGTrNHze5UD3a0lVHhzPA9ykJol
         zn1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVcQ3yx1S+2XChgKVygLqVFo0FYosAcGGSDUYSjSDM5kPBcZF1Aj2U60sQzQyuil6VcuFaBCmUHYORX8XY4wCzaqQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfOhGrdN86K+/6N6wmV7HaPxD56Hi0XuvuCEF4EH7VXhMT6ha7
	iuvsIssl6Ts258/ORON49w0HYwgtkHhqY60vwUaXU+GZ2mjbq0iQ0XNf
X-Gm-Gg: AZuq6aI3TAqftXfWuhFwWtI3NH/cGT8C8XnlgRlnCxq97WHeafZEzjzFglqwB3RRXL1
	xTqyLTBwA0nLv2KNcd6v6fSNUMwqh+Gom8zmB0+AX1J6pwbAU+WceR00Lprxa2Xe36X2uTFtmaz
	ICTXwnEQXWNjzfBonoFrWx97bbPVYd/c83z1MzE2Xh7S3Vg0S+1F8NgSKCyCWJ/EH5ecUjEH/oc
	i8cDtov4K9aA/14JXCvuouFackCA6oPUv3x+/Z3MMwU0uZepghoom3ljAmLRnCMxfEZo8Ztvj9B
	czSV5VUdtgbcGlmjMZ6dELySAcdy/kIWlJZVqmh26L3QYVXV3oTJwU/Onydmr2etRF0UTf2/g/n
	/xiRuxfOklFAAf1XNtA3xLJipLTKVi1y7eJ1eL1CarJVTIZC+f0lgdZs7/D9+rruqawQNtcEWzl
	h84L/Q6Mc5
X-Received: by 2002:a17:902:d48f:b0:2a7:6474:6e48 with SMTP id d9443c01a7336-2a76b169662mr31309745ad.51.1768970640170;
        Tue, 20 Jan 2026 20:44:00 -0800 (PST)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193dedacsm139754815ad.58.2026.01.20.20.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 20:43:59 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org,
	yonghong.song@linux.dev
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v5 0/2] bpf: support bpf_get_func_arg() for BPF_TRACE_RAW_TP
Date: Wed, 21 Jan 2026 12:43:46 +0800
Message-ID: <20260121044348.113201-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support bpf_get_func_arg() for BPF_TRACE_RAW_TP by getting the function
argument count from "prog->aux->attach_func_proto" during verifier inline.

Changes v5 -> v4:
* some format adjustment in the 1st patch
* v4: https://lore.kernel.org/bpf/20260120073046.324342-1-dongml2@chinatelecom.cn/

Changes v4 -> v3:
* fix the error of using bpf_get_func_arg() for BPF_TRACE_ITER
* v3: https://lore.kernel.org/bpf/20260119023732.130642-1-dongml2@chinatelecom.cn/

Changes v3 -> v2:
* remove unnecessary NULL checking for prog->aux->attach_func_proto
* v2: https://lore.kernel.org/bpf/20260116071739.121182-1-dongml2@chinatelecom.cn/

Changes v2 -> v1:
* for nr_args, skip first 'void *__data' argument in btf_trace_##name
  typedef
* check the result4 and result5 in the selftests
* v1: https://lore.kernel.org/bpf/20260116035024.98214-1-dongml2@chinatelecom.cn/

Menglong Dong (2):
  bpf: support bpf_get_func_arg() for BPF_TRACE_RAW_TP
  selftests/bpf: test bpf_get_func_arg() for tp_btf

 kernel/bpf/verifier.c                         | 22 ++++++++--
 kernel/trace/bpf_trace.c                      | 10 ++++-
 .../bpf/prog_tests/get_func_args_test.c       |  3 ++
 .../selftests/bpf/progs/get_func_args_test.c  | 44 +++++++++++++++++++
 .../bpf/test_kmods/bpf_testmod-events.h       | 10 +++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  4 ++
 6 files changed, 87 insertions(+), 6 deletions(-)

-- 
2.52.0

