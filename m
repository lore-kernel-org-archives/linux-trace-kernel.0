Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795471791;
	b=XsPV6HQl8iQma7HrJaumERozXu8HnfLmZi24SbuFZ8ciUvi7J26ngvrGxQavuK1NZ44u
	 H0ZPnpJ2iDzHbPJ29SE3E3YijJ3BSw+NKgxJHgJapfjlKsFZ2IjRTrbTTg018/TaLzGMo
	 3T3m2plh8+sK8sE2zLkguJVTK6OJmFAMSC7faYi64k7YSXBjV7diYjpRt5OLG9lo6X1eC
	 hxyrYcOwPiPZWIFlFHfkCnEtlwXeySBNDXU+TRlE2pIMKIMxhokInK+ILCBl0S2mOlOja
	 EwslZnlH8Satg5NXaOepxxaefoAPHVKnt6aRC7Nn8VuZJkYV6KfNuaoOFEArrurnBpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471791;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Vz58Cre/aXSIBNc6xkRmR7HEG/rtQyKHMhQgyqCK6QY=;
	b=ebNabqDk2GsUsG3vzfkh7DQOvHycw8FKcJARONuREmYTaojRd4pBcT5IWQoDMzFm98wt
	 bDVcdGKbUaRmohhzJ+GCbOnr06pp/GjCENvSz+ObWK42rrr3oDwKvG7EKPRfHu+oqOFbx
	 fBTrffvSPnCZi2tFH2RIYpQI7tbjPUATM1zJe/HRBnBmuTdwlUwuH3k+gekg3QVCHa4YP
	 ayRFSankh4Go3Fuw0EOI+rAvGn1GYqs4o6cV43PLQLeEqHzgq0RY0e0DetkdTpAswF+Vs
	 y07KyUaA11+qMI6fdo0k3Dsn/5yQc5zGeu9mBnVaRygzUIrN2VxaB1PfLpP02JL18MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HLTOpMWJ;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5F5606A687
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Nov 2026 22:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE5F5606A687
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HLTOpMWJ
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb606491faso21419365e9.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Nov 2026 14:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795471789; x=1796076589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vz58Cre/aXSIBNc6xkRmR7HEG/rtQyKHMhQgyqCK6QY=;
        b=HLTOpMWJk38/ystWWFTF7kDJo03Nx/0EQqU7gU1AzYiAhqkOfXtEz0J7jRtoau8Gi1
         emkvpoMxiOH5a+Cw5eXud4Pkrow26A61n1gKW0ki1KbbdozKJX7EYAy1AqP76FccnU62
         tWqcvQSeVuS2T7LwXn4cbQTh8wqaAIsBGvEchHB9chtzRZSUA9jqPDSRWQJYRQVwSHPV
         QTJt/JLh4o4RBM5t2mlFIVsCmCRNlzWTHZw4gR1GOalV97ggx14xwaHr269HbkXb4tiJ
         FV+xs3dSiuDx244qqYRhVgkUifkcmB+/hUL/2JTRMVHltcQr3tpwIldPSjOBtvUdVQeR
         LnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795471789; x=1796076589;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vz58Cre/aXSIBNc6xkRmR7HEG/rtQyKHMhQgyqCK6QY=;
        b=QoLlRMdus0L1w7WW+2pjQ1B44JJ7hPKJ1kP4KjtHOLLxkb69kheofxBUWHpg+lvejx
         BZr1YkGAIwnn1DiHLbAoZDh/nNeMfSfuvp/X5++PWq5t2ViLopBF9jGhTRJf+sWBQCma
         KL+vJWk/vKinHYFHUP+cB8pSv1DTqrWOmDb5ZziREe3A0euwU15Sgehv39gss/of5cZj
         aNsmREIf8+I6G9VEDa8DDvNKPKY1Otv4gWFZugGdE4m6Q4t/+CEHY+h0fWiTFz6jXcST
         jSbM+p9Ztf6ZknWLHbW/uVp6Eb42ae3dmRDgYfMrzdEtjz8TJBzc5g8Yu7261AsHoK8u
         U7Nw==
X-Forwarded-Encrypted: i=1; AL+hErElgIKLhY/toM7dO17qf+UgZjLn/XhxwaEqeNQsb7tEahBGiTeyY54LGjjlnsLpw4mgaGNuVJYM1VHj9FES6hE/Crk=@vger.kernel.org
X-Gm-Message-State: APuU4Z93XKsxCegH24Zsm41M7/CS0yKHaAkdNCyCtdZaLnPzAfWvLWFn
	BchJiUDIwa5e1UaUNbmudC4K443UUAruqA59LFjA2hqRuTVFph248r1u
