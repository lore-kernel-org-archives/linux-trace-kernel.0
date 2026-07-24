Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C483A6F11
	for <linux-trace-kernel@vger.kernel.org>; Fri, 24 Jul 2026 12:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784897570; cv=pass; b=a5uDEQtfCb9D57vNDejjZmf2+nIIp7Y1uI/DJmrhp/aZtGJVOC8rprSupPiz69/P+sko+l+Jp3eE3wvFK7gOXaespSlqb5vnFbaVgTHp2m8yBLXV3925VyddReC3V10J4Tu/IokeTuV9V+9Yr9ch1Z/+t/vk3BgANOdyLArXrg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784897570; c=relaxed/simple;
	bh=H5Wj73ezMjb+EAZvwJvzcK4Qn/TjeY71l0GEXNihPJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jn37s5rpLjDh0jHLMOs2Z2Vp/b4T9bHQaJOQvdny3DdiCzc4VDU32dnxZLdn6isMyyPmrteBazPw0Efgo9B1Rn7VTXDtIEaC+hlDbT9KQEIcgQGBfghAX4c4Y+pPglM8rbZI9DTepVWtRLhmRsx/bb/q15KmrYAgnHxb7jigyVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRq0naTW; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRq0naTW"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c1670dad7a8so62423366b.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 24 Jul 2026 05:52:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784897563; cv=none;
        d=google.com; s=arc-20260327;
        b=hkZrIbriZgdd0k06qc49xzXfhKobKXi8FBTUsL1O2SSP82iPoFF0Pgm5fH6N9ifFQa
         JQdie558hQv4p6nCO5sG4jbUiRi0ZYOz6KvSZAfGv1hLU/lgWkdloicIOJWAcykwr4Rt
         fqOQBk8+Tq2upPKFyI5TtXgbJCimI0fnsl1SrP08Ut6L+iRQO4kbXKWnX9us4aQeNYWE
         KnBkPO7WAKq3Yv++Qk5KF8KXSwi342w0g9wVEhNdklk7sADR1o+geePhJyw5WoM8MbWd
         vby0EUsD+FwIuMl0hAaZgb71ytMv0psW/AEUMqemYajQjZrSAQq9twrsxI89TL6pMMAx
         TVcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/pT/IenNDP5Hl0dbJZet5KGOCsXopWwJV5BCqPS+R/s=;
        fh=f4qCM9WLM8a8DblBjrkn+xl0yMSSWC/44NMTJFfWxvY=;
        b=qttfuoDmk+a8WT3w+xPJ5Lh5lO1IMu0Kp21NLSLl0p5goqJejSjeEuHn0cdoRZumNU
         vz++iq315PoaFujZmkKFJ/qivFma7JKD6ERkisN5TELgzVbylywh4Vnte18y4F9CSjpJ
         SZAjzBR/qwsVkhzo9wUDK6ElkwLYdYxrGnZZpIwtEHHclHtmoWmByKKS7RmSdjMXv/pK
         Gqimi9J6dEEb1IixWO5WcK6VsVNbOYPgBmz3SdrSClN/VsaK7wO2xoiCISZlnyMOPyqK
         rayYOqbbpA7rZkqB1RF5Tq6tPn9WiYJmWSOXPaQDU9FClFPN6+YYOJfM0DfPVkkXo/Fk
         otFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784897563; x=1785502363; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/pT/IenNDP5Hl0dbJZet5KGOCsXopWwJV5BCqPS+R/s=;
        b=KRq0naTWVrnHYHQ0RUrbLGk7mHAs4kdLzdhJZV+Fkt4RNjteFc1KzkIXewpj3k34/d
         f+vRs871+t7aeAX1WT7ABw2WvEmGL+dZIZRpCTnbdsAm1q858zeURkcjWdopdBh/fgOe
         V50YPlMVU3tQndO20FRcwOFhctvRSA0A6mZOGrYSr0wwqy5TaEiiCP1+AD/ZkSCVvaZb
         fT0E4Xk4OeL7KIX5nhXBoaxsjQhmw74CXR3sImLvziF9mpbsJhDSVRHEZR0M47ytyw4k
         Xi0D083et0fhz0NcqY9jbtHXmSow36UahwvDE/+c26wvwN6jKNamRbBDgFan4U0PwuQC
         fSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784897563; x=1785502363;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/pT/IenNDP5Hl0dbJZet5KGOCsXopWwJV5BCqPS+R/s=;
        b=hnd3Ld8lqoxuVqXvhVgN+y2qF7xTlTImOUaAi8EelRbdvE4rwgaXrB+1sSQrNCGTCb
         l+aG8WRXembZZHn07QPW0+YEKspGkLtmkl5TghFiXL4swbEvrssj4fFFaRZknW96pDeI
         PlY0jOdSgY1w+bjZiHZmPeTF1ovenNZViD5IAiYNW+XTdLZf1Y4kCCs5Bu8qT573gLyW
         fbammKtehHfj5/y8aoVhUmnF3zQOJVm5DjAdQCGF/JnVYzhh7SP7Jh6q8P/kNPM0IMBc
         9X4KuRNW6TEQOqFICkUDNORwHfKFDnuR2DYjCX+B6ysOtSzV4HM3mjnie08OsMzBjDIc
         b7cQ==
