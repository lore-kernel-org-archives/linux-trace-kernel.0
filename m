Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF6315DBCA
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142779; cv=none; b=rhNd4Jja/DAgNCUOtch7Dt/FMtDF7O+5XKZv9uDItQGSytdFaxzyuJJNVHAPoPd43lNpRPznKfsb//AeeIs5xEhFWDn8ubHKACWqJi64oBH2s8wgXQCRhHDna/TbWnVaJE9NQWdt1ulEPtbSpGMCwjvG/Ue22qm6Hr1sQZy3deI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142779; c=relaxed/simple;
	bh=VvQb+BMTgSSey78SvDrMJm/73S7iPwz7W6A4Lzu8+18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DpdV/MoueRXWLrPk/W7NuHSigN/UAqTatzEZp2/iDGf5qKEMSJAe7SQk29aCnJ0LIKKkWV443AY0aRO5jCMJFd5BPc8kZDPbFg/MOjMR9y3vT4CIELn+CKC/xMG7yEAHdjVCyNzczWfcaiJs3p0gkunvev+bDU1DX0YeYXKa0RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Qhfm7L8k; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Qhfm7L8k"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d204e102a9so69747081fa.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709142775; x=1709747575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wN06uTemIfMB8SobqPuytHQ6Es/YWPqVM45xDKN/b1w=;
        b=Qhfm7L8kikplC47Nz/45oGAlXdkET9KCUglJpFm9sHkUPfQPlbtjWfIQGWSXHoLGgU
         BSWiGte/EPNeUIm+dTONcD/j0hKlI99iJmEHaRSJ/sgRbWVBrCHqrs8xY8wnV7jCCkVu
         1mZigIRXqwyCkNlWXrL9nzAEB0Yp90ILOO+Y7Pl7Txnb3M0u86SRA4KyozDVc2LvlEeR
         AiYqz/q659BMo7dY3nFjcFnTYXi7Oi8heY1gcpdK8ytWJchD+KFE9FpKbJMyQu3e0jX4
         4ZZt99RLcx6qCt3kBJydw/2ZVRCenoe0NgvfnSt4L4RpXmbqxSgFfHeCWgOyZCa+enGo
         LDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709142775; x=1709747575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wN06uTemIfMB8SobqPuytHQ6Es/YWPqVM45xDKN/b1w=;
        b=B6vTb8tjNL3wWUpEGYjSmK+nf+ykBCTdLfmOZzDW1wf0yrWGsZ+Xtesy5CPNI5zGM5
         4iWYp3IDrl7gM1zj9QUvkyN0xY2rOPIlW6mQ8hEJ6umGBbiwmIuVpGoGkGgcYZBtumK9
         r0wmZPtT6m4lypVAKItWcIB2cR9gFF2OxZleLPWUvPVVZ+D0fFjgV+bDHyYVEPEOAECP
         SyjA1U38dNaW585k9/KPJHHZvmlyOrFp5iKonKXg5oay2etmYosYnsF6tcvveihB4xQa
         Av6HCV7KsWTxV6oumQepUWEqIcfl/hsthFqWwintjTTzxwKyDntVxSLHKN9efhWSA+dK
         xgbg==
X-Forwarded-Encrypted: i=1; AJvYcCV5IXKIqOm7piRb56fZcGYn7WAdHXOKYjVdJ19ZG4WDjDSY6cOZTyoWYppseI8IbShMKBipBM1kwfaT4XxQLqAKJ7m/0Zd5MhIngACAhJocKBfy
X-Gm-Message-State: AOJu0Yy0BQ+/AjdUyd10D9m4EP9PSAPUirqjn+zwRuSwdjAY3RMIS0kP
	59ZOGqpRUSgceMK5wALYunAzR1kOXPjmaMHv+jxlQ4yUNcRfBBxUEk28UrhY5t0=
X-Google-Smtp-Source: AGHT+IETg7kV0bx5myF/NA0zMEyulWLTEzaaIPLLJycmnhfj1WlzWCL3ZxXNKtGoRPlCHLw3VzcB1w==
X-Received: by 2002:a2e:a545:0:b0:2d2:d58b:652a with SMTP id e5-20020a2ea545000000b002d2d58b652amr1724531ljn.21.1709142775497;
        Wed, 28 Feb 2024 09:52:55 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id ch12-20020a5d5d0c000000b0033dabeacab2sm15500222wrb.39.2024.02.28.09.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 09:52:55 -0800 (PST)
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
Subject: [PATCH 1/2] riscv: Remove superfluous smp_mb()
Date: Wed, 28 Feb 2024 18:51:48 +0100
Message-Id: <20240228175149.162646-2-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240228175149.162646-1-alexghiti@rivosinc.com>
References: <20240228175149.162646-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This memory barrier is not needed and not documented so simply remove
it.

Suggested-by: Andrea Parri <andrea@rivosinc.com>
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/patch.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 37e87fdcf6a0..0b5c16dfe3f4 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -239,7 +239,6 @@ static int patch_text_cb(void *data)
 	} else {
 		while (atomic_read(&patch->cpu_count) <= num_online_cpus())
 			cpu_relax();
-		smp_mb();
 	}
 
 	return ret;
-- 
2.39.2