X-Gm-Gg: AZFdTZeNw24d+rcbHiHY7WUDhcnPx9p2wBT6XZu7CZAeQu2QhPhfkpp/Kct7j602Xd4
	7ty2Cnwu4kXs7gfm8bOXSuKdbByQpqw/QozHmU9wBnFKCB/JghnvWCXNe1+INu+FvMEb09Fa/GE
	czR0C6DDbPtzUZwBPaatUE4MetlEx5D9tBzvcVsafiohVIv6KzedpQnRWcL6Zvl8f8j4tE/fOwT
	fG1iNriVg6iZ3ngmglCbkHhcKSTjjyRFXzd5VibYyvowJY+dIpDzDplSOr5amt4KqetaKpLgq54
	zE6NosxaKJbdLsao9a2+WsQzQ6eelBu104ko9P6zG2LNaFY+ENPOHEA5OzIjjmrkB4lDMeM+FOD
	54NppdCkYed3xefEetlsjCRJooR01DKUC42V1NTFhTu/OjiJfKIOdKFXEces8VL/gW3e0/cxLj/
	UdrHV50Rm/4sBf93w4AUdmsAtcIXmM6pRIaGT+3TLQQ6SXfook/PGfJD9vqGKy8y9N+y/QPLHFD
	9dKz8oGvHpZjrV895CWpAH1wiv5iAu8rmyPnxNwpdcdmpiAhapysCh3tJ40roQdrl6c91xdF8RI
	5UkRdhhKF3OKJt4H
X-Received: by 2002:a05:600d:82d3:b0:49f:e701:51c8 with SMTP id 5b1f17b1804b1-4bb8880f0ebmr292245375e9.9.1795471789043;
        Mon, 23 Nov 2026 14:09:49 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85399d52sm372260275e9.6.2026.11.23.14.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 14:09:48 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 23 Nov 2026 23:09:46 +0100
To: sashiko-reviews@lists.linux.dev
Cc: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/9] bpf: Add log support for tracing
 link_create
Message-ID: <awS5qgoIeSAheK-w@krava>
References: <20261123152743.19629-1-leon.hwang@linux.dev>
 <20261123152743.19629-2-leon.hwang@linux.dev>
 <sashiko-outbox-229589@kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-229589@kernel.org>

On Mon, Nov 23, 2026 at 03:38:47PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] bpf: non-UAPI field name tgt_fd logged in
>   bpf_tracing_prog_attach()
> --
> 
> commit 476f541041ef9d87251f0598129c4def280d1320
> Author: Leon Hwang <leon.hwang@linux.dev>
> 
> bpf: Add log support for tracing link_create
> 
> This commit adds verifier log reporting to tracing BPF_LINK_CREATE for
> attach parameter validation, reattachment checks, and target compatibility
> checks in bpf_check_attach_target().
> 
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index ec8e787929112..80504011403f6 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -3677,7 +3677,8 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
> >  				   int tgt_prog_fd,
> >  				   u32 btf_id,
> >  				   u64 bpf_cookie,
> > -				   enum bpf_attach_type attach_type)
> > +				   enum bpf_attach_type attach_type,
> > +				   struct bpf_verifier_log *log)
> >  {
> >  	struct bpf_link_primer link_primer;
> >  	struct bpf_prog *tgt_prog = NULL;
> > @@ -3714,6 +3715,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
> >  	}
> >  
> >  	if (!!tgt_prog_fd != !!btf_id) {
> > +		bpf_log(log, "target_fd and target_btf_id must be both set or both unset.\n");
> >  		err = -EINVAL;
> >  		goto out_put_prog;
> >  	}
> > @@ -3726,12 +3728,14 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
> >  		 * attach_tracing_prog flag is set.
> >  		 */
> >  		if (prog->type != BPF_PROG_TYPE_EXT) {
> > +			bpf_log(log, "target_fd is only allowed for freplace prog.\n");
> >  			err = -EINVAL;
> >  			goto out_put_prog;
> >  		}
> >  
> >  		tgt_prog = bpf_prog_get(tgt_prog_fd);
> >  		if (IS_ERR(tgt_prog)) {
> > +			bpf_log(log, "Invalid tgt_fd.\n");
> 
> [Severity: Low]
> As reported by Alexei Starovoitov on v2 [1], should this log "Invalid
> target_fd.\n" to match the link_create.target_fd UAPI field name used by
> the other log messages in bpf_tracing_prog_attach()?

with this fixed, the tracing_multi changes lgtm

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
