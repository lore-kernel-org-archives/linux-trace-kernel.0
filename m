Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEF02D47F4
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Jan 2026 07:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768547873; cv=none; b=YPSnNYW6lyZAk1R7qzk26WQHNPX2EiKe8iN9yPQqOENOhR79Y3qHQ0rbkIIx3jqL+syra9lJR2PJjzBQZyjPqAu5UiCcCsZ7Mifi7EOnKwZd8GK2lgh4qQCqRdBZ4uWXHrh6QLQRs5WR2pOZNSLApLQL0tlH6oLCvFuTCDRQIcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768547873; c=relaxed/simple;
	bh=Z93SUl7nMLrO2bqrwRew+vNiuicAAkaUil6fIQl8jh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ohoL31fk//bt1N/a88rNN3UEHKrJTVumdUu7FVr5dQz2gQ3XpG7kKteEF2GMAq/tm5hrZ99TE2QVRwK+KdI/2tM65Ire9m8JVmqqPpIgm/2bvU5ivO2CE6kNjuBvj0ZRJ6ET8jAlo9hFW7UhxgcTUxg/cayrkzXRnbfiWZX+EWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCDTJ2dR; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCDTJ2dR"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a09d981507so12150195ad.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Jan 2026 23:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768547872; x=1769152672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5xPODHYPomoRZ00DJDJzyRPo7BF3mCMV2J77rSXUqtQ=;
        b=LCDTJ2dRdfknhOnOt/FNB9AgS9TOoda6UYZM8z3GBAW4FB1fLlvbf+i94cBgZuHHlH
         JxXZIX8E4P1+x/WjWDOAH9IiKBcG6DUu4K2DawJiHZn7FRhg5E1c7Sm9/+KnbYSTIQwi
         wTxHztpOvUGttApLXTZDVZrnJlczCwd+MElm65CI9ChwiO100F7QUV8rycvwDEsO81FT
         dMBulDQPykgwXjxDHwfsn1KWJEQbUXLajhe+/xfhPQf5cAYYuKPJOsyIeiSMIt+IoQ4O
         HMTeT8WaTgpmikQsJtBGP5KxK7/4bvVj6yohv5Mt38qTb01aAE5saZld/S2kxeprYpMb
         aSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768547872; x=1769152672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xPODHYPomoRZ00DJDJzyRPo7BF3mCMV2J77rSXUqtQ=;
        b=K8ezQANf6z23Xwi6gqsGFjvcakimh7opqCrZ2MasqgcJ50ySxsk3jkQMCs1gYvtj2q
         kQk2KVb5V/6XeOF/RgLTC4qzV0l2cdftRjVN8KD0qgnnV5kWg/sb42ZaLWSevHrqeWeM
         4tZCBYF5YaQw4TMgBRymCvOkT0hS6FKSh7Uwu22Opso6aRBa04j/Apak+rcZJCKA3r8e
         LqQpGexZQ98dcgNFgVaZ9PlCiYx71meZwqTLoildi9AvpE3WutZcoNHPKY/qdLvmxuMd
         zzRxhzCjL3fqS1Vv5osMhPDHylzMBM+zV8eX4ZUSscmrRXHox2f8h0WbGurT+ikhhSul
         PKeA==
X-Forwarded-Encrypted: i=1; AJvYcCWbpfSQsgXQE1sWHZ9ToEJT/ZG7Dc2i6V7gDSgJHOtxRh+rg/gHPOYNGOITuhTFuUHoq+LCdmQWA14CYh1gu3DJ5a4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOEgFcbY2xLKo1sW5oR4fD1mubWqUVG0spcviI7WeuCGJXbrtY
	EHnHRqYKu9pnwlgmCkBc0zqs1UBNNSExVjbzu981Gkf16VZRVpKXQUjt
X-Gm-Gg: AY/fxX6r6yQ4o5jraUmWR3os/zByqsknRcrSeABQGAuKoeoXDcHoGj4/G5j8e2B/x11
	OZmNqcO7QL89iQZBwdVzmB2aLspESHjDGtgUZuFA7CniVIwXzYTwPUu4pzmSVo0saTzHprM/YGb
	aUMOqfPQmac7f0Ygyvx80lRr6dLuXM3+/PSmo1rjjChQlagAAJYKm4QHqMWHcUx0mbBCFUcGeqk
	IqyXT89/SX+llQezIZlvGh0bBLxi9QYR5RiVe3uXquvH0nTIlpWqxK0jyjko9SFokQLFxKlChtO
	4HsOCl2/Y8Gpq6fFF6xHGIgS2sAIQZ31ZLL3sNUzSasFcRaMJF0GVkKynZAmYLOdwh5YTVY6juX
	Eji2G5mtAEiRlJBhZMlrsILJtqGlbE5jY9M0wILBzOV4is+srJyE+YRJlpqpa2gvuajqMCyrqt3
	ztZTnkecW7uup9g0c5PQ==
X-Received: by 2002:a17:903:2f07:b0:2a0:eaf5:5cd8 with SMTP id d9443c01a7336-2a7009919c4mr48883165ad.9.1768547871787;
        Thu, 15 Jan 2026 23:17:51 -0800 (PST)
Received: from 7940hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ce2ebsm12508275ad.32.2026.01.15.23.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 23:17:51 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
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
Subject: [PATCH bpf-next v2 0/2] bpf: support bpf_get_func_arg() for BPF_TRACE_RAW_TP
Date: Fri, 16 Jan 2026 15:17:37 +0800
Message-ID: <20260116071739.121182-1-dongml2@chinatelecom.cn>
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

Changes v2 -> v1:
* for nr_args, skip first 'void *__data' argument in btf_trace_##name
  typedef
* check the result4 and result5 in the selftests
* v1: https://lore.kernel.org/bpf/20260116035024.98214-1-dongml2@chinatelecom.cn/

Menglong Dong (2):
  bpf: support bpf_get_func_arg() for BPF_TRACE_RAW_TP
  selftests/bpf: test bpf_get_func_arg() for tp_btf

 kernel/bpf/verifier.c                         | 36 +++++++++++++--
 kernel/trace/bpf_trace.c                      |  4 +-
 .../bpf/prog_tests/get_func_args_test.c       |  3 ++
 .../selftests/bpf/progs/get_func_args_test.c  | 45 +++++++++++++++++++
 .../bpf/test_kmods/bpf_testmod-events.h       | 10 +++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  4 ++
 6 files changed, 96 insertions(+), 6 deletions(-)

-- 
2.52.0

