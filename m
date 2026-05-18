Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9FD3A9D86;
	Mon, 18 May 2026 07:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779088795; cv=none; b=Ya2JzmNpbS/twst1VeTU8/HuduT2w/qb2MkxCdx1+xtXbudI6cJZg+UA4+q/zXFviHqxSGaXFuOsYtMpmga6Fbe8ekp88Oc/w1C0NPraiZAEaB7SK1h4cz/JLEsOuO7Y7ex9eQkHhnNOx6/89nD/RKEjRUioKOYoTZN+MgNT4WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779088795; c=relaxed/simple;
	bh=XVp0FYIUqXg3Y2lYWWzUMup4mUpVEr/4Yj/JsjV7zq4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PzXa8zD8IsId4GZFgUpK/uewQS+NyKpAmlh18di3cz6xAUivrKgJpLG+6tiKCSjh1rkyiT8gDajDCF566SZ5Bl0LNoRmhwS9HAQElgclJi09dmmRm4EuMQdg2T1xfpW3RV/oAMe1YzpYGbV3UiFcYvNmGmG/POM1E0TCTlGjamI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=seXoUbhr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IgUk0OAK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="seXoUbhr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IgUk0OAK"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779088790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fJKT6D/8qq6AHPCzXaOrvOumkd3p3G2p9elZEx6k/Ik=;
	b=seXoUbhrXv7MrAfBp0HxhIm5OMTdEQdjLgTgum0/xAQlcqRRf8GWxW4sEbnF0hCgp3uTnY
	bilnrT8wLIiXuAsh+vhw3V4+cq3wfT2aXO5tZ90by1NS4nXH2rxafawSu/zshkKWaMCPRs
	+Pb9FWqdeLt1epS5efHW389Ufr0NPe+MKaveKVPmPeXFFOFYDGNyS3rPA8q5b+OZdo/0+P
	vFns0c37uCRVPijjXksjw+KcWSgeCwQXcfI2JyDEp7AxXQOvd1z90tXs7A0EhkSU3nDPDC
	sluVWmz0luRDkYdmqzH4rhQ5DmqbtwL6pn2/SIHF6QP2D5pYzr+mIt3sc/2dTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779088790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fJKT6D/8qq6AHPCzXaOrvOumkd3p3G2p9elZEx6k/Ik=;
	b=IgUk0OAK8K/xG517x3BRmmbPPT7+v/rcDqlXqDXCQ7H/EtlbZibrAdxiMM7aCTdqUEhylS
	eJjn3D8u+Y1Zm9Ag==
To: Wander Lairson Costa <wander@redhat.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/13] verification/rvgen: Implement state and
 transition parser based on Lark
In-Reply-To: <agdtxdk-JSyGLZ6o@wcosta-defaultstring.rmtbr.csb>
References: <cover.1777962130.git.namcao@linutronix.de>
 <361efb610ba7c06b3668a953a6847ea80453c2e3.1777962130.git.namcao@linutronix.de>
 <agdtxdk-JSyGLZ6o@wcosta-defaultstring.rmtbr.csb>
Date: Mon, 18 May 2026 09:19:49 +0200
Message-ID: <87mrxx89re.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Wander Lairson Costa <wander@redhat.com> writes:
> On Tue, May 05, 2026 at 08:59:24AM +0200, Nam Cao wrote:
>> +        self.rules = [[c, None]]
>
> Here self.rules is a list of lists...
>
>> +
>> +    def chain(self, op: str, c: ConstraintCondition):
>> +        self.rules[-1][1] = op
>> +        self.rules.append((c, None))
>
> ... but here it is a list of tuples.

Thanks. I will switch it entirely to list of tuples.

Nam
