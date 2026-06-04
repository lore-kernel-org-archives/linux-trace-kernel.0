Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD7130F803
	for <linux-trace-kernel@vger.kernel.org>; Thu,  4 Jun 2026 08:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780560029; cv=none; b=Lt/84ozLN9w7+kvBI16u3ounpF9nqGlJtk8W7zzJyuhiqqKXTauXG9RFZFlFpGPas4mUOUehLieM3mXa7eLF7SRZqjJjyFnf8y3fsGhQvTYWFtK2vRX3ftIZ58qTB0Y89bvTRt0Ev9xGiIMVNVEPp+3ZUoFpc3uAgRlm6W0m86c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780560029; c=relaxed/simple;
	bh=tLNBjb1LxGgsWGmcE25Qk72vSCilUGhydTgk7Zym6qg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3p6nU+fz+Po6IHkT8uJwfU1zP51b6x0SWHNFUbB/k7j8g7uzz4jO5pjw1/EjQ1NiUB0Jp+Fb14AyWDr7psaVh3/ZO7dRzg1a8lgdGeZnoenLZjqmyuVeYe52WrbgN4RGhXFb5Y/+jKKgG2O5KTtPq/n6PqVY6qvHPs1vo5P+eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjvY75eA; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjvY75eA"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490bc6a7958so5321925e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 04 Jun 2026 01:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780560027; x=1781164827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5S/ODxVsZ0F1Hysh5uuXFztTRTMytWGdM0vjEW7pXv0=;
        b=YjvY75eADabUucunowoYWwHqVIXmxoS7hbodzR0L1O/gfSJ5DvEai8MqQqmms/QU04
         kYr0O6bTFoeu7/Cyr/ZsD+axvHsuf7Pc1dqhceEkEEuAFfRFaEF7o+2n3odGlSXSUZ0g
         m4sIorctztaxg399WRqgdqDckdK39aDf5zz0eN50n5ZmlYfHIr/T4y/AGs30IX8gn1Sk
         nOWgNIYQRWQFFcfu3iogyVLN17TO0Ficrffpgu5bk9xMFRHVhBluMA8dqnZB8KrZhF6g
         vE0yuWxST1vv6MXbSmrAxWewfH9YZhs+ymBra4UWJed58jDhvhK+rkHSzgC/y1iiIOot
         WV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780560027; x=1781164827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5S/ODxVsZ0F1Hysh5uuXFztTRTMytWGdM0vjEW7pXv0=;
        b=L3UwRCsONr3cENpn3sgDAOkzVo289wYPU649tjSAT+0LZ+M9LNS7Er8nsUejWImi/m
         KCb7IZS4saIZEZuGXEdxrAeHkn1yBMUjtZYxqinCVCanegkIWTuZpAFGXgjCRlvHebwu
         hbXdpvwHWit/m3LlOHS2q2l/L/OVGKOTVyLHXyaxRPHNl3aF/Z35Z9oKM0vS/v0CROjB
         ydpBa/s9ZigRjjTTpcR1hRH/iUuSdV7fn10NpSRD3fRWsr8e7xIYz0h+JOOtl17JNovn
         yHxrpAF03i7QswEaCqZj0F67GmI2xYLc5fV+awUVQLOcXJIXz687rxXwiH6ftf2xKsNR
         3ziw==
X-Forwarded-Encrypted: i=1; AFNElJ//vZW4MRFX32EVyAAi6KKvmNsY+gm0fgucg8bd/7OGwUNWOhoIloUXT8HzLuAQSqc6MjVmCkbOC4As0uBmu2/KLAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YycEZqy/LFPgjmeMWe2kkw6wJ4yLmT73qEcWCXVz3k74W5KEJkB
	ptjQ28ZGD/DgigkNLKhUHMt1eKeoZlfEK0prUikR5Pg0pV4Iu8/JVShv
