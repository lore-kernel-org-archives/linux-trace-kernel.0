Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562DF3CCFAA;
	Mon, 18 May 2026 08:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779093129; cv=none; b=bV0bDXIPEc9AmET7/DNfl/W8z/krwCTg9JZxZ1sLAnpUPmnOHvjcnaKGvuk4yNuaUPkek/M/fYDAhmHrhjIVkfNlpc8Ou+5fsa7oOe6oZRCEdEh6XlrwdkClB3Z0gtl5HI648MhL2KLmYRkOvAo3HOB26Y+BsBif1pWh8NQp2/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779093129; c=relaxed/simple;
	bh=mC2mXY9+tLi1VOYJc74q2RjmZdknaf5cTS4S9olSLQc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lwNOP6F2JeN4SuJ957EtHNKgeqswv7hZeewv49Hu4fZr54kNnGw1+/sWFSHiJtkSLfP8X98uxOAVMTWv3ocfWW+0xxnFXLAfxwy99jfsXrTAIncGsXpkcJyh0mjPOiVa5xW+Brmc16P8/NhCSaJW5qzyAxm2Ajbdy4gvF6Mjl4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KbpuhfTQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pk7gOUUZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KbpuhfTQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pk7gOUUZ"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779093126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=miyqozgZHG2XFEF/yOaE9ncDEcQ+puhgAwiCmhcfm9k=;
	b=KbpuhfTQupuNNJ6k+9gGQYCUnxllVjGRBxbZdvEdsVi9eNiKiFG56pXHU9OqTMn+/jAIMe
	Z8hSG49M22ItIoP1t1nHPiMstmvd/gTJAx/QpQdAdD3XfjTitwP2WVIeFUUXn17Uoy+7p3
	EHDZLnOJVaPRM+GG5s1mI9s81wofqxXhLabS22A4rHviW9wAYCkgv5NgPr5R6UzGosUFJr
	vHd4G4fZiiJ2PC2TjALfGrJSB2t6ectqHfw4SFpz5jfaEBfM3socn1u/e15F+t1nUD/JDg
	mmL2yl3yLb2AG8OKP2IRHw8lxPdbRCk+K2hSuDJRIQsa9ihDCXPPwemlQ/wEcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779093126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=miyqozgZHG2XFEF/yOaE9ncDEcQ+puhgAwiCmhcfm9k=;
	b=pk7gOUUZSgtCV7n3eB/Mwsh3Os7za1CIWtORaFCD263Wev0wszdAHsd5GboBFTMKeN5qqD
	e/8uPiIQkBz7FxBQ==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Gabriele Monaco <gmonaco@redhat.com>
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang
 <wen.yang@linux.dev>
Subject: Re: [PATCH v2 03/14] tools/rv: Fix exit status when monitor
 execution fails
In-Reply-To: <20260514152055.229162-4-gmonaco@redhat.com>
References: <20260514152055.229162-1-gmonaco@redhat.com>
 <20260514152055.229162-4-gmonaco@redhat.com>
Date: Mon, 18 May 2026 10:32:06 +0200
Message-ID: <874ik586ex.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> +	exit(run <= 0);

Probably better to stick to the C standard:

    exit(run > 0 ? EXIT_SUCCESS : EXIT_FAILURE)

but whatever.

Reviewed-by: Nam Cao <namcao@linutronix.de>
