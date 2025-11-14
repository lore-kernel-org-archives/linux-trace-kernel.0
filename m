Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873AD302CB6
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Nov 2025 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112301; cv=none; b=BNGvUfm6onMedAsU9/vf1adIx/cfziuKqNnuD+2mJpHKdxppMJkv0SKesh2w0EBFKRsLWjrPCOOXF6sgJNe02F6Bzo9h0VbtmMie/Xa2PD/oGi9ekgP/fzjt59ayRj4T878zGKvarWc0ccq4155rgGjHbkwiTuX0f4Gu1+EdEsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112301; c=relaxed/simple;
	bh=+9RQ5SYWcNd1cbzkAGMGzwz/84lSrZPPq5qPr6vkn4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O4LeIcHz4w6bF2c+2LrZqBGIsf/+yqEfTKveVfaCGpxjWrbn2HH7B5oSxl0CktI/RxBV6BgAwlFIITHXrsZXfh5YJJZokDFJr5pXuNMZDfHpvGBqJtfPy7g6dfDxBhwenKzKgEkfOAw1xddPrphCHZWxIUWXlw3LF9QUnYn65xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+my3Y+n; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+my3Y+n"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2958db8ae4fso17412475ad.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Nov 2025 01:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763112299; x=1763717099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j9SsUCl/7bEhicMcDwyeLe+NHqi3g02wXIdTa14uJ8Y=;
        b=W+my3Y+n5olYkTaDnXUuhnD01ZXhZqudCA+hZ53hbOf70wgTGCCsJeDlT4oIBp8d8J
         VXRbthXIjxV7QTs5zkKdtQBSAChYZVM8mfNmV94DfqxgQvuBGKBeCuzkNA8JhwYRpQYj
         +LQ9LIybK6KkIG7EMmWgSyaqapjX+5RJPthRe+dzno9S8eUoyNKNbtp9LzbbWRD3K7lm
         v9Bwrm7F+SyrUv7/5J4gun8mRzRJ2AENicnTI9J7znmaMmhbm9tC/ulp39z21N5Xage7
         nRzZsw/xt3aUqRvoH077FiFNFqgeLStdcfuIkkAQ9zq4oBau8uA5XpgkdR6XOQRe3g3n
         hE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763112299; x=1763717099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9SsUCl/7bEhicMcDwyeLe+NHqi3g02wXIdTa14uJ8Y=;
        b=BzsEOXXg3w/V+jK2vzfeUoL4Jrzxmn94dQU1FHmLM594cel9q0454wdbNexUp9Xs2o
         T90GI2LctzrunsfIEp4YDI/vhZWnpzPILNkYky62ZrKp3xIuFgA08b3VYlQJPbgUhKz4
         48Oc22XSx6dTKEp9gO98jMCUyOIw0/NIQR+OzfLa4ASBKWIC9ad4HwJtbYfGj53TfpQu
         6TyUgoPQgdvZ3o4wWDSb6ggP1aguGXnEtCJBywNq4l1L+yVoSYxhPEdkAXGEhdmfrbmh
         hOs0Z/rmimdamC7vA/Md79ewG/OlXqdZkaPZPmaA+NCMtMXK6hAS85619uLeeh4KbnJX
         20IQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs5qAubP7eNKMOdLA5Lk8nsJwar8Ya7oM44WmcaOT0JBu9WVVcT58E6DZ1OvnUvvqFAeUh7DwTHrw5r23OW0jelFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTCZfcdV779x6SIv2WAXU6tw5jj2iz5muHdiSLt4KFpeg6TJY5
	pAmqyrVOY8rn/hDFNF2fS4N29qiQHOI80zg9b6j3nuhAoX7ub8i5FKdQ
