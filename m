Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7551891A9
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Mar 2026 02:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772678018; cv=pass; b=OI4IdAbgcxzvM62p18PWEvxi8vC7hVGrvfnOesbJJLKylmT7ykYgdL8+vLS2DymnaDHeBxrY0+QFKwlIdmtBkWxVdyvxV7NxA1H3JcQyYcDZ9zOp1JdFnBYoBLtRwicZYpSuXMlkgqyITKrt7p6rS+EG30EON336vJca828uPmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772678018; c=relaxed/simple;
	bh=K9ENe+ZS+qJSovUOmnU+BwHRKPZ9IJnRalUA3D1rjVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H4qE3ZbFU4oSvf2Up2506UYsdU8q0n2Im7lVcZx20HH/WE+JdOk7kZKHzUeYlRJenNSqvDqR5r3vcFBGEPL8XVHOpCIMMYOckBzH7kPRQHmEuNeKVtdCNoDdnV8gNmvSqYmh+gxlM2qnfkRTPC+9paAievtC+GiD3AU4uWmS5ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LlXe3a3Y; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlXe3a3Y"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-79628fb5c05so61567587b3.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Mar 2026 18:33:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772678016; cv=none;
        d=google.com; s=arc-20240605;
        b=DwIIJ4JGfUCemcANsf9Uzpnd7jqNmuvB3CGn+DHWMyW4gSpPIv4tR1A8m2mrx9UzgG
         rWzGoyuiSixXmVnzxqYCqEt/QNqH8fZv+3Ti3HHjRV6USA97FnRFiy37BYR+Z6Gbp5i1
         B7/9gA7qunBMajj7jaitdqS0VkFO+T3ZO+RqVu/21yJKF747nbvjJRopzKNgrOlFWZQg
         w/rGFCkemZtVFUN/bkONxfp9lhUTVkkCpBBQ1WUCbT4mvyhq98TAnM94Fvr55nt3jhxO
         4KfBKNucI3O4CRXC+VglRRGRGp7VDJMuNF4TjernrX20LeoA3HxuYX2ku8AiOOXh4YKy
         90ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XLIDchVytB4hdh+ZFB2ySmS25tHVhntL5EeIcD91OOA=;
        fh=eT/lDcMgXSnXn1RXAR/0usy3lhYMOre8I3RGaM9objc=;
        b=MaRUu7me9CSFfU++r5lnTHTGmg4nroEKUNgpIPs2kcYgEzuhSQDPmys3RjaDC7aVUw
         evXM8o0R3pA9IPdqI8gKuTYNpzKkYIO+BtT924THjW0RNQjAyOockRTVdmxd6UHNLYdq
         9GsXYy/WNlRhq31HVNU11h8Zdwu8k0O7S8DXzVBkHzIT26jL8hRaU/ll3rb0FjHZfqdH
         xlfrhGmlKgnI5SzDR8+tFDMTv2BUSI1vmhILpsy6WoVqlfFR6IwyGY+lTvMeEQmZqA5G
         qf9QRhGXLIjwm92OsLPgZ7edzU7tx/6C+/Er8HsGpNEYRuHiU6RB1hD6e5ANFbunmAdQ
         sznQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772678016; x=1773282816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XLIDchVytB4hdh+ZFB2ySmS25tHVhntL5EeIcD91OOA=;
        b=LlXe3a3Y3cYn97S9gY9jMqB9RTWfP1s+QE5JFrc8hcqM0ZhpoGCDR8PxDD/GOz3uel
         sNMX2f540VckuO7nw+9QBeZevobeKqvTClcBm+UYtXXI/VmB38Ar8W5a0PXwUetHkt8C
         Ahn0oZZbbC5jrDYAQxKBleznRHDLeYaOVQQU/VHGErhZ1COdr0BVCzBJ1ZfCZmWHJJRq
         Z/IhV0mpinH31LQonF0C7uLmM+rkUWJru+r9Khjy7X6f2azA8fWSnIIDTq3qgZbum/yC
         ufWwEvd+JAK/Ci6OAjrAFO1RqBMVW2CCylmP7CsZ5Z88FroJrlXdoawI8LerCGDEa23N
         TpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772678016; x=1773282816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XLIDchVytB4hdh+ZFB2ySmS25tHVhntL5EeIcD91OOA=;
        b=HHd1jexD2JjJyeg/tsvKYmQR4lg2Imy4STcrIh2N5KQnxkdFVLW1E0XEu2sXJd2b0g
         Ixx8uLBUIZtA6oyWaFIET8N2GeBv5Q0OHlOKjz9bSK1J4ofePThgttlp0U5mZ+N5CLvF
         abu4UlQLNRo8Zpt7BRIisAMd7LGLagIYDEiDzorpIBycopS5y6KQijHkQTv5uFvJqKAm
         aUi5h/xTYMFm8J4c4r8PnGmeJHDdIENjQQ70qLD320UxNrMfVBupZbfR1qhlHsbkBtbw
         rCZpDYlNiQw8zBpu2SHE+XZncsRMg3CBl2QNJgdiKx+H2IUGNhq6zG+dROxnB5ye/uow
         2Itg==
