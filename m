Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8AB212FA0;
	Thu,  6 Feb 2025 08:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738832249; cv=none; b=AJJI0ggKaZAprGPOUkc3bxt/k5cO4lxnhLnWL8njaOB8i2VPiHEJ5qGgDMiITiShxL4F2BHc3fBcQpjF5JVnuZmfbYwiU8fZDU/2D0cZh98EejuqWsnTwSf1V0gI8wAuoG+6Rls7kDBpTesu/KCUDXLwAuj+MbdOlD8P4MChIwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738832249; c=relaxed/simple;
	bh=Trr3tnawFCNrkfUYK6OCid+AOPlnxTwqxq7z/9E5Z4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tREyonJoMQVmCPV2pJYtkNVUTgWxcSDidGb3fHYFSp459kT9pY43PQQ0LZAn22BDPrOxlpSaJWDur4Qel75d7BkaL/KIwrbEHA/WGoRnV2wiNkmNEDh+GCeDRT9wrIY7ulyTUjI8/3zLx0OzsUO0tJxW8n33EcRUe0oP2KSRDYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=o8GNpEVn; arc=none smtp.client-ip=178.154.239.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="o8GNpEVn"
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net [IPv6:2a02:6b8:c10:4a4:0:640:7b31:0])
	by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 5FB4160BC6;
	Thu,  6 Feb 2025 11:57:20 +0300 (MSK)
Received: from kniv-nix.yandex-team.ru (unknown [2a02:6b8:b081:1229::1:1a])
	by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 4vhSse3IeeA0-ixJIQ1pH;
	Thu, 06 Feb 2025 11:57:19 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1738832239;
	bh=Trr3tnawFCNrkfUYK6OCid+AOPlnxTwqxq7z/9E5Z4w=;
	h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=o8GNpEVnmdi0N7LHhZpvhbLdgLlRAOxRhnZ1YlsIRShYL7HRFBKe8LP67EffLMiwn
	 V3BsUVfUBKkp6Xbdeo7Z9WIKJWPn3FlYU0Q5on/yb2hRNOh9ozxBXOgU8fXDPsdSXL
	 VSHc7WPRwVssK+aB7eLJT+S6FarEYFR84LtRvk+U=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Nikolay Kuratov <kniv@yandex-team.ru>
To: linux-kernel@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org,
	Wen Yang <wenyang@linux.alibaba.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	kniv@yandex-team.ru
Subject: Re: [PATCH] ftrace: Avoid potential division by zero in function_stat_show()
Date: Thu,  6 Feb 2025 11:57:04 +0300
Message-Id: <20250206085704.1561454-1-kniv@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205095021.15771b88@gandalf.local.home>
References: <20250205095021.15771b88@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I would suggest just fixing zerodiv for now because IMO the patch
fixing overflows properly on stddev path may or may not use macroconstants
at all. Also ns^2 overflow will always happen first. I don't know in advance
how this patch will look at the end and even not sure it's viable.
Steps to consider:
0) Infer some assumptions from the rest of tracing code like `nanoseconds
are stored in unsigned long, so on 32-bit machine function should not
execute more than ~ 2 s anyway`
1) unsigned long -> u64 conversion
2) ns^2 -> us^2 if possible, inevitable precision loss (how much?)
3) Compute stddev using some numerical trick. Now comment about Welford's
method is a bit misleading because its a plain variance formula. But maybe
it's a hint that we should convert to that method and problems are gone? ;)

I'll send the patch fixing zero division and simplifying code a bit as a
follow-up. It's up to you to choose what to apply. I'm Ok with any patch
fixing zerodiv and will look into overflow problem.

Again, thank you very much for the review and your time.
