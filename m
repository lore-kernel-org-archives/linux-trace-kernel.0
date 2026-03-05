Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3246B2741A0
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Mar 2026 03:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772680143; cv=pass; b=VADt8Fqp3t1OEIfPGNKHmO4mUuyl8hZArUtZh1k9G2E/CNKpvHPD7/CUnFvqjJqDEpkvJV9NvjpGr0oTO8Ixmy4iU6afOsrHb/mVUggUtp0EEn3MA70uu2cLOZwJd1xf5VFB+xKpDaEgKZbZUGgIZJgy2cm0JvQ7WG40g9HRdPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772680143; c=relaxed/simple;
	bh=/RXKF8vMBInNsVmDKCPKFPDTkDh01VzBXYdnyYDx3B8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AY7IKg2aSzVp7rU+3Kp3tyFq8mpPdwmifd9wwHV+wAzi7lOZ8LoGpMNYGaFixe+gh+3+fxqJA2xupInnr9+wkniZJM2KVtPRhDji09UVGxTbpiZspvSuEFx8g3C7C54LXjRgTPbCSINCsOEG0UNc7fWmLer/mlKXy/G00oMN6GU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ik3+Tzdu; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ik3+Tzdu"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7986e538decso75907147b3.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Mar 2026 19:09:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772680141; cv=none;
        d=google.com; s=arc-20240605;
        b=K5hfUrBMtW+XJ6zXPlT+LXF8xS0faloGwXu0ssOdeWEi14rnsoan6JJmP6Yl3VEPXN
         lLz7i5WIx+GOGZIHeIaAm8FZRG1IdP4qcMU5H96UHitLiPZPiOYZKTvQvY/ZOr/84r16
         PI2JvT108zcuv73HfHYOED3R2oQkbhgVwUktE7j0nZ3PmOkWco7kmerIz+qtuJJ7lKv8
         f/STnFc+DpxraZpLRlcXodB9A9CLNSxF5cou0FTFOyHeUVwIMKs6VNHgBA3NJR9MG62p
         KSQoHa88oS+KkxKOhrhe3sSrsm7sebKTG9SKbg5pzULDxRNwPNLuxQTCHzbtQmo+JNrS
         zeUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/RXKF8vMBInNsVmDKCPKFPDTkDh01VzBXYdnyYDx3B8=;
        fh=vgYjFNsYVQvf3idX5tkBbhFVwWY3rY90bH1DRd/knGc=;
        b=Mafyg/b3YkurXYCQz4tzyEF4bapikj8lZ4vK2VzgBy/gk89LxyqbFQCfNVo2ByspC5
         RMRYaobxX9g+ZEk/hbcp4pdc1U/vSrINYFY4HVY2ZeLwqeQ7SbepZdZGac12oCyhDBe4
         ahgKb0R2uvUF93k+RYAJfpEvTTqg2vS49VLqD01RPf9IuDlVCfXzeADgnnG0qUN0GoS3
         UFCRTL9n30d9k8T6b/8FCm710oRhzjXjO4LjjikPwrlRmDpUBOVrAzwmEUFrzn9R/JwM
         oDybcatuaY1FuAx6cMJD3lbUs85SARS85xJRRRw9ef/WfF3MgvxJJi8bPB5Z+MsjjLv+
         eJ3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772680141; x=1773284941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RXKF8vMBInNsVmDKCPKFPDTkDh01VzBXYdnyYDx3B8=;
        b=ik3+TzduFk6YCuLj3lduxyk7Jwvn4/087pdwqxMnPYTK5V326VKy2enLZLZWGroLom
         wuDUEi6XF0Kb4g4R1RLTONyzgSnlRzTtVb5v5TVANM9XKtZv1+MK9tuSz+0IoaX3MH/e
         +QTbAApGUtkerfYpjXLcLGf+CZuf5oJi5Jo5I4Hdn8Je8CtyLK9LwOf3wRFK1j3Zz6XO
         QiWXxdJN/brD5dOouKdQNPZrp1kuQrTVomNq2/Eq+0Rd6JaMTr6SQygQ0EKO1Rfc9oRJ
         G4umNOa7zc+ajbuqEwIB0/BhkOBYnPem4Jo/2Gc7+DcVQcX5EZoA31Ml/B95GY/MD4x+
         3cuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772680141; x=1773284941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/RXKF8vMBInNsVmDKCPKFPDTkDh01VzBXYdnyYDx3B8=;
        b=KqSRNgNtLtbPERBZgSY/Y4xAFQli2lgogpJpPsiITQWqpoMSntGkJ6b2cr3hWSKxuO
         ysGTLqmCAYT+8KWZlRPeHsK5UPSioLBc0fQqYPG/SwZYLyiXJu8HNmxN3hzpA5/ZYCpc
         COFFJVrIKW1+Ai7eX/uFruvkuEivNsKDk/AJbaTLgvGxakUcmvrdN76A8twhR4A0gkK3
         Qv8X1uALuyPkOSBk22PIHbgGh9O4QBbQVDzF2pVcVLdgyY1UyJxI6BqOR/pl5reloqe/
         9KY2uxB2PD753R4p907WjU+Ly8zFW6oZmlI/kfsG/9ozfQ/r/Z3qNaeSQVN2Y5aA7w1Z
         n8gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZcFLuO9WYD34KcEzCmhJEnTOaJGfbx50t2Rnn2fTNFQ0xIjY4WhfJ/gdrI64Nh/V1rjrWWi028XJKguJXqfFTjRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXlBv1D9mBiChUBC/4rc4pg+jJkz7QNa++uNn/LwJFdlHGvpFK
	AyBTZC0zPo6fu0N4rIffk1v3xMM1kGu6JR1l9IbGblri2pp0Nvhz35uRfvRzp+DbvEVmTLH9Li8
	soZvjLm/dfySCVTKqnODYNw4xgKh104o=
