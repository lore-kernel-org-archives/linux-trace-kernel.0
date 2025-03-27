Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BEF1E5210;
	Thu, 27 Mar 2025 03:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743045865; cv=none; b=WeTkpn2hiUc+Us3O+5Wd0EyxLCjzfmnbzH3Xd7FwIkMqgszRYczfWk99X9msetkojEcLP48unKSxcY2OzSi91k7QEJMf7cynlqDghcg/hDTV9Zi0B81YO8YRErgshJRQ4xaD+1e475n/z92EoLihTlHGNJmd1QFizRN3rBi7NUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743045865; c=relaxed/simple;
	bh=KuzdeSU+gWliFwXow9YM1xmKtoV0AKeSOb/fjjNgCw8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rtCBFXIHElupORwej5Ft+McVLFpZt/t4XOL83DyM/4VT3t8hmA/PyrZ2BqEWnvgOAkIm7V4dFhfiuu6KHvcoh/HZe5BciRfGrZ0xtfQlb/Ch5cHEXeECCiC0KvWzgChULIYy43QwGcgNeyV46/Wa7zdBkSmul06Myw/UVR+LNU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KA/4aDyc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KA/4aDyc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE63C4CEDD;
	Thu, 27 Mar 2025 03:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743045864;
	bh=KuzdeSU+gWliFwXow9YM1xmKtoV0AKeSOb/fjjNgCw8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KA/4aDycKbZD2jNKPjQ7oXD30BCvby0/dSDk/wFadtlFNakcp9s9PszHCctdNrDkK
	 q0vWWVYVOipIkVUdQ5y6mePwkbQWL1m2jaArlJeelCOy06NPehhK3dOdc4adVFiDWH
	 Ng6mpFg7+AOXWROiYnedkJJmkGCtdpJUcPZsJ7yoQPx7G9RtDzIwWLE8KA5gXvloxr
	 m5PErBMmm2u6KBce2WPRW1DITJti4PaQBUyW3QsyrmkQGTZFPyKnNMAyIjeD81ZwqI
	 WK+FFJLB16AJPxd68Yh6GZaGD6V83FIBSfvCe63CtJpYiZiwdqy4Nn7QqyDQRn+Q1r
	 VX+gc/nE1er4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71121380AAFD;
	Thu, 27 Mar 2025 03:25:02 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: tracing: Fix __write_overflow_field in
 ftrace_partial_regs()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <174304590100.1549280.14019445612094934083.git-patchwork-notify@kernel.org>
Date: Thu, 27 Mar 2025 03:25:01 +0000
References: <20250224-fix_ftrace_partial_regs-v1-1-54b906417e86@rivosinc.com>
In-Reply-To: <20250224-fix_ftrace_partial_regs-v1-1-54b906417e86@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, rostedt@goodmis.org, mhiramat@kernel.org,
 mark.rutland@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, oleg@redhat.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Alexandre Ghiti <alexghiti@rivosinc.com>:

On Mon, 24 Feb 2025 18:42:21 -0800 you wrote:
> The size of &regs->a0 is unknown, causing the error:
> 
> ../include/linux/fortify-string.h:571:25: warning: call to
> '__write_overflow_field' declared with attribute warning: detected write
> beyond size of field (1st parameter); maybe use struct_group()?
> [-Wattribute-warning]
> 
> [...]

Here is the summary with links:
  - riscv: tracing: Fix __write_overflow_field in ftrace_partial_regs()
    https://git.kernel.org/riscv/c/bba547810c66

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


