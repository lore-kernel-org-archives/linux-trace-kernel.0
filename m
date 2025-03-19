Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7CF25761
	for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Mar 2025 00:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742344741; cv=none; b=ALXMh3H3T+aJHeFF6PM8hxR2XRfa03OLcFCcINL77RXAsrtXPUG7MjtW5b0PypbZ6LNKV7SYpDMJszCXvBAlyrTxEKk+40EP18gREQ3c5iyUp2eT5go0fPEwC7FJ2nnLC5Q1XHf2GYarFTxA8djGzscZWVaR0wVLxlmTurEwVsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742344741; c=relaxed/simple;
	bh=9YtCGrT1TuziOH3DDST8Z7oX0GEI1Z6jgZhkeTJNXXY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=B8dGQ4iZ7RGWEO5Ewn4WFVR+mNQYN7ilnrbGsbZKR/EwBmqoYCNeHiYLppYMYO1s/K15Vya4QdHI8LS5PcaDlopQrqFXVX8PdXevNnqNh22ULN9FzR54CzWhUORj6hv/M/VIuEHW2OW1SnMaaBymNZk7PYVvhJDXwcEd1pyytWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ZOQDwVzH; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ZOQDwVzH"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22398e09e39so134830455ad.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Mar 2025 17:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742344738; x=1742949538; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i6AMsqHhYAmFWD0QVOxOen+/UORp2DmAIgel+4FhOyE=;
        b=ZOQDwVzHIhRWyF3BDpnkvMWDMZstVCE2Ow6jJo8AcRfUTY+E18F6eTVzN6mp429GPJ
         UZ+/BUgFIrXTWzam8VaTUA+b5MlJ3aGupuwiJfyRlZnuCUsQwvgEFOyfa6iNu1SgLbUb
         m2ylhGAeC3BZ8UTU2R0F2YEcNGoREn/+Gaf3Ej67cIahysuzb0jfKqZQd5Nk49yoE/rh
         zlotgC0KPhyYBpBXv4abSU/HSbV3kRROuMhK1GEbD0gSFkFnigdxsPjAEzOlX/xis3r2
         hLYvOhkONo4EFMbkfzdXM9hKAfSsAOa/f2TPhlTHBYgUBbtEDncb3nGm6j3mUo5sB63m
         +krg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742344738; x=1742949538;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i6AMsqHhYAmFWD0QVOxOen+/UORp2DmAIgel+4FhOyE=;
        b=fz4JVUmuw+hbJ5jisoxuAxWhf3cO8WIqG+y9xFRG2x9tNGXcJQn5iSZw6zU9mrb7Nr
         Zved/N7HtAgFPE4TyvsOxVjICULUsZtLPHH706R22hGpskMq3Hjj/JXku/P7Bos0n4gd
         LI35x6QlWDeuG0uebptJjafNsScjYhdWztR9FLO8F0btuJWAahZLR6JqyHmKR1PaGfnV
         rt4TjlS4s8A9vx2jBpMaFAR0mjXxEwLXQW7QoPtmZd2h84JI/T0quDJ7Q0kimTu+9tfL
         zTXNucbwYau2ECmML84cazLP6Bnxrl1w5Q65ZMmFKl/wtleTKA81h3NxZvv2Hvq8Y1jf
         pdXw==
X-Forwarded-Encrypted: i=1; AJvYcCU1xkDXE/9y9WnwOJXINeNmfWJHDZbdXu5oLnHTUhU7Pz/5cv1oMGOCpN7RlxlAsuBRskKQdmdBDd+7q/CQb8szTRM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi8Z8+xIs3gt1juDTkp8o46psjPWv0+LafHC26bU2nq5dHlO3L
	7+6xU6RL/t7N4fAD6hD+B+qIbAdK5vcmzBLh+QOg+anBrUISISeCKA0tO2I0ATI=
X-Gm-Gg: ASbGncvx+PMFh+jUy8eFMrV3ioXd1z9A91vVx3GO/w2TUDq3mzXtAHyG+x0sWteP9nX
	pE/g20oDbdOcTlkwjaRhokDQTQRSPukoRwoDlJncZ1p+Tg1Ed+d3AQgbDyvVRJhufgULeeXPQwa
	DFNAkz2zbpsBeW6fYxpwWzhYCoqtmky46+2KgNz3uXvh0FSl/FhNeAkPrxbDEeu2NDZWf+DSnXA
	L2w69Adg1OKsDd+9GVXrmeNNgtlBQ7sxGOrojG7ZRHO+v606wyB//74Nyk9xmxrDvWRHvAz/4uK
	niQOUd7AsO9hBBZHHilNIsaCAwhvajzdxvMsftGm9C1uhHn4THqaOifOKOUA
X-Google-Smtp-Source: AGHT+IEguwL4nKeiu40OBWdp9bVI5fB94ky3nWTc4cxopHEMtTnwIt5J6WclaQ8EVg0q2woZ7jkP6g==
X-Received: by 2002:a17:902:e5c9:b0:21a:8300:b9d5 with SMTP id d9443c01a7336-226499282admr9214455ad.23.1742344737996;
        Tue, 18 Mar 2025 17:38:57 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbe890sm100843415ad.188.2025.03.18.17.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:38:56 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v9 0/2] riscv: Add runtime constant support
