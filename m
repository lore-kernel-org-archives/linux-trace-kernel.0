Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF27306B1D;
	Fri,  5 Sep 2025 16:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757088839; cv=none; b=UREPym5UfmrPbnxhjdMDC8z+Gievhje4b8hN/LkNCWd+S9/5fi3BUPOMmBljKTqyJSQkzlY0h9HwE0b77dJtqc02p95BlDbGX3P9fMtL0PKoNK8ek0N3VK542L7LkvCBiYJMVw1ILtX1g3qyPiMszrrZk4eYU67TvPwoBpL0uQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757088839; c=relaxed/simple;
	bh=YdFIG94YPJs4n/3rT3ux8EbJmDGtB2Mn/Eam+IehyD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yc2vWmHCmr3mvK+m4MZw5NXcAhoBnvaMA6wS3RMz/6Pntn8C6v4OS93uhCdeYBFK020Ro/DyQ6Xf0fiz8LRn+gWqJN938Dq0j4/epqIBk7zMNYAWRH4ThXgHIFOoSlh4mR5d/UZyqt2o1S6KIRbBnVIt2z/ICXN7BKblnkD6HX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E4FEC4CEF1;
	Fri,  5 Sep 2025 16:13:56 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: will@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	samitolvanen@google.com,
	song@kernel.org,
	ardb@kernel.org,
	dylanbhatch@google.com,
	panfan <panfan@qti.qualcomm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kdong@qti.qualcomm.com,
	haijianc@qti.qualcomm.com
Subject: Re: [PATCH v2] arm64: ftrace: fix unreachable PLT for ftrace_caller in init_module with CONFIG_DYNAMIC_FTRACE
Date: Fri,  5 Sep 2025 17:13:50 +0100
Message-ID: <175708881849.3546185.8607701618216308416.b4-ty@arm.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250905032236.3220885-1-panfan@qti.qualcomm.com>
References: <20250905032236.3220885-1-panfan@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 04 Sep 2025 20:22:36 -0700, panfan wrote:
> On arm64, it has been possible for a module's sections to be placed more
> than 128M away from each other since commit:
> 
>   commit 3e35d303ab7d ("arm64: module: rework module VA range selection")
> 
> Due to this, an ftrace callsite in a module's .init.text section can be
> out of branch range for the module's ftrace PLT entry (in the module's
> .text section). Any attempt to enable tracing of that callsite will
> result in a BRK being patched into the callsite, resulting in a fatal
> exception when the callsite is later executed.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: ftrace: fix unreachable PLT for ftrace_caller in init_module with CONFIG_DYNAMIC_FTRACE
      https://git.kernel.org/arm64/c/a7ed7b9d0ebb

-- 
Catalin

