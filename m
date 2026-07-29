Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7183976BB;
	Wed, 29 Jul 2026 22:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785365878; cv=none; b=sWRlC6I5zj0hpWptVzu7h1d4psQvXTtpy2Y5dogQUSBFrfRxU7GI/jerff6zFEu0FY4Z57bk+FwBqoldrfOsHQH7InhJ9UuTk3EyAuX1u1DBSV+mR8/bxwW3Gguo9MeK/xuuHBEZXiahTwRPqPkMyB0guUGwfCBbqM4KdPY+FqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785365878; c=relaxed/simple;
	bh=bfZSSmxJ2lscqsqv3C6aRl8JwowteTi86V6rXp2CKMw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fhX2IvfDBRcgWWQIBfD2VtjWOKVRcd8Jx5ymx7sbdMohRKCc+gqVWZK505XRwlzulFZXyAROGgzZSqKE5XNQM+FEwmsjk/DXr+1+nWiq4o8pM+dwwAoqC5BEECiJV2yxj7f/aD+0fsVtqZVwiCSsnlBE5WeH0Mfi39Rr7Vhkv/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gH5s2PYB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gH5s2PYB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040D51F000E9;
	Wed, 29 Jul 2026 22:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785365877;
	bh=+fWCrPz4hD35/32inYxyCF+iDOC/obqPV6oBRpf3R80=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=gH5s2PYBzMTD5A+B4ANX4QQ+NR0FIGklfyF3euI2yPjQUxfXhCXANrmXeEz+htm4J
	 M2znc5AnZrnnNKbc1GPakKBYBs6G3ZAIepNe7OPjbnqXieS5FIkjgXrEq+QMJMd6B2
	 LRMfdBlqkrzd4x1ekhTxsgd091bSKW+9w/uUGaPCT8FJlDJPHtyr4NSTmzuYeE8Rvn
	 0Ovy5yK4qmzonfe1k1m0fRV1PjOnOydewfxked3lDVwRaXhkq71Y6HEe3W8FueYXKB
	 E1oBo7iX8VLW+dQLduzrwsrBL5J8pnaDI4uaIy4y0fHkcUxuWg5EGWhfilzIsTMClZ
	 9bMkSuHI6z8Kg==
From: Mark Brown <broonie@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 konrad.dybcio@oss.qualcomm.com, 
 Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260729-add-tracepoints-for-se-reg-dump-v4-0-08bbd63b0ed2@oss.qualcomm.com>
References: <20260729-add-tracepoints-for-se-reg-dump-v4-0-08bbd63b0ed2@oss.qualcomm.com>
Subject: Re: [PATCH v4 0/2] Add trace event support for GENI SE registers
 dump
Message-Id: <178535782300.335843.500747630005048689.b4-ty@b4>
Date: Wed, 29 Jul 2026 21:43:43 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev

On Wed, 29 Jul 2026 20:43:24 +0530, Praveen Talari wrote:
> Add trace event support for GENI SE registers dump
> 
> The GENI framework is used by multiple drivers including UART, I2C, and
> SPI. When hardware-related failures occur, each driver typically relies
> on local logging, which often lacks sufficient information to determine
> the exact controller state.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/2] soc: qcom: geni-se: trace: Add trace event support for GENI SE registers dump
      https://git.kernel.org/broonie/spi/c/f40e7ab049f4
[2/2] spi: qcom-geni: add GENI SE registers trace event on error paths
      https://git.kernel.org/broonie/spi/c/607b41c1e0fe

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

