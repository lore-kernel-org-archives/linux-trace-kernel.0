Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B9923D7DC
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Apr 2026 08:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761699; cv=none; b=DwWOfu9x8+N5EQmbUydJiulPDzOzF6ZRFYCfvSB358hLhseH3iEKEGyBK9Ds31rg0DyNfFFNLwSoh5+IeTe7FZ4KOEj0LD7PO0qmDvGgaByDVy6409QdF0yoSMDxUB27PcMns/oCwgON5Jj+mfVFPBs05doquPB0cUidNCieByk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761699; c=relaxed/simple;
	bh=KOd+LAoM7dvqCxKW/Ccet+yk/av8Oxjn8Nrd8ta9Gd0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OlqjWMZZeschPRvg5YgpaIyPuasNezoybNkwSzy6yGxgwV9DplmKN/thJFmtQ2Ido52AexHcLu1AdK5rdZCObD65cAjvzGbAMPnXlL035eW9kLfGOwod39EL3Ee4sbubdAH0AabQYhMUGbHzYi3VL/Yq/XKJPxJmnlHKPJcs/fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XsmtRqsF; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsmtRqsF"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso30570685e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Apr 2026 01:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776761696; x=1777366496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QsEGDw0sph5lbiDCNcPBIQnZObof1B1mZata9gcne4o=;
        b=XsmtRqsF7q3sSwD7bnH71eBnmrEDSk/MHvCEqr2hXgqcEXBLdCCKEKQIuDhVtmQFCR
         MsVztfnZGSGzlR4hRL1312Oibzc/Lo2W+nmP8p1SM8D2UZ8GWligvDsbnhF7C4KPMS7c
         +YF57Cg2ugPvsUCt6dBArbDEjStS5odrauZTucIu2AuGVWlVo0LWNIHSX32/4sc44sFK
         wiNK498/7MhkUkIgSr4J+GYnMl1yK7l50XGf615RnmRbt+OJZSrQZYcGwHRVR1M5+8Jt
         OCv5VGPM/LgdAzAJyEtiyOYodvLcyFbTUsk05lDCbaeN75CsloW5Y0Blrr0Z1tusX0og
         4pUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776761696; x=1777366496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QsEGDw0sph5lbiDCNcPBIQnZObof1B1mZata9gcne4o=;
        b=rrd8nbHGkOzQVrJKXY320vIR50qE4NPE/spgIWPeXu8mJai30EMjempDe+wBjx5JhY
         CctCnuZfb/temWM8q8/nQyxrn+OZTIfuhCQo/1q0IxY/3VjTsqcWT+TEG6+5gnYNiXqB
         XAdsLX3kn4tm/VDY+PM54A7f6vnUwLdOwifebuTsMC5r2QXhaefHUX+Hg89//1+Zm8Mm
         MkUqHLc5W9poOxaRsBd2wqmsTxJGRGyToGAuqEo95OCBTf3JYBDhbRWVwW4b9UuWQm+i
         VrruQSZMSLcjLBdTpzr1hedeDKutKYlKr5taXMXy7Eb6Qg3N0ns9HUy9xuXcUFK7bKYu
         6ElQ==
X-Forwarded-Encrypted: i=1; AFNElJ/IG2G8iwxYwUFf8X8ifD4S3zHyXgr9NjO4yKJgmEdHIXTKFrWywfYnuaQEmJYZer4vLoUVP5tflTIpwtQ9uDGMDbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyZmdK4qAO4aHABjiVuOHtblgjUoTUAyD+IAwS3XyXflMbPEGD
	90XPsFsHQc0bvyJZe1LLa4eCJm4KwkMGjcnPgolBFrTFomAjw//JBmG5
X-Gm-Gg: AeBDietamkfuedR+lY8uQnEyhephU9/IB30isuMeBtaxZzHO2QyeM+M0P3bLcieHSSo
	Vdd786ILvJ1Z0V8is8SM5tPuIaLEMvIMooI8D7YKDn2LgzLLWUKoRWQVp3pNVWyzOQsbZww31He
	CJkyI4XEbiXSk1TM2kG6xkz9S82ImSNX1RZzECOt7gUdztzMgyEuJOSFkgS8ofoZr5DeGgNZgoo
	7UlRcuWXwk58kjr78E8cac6LXidqZp+9KMT7hW31mJG6qCVJZvbjQ70xuE4XlMzLoMtcySa0nLi
	6gIYvEC3m5W5hThPwbfX+RwKTfN6t7C47cJ8tE9/0EcWu6Fg5OUUxiOu1zrQie3drrS/jAQbXfY
	GJTsT6wmal9jVKfKFtWOq2vUC7529VxA1CBdCrYnvd0szfghW89iZ8MfU7MT5dIzdl2nzZ2q/mf
	UcWZ0DTy2Gnh5BBM1hGA==
X-Received: by 2002:a05:600c:c0d3:b0:488:a916:14a8 with SMTP id 5b1f17b1804b1-488fb74fe74mr194042495e9.10.1776761695708;
        Tue, 21 Apr 2026 01:54:55 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb77b001sm160849805e9.3.2026.04.21.01.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 01:54:55 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 21 Apr 2026 10:54:53 +0200
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv5 bpf-next 02/28] ftrace: Add ftrace_hash_remove function
Message-ID: <aec7XYf4o1mZ0fyk@krava>
References: <20260417192502.194548-3-jolsa@kernel.org>
 <14d32b2f6aacddfce59d73dc5e1c0ea423f84e373ca130f6830c3e26154e70b3@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14d32b2f6aacddfce59d73dc5e1c0ea423f84e373ca130f6830c3e26154e70b3@mail.kernel.org>

On Sat, Apr 18, 2026 at 06:10:52AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -416,6 +416,7 @@ void free_ftrace_hash(struct ftrace_hash *hash);
> >  struct ftrace_func_entry *add_ftrace_hash_entry_direct(struct ftrace_hash *hash,
> >  						       unsigned long ip, unsigned long direct);
> >  unsigned long ftrace_hash_count(struct ftrace_hash *hash);
> > +void ftrace_hash_remove(struct ftrace_hash *hash);
> >
> >  /* The hash used to know what functions callbacks trace */
> >  struct ftrace_ops_hash {
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -1249,6 +1249,25 @@ remove_hash_entry(struct ftrace_hash *hash,
> >  	hash->count--;
> >  }
> >
> > +void ftrace_hash_remove(struct ftrace_hash *hash)
> > +{
> > +	struct hlist_head *hhd;
> > +	struct hlist_node *tn;
> > +	struct ftrace_func_entry *entry;
> > +	int size = 1 << hash->size_bits;
>                           ^^^^^^^^^^^^^^^^
> 
> Can this dereference a NULL pointer? The code computes the size using
> hash->size_bits before checking if hash is NULL:
> 
>     int size = 1 << hash->size_bits;
>     ...
>     if (!hash || !hash->count)
>         return;

yep, we should deref after the check, will fix

jirka
