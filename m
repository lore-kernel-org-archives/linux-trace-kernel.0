Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98143395AF6
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 15:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784646401; cv=pass; b=geInlSy57ufi7cI65xk2b5MuvPeMtG0VX5QOIjC6nJ0XPrmEA5hqVfor147HeKF1X+nQG0XlMHqoygmd1R0mRieA2XL/NxnDUb54VhAZUZGXUpvubge3F+V6o4fL27DXx2yHtOAVDjwwS825W7htlJOrevyoHEZuxGBkQ3x1Td0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784646401; c=relaxed/simple;
	bh=ho46wttfZTO7K04O0d4Ml5ZXrzDwso/tV+4SlWbvjus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pToeA6v9Kyjfa88WROX5quxQuHYWe9ZLv978sG7LKqf9iAggfWESIo7anjKO7PCOvizU+vND19u9jjidrHhQawcjvRfDZphRsbSh1+wtjucjoJNyKGFuayEBwZYJ1vQfCpTbYzZ3weNnnJPNHsi0tW5QZeCSDydhcETPzIsYv/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehfAPw+0; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehfAPw+0"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c1740c36c5cso587556866b.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 08:06:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784646397; cv=none;
        d=google.com; s=arc-20260327;
        b=nlSDtQ1Wso9LuupOr23pM2vic6cI4hwKYgdQkO0pFEEeYeRZdHIPHPJnGsowrBVLZU
         YA2idHhlhImT/yxzvA8HBruhM6sBg0FmnzLVB7iBgBrA+hgxRozzd2hV/wowvNMX2jXW
         QOhfBxS46o8+Bb9lvCGjMYj4hdpzoBLNCE+6GZUet4Q12HQmaxGwQRRBgpCK5AIY/QSt
         jELz48gr0gWw+pA1/euhEYW028XV/pfp7+RiRDNeL5HxUlPbUCvkGNQ+7bQFhGHSkhQV
         9Ki2jvpLi4FgeDSLUXFNgiucPJBN9P75m8pOdK9GAylv7kp2McV6f39oUjYERnag2OIZ
         f4LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b6UxfLOGsk3jXJZY6KCtIyp4Mk9Y6qqooNVntB4lo+o=;
        fh=uZNPjdI8Lr51DlfzYLq/t0jWMVTBR3NOAsMESPRqA7M=;
        b=gaziCaqhNt85SG3UPXj7LXXgdTCUFrwNABATQlA3XilgCUxSKZZeNF5vZvFyX55vXe
         ui6yOVYVMZZN/soK8Pw3bGCd+OfIT5MsTlAMpHe3BQZ9C9fbuegMGAi0yOby7UaHHinp
         9Kp+1lb+P+U2gHMPmvM8VKijAbhhocgX9pmTJji1o6H5iuKDD2YE1aVd5ZpKyZvH7NBI
         95O+ppB2+DligsBq0/rqfUoOo+epzm8rs0N/f0i7zDveV48ibedi6bA11ezwqbmUZWSY
         a/z8xPZnu74Z532QugB1x2dfH24/fyzLovwAywBlnkjWYSD/y5Exg2bGRR7JHrrwkgKB
         /SPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784646397; x=1785251197; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b6UxfLOGsk3jXJZY6KCtIyp4Mk9Y6qqooNVntB4lo+o=;
        b=ehfAPw+0jSsxb7nN8116nYzzhoSEuDK2FayEU2nHfruP9g6plk9dkZIaryF3uKdafl
         eAqoPvwqeQOjCt2kPqhlB9z/pIijRmXafqoqE//v1KwOuMoOn9ccaqlREyABRgtWkIgV
         2zBPpWETQNz0un+vqaqZSJ7hTXjYeEfdWDpD3jADDtRJ+n7gqJlR8WXrgd5RHkPBVZZG
         LBB5qzyJvAYWfaKjO+nAFn0pUyXtVvUuhx2J0Ng2dEIw/Y9DqLUJlBy9Yi7AnDGOMD02
         NwiUhhgZ5EJoWl+QrDD87qhGNWIs0ftVzJFRyRcJC2Kh0Fg6ToDFQYqAncAdUIBkuyzg
         yPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784646397; x=1785251197;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b6UxfLOGsk3jXJZY6KCtIyp4Mk9Y6qqooNVntB4lo+o=;
        b=icl/zHBc/cWHMyqq1KYagbKG/4jFpnKyZpZzKEe1z9jDsVLcVXtn/EHl+7eOnlwtnx
         oNJ9Bn5dWxnBNkHCmfTps/g48vt5rGQ9L6GmcrsPoWMR3iIRIdmBBoBgKixp/E7jmzQ1
         ity++NSy3PDQDXWYK2vocfP2SWJG13UEXDh8hp9BzuXJfYbOqPINf7BkDJTmk9kC9ta3
         fCKqGXrxVJc+6rbXFo6dOfK4vzFnulBZmX6KAsZmiCDvoryMvw018CGa/jmC7COUCLFl
         A5iO2Kh45Y3iXjEvaVOJTmLRE/vSIItMJF0mzhZcZtqUXSytHwrhM1l/4H7m7jDHEN1q
         C42w==
