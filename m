Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8025E20C463
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 10:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768817312; cv=none; b=UXV8QshCkgTZTZ23cM9QzzUn1ejQ+b36+TpqT57qDbrlwEvlBA6R58YBQxEJsyMVkyZi0xURn6eKarCRg8I2ECXal/1WIPCd4YozikbSwkgHH++96qarDA7Zej2phSv4sNYIM3TidfQsBTKrKXddRk4Ps6Xxf2tKmKKHeJNz20k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768817312; c=relaxed/simple;
	bh=TUFVCNib8T+nbe4wBU5VeHHQIGyP6QrkuXb0DjWvDoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Hcob7ZbcgVttMHt2ex4HJolaPTAK5jtTTXuSVUnr+bnoqCfMv4CL1TiFr2oawT2F/0u9HuLoRxqEcmbJ2wdUqQ5lCdmm16JqNnv0Gwo490UKfZLikF/DXFMcDeeK5tJ07HZhxiNs04h2BIQFBKtAthhqgiVNfGW9FY7AbEx6FfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dREXa4rB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dREXa4rB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768817310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qp2TxXybZzHflyZA4K0OJx6HlCbr+bAousuWY6dDVlM=;
	b=dREXa4rBMEM4xPPldNXChQ323D7SclIjOxznQKlluLHqBU8kIU69MAkQV8L5Ujv8fREklm
	Xxdq1/GU+8nmjQIixPbr9GR3tXtiGbsUt7Z3hRCWpeIZzriEuqzUHUHR3pT9+hXLn6qK0x
	QHpjOBvn+UR/3KSmLWl72/Ml0qfal0k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-dRj85VcdOHijwk8lf2MnMA-1; Mon, 19 Jan 2026 05:08:28 -0500
X-MC-Unique: dRj85VcdOHijwk8lf2MnMA-1
X-Mimecast-MFC-AGG-ID: dRj85VcdOHijwk8lf2MnMA_1768817308
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47ee7346f8bso21995895e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 02:08:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768817307; x=1769422107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qp2TxXybZzHflyZA4K0OJx6HlCbr+bAousuWY6dDVlM=;
        b=OkjZunJEA+GTYHXb0UcqajPAbswZVl4oFA53yoTzM/P+NhkVQ/X6hghrRk1/aliaVl
         IINlXon0wpk2cuf99MJk6WwphLhnLW/Y21io1Xz4TZ3pauBuTeDGyEW3lFFBBrHrc6rT
         dKJYwYDfi7VPRyRjSCGg5lYNYpMTrLyAJHC4/o7OJ1EXgodvfmbDfV/yUmSq2MASjosB
         MDJnuDesfW8faY+Zc6fIexEd0oPg+MZg4jgQmaQIewzkci6xMOPF7AZ9w8ZwdwfZh06C
         zr1MjMt2gb6w7NO+FKP/GU2oWUgaswdsMk0mXS3Zsii8NX0uxanAzS7muITbuwjC+Ie7
         guUw==
X-Forwarded-Encrypted: i=1; AJvYcCWjJrz21TT6z9Qph236Zo702yeVRvlYMV3wTdDiXUC23FwAIP0P1EWm2rvC/6xvGkiGrHeok0fWZg4AvUHrYb0nx0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT6TP+LzkCNQ9DeMu97cU9u0IlHzvS4yhxDiodSzQ5KDlhQzbq
	yiSIqvuwtNtUHhZYRl/mzXgaQuvYqay40aqtr182hDVDtnYaAwDq5P7P1YACUqfWv1/YPz7TXg/
	zk5vn0wfb+RCL6xF9w4wH5Ulp6PrCK+qx2263AIYh3u9zBcFni4Mf2bSpV2GJxc+0w+iuyU954g
	==
X-Gm-Gg: AY/fxX6CoyNdZbjLv308Q+pF1BZC6p1HJ+MTlMZSTUCtBzXV+SCFuC0ZHR81C5oKIhI
	jchy8hfrVyuSxiEhl5zMU6fJ9USGMUAodKQ/CXS1r+pToqUgbGzlAHoW5WaIBPD0yJ0m8XuM9Uc
	TPBzYOdvksc38exrADCI0VIpvNgo8ZwAPeiYc4MpXGKR0GgoEPh5Mlt/SRLLB54QI9aNzPNV8wH
	rB3OEL5eDh4yj27VZhE7cAaO+BHtYGwZDTxJXpk2vEF0emRzeunmAMWvpztdnsDmK4AYAFZDb9f
	znInXC/nyAoGusig/Y5tATAvbNDQ5tyfjLk4U+vQEccK7aPdzFV1HWNOg8h+nccG8erLwP9Biuz
	mb8fVATk9g+hRvXGiCVrjLMRDKgL5ryCvEHq8zixi
X-Received: by 2002:a05:600c:870c:b0:47d:25ac:3a94 with SMTP id 5b1f17b1804b1-4801eb092demr137077185e9.17.1768817307502;
        Mon, 19 Jan 2026 02:08:27 -0800 (PST)
X-Received: by 2002:a05:600c:870c:b0:47d:25ac:3a94 with SMTP id 5b1f17b1804b1-4801eb092demr137076905e9.17.1768817307090;
        Mon, 19 Jan 2026 02:08:27 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435699271easm22288554f8f.14.2026.01.19.02.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 02:08:26 -0800 (PST)
Date: Mon, 19 Jan 2026 11:08:24 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>, Juri Lelli <jlelli@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 13/15] sched/deadline: Move some utility functions to
 deadline.h
Message-ID: <aW4CmOTG6IOsmbGp@jlelli-thinkpadt14gen4.remote.csb>
References: <20260116123911.130300-1-gmonaco@redhat.com>
 <20260116123911.130300-14-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260116123911.130300-14-gmonaco@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aZrDkvz4gDDsHmOLERt5WiQuBjS66zp1kzH7ea_CqX4_1768817308
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 16/01/26 13:39, Gabriele Monaco wrote:
> Some utility functions on sched_dl_entity can be useful outside of
> deadline.c , for instance for modelling, without relying on raw
> structure fields.
> 
> Move functions like pi_of, is_dl_boosted, dl_is_implicit to deadline.h
> to make them available outside.
> 
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>  include/linux/sched/deadline.h | 51 ++++++++++++++++++++++++++++++++++
>  kernel/sched/deadline.c        | 50 +--------------------------------
>  2 files changed, 52 insertions(+), 49 deletions(-)
> 
> diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
> index c40115d4e34d..9468a9b1090c 100644
> --- a/include/linux/sched/deadline.h
> +++ b/include/linux/sched/deadline.h
> @@ -37,4 +37,55 @@ extern void dl_clear_root_domain_cpu(int cpu);
>  extern u64 dl_cookie;
>  extern bool dl_bw_visited(int cpu, u64 cookie);
>  
> +extern struct rv_monitor rv_deadline;
> +
> +static bool dl_server(struct sched_dl_entity *dl_se)

Think we want to make this 'inline'? Just in case compiler decides not
to inline it.

> +{
> +	return dl_se->dl_server;
> +}

Thanks,
Juri

