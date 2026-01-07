Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E738C224B0E
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Jan 2026 12:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767789812; cv=none; b=UTNqhLlegdLAmy0aMJA9CEGVBGTE6ynG55vBLk3VVVNfK215sxjcjlY2AhYbbAeH9FouWHPCa++RbPQ1vyNxTj/AeMlv5jvVPfBQvEuQ9edcpAVAnCyMo5LZPSyEgWS5Jc0BnHxk+anRTqrBDgTwItXsF3oc1WJgPkpEQSpEvfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767789812; c=relaxed/simple;
	bh=fmI6GBURzynMYjqFLO1rLVW4zSGhzymUlAxu3PhleVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I8/AhZjY1HECiTmo0y6VHSWIo+Z/Q/v/zNuR5jADjXEPriW9fqvrGZjSUZnSoxPsK9K9QWudr/tHHbo0XvtzZORu3kb8fznRNFbXLxJRKLSAjYjvk7MmxLAQT7xn5xdVRMAeCDEQo3owHOo5cJ82VhgnAP3MjhEYVloCYYjJr8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U19zvFUb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U19zvFUb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767789809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qYpjdK6xqjiXLPveyKlEyST/b5NQTjITNrUIV5P8N4A=;
	b=U19zvFUbOXIQMBmXwxH+Bw7mO4cGVam4kN90XekODWNEFpNp8b8JB4oMb+YSugimbKFoux
	QOYPF5cxKQk9E3pL8Uh5Bw0Am84gmcQg1x8q71wVJUz312A1JFcIa8dx8GYQWhs2CbK17Q
	9DbiWpYOZAUYvEnwNps8+Afwcmhe3u0=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-fHsbjNFVOH29iD-Kyb8Bag-1; Wed, 07 Jan 2026 07:43:28 -0500
X-MC-Unique: fHsbjNFVOH29iD-Kyb8Bag-1
X-Mimecast-MFC-AGG-ID: fHsbjNFVOH29iD-Kyb8Bag_1767789807
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-38302c10080so2834771fa.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 07 Jan 2026 04:43:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767789807; x=1768394607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qYpjdK6xqjiXLPveyKlEyST/b5NQTjITNrUIV5P8N4A=;
        b=N50R1m596PiEuN0aQTRMEmB7jmsxubvUlv5wT/B96Rk6g7pOAldm0eH+piOLkos/Cj
         91Shu6xFQqfH2WmOVDIhPKWfz0SCT7z2p0LuWU1B072kR4DYLkg87LtGMHa83bw4jlnw
         FKO3TwEjdeK5/JV7nMb78PB6R3JUIZJmxubadeaKNx1lWsgQagFyWir8uOjpZVPcDqP4
         mh15Pe701bsg/w6tPQfk9PkqzsmGarkdRVLnbG5OzlC53kCsp/Vo9UxAaW0gWVCaRFmp
         cMi1sMnDIg8UuktXR8trp+cRtTNyYE4zfvK6lqRkKNOg+NW51FesaoFq2clO7/CAFlcY
         DpMA==
X-Forwarded-Encrypted: i=1; AJvYcCVtIH2vv2C5+8tTNM5BB17VjHnQb6eqOGYpOxsSnDScRa8LyHribNWd2G1ul7hGBkij/37jNY/XPi5tO1AhxXTFtQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZVZHiTVZX48Z0/SEyG+f6IbVbBMZ18aCIkiNIhPEV2xZA8BdW
	tfM+in1NVp3oCf70G4bSV4PuasvWs8BoOv0kpAj7Z8UHt2wF5b6TEcMG81/RGwJwOcksUsGPWAY
	ZQNTARDPU5K+sSK3c5gCWAfTYvtf5+iEFioo5nLJF5uLuYILBCiZD/Gm4nwM1DWqbwzxOVj501J
	6G8LAqew/N8aJCPGjaEETItBXPuZho1F9J4YV2x4EcT5vm+NOz
