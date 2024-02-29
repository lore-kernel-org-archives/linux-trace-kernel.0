Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5927CF14
	for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Feb 2024 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709208664; cv=none; b=OGlu99a5afjsPjgd4tuuOod22mRwgowCiVhCC5CHGRTqia0uOQDSyif1z4OnXMOE1mkzWSbGHIE5sXkvTScAYIdVhwFFzh1irzdqwDxTf8oz30m/MUS7mLJ3r+j+tNg253scwzVBjyOAHEG+VtJQ9aZZxN82Fl9qVIOB+sw/heI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709208664; c=relaxed/simple;
	bh=hTxLvpIcL1UD2En8JiMErq12bbbWanA7jyd6JUa7mrw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hg5tSYfW5MSddBw1DIRRnHMw+W9SuSli8Am2rCdyqA3z0+2+HvDX/RqhKEU40TExaZa+0/ZCLurZkdwCkCYNTnUaldZwFRObwl+IEfU3iqzNdxqzbppQB6za+JyUdwCF/TWdDDXdshWyUF2m6mBaCGGDSYrkmYLveEniWCFO+4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=VNEjWVk9; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="VNEjWVk9"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-512bc0e8ce1so854028e87.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 29 Feb 2024 04:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709208659; x=1709813459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3uSDH9PeEDZXjS7+X8GDOuU6r1LyJ3/UzSH+DzMzHV4=;
        b=VNEjWVk9BtR9F3sByRfEGnuL+xxwU9LhfJF5MSJNSWnvaKH+j1VMRDfURDAyxEZ8UU
         7K1DFizR55Sv0YGA39gvj/T9b0IkbxSH/erl5QQRchWDxQwJWuIxZrxpT57dvYKlTx2v
         w+Sz4lcKAxxcm+5PE2K1pxtPaBWjU3QFJLs4WqxOPc1ytes2C3Ac+pUKfIL7VhkmpmcF
         ZNdN2ZTinaOW9H2Dg3EC7G5R2RwNl0KOoTN375NL6Q1kVweMX+/l1j+5/GmWBno2+zuk
         F0L0K3kdRKoXto+i5NLvzhmunRwV8w24Yz9dTRYDKDtoacjNwG6SaFct+0TRp892KV1c
         fX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709208659; x=1709813459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3uSDH9PeEDZXjS7+X8GDOuU6r1LyJ3/UzSH+DzMzHV4=;
        b=Vg2r7A16QtGvVuMt0NskTvdQG/T7CqEXmGWQUOvKzGOgBkmsk7kcf5C8QYmDi2gCsQ
         rE+1xKCFK6zaPXg+/Q9GbRlr0ZOtK+a2JkOzbOa5AxxgDEdkxOArMvsX3Lu3n+Hf43T/
         12uvs4tkD71W03cSzNLAy31KRU/uVTORrj+BdlXAX7FAIwVlSKCuQbzXqn4UWeTDvm1f
         bXexpmMo3q1P8T1KTiT70ZgOo6u5DsnK9Y0IBFvLB3HO++kmq1Xi8JcISer7LbAZQEqo
         lqswBM7wCUbOWPQfeWqAfommCuIlIVeAe5DrzbgvcVY+odDmwBMV4tuOrsKsMAWph/W3
         /kWw==
X-Forwarded-Encrypted: i=1; AJvYcCV7oLA7f3wA2+kAFTF6PDTDAVbscN33KBurx39mcz+S/qS35DLqDey3FoYtmEQKeqE3pOfSiEkoaesJQk/M4CwiXRMmx7DZRITdejMhYM4zqM81
X-Gm-Message-State: AOJu0Yx2y0I1OqxuZ8EuVrAVfXGz91wraP7uaASxm0KZN0cvpuq29F+V
	v7wYhOZu/ocizCGMxZFyZib/CERVnZn+VclbzGkRJt6IEa/Puc1OHzjcxfkTvpmZ//gibGFrZdY
	O
X-Google-Smtp-Source: AGHT+IFiP2+0+aXlKLINZxbd8+wcbG7KYr1oKHoklHZdOQh9SVwwVbbn9h4qAc5ttY+lg8ux9QWdxA==
X-Received: by 2002:a05:6512:acc:b0:512:e57d:c9c9 with SMTP id n12-20020a0565120acc00b00512e57dc9c9mr1885133lfu.13.1709208658724;
        Thu, 29 Feb 2024 04:10:58 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id i16-20020a5d55d0000000b0033cffd1a302sm1602795wrw.57.2024.02.29.04.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 04:10:58 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrea Parri <andrea@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v3 0/2] riscv: fix patching with IPI
Date: Thu, 29 Feb 2024 13:10:54 +0100
Message-Id: <20240229121056.203419-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

patch 1 removes a useless memory barrier and patch 2 actually fixes the
issue with IPI in the patching code.

Changes in v3:
- Remove wrong cleanup as noted by Samuel
- Enhance comment about usage of release semantics as suggested by
  Andrea
- Add RBs from Andrea

Changes in v2:
- Add patch 1 and then remove the memory barrier from patch 2 as
  suggested by Andrea
- Convert atomic_inc into an atomic_inc with release semantics as
  suggested by Andrea

Alexandre Ghiti (2):
  riscv: Remove superfluous smp_mb()
  riscv: Fix text patching when IPI are used

 arch/riscv/include/asm/patch.h |  1 +
 arch/riscv/kernel/ftrace.c     | 44 ++++++++++++++++++++++++++++++----
 arch/riscv/kernel/patch.c      | 17 +++++++++----
 3 files changed, 53 insertions(+), 9 deletions(-)

-- 
2.39.2

