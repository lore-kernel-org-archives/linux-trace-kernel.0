Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F4F26CE2C
	for <linux-trace-kernel@vger.kernel.org>; Sat, 25 Jul 2026 12:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784981077; cv=pass; b=t4V1eXsQW3puVmDgYoc23q9YQWUOp1CJp0Bc9xc1oZZIRUyahaEcDzrdnChUrdYkdFfoJQMO6bAe1SnxbpFd0lG2GHbINlzNsI2f1TB0BbBBAar3+2CRwbcSbrx44+woMnjm0etleoKCndIy28e0EwwvAMIXTyuDjAXLgTIYJDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784981077; c=relaxed/simple;
	bh=GCRHgUN5OrDS3h6TXUSztQQGkBJEns8zn1TosahCLFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TdlidVvkBXg1wPX1ZnwY9DCcXje7mUlSwlR0WIlUr7FcbRdZEHaD/ywnEPa2WEBSPNqMw2bthAMeoEBUnIWSkP7XQsCskJvYa5J+AtNVvTDeOZqZNbrUv8DJwySAGE/rvHslZ6MapSpdYeB2NMlW3829VEdaCKQVnIU/UfptdAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2bKQRDX; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2bKQRDX"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c12614b81c9so209138666b.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 25 Jul 2026 05:04:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784981075; cv=none;
        d=google.com; s=arc-20260327;
        b=CMoaJARyvL7D0NMV5XIASsYsrLOAl29yNUb7mlEqSKwUsp6wNDV6He+500rTNoQWBk
         5hkH3itScmqs4TNgDD4AjSzS9YzSP9bW86zT3fyy3VWtoH0kw7sMw50oIigFlQjs9iop
         aqMDCBxfzBGXgGolPk2yGp8WWyOAi1qI38wlSInqneQ2rTT4WylN8rngmXdO0Hf6vgZg
         zfJ0Y9OuswX+iMRQlgn39bkU5ofTgy2tAnntN94yTt59wmi9bOMbWtFIza0CCbcxFCL7
         Pm3TXNus4sr8R7Si/Jlt+wxGYhaawLXdFZbWQWaZY2Edq/VT+UC1c+/3vrSjZ9xv63qh
         wOmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Tq198tQF1IsV+MyvQWn4ns+avHzmhK6z4MHxI2nb1Oo=;
        fh=rxkTA6oXKgiynGl5OyhgOShdx/UNdbyltTHqBsaUE88=;
        b=gF84jRBzVs3yftzNiVoqR04Uw48+tp4KR0CKgf+dJO+HaZoB8KpvzI2dpMNMi/5mWb
         WqhGM0QhPb2dT1/h/JVyfz9Sl3Kzeu8omshiPfX1at8JsDQtRIUsmMFWtxvod2/mnUjW
         RnConxfhfbypUF2O/Nf79tTpiep8egpwH/Mp8UlmTNhxenn6IhJMqic6RsX3/7z2UVLd
         Mcqq19Sbi6gWoH9f4/Y2BylHwLvNoAOB+31WnTJ/bf0w77Iap0vovvuNywC9krew0PX0
         l0rktvJl2RpXkvDyyRtwB0ZF/uvmwaQJTpCF6yrQn4wsSSYCqrmpIN9JY4NZDjGLDpF2
         iL5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784981075; x=1785585875; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Tq198tQF1IsV+MyvQWn4ns+avHzmhK6z4MHxI2nb1Oo=;
        b=W2bKQRDXaiKxUlFM9puuh6benUuuvBUbyJFHV/eRLetklJyoiyz72bNHOsi3lKM229
         WNh5cT09R3d/d1KW8vOZWOGvfWUgGifN+TioFzWe81FkMMmSFISM6c3TGgZqm2CVmAG3
         7zihTVssdSFpRbOyp9Q6FppwVbxe8I7WlVpF21GrvW5QWZkfEk2w/fqVRF4/vPqEE6IX
         xjQKmnjvrY7vCZuop7V4zCLUMyPYqfGwbW3IyYY/jZKWXOJZj0t1lGS3EhKCiwBVEoD1
         1bWLiCrrBkEG01CUGuToi4fO1vZ68i4/CKGLxDQy1xc5yAGEW2chkQ0CMfu/1DGGZhtX
         jJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784981075; x=1785585875;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tq198tQF1IsV+MyvQWn4ns+avHzmhK6z4MHxI2nb1Oo=;
        b=LfjcqteFVp57FqgVakb1azXhMkXZTwZDpOwp61KmdqnwCeCB4i1Voc6k2r87GLCdoa
         OMB2DvFsMPwBjAj2wtPes43LRElPKH7xw32Jh3o2tobACocQAgpHohgPFjcZJZ9DsVtK
         GmDme6/JQSMY4Zuys1/6Nn1G0tAdUMUX8++bjAXbmFqgt4DxXxGlRV5Wqyd5xxVwrL+O
         WCIU+Tl1Zn9qxa87Wg+Bfkke5VPrUSWXSP4UnFbLQZiQQUs1SorDLOlhFHvsUpHax9iP
         ujG7ghfzihoyMpwbrHfko58ZVRR8UIlriuvv+1emGHTBZkTA8tVXCPbgba9MmFlkRX+K
         mudw==
