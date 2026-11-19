Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795177138;
	b=Fvtn+/Dan5YeUMJw4Weua73Riza9Ju6inFP4P8dfJmT9G35iQx+xloAT0vD9zfN6f0wv
	 QxfnmCT9UoBfGdYjo8HLBLIC7o+UWAuxHl0oO14vx2nZ4yzkiB5+WZyfRl5sId5zrl0iT
	 lJqh2PBN0g5y2TuppQVKVCnm/O0h2zmw8GLgOKMYvFRJsFjrk89S/+5708F+1ggm3OQ7g
	 KJ8JiYTUjJoEbFhCmE5A+xgFRwN9As9N2RUpmO2l6qNhqsdDT6VQfhn2umtvgiuR7Eleu
	 cJx5rQmn+7BkqYnbPFevAxx6Mu8ZhCegCUocyXGu5z3Un0IzwlUfNyakrosqb2DcUtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795177138;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=mZEICrAhupddlgOdV5bn1RCsWtol68HHCTnzdH0gBfQ=;
	b=mtUVOfNXN15t6XLWeuUDrNr+SPXl/LAR/ymoBu4N/VGQegtFasShAY1Lg/r2BhDCeOZs
	 WNo2cM5L8YWQXqR7qIO04cZyJuM/Y2xxjLE8g9QzbIVnxVbNI/p2zafTL2iO4+dh6SNtJ
	 Im8xCsvCsPNuy0/5ZKJXJil26pbCpoNY2AwIV1F2En4lEPuONszadisj6Ki3DWb5yxWyH
	 m5eNx94xU3na367zZcQKAq/jEmAPKKa34sdjWvshCn2gFt7co1tWgno4D/1vi/Bni/2ZG
	 22t16X5Iig+t6K/5rJOX3vjT0apI/4x2rpF8T+f4aGkgHcG46I3mtl/cZ3h1R8+P2Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CmFWMpUp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D592606A32A;
	Fri, 20 Nov 2026 12:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CmFWMpUp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C1D1F000D1;
	Fri, 20 Nov 2026 12:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795177137;
	bh=mZEICrAhupddlgOdV5bn1RCsWtol68HHCTnzdH0gBfQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=CmFWMpUpuTu4QERkgn5sLzdq5O3pUdnrY7rYEooEpJEVX69q12zG4lhzKaYs/KkRl
	 mhOObrK8/6IrCk+VMbwMZER9uNXCtG5hsPeMJ2LAy0LyZUDZ3tzVPMGfYyFOjmftkf
	 nXlKVsvY6vF3ZxSs68V5pdCDJYWTNTTdFhIpjwhtq4FvCoPZgcsC2JoEyjX8lyduNk
	 RZPMsSgYNBF+kFu6ktD0E3HC/1v0unekOhA+yCqmcOniUtTkRCNYKZ+CuA4+gC2S/t
	 J53L4t9KkCt4E3iphZ7M+zgnVtz7NOZ7CQbm11FUTbJSjXAmHjdxDqmWV9TmFQa493
	 3GH7FBfXqHDCw==
From: Mark Brown <broonie@kernel.org>
To: Temitope obabi <obabitemitope765@gmail.com>
Cc: cezary.rojewski@intel.com, amadeuszx.slawinski@linux.intel.com, 
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
 linux-sound@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261117220558.2702-1-obabitemitope765@gmail.com>
References: <20261117220558.2702-1-obabitemitope765@gmail.com>
Subject: Re: [PATCH v3] ASoC: Intel: Remove unused intel-sst.h trace header
Message-Id: <179513023706.116416.8935403949115258253.b4-ty@b4>
Date: Thu, 19 Nov 2026 23:17:17 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1122; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Xc74yjRN7L91m2yL17CAgtOasZ8emRvBy+0bQIc/pts=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLIZrNZpOawwvaZYK/aKmavpgsnGr7HXq84vFxXZYZVuJ
 H70k395RykLgxgXg6yYIktcFvfL+pLXa/gOLmyDmcPKBDKEgYtTACbCNIORYQfrFP+1+i/WTAwy
 XJny67FD+av8K2t1pPvzjsp+Mloa9JeR4eelnMmMHOuXRL455rFHU817z6St5zbtsHKqqdBhL5J
 nZgYA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 18 Nov 2026 00:05:57 +0200, Temitope obabi wrote:
> ASoC: Intel: Remove unused intel-sst.h trace header

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.5

Thanks!

[1/1] ASoC: Intel: Remove unused intel-sst.h trace header
      https://git.kernel.org/broonie/sound/c/fdf2a24354c5

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