X-Gm-Gg: AY/fxX5yMMUUkiaRh5AAxjVpFCGfMz1i7XmPHmP3tIXghXutbhhiRog3aV7Vy+DQNDu
	X/fslVuw0bwQjnlTr1pkyd/Y6zqORCUygRsxiiyUjrmw8/W04kBaBQ120CPvqonpC8vAIwaVqmB
	X5D4TfHztjq8uJneXDuvzj0PO4bYthcA8f5ur9kTz/S2D4XxvKOK2pJn4vEDWL8Fn+euvHuJMbV
	F1XZBkk3wrsFc5gTPtTXBv09lOeqWI24fcl3eu8VKWMFkFBLtg8cAGAmuQtK4gVNd7D+3RqJPjE
	JkHP26oGR7rh
X-Received: by 2002:a05:651c:988:b0:37b:b952:5de with SMTP id 38308e7fff4ca-382ff6982dcmr6294741fa.14.1767789807141;
        Wed, 07 Jan 2026 04:43:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHM9jBPzSp9yP/SjuVnAKRT5EyBUzxrL5MI/39iWJVZpfVEHkfC3xCGIi+hK4kmJzAUHK2fLd297HEAyAJoPY=
X-Received: by 2002:a05:651c:988:b0:37b:b952:5de with SMTP id
 38308e7fff4ca-382ff6982dcmr6294561fa.14.1767789806730; Wed, 07 Jan 2026
 04:43:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106133655.249887-1-wander@redhat.com> <20260106133655.249887-8-wander@redhat.com>
 <CAP4=nvT2oPtM73nfPkSJZ4612mcAPw1LWbHNrszFBVAmSJOVbw@mail.gmail.com>
In-Reply-To: <CAP4=nvT2oPtM73nfPkSJZ4612mcAPw1LWbHNrszFBVAmSJOVbw@mail.gmail.com>
From: Wander Lairson Costa <wander@redhat.com>
Date: Wed, 7 Jan 2026 09:43:15 -0300
X-Gm-Features: AQt7F2ohOU59M8pU4jNOqHEDtfqVClEWClJzqZRMA1Tnh2uzkv-X-TWQJ5VOeDc
Message-ID: <CAAq0SUmrRecimVNCa=zv-h3uPm-GpQo3g+ZTV4zLNVA4ZVo-EQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/18] rtla: Introduce common_restart() helper
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WcHIEmVEeVm36CTuQHULe_Wq16agV2WxNGZu-NvWH_s_1767789807
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 9:03=E2=80=AFAM Tomas Glozar <tglozar@redhat.com> wr=
ote:
>
> =C3=BAt 6. 1. 2026 v 14:42 odes=C3=ADlatel Wander Lairson Costa
> <wander@redhat.com> napsal:
> >
> > A few functions duplicate the logic for handling threshold actions.
> > When a threshold is reached, these functions stop the trace, perform
> > actions, and restart the trace if configured to continue.
> >
> > Create a new helper function, common_restart(), to centralize this
> > shared logic and avoid code duplication. This function now handles the
> > threshold actions and restarts the necessary trace instances.
> >
> > Refactor the affected functions main loops to call the new helper.
> > This makes the code cleaner and more maintainable.
> >
>
> The deduplication idea is good, but I find the name of the helper
> quite confusing. The main function of the helper is not to restart
> tracing, it is to handle a latency threshold overflow - restarting
> tracing is only one of possible effects, and one that is only applied
> when using --on-threshold continue which is not the most common use
> case. Could something like common_handle_stop_tracing() perhaps be
> better?
>

Sure, I will change the name in v3.

> > +enum restart_result {
> > +       RESTART_OK,
> > +       RESTART_STOP,
> > +       RESTART_ERROR =3D -1,
> > +};
>
> Do we really need a separate return value enum just for this one helper?
>

If it was success/failure type of return value, we wouldn't need.
However, a three state code, I think it is worth for code readiness.
Do you have something else in mind?

> Tomas
>

