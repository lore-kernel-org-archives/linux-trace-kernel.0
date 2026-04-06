Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286B33290DB
	for <linux-trace-kernel@vger.kernel.org>; Mon,  6 Apr 2026 10:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775472954; cv=pass; b=liOLi/LMyw7cahFtFd72EYit5ZLJKs/1E1XCHgAv59gS/Gwlvctaph1hSavHkvAnfaLanKAGMb8FQxEsLimpHztqwYkDpvaV2Ju3pd20YCFSt6lciv6FqjHFUVMxpYBUb7AiViSz4bpgdQ7azP7+xonLjmS5kor6SfFGMWknXbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775472954; c=relaxed/simple;
	bh=yqtwijJFAq2Vipx/7BM0rX+3bcBaOGswp9DDHJJf19A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kVrtxHbLwjnJfRnFM2oe11d9iekzBiJweuvVYDu/NoJpBjCRYmA7inZtoaeEsj56DhQQdWeeEHiJN97XmzlQf8EqusybNQ7VzYZT8rgwMReDRCWvUzWBiqvJTi0WKQB6Hw5SkaOxZftyBvwAze+/TBGg6f9u4xDnmhWHSkcp7ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aa3n5j/D; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aa3n5j/D"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6501547d7edso3677773d50.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 06 Apr 2026 03:55:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775472952; cv=none;
        d=google.com; s=arc-20240605;
        b=Z6NNcGi3MCrxPQk5onnoWN1myCWYWGCkCjk/bjaHtZjUHEldLk22Zc5jZSZPfeRKVJ
         9UgNhMO3E6nlpdAZ6pkBFQKLihjm8ZBgy3fcE8IZchOKlzY6YcBcDO2Ae+l4dSEsUiGo
         165QtCofeNWdQ9urVmbQe1GkN7Hp6DTwNTJunWD1miwrsQ9uJ8TAZjwr92zw6wVF9pko
         0NNoZb8CA5qFTx4DKi7nt62RQJA9cjkFk3ao7QXkMFVBBbn7/aRTlxakYamqz1YoWhhl
         RINtpgx/h5wOfka7MmM43fGJ75Y+wypwAg6W4SJ9fUdAagNUWJuRaF4SESwrWG7FN81c
         ewFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7uq6NOmuMF5oFq3KCbCddyHNt0qGPgVd9ZLN7F8nbAE=;
        fh=H2PCLPPCnS5pC2YucwwYG0rL0Z+sBbjiQ9DJxRtISTk=;
        b=Q5ZD27dBx8m3Hz3iik+V1RjEv3Df3ZzjNY0m+0zoFieUkCyIfGaHBAFcmOu2bU4quo
         RuBUFn/c3sAe9nYQUZh0pPFUt3Du16JuxijF1da+sj11LVR6CPEbHM45f2kdjmkKppmM
         bvaYEbInPTV71+arSioy98cVOIFUuIOlndMDVsLAzfwGEsYwl2LQzvXwDyj8y90+Wldj
         hB3hLVejMIEFDgUYcyYsPalpYXwkbHADpMDKbRlbslunhz4yKGcesN5lmmctZvfd5GaQ
         U6MO+ZcuPpgh4OOvmbSjPYsSA7333worE0EHcMQ+X2k5ewS4Hw9uJvkTv2GUa6a6iVwx
         VgTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775472952; x=1776077752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uq6NOmuMF5oFq3KCbCddyHNt0qGPgVd9ZLN7F8nbAE=;
        b=aa3n5j/D15RKLLEqR7to+GtxRAGugLHhde/cNcdw2n7LGYBdwRAHAjMAdRqbnbDP1i
         7DF98zVf+wT3iy5LrysjBm1on0an7JDysMAtLEx2NIwI3yCnB+WuUhs6FdaZ5uELrOV5
         qWqB0KU+Fos4hz7W/17uTAlBctEZRSrWIXVE+qKC5arkCQJaZ58MdOE0D5utVNMLnswe
         c7GnIcoiDSYaB/oETBk1FF4k48pnNtESF6ogwUak4rnEj70GC+ipG+ej6rNVgyicuKkF
         alhzu23eVnFcSIz5NzqNDX25nUxBrETs9OaH1qxN9E5D00/gUgGDQ5nr8qFBeAXEj9hh
         SMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775472952; x=1776077752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7uq6NOmuMF5oFq3KCbCddyHNt0qGPgVd9ZLN7F8nbAE=;
        b=UDK1s25A4pX65YzuvqSAid8r9nkDfNA3+rK/wRXiSZtaKalr+u3h1SVJBKYsXHJJU/
         QoIMkLaGoWQ11wi3Cud5lwoWcFPy5COden/7t0LaVzambf2N7Jr+xkRc1/XqZrV7ZKZe
         XRmRE4TRk3ov0ypce1FDh75clY/zmAIWyDhrF9PnLwejO63pNbyQsRl/3gvEkQeumvTI
         eWNzQNmpEPK6u0bihyLcb7UczpXlOOhfoyrIRGIjiR85uZdGoSjQ8Z1OBKyDw0dsmEgz
         9xHQ/K+KLqL2QWn47bde2BkjdDoclDFrG390e421y/ZEljo/zj+OwfankpY5WAbF8OkJ
         u4kw==
