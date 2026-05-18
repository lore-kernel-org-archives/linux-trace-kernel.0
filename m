Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7848327204;
	Mon, 18 May 2026 07:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779088903; cv=none; b=sYqeJjBdngLJWw9dB9i+nFUe04qEAaOpqFSkmkwQVGlWmyIuP5UWRcERNl93kW6UcBeTjfOMd761CIxvenJO4FgCKzwKP7gCem3avBCBsEWPWNauzu6FYhpW4sX97PraFq5x2lsr17SLDJLrczwBgrp2jg72aaCZa5ahwXWjLsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779088903; c=relaxed/simple;
	bh=ZONVDWa+TBdkNPRVRmoupfoFeubN3B/UhIwnUL6dnUw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jTvuPRDmIcd4nXA8veas9FWl6r61Yu9RfINv5GincVkOA8R2RKXwZHcVwWFYeexnJvPP2nqjN10QIIBTJLzVAIfBSJfNMei3ui3YisS1tl2gbBMA84GCq57EWGs9m7O5ZZRzXAd3LqoQyPjd7ozit3DOEIUU2PExE55N/FMiHJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SZ5lvLI7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j6YG4RgY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SZ5lvLI7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j6YG4RgY"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779088898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3ZEuF+EglygjocuJ1z+rJUTypPc3wvabDQo1NwgdqXQ=;
	b=SZ5lvLI7OmP8ytLw513E1P8uQ0ppKNuF1MT2CiKRinu/VNE+0yEpybBvwP9+wxzCdsMfxo
	2GY4YsBh18RiJwDRENB7QcXacMCegAItNja8HG+G2Ix1xcxhvuRQMTcg/cjUn3jJXSPTbz
	SaysHa+i6OG9sY8h9X9tuoMC4odySBKTqBD6Mp3aYzHmUuczWMXhFl4FnvtgkSZjelGZne
	UPwlyTcbYloJb8y2SBWDx8VZZ5MttrQ38yANSyJ7Olqu83RmWwPrZRnasMGibofRHihXVQ
	+MhxkijToFVCndPMc6HtBABd95exdcNm9HAMsBC7UUeuPvMCxsZJAlz6aDLmSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779088898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3ZEuF+EglygjocuJ1z+rJUTypPc3wvabDQo1NwgdqXQ=;
	b=j6YG4RgYG/CrRIKznN9LXw50Hm4LuhbOV4gZ9SIktdQyqWUPPpFbjPfOe3OwUHxjDu5H5o
	BheR/KrdtliJCkAA==
To: Wander Lairson Costa <wander@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/13] verification/rvgen: Convert
 __fill_verify_guards_func() to Lark
In-Reply-To: <agd1Tb8RDUqfjaGn@wcosta-defaultstring.rmtbr.csb>
References: <cover.1777962130.git.namcao@linutronix.de>
 <e8a636c8ea6da554fd51b1241b9181f65af420c8.1777962130.git.namcao@linutronix.de>
 <agd1Tb8RDUqfjaGn@wcosta-defaultstring.rmtbr.csb>
Date: Mon, 18 May 2026 09:21:37 +0200
Message-ID: <87jyt189oe.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Wander Lairson Costa <wander@redhat.com> writes:
>> +        if not self.has_guard:
>> +            return
>
> The signature of function says this function return a list, instead of
> None.

Can you share the tools you are using to catch these? Or did you notice
that yourself?

Nam
