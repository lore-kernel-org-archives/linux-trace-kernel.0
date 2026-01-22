Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1AF3624B9;
	Thu, 22 Jan 2026 14:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769093948; cv=none; b=fwGHDwExf+UCClqYyzCa8A9Qf4dC+oVpIz4AuYRoKCAB7k11NCHwupZ+EkBzpEJvl8JQ+4R/PLUKXgPAYhlOxZLJ9cDe7rwvi0LNW5RfFnKTzNcToxgxA6HTXTwtpkppIw8p6D1gtr+7+jtj65EvLwscSjgbSoTneH1B2KWH7VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769093948; c=relaxed/simple;
	bh=CGSQd174NJAOGoNDEp1CRz7FH324pgCO/96h+u4CFJo=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=scaSdfvYMIh4A7mRZ846m4OXzq7Ix5/UUhnKfOU+nY2XCBi+KKhEtPRqr068Fzq9foWCeLaZ/hvYeo9q8JZLuZ+HXArnQ/jPuuOBVSUKRkkcNW8MpCE+/MS8fdBXqiNebXnIZbcCq4+X88ItlTgnIWrKsF4zWQ0A2TUiwgHlt/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kqz5YWrw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1mRw02/4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kqz5YWrw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1mRw02/4"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769093945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CGSQd174NJAOGoNDEp1CRz7FH324pgCO/96h+u4CFJo=;
	b=Kqz5YWrwUp0o//z4h1dbLFAYnTSnIcQrTi64CFRmvczfT/gCzLtWVU3O3WVXemJ4/l1YJR
	nfCKpExLLVutDex6zGZ3udGu86QUHSKlv5alzCQF/dGzcre4KehlVfLWu+RrYquzR2DjVq
	6doW95svaUL31Tm9oOW4kLcejKIWF6NS5WdjnWEqHd07CBbSUPoM2WFiW01uZjNFgej5zM
	qE6vcpcGLj3vyzeP5i3ifqCtr+PGjA8nWl8XdlYFiMt9r8FxCdCl8mW4sxH8wOprEt6kp/
	RJ3hPDjIUnETNJerydDleY5B/L31jJCA1rX07m0Bfthzdm/zTvL5wStx2Eh+gQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769093945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CGSQd174NJAOGoNDEp1CRz7FH324pgCO/96h+u4CFJo=;
	b=1mRw02/4D8njJpm1Vl3oBFCHbJl1D+nTfqZChBds+5n3o1CZu134meVMFsMTbpUYNWilTZ
	6/1jVAXsNDy38RAA==
To: Wander Lairson Costa <wander@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>, Wander
 Lairson Costa <wander@redhat.com>, open list
 <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION (RV)"
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/26] rv/rvgen: fix typo in generator module docstring
In-Reply-To: <20260119205601.105821-12-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
 <20260119205601.105821-12-wander@redhat.com>
Date: Thu, 22 Jan 2026 15:59:04 +0100
Message-ID: <87ms25ithj.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Wander Lairson Costa <wander@redhat.com> writes:
> Fix typo in the module docstring: "Abtract" should be "Abstract".
>
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