X-Gm-Gg: ATEYQzyEPZHN4R2+SwitoqIvBSd9ZGLsCxXUzJLPKhkAPqoJ8NZGE6jXJqgUbhOcRkp
	e6hkz2CC0FUkGrhOPOXqEYcArZPw09LFe6Aebv6sGa5OYTXSCD8TCKyZ60eN4I9lospG/ftm2oM
	7QV4elDGbFm3J68cUnOn4qjHUxDaqYV0lSnOYkwSFh0gjP+quEyRIbBzf7UV1QxoQrQizKhCc7H
	M/5dfKScgGwR4LfoSR4TwzwzVJVNp2V16xZx/M1MjYoTCRQFSum7eBRJh6CE/aX4rFt64sX8ZCp
	kpaLrDVx
X-Received: by 2002:a05:690c:60c7:b0:798:3f7:83bb with SMTP id
 00721157ae682-798c6cf97c2mr33006287b3.61.1772680141182; Wed, 04 Mar 2026
 19:09:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304074650.58165-1-laoar.shao@gmail.com> <20260304074650.58165-2-laoar.shao@gmail.com>
 <20260304090249.GN606826@noisy.programming.kicks-ass.net> <20260304095415.4d5f2528@pumpkin>
 <20260304155742.7b4de2d1@gandalf.local.home> <20260304214447.3e5817ea@pumpkin>
 <CALOAHbCOynnRdc8JkNJHb-nyoerrz0K5GUhnD8OR2hv4x==5LA@mail.gmail.com>
 <20260304212802.458b878e@fedora> <CALOAHbBA643_QOsnTmrfjKE71hSa+v1cToiELvGk+vjtcgJsxg@mail.gmail.com>
 <20260304220019.3efa12ab@robin>
In-Reply-To: <20260304220019.3efa12ab@robin>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 5 Mar 2026 11:08:25 +0800
X-Gm-Features: AaiRm50PtdO48r9cLOL_WD4Ghivi25JYvibiyA2rswTS6fmebhZiuR-YD71P3ks
Message-ID: <CALOAHbA4Dtc3cXs2JiQ=kxES3kT+Acb=amUxkOvQ22fns-Mqgw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] locking: add mutex_lock_nospin()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: David Laight <david.laight.linux@gmail.com>, Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, 
	will@kernel.org, boqun@kernel.org, longman@redhat.com, mhiramat@kernel.org, 
	mark.rutland@arm.com, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 5, 2026 at 11:00=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu, 5 Mar 2026 10:33:00 +0800
> Yafang Shao <laoar.shao@gmail.com> wrote:
>
> > Other tools may also read available_filter_functions, requiring each
> > one to be patched individually to avoid this flaw=E2=80=94a clearly
> > impractical solution.
>
> What exactly is the issue?

It makes no sense to spin unnecessarily when it can be avoided. We
continuously improve the kernel to do the right thing=E2=80=94and unnecessa=
ry
spinning is certainly not the right thing.

> If a task does a while 1 in user space, it
> wouldn't be much different.

The while loop in user space performs actual work, whereas useless
spinning does nothing but burn CPU cycles. My point is simple: if this
unnecessary spinning isn't already considered an issue, it should
be=E2=80=94it's something that clearly needs improvement.

> With PREEMPT_LAZY the most a task will spin
> in the kernel is one extra tick over a user space task spinning in user
> space.
>
> available_filter_functions is definitely not a hot path, so I
> personally don't care if it were to use "nospin". My worry is about
> adding this "special" mutex for a single corner case, and I want to know
> that its a real bug before we add something special into the kernel.
>
> -- Steve



--=20
Regards
Yafang
