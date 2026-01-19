Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A521DC9B3
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 02:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768790264; cv=none; b=sxx9kFfZmpJHNinvxZjtVoMqRt0m4niwuk9xVPRtwvr1wD+T/0ZvXefb86TwboWBaTw4DOmsJcoL4upSLE0kauiGseQWE15cLW+hTNWkNjGwlrUGrAjsIS0TCzTAHnaInOzg5/g78EWu1yc1Urj+QLyVz6/sJAZR5agRG0hZVME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768790264; c=relaxed/simple;
	bh=vE4UtI7vsbPwN5O8TTJQLR2y0P2gdea4s1NbUI9fIOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eou4nHghtB1SnnTwQLttUX7tA3NKTTHxmNqp0VBip6OEsJekZKDCAkW/tOdYnqsL1isY3RI907nBH4qMR4XKWXejv4dK84OdI4V06jx9QDpcHX/D0XIa7jUppv2pkLq0PW5w1UkWT24VbvBL13xDHILXeGAbnlaQJ/ui2LLIP6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kF43OmrW; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kF43OmrW"
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-b98983bae80so1476130a12.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 18 Jan 2026 18:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768790263; x=1769395063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AXD7gkLP0fle4I19z7dPAe1rEcwBG5fmCSuAh6ILdaQ=;
        b=kF43OmrWd0S9EqfALeJnEIEsBmdNc3Pa8JH4A+HAcmisuL5ToejBuQMhpmgR6Xwvik
         jvBQQ1+O9hzqUtPPAgLFA63oF82c1cR0qhTEFmlRP49w38+uAyqUwQL5PxMkrNER12Yi
         QWWnPxp60DdyTkDrNh0/45IB1PFdBn7jMPKFCiPvVO0m3rd6T5xTim0i6jHTV1ZGPUrq
         cmYoQs7KSTCRbnsOz7p7Gu+hvDiY7uRJ3YuPtGu0I/TCzEJkKL/+qgyaAmHrbOG5cDzD
         vDwkMS9aiQdQYkZ/4gHqlLuitzc6Nx6zYchx+ZY1na7WzBAQjAXh4OqKLiepNn5e+Xak
         LMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768790263; x=1769395063;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXD7gkLP0fle4I19z7dPAe1rEcwBG5fmCSuAh6ILdaQ=;
        b=DiUiL3wVnelYZtk4UNJGYuO88nzzNAgreoKCloZy65R3fgrVLwqIUWCrsguHu/PiB6
         i9ZRjKwEkfMS3iY7BF3PL+ePAFSl9uKFm2UEPBZOyB2kywgRf8A2MA7jXLUQaiqEyagM
         ylQBkoDe96lsjQArCXRYYP5z0+NlpJrrT/QJiAZg2ocyIfot6+UC5Wk6uD/Q1GrWLGGA
         NWjWNwDPRSp5agoAu+hZ7ZIZxoy5g6QXsjKLe3TzKA4ma+03c/5DsHLrqn0MmG5bOWJS
         L2DswKtaWIVZEjy1XAL9fj0ZriIxUVJlokRKb3hfHr99bk/R5cNPDQgoKyMrvCxFPUWF
         mvLg==
X-Forwarded-Encrypted: i=1; AJvYcCUdHXgC4ZU8qWIWkfzXphMy1Gh5owfG53EvFruimEekq5F4AuPS+OgVNx3rH1F95VqPYoOl0PbnfEHGGsJo5I9Hz/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL954HFhBhmQom+tDnphvHQVqpVUZCA+CVfTJgyUdFtdzVEuP2
	+e6LOoubjwUVlu86g/wyNmpPLTa27/hn5sCgEMcxtNhJkytXoGnVJsYl
X-Gm-Gg: AY/fxX7h6eW0bZfaxG534mYJKBmBKxYdfEnPeg6lUGfX0h49dXdiEvWzxd0Shhm1X0/
	kyY/Ono4sWLDqVsVhBIsK0zcSxaYK4pvEC8iQ+CM+f2cUXTGlW5wjcBnOXnEYcSagY/2b6Ja7zA
	NCaI0/pSucQFV9gfh/5+y2fn/NOPmBLHzlz+YfsxwT9m5OTLYdOP+OmzHBbmC7e7ECFvAwZa1aJ
	7tYTC8oJmECSATBAE3DuOHs8OY2e7PfZrvFj9JQ2m+gLN6NqBeHdyGK5ijHNh3perHIvmve/O8n
	07/qI/ZJ7uBHFwEVfP/IbqCiHBYWVYLPoahyjXiSlarFbbKuSF2lMQbbhd3Jb1uTzb0PcEHqHTh
	e/i/rjljXI7aOdIrL5JU1ZbksxK0lppyy4Hct3PnUjaabA+qU40K9e1DSSYlwIsGuRRn9BuG6v8
	M/ScZEtik5
X-Received: by 2002:a05:6a21:101:b0:366:14ac:8c70 with SMTP id adf61e73a8af0-38e00da3cabmr7501977637.70.1768790262809;
        Sun, 18 Jan 2026 18:37:42 -0800 (PST)
Received: from 7940hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190c9ee9sm77154645ad.22.2026.01.18.18.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 18:37:42 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org,
	ast@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
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
Subject: [PATCH bpf-next v3 0/2] bpf: support bpf_get_func_arg() for BPF_TRACE_RAW_TP
Date: Mon, 19 Jan 2026 10:37:30 +0800
Message-ID: <20260119023732.130642-1-dongml2@chinatelecom.cn>
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

 kernel/bpf/verifier.c                         | 32 +++++++++++--
 kernel/trace/bpf_trace.c                      |  4 +-
 .../bpf/prog_tests/get_func_args_test.c       |  3 ++
 .../selftests/bpf/progs/get_func_args_test.c  | 45 +++++++++++++++++++
 .../bpf/test_kmods/bpf_testmod-events.h       | 10 +++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  4 ++
 6 files changed, 92 insertions(+), 6 deletions(-)

-- 
2.52.0

