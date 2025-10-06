Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B0027F727;
	Mon,  6 Oct 2025 13:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759756866; cv=none; b=DkvN7lbOlFMHBcOdQir5jYBfNcL9jSnxcHW4MS1cNK79CH3W5UjyZpQp01bJLCACHCGA6KqDeYMtjDNU0SFA44dkVafS+Oa35UxAgM4HTUiFLNRwZa8AO+4HJMF3me2giTGnBEJYs8tplQYNbZiRPrst+CKexml3VFJt5RH8Y84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759756866; c=relaxed/simple;
	bh=4EfBJirwXmHS9bKxnVpvP65VK3V8Y05OM0scvwvBAw4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pg7dTbSstx4upt6VcrX8oDwzBrjwiwwws32X7wccAhvaRg94FpLJ7KPVC9h5uGM/+e24sGwbB18JPjH+LnVOv2u+Xk2hc4NMdrjRlaQ+MxP7fEmYkgauKsov1C0nU7LNJE25/Ou83QQtbhnYrjTjZ+jMLEokeFbs6Gi9gjlJKp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WDSRahFl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i4a1m1JS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WDSRahFl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i4a1m1JS"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759756861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TPC7moutDPDkHYlcUYs2BarEbILZKiCmd0pMpjL2jac=;
	b=WDSRahFlku0Xyd0XNGlbkxHS4Lts0OFDAXPa6xi9Na2ebGzqLAjtqeXYULkrlaPJ+bHkLC
	K5Yb8Mav/VWPDclJlLYsXsJwx5SahmCYCSBsM6JAzfj/BSSjODvRBYDvdGJ9v5M9l4DLEY
	1CynoDFJwwpHS54dY7syUOb89BDZJ2nIuJ9ZavXO5UmD+v2M/awqcXHE1OBy9RHRnWRo3o
	Rtt5HaLLu7uTE477C/bJn4TlTnWrlW+x4B+lp3sk1lszHRUU58wl85RG6bTT3i4YZZRDiQ
	VRFUcvDN5JFATEFr9Zt/4R/OdFt5USGMLQK1xlmbpbU4+F8poRhf3/UXNy7Q4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759756861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TPC7moutDPDkHYlcUYs2BarEbILZKiCmd0pMpjL2jac=;
	b=i4a1m1JSUHEWvPwtw+Y5uRCx28PGwuFqoN6CmXYvRoTw/X2oD0R8iMzNVloPJIXfUc2peJ
	QtsuhKxWArvgYMDQ==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v2 11/20] verification/rvgen: Allow spaces in and events
 strings
In-Reply-To: <b2eccf79b5ab2b0d4b2f02e048938e923aa6e619.camel@redhat.com>
References: <20250919140954.104920-1-gmonaco@redhat.com>
 <20250919140954.104920-12-gmonaco@redhat.com> <87v7kxr2fr.fsf@yellow.woof>
 <b2eccf79b5ab2b0d4b2f02e048938e923aa6e619.camel@redhat.com>
Date: Mon, 06 Oct 2025 15:20:59 +0200
Message-ID: <87plb0jhdw.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> On Thu, 2025-10-02 at 13:03 +0200, Nam Cao wrote:
>> Gabriele Monaco <gmonaco@redhat.com> writes:
>> 
>> > Currently the automata parser assumes event strings don't have any
>> > space, this stands true for event names, but can be a wrong assumption
>> > if we want to store other information in the event strings (e.g.
>> > constraints for hybrid automata).
>> > 
>> > Adapt the parser logic to allow spaces in the event strings.
>> 
>> I probably misunderstand something, but isn't the description
>> misleading? After reading this description, I expect the patch to ignore
>> spaces or something similar. But from my understanding, the script only
>> allowed a single event, and this patch allows conditions as well.
>
> The script allows multiple events, all separated by \n, strictly speaking there
> is nothing saying spaces are not allowed in event names, but the parser breaks
> if there's any space.
>
> This patch allows spaces in event names, conditions (separated by a ; ) are not
> supported yet.
>
>> Shouldn't this be squashed to the next patch?
>
> I kept it separated to avoid pushing too many changes in the next one, which
> mostly adds new functionality (and lines) instead of changing the current ones.
>
> Apparently that didn't make it any clearer, and there isn't really any use case
> needing event names with spaces, so if it looks cleaner to you I can just squash
> it.

Nah, you can keep it. I was just confused. Now I looked again, it starts
to make sense.

Reviewed-by: Nam Cao <namcao@linutronix.de>

I am thinking about converting the entire thing to be ply-based (after
we are done with this series). It should make things easier to
follow. Would you object that?

Nam

