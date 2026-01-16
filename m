Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FDF29A1
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Jan 2026 03:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768535436; cv=none; b=j1DpquK+Glqa6MOFf8pAmz6MHA22dla3Qlh4WeTbK4YgizOakBZwaRs7ZT3VwPDtwbU1oekCeXjBQu544kSowawolMHo8VV4EmywI4UN/EXNvvGpG3vwJF3ZkC8I5lmSVbzqMbkTyYsDh3glXOrdYjT2AG5d4r7JETv2vFiA4es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768535436; c=relaxed/simple;
	bh=W5vHBekSY53Vj7NOebsIaB44z4J+hbyazQnXmcWOrXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TxaqwIiZO1xQRG9ZLWej2PeKNlK3mPdzEIcFeNwePZ4wicrOUsocc/8OUBMd8Nd/83sAUwc8E4TAuLJuE4rIBCNZuyixYelG/4BxMwmIOe9TtTMO1t1p8uNhn1jGRMXgz/ygc0GRnh7kaBJ5hfNW5uxjxiI4D9WlWuUdvL7bxpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+bXTpyK; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+bXTpyK"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-81f46b5e2ccso943451b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Jan 2026 19:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768535435; x=1769140235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I4Nw1xHIHRTPBZ6KLjZI9nX2i+deS8eDOs2dsUOkwu0=;
        b=H+bXTpyKC+a0lHXxHs0bDv6NOkgPGAhlB1njlc76p7Z4fonjj/E4FvtY3Ow1HgsqGm
         yfpAHfr6QphQg7E8Ie61hnv6oMO3OOhI0qWY0+LKs051ry+xpwCEw6nYl26hSAOhOKwH
         GvtQQXCSMbOQ55+toZYCXaQbkxCk38t3q2I/dW5TzoxUQhoCTS4efWkbe/kPqk7Ne+RQ
         x+wpWTu0dySyJHfHAEnktVBD6VMxjPWGJNQcSM61nODCUkFOKx6KPJqQrfItadVygw9p
         3SJ1gVbp4VZ0m3yu1tayhcvgzmVJK4odfKkYHhQuw3zygLjTHbmC0QxRrmPbpaEEKtI1
         ByzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768535435; x=1769140235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4Nw1xHIHRTPBZ6KLjZI9nX2i+deS8eDOs2dsUOkwu0=;
        b=Rfp3zWhZk5HxFMGHZKDcYfrzyvO+r6rJtNQ8DMgkBc/Ql9dZ5lrGncOrgxSLm06xvo
         m7jre0eU7oY7vCthfT+Dtid1bwAioNoZjmOTTnRMGX3fsZe6bNscHLWjiDVja+wRWK3H
         jPN7Bnm3Oa4v1/VZNjzhzz/NBavR99u20nUB5oqyRLdigSwP+/xOYOTz7IvuBX0CPE0j
         upxsh01XLu3Ng5KBY3/XiBa3xJv76JKysHibZAwKp7B89au1bnkbELlyP2jN/JIelSYr
         oK5QcW8hygkbNp6m2shC1YP5++aLBhnSNhN9SoZdWLvf0m8iBek8J/VRH+GZ4IlmbPFh
         l9ug==
X-Forwarded-Encrypted: i=1; AJvYcCXJE02vDJ91C2OqCYMqVZO5xF3GTqaTYdB7ZrKcUzyWmkoJve+eobYCq25yMasbHo8c04miKFGjIrgO+vlrB05NmZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YymZjxeYArspbNC4a4krdka3MeZOOzb+TBcDf8WUwXSSno3Md09
	bRlC/h27FolL73ZFK1Qw7uye9RlsltuCzKAjtZEN0xUfwsfW3JqNdKfz
X-Gm-Gg: AY/fxX74RH+iGhwZXoQ6r9KFK0f/xMDnA0meUxSHl6a2bLj3RiFIj69H0K0Tgn1ZxV5
	+styB7AOFGBM8ZeOy8h3y2l/3iELx4iRheXxhZ18VaAifaltA9j4vUY6SchbHo62S1zwONcAgQe
	01ZmxUqgE5pAsqi2R4aH4T3G5ejBK0cTEMzmG9cDCrax+VkKVD4f0VDVxFeiNR3HqETgRi6arEN
	t70dCMgofqjMDg7CYYfr++0Wk7YUFCc0xeyf4wTEG9c3EjsWA+HBNJfEuz7y+wF2G4b0m1X0WWl
	JqZ3sQR6zMjmkd/OI/VajR8Y5v1ioFwWiBKzQU9rclsN/3QUa9E3yS32CaI+C7NPHl8BydCMvvf
	sDBwyRGaBRW85g1ucFDHvc/qux5S3FXjHmLsW6QtYzaSnoCRKxOjO052CfKretoDpRbC1nEzODf
	pnC5mbaww=
X-Received: by 2002:a05:6a21:683:b0:38d:e676:6da4 with SMTP id adf61e73a8af0-38dfe5bedf6mr1791438637.11.1768535434866;
        Thu, 15 Jan 2026 19:50:34 -0800 (PST)
Received: from 7940hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf37c9d7sm684504a12.35.2026.01.15.19.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 19:50:34 -0800 (PST)
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
Subject: [PATCH bpf-next 0/2] bpf: support bpf_get_func_arg() for BPF_TRACE_RAW_TP
Date: Fri, 16 Jan 2026 11:50:22 +0800
Message-ID: <20260116035024.98214-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support bpf_get_func_arg() for BPF_TRACE_RAW_TP by getting the function
argument count from tracepoint prototype during verifier inline.

Menglong Dong (2):
  bpf: support bpf_get_func_arg() for BPF_TRACE_RAW_TP
  selftests/bpf: test bpf_get_func_arg() for tp_btf

 kernel/bpf/verifier.c                         | 28 ++++++++++--
 kernel/trace/bpf_trace.c                      |  4 +-
 .../bpf/prog_tests/get_func_args_test.c       |  1 +
 .../selftests/bpf/progs/get_func_args_test.c  | 44 +++++++++++++++++++
 .../bpf/test_kmods/bpf_testmod-events.h       | 10 +++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  4 ++
 6 files changed, 85 insertions(+), 6 deletions(-)

-- 
2.52.0

