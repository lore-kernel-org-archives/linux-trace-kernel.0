Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3E93FFAB5
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Mar 2026 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772462276; cv=none; b=WeTzhXXfgkCvwWGwAXLRcXyAkPh+BYjXPKwJLvrh8HaKTK905ol+ib6dcPDyG4Jw+v7lZEM9rNKNWz6jLxVJ7tENtLdj3E6vsgumph7ynnxMGht/j8rHwbR6WllStMXSOyiYydBUPy0sGir8pxAhyZAhSABUWWv0ihZ1GwcGAmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772462276; c=relaxed/simple;
	bh=SG8Nvfo7w+sgi8qsb3e/oi2kuPyTcOKT0aLGoFOWCGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=WRVZMahnRUiV3Hloc/cNlkFce67+g95cGKOf43hjpOLAQUdqgGsZ0JdCxW3bcPZ0zFeaEpidfUC4CDVFBpbu3ih2lantM3ooWBaqGhvI7wdiFEsCKXIp6kokIIzmjzf3gjmghqvR6F2uLV1rnzhm6YGtdHmTn2qUbxijY+csg2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=US15FsXc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="US15FsXc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772462274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8sJlSZs5xrhC2dH3em7lfnyFktrvfkJs63IZ5CWmLzM=;
	b=US15FsXcWrW7cwRretuuP6b2n9seRS7dbM0m7FzjlT3duWXsWe4nQAf5IKrem8BwcIu4La
	WQovAbs0C1u0eIPcu+TYfM4oauZsiZt/JSvSzWne27jDXffONqNgY2Ja2kEEaThJSgZqvf
	HhRAQNxkd6wIhiQSqGTeLFF/WBo1+j8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-4GAVslSdOoqVJA3glu4a-g-1; Mon, 02 Mar 2026 09:37:53 -0500
X-MC-Unique: 4GAVslSdOoqVJA3glu4a-g-1
X-Mimecast-MFC-AGG-ID: 4GAVslSdOoqVJA3glu4a-g_1772462272
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-483bcfdaf7dso43145135e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Mar 2026 06:37:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772462272; x=1773067072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sJlSZs5xrhC2dH3em7lfnyFktrvfkJs63IZ5CWmLzM=;
        b=d5Xs8qCX/cSlJMf45x1uAq/jxoZZwNIOvpCWXNPHKX1panH8IJ3J8MCJL2MMLSNaTH
         mosgmd2OO4T/PflMHCkRmH+r5Fi5vOrBqQ6+IRFSvk0Aib8PxcrUc+zUw/zrFs8JyH8t
         De8LWpg5N5YY9b3uDcYlzDBNYDHOo17yIZgfj+A+EpF5cphPzmvlLZFpTf1qFrSwB9go
         k0oJcVIWOPFjWrhmzscDL73Ag+4Vsdfz9dqNrz9o1N671ucyvD94Qvl1kXb9BcdAEKdK
         LjFubPt/pAUf09EoBVQMH7zGvfukCRk/fWbN40R1/xPiFBtgluq9NnSgkx6QnX/W3PJ8
         3Uaw==
X-Forwarded-Encrypted: i=1; AJvYcCWeW1EPvpSd2f1fhJS2L7bem/FYY+X9QsQl3J5Rm7PbdFnldGdjRHSLAaIhsg9dP90UGl9mZynmSHM4B+2Y4LWv91M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxntD3ofmN5xzev++tZLya+LU1R77aW9OPh7kFGTjhdeYXOUr0v
	N7+l0LLtR2E55SkRFxACKFKEZbc5awr3K7auh5PA3j6xFcAvDhRtt4syd9AcT+SetlN3r+dz5ZX
	EbgnRQ28rZTgh+SO4/MLWHr3hguXk4i0C4ewHMxDcyXCTX8ZdTtuzGA1JzFizfvMM/wwENiVPXg
	==
