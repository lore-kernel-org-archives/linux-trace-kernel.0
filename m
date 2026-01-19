Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CFA1EE00A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 11:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768820685; cv=none; b=Xe3WdVpQAEHFZ3Pv2oKz5CrkxtkIK4PZ+3VHDdsghTjqs+l1gTIRKTwhSLw+cZAJL6kY91uUxgqA+7zHif5xtlrp6MJHgjBXsKAlL3bSgwHhrpzwIkW7nhTnoMJEk1LZjr2IXbz7YsN0c3YYmR603xXUHWJTWU7gmgY7kgfftW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768820685; c=relaxed/simple;
	bh=/muiXxKbxDRdO0MB+mCm4SfaD5B3F+0ImKkl0B9gKiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=l78xnw7aw3dwKHy/Dpd4ZxIuhzFgJK2kZMvPXgrYX8e1Ie1UOA/OhvCMqSvDg3wuNzdDywPPrg/rTu7CrhrOIXXPROwp6JlFDNG64HsTkMAdPIpoMVnvxZLkqWz5ydQDCxw/OxbeAtGy7mvuAUbs1QwExm9/Tlv6bjvoiqT8dWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HxTcbU6j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HxTcbU6j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768820677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hNfGrzoWgmkgHbgWpkrQnRoddNG6uHNGHcsuvEPWnR4=;
	b=HxTcbU6jX+9cDN/pOehKq9wAshavrWD8wAMOuaGnrjkYMZE8B4hCr+URLBwfN7qvXpbqcl
	3iVcMzpcADXmggF1cXMwRiI2B97PTaD8zr0+/4m8/lpNXR2cv5XdMYBw3t433Dtv9vKKQr
	wXltRV2ITFqJpGrbB2HNh2ubhn3xO94=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-I7FXaRepOrqTKkj9ApnP5Q-1; Mon, 19 Jan 2026 06:04:36 -0500
X-MC-Unique: I7FXaRepOrqTKkj9ApnP5Q-1
X-Mimecast-MFC-AGG-ID: I7FXaRepOrqTKkj9ApnP5Q_1768820675
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-434302283dcso3256465f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 03:04:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768820675; x=1769425475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hNfGrzoWgmkgHbgWpkrQnRoddNG6uHNGHcsuvEPWnR4=;
        b=nPnUIqJZ2UMnktkDybpLQ1myc/wsRUH5fOH6OHiRRHhJeWpxVNWL+ECXi66oP1aUvp
         +XsfA5n47APtU3PPchyrJdr7yk2mHY4OlFbJdb+HXQD1pua1TpPS74egjWYTJjQMhZc0
         qwTIjzkfJkSVKP1k05qQVyHfd3o2IfMoO0XzJ1BOt9fSTW2eh/cGBFLm+JNIIWTr7Ia0
         MTgpcsbNHLWrVlAgQgZyX5oquuDFM7BmJBjGdWR/ckUJduUrGTdU6FUAP2aUu4WViRQ9
         wWgi0OueOibdFwmbiTdIA3LTw4TCmSmukcuQkt3h80MoL3lNelzu5oCZFYsU3Hm5CT+n
         odOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI0PK8acQRv2bk1Rp8vSxbKz+k5P5qK2tzXCeT6tZ7rPW7qEdM88Eg55Kas0NcW79qFhHiQQLoT2Td3M6FBekak6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqLwQBw7c+5O3yJIDMLFBXOOhdgUUZiE2mO+FyaFVXiOIRp2qG
	EEiwOBMxoUW3bpi1CIR0WoXG6krt+3VKpcsrOj+pA2LePQbabCMxesByyXKkEBg3x75KpVl+loJ
	qPe27Mxeo58uJGVtmHIz8pBQ5wl5b/Dx1p2YY/Zs9ZtAAgNVcbxN5jKTMNxcUDfHzS7+HC0TAGg
	==
X-Gm-Gg: AZuq6aKWcMVHGRTudt+er2Xb/fBRiBRTzbLkW6MpJi00FrXTrS8cJx+j2pbH49BF67h
	d/50gNdbqaodx1ykSSacY7N9K7P2ddYJqVF1J/aO6rr9/ajQpXu6NbC6dp/NfOjlVSDZWYpj2tS
	6DbzkbfAFK4V3/mCZo5vktIx8bp67eQDXV6E2uIVo78RO9Ngz/Hcg/gf3iMCmPy16OxgQ7XoxMJ
	KyLW7+Xk7/J95MR9b7WLoaaa9VrcAbbYna05GU0ImzG77pySSV1USPjioUocF/9dfYBkZbNMkXv
	ThEYkdcPc/lGj3D+xjSz4+MFISopECuZoWyrfpynHkDgAJVeBoZ24LqFThbYuK9B7kHKSHXczCq
	udqJ0fDTQ+olPM3BhHjrq9JJtE61oPhPuM+TCU0aM
X-Received: by 2002:a05:6000:1843:b0:431:864:d492 with SMTP id ffacd0b85a97d-43569bbaf7dmr13975641f8f.36.1768820672854;
        Mon, 19 Jan 2026 03:04:32 -0800 (PST)
X-Received: by 2002:a05:6000:1843:b0:431:864:d492 with SMTP id ffacd0b85a97d-43569bbaf7dmr13975591f8f.36.1768820672434;
        Mon, 19 Jan 2026 03:04:32 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356996cf33sm23073587f8f.25.2026.01.19.03.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 03:04:31 -0800 (PST)
Date: Mon, 19 Jan 2026 12:04:29 +0100
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
Subject: Re: [PATCH v4 14/15] rv: Add deadline monitors
Message-ID: <aW4PvcDxBJnDLJFq@jlelli-thinkpadt14gen4.remote.csb>
References: <20260116123911.130300-1-gmonaco@redhat.com>
 <20260116123911.130300-15-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260116123911.130300-15-gmonaco@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Cgv0A2W37IRS9LuKS3xJRRm01QBxw116ol7AaEfYVUE_1768820675
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 16/01/26 13:39, Gabriele Monaco wrote:
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

> +/*
> + * User configurable deadline threshold. If the total utilisation of deadline
> + * tasks is larger than 1, they are only guaranteed bounded tardiness. See
> + * Documentation/scheduler/sched-deadline.rst for more details.
> + * The minimum tardiness without sched_feat(HRTICK_DL) is 1 tick to accommodate
> + * for throttle enforced on the next tick.
> + */
> +static u64 deadline_thresh = TICK_NSEC;
> +module_param(deadline_thresh, ullong, 0644);
> +#define DEADLINE_NS(ha_mon) (pi_of(ha_get_target(ha_mon))->dl_deadline + deadline_thresh)

...

> +static inline u64 runtime_left_ns(struct ha_monitor *ha_mon)
> +{
> +	return pi_of(ha_get_target(ha_mon))->runtime + RUNTIME_THRESH;
> +}

Why use pi_of() in above cases?

For the first, in case the macro is called while the task is actually
boosted, we then might continue to use that even after such task gets
deboosted?

For the second, current PI implementation (even if admittedly not ideal)
uses donor's static dl_runtime to replenish boosted task runtime, but
then accounting is performed again the task dynamic runtime, not the
donor's (this all will hopefully change soon with proxy exec..)?

Thanks,
Juri

