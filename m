Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC36619E819
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 23:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779146025; cv=pass; b=IZfx6CjtWFBdEQBsls7DUMJJdL+6qDQ/C47nnZ+NC0WmSuA65I+KjkfjggISkOXz/WhWbGgGXTT6oRiweiRxebyrUoGz0rnzixzG9+qYCiN6aH9aGiM2kOOeItbUOEdPJZoAsboCkYOpL2ayZzfsKXPcpuy3CLoUdfeQ17QX2O4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779146025; c=relaxed/simple;
	bh=T7x3IVUUIgtSllWSYneDq36vtBDXHESPdHNN2hLyyGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mZATTN8gkbNnUo+ll7vRxG+pBhQWPwzHtI3kbPmooJnPVsijytm4/1asW9cXLn+7yrNFXWwbWoPtvfRwHCKjJi3AERnjyG4UgJ4XTd05OGAlNFZzCFdCLj8oq79E5KEP1pFXNb0PqAew2NpnXD3iUExzaGI++yRGYq6vrotAPH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=t4F5rmnX; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="t4F5rmnX"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-65c1ba7eeb6so2957223d50.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 16:13:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779146022; cv=none;
        d=google.com; s=arc-20240605;
        b=YkFensj54/W1Dm0+qQ+Hf+EvlPMtgKlkEq7/8Pl3vEwlVbP2bjGw4ad7TTw76VsNhI
         q2Md6gwgAqklASQ/xoJfq2Z0JSTekAGLvLP4j5lAWZ3IR3R4pgqxSucEIzp4+qAHbevY
         quxNve/TiEJQR8FqCyl58SVNPcEdN0KoaA+/Xn8m65g83zfDe/Ofj6IMyNYdVWpLli1Z
         NZhKKJI9/ZD6xhl45GfaMkcgmlhktbCf6YflcnbKJV59u0ubeQWPNFiPIS/DejsNX3/k
         4dnCaWwM3n+6AetyhtviEx0FcwFobXpXGu5O4SMwTLDr6Pe0kQBVLmNDleS0DCQ88KiJ
         kCXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BwHZlfiYmXrlLurjFFYCMzxFPefIBkUCbNKJ0BH1hiA=;
        fh=uQ0FY4VXvrTHyhRZNcwtmI8Rf90Ss3AHLTFckhqmXXM=;
        b=hGoqeO9deb7h7fidyFeZeYDh+hkRCFOAab+deYjZHPV4x6BmwVNmzrAYER6Rgg46tZ
         QcDiLy9xN8U9XSPYdN+RDfTOmMGoDRbE8/5Z1piQgzgRAAyURY7cygJR56uU0/u7vjTM
         xHJTMTJq606rZ0OwNKeKbCS1Z+SYi1fUTtArsnvwiyIWi8qmIHQqLN4qQ1b5mDpy40PY
         /wV38mmhGT+KxehN92S0QA2peQbeS583SoXCYEgDiG7qpU9IY4KtbuaLLfz018VRV3ec
         qedBTbZ/FVD8Hp3eoXeNmlh2Cic2GVqHXz0NnlcbdHyrnIdTMmr0Va6MemQJ83RP7vvy
         Yrnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1779146022; x=1779750822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BwHZlfiYmXrlLurjFFYCMzxFPefIBkUCbNKJ0BH1hiA=;
        b=t4F5rmnXtQD2wOgbHUnXkl9Yv6UwxceG8Z9eZihfp4FhzZ2FWTIyzK8z5QDEzzustl
         qdJKKNsaP2AAZeyanhvqYkn6RNjRFIj3xPejhToLo+aq8E/TDPbxkE7Q1g6mHZFa+Tq8
         evTShdCNFSCTHgr1GFGUfaaaADkE0rMNI5coLMswvjRBPRCEaZ6y4+MU4quQbNT6lbta
         8F/k/LuanBK+IrLBCKDVjbpfKeQY7v1PxPsN6YNDOdQkZKQlSlx1mbTKSCyTBLchya/2
         0kLCaj7jSMKS+H3yyoBUbpUstLCmUKtGWGOTFoEM4efIP1lg506kqCmuqPN41JF5I2OB
         MQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779146022; x=1779750822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BwHZlfiYmXrlLurjFFYCMzxFPefIBkUCbNKJ0BH1hiA=;
        b=Y7vx/FdR4T25MIJ3UJfQzM8Jwwd5E059yBJOPML1PWkLScFc2v2f8Y7DZavlsbH1jd
         IC000WcQ1IJ35Htx6XJ+b4h4S8uWr7Mcd200rIOcMeOgUeItx9lqBa6e55TL854AD2vD
         MEMntEIOh1iQAy+e0sTOcDl7l9To8Iy2C0foNrKoFwYSlA/+fQSuup+2dzbkFCalJc/j
         wuG1261HzAdJLxzWl7taaDHCIxuucl0j03cTp7iFA4aPR2Zx5lL68zNGkIwhzr73aL9V
         LKThHm5Ni62VK4Ougsnthln7JH6EM/2OVrXk0AH3uP+MwR1U8LzLm1wrdIc/NAQBxP6S
         FF2w==
