Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A467C3164D8
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Jan 2026 12:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767788543; cv=none; b=iQ2vWHj++IY6/AukCpkPNzjgbsJLmh1kYOYt5UNCQ7X8RDizxSVsVfyk+SzF+oNMpx/QDLvlQOQZMQkNb0bTXinYMi+VqskujfeHKkv/t6TV1J5jpnFZKQAZwonAe1KZmQjgbXs/BQopLrNZ+HS9md2UTtJJopOlZALO8nfh8Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767788543; c=relaxed/simple;
	bh=im6+FmUa4bUrtYoqyvdPdobyaHlhncXg5H7WqmB2EoQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=etLeZj9lPXVPYJX2PoEHV/S+C3lntgN4FJ0dbDnjtLkW+g37t8yUASo60XsMgCSKfcf06os+urVfDblbdyoUIipufdZR8YTY+Uxoc3Dc+a2HN4bIKAGrdhvNAGoZDO2FkgCBH3Q3Og6knO1O8OQhmaCk5AhcfAnxMYCPctL9Ppw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCUjThau; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCUjThau"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a0d06ffa2aso16485995ad.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 07 Jan 2026 04:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767788541; x=1768393341; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SGrLo1T/GXWCd4yT4qDDB4M00lQE1SksrWNKQr8UGaA=;
        b=gCUjThauMASaq0N5h1HZH5drWl7/mU3lrlDzES6q1vrBU/vnE7GcOTbfGE+SGGNifJ
         y3VAMG5lGJzROmxmhKDWUDUDNgRliHGNlqDkk2HaL6UPEof5AKbJrBkhEKxx3WCJCOPa
         9W9B6D2FDLdUHzaTI2pBtqpbsh83ZLN4xFJK0HZtUsq2QXGXH9i1/fdgpqoXkoVYZ9fB
         IXR0o2JH2fKVmVDyxqIhHyDe55IReIUJmAx4uN6J+RyedkgSAfNo9gV5JKLmX3bhr776
         2X94+V2m3uhJQfIdVHjUhVIj3IXs1BsjArEIXXPcYW3L8oH6zysw0FxOJRdWOznVH48c
         DW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767788541; x=1768393341;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGrLo1T/GXWCd4yT4qDDB4M00lQE1SksrWNKQr8UGaA=;
        b=J8G/7R2/ljY9ZkNy1hdlD29qLgHC2n5FzE2lnu/r72/ZkUtb5chzDFi/GycYR+5z08
         Ux3N9asbATeBH0Ur8DigeK0P3T3K1xJiA2Ry7MqjB48AItUgygTKjZnlFQ6l+4vLj2ts
         TxKigIl8raoP8qTec3zrwB4HqHUmqL+lGi9vhjcgAPHnC0EjA/vDy15+Qlqfp/nTeq+F
         j7e8vMOOQVDcHhouqkcmoz35oCxHZONmhMf0S+5w5vjbrGMowLlTeXDoTtnnN8zSUNhl
         keyEymIu4JbNPmgO+grtGuHcy1kBjyn/mAAOYXPcOKc1ruppaTlIn5ZGFe7WGft5U0J1
         oSIQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2zEBAye2ZkrCaViAazfcv14mvfwWqTeNgfNG+KSKU3eFbAcrdjKFxeoifBqTw3EQj7h924PAOHw00bNr4fZ92ZnA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4HiFPpS8jqz6GZIUvCJPkD8nPBrXW0PwjobVXYTJqpUmNL8db
	vuqOQ4RM0vKli1yDIA3cySSOkVdo9T6nSNj7BGyPbZTescv+PdCVcHhK
X-Gm-Gg: AY/fxX7aNxhCoC/onA5cCm1/nPDRsldqOVzb5N0k7EIVhxwVYjJ7VIUYd0HLWgo9+ka
	zUNls0texHHJsxsoCjD+iv8ftM/nlIIXXAynwu0UQIHvcydP5R0xgxobFayUMiPQW3j+ubyKP4l
	6Rrlt9D4d2vIs6OWh6a2APh+PBIwOP2B9xo5L7xmpBfj+6UGkjCcx9Nty8GwySm4SpZcKcFhy45
	qNNVNQl1btZwHxSLFRI/2F8HMEJhi7owTx1qHLTa2O8axflEtFkO1S8DyEMHx0Jq53lAYKvSs0L
	mcsWE0P23Iye/bx5xS3Jm1KbHS/2Yq4IGpfq6QP2eRz8BD50XH6t+qcEsZipeGQ/fbGzAb+f/s6
	qX/lLT60LlEeVzS/xz3C00YnCkDqO/qTkNpDU1nnRBk76hfRFBGPvMSXBW9XByez2rcmUeSRvv0
	lfi65d3ydS/zU=