X-Forwarded-Encrypted: i=1; AHgh+RprAks6y+Pzr3u4rTnsJiEHsBeX2d0ApKHrpbdUDkn+A+KxoT3EumDTn7Wq57xykzfovdGp9IISgQYVRjcQaogX1yM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm+AqRMU/EGGVf7o0z49kKjN75zCP/9khCX0iynQE/RJ+muimT
	gHJJEGKHC3hWiFaRs9SEVkacO/IIp4LmcOlo2D69YzhtlEuLvxt+5Kgb5sK8O2AY9pVI3V7G3I8
	CThtwcdbpD9DYlg50fYG7sG/x28G7njk=
X-Gm-Gg: AR+sD10Hejo6hmkfwMCK5Rd1f5VkNUFQT1HIXUndITkydDzpd/Kvcz5DhHvnQ+zz87T
	2eog0/0D81jr7pmrjxGQhEWUS2VGo2aWPU3rlhyXK8xcZ/D6Wul6gUvlSsoLDQ+M2GLshZY0RvS
	kzJH8Tmyo3mg8cUZKr3+uCh4xPYZLg/ivNjZk1m3R6NwrIVTWJM9++Bz6Sm28TegUDEbuvtR81v
	N3lAaz/Vb3QjvzCw1QQK9rZlRnNP9pZzVbzv3Z2fdIm2XFrYlR/CuT1RDTksLjSbfl89ZOsLWU1
	eQRo3btwARwLop495jhYaAe8J6LbwA==
X-Received: by 2002:a17:907:97cc:b0:c15:f6b6:18f4 with SMTP id
 a640c23a62f3a-c1f1ed40564mr75174166b.24.1784981074298; Sat, 25 Jul 2026
 05:04:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624132356.516959-7-puranjay@kernel.org> <20260724183123.160051-1-puranjay@kernel.org>
 <5a87e5f1-7cbf-45c0-a6e2-88320db628bc@paulmck-laptop>
In-Reply-To: <5a87e5f1-7cbf-45c0-a6e2-88320db628bc@paulmck-laptop>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Sat, 25 Jul 2026 13:04:21 +0100
X-Gm-Features: AUfX_mxztUek5QzrvnuWv513tANm2vUvNcHIsu0rIcLDMCQdR_8_cVOv82niJL4
Message-ID: <CANk7y0jZ7JuR6MoNKZZU3R=+kfe0pELRUWYomtxHKQwsBan3Bw@mail.gmail.com>
Subject: Re: [PATCH v2 6/11] rcu: Enable RCU callbacks to benefit from
 expedited grace periods
To: paulmck@kernel.org
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Breno Leitao <leitao@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 25, 2026 at 1:23=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Fri, Jul 24, 2026 at 11:31:23AM -0700, Puranjay Mohan wrote:
> > Currently, RCU callbacks only track normal grace-period sequence
> > numbers.  This means callbacks must wait for normal grace periods to
> > complete even when expedited grace periods have already elapsed.
> >
> > Use the full struct rcu_gp_seq (which tracks both the normal and
> > expedited grace-period sequences) throughout the callback
> > infrastructure.
> >
> > rcu_segcblist_advance() now checks both normal and expedited GP
> > completion via poll_state_synchronize_rcu_full(), and becomes
> > parameterless since it reads the grace-period state internally.
> > rcu_segcblist_accelerate() stores the full state (both sequences)
> > instead of just the normal one.  rcu_accelerate_cbs() and
> > rcu_accelerate_cbs_unlocked() use get_state_synchronize_rcu_full() to
> > capture both sequences, and the NOCB advance checks use
> > poll_state_synchronize_rcu_full() instead of comparing only the normal
> > sequence.
> >
> > srcu_segcblist_advance() becomes a standalone implementation because it
> > compares SRCU sequences directly and cannot use
> > poll_state_synchronize_rcu_full(), which reads RCU-specific globals.
> > srcu_segcblist_accelerate() sets the ->exp field to
> > RCU_GET_STATE_NOT_TRACKED so that poll_state_synchronize_rcu_full()
> > compares only ->norm and ignores ->exp.
> >
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> > Paul, please take this in place of the original 6/11.  The only change
> > from v1 is dropping the premature !poll_state_synchronize_rcu_full() ga=
te
> > in nocb_gp_wait(): if a grace period completed between rcu_advance_cbs(=
)
> > and that poll, the rcuog slept grace-period-deaf in nocb_gp_sleep() wit=
h
> > advanceable callbacks still queued -- the lost wakeup Frederic diagnose=
d.
> > Verified by widening that window with a delay: the original reproduced =
the
> > writer stall within ~75s, this version stayed clean.
>
> Done, and will test during the weekend, thank you!
>
> There were some conflicts, so could you please double-check?

I have looked at your latest dev branch and everything looks good to me.

Thanks,
Puranjay
