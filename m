Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517EA242907
	for <linux-trace-kernel@vger.kernel.org>; Thu, 31 Jul 2025 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753952691; cv=none; b=dusvBwW40KPFngfLeOQnUOyTNcOCF3czkwS2Fg4FzmWcfilfWYdPDVheSkOK29MpzPyMSQ67cPU13a1fGmZDVazjDy6C7zwA1Kao69M13YIsscg9KjfXr6rHBZG/xyb2YXnqBf/pu5zrsj1n85XVmDJwjtWg7qhDBYvCA3nssUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753952691; c=relaxed/simple;
	bh=IHVPaNKNJnT524DrDueedxxChdVCCbTGEebCYfKW4Ds=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YrswBiWwsCDnAS3EqjjYeys0Nka7cpG2XDZ+zPKV5EODTfzujEQ+9TyJYTZCz9HX05n3QTG9OsgiPB45BcMpT4tL9g9IRyHgbETPWTW5ZB2yWTFAruVkbSUpyJ8WKwOWnQcM1avHTdg/ccrmuj8rRjo+gLQGniEhuNIqE9uaC3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iIIoVeIV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iIIoVeIV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753952689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dHLRfTePpk4K3kS2fqC3DLkyubQlthUhHTjzNjzAlQI=;
	b=iIIoVeIVikJGpmUtChtu8mxMrLPAAQxbmDBY2fCj6Q8cP7Ti5C1LP3xyNWckFILWdGDMmF
	/c6934eqG8ISJ6j1hRICw9/WCenPwkOpEnSogsp+IZgs1l4+PoIIS6LVtqu67b/mZxHHei
	f+ze2K7ZRszyuAIMEeggfHdThwlt3iw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-c0wlc9biN3WHFKtPGnbdmg-1; Thu, 31 Jul 2025 05:04:47 -0400
X-MC-Unique: c0wlc9biN3WHFKtPGnbdmg-1
X-Mimecast-MFC-AGG-ID: c0wlc9biN3WHFKtPGnbdmg_1753952687
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4563f15f226so528545e9.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 31 Jul 2025 02:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753952686; x=1754557486;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lMND2eCV1zriOEfTEYyl8gkAo+zM/ZdiGMIBLba1//A=;
        b=HH6sexi4u/29xyQf3dtCHRaCjjW7P9BPa3i3bqmEZZ83sDoN1gA85kmsKFUrBuZcyP
         NgTN1r2cRXBlIqpiaTClTAXoii0FCmDaJM3yfm3qVVwTimUjDxnRT/RRxuFGDz9y2ZR8
         fGHJj/ia55pKQFtiD1pzPoNqA1gxNyBNqovAgzvqNzbRIy/2ZlG94LRIiNKe+EaRx0Ql
         0AGho+247U3l05D6wjOjgwJg1StWDOjhh9mCYfY+5pe7JeOoppZU33bZhw5zcaVyoPSt
         JYbejwlgAC4Lk0+TGBCEum2GOMoUgrfcLAtmBhJNvtbjnCAVUlPVrELMXWqRNFU43+74
         i99w==
X-Forwarded-Encrypted: i=1; AJvYcCV6n/sNWxvIYjb9x9uPUDlLECRPUVF1YOZlkjjQl8x0/seyRr08Roa51qt66eEXuK2Q1U0mXX4dZehPpYmXULMMNBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7WJTcbHygRfYNHHniZ9D8xcp52CHZoCpdbNNqOftxfrtO19pq
	TBcG6WDFjiD+qiX3qdEFvHEXuBq+Mga080iAhDvzuNbq2TAVp6V84w9IvHR2oszqNmFh8uHyZU/
	TZohKJveeuWVlMTuYsN7qSOHpl1dkj52DwzK1Vbbeug8O8jEVOVVyR4rHg+mW5Ra6DRQjL9RR/I
	icITLGRzej
