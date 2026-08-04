Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342FF40D590
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Aug 2026 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785854758; cv=pass; b=YXXCs549p/v6Yz1UA/SIk1SZetk3YBukDUeKAauR4ufqkyjpFHloGbraQhgDrTr9Ln3Luo/fGSZ8tmBWFHFc37tL+BfIIBErbAOKwWOWs1/fZugQkPWCvv4AWWcBa3WoRwHlpeghZx9WK84IB9Yh/VejA65zJQWab4sFMcZm3oM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785854758; c=relaxed/simple;
	bh=ztSaoUfMVezUsDwkDcA8OfphYl9+J8Z12iVlxPqy/tc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HeX/4pxncdbrdjRByak+EjTX3eS2oOEoxN1yMd8IahUCCkeWkLzzymSJEf9yOC8ufZvfCQexXyGlXlAslgXwWWotJrL/3B5ycXswW3qsuFAUSr9zrN0nYnorn5XKM8bsVvgYXd3lutiKKC5dD4TxVqvhFHgLlPG34Gal1KQwWqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TB+N/y3z; arc=pass smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TB+N/y3z"
Received: by mail-pj2-f10.google.com with SMTP id 98e67ed59e1d1-38dc4f9462cso1390597a91.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Aug 2026 07:45:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785854756; cv=none;
        d=google.com; s=arc-20260327;
        b=q+PNrElwV95Y7YGSqxTfL66ySRHmxtSZQlmeZvxWhOdDh+YLN4YQkWf1mQw9hh7WRh
         go+f7x8uHUzjruxKps+NGe2Qtmlpu0LQFNZRHP/ahiwRcuDBePSEDY++W7JA7WTPFG3j
         etoexTbkDYEG5ektPvAj/YCMVIZMttP+xL76filS3kyjsEOf/vxs5lVJ5cZ+3J282A1z
         pOb4ac/Z6wU0XJrlzgK6zo8VLWAhz66vqTuTNCIHUNvJ4t7qgcM7c+IBvj8xsDy/XvWh
         xJr7NNSHXcSAHNY/41u2spH5SYiMv2Xm8R/H7FoMYzqGqvFmw/PjKtqiZveP3/JmXhb7
         tPJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ztSaoUfMVezUsDwkDcA8OfphYl9+J8Z12iVlxPqy/tc=;
        fh=db3NWuZ9utT8kr+OyMGcKa67X2gK6x+pks0YB7MUIHA=;
        b=WvwoGbz0gY2EDufGNNNpSlILmzTGDQWd8ey2i4ZFS5/QVMU25c3uVxme0HCDJnXIPN
         By5RVQCS/BoXkGESdMURC37eigpIyi4B2sJeazJzUvaSC+mpLqkF55cwuuC3lv1+djhA
         PEJx3j1iFR/aR6+2sMlGeZxjAjBpCMe+pAdljUmZRj7U2QnsOFUaXs0r8koZbQmPu0TV
         VFSqz5zs7iZO6wO8WbYC/sP9YsRD07i+D1VD0u57ypQgq0cLDyID4CwKZjn5GRvHdkeh
         8z3pyU4kmaNpQOO2BcWj570BSXXwwNi1N9KJosXZdtUtq/zRameHt1CQtwyof/0zlt8O
         nMSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785854756; x=1786459556; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ztSaoUfMVezUsDwkDcA8OfphYl9+J8Z12iVlxPqy/tc=;
        b=TB+N/y3zKPWzhMOqzKFMBTA5TTJ+jE3XxywU0NuIrh21A7EPUwkMiCjLKniUTvY4DG
         J03gc/31Pq7uai+EhZV41j8NoMZeD42XAOZhijrYks9+mXHICii51clDQbGZ1ayBQnFD
         tk1bHsW99rqzgh/2eo/yzVXAgF2GPBAQRZAwpyoncBFKxMU/e/m33aiAyhb5wlT/tmoC
         B2Ah5CY9VHTW/yhFjKuKOrk28uE/961J7Q7EAvXDdGk1y1i9eRBhZWkFf2OwbePmmyvB
         XSv1N1OJfWfXX2bzaEwjhY4aIkFxqOpVPPazY0qzJIi/+NsFIdZT5ir+ctJdgNq8iHxV
         TI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785854756; x=1786459556;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ztSaoUfMVezUsDwkDcA8OfphYl9+J8Z12iVlxPqy/tc=;
        b=mUUDmB2d2EJ+/XZzwjS5T9b2GvGt2DZpTVSXYVAY4+d0ARULnqKm2D0ym/n0OpqSrD
         9akuSmEnK6ithKYqiwhhJ9PmyLbg/9SyRrkHE4qRUtpumta59WY+XC0wpUDK+AwHKMa0
         1P45cQD1f7Rlt9oyU2oUdpYSRKtq4KcWYuTStgmrMnY6+NYkWC6y8pGPa+vWUn5zv9IF
         +RpPr7426V5pR6OVd4ck6n9AexHlAMXHBRA8g8Xo6BbSMr4v7ywiAAt1/IjR4AaSv/ae
         rF5/jA6HR3E74Sm4uZJ7U2eMg8WeHCIw3axR/5jgjobxSOJPN34ELuCh2wJ8U1/ZDyg9
         Xmhw==
