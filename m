Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE86400DFD;
	Tue, 19 May 2026 15:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779204253; cv=none; b=f1DAoVAzzO9mbUwRhm0oKUABs3Co1fWhILFasgWPbQXk9GgIpBd/AAP9F/jwtdKS4r6VGFQFCDdGCMuBBCHd23wCH3LuX86Wz4kRG5rrlODdaNHzLsh42DXSMzqnJwOJJ7qu25TZMnmpNZEjr/7z06jiISWbp9EPgkLak8hcmUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779204253; c=relaxed/simple;
	bh=dGBUs93hSDXZah+oK/H6iBWxZcZqTMWvsGGZcFSNp+s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T5EXRS4dDwnQag/jzhIy+mkhH3JnRO28Fn77xAhn/t4bGR5avfMiBceOSEdPBoF2Yb6aBZadmhMaSQmXmrVmUGL3E8Ed9krDm1i6G1tFclqTsiRU9FtLuXv4dzYOp+k5/x9UF1ycomoxTymaY1nxbLJKitD44WrE9zxH27D6VDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kKikZ1Hw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+hi/xntF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kKikZ1Hw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+hi/xntF"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779204250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dGBUs93hSDXZah+oK/H6iBWxZcZqTMWvsGGZcFSNp+s=;
	b=kKikZ1HwwDqi40FNhsLYEPqzOx/bgG4ujomUJN+G4dYtDzEe6zNYZW5AND37w4Hmf4Jy6L
	zFeh6m9bAkuooPvpneDZmPR5K9PV6TPbxDlcg9f4eiQXT6pIb1VRdlXp9MSuVbM+2XY7CC
	b22m3XLqWlsGWPBhRR5i3UHHlXZ7dGYnGkdy9aOmCB33Dmqy6cE1oTinIdHiBUS8/FfkC0
	Ksp1FspNFWx3aMWYcQtIJg7V4S3hRAs7pm+gDb74Ln9myoCFIH/nH37O/3pZocSeVNPryN
	g6jsxLaKD8+9CZuszKFkvwLyR1IcGRv3lPlDl8lJM9gTGZKU6JNtaTzc7anpug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779204250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dGBUs93hSDXZah+oK/H6iBWxZcZqTMWvsGGZcFSNp+s=;
	b=+hi/xntFrdkQTpWUVQOiyROtmpeFkcotl/xh9amVWf3TpEKTt0S1mBQYDDum3e+l/O0u0b
	EwyaUbawkKp314Cw==
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rv/rtapp/sleep: Make the error more informative for
 user
In-Reply-To: <19cffa1267c6538e6310b0149b0367807af76ac0.camel@redhat.com>
References: <cover.1779176466.git.namcao@linutronix.de>
 <14242f444f7d2396c0c5a345f0099665d09a0ec5.1779176466.git.namcao@linutronix.de>
 <19cffa1267c6538e6310b0149b0367807af76ac0.camel@redhat.com>
Date: Tue, 19 May 2026 17:24:10 +0200
Message-ID: <87y0hf2zj9.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> On Tue, 2026-05-19 at 09:49 +0200, Nam Cao wrote:
>> The rtapp/sleep monitor detects real-time tasks which go to sleep in an
>> real-time-unsafe manner. If this happen, the monitor triggers a trace event
>> in the sched_wakeup tracepoint's handler.
>
> Ok so here WAKE is no longer tied to the wakeup event but to the end of the task
> switch.
>
> So what happens if a task was not sleeping but just got preempted? Wouldn't that
> trigger WAKE (though that isn't a real wakeup) without RT_FRIENDLY_WAKE ?

The monitor's rule says that when a task sleeps, it will not wake
without rt-friendly wake. If it "wakes" without initial sleep, it is
simply ignored.

I can change the name to be SCHEDULE_IN or something like that to make
it clearer.

Nam