X-Google-Smtp-Source: AGHT+IFRchTfsduoJn0oX6m0fWHXyRosMYVgZHpA1UJaa4M9jq2wiA3YsmjcaDKgVMcgaLKr+eTvyw==
X-Received: by 2002:a17:902:cece:b0:298:2afa:796d with SMTP id d9443c01a7336-2a3ee4c432bmr20560315ad.61.1767788540464;
        Wed, 07 Jan 2026 04:22:20 -0800 (PST)
Received: from [127.0.0.1] ([188.253.121.153])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f8b1526sm5025946a91.14.2026.01.07.04.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 04:22:20 -0800 (PST)
From: Zesen Liu <ftyghome@gmail.com>
Subject: [PATCH bpf 0/2] bpf: Fix memory access flags in helper prototypes
Date: Wed, 07 Jan 2026 20:21:37 +0800
Message-Id: <20260107-helper_proto-v1-0-e387e08271cc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANFPXmkC/22NwQ6CMBBEf4Xs2Zp2haKe/A9DDJQtbAK0aQnRE
 P7dyskDx5nJe7NCpMAU4Z6tEGjhyG5KQZ0yMH09dSS4TRlQYqEQpehp8BRePrjZCdto0rm6Yq5
 LSIgPZPm9657QeAtVKnuOswuf/WJR+3RsW5SQIrWaZHvLEdtHN9Y8nI0bf/IEaalkeQQpWxd4s
 cbYf6jatu0LDlaxAeIAAAA=
X-Change-ID: 20251220-helper_proto-fb6e64182467
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Shuran Liu <electronlsr@gmail.com>, Peili Gao <gplhust955@gmail.com>, 
 Haoran Ni <haoran.ni.cs@gmail.com>, Zesen Liu <ftyghome@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2113; i=ftyghome@gmail.com;
 h=from:subject:message-id; bh=im6+FmUa4bUrtYoqyvdPdobyaHlhncXg5H7WqmB2EoQ=;
 b=owGbwMvMwCXWI1/u+8bXqJ3xtFoSQ2ac/+eQ+OhzsvkdJ+oKCppF4/PlwgI1hFmXTEuq6a5M/
 7L33OOOUhYGMS4GWTFFlt4fhndXZpobb7NZcBBmDisTyBAGLk4BmEhoPyPDhvalsXW6SoV+8oks
 bY72h/oXecpbv5/FtmRR2P5gnZ3XGRmmXPfYNCHcc++RJersW/6vVm4sO77s+9yei48kPyzinar
 JDQA=
X-Developer-Key: i=ftyghome@gmail.com; a=openpgp;
 fpr=8DF831DDA9693733B63CA0C18C1F774DEC4D3287

Hi,

This series adds missing memory access flags (MEM_RDONLY or MEM_WRITE) to
several bpf helper function prototypes that use ARG_PTR_TO_MEM but lack the
correct flag. It also adds a new check in verifier to ensure the flag is
specified.

Missing memory access flags in helper prototypes can lead to critical
correctness issues when the verifier tries to perform code optimization.
After commit 37cce22dbd51 ("bpf: verifier: Refactor helper access type
tracking"), the verifier relies on the memory access flags, rather than
treating all arguments in helper functions as potentially modifying the
pointed-to memory.

Using ARG_PTR_TO_MEM alone without flags does not make sense because:

- If the helper does not change the argument, missing MEM_RDONLY causes the
   verifier to incorrectly reject a read-only buffer.
- If the helper does change the argument, missing MEM_WRITE causes the
   verifier to incorrectly assume the memory is unchanged, leading to
   errors in code optimization.

We have already seen several reports regarding this:

- commit ac44dcc788b9 ("bpf: Fix verifier assumptions of bpf_d_path's
   output buffer") adds MEM_WRITE to bpf_d_path;
- commit 2eb7648558a7 ("bpf: Specify access type of bpf_sysctl_get_name
   args") adds MEM_WRITE to bpf_sysctl_get_name.

This series looks through all prototypes in the kernel and completes the
flags. It also adds a new check (check_func_proto) in
verifier.c to statically restrict ARG_PTR_TO_MEM from appearing without
memory access flags. 

Thanks,

Zesen Liu

---
Zesen Liu (2):
      bpf: Fix memory access flags in helper prototypes
      bpf: Require ARG_PTR_TO_MEM with memory flag

 kernel/bpf/helpers.c     |  2 +-
 kernel/bpf/syscall.c     |  2 +-
 kernel/bpf/verifier.c    | 17 +++++++++++++++++
 kernel/trace/bpf_trace.c |  6 +++---
 net/core/filter.c        |  8 ++++----
 5 files changed, 26 insertions(+), 9 deletions(-)
---
base-commit: ab86d0bf01f6d0e37fd67761bb62918321b64efc
change-id: 20251220-helper_proto-fb6e64182467

Best regards,
-- 
Zesen Liu <ftyghome@gmail.com>

