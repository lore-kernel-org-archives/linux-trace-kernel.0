Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794947757;
	b=quFNv9vH6mKagay9vW7a1pFhV8ZVtqic5kWEEf8IL34j1Bb+bg8Qpof/7HdJe+ktsp6Q
	 JMlpjLwycyIOCgyv4i8ODat9GlYFKl3/BzFhmextuKMxDBOm+5twumQdRMMRwnCz5YODt
	 EQin0T07h+m9f2e6gIB+Eay/1LHXwv6eZF0uJRonZ8tYjAzWaR2rdiNxCtBseRlXJQLU+
	 jDvTKm70b+qc0wyEbiHLwLs+9d+gDgulkrkwvNu985uDzvY3Es7KQZZ+luggUp7t4eCEb
	 gcHOEBtO4hyHMJ1wHMshpRP3Ql56bhqWTgJu+BM1x8WF4cSmFSOhau25ug6XFwn57rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794947757;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=qU/707wsLwghguzg9u1/2onlRZx6ZVh35wJOTps23pA=;
	b=XuN3zf03lmXSe31JRmo649Y7kno9PODAJzgX3BxVBnPfx1hHprcP3w30oSyTxbhKxQkW
	 lWWZf0y07kGZmTmZst/ItKhY80tycaUK52PGXmsF8b46Zx6Cy6rg8Hsul5D1XUZMQzcDM
	 E/qrkIutJioKiM3rIqHK12LliwKTpqHSmqK3Fiv6URoy4ZlpIUZoOb68pRLh7d7uAGurn
	 9kd0Q3+lS3PpSdVa4vRtkcPEITvNhK4dFqrNCQ4/U8a+6pjUJknj8roiGjGm47ifKM5pI
	 /C0qYf0w7EhKn8+9iJ8IuiL3fTxBAFagkEfnVp3mqPH8kJUvXd9G3z6jo59T4u6OqXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=B4coaHg9;
	arc=none smtp.remote-ip=209.85.161.53
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A010D606A31C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Nov 2026 20:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A010D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=B4coaHg9
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6df7f544919so164000eaf.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Nov 2026 12:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794947755; x=1795552555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qU/707wsLwghguzg9u1/2onlRZx6ZVh35wJOTps23pA=;
        b=B4coaHg9J2NmCimgcZieOieeWy/ImLpro9mKFgLcYSEavyYH4UA1O/QqS2yOmKpSj9
         UOn2RuTUhw8htulvaP4TdRawt/SRkhUxhvDeOpvKSgCtLtXEKpD01Z7SSqwx9ZEDfm66
         mmyDBrQqR8e4DOAtmkXyuJs5tXbv2jrsfGdgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794947755; x=1795552555;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qU/707wsLwghguzg9u1/2onlRZx6ZVh35wJOTps23pA=;
        b=jkRGrOEgAjZuuU3XcQj3bznmJ95cHCws/R/I+KYvc2vt+HVkjyxZvX/LyDFYlO9rcq
         nC2kPZi2EJscDjkIJ8Qkl9j+ZhYMqx5hyQkP8TosXbK3D0GVXeepqBXHw8Yfg4AvZxSU
         vjFEt4F9dU6vrWMyK0muGwg5976jvXLuX42YSo665AXp3Enc6B6NQsbqdI/ZtsJAtGby
         h0dLDTSGh2ZVQ9/gq/bnRi/e0YaK2mWA6T4uo1LLW1o1iMPtQRDPzQIGnv6t9c7C2sn9
         m5QjUM5LZMJJn+z7/HGi2EcK8YnnMOP50QM+1Zf1rJQ9knfvQcB+HWaIpLnZXZIY2GYO
         dySQ==
X-Forwarded-Encrypted: i=1; AL+hErGyxteg1AI9SjZYrR2fIodIULhitgAFUa1Jg7xkazkFJSVgclp0B+y4BOjScBdVL0R9sbww87vS5AgLDr4404QCAE0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8MGSslD8gqH4h+HsUVYT6VtViSbwfXd9RNlROBsbkhTXztJ8tE
	RMggI4yIBJ4Uf4somkEF6zR0TeMbAIH4y81hp7xIBr5uravocBp/0jz2yROdTnP2gZWONud6bp2
	Rqhw=
