Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623632DE6F1;
	Thu,  2 Apr 2026 13:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775137058; cv=none; b=VzTOPWvAfoyjRaOG+qtcQrFFrhTkBJ17HIbGfhWS/MgM/2vAp8ip7FEByBXj1SCXl+D1y4J5mAiLYYK6IQAo7MKrca7GrU08dLr9FVJziUWk9UkYSUnY+ZlvQuq7maouQhH8nwPmCKwez6G4xjWe/l1032U3YFwbQlWtNGMXOkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775137058; c=relaxed/simple;
	bh=kO/csKsIYF5hmMQIEKr1I9a2+/eQ8eObsrQ15zufFEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W+kfprAj33tsebrAaGPxgzMvewpX6TQzXpzMXswR7ud13zJEkR/aIEFPCbClCCm+CjRBagehL3KrYVy8w/iRqmmqzt9EGH2CA+p3wRrd6g3ugtHziQLFuqDFV+ICa4DYSWU6oMyX/aoObifVeqN6mvbsWg5PLB3Nv+NmVQKH/B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEhoDk2w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEhoDk2w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC1BC116C6;
	Thu,  2 Apr 2026 13:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775137058;
	bh=kO/csKsIYF5hmMQIEKr1I9a2+/eQ8eObsrQ15zufFEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jEhoDk2whQa2i9wITkDYvWZk9Ysr2cVNqL7kEDI98rWo7+3F1/5bDXYLNlPM8G40D
	 xnQ0P+ahDRyqFjf4HNOdlDv2M5OutrUNfMIzOTS3+HJByv0ZVxA54sQ4JHkRpP6qx3
	 zowHoqepSn8O2uSXq1gS92NC8eyo4cmm8L5IOkExrS8olb4EOy9t4leo4pgJhGWrKA
	 e63Q8vpibJQcGHNzsF2ICvMu75DGE6FaWM4WjlFKAA1x5LBdar3g1TKK4GL4C6SPxH
	 0/2+KqhDVGhXXkj06QoPGqi4c+2wFrSF2nqCsM12OgYbTA/gBfqjcCIMznUJ3vAFQt
	 0XxmU+qCkH85g==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1w8IEp-00000008H3A-2poD;
	Thu, 02 Apr 2026 13:37:35 +0000
From: Marc Zyngier <maz@kernel.org>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	Vincent Donnefort <vdonnefort@google.com>
Cc: kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Fix trace remotes read with an offline CPU
Date: Thu,  2 Apr 2026 14:37:32 +0100
Message-ID: <177513705028.453830.17768849375022719391.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260401045100.3394299-1-vdonnefort@google.com>
References: <20260401045100.3394299-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org, vdonnefort@google.com, kernel-team@android.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Wed, 01 Apr 2026 05:50:58 +0100, Vincent Donnefort wrote:
> This small series is fixing non-consuming read of a trace remote when the
> trace_buffer is created after a CPU is offline.
> 
> It also extends hotplug testing coverage to include this test case.
> 
> I have based this series on top of kvmarm/next which contains the hypervisor
> tracing patches.
> 
> [...]

Applied to next, thanks!

[1/2] tracing: Non-consuming read for trace remotes with an offline CPU
      commit: ce47b798ed1e44a6ae2c2966cdf7cba6b428083e
[2/2] tracing: selftests: Extend hotplug testing for trace remotes
      commit: ec07906bdc52848bd7dc93d1d44e642dcdc7a15a

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


