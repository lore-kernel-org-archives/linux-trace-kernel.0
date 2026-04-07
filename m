Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1125E34B1A4
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Apr 2026 02:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775528543; cv=pass; b=knYgJt0IGApUIVfzNIjhG2i6rqyYCfcKyoSJSpuYIIOsmONfm1qHjga2iA3FXr2RxBe/99gVyPlgfqx0p3Y5rwdN2XOvuMVLc684KJ6RF03+xYCdG8MsqG0ruzpjxHwVWqC+7d2tsvfa45bN1eSoAkk5cUB2ZyLq8ZQ/XxOoC3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775528543; c=relaxed/simple;
	bh=NLGRqjeuKpGNc91JbpQik1MBmKlqX+MA4yQsWR41Rmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p6+zOC1DGb0lXL59DrqyXoj0gH4uZr+p6ioJMqYY/ng8dAWVzdOvOGseldTV5SGRY/mPmMdB3Tj6vheeX/zmMf9JJhhKR8IbCHoms29PWDoj+4+6i3JE6CcB95KchLzGZGULw3Xns3OvDZoVeA3S+AQdgFtbDSFW6eeEs5NP0Hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pbHA7w5D; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbHA7w5D"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6501c4857b2so2158141d50.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 06 Apr 2026 19:22:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775528541; cv=none;
        d=google.com; s=arc-20240605;
        b=J0VNZajImBw0/9SRHAw6QIt2W2c7ArFFValXJRLLDCCYUQBYVKESqJWSV77Gcg3bni
         kbZsGSH2bq0vSW5BpWOpm8nUAIX6sv6QSfti+Y6JwHv3zlnmh0ak2sHfKx8am1gYgWpC
         jOZPkKOe5x0IYUmr34UJjfOONvpUNwvdcJZqg9JVx+Yu6CcU6bTZPkY0ITXvCgViyCnN
         SRQJnT1gnISQX8M8Db+WQnY19b1sLtfPlLiywpNYwkBCee4IZ3tammLQ4KvQ6Bit0Nbq
         4sc/c3J+Le4VTWHe0dQQ7ut+rTMUd56EzwgH9jynPmf1QrKUPz/TMcObA1kKRM8s7b8O
         676A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hi0ALShgexmGG4t5YaOzHqoGmz/vsFovN1VLyQXTOrs=;
        fh=NcAAQvrKGn1IbVVmw3Zik8m8nhM5n7fnqdO2qIdjV/0=;
        b=VSeBR6dDV+zYJ2lJXEpDU/ugnT2P/yvePb7EaQbGlXx3PrEI9jL9J46m3zSmG4FD4A
         BwooZRSLxzKPbVbh1oXAKRRoaJqidd5sy8nY32aEwV+yj1VxUCn2Qz2JAn6JVJeQLSZt
         Q3hXK4uGEpHa/4YV7nCKIB84/O1JunOGRnlkfGGvOjojZZ7LuolaXpP4FyYIQbmdC97d
         806QtopL3WLSUro87IHmnMQ8jfzVlPVU8C194Wgme7MuaPan+x4mguMHk6BlB53fMxom
         lACUlldWJbOjXOIi87yF9JwrAFnugwCjS+PlK5chNfFIHCX41P8FaJPsaD1YqFX/G8oN
         OONA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775528541; x=1776133341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hi0ALShgexmGG4t5YaOzHqoGmz/vsFovN1VLyQXTOrs=;
        b=pbHA7w5Dek9gqYazNwXy8Wev2rvy9OVweUsIbi+wRfrskH12GZbkNUvVLVp1G75SSl
         xdihA+z0qyOP+JcYV940qHTv3HiyybT+50NATYRfV9jslA5bgmBDcaA9E/yXk7dfuoY3
         4FZ5I2hI6lnVWHXTYg2m7KOFifM3pvBX+gsHuVPyR/mD8JwFavJ01hzUkUHZ27nvXVY5
         Yj3Nr4q2ocH/LHlrpNX9ft7Z2RXUt/pqTP2To9ApkYOHXrr1lXMMQHezW+qbJK9aHH6i
         q/stAYMHjDNjYreNhcNBEEgNLcilP/Ga9bIfOemsgrhH3rctNv+oIjDT0urzFOULbSSq
         XwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775528541; x=1776133341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hi0ALShgexmGG4t5YaOzHqoGmz/vsFovN1VLyQXTOrs=;
        b=bxDgbB4Ki0keMbs1FzCHhrM2Mbqa6d+RCsitymBRn8IEZxI6qzgk2UvbcQVIUX6pQS
         dfIEPuylWHx1cJTRd3EK8CC6sLaOtrQ+/Z6hmpw3BNFyWKr3er3H4HyG5eXiPEp0SU3a
         f1JUkaBNxpUQDapL9LbKL8RDcDNqktXtUaEqvo+dzLYOqHby6H4hrXpsyjxxCclnKDlo
         37lEa4QxjyPks4YTMfW5sUN3uliDzXarwrKcM1E6nDG7JiiC2WWPRcvkZxiWVejVg2h+
         CgiP6yzurSTo7esXbE3J99rk6NrGnS5EmyXHKhko1PkmJtjtHub13MHPcq+P69pOAuaG
         nguA==
X-Forwarded-Encrypted: i=1; AJvYcCW0lK8iObGc0eBmeH00pu7dfi5wtU3qd2NnvPqthapcVPAzczpXgEdv6mjn2WL3TeCNhF/4oCws61q8jz26k2Me+Os=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnFRhZ5bcUN8kG9hms1v/jmHcLGI6rHMcvGxTfe9OKrvy+tACA
	WasLMakmFsHtXuaNCgiprN0X8CR2ML+6woWW4gmYC7SCJoKg4U79OG73Ki87f+EAmQNh72L0Sg6
	7wCXEwiwwkC3kr3wkyjieSM2hsUA1DY8=