X-Forwarded-Encrypted: i=1; AJvYcCXYlz8+LHASJJ0MAwU020HRXUDeIgJ33iU0gWbnuMA4kS5tC1aQN2ccrn18MTbat97DqiOYeMm4oBTbGgmBKa1NVNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI2md2pFkzmoLVUwTDp+7QAzmiyqLHsxUV+87/Ln34RvK0AQvG
	/AQcsdiRawh6iphT2S3Ogq82Ol1/JVYJ4pAPEekuRh+Vgx11pTCD4V7IsLaur8Xljab5s+RyN6N
	BEZNvFdFrIWtB5p8IHrHm5pTd8YLjdbc=
X-Gm-Gg: AeBDievstAZN8bCnqEHRDgREcMmgO6DRyVa/AkIUUhskrsNij8IYQPer1iwAU/P49Fc
	RJewgZ6YfSpskIYdgeVpx3Q8dnQ0PWIud4q0+gkCh2PfxGetjEbWAZJESCGTfMLq4UN4eHoGgN5
	E2RSkJ3O1NkkCjzWDsRNpwnutcycY83YmeyTwmiw4tctsenvF9+tv/02GMjOGtO/SjRbaTB0hUl
	mzuv7S6VUJjh32FeKHpJAnkYZlvxqRaJY5uM6LGit6O8++56jp61aXJXb+vre2rZfmPSXAUWgWr
	swS7cyMS/UDxMO/8lpumSzmC8JrQZu6nf0VZ088=
X-Received: by 2002:a05:690e:14cf:b0:650:17fe:1a9c with SMTP id
 956f58d0204a3-650487755d2mr11770998d50.33.1775472952117; Mon, 06 Apr 2026
 03:55:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402092607.96430-1-laoar.shao@gmail.com> <CAPhsuW7Y5KksWM49TrGH_Hohaq02XO8qs7G99Y6D8=0usLFSrQ@mail.gmail.com>
In-Reply-To: <CAPhsuW7Y5KksWM49TrGH_Hohaq02XO8qs7G99Y6D8=0usLFSrQ@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 6 Apr 2026 18:55:10 +0800
X-Gm-Features: AQROBzAue1hvnBCCEMF_NUELA-CKaaUqDrVovMjW_KAS9zf6eAY3_xH0-Hp_7YU
Message-ID: <CALOAHbDG8=eUV53kF+xn=izs2rpydCk=a9RznU-EEOzmkB8mQg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] trace, livepatch: Allow kprobe return overriding
 for livepatched functions
To: Song Liu <song@kernel.org>
Cc: jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com, 
	joe.lawrence@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, kpsingh@kernel.org, mattbobrowski@google.com, 
	jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, 
	yonghong.song@linux.dev, live-patching@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 4, 2026 at 12:07=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> Hi Yafang,
>
> On Thu, Apr 2, 2026 at 2:26=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > Livepatching allows for rapid experimentation with new kernel features
> > without interrupting production workloads. However, static livepatches =
lack
> > the flexibility required to tune features based on task-specific attrib=
utes,
> > such as cgroup membership, which is critical in multi-tenant k8s
> > environments. Furthermore, hardcoding logic into a livepatch prevents
> > dynamic adjustments based on the runtime environment.
> >
> > To address this, we propose a hybrid approach using BPF. Our production=
 use
> > case involves:
> >
> > 1. Deploying a Livepatch function to serve as a stable BPF hook.
> >
> > 2. Utilizing bpf_override_return() to dynamically modify the return val=
ue
> >    of that hook based on the current task's context.
>
> Could you please provide a specific use case that can benefit from this?
> AFAICT, livepatch is more flexible but risky (may cause crash); while
> BPF is safe, but less flexible. The combination you are proposing seems
> to get the worse of the two sides. Maybe it can indeed get the benefit of
> both sides in some cases, but I cannot think of such examples.
>

Here is an example we recently deployed on our production servers:

  https://lore.kernel.org/bpf/CALOAHbDnNba_w_nWH3-S9GAXw0+VKuLTh1gy5hy9Yqge=
o4C0iA@mail.gmail.com/

In one of our specific clusters, we needed to send BGP traffic out
through specific NICs based on the destination IP. To achieve this
without interrupting service, we live-patched
bond_xmit_3ad_xor_slave_get(), added a new hook called
bond_get_slave_hook(), and then ran a BPF program attached to that
hook to select the outgoing NIC from the SKB. This allowed us to
rapidly deploy the feature with zero downtime.

--=20
Regards
Yafang
