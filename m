Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECAE22652D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 18 Dec 2025 13:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766063238; cv=none; b=FWSYNswefqbyYqHyxnBJEnBQv/5NE7DI3s6Y/nBc/04HHvOFFhe4WWICuh/7WKPB7TK3mmqtCuG80dSSMiMXIiawagmPnyI1byrnNLiBfbBymksRWYhynDt1Zj+s2Tvma+6VmQ4Vlb85Rx7E5kcySgWNOkQPJbV7Z0JX7p7Wbyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766063238; c=relaxed/simple;
	bh=TZ+mg3/PgNq4Be8wX9hZpd+y0t9hHYR5vNxg2s6h5wg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RxpyKQMA/kyVDx9dEuqpgVuVd2f7fDYTbbq7f9dM381FJz1KK6PEgjD86qodvlgucQfIUfTs565WfZMTtT0yDq2r2hZXOgN+nlAYpdN1YZKrfpCQ/KoH+6t74zDzmKAxKgxVsiRq4rCtf5Ay9nAGPtjSu7zSH1Uleui3qfIP0P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdoW809W; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdoW809W"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a0ac29fca1so5520195ad.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 18 Dec 2025 05:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766063236; x=1766668036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o6MDSoNjVj8xGwzF3ZHeVHcF1K0gBl7qfRmDmp9Suac=;
        b=OdoW809WGjlI1Pf+KbvxZQo7VctMVdoyKGbUWZ4TqGSsUywHw7Yk4joH/DLbQlzDCT
         95NkSq5ASpr5Fyydj+9U3CqNEhlWFQZGpJRHAMoi7eh1p0KH+MGHABVNIwcHibFPgqNU
         cXF8khAiQSze0Fx54Vp3/2/yZxQDyqzyvOGTUn6BbheWIlX6FMTIJ0UfjyXyr05BzHuF
         QoiTQKIp8qIbiuHIVj7KoTWnCKSPjxYPU8oR1W9EEjnpqvYkserwLZU4dlYIvXyVkbNv
         GshfijHgdBUwrCkHATYH8wqs6bcGhHzTlUUvFdcRfwxWKhVQ56HESJH3ByNQiy6DH10v
         /bsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766063236; x=1766668036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6MDSoNjVj8xGwzF3ZHeVHcF1K0gBl7qfRmDmp9Suac=;
        b=bOqNRMm6/MJoontcU4YVoXrcFFBONFLSdBd80IKIUZp8dZ3MEv2Oki16if22DCQkxH
         SamJFjJJyqQT5TrThyHifuhenf1+UCCGQsmoN0kN/8zkHSyzIGgGE4u49e+sICyH5kO4
         0LtSUj/eEqqPqKlbS1K+cOkxoMfY9S0MeEW/lTB9GTi9jm/kSKZcFJgt9BXcxF3BI3xv
         +2050ICO7catYpq6/RQbztJkcMaR3OVbmBSY4tsUoIqeiZlfoRGwm3lKGpoArGABi2/6
         djBYE4NTZuvaRkBGSSuI2q66bj6+RdHCbFuVDcP4tNIhZUy8F7trwrqmjXtEuzuCCCNO
         QHvw==
X-Forwarded-Encrypted: i=1; AJvYcCWvBqhsBQB2Jjl7fBbA4fE0xe8rqAKl9UT+vQmYAdgLtJAoZYiSZXhj6uX8C+4svsfhgHBnqF99O/2oD9ZxeW2QPHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKHuSn4Msr5Bc/xm/ZanQUAposFs8i0PisCRX3agE5OjVSV2+L
	t4PQRbRgndX2kTK5TU78kaKZ8eI8oMKyTMgnGy5pnFecQk93vK028xHN
X-Gm-Gg: AY/fxX5miaEi4McivRBOtgHYAWd7nhKP8QDDXTfS1eaLyZCi88Lak53Q2WiQ0earYLJ
	FTWYnLP+AsKoQEB56RMSQtlptDAX/iyHWz6pVep+NnUsod1oJrXomjoJovY0uUHWjkxRG6GGOg8
	O5tTmdhGSfgmgYFwqFqt9RXip14Q3B8skTPinVaxXdmVyy+Y0qc0W+oxx21oziA/qbsdUT6Kjxp
	TbGO4BEsnpw4BIvwHKmcBwn/OeRpaXPi2VItRKPQb/tz0qu34C0vade+eR19xv7RA24xrLPpsaD
	FdiCQRwmcZmsZkr08k5ame19htAwULL1zw7cEeODP26j3VD8hz2JrzsbXSPFEIssHsLYHIuiyib
	/LXNoAd+jLJsYw5zmjJjIA7O1I5pC/7bc92WrwTN3ModNXm/JVS9QWux5MkTU3J+NUAs6ggfq03
	tFIU2M6KNHNYE0h3qfnf0Ek9ViL33dEJa+FjM=
X-Google-Smtp-Source: AGHT+IHvO+1PD8RrEUebpSGTyKqxjCqg0KVzQG9kyzDrg3ZQ6OBh/WipWLO57nrDhnRsudiWhSkS4g==
X-Received: by 2002:a17:903:1986:b0:295:738f:73fe with SMTP id d9443c01a7336-29f23c7d087mr202108065ad.30.1766063236135;
        Thu, 18 Dec 2025 05:07:16 -0800 (PST)
Received: from mi-ThinkStation-K.mioffice.cn ([43.224.245.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d1926cd2sm25539905ad.77.2025.12.18.05.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 05:07:15 -0800 (PST)
From: liujing40 <liujing.root@gmail.com>
X-Google-Original-From: liujing40 <liujing40@xiaomi.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	mhiramat@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	liujing40@xiaomi.com
Subject: [PATCH 0/2] bpf: Add kretprobe fallback for kprobe multi link
Date: Thu, 18 Dec 2025 21:06:27 +0800
Message-Id: <20251218130629.365398-1-liujing40@xiaomi.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch provides a fallback implementation of kprobe multi link
using the traditional kretprobe API When fprobe is not available.
This ensures compatibility with older kernels or platforms where
fprobe support is not compiled in.

Uses kretprobe's entry_handler and handler callbacks to simulate
fprobe's entry/exit functionality.The API remains identical to
fprobe-based implementation, allowing userspace tools to work
transparently with either backend. Cookie support, both entry
and return probes, and session handling are fully supported.

Jing Liu (2):
  bpf: Prepare for kprobe multi link fallback patch
  bpf: Implement kretprobe fallback for kprobe multi link

 kernel/trace/bpf_trace.c | 603 ++++++++++++++++++++++++++++-----------
 1 file changed, 443 insertions(+), 160 deletions(-)

-- 
2.25.1

