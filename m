Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BEB22F1E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142719; cv=none; b=MA2Jex+etCb4S8GdaXZTTwnh8SabYJOWJAtj28DIRU2N7A1vTE+nhV1UXCVBU4oNwmOJTMuAuc4Q5/oOXEvZuEWDClIAkQtqctmWzvVEH1oA0R95m832VY+YEsgAT2GN23D5jZb1R6ogqZOVIyjRIfHh8tLvMC0abzPwDcSBXxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142719; c=relaxed/simple;
	bh=DYg0LXB04IOIyfloSAJ7RhMuraWDe4p86DhfIeb4hC8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=OWEZGL20Uk833thowXwDD+cvoIUzYSWTqjPPsVnoOQyrZOFopDG0SuBEFkrEvl0mBXGEFUx2fpBlgVhklRHdldiFsP9z23LX0QtKdSS+n4FFOGl0zUTrO2gbZOTs4f4QB9mRmk0YmzyupoVHKCw6/ZwQpxSaUYdRzgP8pu9xMPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=q+5OvfTk; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="q+5OvfTk"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d29111272eso41486461fa.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709142714; x=1709747514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2PXWhKeObjvrv5a0sp4dojdugZSvAvimHcwo4W++JCk=;
        b=q+5OvfTkSQ/neuhhx5Q0jFSnztg1vpt3gWh4/SFdi74J+3codoxO0txrzjdShKsu1R
         HCsBYu6B0mr402b+kTaCrhfMkvasPz8VUTX38YTBU1/jJ9UgwdzHTB6sMnNKpk/ELt5B
         1g0h0QY0gUDOaqoaqZTZEyB5TU+nCH1N5fAhtTOFjMAQwIduLWgi+Y9bMJl9GCSBiOwO
         gr0YJ2tBCj671JkaVTtsOyUTS5B5QHtR9nW8DCmxRR2RAglEIg9Iu5VDbN8QjaP21YJX
         5KFKM6zUOOVhQVm7abrDJ0BZEdbTueAlxePLkrwznjNoNZLQ/n4EeJmZZ6hnN+D7wVQM
         GsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709142714; x=1709747514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2PXWhKeObjvrv5a0sp4dojdugZSvAvimHcwo4W++JCk=;
        b=gdb0rcqIavTX8PAVY2mIZpBb0JWk/DWlyBu4RRhOzpJLNhNokVJFe7MxgzG1fe5/MK
         kHWimnICwt54Cgy4Q9Z6JR9ZjSwVYkPlOmv1IKrNckI3n94IVeykySpkEIOxCy1dpksB
         ZLvwPspqrX223IH4BoMLDERDD2MATOXJiyMY2WohG0i+6fI2wMgjp6kHfch3gxJaYcsJ
         k+9THYgGafPDtllJKEkzV2AOYbrs3XQJiiAXEa6QuJSV7wcps9bFn19hjjezSth3VyWR
         ioI2LPi/8kH5lFMXGCWp1OJQVL3e4ThIL/9OHyVM2NoMBy2NTVvx8+JD7lTZWKSfzmnN
         DGow==
X-Forwarded-Encrypted: i=1; AJvYcCUlHOCxsbJINSRLsIuhXP8Vn80Y0daunU6s8eJyL2im+34238jgClgsRVaw/UIKPOhI40vVvlCL7occgmgh3BKLstTpBqU/u+6TNHP/vXDEriYU
X-Gm-Message-State: AOJu0YzJw3tfphGT/I+qqXeMvcnoRlpgAZRjaiXRYLkiSfI+JeMWorLG
	nBSWKHFZccP2OObL2Fk5WSGzmty0AJe2J/XPRcxoKBrPJgZYqiaNVVFjTUACIMA=
X-Google-Smtp-Source: AGHT+IHx7VzXebFCK9PVoydXjk9GVjtk6uMFBqmfk4DW/VbXqUm0WiQ9809xGiewPieJ0e9vq8pkKg==
X-Received: by 2002:a2e:994c:0:b0:2d2:3017:c144 with SMTP id r12-20020a2e994c000000b002d23017c144mr8654944ljj.39.1709142714369;
        Wed, 28 Feb 2024 09:51:54 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id m20-20020a7bca54000000b0041290251dc2sm2706543wml.14.2024.02.28.09.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 09:51:54 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrea Parri <andrea@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 0/2] riscv: fix patching with IPI
Date: Wed, 28 Feb 2024 18:51:47 +0100
Message-Id: <20240228175149.162646-1-alexghiti@rivosinc.com>
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

Changes in v2:
- Add patch 1 and then remove the memory barrier from patch 2 as
  suggested by Andrea
- Convert atomic_inc into an atomic_inc with release semantics as
  suggested by Andrea

Alexandre Ghiti (2):
  riscv: Remove superfluous smp_mb()
  riscv: Fix text patching when IPI are used

 arch/riscv/include/asm/patch.h |  1 +
 arch/riscv/kernel/ftrace.c     | 42 ++++++++++++++++++++++++++++++----
 arch/riscv/kernel/patch.c      | 19 ++++++++-------
 3 files changed, 50 insertions(+), 12 deletions(-)

-- 
2.39.2

