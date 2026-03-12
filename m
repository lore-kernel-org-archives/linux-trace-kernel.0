Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70212ED848
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 13:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773322663; cv=none; b=TA6YqVAPMp8PV10Y1pLimOoxA8OIZhlJ+C1X+5T5+chCBz66E+UrQMUySPkT/Ew58aXOWYQcRh57bFAkdeR3+bJC/AXggGnELGiJUF3kRpQRq2PxMn69t52ijMm63DYnZOQ3e0QAACgIU1S7srDpCrct80VBO2ykNTMtVuGGo7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773322663; c=relaxed/simple;
	bh=/Fdy6xvfMQaqxk4Ucfc177UadVLEotfGbvycLsLbU1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=J/o5R3nTvC1+t+/W1jMmUmrLa1d9RiRECXciGVwlu1Pc9yKkn6LBd3DzSYJwBzr3019JedYC5nNKJTF+vlkZe0CgQEnl0lyFXHezfgvnxaagLmei6O+S03m01Pvmp02ZUkXDNbnGBGNVthbDjqa0mIB0arY05XX6ile3qwgxygc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YzMdj7ep; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YzMdj7ep"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773322660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BTx/xQB8jpXSOLhkbmx0NoEZlX+Tteed/9B2psizxqc=;
	b=YzMdj7ep/pStZyrMeZqAfnj5W7Ltz6+JzeKgugD4MpcYkI9PsH4mdGq978ASvt3SCRoCe/
	h4eMy/tXnKpwwwvtfbH7LETCk7vGSbVES6e7JiIW+W1eI19G22Z7PZeuSN9hU+0RWk4qTh
	dwxKT0892kb6sq5rJASNcGy2Z3poMBw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-sBk838rhNa-juSrJRCqogw-1; Thu, 12 Mar 2026 09:37:39 -0400
X-MC-Unique: sBk838rhNa-juSrJRCqogw-1
X-Mimecast-MFC-AGG-ID: sBk838rhNa-juSrJRCqogw_1773322658
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48532df52c5so9155945e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 06:37:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773322658; x=1773927458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTx/xQB8jpXSOLhkbmx0NoEZlX+Tteed/9B2psizxqc=;
        b=t0kcCdkgpVEyvVQKm9tops6caCsZG0tDNBGWJORuP+Uvm27FJTFwhTkXVwEeDpKgpK
         o8Lb08gBfUVu64FvL1+yrQ+ShVISV3dVkdLlLZbK73itgTKXAuWm1onG587EWA12yhvp
         MHC/ZH8SE2QWxh6T+xrzFhOiKu/A7pmImgrWuJW72GraXlR2U4uf1zgBk6mqdZFsQt6u
         TzHZAR3JahI47mcRit0Y0vzUEXabkIhPS4o2+UjFvfVp5FsA4u2FH9PAkcKdSbTsImgX
         N63V7BwQjJBQSAu7LTe17E9yjtCgzrfESJhuAO9FBmfUSnB+sFUL5SW3gBanH1qZYSe4
         pkHw==
X-Forwarded-Encrypted: i=1; AJvYcCWVg9RUttAqI+/4gPA23HkSl/oeb4dmsRn2kANh7dPT1ys2/qnOFJ0STGwTn0L+Mt4EMuq9BMUx7bjwA+kglL1gxgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHbH5gZpKyIWdgmAMNP5HZOYA/ajJzsRkgl3nL6vmr+QYe2Gym
	uptC4cjkxoVXokeuarjSMHR0FpJo0yZtJYdA71ZGb3NxR94pPMM9cqbtD/EJW2ah2SF2ScjZTr8
	ursbl2TE+xUxb2ooJUR/A5E/L06Gx//vqCBev4cqacbeG6GJThtM20HTxUEPsg71VGLuwTUTx2w
	==
