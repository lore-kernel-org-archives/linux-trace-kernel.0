Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6474C9A;
	Thu, 27 Jun 2024 17:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719510645; cv=none; b=sHTvf/5/jcLA5PI16KR5hJoptEA6KQdB66up2ZB6nAObVpDz0ZaVSHh9zwiiBKxu6VwUwM3WauBy2BzG4iLjIX4qam5Tyw0fHsy7/q91JtzR2bJfz7KbJQJXYgGUVTgJlBvPFJ1C4pKyZtETu3a2MDLeDRViUDGngxHjeOG7xw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719510645; c=relaxed/simple;
	bh=jobjg9OesfGn+Q6aCcAWa0Gq/nbPQMb6sNYVq2ittnQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gtY0HuXb0xO3BJo/8EFsAohJ2vvY/lYBhxobBdUQmVy9uTznaSUj9qNifu25vVS48E1W69dqXx8WskkYzNlwuE/eHarsNX1xmBJ0K/mC8Bw6YV9XBWFmdA80YD13vUYEd2gDHR87EwZ7sjWj0rmHpvIaluGiLUYM9kc5/4LoiiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdJ64EEn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdJ64EEn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9C73C2BD10;
	Thu, 27 Jun 2024 17:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719510644;
	bh=jobjg9OesfGn+Q6aCcAWa0Gq/nbPQMb6sNYVq2ittnQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hdJ64EEnw+ocdIPgMBxcSO0LRAqr3vLx2l2KCjZ/B2DT3wUoG2gUMypr0XRKZ498Z
	 ozdCKPuHPsG4WZxp271//HfptbaNG6sZeOSfthkltOYB6cZ8VOSS5sW4KHFxUEOfUs
	 HWpo8zwgK3YGwaMwQVVinVXFUE0aTG90dUgpaR16LAFXjSFV0FgaNI7UJJTAWP+6US
	 0oPFyIm6WzdMTzww8Z3IYDreBK+N73/6yfjb/ziPxcaMRtZKIFvBZRuELaDKRmHw8U
	 tCkK4JWLFIaUBjXqVM3jLjIkaNrmE+7CZ0WgOtitDuYYovApX074XBVIgDSePuuc2x
	 hJWL3H9VhXwwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8ED99C433A2;
	Thu, 27 Jun 2024 17:50:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -fixes] riscv: patch: Flush the icache right after patching to
 avoid illegal insns
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171951064458.6762.1867426653510240080.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jun 2024 17:50:44 +0000
References: <20240624082141.153871-1-alexghiti@rivosinc.com>
In-Reply-To: <20240624082141.153871-1-alexghiti@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, rostedt@goodmis.org, mhiramat@kernel.org,
 mark.rutland@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, bjorn@rivosinc.com, andy.chiu@sifive.com,
 puranjay12@gmail.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, conor.dooley@microchip.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 24 Jun 2024 10:21:41 +0200 you wrote:
> We cannot delay the icache flush after patching some functions as we may
> have patched a function that will get called before the icache flush.
> 
> The only way to completely avoid such scenario is by flushing the icache
> as soon as we patch a function. This will probably be costly as we don't
> batch the icache maintenance anymore.
> 
> [...]

Here is the summary with links:
  - [-fixes] riscv: patch: Flush the icache right after patching to avoid illegal insns
    https://git.kernel.org/riscv/c/edf2d546bfd6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