X-Gm-Gg: ATEYQzz7QRd+YU8TVYy5jRbzLHM/loB0tYvKv6ONoNpGzQiNSLI8n7xhMEDMfLnJI/L
	wMaBcV/5+nttJO5FVN7n48Dks7zZ99t6p5Q4aWKNZFz/vJ7Ut/9ex10Y1hrVI6gRYejwl6YGH69
	fvnr+u7r3OqfJt9GVWuXYbmFNHGNa7AEik4xIzz3jc2f0NONn5QBKVxM3HwYpsCzjNyplaDpN/p
	q/bCvLRROpWdm7LEqbMTc4gFUYG/RbWQAFZy/X/Bl1iJ/nmpDTOISneZV4AWHNLOwTsoc5ov45n
	E6tuTje5BqXfL5CdMFl+KFWmPejgv4ABlyktZAwq4btvW77y1ANnhuz96r+t5NGq9Hhh1hKTUv3
	jLHWbnyFetDdwW71m0EKrZQiKPxP5SOZ6MOgJE3IMuengE7IIxpQ=
X-Received: by 2002:a05:600c:3486:b0:480:3a72:524a with SMTP id 5b1f17b1804b1-483c9bed89emr249011825e9.19.1772462271938;
        Mon, 02 Mar 2026 06:37:51 -0800 (PST)
X-Received: by 2002:a05:600c:3486:b0:480:3a72:524a with SMTP id 5b1f17b1804b1-483c9bed89emr249011255e9.19.1772462271471;
        Mon, 02 Mar 2026 06:37:51 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.73.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd70e6c9sm361018285e9.8.2026.03.02.06.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 06:37:50 -0800 (PST)
Date: Mon, 2 Mar 2026 15:37:48 +0100
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
Subject: Re: [PATCH v6 15/16] rv: Add deadline monitors
Message-ID: <aaWgvBXaNg48qYRl@jlelli-thinkpadt14gen4.remote.csb>
References: <20260225095122.80683-1-gmonaco@redhat.com>
 <20260225095122.80683-16-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260225095122.80683-16-gmonaco@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EEUDAbOL-gEgsvNR_5H-QEGRdTIHuQxWlt9qw7kLCio_1772462272
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 25/02/26 10:51, Gabriele Monaco wrote:
> Add the deadline monitors collection to validate the deadline scheduler,
> both for deadline tasks and servers.
> 
> The currently implemented monitors are:
> * throttle:
>     validate dl entities are throttled when they use up their runtime
> * nomiss:
>     validate dl entities run to completion before their deadiline
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Reviewed-by: Nam Cao <namcao@linutronix.de>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---

...

> +static inline int extract_params(struct pt_regs *regs, long id, struct task_struct **p)
> +{
> +	size_t size = offsetof(struct sched_attr, sched_nice);
> +	struct sched_attr __user *uattr, attr;
> +	int new_policy = -1, ret;
> +	unsigned long args[6];
> +	pid_t pid;
> +
> +	switch (id) {
> +	case __NR_sched_setscheduler:
> +		syscall_get_arguments(current, regs, args);
> +		pid = args[0];
> +		new_policy = args[1];
> +		break;
> +	case __NR_sched_setattr:
> +		syscall_get_arguments(current, regs, args);
> +		pid = args[0];
> +		uattr = (void *)args[1];
> +		/*
> +		 * Just copy up to sched_flags, we are not interested after that
> +		 */
> +		ret = copy_struct_from_user(&attr, size, uattr, size);
> +		if (ret)
> +			return ret;
> +		if (attr.sched_flags & SCHED_FLAG_KEEP_POLICY)
> +			return -EINVAL;
> +		new_policy = attr.sched_policy;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	if (!pid)
> +		*p = current;
> +	else {
> +		/*
> +		 * Required for find_task_by_vpid, make sure the caller doesn't
> +		 * need to get_task_struct().
> +		 */
> +		guard(rcu)();
> +		*p = find_task_by_vpid(pid);
> +		if (unlikely(!*p))
> +			return -EINVAL;
> +	}

Not sure I get this comment. RCU is released when the function returns,
but then the task pointer is dereferenced by callers?

Thanks,
Juri