X-Gm-Gg: AYBFou09/7ajshyaBsQ9HGQPhleKj2pPxsWX+aIfuGBFfGaBoMFqcguwjH3dptsXJiO
	ejkFij5pKveztznwCA0bzQvO2UDb+RCZL/fjkU2EjRUWmRR8vU55s924eTe9b3SuwF+mq3rhSPy
	CoQaBFi8cEvmSKZ70shjvvWd41pMEYZr2kEaLDyBhgtBNLqT6PnGlbJ2KyKoWoxlAuxnBx6bVoX
	/uua/3tF/8yEMh0dW8tv5ISWrOeARj/ejTexh14l/Bosk004R1PEUvUdShnhBDMwOCbUm8fl7ZA
	QOxdjzqhCAetC3n2iGNRqTjgmIywFNZiQtA4CwzY56xIgRU/Q2XWuE7sr/gGOKW613lbOATAPIu
	JPG0Fkqjt1fxEo0OOvdqMJb0+pmFM5ty3jsT45bcaaJIpYLlF9KySC063qJ7SoQSaWq7nv8thkk
	ynb/zuI+jMqrjIVO3iLkcAmR3FhuyIdP6eHMAvQBuQFZF7YavHGzbRXsWpk0Tot/mw0o9s4RNyu
	y0BMRrOWbymdLggcnnjMXPDh55OAuBo+m+ikuXWIO8//6AP7P5D4uABOo2eCdeDR862lpJa2o4w
	feWE/RuqyS9CVUe5k4WsvGIA1cjWLO7aLwZKopY3q75wV+iBLxBQKGc1Lr0c4i/XgZIK
X-Received: by 2002:a05:7022:2205:b0:1b3:a9c0:6a3e with SMTP id a92af1059eb24-1b543c26e95mr931425c88.29.1794947744502;
        Tue, 17 Nov 2026 12:35:44 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:d92d:531b:8d97:bf51])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-382a63059e3sm651691eec.5.2026.11.17.12.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 12:35:43 -0800 (PST)
Date: Tue, 17 Nov 2026 12:35:41 -0800
From: Brian Norris <briannorris@chromium.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: 'select' GENERIC_TRACER, not 'depends'
Message-ID: <avy6nTb0ccqNNnOo@google.com>
References: <20261116144652.1.Iecb63200dd245f62032a3b1f60ae78cc48868094@changeid>
 <sashiko-outbox-217828@kernel.org>
 <20261117085552.0e4ef272@gandalf.local.home>
 <avybp3O2zxcLozKB@google.com>
 <20261117142203.72235895@gandalf.local.home>
 <20261117142310.4f440b3f@gandalf.local.home>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117142310.4f440b3f@gandalf.local.home>

On Tue, Nov 17, 2026 at 02:23:10PM -0500, Steven Rostedt wrote:
> On Tue, 17 Nov 2026 14:22:03 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> As it doesn't need to be visible let's still have:

What's wrong with visible? Hiding it is part of the confusion, because
it disappears when you select something else, even though it's still
effectively enabled.

Personally, I think it would be nicer if we could eliminate the separate
ENABLE_DEFAULT_TRACERS (or ENABLE_EVENTS or whatever you want to call
it) and make CONFIG_EVENT_TRACING:

1) user-configurable and
2) 'select'ed (or otherwise forced to =y) when something else truly
   requires it

That would make it clearer what's happening, IMO.

But I'm not sure off the top of my head what the best way to do that in
Kconfig is, without introducing odd circular dependencies or other
issues, and I also don't know how much more time I want to spend on it.

I'm open to ideas, or I'll let it sit/marinate until I have more time.

Brian

> 
> > config ENABLE_EVENTS
> > 	bool "Enable trace events"
> 	depends on !GENERIC_TRACER
> 	select TRACING
> > 	help
> > 	 Select this to enable trace events through out the kernel such as
> > 	 scheduling, irq, kmalloc that can record to the tracefs ring
> > 	 buffer data from within the subsystems the events exist in.
> 
> 
> -- Steve
