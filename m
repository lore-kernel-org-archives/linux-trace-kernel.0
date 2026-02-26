Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB753425CC6
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Feb 2026 16:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772123170; cv=none; b=ZjsskTfbiR9hP35uDaVvLAyivduLmkN3ckb2jhwqmYd4rAMiZh2ySgWAJHHajW4oQSO0qKGwQ6SxyvXxiLxbEwbrfdVh5ffXyS368TgCE/oNCMyi6tixudtitKe6IG8I5qBYMvBVnnnc/nDSr8nqdZ/GjjHyrxXy7FYA511lbXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772123170; c=relaxed/simple;
	bh=iMz3JjCEEDgr+u+ZxWBQIDxqJrYAmRmu6TUKDJU0hKw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=kmB5JRbvl6pGF70stHkTBydnxRAdTCSbx1jwywm0LPzFfn3+Wa3YLSP1AAinFGne0oTMbfj7/hW1yn+3sUrxC2WrQhYyuE2Nz4vNuNCWO1UiHaB/6VVybE9eiU++RcNlCJKkvFRNH+5qKpYxZeiPvKOCzgWru998Rb86LJ2fHmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PbiPwtwg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PbiPwtwg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772123167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iMz3JjCEEDgr+u+ZxWBQIDxqJrYAmRmu6TUKDJU0hKw=;
	b=PbiPwtwgG28Rtjo6WgJ7kVy0ahEcskfLMo03zcN0rjam2dIWvpFZOExkHkjL1SrhebpvsL
	ier4mdNnjpHrDZQ08hutAl4ozuweU83ifK9rx3Fj7sFCbqqmJrUt91kR75GInL4aXLCNIV
	uwE04QPykBkoFCONh+1fxMNbDFf80Do=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-G0pLLT-HOVOmXRcEzhXT0w-1; Thu, 26 Feb 2026 11:26:04 -0500
X-MC-Unique: G0pLLT-HOVOmXRcEzhXT0w-1
X-Mimecast-MFC-AGG-ID: G0pLLT-HOVOmXRcEzhXT0w_1772123163
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-483786a09b1so10857165e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Feb 2026 08:26:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772123163; x=1772727963;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iMz3JjCEEDgr+u+ZxWBQIDxqJrYAmRmu6TUKDJU0hKw=;
        b=qDNwHSkfAS2kF/kqZwWM7SJ1v6BtyucgLFvLYpAvSjTAQa8cOhii73UKm/QsEhPez+
         lrkB9bVybNGsh2vCZTEyCjq/vnPis4MTKj+mJ+/HNdhiXXM/5Eu95JzYpxjSB2lt0YfF
         pPgCawzupovcfg7l+ltjfg4mPihvzb2epaNhCCvz3cqnHlzE9FOeydE6XSzrno+Y7XeQ
         xRDd4Era49CPayzQmE1Jfrm5qQnnEcRWkhr5Zh8/Fnstokijlf8GbyPtHn/qFetKUDOO
         Uob3sp1w5dYdOA8cQdY+K0jMWiKISphpJbmGpn8hcr+mMVjsibqcRLPSlj3L8GPpOn7z
         9OtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbbS4NSdRt3IvFQRpCF0h+xLp5abirUVY+fQgz4EiSHbHy7zAtB0MHOaI33IzVD5GjKeRrcd6q9kATWGo04BYxeTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMpaSD5wzW6PcW+nlotJrc3QhxwQyv3FD1XZKIU1rRemSbSGAJ
	nu0sD7q8OBuSMB2F6IOSfFuQike8cqQLDmeJJvQJGcM8hKmSYs5hjIiNzq3uaFBCDTb4WrIud7M
	Nke1px5wXg9bRjla7109n5QMuwHPjrbLAmiqSkW3G+p63mV6RF+ddn5VYzN81GJwOtREPtd3j3g
	==
