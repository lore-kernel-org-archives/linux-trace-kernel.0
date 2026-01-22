Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48E22EFDBA;
	Thu, 22 Jan 2026 14:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769093501; cv=none; b=hTKmYadG468TQUODGoAZsXEbu1sEF67PvXregeQchUsUrpvqhIjqTC3PvYz4P+UGzu9xAZQs4bYdNfdlO6jA5ZfSxbmfWZuAt33hVe7EFHuqfZxyDwtNW/6NGvMQYhyQEctZ9MLPGvn029uPMG4fgH0SN+yaS5ckOiEoZyV8ocA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769093501; c=relaxed/simple;
	bh=9ujFaiUju1MYRxdUOoBFPKR+23jR2tkk25ZxB0IoamE=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LQCASuqhFyuw/40VkHGpcEtPA2dnkL499N6Hg7IclFSyyNgBUt9rk4Baf2zNeJ/TJfj1lZz+725aPYmHfDSBTEXveIpF2N0jPwkW9bjiuaxrH2p9e7v7ljInsp49NrgwqKsd/P9owRzsOHPgfLMcEIfGVRcKzaYWKgm8NISK7D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vKbg3vUu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EECC1A60; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vKbg3vUu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EECC1A60"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769093498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9ujFaiUju1MYRxdUOoBFPKR+23jR2tkk25ZxB0IoamE=;
	b=vKbg3vUucqRKcluf4hEm6DccbTkFTqJ9k3Hhqxl6VLyGOH6j5eMjvPJ6u9GemsRpcDRsrC
	9HdZBLbuAlXnW4zXLP9lsFbawGhKlGfYZ2wwhQF8juUme9Ys72iUSyq8rGZPDJEObTna3+
	PwQJViSaURI9ZFywcT2FwxlzRJGL5Aqi8HpNxtBFALMq/GIt7J4JF79vEwsP3vx2TfYs/X
	QZ9hG3fQ2BDfTO1veDc/YPlXwrNC4H+ivmaeT/mmB4SCeJk+Ko5M/cucwn8o1HUqHvdJl8
	LChaGlSO73778XQgAtti/WBpBh44cw6WGnC0cb1vlKMgChqF46zKw3/ieEo0lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769093498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9ujFaiUju1MYRxdUOoBFPKR+23jR2tkk25ZxB0IoamE=;
	b=EECC1A60nxu19mo9qwnk4MOB0fU3kqoZn4vhhSp7huLsCpMFAgmRPqSJr2nqPPw78FKFXT
	NjR7k3a9g8vHobCQ==
To: Wander Lairson Costa <wander@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>, Wander
 Lairson Costa <wander@redhat.com>, open list
 <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION (RV)"
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/26] rv/rvgen: simplify boolean comparison
In-Reply-To: <20260119205601.105821-9-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
 <20260119205601.105821-9-wander@redhat.com>
Date: Thu, 22 Jan 2026 15:51:37 +0100
Message-ID: <87v7gtitty.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Wander Lairson Costa <wander@redhat.com> writes:
> Replace explicit boolean comparison with truthiness test in the dot2c
> module. The previous implementation used the redundant pattern of
> comparing a boolean variable directly to False, which is not idiomatic
> Python and adds unnecessary verbosity to the code.
>
> Python's truthiness allows for more concise and readable boolean
> checks. The expression "if not first" is clearer and more Pythonic
> than "if first == False" while maintaining identical semantics. This
> pattern is preferred in PEP 8 and is the standard approach in the
> Python community.
>
> This change continues the ongoing code quality improvements to align
> the codebase with modern Python best practices.
>
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
