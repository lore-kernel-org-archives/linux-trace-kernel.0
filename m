Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423F93A783F
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 07:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768894260; cv=none; b=stdRmmlu3GRicZT8CsJCA/pDUNINyd/NK7JTBrB7weFZoDneoD3upRk5USjKVcoAlcLvT+iFgXvEw9AUDRN1wmGQ2r4WlQaqf3igOD37m+jU4Wab2xY2oivsSuDBI3JN91kgw4AN3vUM37pss7ZSX2pklxm2Bob24Sc1FZHFy4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768894260; c=relaxed/simple;
	bh=TH+y/5eR44Gi6eHkf0DOaqZcfV5F48oCEnf4e49LNwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bbf2P+LX8k9PxDLqR+HZitYkWEbSsEd1lcMo5Kr6lnU6VHxHQyJVnssPeEE7rm+1ddtPYwr6J0YZKpDvPgkpn2AbZFTgidfoSogRFjdCFlWGVZKFg7k6PO8mJ2DTSPaLW5wC2T5JjFIKMn1wGCusw7wmbk+SkhRsfmhX0vLV/xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AhaGX7TJ; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhaGX7TJ"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-81ecbdfdcebso2979012b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 23:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768894258; x=1769499058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=akH5HXotpzW47WqMXlXGnxoszL9Ij3pR5J2SVW4ssXI=;
        b=AhaGX7TJNQAVHd7jStTmWvVtTmfZLWcE3Il/6qZ7ZiNRaR0GIbrQf9OD1OsX0d9+Gg
         QUhxZvJcfm3jc0kvivAuXdXDdCb/gsAUScy7iy5xyUSfRGjFz6SzrwKdVdci0lzIlhnj
         iZXm0jkGTgkx4+oZ+D2EVK8iQWVs1UhlKrfFy8kaVjmZNCPEkSTpv0YOWxKOg/oFCW05
         PDFg+Ka4QrH0TlYrXz4R/Nn90GjDtnL9/M6R5b1Y+1l5Q7m1Fs1R9ojTMGeXXXB27dQE
         v2SuMgWPwie+W4kiWyUYMRYc2GL94XxrUUiQ20Kz8tQrf5v2FM3978/jdszbZ/5w4xOw
         TjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768894258; x=1769499058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akH5HXotpzW47WqMXlXGnxoszL9Ij3pR5J2SVW4ssXI=;
        b=U9JM1CXDUBSCUS9up/L3mQP1GzVjVaNOgaSCGNFEeVImu97waog/bL7mWvBD+2XrKO
         lUawzj//zDrYsrX2SCf7UiCDf7/uuR9Xp3thuSuUdtiZY/x4tMZV0Cxbh1LcToUogzmq
         LH9+1V3ElGmSjSgxE/aleYWKV9gjs4C6wOsqy23s0GbLrmj9Sok5/6ZBuTerpRUEY7qg
         wXB4gKnxO6K6FQKi1XEabRoxlAkMu4Xc7+RL1sBzVqGug2ixOaAvdpfQMEeKY/pw+EC/
         29MsrZvwl5aoHlUQEex3i+FAs1LOBbfiUnCzwo1OAtxtM7XzO+EAv9lyjdD/yKsLebGX
         nu2w==
X-Forwarded-Encrypted: i=1; AJvYcCUlRkMSSvDmudod8HDm9sJCKFfAJ9EiFvo8MrExm1ZuOZt/d80sADEsN6CbqZ+JFxEcI/JNCHcyzFHd2asuS3sdjO0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx1qWHvNMRt8mEiRfAwXDAeS1is4rfxfeVEfCEfTHRPABDzbaR
	rrJIbHOVMmiFbnpqRPpErpUpIYwRAoz6FOhKbsNCuSSpPc1kwg4d49ZN
X-Gm-Gg: AY/fxX64AFer7k3CPCu8szrCw00YsbU6UDMpRqcs4tHwY6boFuEOwRIrgHwn4qeqoGC
	0AMOhecYDZZzSBCwHCeBnzsUaUwsC7SkYSORyp/y2c0N1UjKg1r5mSA7zOKQU6wMVWgMRfyqasF
	xgFTFaoBqNiVZ8bOvkvrCL228K+xgkKFCFsmtRFpXIGH5TjAl1VIoCvWBoU/0a95/ATo6DKbdxX
	e4Vlg43M1go3aDpb40lGeiJ28yILwC8VEMSfpSQg7EXXDeqTIr5STkOOfx3CtnH+1vHQW16Ya0v
	nHTEV5gRp+9JLFJrJN8j4QL/fKXpakptSifli7lzIo0wOvO4Ouiv854r6p1H6O56LydjRC3m3BR
	0lg9UpT/iuP8tYkLBDn26D7+0b7lXjiGIof0bYnPH9j4+O7Me6yxqQxWirV2EKiIOF5QC0KCUmC
	ug2KOUmmPl
X-Received: by 2002:a05:6a21:4d14:b0:366:14b0:4b03 with SMTP id adf61e73a8af0-38e00d6e972mr12419808637.63.1768894258319;
        Mon, 19 Jan 2026 23:30:58 -0800 (PST)
Received: from 7950hx ([103.173.155.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf2363e5sm10822395a12.4.2026.01.19.23.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 23:30:57 -0800 (PST)
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
Subject: [PATCH bpf-next v4 0/2] bpf: support bpf_get_func_arg() for BPF_TRACE_RAW_TP
Date: Tue, 20 Jan 2026 15:30:44 +0800
Message-ID: <20260120073046.324342-1-dongml2@chinatelecom.cn>
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

Changes v4 -> v3:
* fix the error of using bpf_get_func_arg() for BPF_TRACE_ITER
* https://lore.kernel.org/bpf/20260119023732.130642-1-dongml2@chinatelecom.cn/

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

 kernel/bpf/verifier.c                         | 32 ++++++++++++--
 kernel/trace/bpf_trace.c                      |  4 ++
 .../bpf/prog_tests/get_func_args_test.c       |  3 ++
 .../selftests/bpf/progs/get_func_args_test.c  | 44 +++++++++++++++++++
 .../bpf/test_kmods/bpf_testmod-events.h       | 10 +++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  4 ++
 6 files changed, 93 insertions(+), 4 deletions(-)

-- 
2.52.0