X-Forwarded-Encrypted: i=1; AHgh+RpmexwJoqIrf6ayOHDfPgK+pTmv6YEeJ/CDileQKyFX45+0fBxZLAM76AXo9cMxCNeI3j6u0TfK0ElhG6BOaKI6nZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1BeAuFYLMY/K/mGJpPaSps9BmWXXYOM8I2WUq7OETE1924nXs
	Hq68S2tgeZoKOJK/KA11X4XUnBifVXhsLL4canuAP+zcVzfiVwBxXhIwQSWgyZFdPv06IjOX+I6
	dIxnx9k5fph+ZhwAURiGnai88NHBM+HE=
X-Gm-Gg: AR+sD11MsDwW5uSe/fm+OpLjkeAjOHIpdCiV1kvDxyz5XTRHrhg0bVJjC9+Yv/CHvYl
	7Czr+tu4i1qPqtYbCcLr6xOfzmqWrr/cnOHPV5meJ61RXOrIyXrxy/1JZ7vi1FMN+/zSs4vAEpZ
	z66MBZFdP/Frh1rt8P9wAkQVYTCGHXPQx+pJP2K20QWyl2PhlOOVlGFMIjILWT9fyi5W/ZR1uOZ
	6Y+PuvX3jrVkhk9m6ZAbg/YqczffM9I+9yiUGRwjD5UZ4iVgogJQvbz2FOuOXVwbwfWJ76p7KMj
	cg==
X-Received: by 2002:a17:906:478a:b0:c1c:2fd3:bbd7 with SMTP id
 a640c23a62f3a-c1c509d3485mr332428066b.26.1784897563116; Fri, 24 Jul 2026
 05:52:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624132356.516959-1-puranjay@kernel.org> <062ddbcd-dac1-4ee1-9d3f-ef115a667d6a@paulmck-laptop>
 <amNeS_ahHPLqXIGT@localhost.localdomain>
In-Reply-To: <amNeS_ahHPLqXIGT@localhost.localdomain>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 24 Jul 2026 13:52:28 +0100
X-Gm-Features: AUfX_mxSjHfjWkcj0LEqQto_dwl1af8NQPOTnuA8saQXKYY5X49y2FXuKVGCVFM
Message-ID: <CANk7y0hQQ3oDKt+_8oh4t=8NfMRSa80a9jGr+DG+zbrcuUskTA@mail.gmail.com>
Subject: Re: [PATCH v1 00/11] RCU: Enable callbacks to benefit from expedited
 grace periods
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Breno Leitao <leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 1:45=E2=80=AFPM Frederic Weisbecker <frederic@kerne=
l.org> wrote:
>
> Le Thu, Jul 23, 2026 at 05:31:17PM -0700, Paul E. McKenney a =C3=A9crit :
> > On Wed, Jun 24, 2026 at 06:23:42AM -0700, Puranjay Mohan wrote:
> > > This series lets call_rcu() callbacks be reclaimed as soon as either =
a
> > > normal or an expedited grace period that covers them has elapsed, rat=
her
> > > than always waiting for a normal grace period.
> > >
> > > Motivation
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > Today there is an asymmetry: synchronize_rcu_expedited() callers get =
fast
> > > reclaim, but call_rcu() callers never benefit from those same expedit=
ed
> > > grace periods, even though an expedited GP proves exactly the same th=
ing
> > > as a normal one -- all pre-existing readers are done.  When expedited=
 GPs
