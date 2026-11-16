Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794848045;
	b=gctVhryo0FP04x1diPhyNuMLU2HOYbhbhurE6K2hpFQr2G7eMrI+pV31B2QTXwoDNJpL
	 wclxogJ2dgbUZ+UWVbTgxusKCr2bg6ZahQBMQOASe9prPeP8pjUxrd4VmPCzx3CxauxVR
	 UWEF+KhTWCJokrtBzeonAT9nr4j8ad3rKS6vQ6a/EVKYsr95vZn3KPfhvJzLFzNXn1f7N
	 uihlU3SCz/5b+6tYCqlR+mGI5pZ1Hhq6h6L9uoKtFmxIvSnyxe+CvS9bxYsPZ5UnWwP/s
	 3/CSJjR5kkHwd7dSSzYGF8PyO36VY6TEF2yGy7i8RSnXZh6J4M6njbVovkK5Xkr6Mbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794848045;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=S3bxneiWF925sHRWuhmHNR2GbqcJSpHqdoFk1dfbgNk=;
	b=tCjXM56LF1VHtQZ6gqHoJX6WiZhwJqVxnHXNZ8qDyeYc2y0FW+fV3oMJR4X9TGMQAvfk
	 /X3R1N3v66TnzdvE7YKy1bABmpLAcuLQXDJeMm/HuzivzF3PUSqr/jxpPLxmVg475p4hq
	 i2wcY7XewRgJQ20tzGEI3kb8SUXTzvxUd9BqkEbgxmpABaHmfmKXfaJD4N5mey6mOEdaN
	 fPZ2UMcAULGV3MO0JsFhyCXVJnsShqQaaYBAeI8zXbBKVD+AR2pAezF2zYaCxZcUJE6An
	 rO9QoLhxTzWzk+eJVLE9JHMc7mepaCdaCcbt554Opp5JAJnFixe3C34Rt4DgK7l+7DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pablofraile.net;
	spf=pass smtp.mailfrom=pablofraile.net;
	dkim=pass header.d=pablofraile.net header.i=@pablofraile.net header.a=rsa-sha256 header.s=MBO0001 header.b=QpBEdrTo;
	arc=none smtp.remote-ip=80.241.56.171
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122CD606A31C
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Nov 2026 16:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 122CD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pablofraile.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pablofraile.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pablofraile.net header.i=@pablofraile.net header.a=rsa-sha256 header.s=MBO0001 header.b=QpBEdrTo
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jSv8S1kT6zMlkh;
	Mon, 16 Nov 2026 17:54:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pablofraile.net;
	s=MBO0001; t=1794848040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S3bxneiWF925sHRWuhmHNR2GbqcJSpHqdoFk1dfbgNk=;
	b=QpBEdrToFOfl8yju8CirB4ZkETT4dw5APekHI/hflqRyCmjBxERXDdGZhNTE0IueDZl5Sa
	QLkNINVXi4fL1IPTsuJWt38Hf4XLqrmOPab1MN0r3TUbkwms6zzrXrp0MeWrobjK0xK2bH
	soZI7RSL0bS2cDJfGqp/KsK9obDP7cIFja4SadsCE9ngfA/dtjRenuNRPZ/s9ywJaIFjpX
	biv4/2N70URinIbw2J/qM3Mi3P1b2E8uH6hHvfA00MMt7rbqhS0fkcjQ4Q/1rhPTp9SYVv
	0677LUxOLqgth/kBEeEt9pMBilm3eWHw55XuZ8sLmH6t8WufJhhw/q8QGuH4nQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of pablo@pablofraile.net designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=pablo@pablofraile.net
Message-ID: <83290e65-131e-4aea-ba79-e1453445e872@pablofraile.net>
Date: Mon, 16 Nov 2026 17:53:58 +0100
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] uprobes/x86: Fix bypass of two-byte opcode validation
Content-Language: en-US
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org
References: <20261116-x86-uprobes-two-byte-opcode-v1-1-2b6dbabead52@pablofraile.net>
 <sashiko-outbox-217334@kernel.org>
From: Pablo Fraile Alonso <pablo@pablofraile.net>
In-Reply-To: <sashiko-outbox-217334@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4jSv8S1kT6zMlkh


On 11/16/26 17:01, sashiko-bot@kernel.org wrote:
> map-1 opcode against good_insns_64 (map 0) instead of good_2byte_insns,

I checked the parent revision and confirmed that the reported REX2 behavior already exists before this patch.

Previously, REX2 map-1 instructions also reached the first OPCODE1(insn) lookup against good_insns_64. The in-place opcode modification in insn_is_nop() is likewise pre-existing and unchanged. Consequently, the examples described here have the same acceptance/rejection results before and after this patch.

This patch specifically addresses the validation bypass for legacy 0x0f-escaped instructions. It leaves REX2 handling unresolved, and I can make that limitation explicit in the commit message.

I agree that prefixed encodings need separate attention. I was already planning a patch for some VEX/EVEX handling issues.

