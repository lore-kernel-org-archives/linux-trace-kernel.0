Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547BB18733F
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Sep 2024 23:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726269683; cv=none; b=ZUIxK4FyfvpY1yEGbdeI/ibv1UJYHjhlMATlFVR6iJSB67HAhqaZpOhe363E8Rd5UmAMHkURQi5uMw7BoKalXiD5n4GRRCDj6XR50v43+2QYxFmOkOSCt7ZNmAzC4yk2mVarOQxo8NUJYIxujtWll2HAN3a2IPk5/s7iRrYuvto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726269683; c=relaxed/simple;
	bh=fXShCPOpZz52eO91jyJt6+04d4urWyr5XmecZWpUQZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XXx9bpcgDMNJ0lSSJE5qbLbxh2liE/F1skP4j9m6QqYKcWNijYJssZTVRsnm6vXOKu5jrr+tBx6pMaFjo0er6XVjpUeXtoOmJESyr9Ipk0o/xgAfVfK4PHyZBrJ36HfwS8nyVeq9CtrIdfRAshY2kg2wMa6Ko9i6/7RAAfZByHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HLuctxIP; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HLuctxIP"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c241feb80dso7125981a12.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Sep 2024 16:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726269680; x=1726874480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gHrUsCpR6q/vcDy94msssmKj/tbR9miRFAu8ZGicdg=;
        b=HLuctxIPn+x+eirrotxm4vGfMlKKAGm1I6loe3AKuWoto4gylEdR3R2jA+vAG9BGIK
         w1cWEnHGrduJC0ZdKxeERNndQV7m3G8prVz0RVkXGhFGRek2nW7JN+Zhfj4IBuSQCGxr
         QXMNeWvzqTLvuJ+APbhlw9DacFGL9eQePL7rRh2R08NCJzP1S6uq5/BYra+vVRhwDZVZ
         GiTQC+fpl6nqY14umx9L2+7w07ESmW0w0Y/m9CZGDzjVBqKkZ17DY5oJgcO5WTFO7ao3
         hKNwSoMUCHKmJzhuqX2FNFTZD7yB0suYMGCrsMXX9UL/wjc1fGTeSFa0yWO1YoW57INH
         u/3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726269680; x=1726874480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5gHrUsCpR6q/vcDy94msssmKj/tbR9miRFAu8ZGicdg=;
        b=dAYCKdBNLDBe91Z6rMYUe0OSOqpyvWdn031Fd9GrGx69A6enZHzAA+xXAjalg0gF4v
         KSnbAj4jiAM7pmAPoeOkdWshrk4UaeeQEYHEDLLxj1aalGfSa3/9XPNWj7S2LEMXL+4y
         VXm/aO3cHjWLWTE8o7ZqMu6Ux1IEyrZnuCpEY/ctZkO4e/mkr8/KwBVdsTnfER0c+HAp
         YMJ5SXELvqPukZzaB+5PFk8Yi/SR3s/aWv3h+YSa+gyx5XVNdy41uXoFrrakLOSzyqvl
         fiywZnJBgkLU7H6O7QaiRy83XiKeqcHQfBuhAJdpK0P56z53RHzQ1fBWosEVfKE9ATjr
         jhAA==
X-Forwarded-Encrypted: i=1; AJvYcCWBx1vnZj83rKYkXU08RlZwkCW5Dg/SUKQ258Hnm3rXGw4DjczpxxUIfI7hRrmSwLLCSPQ9zsdNFkgIYamdEMK2/R8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhuyDK4E6x+9Ypp84fffZqUKKIrnrj+1CLUacG/KtHHUsG0q6N
	aOocMkrJt0Xz0eiScQt4s+vo9L9J9iMnzCMh2xIHu7fknwHeth3EOkUeEhkCiYtqSHVwwZ6tzHh
	P5V0Umv65QJ8RVf6GO5ER3KiP/3Ry1YXgd08=
X-Google-Smtp-Source: AGHT+IGvxiSn6JWS9N9/EAoj59xcTC5zKLV9vZxugR8jrHol8xrwnt7BBpr6nBUOCxwG9AGyWxa1x9nBJUY4B0O9e8k=
X-Received: by 2002:a17:907:1c22:b0:a80:9c1b:554f with SMTP id
 a640c23a62f3a-a902a8c3963mr879630266b.27.1726269678841; Fri, 13 Sep 2024
 16:21:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911093029.3279154-1-vdonnefort@google.com> <20240911093029.3279154-10-vdonnefort@google.com>
