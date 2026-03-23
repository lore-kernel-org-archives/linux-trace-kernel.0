Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1513ACF0E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774275371; cv=none; b=VUL2BcSn/O33KTgEPRuDUFuDzrmoVYW1W53jApVg6flIfQIHQ2MvibuPLkygCUmS34QI5pJuWCE2eqvCQyL+H/mExyzvAcybwwlyN+tDVnoYMOiI8S3L+lBUo8Zdtvs8nKmikQuo8Yw847hwYnCeNiyeJvJPpm1k0rfPjiZ784s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774275371; c=relaxed/simple;
	bh=1nIqdRIK+bdOJEY5Yuv7/zhGEajgtRCx1Do8WfIUy7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJ4d3z/mjYXPDpN6UVOwLAJydKNuC8j1U68CZ3wJacdJkz9LLTbY5lgw5LNXrLdYrJzDtb0sL4hmvzQdDDh/0ZMHekrQFQiNSzWT7JatuxrfDnONeRky7libCrHM1Str813lseHPue0KoGDpxvLTHYwJymzLJpFX4i7r99IZkQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hQGwWlgB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQGwWlgB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774275369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=imgXWCiXPKFseEHXN+izA67gyX9JBIBpeFg/nk4xdSA=;
	b=hQGwWlgB/pBaZBibC2M4WJA5AyGwm8m7eODETmCOjDl926/HzRDL0Dkt3SZ2Y1I6V8VmNr
	ailu2UhZ/fjgpmpU0BwV+rNOB7lVGej7Az1SKAH2cVNKKkwncvZxYYzYW6OzfaDE/0Teek
	YNCBP7i2AMK+QLqCFoiJ5g18nf5mAzU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-A62orafCMO2tY_YaZOEkcg-1; Mon, 23 Mar 2026 10:16:07 -0400
X-MC-Unique: A62orafCMO2tY_YaZOEkcg-1
X-Mimecast-MFC-AGG-ID: A62orafCMO2tY_YaZOEkcg_1774275366
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b97f04b44b9so24881366b.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 07:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774275366; x=1774880166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=imgXWCiXPKFseEHXN+izA67gyX9JBIBpeFg/nk4xdSA=;
        b=Z7gr50+17pl3G2gaNe9j20HTeovEA5PToK6wk99pqw3IiIS/x9eWv7QcfYzSSOqfvZ
         UW9/zYcbb4TZUIXnKzkUOU9NfT35+99dtiUzO0T64joD9Z3Od4Ehajiw1XGsNrObtRN0
         yuEgZLQ5xaBZzy1v679HTyJjwa8L3duXxj+Q01JXNDoMc/tCV+AaKkRUIW4i4x9i1vXB
         XsFe8UHsGXfuvkj9+tLl9duQCH6Y3ns6yBCu383osCqMUkf+6FIA7MuSGdg8w4XkFWDv
         k3Fn7JGcGySRrx3zLk6Cg8MKohEWYAHenT00pm3ZI0BOm5ZSRoh+XdLBgOTR/4WsZiNl
         v61g==
X-Forwarded-Encrypted: i=1; AJvYcCWTCqv+sTedabV8Q2UyCP7d3K8tKc8deSywi849MgP/4VzyXL+C98vlPTd4iwETZ+ptWfxlVNK0YUZS6QVctbI2Brk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1DrnCHuCkapXw1FGNWey/pEbGHgWB+Tqk9SeR3BWX4xhy+9Ce
	mzdwB/wj2ivF+1DZhD0SCmrAL4JPgr0hYBeuxlHh1faX0Qp4XJmyK0BVsA5C0HRM44uAp/fU5Yl
	aEQWI4UhqCqw1Q7M23wYTtai1eb6IeQY8qydCcpSc/ExvvIp6+ZSPQb+1+lLaZWk5wc9FLbBnm1
	QPmzFXY2gkO2hpO68iME1cfAy6uvi2zZXHFS7FmbhT+iJuHquy
X-Gm-Gg: ATEYQzz4dCon7OmyS+lIm49M6kfFvC2PI4dXkKSprsA+k/3cqFVb+wIF65cb/B6YYZU
	BLj8GHU+EITlGg8xkOEZaLLLFgCgkt0cbT2OwE7bUe1Ytl0Tuqb2UhGa/2WkRRbR3tdW20zozNZ
	lJ+2Vj3EfxYyMWQF0rd2VktOK/f27qghoxixyOLEcBXhpbJN4/RZfGBp0DMuVUULxQYZuy9z2mE
	12ehg==
X-Received: by 2002:a17:906:e94a:b0:b98:1b:5157 with SMTP id a640c23a62f3a-b982f28b1aemr705653766b.23.1774275366354;
        Mon, 23 Mar 2026 07:16:06 -0700 (PDT)
X-Received: by 2002:a17:906:e94a:b0:b98:1b:5157 with SMTP id
 a640c23a62f3a-b982f28b1aemr705652166b.23.1774275365877; Mon, 23 Mar 2026
 07:16:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320150651.51057-1-tglozar@redhat.com> <20260320150651.51057-4-tglozar@redhat.com>
 <ab2D0a32yuwYTO1K@192.168.0.121>
In-Reply-To: <ab2D0a32yuwYTO1K@192.168.0.121>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 23 Mar 2026 15:15:54 +0100
X-Gm-Features: AaiRm51OaCr12M7bKmgPO5zKGS_Ot5Z_5dmTG4KQ7CY2nbc36ZRPKUfpZq_CCcY
Message-ID: <CAP4=nvSqarP3JtCqkvMeH3wmM08pTWADBSJR0RVN8b7FXYXZeg@mail.gmail.com>
Subject: Re: [PATCH 3/3] rtla: Parse cmdline using libsubcmd
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ez5Upy0J2I48Z4EyIA1zro9clnQzzp58872sUkNE-4o_1774275366
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 20. 3. 2026 v 18:32 odes=C3=ADlatel Wander Lairson Costa
<wander@redhat.com> napsal:
> [snip]
>
> > -int getopt_auto(int argc, char **argv, const struct option *long_opts)=
;
> >  int common_parse_options(int argc, char **argv, struct common_params *=
common);
>
>
> The function common_parse_options() body was removed, but the declaration=
 remains.
>
> >  int common_apply_config(struct osnoise_tool *tool, struct common_param=
s *params);
>
> [snip]
>

Thanks for noticing that, I will fix that in v2 that will be needed either =
way.

Tomas

