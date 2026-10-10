Received: from mail-dl2-f7.google.com (mail-dl2-f7.google.com [74.125.229.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4B910F1
	for <linux-trace-kernel@vger.kernel.org>; Sat, 10 Oct 2026 00:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791591030; cv=pass; b=F6MpKpv1HC0SC6bJxn94F5YofH2aCZ+X54hFFj2OMCA08i39zfZKFqExWUMaoNw6hEtsTjd4H6n2c9ufiAxnbsALiz98xdtx75c4GyJHpYassaIMFJ3lNFClF2QXyqE0UdVoTyYuzWoiBUgEMCDaL+TKh+CwvK1oLn/Y7j9Wz4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791591030; c=relaxed/simple;
	bh=VDF3hQxEsXwOOEKMR7uFIu2BM583vjfhY7iLbnx2e6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4BSci3I1wZCpbg+WGU06CVqPeauiAgoLodRanu3ynWbyRrafLS8H+oSPkp9mehmx2u5/jQqxuLWaYHmLE0vwO3EDmqi5vLEhjFLuL5zaBApUT9qqkandQ1nEFz7is6tzhMYL3i8z1ilanmm6iWoxZpciWu8jlNSUlw23fip2TE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tAb0lZ2t; arc=pass smtp.client-ip=74.125.229.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tAb0lZ2t"
Received: by mail-dl2-f7.google.com with SMTP id a92af1059eb24-14345ae29c5so180498c88.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 09 Oct 2026 17:10:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791591028; cv=none;
        d=google.com; s=arc-20260327;
        b=bDEkxyQHcgHleVvmlTpBasmeSF9x/EihVJxWXX323ho8cb6MD/FG6ICPfBMWhOJZJV
         9Rp9iTaLcIXl6OXmcvnXbcHE5Kvl4stY/+Okd30CUWz698psK6LR1pQiMF6JhLh7sUXh
         sXmhM/pB3chaHwQcl9TRfl2WYAliNhTsoGJrP4QIUJCeKTEJM0IHEBw09ZuAU1yJ/6FG
         8YlUrRgTxShXdACo2BJFvGhOfgOfCMyhrpXlGrM/wFrY3WUrM56KI0diVvKKGti3u4Rj
         uae1NdZG2IFevSMraBkDODfISXu1+FSzHAicoS5ywTln+EvXJ043lWqPclSOOJdhVQcD
         wrSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cR/CPJKG3NoiCnDGVGJZMEP7USNRf/dhi11bwg0wPvE=;
        fh=Llrw7vpOBY8c/q4TZPRBY33oEnWxDCSQv/NNOhCq/Ao=;
        b=aDEEb1Nrv3b7/EZgUKOUgu7tOkE5ARO+gAAKB0slT1OYoTTrEsEbgTjJSFix49SGoq
         bA0tw8oFz15aHW732utiiiD87ZyheXzMbs6txBBPE6txh/QcOOrzduYocs+Q4IEHE/gU
         a2fSwAtRmHGjoWN5YfkpNdPwQZwvbAKaYTx/fG9O3BFuiypwn8Ou2xpVfZLcpi/WTwDX
         7bYF3nA5rZxupu0YYd9Szzp9NMPfTeCUSbiH01LMI8AsWgjl+NSbU12AaRHoRX7JQiyR
         k67R+EJCkUZA0lNTNoZb1W41Wj5ENGFLSb3BhENN9plnQZDALwv9sttbMrO/O0RGEJHM
         XBFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791591028; x=1792195828; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cR/CPJKG3NoiCnDGVGJZMEP7USNRf/dhi11bwg0wPvE=;
        b=tAb0lZ2tx6u8SLh3zO/dNMo5WZ7CTdCJkpLGr4TlttMSyGyZ8mX+2vsxUGGPNVcq5M
         h9EvltQw0Qese8SCZ68BmiTcmNqsFmdiPlz53EkZiiEKqFqip9fkOrVx4a8tU5ydUaEf
         yye54pRrLyF3p48MJMWFaR0H9cTxeYRAiyF0NuHdXSDGxMq5NNcH1hlAgM49CPfseeoH
         LAK7ClrhayZlhhTf3NfaraX3p4O/Q7dYWuhsxlPQoLL5VuVTqmslwWbMMO4boP8wESWR
         Nsn1oPzFukTg0GgELloX0HWTh8QxxvgmQKKexFVXAAJwLZQNPn6NZtdmTttH72Se3fGx
         1/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791591028; x=1792195828;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cR/CPJKG3NoiCnDGVGJZMEP7USNRf/dhi11bwg0wPvE=;
        b=o6men5DzkWZG2mUimPNthZYXDr+fzqeMjt9xB/TV2rur3lyFr66kClXecqAZVg5dwo
         ShBQzfWBeM3t3MN2FFx2uusC9tARFM0Tucv/wVv1Ad6X+VtKhAn6sQff+6U10w5jfMms
         KNVOh6QGTb1yS1ZWqxr44JKzBCxwaZiVpC3NxwN4Uebk52A9KQmJBQhHoZwyeQzCoamp
         UCRt+CpH0vzw5Nw0tlhJtiZMhWQm3RQo1X7ytqLzM4suEUXGRaN7tK8fZ4oMsO2Ia0SB
         TFU4jZKMiWeJFrBPKEkNsNPHK9viYV+viAZLDnQjivvkjUtpEUskEysBVPXEo/+oyTHU
         rkdA==
X-Forwarded-Encrypted: i=1; AKwUvBxKgJp1VZ19fJ7iQGGKo/l7upUmg31UlGuX/EpF9a76avraXb7sn603nbvPJfPAaBsnHbS80kMdHN2tfK6iRTGVpyo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJdfIcRiKzEl756RSA80yxuVk8mT3z1VAztSirov+hUVGviz62A
	CgUJ8TS57INEE7qRD1X4Yr2btKIHnx8NjcOLvSyj+ebm0uQVabB9YLNaTfMS+un/R4E0tI5BJ/l
	7f8rRcPM3MCvXBSkGdAVSoDzq/ZSzow==
X-Gm-Gg: AYBFou1WqBq8dOiA+bEHUNR+c9uOKwB1dalIyD4IhHQgKRxj/6dP1Mk2j7hzGdoq1pX
	92RurqPr0H2O6vtEcR3vf/wS+PuUWBboCYRBycW9K6gH2ZWIzk6p2jpR7uYVojjDR67Im5rH6B+
	fwXeJkRrVWWqjGaUoZYWWFKPbsRQK+91EKJ+/jENpQ6ZBhXAtV7Mrpuzh6yvA3cqIgKzlWXPDgN
	kEA7dEN7SR8xsinbLR/XGGSo4chyaM+nkxnfa+BxaUiQmwrQ3a+KB5V7To/TW6Pc6zE1c1OsXim
	HIMQaS7l+1JPJp7c37mEWWxGgbxvRlIYMeDjZEHxS4BupfrC6xVgOgjM
X-Received: by 2002:a05:701b:2607:b0:144:f096:4dd1 with SMTP id
 a92af1059eb24-16a611c76a1mr3960393c88.41.1791591028199; Fri, 09 Oct 2026
 17:10:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261003202727.3673-1-ravis.opensrc@gmail.com> <20261004080110.37328-1-sj@kernel.org>
In-Reply-To: <20261004080110.37328-1-sj@kernel.org>
From: Ravi Jonnalagadda <ravis.opensrc@gmail.com>
Date: Fri, 9 Oct 2026 17:10:16 -0700
X-Gm-Features: AclHuK9iErDpI0ky8YsjjXHUJ1Bhqg2BvHDmttXO2gzSECAslgV1ytghZLxTEaM
Message-ID: <CALa+Y17H55dp07Td7oqhDPq0TmuWHFB9DNcXNZ91Su_di2vhnA@mail.gmail.com>
Subject: Re: [PATCH] mm/damon: add damos_node_eligible_mem_bp tracepoint
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Bijan Tabatabai <bijan311@gmail.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	Honggyu Kim <honggyu.kim@sk.com>, Yunjeong Mun <yunjeong.mun@sk.com>, 
	Akinobu Mita <akinobu.mita@gmail.com>, Lian Wang <lianux.mm@gmail.com>, 
	Kunwu Chan <kunwu.chan@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 4, 2026 at 1:01=E2=80=AFAM SJ Park <sj@kernel.org> wrote:
>
> Hi Ravi,
>
> On Sat,  3 Oct 2026 13:27:27 -0700 Ravi Jonnalagadda <ravis.opensrc@gmail=
.com> wrote:
>
> > Add a tracepoint for DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP quota goal
> > evaluation.  The tracepoint fires once per quota-score computation when
> > the goal metric is DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP, exposing
> > context_idx, scheme_idx, nid, target_value, and current_value.
> > current_value is reported as the quota tuning sees it, after the goal's
> > complement setting is applied.
> >
> > The DAMOS_QUOTA_NODE_ELIGIBLE_MEM_BP metric expresses node memory
> > occupancy as basis points of eligible bytes.  This information is not
> > exposed through any existing external interface (perf stat, /proc, or
> > sysfs), so the tracepoint is the only way for userspace to observe the
> > target and current eligible-memory basis point values at quota-scoring
> > time.
>
> Thank you for this patch!
>
> We have damos_esz tracepoint.  Have you considered using it?  It doesn't =
expose
> the current value, though.  I thought it wouldn't be real problem in most
> cases, but I can show it could be problematic for node_eligible_mem_bp ca=
se, as
> the metric value is not straightforward to see without using DAMON.

Hi SJ,

Yes, with the temporal goal tuner, damos_esz only
tells whether the goal is met, not how close current_value is to
target_value, and damo needs that to know when a step has settled.

>
> If you really need to know the current_value, I'm open to add a new trace=
point.
> But I think it has no reason to make it only eligible_mem_bp specific.  H=
ow
> about adding more general purpose tracepoint, and/or update the current_v=
alue
> file [1] under the goal sysfs directory to show the current current_value=
 for
> all goal types?
>

Agreed, nothing in it needs to be specific to node_eligible_mem_bp.  I
will rework it as a general quota goal tracepoint, emitted for each goal
evaluation with the goal's metric, target_value and current_value, the
node id for the node metrics, and the memcg id for the memcg metrics.

I would leave the current_value file as it is for now.  It would need a
stats update command or refresh_ms to stay current, and damo wants every
evaluation as it happens, which the tracepoint gives it.

Thanks,
Ravi.

> [1] https://origin.kernel.org/doc/html/latest/admin-guide/mm/damon/usage.=
html#sysfs-schemes-quota-goals
>
>
> Thanks,
> SJ
>
> [...]
