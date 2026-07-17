Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F295727587D;
	Fri, 17 Jul 2026 18:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784312599; cv=none; b=Y/AWob62JJAZOE+CQiuUlMgy+LUiecPQCydtGMa5g1jGeARQ4t2SME3O9e+Hjyg3LULGQTq8cXBQQWPs9sRDpm/qee8Iok83kYuM6/r/nyiEh6HbzvleZareYO2Px0QjCnPFbyQtKqnAyZAgZTQ9M4hHrZ6+2knEb/QcHBiLhtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784312599; c=relaxed/simple;
	bh=gU8u1Xm4GBedXzE/bToT04xl8es95mzWgcKHUtTbTVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hQFVq4hpUsv9cYBbQQ1s9yMWX8klwu8vKCyS2t7QVPxZlpcn6l3R0Veyol++5ocFKKxQRUT3tTHOXLFrVnaGzGkWfefTQWHXQtNt0amPhK+cs9QrmIvAu4vFTaYmbLEgOJNbDUzT0JJG5Yf0jxIauc3VZxSyd9aPLh3V7hmLhjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTvyY7ex; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTvyY7ex"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EBC1F000E9;
	Fri, 17 Jul 2026 18:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784312595;
	bh=uT+bu1nR22jG3svg0QpVCjdccwM9QhJkJ6q8Ga7Koes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fTvyY7exskBBJ3sUMf7tkQM0dXLp4Dh0gFJeCZ2keVBp63ziyBOWMRgcJeb6B9SyN
	 do2nre2RWPxsnPr3MebejaKtdWGRYlNTDpR9gNr/HH1UjilUShzt1D6EtGiT00uCDM
	 RVswumwHYRggaXROvnppkQYDkTzJgfHUqwInlWm3oZzWjedQ/WvgEX12dgVAqhE1f1
	 txw1yYJhxsqBmGZqJLsx4IMP9Zs44hlusOa5YtPvuMvLCXwJ/cz31wgXpT+KWOIcb4
	 AkCC54qvbKqgf9HfRwM+p79ys/3c9VcEamZIluViubR0pygNmx/ghpDG2ad7/0orer
	 qr3Er2wpG8syg==
From: Will Deacon <will@kernel.org>
To: mhiramat@kernel.org,
	Pu Hu <hupu@transsion.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	ada.coupriediaz@arm.com,
	davem@davemloft.net,
	Hongyan Xia <hongyan.xia@transsion.com>,
	Jiazi Li <jiazi.li@transsion.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	naveen@kernel.org,
	yang@os.amperecomputing.com
Subject: Re: [RFC v3 0/2] rm64: kprobes: Fix single-step fault and reentry handling
Date: Fri, 17 Jul 2026 19:23:06 +0100
Message-ID: <178431138979.1463087.7670145018336150916.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710063242.228714-1-hupu@transsion.com>
References: <20260710063242.228714-1-hupu@transsion.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 10 Jul 2026 06:32:52 +0000, Pu Hu wrote:
> This series fixes two arm64 kprobes issues observed when running
> simpleperf with preemptirq tracepoints and dwarf callchains while a
> kprobe is active on a frequently executed kernel function.
> 
> The crash happens in the kprobe debug exception path. While a kprobe is
> preparing or executing its XOL single-step instruction, perf/trace code
> can run in the same window. That code may either take a fault of its own
> or hit another kprobe.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/2] arm64: kprobes: Only handle faults originating from XOL slot
      https://git.kernel.org/arm64/c/879a6754d3d1
[2/2] arm64: kprobes: Allow reentering kprobes while single-stepping
      https://git.kernel.org/arm64/c/23f851ac0078

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