X-Gm-Gg: ASbGncuicfMAhhPG55rlHXNnJ5TNRo1ugMetyb+nf5JiUP72I7avfLP+9QXvAGE3WmI
	dfpsTc7SrHcb9QvpvcPl9eucqgvQ5eJEJ0d3UDXokZWFvqcKdP7ZbeNTYFBe2U5n/roCzVekdxU
	8LvV3CCDrunMqsfDUQzHu6vAj41D2FKF8WZjTchwbkJSi7m4sTqJzjQDSSgRWuRKZjl/7vLvTWe
	e2yfKSwWFqm/uChBObMcLYr9b+ZpAwXsjRa5ug9QAoerli9bhd2fC7K3yjpbB7Oqi6UO2uVjUK8
	uIY1yXvXm4CFACo8pevelcRdyRGGrrPQ23h6Z9h2Lx7JRYS5j0ewVK2RQnZQ3aEeOw==
X-Received: by 2002:a05:600c:3490:b0:456:26a1:a0c1 with SMTP id 5b1f17b1804b1-45894ca4e2bmr49609035e9.17.1753952686574;
        Thu, 31 Jul 2025 02:04:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcyvCOcWpMoydPfhIGcE6BmPHyVSaaAWvBnHj4Nb20j+gkWmRYUb+Jbh+3IQ2C1Hevzf9Pjg==
X-Received: by 2002:a05:600c:3490:b0:456:26a1:a0c1 with SMTP id 5b1f17b1804b1-45894ca4e2bmr49608735e9.17.1753952686145;
        Thu, 31 Jul 2025 02:04:46 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953f8e02sm55775935e9.32.2025.07.31.02.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 02:04:45 -0700 (PDT)
Message-ID: <adeb68b39e8b468da685bbbf3b453f947fe2336d.camel@redhat.com>
Subject: Re: [PATCH 1/5] rv/ltl: Prepare for other monitor types
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 31 Jul 2025 11:04:44 +0200
In-Reply-To: <0d13c61bc6e0dc82108995c9a1d140bad4082039.1753879295.git.namcao@linutronix.de>
References: <cover.1753879295.git.namcao@linutronix.de>
	 <0d13c61bc6e0dc82108995c9a1d140bad4082039.1753879295.git.namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cpNGB71VuBwhHHZoiH7ooDwGkmw7rzfIl2bNkJwula8_1753952687
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-07-30 at 14:45 +0200, Nam Cao wrote:
> rv/ltl_monitor.h is the template file used by all LTL monitors. But
> only per-task monitor is supported.
>=20
> No functional change intended.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> =C2=A0include/linux/rv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0include/rv/ltl_monitor.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 85 +++++++++++------
> --
> =C2=A0.../trace/rv/monitors/pagefault/pagefault.h=C2=A0=C2=A0 |=C2=A0 2 +
> =C2=A0kernel/trace/rv/monitors/sleep/sleep.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 2 +
> =C2=A04 files changed, 55 insertions(+), 35 deletions(-)
>=20
> diff --git a/include/linux/rv.h b/include/linux/rv.h
> index 14410a42faef..175438a22641 100644
> --- a/include/linux/rv.h
> +++ b/include/linux/rv.h
> @@ -28,6 +28,7 @@ struct da_monitor {
> =C2=A0
> =C2=A0#ifdef CONFIG_RV_LTL_MONITOR
> =C2=A0
> +#define LTL_TASK_MONITOR 0

I stole your solution to get rid of macros for the DA as well (might
post it after this merge window or with the next changes) and I'm
currently running with this:

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 14410a42faef..6a7594080db1 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -13,6 +13,10 @@
 #define MAX_DA_NAME_LEN=09=09=0932
 #define MAX_DA_RETRY_RACING_EVENTS=093
=20
+#define RV_MON_GLOBAL   0
+#define RV_MON_PER_CPU  1
+#define RV_MON_PER_TASK 2
+

The numbers don't really matter and you don't need to implement all, of
course.
I'm not sure how are our patches going to coordinate, but I think it
may make sense to share those values for all monitor types.

What do you think?

For the rest this patch looks good to me, nice use of the typedef.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks,
Gabriele

