Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B851729A9C9
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 10:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768818017; cv=none; b=UVyix4bMqMTXCjNySPLDPKFj5hQb4e57W59L7Zd1jyOWoksVjI2LrLBSH6VUO1LwxQTU0bd75uXBsMYyrQeadrPw7NIyoXFBbNWUUb9TlURQBT2yyuiIuOGwfzjnQ5PCcOltMd+EXXEg6zjDgozBGeZNDc2C4W9vqPeEsQ8woUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768818017; c=relaxed/simple;
	bh=rvbQI62i4mtAotc2MpDRqaxn9YoF5/eNwEuQEPtP2sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gT9L+Rurqyb4f+DQpHh6Mx7ucF5y671DHDT3OnGSnEm5EiAlFwqaAi69hIqXd22mqdUObX8evMHV2A1ah6u8ifEA0DXCaT7lsCSHWEJDWN/C94k3n+xr4e88xBVVRKO0x1AiZqXnDAiub7fVqB8sLyqucIrmAxswoQ0uNDC9C+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XcKujNjL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XcKujNjL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768818014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CZ7h+X5PUzUJFRlyxGa26OCMfvSLNsMYWmHGIZyf0n8=;
	b=XcKujNjLkDq0Ipu1Ng95YoX/PpYUWXCo7WnCRWjCKqPM9ezeh4OOlw+BNrxO4wCMt+OtdA
	xUC3QHgCAS8wCQWUXThPKiXdg5Z9M+FrUL5S1OH8/KmoT8m21A37KyO78PPmImSlanxQGv
	k0Ht6zAUHnGgRotbAlrDnuztD6EHpts=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-Wh-llpJ3Nyy7BbvSMmQ_3g-1; Mon, 19 Jan 2026 05:20:13 -0500
X-MC-Unique: Wh-llpJ3Nyy7BbvSMmQ_3g-1
X-Mimecast-MFC-AGG-ID: Wh-llpJ3Nyy7BbvSMmQ_3g_1768818012
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4801ad6e51cso33829955e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 02:20:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768818012; x=1769422812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZ7h+X5PUzUJFRlyxGa26OCMfvSLNsMYWmHGIZyf0n8=;
        b=FdABQput0yRoBnr4nibrxJPqC/oSEiR/+WBbcoYgoP+J6EzAMBenNeZSs3bRiPUKjq
         LhLvWrrHsD4j3Y2j/heUzS23YkGsyU+XwGY09yt9+9sjbvhmN1fYLzGCK4QtyyC4Hn8y
         lAmxLlk/KO0o3/VId7myuUxQN3mbeAWKF8vdO+yEpqZVYPGCBJZOJC7/2HW6+feBO4sJ
         a3gHsrKVbRME91+/RrEYj78WWwOz7il3hsJrKP+L5qSNSYT5+tdEP7WjBB0NkN5lZfHc
         66Fw99/612DbnelSCNM5T9LvWBc+WDaLik3XisGQ9sQGFUesyj2pVNsx4ZNbhmUrTkb3
         Q+Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUlNeOlFtA5aIV9XhrEV5eXqsiDp4PhpDZuKKT2l4tJPsGmqQ3AmXfRtWSdCwVnk4Wv/rx2fEXJbaEwv49r6rTblq0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwa1N1mdAPa2fEB09fbBtGuxFIDsBaNM/Bzk9JVSQroLotyufk
	HqX7FpMs0H8S8QPzCgQdWT1cir2mWsfarxkqSJtQyriLKx4gwgTncX2bc+TiMDALrfR6y5Nk7Yn
	R1qtpIS+ZnnAllG9eXWH4lxqOTbDs97dV296sLEzXUy/hc0vn5uBefmgFNhoyTX8fFQoz406/Ew
	==
X-Gm-Gg: AY/fxX7HEonmCZTEutFT021ReIwUnyApUN53pBLjjyLNHXfaWZih5/0wMLK9qjHcBsJ
	APy39gJd39GFobB1t3WhulY5O0Dygzn333iOoB4iTTqfIlbq/OhdYRovxJ+bJB4wHyEfWJuDf56
	j2uwVs0kdmko+o9AxBDglXdoukW/AILKCQ8glTKmFi6vvXiRyvqdSsgqCpX3g+L4gVF+q/Ikknb
	n/4RFzQvb0M+1FVypm/pmIwofMZkLGSNG8FLNlNsnFu0WkBikfhyzxgkBTlFUGpIWUzmX2guBIe
	RopAanD9tTqZB0PW4nV3PVrvx8M4IZ6z+xuJ4pmZadweaOxRxy3rUOsQo6RcmqSTu1qAmrKlrH5
	A2uz4nHuEDuJF0BaHxmw3dHLryOQPGIec9MTcwu21
X-Received: by 2002:a05:600c:4e43:b0:47e:d943:ec08 with SMTP id 5b1f17b1804b1-4801e33dc26mr125607945e9.28.1768818012241;
        Mon, 19 Jan 2026 02:20:12 -0800 (PST)
X-Received: by 2002:a05:600c:4e43:b0:47e:d943:ec08 with SMTP id 5b1f17b1804b1-4801e33dc26mr125607705e9.28.1768818011852;
        Mon, 19 Jan 2026 02:20:11 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.129.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e9ce5aasm84014345e9.2.2026.01.19.02.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 02:20:11 -0800 (PST)
Date: Mon, 19 Jan 2026 11:20:09 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>, Juri Lelli <jlelli@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-trace-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v4 09/15] sched: Add deadline tracepoints
Message-ID: <aW4FWVqgtk_cwPPI@jlelli-thinkpadt14gen4.remote.csb>
References: <20260116123911.130300-1-gmonaco@redhat.com>
 <20260116123911.130300-10-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260116123911.130300-10-gmonaco@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3X0Bs8yZv5ipTzVht0EKFpzQ7h3owlE81rRfhDIcFDY_1768818012
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 16/01/26 13:39, Gabriele Monaco wrote:
> Add the following tracepoints:
> 
> * sched_dl_throttle(dl_se, cpu):
>     Called when a deadline entity is throttled
> * sched_dl_replenish(dl_se, cpu):
>     Called when a deadline entity's runtime is replenished
> * sched_dl_server_start(dl_se, cpu):
>     Called when a deadline server is started
> * sched_dl_server_stop(dl_se, cpu):
>     Called when a deadline server is stopped
> 
> Those tracepoints can be useful to validate the deadline scheduler with
> RV and are not exported to tracefs.
> 
> Reviewed-by: Phil Auld <pauld@redhat.com>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Looks good!

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri

