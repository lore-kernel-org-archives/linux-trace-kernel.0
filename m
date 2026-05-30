Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFAE296BD3
	for <linux-trace-kernel@vger.kernel.org>; Sat, 30 May 2026 01:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780104743; cv=none; b=YFLO9oT4fFeLMtnAG8JNYqAUzxcP9tZp3oD5NSQbtdc6AEyqeV+hA3xB5VOGvFWjcczV01mdtpPEl2SQe6WZrZQ6lwp8IaNlSPqv2vpD/auM6SJmaW8Itsz098DpHoiyitAU8U4bZPlhfYTu5DqlJXq9Sy+lusnoa4XzB62mvoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780104743; c=relaxed/simple;
	bh=QEguEi2FzuiX85NhXKp7GXSkha3tfMQkSFRwAjHqX08=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NHJsZZXETGc72Y0/YMoMSWThXIjctSPYMlur0eWouA77bVTPFpmB+sr/1ohfxMRgex7ILJQmE/uuE0iZDA4+RHpoTv0q9PQ1iGDechsGwiCsYPRzCgsQKu18f6fbGXg0TfnSkmcPCcXJ7+KHmaOKPZxPmnPPsZmnjRrr4pgJIdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=giAQgTjB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="giAQgTjB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780104742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QEguEi2FzuiX85NhXKp7GXSkha3tfMQkSFRwAjHqX08=;
	b=giAQgTjBemUuJ/NXKysmI9JZsWOhjIch9lBPzlOQKwcDpy7OUrzhG5rW95R9aB2AuzASA+
	KhQiyb9/Sk8VICgocqxUrIYuy2a69DaXMMmVhMqH0+EJEk+xEvgHLtsy1hy7hDgDbG6IIc
	H3NEfJb1GJRneo89nQmRgkAyttgJ3tQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-GuhpDdHdNGW5l_PmeD1bCQ-1; Fri, 29 May 2026 21:32:20 -0400
X-MC-Unique: GuhpDdHdNGW5l_PmeD1bCQ-1
X-Mimecast-MFC-AGG-ID: GuhpDdHdNGW5l_PmeD1bCQ_1780104740
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8cce4f4634fso37493146d6.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 29 May 2026 18:32:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780104740; x=1780709540;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QEguEi2FzuiX85NhXKp7GXSkha3tfMQkSFRwAjHqX08=;
        b=RQWHmQ8LZc3nHQsV7Be3HeB2qu2ZMT9oSZXdNa6tpmLCMxqD5C3fo/8TOaQPe0TqZR
         xGksCRGVIfHJYmJ6/TQm/rSZgOu69MRvEZOEWKTqejES+ewcnJsCcnLB07BKon4LWj9K
         Ubo2/xvWFoaHMZ3fSOlFnN2z54ISsqhHrdFGx42MtjlusX/gBdADf9BfoMQ/Xb3cGEoi
         UHzPxKSHA4xVjtMduomhTyRnUQ2Qw0iZLZUUgYsuOaTBl6K15X21A2xs7WXU7fretCPu
         2TM4fG95dOgVJiXB4Enwb4vylBrRUNWFqm1ExGH0u6DfpmsJmFxIToBRqjkDiDtp7ScF
         uyrw==
X-Forwarded-Encrypted: i=1; AFNElJ/gKhQibinXCSFhIFaTz8n0nF7yM0G2UvyVyKAI2KqybOXaBj3qBpe0yp/XBTqnZyP0T0Z+jfqfgqJT8Yg+VzNupnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYN8u/sOPeVBkpzS5AH4j1Bj4npHcEv/HfAH/3AoK9eCVwU1D3
	FxMP41C2I1fis2IVovRrIPNa+RZCBDvFeuQ5JV023JIA5Aak0vjPERAc3b1nqBtaP3Q5hyEPWdc
	sxc1LfGXe7Vk2X/qlEo+IDrIGlYsmTMMfQZoPMcXSw0X0bHT+GRUfFPdf20qOOBi070NlvGK/Bg
	==
X-Gm-Gg: Acq92OGbgAj7g/IhzOhuz6OLKIKx5+7PpL4hkOFW9BwvIScgBbh2cT3hps5srATF0pK
	zsuP2kLsq9fYXVtmRlA6b5tOgq9p28vDN2RA8XKXWXGi1E3GYDeepXDxIlTIZCvwKomFJVSNZMW
	zw1yvYOxHF/TjANoGzkZEtqIJm/l/12pbicjXUwIsBZcY1jgWD/s8eD3gvowXZeptp5YazvEl/A
	PAEXGDp9vSP49t944+XFXO1bxtnyj9WnCqrsgBpOCqu4bY0JCrns4FGEzIKfT3OcXb3AszeqtbJ
	38M+50afnzqW6ZsQNJCIjEHCRAJpv7KEzChiqwLJV4xdzlWPl841SAkIk582aqL5l9uJAHpXtLN
	Q3XMFfdSPbttjsEttGwC4jMwfpZc60F3simpNEyM0yucj2ATzzHs8G588freaHByO
X-Received: by 2002:a0c:f10c:0:b0:8cc:f074:95e with SMTP id 6a1803df08f44-8ccf0740afbmr29390346d6.30.1780104739836;
        Fri, 29 May 2026 18:32:19 -0700 (PDT)
X-Received: by 2002:a0c:f10c:0:b0:8cc:f074:95e with SMTP id 6a1803df08f44-8ccf0740afbmr29390086d6.30.1780104739357;
        Fri, 29 May 2026 18:32:19 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:cc81:56d0:ab94:b2cb:29a6:7ac0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea272fdfsm32310386d6.49.2026.05.29.18.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 18:32:19 -0700 (PDT)
Message-ID: <3acfb688a2ace152067fdc2a3a07264071223266.camel@redhat.com>
Subject: Re: [GIT PULL] RTLA changes for 7.2
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>
Cc: Costa Shulyupin <costa.shul@redhat.com>, LKML
 <linux-kernel@vger.kernel.org>,  linux-trace-kernel
 <linux-trace-kernel@vger.kernel.org>
Date: Fri, 29 May 2026 20:32:18 -0500
In-Reply-To: <20260529200229.2c63539a@fedora>
References: <20260529130643.3080315-1-tglozar@redhat.com>
		<20260529095646.73c95f60@fedora>
		<CAP4=nvSi2q=h308Osmrph4YgOkMJE_QmsfSAQcyvi8sxKY2kug@mail.gmail.com>
	 <20260529200229.2c63539a@fedora>
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9k-uwV-Hiwshe2WaM5t1F2EA9D3SqMASW-h6NhhaiRk_1780104740
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-05-29 at 20:02 -0400, Steven Rostedt wrote:
> On Fri, 29 May 2026 22:50:31 +0200
> Tomas Glozar <tglozar@redhat.com> wrote:
> >=20
> > The only build where it does not work would be in the middle of the
> > pull request, with the --dump-tasks fix but without the libsubcmd
> > migration patchset.
>=20
> Great, then we don't need to worry about it.

...until someone ends up depending on a script that uses some random
prefix that becomes ambiguous in a future update :-P

-Crystal

