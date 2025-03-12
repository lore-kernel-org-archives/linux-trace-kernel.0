Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012F623C8B7;
	Wed, 12 Mar 2025 09:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741773420; cv=none; b=VyqG0CDugcNTQa43Htf3wrC3MGhy1EvieBhhATOUQMS+9MCUdX/rLNHfDZo7urHFySqqo28F77QbMKn8+ZxtdmAXV6jVrkhhMjMwqmmA1DJM2oAcnYRQX91S2T8+3hrOpv+kV3fZiqc+NzIZA1ZTuFyiDoi6aVdccC23Wweuqvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741773420; c=relaxed/simple;
	bh=hyx7eXc6N2QDMkI31SyQM4MiHmDWqcYPqS9p6z4tClE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oc4cdAbT9+8eVP290n+a+NsIi/QTBeygmDmPfmghjnsTEpnofQLfKl6aSU1597zxcfDNdBvLzrQ5M7Eqd4EGDES3qN6Lmy6kdOWymCs/lgIRQCOtX4BaZhMTQfQAatMwJFmH7ykL8VfNN9DKMB7D+E1hHhGVYbTx6mG9ojLbP48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491C8C4CEE3;
	Wed, 12 Mar 2025 09:56:58 +0000 (UTC)
Date: Wed, 12 Mar 2025 05:56:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>, john.ogness@linutronix.de,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] rv: Add infrastructure for linear temporal logic
 monitor
Message-ID: <20250312055656.556a5db1@batman.local.home>
In-Reply-To: <035d1f1a92f15bfa60d2d133131dd8a25b3c78e4.camel@redhat.com>
References: <cover.1741708239.git.namcao@linutronix.de>
	<0b03a7d779707c598068d6ec00f3e5a19de336d8.1741708239.git.namcao@linutronix.de>
	<035d1f1a92f15bfa60d2d133131dd8a25b3c78e4.camel@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Mar 2025 07:47:50 +0100
Gabriele Monaco <gmonaco@redhat.com> wrote:

>  -/*
> > - * Futher monitor types are expected, so make this a union.
> > - */
> > =C2=A0union rv_task_monitor {
> > -	struct da_monitor da_mon;
> > +	struct da_monitor	da_mon;
> > +	struct ltl_monitor	ltl_mon;
> > =C2=A0}; =20
>=20
> This adds quite some memory overhead if we have multiple per-task
> monitors (we might in the future) and we don't use this ltl monitors.
> What about keeping it conditionally compiled out?
> You could define the struct only if e.g. CONFIG_RV_LTL_MONITORS is set,
> select it with any LTL monitor via Kconfig, then glue it somehow to
> have it readable.

One thing to do if you compile it out, make it a stub structure, so you
don't need to add #ifdef into the union.

struct ltl_monitor { int unused; };

Or something like that.

-- Steve
