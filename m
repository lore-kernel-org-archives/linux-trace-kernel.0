Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3093A3D410A;
	Fri, 22 May 2026 10:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779445297; cv=none; b=okp/BwNteSJXDzZ7cHWo85nJV/Dw3ggLbGjxmt7iyOLHvYs7zmex4k/eMsDS27uZfZCDjZWt6WWXKR21vdbLa/3HS3ZKYv6LzqU15h+RVhA3Alng9xWtod6G7wAEBOpQz8E1KHaUsQ0XMkZYFHLy4AV2FuK6D2Thq+Ilz7w7Clk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779445297; c=relaxed/simple;
	bh=9GtPfAC/7X0StcDinTriwrJOIHC98Sl4258lsNRLwmk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=C4F363TbNAgQP+Z9cAha3AozTPwHNpMEjITUa/U69/7uVVJEb8gkynwm5kMMYsdrVUNh/eE2cf1KiNMayq6I5Hfezl4BlXCtHnFkoANGJdPbozoSKfD+Iqhv2/oJi4y9mQg+VY0sjymZ3GG/FlG/l1DPbDcq9X937c8I8Fi2Gug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LbaBGZvC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LbaBGZvC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A4B1F000E9;
	Fri, 22 May 2026 10:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779445294;
	bh=RCKk3G/fG9xNHQtopQgosGS3JYiX2OLPFhfHBrbqUdc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=LbaBGZvCeaADuRERmjoD9QTmzzOLrZsfhniBoeeEut0XLLXoA15muHYKFbqma4txb
	 JH4qTMZbgIk36XHb82fvL0I5s7MAHqYEfnBbikUr1NwmFtGTHMJhx8xEv7owt+UvAH
	 ItquTogvlO/dzeZN0/DrmT4owf8tCCiHcBUCFuYSkBVaqQnyn1gjRjIPDVaF5nzqKH
	 eSU1mvViloUzt9YGFTx/pjSIRji24gP4K1Hdh5V+CsqhIqQSrcqmjZqpzDdGCPJG4D
	 ZgvSxEx7nj/G1RD0gRFnfzGNQRyskaESIgtfcrV1lXYYBmOz3z7uI6NEueoQ58FmzN
	 4HOQhgeXIkavA==
From: Mark Brown <broonie@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, 
 mukesh.savaliya@oss.qualcomm.com, aniket.randive@oss.qualcomm.com, 
 chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260518-add-tracepoints-for-qcom-geni-spi-v3-0-7928f6810a79@oss.qualcomm.com>
References: <20260518-add-tracepoints-for-qcom-geni-spi-v3-0-7928f6810a79@oss.qualcomm.com>
Subject: Re: [PATCH v3 0/2] Add trace events for Qualcomm GENI SPI drivers
Message-Id: <177919638255.6167.12994176787031885000.b4-ty@b4>
Date: Tue, 19 May 2026 14:13:02 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1546; i=broonie@kernel.org;
 h=from:subject:message-id; bh=9GtPfAC/7X0StcDinTriwrJOIHC98Sl4258lsNRLwmk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqEC4qFF7/ZgXzkEqdBZ2lH9wYy8JTYhh4d6Igc
 xgr9PVds4mJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCahAuKgAKCRAk1otyXVSH
 0BQ5B/9EdM+6O9YI0UCKxggIRj44WraRmiJtCjfQo6oAOVPeWbkbrpAV4XH+ngWlu4BvxVYWVdf
 0rQzEjwQoqrRII5XKAb1E+NNBCpPTcV4zGGGHRlxUsuSLtCuW62kcPxRZ6XGcGjZFqOB3ehWP7k
 OmWS8e15M0D8Yb3vghx3qbQ5Jg03kzAjCAhag/F1lmEKsjb/UyV9x0wMeIZkxJZ4UuVpd/ZwzS5
 VOwD6pPB6TzEQkthl+s8ZaSC4rTzoFLMSC42b/xvYTGwkIxMhQsmxTrBfqXRbU7jbcJmrshAo3G
 DIVGxh9PjCGXfcOxDe6s58wXrkuGgUfePhf9abSFzTrnCpJA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 18 May 2026 22:30:50 +0530, Praveen Talari wrote:
> Add trace events for Qualcomm GENI SPI drivers
> 
> Add tracepoints to the Qualcomm GENI (Generic Interface) SPI driver.
> These trace events enable runtime debugging and performance analysis
> of SPI operations.
> 
> The trace events capture SPI clock configuration, setup parameters,
> transfer details, interrupt status.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/2] spi: qcom-geni: trace: Add trace events for Qualcomm GENI SPI
      https://git.kernel.org/broonie/spi/c/bf62d130b1f2
[2/2] spi: qcom-geni: Add trace events for Qualcomm GENI SPI driver
      https://git.kernel.org/broonie/spi/c/b5687af4af89

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

