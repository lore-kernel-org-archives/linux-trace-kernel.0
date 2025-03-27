Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF961AC42B;
	Thu, 27 Mar 2025 03:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743045845; cv=none; b=anO/PcAL+FzwkVapNk1mvWQpBBKKrRTA+z3xiS0ZhnqdUAdUHZQk++aN0Xs7YByB06HnC3D4CCGqaeRoYu6YDTaeJllX31ZrmNIB05ym37QZYzby+9CAWwQEjBYP9WcoQES4Ev41kslTNvMdmL6xmCKDhyGfBywvr0d93fPUb3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743045845; c=relaxed/simple;
	bh=a/1dhKQZA9WXAV4MchBNrnu1u3x/RKB2nhabVuvLdEE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QuQbjPo1wsQkSIqSw03julBNSL+HcrpoyY6ATSapI+UQsxSul16zlFqaJ6Cwfpd9akp7T4KIE5LYzrbKKKi1LZBYF/ePMCJLH+WlyGzsiD35zFZBJ9HqRjjNTXGLgEJepDhQm1Moh7z9UL7VtktG2OGlNm9ymk0sixOF5+zqR4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tInMVZ1x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tInMVZ1x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226CBC4CEDD;
	Thu, 27 Mar 2025 03:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743045845;
	bh=a/1dhKQZA9WXAV4MchBNrnu1u3x/RKB2nhabVuvLdEE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tInMVZ1xbJKBmdRpo+3xhaTiRiIWrjOXUZs/0F85DjYlRcH0wI1SCYZjItLpGdq+L
	 ZG9Ud1dGEe9NJIPjatI1q+PhyksJnfGvTebWgThuBEHz/jJz/Avyp9Pi48LP1u+8Rv
	 K5vXSuMK/LKY+M7ag4OzmQg/6IY3T38m0nIuMbC2KhOAQuFy51mJqED9RypFuuoIq4
	 7fZP7wvtSVRdmbGdBOSZObyg1skDOxnG4FqAu8D8Nlhcqwaa8xVqHh9XwQm37JE9/q
	 KeDfpIPeAkI06LwAndwbYFvopRIEaOKtH72MGLxZPIHjLUrMMoLJjDHgUawqEiSGAP
	 opOo3KmyYTNPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCBD380AAFD;
	Thu, 27 Mar 2025 03:24:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: ftrace: Add parentheses in macro definitions of
 make_call_t0 and make_call_ra
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <174304588138.1549280.9624481038618834667.git-patchwork-notify@kernel.org>
Date: Thu, 27 Mar 2025 03:24:41 +0000
References: <tencent_AE90AA59903A628E87E9F80E563DA5BA5508@qq.com>
In-Reply-To: <tencent_AE90AA59903A628E87E9F80E563DA5BA5508@qq.com>
To: Juhan Jin <juhan.jin@foxmail.com>
Cc: linux-riscv@lists.infradead.org, guoren@kernel.org,
 guoren@linux.alibaba.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mark.rutland@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Alexandre Ghiti <alexghiti@rivosinc.com>:

On Thu,  6 Feb 2025 13:28:36 -0600 you wrote:
> This patch adds parentheses to parameters caller and callee of macros
> make_call_t0 and make_call_ra. Every existing invocation of these two
> macros uses a single variable for each argument, so the absence of the
> parentheses seems okay. However, future invocations might use more
> complex expressions as arguments. For example, a future invocation might
> look like this: make_call_t0(a - b, c, call). Without parentheses in the
> macro definition, the macro invocation expands to:
> 
> [...]

Here is the summary with links:
  - riscv: ftrace: Add parentheses in macro definitions of make_call_t0 and make_call_ra
    https://git.kernel.org/riscv/c/5f1a58ed91a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


