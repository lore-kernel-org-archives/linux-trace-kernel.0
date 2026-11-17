Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794914786;
	b=V2ikhVPyx7rN76A66H5irdcnCe0UMf/65RCsdUYRRFk0s9Mq5fxd26IoNqSaGb/5L+gn
	 aHfDngEAJwl4I502tOK9DrXAAfV/yx/5WtHJEW2RvAowe13VY0G1tZYiagWWHaay0Y/76
	 1sLRv8GD3mUt3J1p7+YEzW088ZL/yFm+AdB12FjG9uk8Oeuj0/2s2A3lutCDBh3aEK+04
	 oqdpg+miybVbkd91lrKYwE9g2N8QeT+KSuC5WwFTTPFJ0VCYlc0E2DftDQA18OeFH85Dx
	 fJAi4d4F4elohnBZK6FseYqc/9dCK+qeO2/G/642+t/RzNb8D0NOzzOvC/tM+s+oGhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914786;
	h=Received:DKIM-Signature:From:To:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=+OycqK3cd+ZXVs2LMQfSxir1fD3j6jLIn0dT6Kkp2J8=;
	b=YuNLO7wI9ytrNIb/R3z1ct+ijZtyBghDJPuC1dItBbsGLZo7efIgWpQjnl08CxVu5k7E
	 NfTrTYTgoGbU93cwWEOH6eb+8VRzGv+UAsvtpxsxsxOndzpncViZgwP8Y78nYepDhfZZJ
	 AR/ZqZIWgfwI7hrgbDcDxjuSNU7Olkg8qDLe1Y34F4brYkEEQ8j+klAkqPCAMDchY3CwA
	 xlfvkJ46lKU7lCquousAG4RzEk9POPnNC5Lvjg6IcV2bEV8XHnTdUfWkCzz2wv4HOjlrG
	 EwpN4eqijCfwBLcoVemreXaV9bBUI7eRP4VTWq1MQj1RePoPxValjUacou/fXUlhZBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jXYMiNh8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793AE606A31C;
	Tue, 17 Nov 2026 11:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jXYMiNh8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA7F1F000C4;
	Tue, 17 Nov 2026 11:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794914786;
	bh=+OycqK3cd+ZXVs2LMQfSxir1fD3j6jLIn0dT6Kkp2J8=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=jXYMiNh80N2TnHcmikgLEQLZjaALXwTpK6B6sN25XBoNbpwjy6VMIeZsdrRRA0ACn
	 eYFsynfF+mdQaGCcPQi45NrNWQ6ctTZnX20NdZZep9ISeupkKxPV5O6wVY9NwudvSM
	 cH0bNTxlGv11yVcThvHcT6t0x1WTcUGWopvc6q1c5r47dtRphQ2ycabQR3H5aiUZF/
	 BPD5WwgvQ24ZwVIgDFFhdooFHIBclnGW1gUcsn5dcJa505x5uTFpWkz+tJuu5gWjYt
	 O4Vd6nskaAU/IOU+AjF2+oa5KRmG/O+JUAW5bUAHg+IsPLSLcSagXxOmXZzhoI4soW
	 16gR+ed0B5Qfg==
From: Mark Brown <broonie@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 =?utf-8?q?Amadeusz_S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>, 
 Cezary Rojewski <cezary.rojewski@intel.com>, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, 
 Temitope obabi <obabitemitope765@gmail.com>
In-Reply-To: <20261110132013.732-1-obabitemitope765@gmail.com>
References: <20261110132013.732-1-obabitemitope765@gmail.com>
Subject: Re: [PATCH] ASoC: Intel: Remove unused sst_ipc_inbox_rdata
 tracepoint
Message-Id: <179487776546.3663701.11916478949345242482.b4-ty@b4>
Date: Tue, 17 Nov 2026 01:09:25 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1134; i=broonie@kernel.org;
 h=from:subject:message-id; bh=pS4d9hwLwMRABav02cA/zMMbVL1fMwxfjoHAT3PllU0=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLL+WN77c7By258qu+vLVjuqsH4vySxb9cRd58tHT8sin
 kNp/209O0pZGMS4GGTFFFnisrhf1pe8XsN3cGEbzBxWJpAhDFycAjCRf14M/0y87sQ/T1xs6Vl9
 8Bnvx7MnmzpNjZTn7LgoL7SqtPvOtYuMDG8FmhS26ejw/5EM3ci3/HeCx8276/wLWwJnbXzIWb4
 9gg8A
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 10 Nov 2026 15:20:07 +0200, Temitope obabi wrote:
> ASoC: Intel: Remove unused sst_ipc_inbox_rdata tracepoint

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.5

Thanks!

[1/1] ASoC: Intel: Remove unused sst_ipc_inbox_rdata tracepoint
      https://git.kernel.org/broonie/sound/c/c5afacef0c09

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