X-Forwarded-Encrypted: i=1; AFNElJ9RJM80KwCCE7X0OWmkcS3D6K7/HdzIdNwctdP4xUr1qizLjYyIFd0vBlRgaPMbOa79/1zdekKoG+Gj76HcaWgDOjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYXvwLCH/aPmhZOm/3G6cWSNX8N4kKBJblyYgChtvlNHFXMXz8
	k4uZNbPpsWgSH8gKjfiqSpHJmD+HYk2oGgGuHx1WRJ3/xYl5m4lvNxTMJUHYI1W/l663QDbG61y
	ez6GnOSUf8j1rLL9ohHIe5TCRNfU2EY7N+/poZ6RFtA==
X-Gm-Gg: Acq92OFlZlDQq0LBYMknWbHnLm5XNWWVy7bh/XtO80371i1+CqbY6WvGNi8QnX+wY/y
	V2J5gXWhojt3ZTt/dh6yKqV8fzhvzdKuv6HAog0CcKPgl25fsgeMw/2phjZeIzw1PZrShR3MYQK
	dAHdzI9QqZAZ1g6MacmYpw86eY7TiYxw/pKFa0Pq/b24hJjvvrHKArK5hoFvCZoMgx4fA3lC1DY
	VTN3MLFUFwzoCkTBNrLSIpVS713yn5Hwt6Pq6ygx4DBi8KrPSUAPAHldsZExVIJ06JpKDJpEmII
	vs+o0ewgjL+5HbmNZ25c
X-Received: by 2002:a05:690e:b44:b0:65e:5d9c:286c with SMTP id
 956f58d0204a3-65e5d9c3286mr5438297d50.31.1779146022578; Mon, 18 May 2026
 16:13:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515135959.2238922-1-vineeth@bitbyteword.org> <87jyt2xzj6.ffs@tglx>
In-Reply-To: <87jyt2xzj6.ffs@tglx>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Mon, 18 May 2026 19:13:31 -0400
X-Gm-Features: AVHnY4IXsQQMLTdS4POtHqRxTRzqXEVnWlXlOMBhTtqR6-HYQSgMty8ZLsPk1AI
Message-ID: <CAO7JXPhToByj4Gh42G2k4Ow-Qoasr4rmSKgDgMBmSjBnjuqY7g@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] kernel: time, trace: Use trace_call__##name() at
 guarded tracepoint call sites
To: Thomas Gleixner <tglx@kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 17, 2026 at 3:31=E2=80=AFAM Thomas Gleixner <tglx@kernel.org> w=
rote:
>
> On Fri, May 15 2026 at 09:59, Vineeth Pillai wrote:
> > ---
> >  kernel/time/tick-sched.c       | 12 ++++++------
> >  kernel/trace/trace_benchmark.c |  2 +-
> >  2 files changed, 7 insertions(+), 7 deletions(-)
>
> Please split that into a tick/sched and trace patch so each can be picked
> up in the relevant subsystems.
>
Sorry about this, will split and send it in next iteration.

Thanks,
Vineeth