X-Gm-Gg: ASbGncviYo/uSws4GwZAD1eieh0kqb1Cqi5KEm59S4wgJAcH03Z0906+7cTH4ZfffOh
	j/T8Rrg2aWoX3Qwjot5tXBXqGgGubd8LV/w6DvnA2QY6JEzZKukm6SYpaFoTVlIR88F4t4Z+A1y
	iLNFiJs6EcuyaWA/+JbaudtW4PcUiNXHyCfzeQFGMESKUexgAdGzegU/XdauMpq5A+g6Ni3mEYc
	zEJc77LR8caBn0JbZ01zjtXwjkxx1w3Trqn4NWspPz5kI9UsNsXCIJtGzU+6FXj7VLmR5wx9zqR
	2UyHZx5DVk32WStQM8c/f5P3DWsIev2RGiV+efCYe8Egbzu+n8IiaTX+Kwo3yAbYefGY5uc3bGs
	pdzivRL9jcRXIGwWMZZ5Hfrg4b6pNWtjc6pjbdut0KJ2Q6aehaGjsVtx0I9e3bOicaa1Rd4TdqG
	hKFwpo19TwxTY=
X-Google-Smtp-Source: AGHT+IGGH96fiP4Mtc9aNQbmVe0Ea4kytDhImVoRCMVSUzVPcH6o18mB6xdLlzUY/ylcw8DGmsc9sQ==
X-Received: by 2002:a17:903:1b08:b0:295:20c5:5453 with SMTP id d9443c01a7336-2986a73b26bmr26556915ad.29.1763112298644;
        Fri, 14 Nov 2025 01:24:58 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2346dasm50451525ad.7.2025.11.14.01.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 01:24:58 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	rostedt@goodmis.org
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
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH RFC bpf-next 0/7] bpf trampoline support "jmp" mode
Date: Fri, 14 Nov 2025 17:24:43 +0800
Message-ID: <20251114092450.172024-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, the bpf trampoline is called by the "call" instruction. However,
it break the RSB and introduce extra overhead in x86_64 arch.

For example, we hook the function "foo" with fexit, the call and return
logic will be like this:
  call foo -> call trampoline -> call foo-body ->
  return foo-body -> return foo

As we can see above, there are 3 call, but 2 return, which break the RSB
balance. We can pseudo a "return" here, but it's not the best choice,
as it will still cause once RSB miss:
  call foo -> call trampoline -> call foo-body ->
  return foo-body -> return dummy -> return foo

The "return dummy" doesn't pair the "call trampoline", which can also
cause the RSB miss.

Therefore, we introduce the "jmp" mode for bpf trampoline, as advised by
Alexei in [1]. And the logic will become this:
  call foo -> jmp trampoline -> call foo-body ->
  return foo-body -> return foo

As we can see above, the RSB is totally balanced. After the modification,
the performance of fexit increases from 76M/s to 130M/s.

In this series, we introduce the FTRACE_OPS_FL_JMP for ftrace to make it
use the "jmp" instruction instead of "call".

And we introduce the bpf_arch_text_poke_type(), which is able to specify
both the current and new opcode.

Not sure if I should split the first 2 patches into a separate series and
send to the ftrace tree.

Link: https://lore.kernel.org/bpf/CAADnVQLX54sVi1oaHrkSiLqjJaJdm3TQjoVrgU-LZimK6iDcSA@mail.gmail.com/[1]
Menglong Dong (7):
  ftrace: introduce FTRACE_OPS_FL_JMP
  x86/ftrace: implement DYNAMIC_FTRACE_WITH_JMP
  bpf: fix the usage of BPF_TRAMP_F_SKIP_FRAME
  bpf,x86: adjust the "jmp" mode for bpf trampoline
  bpf: introduce bpf_arch_text_poke_type
  bpf,x86: implement bpf_arch_text_poke_type for x86_64
  bpf: implement "jmp" mode for trampoline

 arch/riscv/net/bpf_jit_comp64.c |  2 +-
 arch/x86/Kconfig                |  1 +
 arch/x86/kernel/ftrace.c        |  7 ++++-
 arch/x86/kernel/ftrace_64.S     | 12 +++++++-
 arch/x86/net/bpf_jit_comp.c     | 45 ++++++++++++++++++++--------
 include/linux/bpf.h             | 22 ++++++++++++++
 include/linux/ftrace.h          | 48 +++++++++++++++++++++++++++++
 kernel/bpf/core.c               | 10 +++++++
 kernel/bpf/trampoline.c         | 53 +++++++++++++++++++++++++++------
 kernel/trace/Kconfig            | 12 ++++++++
 kernel/trace/ftrace.c           |  9 +++++-
 11 files changed, 195 insertions(+), 26 deletions(-)

-- 
2.51.2