In-Reply-To: <20240911093029.3279154-10-vdonnefort@google.com>
From: John Stultz <jstultz@google.com>
Date: Fri, 13 Sep 2024 16:21:05 -0700
Message-ID: <CANDhNCqvwn7W8JgdzY=2PrEk0unm3E0Kso7h2CCZBPO+hzLaOw@mail.gmail.com>
Subject: Re: [PATCH 09/13] KVM: arm64: Add clock for hyp tracefs
To: Vincent Donnefort <vdonnefort@google.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	kvmarm@lists.linux.dev, will@kernel.org, qperret@google.com, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	"Christopher S. Hall" <christopher.s.hall@intel.com>, Richard Cochran <richardcochran@gmail.com>, 
	Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 2:31=E2=80=AFAM Vincent Donnefort <vdonnefort@googl=
e.com> wrote:
>
> Configure the hypervisor tracing clock before starting tracing. For
> tracing purpose, the boot clock is interesting as it doesn't stop on
> suspend. However, it is corrected on a regular basis, which implies we
> need to re-evaluate it every once in a while.
>
> Cc: John Stultz <jstultz@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Christopher S. Hall <christopher.s.hall@intel.com>
> Cc: Richard Cochran <richardcochran@gmail.com>
> Cc: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
>
...
> +static void __hyp_clock_work(struct work_struct *work)
> +{
> +       struct delayed_work *dwork =3D to_delayed_work(work);
> +       struct hyp_trace_buffer *hyp_buffer;
> +       struct hyp_trace_clock *hyp_clock;
> +       struct system_time_snapshot snap;
> +       u64 rate, delta_cycles;
> +       u64 boot, delta_boot;
> +       u64 err =3D 0;
> +
> +       hyp_clock =3D container_of(dwork, struct hyp_trace_clock, work);
> +       hyp_buffer =3D container_of(hyp_clock, struct hyp_trace_buffer, c=
lock);
> +
> +       ktime_get_snapshot(&snap);
> +       boot =3D ktime_to_ns(snap.boot);
> +
> +       delta_boot =3D boot - hyp_clock->boot;
> +       delta_cycles =3D snap.cycles - hyp_clock->cycles;
> +
> +       /* Compare hyp clock with the kernel boot clock */
> +       if (hyp_clock->mult) {
> +               u64 cur =3D delta_cycles;
> +
> +               cur *=3D hyp_clock->mult;

Mult overflow protection (I see you already have a max_delta value) is
probably needed here.

> +               cur >>=3D hyp_clock->shift;
> +               cur +=3D hyp_clock->boot;
> +
> +               err =3D abs_diff(cur, boot);
> +
> +               /* No deviation, only update epoch if necessary */
> +               if (!err) {
> +                       if (delta_cycles >=3D hyp_clock->max_delta)
> +                               goto update_hyp;
> +
> +                       goto resched;
> +               }
> +
> +               /* Warn if the error is above tracing precision (1us) */
> +               if (hyp_buffer->tracing_on && err > NSEC_PER_USEC)
> +                       pr_warn_ratelimited("hyp trace clock off by %lluu=
s\n",
> +                                           err / NSEC_PER_USEC);

I'm curious in practice, does this come up often? If so, does it
converge down nicely? Have you done much disruption testing using
adjtimex?

> +       }
> +
> +       if (delta_boot > U32_MAX) {
> +               do_div(delta_boot, NSEC_PER_SEC);
> +               rate =3D delta_cycles;
> +       } else {
> +               rate =3D delta_cycles * NSEC_PER_SEC;
> +       }
> +
> +       do_div(rate, delta_boot);
> +
> +       clocks_calc_mult_shift(&hyp_clock->mult, &hyp_clock->shift,
> +                              rate, NSEC_PER_SEC, CLOCK_MAX_CONVERSION_S=
);
> +
> +update_hyp:
> +       hyp_clock->max_delta =3D (U64_MAX / hyp_clock->mult) >> 1;
> +       hyp_clock->cycles =3D snap.cycles;
> +       hyp_clock->boot =3D boot;
> +       kvm_call_hyp_nvhe(__pkvm_update_clock_tracing, hyp_clock->mult,
> +                         hyp_clock->shift, hyp_clock->boot, hyp_clock->c=
ycles);
> +       complete(&hyp_clock->ready);

I'm very forgetful, so maybe it's unnecessary, but for future-you or
just other's like me, it might be worth adding some extra comments to
clarify the assumptions in these calculations.


thanks
-john
