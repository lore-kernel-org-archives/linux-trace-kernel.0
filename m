Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E35E31194C
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 08:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768206277; cv=none; b=UqSWSEA+4cbMZcXlkjCRqmAKy0pYo5HB8V5UPoJ/oR/rNAHz61/e7uXjwX0rFgpw08vX34e3doaJZHZ0bkcFqx550MX+wGAmJXgU2C+rUmgMeaAB0gj5+6uUYq7vtSKg3o9Odn/NIqH0oxCMVFyoMjBcfG7d9LvvJqR1dkB/DCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768206277; c=relaxed/simple;
	bh=lfhp0xOpEYm5BA51occmCsqJF2exBFweB+jCpxqtXBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s48T7XQGgEpxvUogDg80UgFZLbWDh9eg7xXY0nn1gFjZOlfCDZxG8VKI2ugK6oMrlbMonARLNZ3/gKiAmFo554dOFOO9NHuc4I2rnw8d+n2nkMVwUVOzYfpvxYM5iqKUyI5iWGy8nJVfoXyc1fmmLQyBpaVZSQmGtILtGMOZ3Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YVtdk5Lc; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YVtdk5Lc"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-382fa66fa9dso41242831fa.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 00:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768206275; x=1768811075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfhp0xOpEYm5BA51occmCsqJF2exBFweB+jCpxqtXBA=;
        b=YVtdk5LcmWB8BZyGd/IlAWsLujgxY/Zus4EwJvxwvq4FwBmRmNYFl6WQk7dCIBHFYX
         mdlmqU0IXs/fZBu+1C7Rbk5c9JPNoqbt7tijYeCDwEpiPZ5k+lr6h7n2M2Efw6PgZX/q
         ywBlb5cBMKzQRacDNkhNBJayQbp6iCCVeG8tXdsNMv1RmKikbEdNPlZ//PHAQ98tVdas
         UCFID+mphZxRJcAW1BnldsofDe38QJ4NhA14tXTlZMdR1OCekxL0FvdXWHVXIYJuiGWZ
         +04lxRZWu/nYKT2B1e+yZWzv7kuDym3PonUdfS3NHYGO+bJ8rPXV/aCRBYictb6ytJXk
         SuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768206275; x=1768811075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lfhp0xOpEYm5BA51occmCsqJF2exBFweB+jCpxqtXBA=;
        b=F/CBrNLxhZeJwhGtSKVSaaL4Gw5mSoZAIbYENP2nmwyYmYFkil8Z4lJCXW4DjCwuiy
         pyRlp1VThvIxBr11i9J8TLdhGDtf6daQMylNdCdD/jRD3Sr9Rc/9BXRc3TgwMBxeOhBv
         wRSCVj7ADgAxdApCo8mWZut2O63jiIrpBeFjVGZ1VHsX2pux+Js2BkeJRqirSFyd5lji
         E9mFoD0K5NG5up7P6lWGU9SqvyPq6Uh8bzcpTwPpDJv05YYSca4s0xQR2ZCh7EpYg+TI
         Ywp+VzU8TRh/isNsJlNqOtHv/fZnvpZhR+M5E3p4/ISo6Kh7Bb7Cch/WGrCYxne1wmmS
         kmPA==
X-Forwarded-Encrypted: i=1; AJvYcCVQbLfTHG2VuK3IvApfPlLJujHGKe4+fImCroCTV7v0Ksw4/3f+V6Jhvz3u2gr82DvuC2HlTa2EIlNyV4c6tMDIWJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxzk094Tx/DJs+8kCw4wjn9lKevs2divMoOUP4FY2wdw/ASuaw
	fYYXTwmD8j1kwgoE/pquBuaNDvbfcx5s3lbWMZNeOWnv/+MFO/mOGLF94AN/VyB/WgPsGPU13qG
	iRZw6+TyVBYfNK39KuJZRJbBZHfmeQIR3BrzodkNByQ==
X-Gm-Gg: AY/fxX6YaKu+/gulMio9Roberg5IBC65een09n0Jz6cucd3uV0W7u28jjAypwhRy69z
	DoN8NVwySfKmrpzmKbD7iAlKT49ZGP2Hni9CdXTLQGlTmKTJ+BRh6zPiXia8ud11d5YdHliMsEh
	NglcFeREPN4K/CkPGR2ce+rWG+PXWmwybALV00CcHwIht5Ybmv+TzyQk9VLzcOBjYngaUY9AD6o
	QtIIYqKaexPuZxk6B+32DS1emYeseQX7Id39J4PSWPJMY+V70WSyQJD7PC3dBilImzF+X3JAjS4
	wOggZZ5pvrmANTxBbAe2oLIlGmxU
X-Google-Smtp-Source: AGHT+IG/tXabyyT59kXpBkJtq7aIwfkDlohuutNxueNT2jOC0zVIWgOJx/KzKA8PO9DED/xc6lcUEp5iHU2ymYjeTgE=
X-Received: by 2002:a2e:b890:0:b0:382:fea1:10b3 with SMTP id
 38308e7fff4ca-382ff696686mr50817121fa.13.1768206274742; Mon, 12 Jan 2026
 00:24:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230142820.173712-1-marco.crivellari@suse.com>
 <20251230094236.358ae2d8@gandalf.local.home> <20260109142758.145f57f8@gandalf.local.home>
In-Reply-To: <20260109142758.145f57f8@gandalf.local.home>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 12 Jan 2026 09:24:23 +0100
X-Gm-Features: AZwV_QgeCJjuPhuNhl5sgCtKkp3OQo0sHzToyZMjx1bdQZ0T9jco9vcJ4K5_O5k
Message-ID: <CAAofZF74Bhx9R_jud2zQ2ERcgGU2Ch+jD1QwdMNPBAzp4va+EA@mail.gmail.com>
Subject: Re: [PATCH v2] tracing: Replace use of system_wq with system_dfl_wq
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 8:27=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
> [...]
> I guess I'll take this through my tree, as I'm pulling in patches now to
> base off of -rc5.

Many thanks Steven!

--=20

Marco Crivellari

L3 Support Engineer