X-Forwarded-Encrypted: i=1; AHgh+RoztR9EcumkW8j8/Juu+5/J9lyahsXBKJ5T44gMNcqwspQAyJQwP+XhZUpsD2kIix45zO2M9sSG7B8lcCOYqIef06E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG1P2ocKwGKLXrKSjYaL1dBMLQgvoCudnIfKxSPv2ZcdFgQXw7
	ADRdtKmWjrJKJb6eup7DWQioB0NMRstyOngYW7Pmn2U7/ypVKd72vAQjMERU5U2LjpbwCqYTrp5
	chXFrZxbT4bIJchKE82Z3bQMCNaIL96Q=
X-Gm-Gg: AR+sD13CBp2c+lVOxPUmNMr1rw3dcdbUGpv6ceRFDYkjMNlhqxsgDwqhlZ9i73pZDl2
	fZUkjd0qaQJtf9j/80ni8rJ3K23/6hLoZSy+eXTYvV5YoxDu268W0CEoEoyU8mZb5VdmwOjhpnq
	i1rqF/vpw1K6F8Gx/fKt6SHlxf3gE5zcb024YNg84CelcUSDzKPObfIkONm4NIxyB1YTNz2TJn5
	jplHfHJ676Mslp8tKRV0mV9P8WumYvWssFIQ2PD7BaO7/0QGdNacBcCwztU09nq8cF21qEdP7Eo
	85dz8WIWtSd+Yio9VX/wjzuFp4uAlWPMjApbmCTiBTaE2w==
X-Received: by 2002:a05:6a20:6a10:b0:3c6:3c5b:f2e3 with SMTP id
 adf61e73a8af0-3c92a62d94cmr15620433637.33.1785854756552; Tue, 04 Aug 2026
 07:45:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803-fix-lock-tracepoint-bpf-lockdep-v1-1-91fb7afb526a@gmail.com>
 <anEuaSqiCVsQ6I4P@zenbox> <178583246611.3252194.4318729338489544399@noble.neil.brown.name>
In-Reply-To: <178583246611.3252194.4318729338489544399@noble.neil.brown.name>
From: Quanye Yang <quanyemostima@gmail.com>
Date: Tue, 4 Aug 2026 22:45:44 +0800
X-Gm-Features: AUfX_myq83VVn48ShEyGmTjvf-TWPUcuekz03-F_pf7Av6LHmdejBcY2Ac2RQiU
Message-ID: <CABcBDJuznu=BgDhevsD6PybX8+6fcaO1xyTcuGuv8F_+MfeZoQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: disable lockdep while running BPF on lock_release
To: NeilBrown <neil@brown.name>
Cc: Justin Suess <utilityemal77@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Emil Tsalapatis <emil@etsalapatis.com>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	syzbot+ef8d17bae14efb960935@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 4:34=E2=80=AFPM NeilBrown <neilb@ownmail.net> wrote:
> I know close enough to nothing about BPF or trace points...
>
> Can BPF programs ever block waiting for a lock that is held across a
> tracepoint?
I investigate this and I think the answer could splits in two:

Mutex (sleeping locks): no, this is prevented at verification time. A
BPF program attached to a tracepoint is non-sleepable --
can_be_sleepable() returns false for BPF_PROG_TYPE_TRACEPOINT, so the
verifier rejects any sleeping helper; and at runtime it runs under
rcu_read_lock() with cant_sleep(). It cannot block on a mutex held
across the tracepoint.

Spinlock: yes, in principle. Spinlocks busy-wait rather than sleep, so
the mutex protection does not apply. BPF programs do take spinlocks --
each map lookup/update/delete takes the map's bucket lock, and
bpf_spin_lock is a spinlock -- so a program attached to a tracepoint
held across a spinlock can spin on another spinlock, and if those form a
cycle (or are the same lock) it is a real deadlock.

That is exactly the hazard BPF already hardened its own locks against:
the hashtab bucket lock and bpf_spin_lock detect recursive acquisition
and return an error instead of deadlocking (rqspinlock, succeeding the
map_locked approach in 20b6cc34ea74). The rhashtable bucket bitlock has
no such protection -- which is the gap I think.

quanyeyang
> If so, then attaching a BPF program to that trace point could
> trivially cause a deadlock.
> If not - then how is that ensured?
>
> Thanks,
> NeilBrown