X-Gm-Gg: ATEYQzyeGyzrAFdufYnjz1XznXtkDPouzVwh+KlqYq3V1+IHzBVPeGtzvUbZDyUzWh7
	7asnzMzuTbQwTFmxAQtk52xM29T34TDI6UC05HQjlrU42GCaqYcpsS7aX/jACEZjTmnTa0V6wnG
	baOHRlEXk83n4Lp6PMZJtHhv8qju5xaGVIFCmZH2AWM7YBh9yJH3nNpmDJfye7C8GVjU4KRtUM/
	hWbVoQpzE3UbjYG/PUzU+3EE0xUMAqVJ/jMjauYUYxcE/MQy0l3dqYXAZ+rn/3NHZYOGx9Wnt5t
	Zqf3wps/iG5yKrzkKO93nZoUxeqizykyUBEpSiFIoOAUbfFX2JFrymA7AuJ/NIuDWBz6lQyJD8w
	fQIbUxoOYzcCbOXJD5Q==
X-Received: by 2002:a05:600c:4f11:b0:483:7903:c3b1 with SMTP id 5b1f17b1804b1-483c3de3911mr35388985e9.20.1772123163010;
        Thu, 26 Feb 2026 08:26:03 -0800 (PST)
X-Received: by 2002:a05:600c:4f11:b0:483:7903:c3b1 with SMTP id 5b1f17b1804b1-483c3de3911mr35388675e9.20.1772123162585;
        Thu, 26 Feb 2026 08:26:02 -0800 (PST)
Received: from [127.0.0.1] ([195.174.33.230])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b3d24dsm44190465e9.5.2026.02.26.08.26.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 08:26:02 -0800 (PST)
Date: Thu, 26 Feb 2026 16:25:59 +0000
From: Gabriele Monaco <gmonaco@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrea Righi <arighi@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>,
	Juri Lelli <jlelli@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, sched-ext@lists.linux.dev,
	Tomas Glozar <tglozar@redhat.com>,
	Clark Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org
Message-ID: <deb203ab-7564-4bef-b4bf-053c6ec08f27@redhat.com>
In-Reply-To: <aaBrMr5O4455oU31@slm.duckdns.org>
References: <20260225095122.80683-1-gmonaco@redhat.com> <20260225095122.80683-15-gmonaco@redhat.com> <aZ8snSHWw-U0lVz2@slm.duckdns.org> <8fbc3ced19fb0c2a2171708073fa51ae308755b5.camel@redhat.com> <aaBlJT9Mac9KQpKL@slm.duckdns.org> <f49a6db6f0070350cb2d2b023b5733a3646996f2.camel@redhat.com> <aaBrMr5O4455oU31@slm.duckdns.org>
Subject: Re: [PATCH v6 14/16] sched_ext: Export task_is_scx_enabled() for
 verification
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Correlation-ID: <deb203ab-7564-4bef-b4bf-053c6ec08f27@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eizfJiUwsBLSJHu1PU4I4Eux2KxZ5r-HvWHl608EyBY_1772123163
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-02-26T15:48:11Z Tejun Heo <tj@kernel.org>:

> On Thu, Feb 26, 2026 at 04:42:34PM +0100, Gabriele Monaco wrote:
>> scx_enabled() might as well be exported (together with its static key), but I'm
>> not sure exporting the sched_class is the right thing, since all those scheduler
>> things are quite private.
>
> Don't you just need the sched_class pointer? Can't you get that from
> kallsyms?

Yes that pointer would do. Do you mean getting it in a task_on_scx() reimplementation I would just use in RV?
I could do that but I was looking for a more standard solution.
While very likely the pointer to the class and the class field are here to stay, having a function like task_on_scx() directly available in include/linux/sched/ext.h is less error prone and future observability tools might need it too.

But let's rewind it a bit, if it is a big issue not to have it inlined (which probably isn't), we could just go on with something like _task_on_scx() (inlined, for the scheduler code) and task_on_scx() for other users. Wouldn't that be acceptable?

Thanks,
Gabriele

