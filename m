Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2296118A943;
	Tue,  7 Jan 2025 17:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269972; cv=none; b=Z8M7jQOzejpiqPghU0QkRCfONxIX7uDqoMSdILWD82GRjypCl2b3VoLwEY9fko9Qj7phbA9NgQ68vceqV1PLpkd1Xw4rL3+6GRGK6Gr2FjZ3HZuXtE9296edkjcICYXYumsfV/ra1vwCLOxz2l0XR/E4Qo99VS4ko5RGuXWgKMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269972; c=relaxed/simple;
	bh=XT3uWSyIyKjlrTiSLLqRYxSd8tnvnMF2POEYJodfnP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOlpnMicKirSc9n4Y/qhpVd5A2IyUL0I2ssAo4pbUdHvT5eBQSiXuHptk87RqJJU2Ztmu9O4ekLJx1wXmAYMY0hq3Bh22H9QvtUOZsgrCeg2d7fAcUAQm9sR+R6CpNVRWYPM323h6Q0J0r+2rMIeC4B4qVBErY1REcVbV7zjEeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cVwsuPzv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iCw7LlWz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cVwsuPzv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iCw7LlWz"
Date: Tue, 7 Jan 2025 18:12:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736269969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xsNnuziyNpOSTD/Cp5DOy3MZvA294grDpf4nsHeVMI8=;
	b=cVwsuPzvQdzTTAe1TW+BTAPiBZBoJMFjGOGfIiWa03zhooCI8x24/wt1uMkD0QgB9ukpTG
	+2e0rf3abqxIEQ99upY3h/tKbltUJUI0bXC9nYkNJCF/CvT9PcPhoFRlBAOLHkt1tES55a
	2Q8ceuvzqrsmHDAPNg8yDyP5Ql3P2UldS+favGeozrm9DIzQjuu9Kq9DOXooZyty3rN1Ok
	ssXhOE0c4EWMFr7ivQwjfFywAChHMJN+veryrT9i4Wm4fMQYIZb7dK2XJCAdG3SU1EmydP
	yYj+P3srQNhI0MT8QF5taD+uG71M/TE3IF0pWW0P8HTpK9ttJNi5HRXMu1BhuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736269969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xsNnuziyNpOSTD/Cp5DOy3MZvA294grDpf4nsHeVMI8=;
	b=iCw7LlWzWbcnA2qYMjWzFfhpgv8rVYQHF67jKKd3znR4ykiP9hkcG0sOr02Wv55uQR2HFA
	E5zfxsCrV3EF//CQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Gomez <da.gomez@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, linux-trace-kernel@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: Re: [PATCH v2 19/28] LoongArch: ftrace: Use RCU in all users of
 __module_text_address().
Message-ID: <20250107171247.gzibqLkQ@linutronix.de>
References: <20241220174731.514432-1-bigeasy@linutronix.de>
 <20241220174731.514432-20-bigeasy@linutronix.de>
 <20241227121946.1643decf@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241227121946.1643decf@gandalf.local.home>

On 2024-12-27 12:19:46 [-0500], Steven Rostedt wrote:
=E2=80=A6
> Is easier to understand than:
>=20
> 	if (!mod) {
> 		guard(rcu)();
> 		mod =3D __module_text_address(pc);
> 	}
>=20
> Because it makes me wonder, why use a guard() for a one liner?

Why not? The context ends immediately after.

> But, when I saw your other patch, if we had:
>=20
> 	if (!mod) {
> 		scoped_guard(rcu)()
> 			mod =3D __module_text_address(pc);
> 	}

Okay, if this looks better, let me update it. It just you already have a
scope (the {} after the if) and then we start yet another block. But if
this looks better so be it.

> To me, hat looks much better than the guard() as it is obvious to what the
> code is protecting. Even though, I still prefer the explicit, lock/unlock.
> Maybe, just because I'm more used to it.

I'm probably also used to the explicit part but numerous people said to
use this from now on. And it results in less lines and you don't have to
worry about each return statement. So it somehow looks/ feels line an
upgrade.

> IMHO, guard() is for complex functions that are error prone. A single line
> is not something that is error prone (unless you don't match the lock and
> unlock properly, but that's pretty obvious when that happens).

True but this is now a one liner which might be extended later on. Also
the context is one line.

> But this is just my own opinion.
>=20
> -- Steve

Sebastian
