Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDB51B425E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Dec 2024 15:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733844033; cv=none; b=BYrVB6i3rBcLNSBymLEsJZ4vu7iiRC09QKv8LCkTzKOHPgRdGr+DGuLmypMPMtnARNGsUk3XNwkMRT5Iq3VmJO2XWbJ4Fsxxmzlc89gdr2awVhOquNZeEbnATNQQcltnEEGyz2MavhzzsEtb/oT7TBtpSrasBRPAxii7ciydt74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733844033; c=relaxed/simple;
	bh=qOI5Q+ys8kSBBKzvi24USbJLsDSR8GifUW9Hdx8k6fg=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mx9/p6ruoXILDUPM7wDM8Fhm2oNLBXXJHWkBKrRz1Rkkr7cMwZmVhedTvvrUaV5KNqBlqYMtgABOZ5L7P0OwgPh2kMuQGeHMkPZ0cGJx94aNeeqWWN6Gv3gI/vPOaA8mgzP44EYVHDA9LiY/bwoxvzZXsUrf+vCCUAK+jcBmVwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kKvS0qUl; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kKvS0qUl"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434a742481aso51238995e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Dec 2024 07:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733844029; x=1734448829; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WUBSukenJDirnMHi3gGCZN8RVYaRDYoJnZeOKJRWlno=;
        b=kKvS0qUlR++XqbyUTn9wR+wahPP/QHv/20vJG9J5UthwDfJtnktShW6N+29LDJ3AEL
         FG7JvLAOPeKGK1GjgXNzlH07T99nXeRKn+mJBdX5KKJtV7mBUhtUh0hhudMey4vH2EN3
         wfpfwqN1+lPgeMrG/0nB0AogkSuYuk/R+dgc78iiUKBrnSh78oRTD/FYajSRiMa3DVkM
         Mwn/lE79R+4vTHNSUNbJFsTBuXAde3aRS8vpcgP0Yef/OxasYt6VhNm22oamwZi4ytKM
         1cfR1bXpJxqxAiePNjSGrErGFxOiTYZtZs4FJiPdrddapgKzKCuIZ9QZRXttTYYU1+I2
         r26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733844029; x=1734448829;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WUBSukenJDirnMHi3gGCZN8RVYaRDYoJnZeOKJRWlno=;
        b=bILnBdsr7IC1Ovcc1r49e5ncB8w3em9p01RhtZNpgXwUYkC8oDid860qDTsp+m2wW3
         BmBcZsLp2qjTm2LJi/iL1cqqQyqfSK5QucszN2FodxD9HnvKApM8H48s+ixMD2/ysjJ5
         cKqvmzjK2GEm98f6kOtKxK4Yf8/AaJvGUkU+77QZoElX6LCl0fXRmsCdmEfmTrw+lZ3e
         aoB7Qz4cwpe9uDJavhzzij9mRSBJRHyGShrwnSQhP8P0LA3sZzLU5NXBB9DgGuGYGLp7
         6SE8SbkmIHC3ihcmcixAlFnrdWeAg3KVb5DNmtMz1Bte09cMNePqQGO7j1J+j2ye7vZC
         S5QA==
X-Gm-Message-State: AOJu0YwmFtI0YZN1oE1JqW9R5/rfBbjxO/aeThndfilPDqzJdhDsQmfN
	THnwo1c0c5aeosYhCmmTWcRlZke9Nj7G2gDQhuZpV8j4LXXEH/xunG2HYJg+ulykXCsR/lN8tSE
	/xg==
X-Gm-Gg: ASbGnctWCrggLthmryZyCAv83kV4W975jkabysCGvUlBTikBU77rp58UJFYOgftgtal
	r8xDsaUKPSTX2/iFIbPrflHiXyx//qOLh4w82cRTRZT15Fvv9hnvK7u8VI4iuUHPOCZ7IOeukr1
	kwnZEgXJEiOSRP+dWQfSWuI0xIB5ivgDT2vz8pbXmNYmBXk2Fm377I0nI1o8YW9g75q9vCYiLfX
	/zVCeZFT3reg53vOM6JNqQX1jmFzeh9k8yMLI6go71ytTzlg7Ea1FzI5wrKjKGtDwS6jj646JLQ
	JjjzUHPe4sB3aW4+N4Y=