X-Forwarded-Encrypted: i=1; AHgh+RqgpxRdnNj4EBh9v/qbdO9m6V+Hs/xH8fje+FA9Iac7PexyFcEM96WuoplyVKrpkzQisOCSpnQvCqxLYe76YvbT7KY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpGfVz4HvjL9wGDntAMgKjS+k2PimZCNh3GD+IXn6cSCon9jZ+
	hmXC/HYuzghg73+69DSzRYF93BRffirOcshUwmokBCswfR/uq/Om3JDH+McaDgV5ghZEORMHEU0
	w2uSYbYZKdmSrmdqNYtRCSkJDCTFh2Pc=
X-Gm-Gg: AR+sD10sa40e1al1DVXlouDh+6aGFTiqxf6gI6CY9y/qwgZUyu0O8VHm9OY5RJnY5fJ
	RKXWjem8pbMVhIgwFduHnK8eoTLNWm4tSss/Qu7ZWxutJ1zQt6YWSL9olNK2b3ZG9KrUoyt0XSy
	Zr8lkzPCb+JuBRySQRTe213VwxMhvAFy30n1gvZQXNjd+U+HZ1hoPjQqfswndUGGV3iYh697hp8
	69DbVGKBcVoQUpQaQdW0ZCgEXndrxyM6cFVO1+LsZ4GFCDfVQgsGVeiohV7mSN+te4BzRtzJYU4
	yg==
X-Received: by 2002:a17:907:3d45:b0:c16:5dbd:8210 with SMTP id
 a640c23a62f3a-c16b487dccemr839458066b.44.1784646396456; Tue, 21 Jul 2026
 08:06:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624132356.516959-1-puranjay@kernel.org> <20260624132356.516959-11-puranjay@kernel.org>
 <al-DopVEIe2FvLnv@localhost.localdomain>
In-Reply-To: <al-DopVEIe2FvLnv@localhost.localdomain>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Tue, 21 Jul 2026 16:06:24 +0100
X-Gm-Features: AUfX_mygNiKl7k5PKNcYxKWmZDstqHm_LMPoAPOfcq1BpHj7wCOU9ddgC3MI19k
Message-ID: <CANk7y0hado1yb9Gaeg0FVX45E96E3U_8d6gJTF0=s-pjwcQEpQ@mail.gmail.com>
Subject: Re: [PATCH v1 10/11] rcu: Advance callbacks for expedited GP
 completion in rcu_core()
To: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Breno Leitao <leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 3:35=E2=80=AFPM Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>
> Le Wed, Jun 24, 2026 at 06:23:52AM -0700, Puranjay Mohan a =C3=A9crit :
> > Even when rcu_pending() triggers rcu_core(), the normal callback
> > advancement path through note_gp_changes() -> __note_gp_changes() bails
> > out when rdp->gp_seq =3D=3D rnp->gp_seq (no normal GP change). Since
> > expedited GPs do not update rnp->gp_seq, rcu_advance_cbs() is never
> > called and callbacks remain stuck in RCU_WAIT_TAIL.
> >
> > Add a direct callback advancement block in rcu_core() that checks for G=
P
> > completion via rcu_segcblist_nextgp() combined with
> > poll_state_synchronize_rcu_full(). When detected, trylock rnp and call
> > rcu_advance_cbs() to move completed callbacks to RCU_DONE_TAIL. Wake th=
e
> > GP kthread if rcu_advance_cbs() requests a new grace period.
> >
> > Uses trylock to avoid adding contention on rnp->lock. If the lock is
> > contended, callbacks will be advanced on the next tick.
> >
> > Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >  kernel/rcu/tree.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index b01d7bf6b57b1..f42e01ef479c4 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2891,6 +2891,23 @@ static __latent_entropy void rcu_core(void)
> >       /* Update RCU state based on any recent quiescent states. */
> >       rcu_check_quiescent_state(rdp);
> >
> > +     /* Advance callbacks if an expedited GP has completed. */
> > +     if (!rcu_rdp_is_offloaded(rdp) && rcu_segcblist_is_enabled(&rdp->=
cblist)) {
> > +             struct rcu_gp_seq gp_state;
> > +
> > +             if (rcu_segcblist_nextgp(&rdp->cblist, &gp_state) &&
> > +                 poll_state_synchronize_rcu_full(&gp_state)) {
> > +                     guard(irqsave)();
> > +                     if (raw_spin_trylock_rcu_node(rnp)) {
> > +                             bool needwake =3D rcu_advance_cbs(rnp, rd=
p);
> > +
> > +                             raw_spin_unlock_rcu_node(rnp);
> > +                             if (needwake)
> > +                                     rcu_gp_kthread_wake();
> > +                     }
> > +             }
> > +     }
>
> Should that go as an improvement to note_gp_changes() instead?

note_gp_changes() only reconciles rdp->gp_seq against rnp->gp_seq, and
the expedited path never advances rnp->gp_seq. So the gap this closes
is exactly rdp->gp_seq =3D=3D rnp->gp_seq, where note_gp_changes() and
__note_gp_changes() both short-circuit, the expedited completion isn't
visible there at all. It's detected from the cblist's stored gp_seq
(rcu_segcblist_nextgp()) confirmed with
poll_state_synchronize_rcu_full(), so hosting it in note_gp_changes()
would mean running that in the lockless preamble for every caller,
including the off-tick call_rcu_core() path. In rcu_core() it's
already gated by rcu_pending(), which does the barrier-free detection.