X-Forwarded-Encrypted: i=1; AJvYcCX5y0hVO1tMpidZ/qs6H602pu20X3Bpe2ml8TJWx25V1+2cLwHsFrVoV0ZY0wiQ9SSSmOcOCtiE1hNNBu7aVVY6qbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZMEABrjk0dAQN7JCrvOvXbl5TPMlkZ56ol1+AtoxH4JFSvPcz
	kR3yktmkJinAF2lMXA0wyCGYTD7BMFjmz0G3y17EPehih4BNEoFXqFfZE1tAZ8biiLB1+7mD6pX
	yXVfQD2I5w9h1gsalCJKzdSd3uM2SlgY=
X-Gm-Gg: ATEYQzwI5G2bHniZivWjzioy7Gi+3tToFLmh3Jw/EFlf8QijemJbnrHs/5sml5g4Y16
	UAJ2+cClrsBE8owmoUXDg4omnjDfk4z2FWSZo2WBBPHUwpYXe6N1M0ozD/cwFv6TUEebe37wL4b
	nDPx8V0OovB7TdluXmA/igwMeiRUVBwVO/+wP2StxPJmocPZeA52kAWGF/m5f5oKgu6poijwU2e
	N0LeAlrpYblIh5fPsBOmelLgAW9FXKVoemUdU5VP6I8oVimSPw3ibe3HONvxEd3EjjNBU7wctSr
	nPH+lwa2
X-Received: by 2002:a05:690c:d96:b0:796:3d5f:a2c8 with SMTP id
 00721157ae682-798c6c274a9mr31734047b3.21.1772678016033; Wed, 04 Mar 2026
 18:33:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304074650.58165-1-laoar.shao@gmail.com> <20260304074650.58165-2-laoar.shao@gmail.com>
 <20260304090249.GN606826@noisy.programming.kicks-ass.net> <20260304095415.4d5f2528@pumpkin>
 <20260304155742.7b4de2d1@gandalf.local.home> <20260304214447.3e5817ea@pumpkin>
 <CALOAHbCOynnRdc8JkNJHb-nyoerrz0K5GUhnD8OR2hv4x==5LA@mail.gmail.com> <20260304212802.458b878e@fedora>
In-Reply-To: <20260304212802.458b878e@fedora>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 5 Mar 2026 10:33:00 +0800
X-Gm-Features: AaiRm53aCsDXjaWwJhIMrzV2l8_S6HGgo3u5_su8w8JGRp5Idp54WIy0bpLVxTQ
Message-ID: <CALOAHbBA643_QOsnTmrfjKE71hSa+v1cToiELvGk+vjtcgJsxg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] locking: add mutex_lock_nospin()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: David Laight <david.laight.linux@gmail.com>, Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, 
	will@kernel.org, boqun@kernel.org, longman@redhat.com, mhiramat@kernel.org, 
	mark.rutland@arm.com, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 10:28=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu, 5 Mar 2026 10:17:09 +0800
> Yafang Shao <laoar.shao@gmail.com> wrote:
>
> > bpftrace is a widely used tool for online debugging and dynamic
> > tracing. However, sysadmins may unknowingly run multiple bpftrace
> > instances concurrently without realizing the potential impact on
> > system performance.
> >
> > If this is your answer, I believe we should clearly document the
> > following warning:
> >
> >   Warning: Do not read available_filter_functions concurrently, as
> > doing so can significantly degrade system performance and potentially
> > impact production workloads.
>
> Or update bpftrace to cache that file. It's only updated on module load
> and unload, which isn't done much. There's no reason it needs to
> constantly read that file if bpftrace is being used constantly.

Other tools may also read available_filter_functions, requiring each
one to be patched individually to avoid this flaw=E2=80=94a clearly
impractical solution.

--=20
Regards
Yafang
