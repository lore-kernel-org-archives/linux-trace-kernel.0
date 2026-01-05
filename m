Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC53311C24;
	Mon,  5 Jan 2026 22:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767653937; cv=none; b=EWa3e1bwdqSUEYPjpVJGMC6sJx4pbwdFkhr3YQirjewym43Rmv/uhZ9HRpTIgpHUWnQZ0y3EzhI94SLsVZWb67KVWkBRGro6yLnL4ni+h1g7bs2a8kwv9L8DV/mUruSoatKfdP66W8c+s289evULasm2X4ZyQilwLKWHbP7bhwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767653937; c=relaxed/simple;
	bh=JFPOBvbTjmeMqXOwXhUAcaRqRs6h5mCTAz9J+WLFGV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bqwBKHOsGgPWKVDBEualerl0bsh8HVqxbyU2GGGRpyLDrOtMejBTNbZ3Sq5Kl9BK4Y0NTwPcKzzjyxdj60atyxL0bZ0PNIYm5piFyQBTwJ1BffJw+yzp/8j4jTMOriTndAld93UsntAmMq1amuKkeILvtS84jOWYVg50Noex21I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCKsMQy9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCKsMQy9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BEDCC16AAE;
	Mon,  5 Jan 2026 22:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767653937;
	bh=JFPOBvbTjmeMqXOwXhUAcaRqRs6h5mCTAz9J+WLFGV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vCKsMQy9EpaX08WQG2C4dwkfLcRRS+BH/zMGoHUv0EWLDweFyqvrTylCH4BCl1glb
	 O5usHNjvzbmnwACa4EuLZjX1K6H79oOmIOR+147TEGSzWYJzGYUetWWV7GmkF09h42
	 7P6hWwN+CqDEE2uWypmaQXMHYbgB2ih3fihvDjnUcvaVtL6uzDDhHT4QN9D6usTX9L
	 Sz4Q/eneWLGNws3wWK05aRvASSA9VhrTz0nLyZKU+iD9GgTAWG/Ys9fujsM8bpn1Ee
	 71VIOZMm0hjh0a8a76DSRbxcUP6mLO4VuBwpsAcQWnUnXrA66OSNQxl87tzvOaOU+M
	 3O3I1EpK/M8FA==
From: Will Deacon <will@kernel.org>
To: mhiramat@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org,
	catalin.marinas@arm.com,
	Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: simplify arch_uprobe_xol_was_trapped return
Date: Mon,  5 Jan 2026 22:58:25 +0000
Message-ID: <176763137996.1384236.2783577028215975576.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251126223130.216302-1-osama.abdelkader@gmail.com>
References: <20251126223130.216302-1-osama.abdelkader@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 27 Nov 2025 00:31:30 +0200, Osama Abdelkader wrote:
> convert arch_uprobe_xol_was_trapped() from explicit if/return true
> return false pattern to direct boolean expression return in
> arch/arm64/kernel/probes/uprobes.c
> 
> 

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: simplify arch_uprobe_xol_was_trapped return
      https://git.kernel.org/arm64/c/484626209600

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
