Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E120318149;
	Wed, 26 Nov 2025 08:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764146192; cv=none; b=kKfejVq/EUS9keHnDvOf5sDVlDUK28vIgd7uzWYqRNxEamoHgZVtY7i5FvQhUfKACxIiCK3k8vHumYakanVn0krnafAwIQ1SHOrAzNJkIaiLPQYsnUSgeXCGlGaGr2uJE19KtZtO0XOLiu6FnGXwihGiHu72838C8CrB2r+guns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764146192; c=relaxed/simple;
	bh=6HCJiyfqp72xxdL7D9qi5O7xP31QXL0BnsOXwAK23VQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UxpA5o5eyIvbRXcQaJWJl2wHE9CvS3RMnelOsRDm+jCsl7QHNAhlkkyJZZW5hg97PygN7+mHpHfSDRBlYN0xmDqWicZmlFoZOztt52NiS3rkAg1D46/ipV6kyOzHxIRDLTPW+Y3Ayu+ToDcAtr2QeWqdNRUdH7y+TEyVSVCYNfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3AOrs1vl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=52rlU9XM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3AOrs1vl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="52rlU9XM"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764146184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FUu7oIM6gSr5XdaIxGqV6VzF3jQHUjuE+Tb9jD8980Q=;
	b=3AOrs1vlDAcEQyhHWwyKba756JZ6RGt257K6TKHSQbGFmWBZZQEB6JQSMC3XzQP4VKs5sF
	iv7BLzJVJl3doQJtkY2tSpBpA/Svf8JGro4ZOc0eF7qSVtD1ffDmfAngw7ALjLqJfXf9L9
	Qo8fFTkJpsTYt5i5mXqFvPJYpmsILbGBLUG6YG0S/15fk1GMIQOK++lzkQxS2HeA4w0S6r
	jFzqtpYyAAgpk6axpkbc/GCiAOsDbzosjwmDOtVQbwGEjIILW7s/hw5wOTZ5o+4KI4rIOz
	1yb1sCgkd2nIN1xwDqivEXBJJ5AauxW1FPxQmzTOPuhZLb4QvOhONROGRTQ7tA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764146184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FUu7oIM6gSr5XdaIxGqV6VzF3jQHUjuE+Tb9jD8980Q=;
	b=52rlU9XMoLFNzA2GJKkVlzOv4v0gIYUDQoQ6WA86Yhl3ErvFkomqQJxvKW3Bq48c7sfwv3
	1Ka3tdQLVIEBhZDg==
To: Gabriele Monaco <gmonaco@redhat.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rv: Convert to use lock guard
In-Reply-To: <e4838dd91f14024222eef8e705f2b1ae7945bb80.camel@redhat.com>
References: <cover.1763370183.git.namcao@linutronix.de>
 <dbefeb868093c40d4b29fd6b57294a6aa011b719.1763370183.git.namcao@linutronix.de>
 <20251125145736.48c3ed9d@gandalf.local.home>
 <e4838dd91f14024222eef8e705f2b1ae7945bb80.camel@redhat.com>
Date: Wed, 26 Nov 2025 09:36:23 +0100
Message-ID: <878qft5gxk.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-11-25 at 14:57 -0500, Steven Rostedt wrote:
> On Mon, 17 Nov 2025 09:06:02 +0000
> Nam Cao <namcao@linutronix.de> wrote:
>=20
> > @@ -644,13 +640,11 @@ static ssize_t enabled_monitors_write(struct file
> > *filp, const char __user *user
> > =C2=A0		else
> > =C2=A0			retval =3D rv_disable_monitor(mon);
> > =C2=A0
> > -		if (!retval)
> > -			retval =3D count;
> > -
> > -		break;
> > +		if (retval)
> > +			return retval;
> > +		return count;
>=20
> No biggy, but I wonder if this would look better as:
>=20
> 		return retval ? : count;

Unless you really prefer it this way, I would rather not. The first time
I saw this syntax, it confused the hell out of me. Took me some time
scratching my head until I figured out that it is a GNU extension.

I prefer to stay with the C standard unless there is major benefit not
to.

Nam