X-Gm-Gg: AeBDietwG54kLKY8fpXRMQStNUtApn7FvWlLiD9uWVo2SNtK/n50To6KYj6/cnFczKw
	HrIGFY3xz9Cr99wUB/fvLFvvQ3zQz9ArWjm+6SzuLxYG39s+Y7y9jWUVUc35ZNQIydDCUSwrBTw
	LWQtro5Hqo34RXHJFMY6qKDF/Rja6tm4YUXfKoC+hZPsfe/lWFLjlRUoK3Yn6+wi4CMjl6cqO6f
	yZJ/kH2ezlWalTUkTEnrQ/nRF0MU/jhBLpNr91O4Aj2aTUxLezPbMfu881WkRi7muD9wrjbzXkz
	yRjy09IzzY9iCaj98VBPhxC0g8CmRSLBOSbCxagzPM3/U8LPJjw=
X-Received: by 2002:a05:690e:4841:b0:650:42ea:26da with SMTP id
 956f58d0204a3-650486c18c3mr11636012d50.4.1775528541024; Mon, 06 Apr 2026
 19:22:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402092607.96430-1-laoar.shao@gmail.com> <CAPhsuW7Y5KksWM49TrGH_Hohaq02XO8qs7G99Y6D8=0usLFSrQ@mail.gmail.com>
 <CALOAHbDG8=eUV53kF+xn=izs2rpydCk=a9RznU-EEOzmkB8mQg@mail.gmail.com> <CAPhsuW73qFybHgOnZ=oFC1PvdWkYWDk7gsAoiBXe4xWYagPrmA@mail.gmail.com>
In-Reply-To: <CAPhsuW73qFybHgOnZ=oFC1PvdWkYWDk7gsAoiBXe4xWYagPrmA@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 7 Apr 2026 10:21:45 +0800
X-Gm-Features: AQROBzBkgo3KxI2MHJmBlrvcZpAG1jaYfSLmu1S4rqwNflNyNo9B1VXQaeJKRX0
Message-ID: <CALOAHbC0hqk+yrUZay01EBRNOHgyj1MAavzNK-06XJKK9ARMqQ@mail.gmail.com>
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

On Tue, Apr 7, 2026 at 2:26=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Mon, Apr 6, 2026 at 3:55=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > On Sat, Apr 4, 2026 at 12:07=E2=80=AFAM Song Liu <song@kernel.org> wrot=
e:
> > >
> > > Hi Yafang,
> > >
> > > On Thu, Apr 2, 2026 at 2:26=E2=80=AFAM Yafang Shao <laoar.shao@gmail.=
com> wrote:
> > > >
> > > > Livepatching allows for rapid experimentation with new kernel featu=
res
> > > > without interrupting production workloads. However, static livepatc=
hes lack
> > > > the flexibility required to tune features based on task-specific at=
tributes,
> > > > such as cgroup membership, which is critical in multi-tenant k8s
> > > > environments. Furthermore, hardcoding logic into a livepatch preven=
ts
> > > > dynamic adjustments based on the runtime environment.
> > > >
> > > > To address this, we propose a hybrid approach using BPF. Our produc=
tion use
> > > > case involves:
> > > >
> > > > 1. Deploying a Livepatch function to serve as a stable BPF hook.
> > > >
> > > > 2. Utilizing bpf_override_return() to dynamically modify the return=
 value
> > > >    of that hook based on the current task's context.
> > >
> > > Could you please provide a specific use case that can benefit from th=
is?
> > > AFAICT, livepatch is more flexible but risky (may cause crash); while
> > > BPF is safe, but less flexible. The combination you are proposing see=
ms
> > > to get the worse of the two sides. Maybe it can indeed get the benefi=
t of
> > > both sides in some cases, but I cannot think of such examples.
> > >
> >
> > Here is an example we recently deployed on our production servers:
> >
> >   https://lore.kernel.org/bpf/CALOAHbDnNba_w_nWH3-S9GAXw0+VKuLTh1gy5hy9=
Yqgeo4C0iA@mail.gmail.com/
> >
> > In one of our specific clusters, we needed to send BGP traffic out
> > through specific NICs based on the destination IP. To achieve this
> > without interrupting service, we live-patched
> > bond_xmit_3ad_xor_slave_get(), added a new hook called
> > bond_get_slave_hook(), and then ran a BPF program attached to that
> > hook to select the outgoing NIC from the SKB. This allowed us to
> > rapidly deploy the feature with zero downtime.
>
> I guess the idea here is: keep the risk part simple, and implement
> it in module/livepatch, then use BPF for the flexible and programmable
> part safe.

Right

>
> Can we use struct_ops instead of bpf_override_return for this case?
> This should make the solution more flexible.

Upstreaming struct_ops based BPF hooks is a challenging process, as
seen in these examples:

  https://lwn.net/Articles/1054030/
  https://lwn.net/Articles/1043548/

Even when successful, upstreaming can take a significant amount of
time=E2=80=94often longer than our production requirements allow. To bridge
this gap, we developed this livepatch+BPF solution. This allows us to
rapidly deploy new features without maintaining custom hooks in our
local kernel. Because these livepatch-based hooks are lightweight,
they minimize maintenance overhead and simplify kernel upgrades (e.g.,
from 6.1 to 6.18).

That said, we would still prefer to have our hooks accepted upstream
to eliminate the need for self-maintenance entirely.

--=20
Regards
Yafang