X-Gm-Gg: ATEYQzzPH0MXxKEg5Qf3bEuRDOilHwY1cbguXP2rTb4O1G3MWvAc7anFUhg0c0GUnvC
	vI4vqQ+SLcIF/DIMD+jXzW6kDg8bUXq0ykiVjtQUGNlDeV2aEFoM/WidfcHzVKAYD++/xFw2k/f
	vzPJyFdHVQ5BFr6GsuhLxkkl70xUGtFPuPt//SW3oVMCGQAP+w7ecpN912ET7DMG/RoZK6PerIr
	DfA6nPoXkvaomA3688deFXZ4iuwoP4DZjPmC9FGAoPwjDxWiTuzk+Q6HLJOqgH03KyG7HqWLAmU
	yFff3c9wt7V6eEGCWAHHtYMdIih53KxuuIGtSCYl3trx037xfsU2zvZhEqd601E6LNGfWNX1TLY
	0TyOihCxDgbrL4ilXEeFCkxrfg0thmbXaA2XSp1U3HE3k5SI1dM8=
X-Received: by 2002:a05:600c:3106:b0:485:40ed:2d1 with SMTP id 5b1f17b1804b1-4854b0fe8d3mr137010745e9.17.1773322658305;
        Thu, 12 Mar 2026 06:37:38 -0700 (PDT)
X-Received: by 2002:a05:600c:3106:b0:485:40ed:2d1 with SMTP id 5b1f17b1804b1-4854b0fe8d3mr137010285e9.17.1773322657731;
        Thu, 12 Mar 2026 06:37:37 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.82.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b66ffe2sm126229605e9.13.2026.03.12.06.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 06:37:36 -0700 (PDT)
Date: Thu, 12 Mar 2026 14:37:34 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>, Juri Lelli <jlelli@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v7 14/15] rv: Add deadline monitors
Message-ID: <abLBnlqIHVPEcisP@jlelli-thinkpadt14gen4.remote.csb>
References: <20260310105627.332044-1-gmonaco@redhat.com>
 <20260310105627.332044-15-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260310105627.332044-15-gmonaco@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eYbQIBU1BN_ucwCxndQjGxdpS-pGD-MZ6ftsj_0c0fY_1773322658
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 10/03/26 11:56, Gabriele Monaco wrote:

...

> +/* Used by other monitors */
> +struct sched_class *rv_ext_sched_class;
> +
> +static int __init register_deadline(void)
> +{
> +	if (IS_ENABLED(CONFIG_SCHED_CLASS_EXT))
> +		rv_ext_sched_class = (void *)kallsyms_lookup_name("ext_sched_class");

Looks like the above look up can fail. I don't actually see how/why if
would fail if things build correctly and EXT tasks are around. But,
theoretically, we could end up with rv_ext_sched_class = NULL ?

...

> +static inline bool task_is_scx_enabled(struct task_struct *tsk)
> +{
> +	return IS_ENABLED(CONFIG_SCHED_CLASS_EXT) &&
> +	       tsk->sched_class == rv_ext_sched_class;
> +}
> +
> +/* Expand id and target as arguments for da functions */
> +#define EXPAND_ID(dl_se, cpu, type) get_entity_id(dl_se, cpu, type), dl_se
> +#define EXPAND_ID_TASK(tsk) get_entity_id(&tsk->dl, task_cpu(tsk), DL_TASK), &tsk->dl
> +
> +static inline uint8_t get_server_type(struct task_struct *tsk)
> +{
> +	if (tsk->policy == SCHED_NORMAL || tsk->policy == SCHED_EXT ||
> +	    tsk->policy == SCHED_BATCH || tsk->policy == SCHED_IDLE)
> +		return task_is_scx_enabled(tsk) ? DL_SERVER_EXT : DL_SERVER_FAIR;
> +	return DL_OTHER;
> +}

Considering that, if that happens, get_server_type() will return
DL_SERVER_FAIR for scx tasks as well (possibly confusing monitors?),
shall we add a warn or something just in case. A 'no we don't need that
because it can't happen' works for me, just thought I should still
mention this. :)

Thanks,
Juri