Date: Tue, 18 Mar 2025 17:38:44 -0700
Message-Id: <20250318-runtime_const_riscv-v9-0-ddd3534d3e8e@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABQS2mcC/43Q3UrEMBAF4FdZcm0lM5Nfr3wPkSVNEzcX20pSg
 7L03c0uyBaJ4OUZmG+Gc2El5BQKezpcWA41lbTMLdiHA/MnN7+FIU0tM+QoOSAN+WNe0zkc/TK
 X9ZhT8XVQfjJShIAGNGub7znE9HlTX15bPqWyLvnrdqTCdfrj6a5XYYBBWzlypOCQj8851aWk2
 T/65cyuZMV/MNgYK13QPlrtyHYY2jOmz1BjACyiNTbgRB1G7BjifUY0pm0rL2DUo/UdRt4Z5P2
 uq2zM6BVoUo7aTx1G7RjAPqMaQyFyEGok6Fas98wf3ejGBEGgFYHUMXYYc2eIyz5jGhOdUpGEM
 pP73c22bd8pY7PBqgIAAA==
X-Change-ID: 20250123-runtime_const_riscv-6cd854ee2817
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, 
 Pasha Bouzarjomehri <pasha@rivosinc.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Peter Zijlstra <peterz@infradead.org>, 
 Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3163; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=9YtCGrT1TuziOH3DDST8Z7oX0GEI1Z6jgZhkeTJNXXY=;
 b=owGbwMvMwCXWx5hUnlvL8Y3xtFoSQ/otIck4sdvvpDU/ddikSIuashTHuc1m1T3CtuvR/9zy+
 I3p+dM6SlkYxLgYZMUUWXiuNTC33tEvOypaNgFmDisTyBAGLk4BmIjUUkaGu9sftSRvmVDN+1pM
 62ZC692dHcYqu+c8/s57/+WExyfO6DAyHFq/yUksnT9p1j3uU69ZxbQPLLllb5XT1aEmonTkKt8
 hbgA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Ard brought this to my attention in this patch [1].

I benchmarked this patch on the Nezha D1 (which does not contain Zba or
Zbkb so it uses the default algorithm) by navigating through a large
directory structure. I created a 1000-deep directory structure and then
cd and ls through it. With this patch there was a 0.57% performance
improvement.

[1] https://lore.kernel.org/lkml/CAMj1kXE4DJnwFejNWQu784GvyJO=aGNrzuLjSxiowX_e7nW8QA@mail.gmail.com/

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v9:
- Fix bug where stale register data may be used when an lui is replaced
  with a nop. In the following addiw, add to register x0 instead of the
  stale register to resolve.
- Add locks for text_mutex before using patch_insn_write()
- Link to v8: https://lore.kernel.org/r/20250305-runtime_const_riscv-v8-1-fa66f3468dac@rivosinc.com

Changes in v8:
- Rebase to linux v6.14-rc5
- Link to v7: https://lore.kernel.org/r/20250218-runtime_const_riscv-v7-1-e431763157ff@rivosinc.com

Changes in v7:
- Added benchmarking info
- Added CONFIG_RISCV_ISA_ZBA and CONFIG_RISCV_ISA_ZBKB to check that the
  compiler supports the extensions.
- Link to v6: https://lore.kernel.org/r/20250212-runtime_const_riscv-v6-1-3ef0146b310b@rivosinc.com

Changes in v6:
- .option arch only became officially supported by clang in version 17.
  Add a config to check that and guard the alternatives uses .option
  arch.
- Link to v5: https://lore.kernel.org/r/20250203-runtime_const_riscv-v5-1-bc61736a3229@rivosinc.com

Changes in v5:
- Split instructions into 16-bit parcels to avoid alignment (Emil)
- Link to v4: https://lore.kernel.org/r/20250130-runtime_const_riscv-v4-1-2d36c41b7b9c@rivosinc.com

Changes in v4:
- Add newlines after riscv32 assembler directives
- Align instructions along 32-bit boundary (Emil)
- Link to v3: https://lore.kernel.org/r/20250128-runtime_const_riscv-v3-1-11922989e2d3@rivosinc.com

Changes in v3:
- Leverage "pack" instruction for runtime_const_ptr() to reduce hot path
  by 3 instructions if Zbkb is supported. Suggested by Pasha Bouzarjomehri (pasha@rivosinc.com)
- Link to v2: https://lore.kernel.org/r/20250127-runtime_const_riscv-v2-1-95ae7cf97a39@rivosinc.com

Changes in v2:
- Treat instructions as __le32 and do proper conversions (Ben)
- Link to v1: https://lore.kernel.org/r/20250127-runtime_const_riscv-v1-1-795b023ea20b@rivosinc.com

---
Charlie Jenkins (2):
      riscv: Move nop definition to insn-def.h
      riscv: Add runtime constant support

 arch/riscv/Kconfig                     |  22 +++
 arch/riscv/include/asm/asm.h           |   1 +
 arch/riscv/include/asm/ftrace.h        |   1 -
 arch/riscv/include/asm/insn-def.h      |   2 +
 arch/riscv/include/asm/runtime-const.h | 265 +++++++++++++++++++++++++++++++++
 arch/riscv/kernel/ftrace.c             |   6 +-
 arch/riscv/kernel/jump_label.c         |   4 +-
 arch/riscv/kernel/vmlinux.lds.S        |   3 +
 8 files changed, 298 insertions(+), 6 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250123-runtime_const_riscv-6cd854ee2817
-- 
- Charlie

