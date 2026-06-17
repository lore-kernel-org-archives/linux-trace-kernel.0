Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93F63D565F;
	Wed, 17 Jun 2026 09:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781690378; cv=none; b=gggDCk7XHXRuwrFUi8sm7Af7YvWDGL0jwY3Ko6BiHbWVUBuu9QQI6v9bVJ6Lrr0DigZF8tQlWQuL9omFJrm7+daWNNcwXPjfF/gxE9rBMEQeynQgClGKdmrBOZzJwb7Pez5PLF0TjJQ8dYcRDD7eyGYH+SL8y8DxGjA26Lo6oBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781690378; c=relaxed/simple;
	bh=Ib01VTzol3QMgAX81gh/MErKZARayMDu3lBRdtfRl98=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SjxGjoJnlLAAOsHtnyhZs63iIl3/FrlDpf0iggvEeCjBzQ1Feg92qmUvFlsD2zBSklex9Eu3cLFd6wD9ZOt3Ov1sdsYepyo1C1nXT+05KyrXksZs9hnbQXBGIKEfS+25IfdnIbjFsua9a/9T8Mb4xR9dNKwptYCwDW+TvhdeV3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bgSU23iG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xBlWSkkr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bgSU23iG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xBlWSkkr"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781690369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nB9DBe84//yy7w1SJ/RDU2h2bhihQL0ka2bmBGeew4I=;
	b=bgSU23iGLwagGasp17ibPTrk9UPAwGul7T4p25qKQ+JcPyTmw3oqK8Wzzyq+X4TEYMjtkh
	66sP/7BVwNYGZxyugUfNlANP+R1a1YL2CPuzhgxnrRuCyWsfGAIku/LhDJhVNp6SZK03Q6
	jCWz/H5xZiqpcu5PEnisARGxYiww8dN9MyEUCugy6xNov9/i5hHth3Ao1FwMg/NawFpj/V
	rsr2yyDhGLN+COifdNfAKMFDIHI064V551GozcHyeDLPsLPY2msTQgRjOmHBM9TlhSclDs
	SK2SCwNk/uJT+eJSuZ/CkzWJOh9xYiQJ8kLbD274LZyEuVNGrT8BG36mvMb59Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781690369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nB9DBe84//yy7w1SJ/RDU2h2bhihQL0ka2bmBGeew4I=;
	b=xBlWSkkrnDMaDCrvCfKQy8pZRNfFkegwZvewIZMb2im33pFRZKRhfAYWQaOHQ/bvN2pAPb
	apFx+0ytbcoUEzAg==
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Wander Lairson Costa
 <wander@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/13] verification/rvgen: Delete __parse_constraint()
In-Reply-To: <e3f63618b48dba9299c88bfffeae14b71717fa77.camel@redhat.com>
References: <cover.1780908661.git.namcao@linutronix.de>
 <8d9b9068a5dde8256edd7debe7aab33e15a7fc51.1780908661.git.namcao@linutronix.de>
 <e3f63618b48dba9299c88bfffeae14b71717fa77.camel@redhat.com>
Date: Wed, 17 Jun 2026 11:59:28 +0200
Message-ID: <87tsr1mqrj.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> This function used to validate things we are no longer validating, now it's
> alright to create a model where a clock is never reset, which doesn't fully
> make sense. Should we add that check somewhere else?

Theory does not require clock reset, right? This is not some sort of
hidden issue that trips up unsuspecting people. It is obvious from the
model that the clock is never reset. So I think it's fine to allow
people to do that, maybe there will be an actual useful model without
clock reset, you never know.

The self.env_types check is enforced by the grammar. We do lose the
self.env_types check, but that is likely redundant anyway because we
have this:

        for transition in self.transitions:
            [...]
            if transition.reset:
                envs.append(transition.reset.env)
                self.env_stored.add(transition.reset.env)

so it is clear that all envs that are reset do have a storage.

That said, I am fine with keeping these sanity checks, if you are
paranoid.

Nam