X-Google-Smtp-Source: AGHT+IGv4qL1r49C///HlTQzOW6r4J4LHGJSWmKS392Nw3uNk04YvJr2itXGv8l8WIzOIV9UcpFcBA==
X-Received: by 2002:a05:600c:3d8c:b0:434:f953:eed with SMTP id 5b1f17b1804b1-434f95312e1mr71006305e9.30.1733844029312;
        Tue, 10 Dec 2024 07:20:29 -0800 (PST)
Received: from google.com (202.88.205.35.bc.googleusercontent.com. [35.205.88.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f123da83sm109778975e9.29.2024.12.10.07.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 07:20:28 -0800 (PST)
Date: Tue, 10 Dec 2024 15:20:25 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org
Subject: [BUG] v6.12.4 copy_page_to_iter WARNING
Message-ID: <Z1hcOV5_xVEeAJxN@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Running v6.12.4, I can trigger the following WARNING

[   62.374530] WARNING: CPU: 0 PID: 133 at lib/iov_iter.c:344 copy_page_to_iter+0x44/0x148
[   62.375388] Modules linked in:
[   62.375747] CPU: 0 UID: 0 PID: 133 Comm: grep Tainted: G      D 6.12.4 #51
[   62.376452] Tainted: [D]=DIE
[   62.376732] Hardware name: linux,dummy-virt (DT)
[   62.377147] pstate: 21400005 (nzCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[   62.377794] pc : copy_page_to_iter+0x44/0x148
[   62.378196] lr : pipe_read+0x104/0x3d0
[   62.378530] sp : ffff800083b7bc00
[   62.378816] x29: ffff800083b7bc00 x28: 0000000000001000 x27: fff00000c21f73c0
[   62.379494] x26: ffff800083b7bd60 x25: 0000000000000014 x24: 0000000000001000
[   62.380171] x23: 0000000000000000 x22: fff00000c21f73e0 x21: 0000000000000015
[   62.380891] x20: 0000000000001000 x19: 0000000000000000 x18: 0000000000000000
[   62.381536] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[   62.382185] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
[   62.382831] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
[   62.383478] x8 : fff00000c1603400 x7 : 0000000000000000 x6 : 00000000000000a0
[   62.384153] x5 : 0000000000000000 x4 : ffffc1ffc30867c0 x3 : 0000000000001000
[   62.384798] x2 : 000000000000103f x1 : 000000000000003f x0 : ffffc1ffc30867c0
[   62.385441] Call trace:
[   62.385684]  copy_page_to_iter+0x44/0x148
[   62.386091]  pipe_read+0x104/0x3d0
[   62.386413]  vfs_read+0x294/0x2fc
[   62.386728]  ksys_read+0xdc/0xf4
[   62.387025]  __arm64_sys_read+0x1c/0x28
[   62.387400]  invoke_syscall+0x48/0x110
[   62.387759]  el0_svc_common.constprop.0+0x40/0xe0
[   62.388178]  do_el0_svc+0x1c/0x28
[   62.388525]  el0_svc+0x30/0xd0
[   62.388818]  el0t_64_sync_handler+0xc0/0xc4
[   62.389233]  el0t_64_sync+0x190/0x194
[   62.389663] ---[ end trace 0000000000000000 ]---                 

With trace_pipe and grep.

 $ cat trace_pipe | grep foo

   and 

 $ while true; do echo "foo" > trace_marker; done

Is that a known problem? Eventually this ends up in a more serious BUG such as

   BUG: Bad page map in process cat  pte:72616d5f676e6963 pmd:800000102279003

Or.

   Unable to handle kernel paging request at virtual address fff82e2dee2e2d80