X-Gm-Gg: Acq92OFAkE9Jg7dDVCYJaE+/5FZQ+05GZT+Lt3LDfyVbm9psYVVl2jVQyEGDFL6uTPV
	8yWr2uSzL28B6iLJehtQGwhpMCIafYHAJxqSac/7/8WxjukrCvK+hpfHv7KGfNAmV4+NxA6nan+
	VMGXR/Ge7auEwcYn9cgiihJdtqFGOfo6kC4CIRqH4ZOxUDL7tp80EwZg5N2a9CRdoep7k5FmrhQ
	6WlGifkzUpfb2GbdNy2RMwSK3y5visxZfGGubzgjXT/KawYkUU8gCjI9ZFCBNw9lE72a8Pr95Gs
	vnMMFSa/cFWWMBL3An2MYrDIUdPdzYAxEMu5EVOGiNHbLNoz6HqubksgjNKnV7nL6guLdKf75if
	nDWm3Ms7TNahrljuf8N8f5Qq1Xl5ntNzIqrMiGI/NEYl2UN1hMUR0qLJsyZMWNOfgYRt0+gLDfs
	A3JOwIOtiv8rLz2BSfJAN/43c3Fw==
X-Received: by 2002:a05:600c:6095:b0:490:bb60:68ca with SMTP id 5b1f17b1804b1-490bc4b54b4mr34914705e9.3.1780560026574;
        Thu, 04 Jun 2026 01:00:26 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b7e6c774sm67383595e9.1.2026.06.04.01.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 01:00:26 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 4 Jun 2026 10:00:23 +0200
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kafai@fb.com, eddyz87@gmail.com, songliubraving@fb.com, yhs@fb.com,
	menglong8.dong@gmail.com, rostedt@kernel.org, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv7 bpf-next 13/29] bpf: Add support for tracing multi link
Message-ID: <aiEwl5axWo8_V7cR@krava>
References: <20260603110554.29590-14-jolsa@kernel.org>
 <6e738b0697b9ee06e9cbaa325a3330f0447f4cd12ae54d6b2c82365d58c4c525@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e738b0697b9ee06e9cbaa325a3330f0447f4cd12ae54d6b2c82365d58c4c525@mail.kernel.org>

On Wed, Jun 03, 2026 at 11:52:13AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index d853f97bd154..9e3cb547651e 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -42,6 +42,7 @@
> >
> >  #define MAX_UPROBE_MULTI_CNT (1U << 20)
> >  #define MAX_KPROBE_MULTI_CNT (1U << 20)
> > +#define MAX_TRACING_MULTI_CNT (1U << 20)
> 
> [ ... ]
> 
> > @@ -3641,3 +3642,132 @@ __bpf_kfunc int bpf_copy_from_user_task_str_dynptr(const struct bpf_dynptr *dptr
> 
> [ ... ]
> 
> > +static int check_dup_ids(u32 *ids, u32 cnt)
> > +{
> > +	int err = 0;
> > +
> > +	/*
> > +	 * Sort ids array (together with cookies array if defined)
> > +	 * and check it for duplicates. The ids and cookies arrays
> > +	 * are left sorted.
> > +	 */
> > +	sort_r_nonatomic(ids, cnt, sizeof(ids[0]), ids_cmp_r, ids_swap_r, NULL);
> 
> The sort here can run over up to MAX_TRACING_MULTI_CNT (1 << 20) elements
> without ever yielding the CPU. Can this hold the CPU long enough to trip
> RCU stalls or the soft lockup watchdog when cnt is large?
> 
> This was raised on an earlier posting of the series, with the suggestion
> to add a cond_resched() somewhere in the path. The reply noted that in
> practice the count is expected to be closer to 100k rather than the full
> 1M limit, and that it was unclear where the cond_resched() should go, so
> the code was left as is. Since MAX_TRACING_MULTI_CNT is still 1 << 20,
> would it be worth revisiting whether a reschedule point is needed here?

we now use sort_r_nonatomic which calls cond_resched,
I don't think loop below needs the cond_resched call

jirka

> 
> > +
> > +	for (int i = 1; i < cnt; i++) {
> > +		if (ids[i] == ids[i - 1]) {
> > +			err = -EINVAL;
> > +			break;
> > +		}
> > +	}
> > +	return err;
> > +}
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26881310426

