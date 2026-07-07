Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C494252C6
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Jul 2026 07:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783409022; cv=none; b=VFQ15oHbdfYoXABGawayQOlPcolAbISSj6bFbQlFzsB/vYRpLE/bizIpEzKh+Ou95F8SkpDVPB5PNOcKRFG/e8hPCEwpfazFtHMBe1fYDAl7IbR7pwLeIaSo5qjKz3x/S8CYk/ksgaPQ8R46HhJlSqGpaj+uQVs+EbCxxaPfwqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783409022; c=relaxed/simple;
	bh=H5uZDARIoPVu0+cgA55LNxyWBPEvQr0/tBGPw/Dmoy8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ppv8OsefPT7DisrDeloB8pV3MgCWR16sKS1EFjEUdG+RzifkGdpz/ANnejLezDHRt0wvYDH3b1OHx3sInEuINd/NYcezn/gaqavpwqr2BrKt2MpNRVuQuZ2axpQWT0VKX7NU6flFv0x1fGO6eHgz4x7hGCuZiEvRaYc2QvrihN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bw8GC0ZO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bw8GC0ZO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783409016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=H5uZDARIoPVu0+cgA55LNxyWBPEvQr0/tBGPw/Dmoy8=;
	b=Bw8GC0ZOSEL+AuudOFkZbDd8SFkr3g79x8A15OkTpJtPErnBah6bnjCl0u8XiofIpFHhb1
	uOtsWBGcHMEj5J/sD4bXEULpbKdeS27ztuJK8dh/L9KaICjpZxMm/i7JrYF3c37ykvnMUT
	sJPD/I95gBlHdEd4UhdGZR/YZknzWM0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-BzXbk8ZeP5CpO25UZcGVvg-1; Tue, 07 Jul 2026 03:23:35 -0400
X-MC-Unique: BzXbk8ZeP5CpO25UZcGVvg-1
X-Mimecast-MFC-AGG-ID: BzXbk8ZeP5CpO25UZcGVvg_1783409014
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-475eba52438so2893491f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Jul 2026 00:23:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783409014; x=1784013814;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=H5uZDARIoPVu0+cgA55LNxyWBPEvQr0/tBGPw/Dmoy8=;
        b=AliXEuvpClmt2B/xIFbIAEJpf5ttWnifnKiE6lJoHacsNW410iipz1WUUHmyL5dHri
         6K5G0aTAnVVB3lWLdoU3pvq55BBls8UfFCcPGK5sKvqN1t1iCGdKOHdf1+Zxn66KSD1J
         TJHWfTx5t3dh/aHr4us3X4UNdSuUIakktrOuJ512ZXLJ4u4VOnXdAmVfVtiBTnEAh6W/
         4rJ2cZRoRd1cZecr4K12iobM8qHdDxWZ48MKl0T3V4ZNmd9OGABX2A8EUIpWUJCjz8wg
         CzwlVxx05CP+ggGfdTgYCczMqgYNJZKHt1R/y2q1X0FFAl/dtWb2SKFUCqjbxhTYo9On
         CEtQ==
X-Forwarded-Encrypted: i=1; AHgh+RoUbTsIWYSGySjfDkPZYutOkJb1Bq/gpbyK12Xe6Mm1qxNpRtbV956nG0DSNRA5LyvVArADnqySSXDssSKmcipqzv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj4OVZaUhpnU8AWa51NpQwD6DV7YPBcMgqkEc7RRnFp5G2mi7q
	wGmVvV52NBry3lFkO7bcjysN8CoYKvehv3kDVeUFycRuN62suhRXKMA4DL/macQSXDgKJS7LltG
	gsF0rOZ0WjdgJ4Pkmm6guZWm+2JOb/Uymfb4OO54OOWIU89WKSw82aGfM9FZaPmiK8xs3IiSPOQ
	==
X-Gm-Gg: AfdE7clZ3YbmsY7C8ctPtgr72TNowUC+NDcrquTy7lddPVs+h4MvUMDf3y90z2+8wxZ
	mmdS201rvmfu3yfD5yO1O7FH+bD4qrQnxNIPbmMkZDorNgVtYs5F3hbHfo91ngXKb5JWzP1hWn1
	SMR4C1WlB8ynHjoC+E84EvRyVh+J8F3HUhrm0c4Ih2gxHdBTOIV58oREOK3KkCb+ChEVDOnbLuB
	lHB1Dn4Oe6OHWmXqb+UmQJEXULYf8v2zQ0kr5x5fPxk4hY1ncERtocjRBCup/WxLP5+aPc+Bq6h
	l+IkqxDyiztH1zYOuQI86VJ1dVbg5S3B0nc0HkJsInVnAoqT6pU/waLvQ1KWEFUpniBqCjVbpg4
	rj3LKj3kFgESmPNNWPDgj5WwEAAtA9D5WDj0Mv3HwhDhloNsC+kEIMS4hY9bcrCWuMciMD0eUFk
	Im+tc/
X-Received: by 2002:a5d:54c7:0:b0:470:2fb1:3db5 with SMTP id ffacd0b85a97d-47de66d30fcmr3131795f8f.30.1783409014325;
        Tue, 07 Jul 2026 00:23:34 -0700 (PDT)
X-Received: by 2002:a5d:54c7:0:b0:470:2fb1:3db5 with SMTP id ffacd0b85a97d-47de66d30fcmr3131699f8f.30.1783409013195;
        Tue, 07 Jul 2026 00:23:33 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d780csm32483402f8f.11.2026.07.07.00.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 00:23:32 -0700 (PDT)
Message-ID: <a04e3522b94e1267395a1bc5409c86a8ba49aaeb.camel@redhat.com>
Subject: Re: [PATCH v3 11/17] rv: Prevent unintentional tracepoints during
 KUnit tests
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar	
 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang	
 <wen.yang@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu	 <mhiramat@kernel.org>
Date: Tue, 07 Jul 2026 09:23:31 +0200
In-Reply-To: <878q7n2six.fsf@yellow.woof>
References: <20260625121440.116317-1-gmonaco@redhat.com>
	 <20260625121440.116317-12-gmonaco@redhat.com> <878q7n2six.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zPutC65IwFFvlYnn3Fzl52eW56y-DClg7HTxPqHt6cA_1783409014
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-07-07 at 09:00 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > Monitor initialisation also called during KUnit tests may register some
> > tracepoints, this can lead to issues since we don't expect real monitor
> > events running during KUnit tests.
> >=20
> > Prevent tracepoint registration if an RV KUnit test is running.
> >=20
> > Reviewed-by: Nam Cao <namcao@linutronix.de>
> > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
>=20
> Somehow I have no recollection of seeing this patch.

Well, I'm fairly sure you reviewed it ;)

> But since we already hold rv_interface_lock during the test, is this
> really necessary?

This is for things like ltl_monitor_init() that attaches the newtask probe.
The function is also doing a few other things we may not want to do, to be =
fair,
but calling the monitor_init() function as-is was the easiest solution I co=
uld
think of. Also ha_monitor_init() may attach a probe.

I suppose I could also do some more targeted initialisation/destruction, in=
 fact
right now, the LTL initialisation does a bunch of stuff tests don't need an=
d
doesn't do what they do need (initialise the dummy tasks, which aren't part=
 of
the task list).

I should probably rethink this a little.

Thanks,
Gabriele

