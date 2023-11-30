Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D460C45949
	for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9Q5rmh9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124E7C433C9;
	Thu, 30 Nov 2023 12:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701346547;
	bh=HmEvOH8Vmsy9AJOG2aGCmYoPEIzruRbAiBD2YtmkRA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f9Q5rmh9aU+KSwsXTUbDjhEslkwGTLJuD4YuvMKZRNk1vid8BLmrfcxYmm5rGC3Sv
	 3AeVL2U4xQD8iGEf5sdIVwqG8VKvcfyZToF3GOVR1N4xhpz29fHpZm5WjQkfPxU/oa
	 NCIH9i21TD6fDUvf90zs0Vqn3/6daJEmcrRSwFQ8oI+U15yf5TPwVfQ+GFsAvZ5xB9
	 98WoVjgKVInr3rBkHlBzIN1C3133mWV+BOx8BiXkxuU6OA5K0fL28TAZGaO+4cntvL
	 IzXdGCWDKjhi25Jgr7pupYTgq9xbvkppQ6jSgaejO4vPumm4hCoJIer45JZzZLvtKq
	 q6hQGZqNk3T1Q==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Song Shuai <suagrfillet@gmail.com>,
	Guo Ren <guoren@kernel.org>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	songshuaishuai@tinylab.org,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH v12 for-next 1/4] riscv: select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
Date: Thu, 30 Nov 2023 13:15:28 +0100
Message-Id: <20231130121531.1178502-2-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231130121531.1178502-1-bjorn@kernel.org>
References: <20231130121531.1178502-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Song Shuai <suagrfillet@gmail.com>

In commit afc76b8b8011 ("riscv: Using PATCHABLE_FUNCTION_ENTRY instead
of MCOUNT") RISC-V added support for -fpatchable-function-entry, which
removes the need for recordmcount.

Select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY to tell the build
system not to run recordmcount.

Link: https://lore.kernel.org/linux-riscv/CAAYs2=j3Eak9vU6xbAw0zPuoh00rh8v5C2U3fePkokZFibWs2g@mail.gmail.com/T/#t
Link: https://lore.kernel.org/linux-riscv/Y4jtfrJt+%2FQ5nMOz@spud/
Signed-off-by: Song Shuai <suagrfillet@gmail.com>
Tested-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Guo Ren <guoren@kernel.org>
Acked-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 95a2a06acc6a..69c95e42be9f 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -68,6 +68,7 @@ config RISCV
 	select CPU_PM if CPU_IDLE || HIBERNATION
 	select EDAC_SUPPORT
 	select FRAME_POINTER if PERF_EVENTS || (FUNCTION_TRACER && !DYNAMIC_FTRACE)
+	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY if DYNAMIC_FTRACE
 	select GENERIC_ARCH_TOPOLOGY
 	select GENERIC_ATOMIC64 if !64BIT
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
-- 
2.40.1

