Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4267E749C;
	Thu, 27 Mar 2025 03:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743045832; cv=none; b=IeetTyXYZlgRZOxcB7UIhuN0xOMcmBsUvj2eLzN9vJv4NyRwO0BkKhCdTyxNLUowuS6T0CM1iVrxYmbtls33eWHvRyQGSXVUhuJwF51svOR44X323arsOniQqRDFEM615n4rOQ4/6/tQqEE9C6UXkRmzvSc/pZqvUlzca1sdPyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743045832; c=relaxed/simple;
	bh=MQhcmVMYslup6LMuf3wI469Rp6j+4KOBFl4QW6WH2ps=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ByeoihBdn/x/c82VrXDVnuTJZmgi+2Sd5zi6kTUvOq4goB/cU668Ljlf/YIpMNYMqxt0hLcjDpMZB5pJMp1RkRVXPP+BteZVHPAj8zsZb3F5ULGOPTJMq4CK9pwkRcpU+H+y71V+eS7NEuY0qthKmQm97sQo1w6PL0aoYTWhsio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cylU1Ld4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cylU1Ld4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0AD5C4CEDD;
	Thu, 27 Mar 2025 03:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743045831;
	bh=MQhcmVMYslup6LMuf3wI469Rp6j+4KOBFl4QW6WH2ps=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cylU1Ld428ydr51w5e0flPy+LqyTLOSg2LlqPrpePd5oHB8HePBVwPJbhH9XxUx8B
	 uZTTg2t1jgl/XxBxmQsPpjD5bqcRmrDRy0G9sxbtnIs9qXqcFMs0iWrufDlvrf3Ch5
	 axLZt4jcoiZ9ofb+dZjuV56junB8mrZsNLryoFt8HMl7y7sAOho5WeiKr7W8jlztE8
	 S5Ola6+X3xZDtcO6uNsfo+D7t+WWrBAnNJZcGScat6gLuyhTqDZw+l211Gj3Mcr9JC
	 eQ9rUvzjqUv3K9jyGjovklgZc+hFL7FwusGgs1kqbkHm5y0M+YMz2qA+lpbrc/BzeD
	 w6GnP97Jl3sSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CE7380AAFD;
	Thu, 27 Mar 2025 03:24:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v10 0/2] riscv: Add runtime constant support
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <174304586800.1549280.4422095379937225029.git-patchwork-notify@kernel.org>
Date: Thu, 27 Mar 2025 03:24:28 +0000
References: <20250319-runtime_const_riscv-v10-0-745b31a11d65@rivosinc.com>
In-Reply-To: <20250319-runtime_const_riscv-v10-0-745b31a11d65@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, ardb@kernel.org, ben.dooks@codethink.co.uk,
 pasha@rivosinc.com, emil.renner.berthing@canonical.com,
 alexghiti@rivosinc.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mark.rutland@arm.com, aou@eecs.berkeley.edu, peterz@infradead.org,
 jpoimboe@kernel.org, jbaron@akamai.com, ajones@ventanamicro.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Alexandre Ghiti <alexghiti@rivosinc.com>:

On Wed, 19 Mar 2025 11:35:18 -0700 you wrote:
> Ard brought this to my attention in this patch [1].
> 
> I benchmarked this patch on the Nezha D1 (which does not contain Zba or
> Zbkb so it uses the default algorithm) by navigating through a large
> directory structure. I created a 1000-deep directory structure and then
> cd and ls through it. With this patch there was a 0.57% performance
> improvement.
> 
> [...]

Here is the summary with links:
  - [v10,1/2] riscv: Move nop definition to insn-def.h
    https://git.kernel.org/riscv/c/afa8a93932aa
  - [v10,2/2] riscv: Add runtime constant support
    https://git.kernel.org/riscv/c/a44fb5722199

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