> > > are running on the system (driven by other subsystems), call_rcu()
> > > callbacks that could already be freed instead sit in RCU_WAIT_TAIL un=
til
> > > the next normal GP.  This series treats a grace period as a grace per=
iod
> > > regardless of how it was driven, so memory is reclaimed sooner.
> > >
> > > Design
> > > =3D=3D=3D=3D=3D=3D
> > > Callback segments now record both the normal and expedited grace-peri=
od
> > > sequence in struct rcu_gp_seq, and rcu_segcblist_advance() releases a
> > > segment as soon as poll_state_synchronize_rcu_full() reports that eit=
her
> > > has completed.  Three notification paths are taught about expedited
> > > completion so the advance actually happens: the NOCB rcuog kthreads,
> > > the rcu_pending() tick gate, and rcu_core().
> > >
> > > Changelog:
> > > RFC: https://lore.kernel.org/all/20260417231203.785172-1-puranjay@ker=
nel.org/
> > > Changes in v1:
> > >  - New prep patch 1 renames struct rcu_gp_oldstate to struct rcu_gp_s=
eq
> > >    and its fields rgos_norm/rgos_exp to norm/exp tree-wide (Frederic)=
.
> > >  - The rcu_segcblist segment field stays named gp_seq; only its type
> > >    changes (Frederic).
> > >  - Patch 8 (NOCB wake) is reworked.  v1 woke the wrong waitqueue
> > >    (rdp_gp->nocb_gp_wq via wake_nocb_gp() rather than the leaf
> > >    rnp->nocb_gp_wq[] that an rcuog kthread waiting for a GP sleeps on=
),
> > >    and the wait condition only checked the normal ->gp_seq.  The rcuo=
g
> > >    grace-period wait now tracks a struct rcu_gp_seq and is released v=
ia
> > >    poll_state_synchronize_rcu_full(); rcu_exp_wait_wake() wakes the l=
eaf
> > >    node through the new rcu_nocb_exp_cleanup() (Frederic).
> > >  - rcu_pending() uses a new memory-ordering-free
> > >    poll_state_synchronize_rcu_full_unordered() to avoid memory barrie=
rs
> > >    on every tick, leaving the ordering duty to rcu_core() (Frederic).
> > >
> > > Still open: Frederic asked whether the first smp_mb() in
> > > poll_state_synchronize_rcu_full() is needed on the callback-advance p=
ath
> > > (patch 6).  That path still uses the fully ordered helper; only
> > > rcu_pending() was switched to the unordered variant.  Happy to revisi=
t.
> > >
> > > Puranjay Mohan (11):
> > >   rcu: Rename struct rcu_gp_oldstate to rcu_gp_seq
> > >   rcu/segcblist: Add SRCU and Tasks RCU wrapper functions
> > >   rcu/segcblist: Factor out rcu_segcblist_advance_compact() helper
> > >   rcu/segcblist: Track segment grace periods with struct rcu_gp_seq
> > >   rcu: Add RCU_GET_STATE_NOT_TRACKED for subsystems without expedited
> > >     GPs
> > >   rcu: Enable RCU callbacks to benefit from expedited grace periods
> > >   rcu: Update comments for gp_seq and expedited GP tracking
> > >   rcu: Wake NOCB rcuog kthreads on expedited grace period completion
> > >   rcu: Detect expedited grace period completion in rcu_pending()
> > >   rcu: Advance callbacks for expedited GP completion in rcu_core()
> > >   rcuscale: Add concurrent expedited GP threads for callback scaling
> > >     tests
> >
> > I do see the occasional failure when running TREE01, as in a failure or
> > four every couple hundred hours of testing.  This is the only rcutortur=
e
> > scenario that exercises callback (de)offloading, which might (or might
> > not) be a clue.
> >
> > The console log of a failing run is attached, or you can find it here:
> >
> > https://drive.google.com/file/d/1EH2P4SDy2a-SJndkN3GbCTGAXxI2xevm/view?=
usp=3Dsharing
> >
> > This is a "??? Writer stall state" failure, where rcutorture never lear=
ns
> > of grace-period completion.  Possibly because no grace period completed=
.
> > But there are no RCU CPU stall warnings.  In addition, these two lines
> >
> > [  631.032657] ??? Writer stall state RTWS_EXP_SYNC(4) g152813 f0x0 ->s=
tate D cpu 1
> > . . .
> > [ 3610.863114] ??? Writer stall state RTWS_EXP_SYNC(4) g736160 f0x0 ->s=
tate D cpu 1
> >
> > show that the grace-period sequence number advanced from 152813 to
> > 736160 in about 50 minutes.  So grace periods really are completing,
> > lots of them.
> >
> > This rcutorture scenario has rcu_nocbs CPUs, and CPU 5 is in trouble:
> >
> > [  631.066109] rcu:    CB 5^4->4 KblSW F21044 L21044 C116 .W120(148380/=
168068).N295B101 q516 S CPU 16
> > . . .
> > [ 3610.869914] rcu:    CB 5^4->4 KblSW F3000848 L3000848 C116 .W120(148=
380/168068).N295B101 q516 S CPU 16
> >
> > There are 120 callbacks on the WAIT segment, which are waiting on
> > grace-period sequence number 148380, which was long gone even back at
> > 631.032657 seconds in (g152813).  There are 295 more callbacks in the N=
EXT
> > segment, which long ago should have been assigned a grace period and mo=
ved
> > into the currently empty NEXT_READY segment (which is the "." right bef=
ore
> > the "N295").  There are yet another 101 callbacks on the bypass list.
> >
> > This suggests that the rcuog kthread isn't being awakened when it
> > should be.  And that something is failing to advance callbacks out of
> > NEXT in a timely fashion.
> >
> > Thoughts?
>
> If a grace period has elapsed while in the middle of nocb_gp_wait(),
> after the call to rcu_advance_cbs() and before the following polling whic=
h
> determines if we a grace period must be waited upon, then the kthread
> will wait for new callbacks only (and will ignore waiting callbacks that
> can now be advanced).
>
> Does the following help?
>
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 6da1b8f52476..96d76eb6259d 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -792,22 +792,12 @@ static noinline_for_stack void nocb_gp_wait(struct =
rcu_data *my_rdp)
>                                                            RCU_NEXT_READY=
_TAIL);
>                         raw_spin_unlock_rcu_node(rnp); /* irqs disabled. =
*/
>                 }
> -               // Need to wait on some grace period?
> +
>                 WARN_ON_ONCE(wasempty &&
>                              !rcu_segcblist_restempty(&rdp->cblist,
>                                                       RCU_NEXT_READY_TAIL=
));
> -               /*
> -                * Only request a GP wait if the next pending callback's
> -                * GP has not already completed (normal or expedited).
> -                * If poll_state_synchronize_rcu_full() says it completed=
,
> -                * then rcu_advance_cbs() above already moved those
> -                * callbacks to RCU_DONE_TAIL, so there is no GP to wait
> -                * for.  Any remaining callbacks got new (future) GP
> -                * numbers from rcu_accelerate_cbs() inside
> -                * rcu_advance_cbs() and will be handled on the next pass=
.
> -                */
> -               if (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
> -                   !poll_state_synchronize_rcu_full(&cur_gp_seq)) {
> +               // Need to wait on some grace period?
> +               if (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq)) {
>                         /*
>                          * Track the earliest pending normal and expedite=
d GP
>                          * across the group so the wait below can be rele=
ased by


This looks correct to me, this optimization with
!poll_state_synchronize_rcu_full(&cur_gp_seq) opened up this race as
you correctly explained.

Thanks,
Puranjay
