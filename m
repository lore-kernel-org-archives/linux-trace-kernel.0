Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF8F243369
	for <linux-trace-kernel@vger.kernel.org>; Wed,  5 Mar 2025 12:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741178092; cv=none; b=IeXGRnGIt785ULzbKwBLp+FI9d0m8PSoTvCyh12q1v9vCnCfBGRvCC2QyGlf+dRtxCPksc2dVdvcVo8vSrDUmjMIG5yoswhe5nbiYARqThwfAKd3IGdDvPj0xRopsdiFdgSOGnyRMxeeFqClKC1XPeJOxueLKJvzTFUHAqYhOQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741178092; c=relaxed/simple;
	bh=MzbvmMQv5RSDzTCeWNjXU61fajli7jqj0GtNNyX9JU4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RyYKfXoMp4i5jdiH5AbakW78TGc3W349hwXT3DKmbaPEwlHUBnr0acKm5r+dMkGKd/2pfGZPONU+x1U0Ket64jqUpwzMgz6nDuywfesAxesPhI9d6x84dr4M5S5/ia3hGmbnCUSVwNdSeKn0IPA9lv4wEUWTP23sqaPEH4DCTqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qe+nACkk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qe+nACkk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741178089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MzbvmMQv5RSDzTCeWNjXU61fajli7jqj0GtNNyX9JU4=;
	b=Qe+nACkkk6HZ25KC1VUKtjEHZKXrCwn4R35PRyh7uzPKtSS2xv477mHlDNdwYnesIWyAMW
	YBtVq5geyLqgmnTgpAWz040O16hwovMjsnzvA7vOtP+Ajpo83TffAkWI6k3bIXhK6emGXH
	Q7PRGotOK1RaTJR3iYTswjMytLEZzMc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-V6zZ5euhOuawpnB1rnI_PA-1; Wed, 05 Mar 2025 07:34:48 -0500
X-MC-Unique: V6zZ5euhOuawpnB1rnI_PA-1
X-Mimecast-MFC-AGG-ID: V6zZ5euhOuawpnB1rnI_PA_1741178088
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-390f729efacso1868622f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 05 Mar 2025 04:34:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741178087; x=1741782887;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MzbvmMQv5RSDzTCeWNjXU61fajli7jqj0GtNNyX9JU4=;
        b=siwxPStvFRqSlqs1a+p44u594qjeavmIOXeUtyFQCBpG8ia5J4EeQiIE1bLXE9oRDg
         iuxrSLcpd/rBYmIc9AWnT/Q+6yoc3fSci0sCwbdcFvUvqSyOyFbfm0ycFQNfrVQn0Jv9
         Y6jB0O1RKNCjJhzOvq9Op69L6gnUTWD6Vk3H0oRpTJYE97aitVac39+EaU1QWXecrdCz
         uy8OmQ/EqaIaCn6w8JrlUqRu8hnYMNoSO+D2VHloOjFAocmw6dPdUC95jggaAAR8RW/3
         m/cAHFN04gTWo5vHaek1EX9YcAJS2OqTHva6kN5C1OPbtAbrnrBiUJUB1p0j4FgKOXb0
         1NLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/JWuVG8NJkLvGYRNI5+ESb7CVK8stpfDGHtWYa5SHDoSXuA/hWGKF9XhQk8XsViHKGeR/MVha9hjz18bK5v+LbWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Rmb6fvrcKkFxg2GdZjN8ZoJorYGxtAzfjm+I+nblfKja7KB7
	piRGlB3STYFwWNnjBuVgamc1CaCo39Gbn7U0KNpnprNcQrVt/UjxQVFtSk+9QtbLcu5kvd91li7
	u3NuqD46pOyWZNcQdp+v6S6qmajB5IRvpdRf6+tU/RZtiT+YKUFCCxnIaOAKRY9TLbGVt2A==
X-Gm-Gg: ASbGncsFhrDT5q74nUbCYMsmRx1ncdEn6MIE0S8x0GFbQEh4HsTHR9huJ5lBH58sdYz
	rufUQ63AO1GmpnCBu3PK8M17yF9DF+nBSsgmKgSLNP34Dw/E6gg55HJwhw9VgiHgoZ9m4PizqZ+
	T8WRRcMAnpxjdixkM0Q6UJ2C9MvfK/RuAzcguLMYW4mv/mRST3Z4DGQ/vUhUKZqwAA+Gdk83Jp0
	i8a6I+UIqKe78A9K7JgC+NHAhDLQerdfxELVO/v9gfC5tbdOXnGBu0DbAb0mQTyDiscO3wf1CUh
	U5BMI4rk+UspQbmAsA7MZfaJY47PDC9L+e/7gx25CQ==
X-Received: by 2002:a5d:47c4:0:b0:391:ffc:2413 with SMTP id ffacd0b85a97d-3911f7c3b07mr2400867f8f.40.1741178087569;
        Wed, 05 Mar 2025 04:34:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqQWQA/n57DVltTxNtmrZ/6HkQkivRxHCLahBCPf9F/HOe2cN3ukO92Xnzt4J+DpQyRuP7Yg==
X-Received: by 2002:a5d:47c4:0:b0:391:ffc:2413 with SMTP id ffacd0b85a97d-3911f7c3b07mr2400844f8f.40.1741178087199;
        Wed, 05 Mar 2025 04:34:47 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485e61csm21201667f8f.98.2025.03.05.04.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 04:34:46 -0800 (PST)
Message-ID: <1115798d35feb54f0cc714dec3bd7fc5a671adc8.camel@redhat.com>
Subject: Re: [PATCH v4 02/11] rv: Add license identifiers to monitor files
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>
Date: Wed, 05 Mar 2025 13:34:44 +0100
In-Reply-To: <20250304121828.34006e00@gandalf.local.home>
References: <20250218123121.253551-1-gmonaco@redhat.com>
		<20250218123121.253551-3-gmonaco@redhat.com>
	 <20250304121828.34006e00@gandalf.local.home>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: u-7R1j8otzydp2pEjaqMjHSTWJOzd0EsCKIPuyHc_mc_1741178088
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-03-04 at 12:18 -0500, Steven Rostedt wrote:
> On Tue, 18 Feb 2025 13:31:07 +0100
> Gabriele Monaco <gmonaco@redhat.com> wrote:
>=20
> > Some monitor files like the main header and the Kconfig are missing
> > the
> > license identifier.
> >=20
> > Add it to those and make sure the automatic generation script
> > includes
> > the line in newly created monitors.
> >=20
> > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> > ---
> > =C2=A0kernel/trace/rv/monitors/wip/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 ++
> > =C2=A0kernel/trace/rv/monitors/wip/wip.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
> > =C2=A0kernel/trace/rv/monitors/wwnr/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 ++
> > =C2=A0kernel/trace/rv/monitors/wwnr/wwnr.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
> > =C2=A0tools/verification/dot2/dot2k.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
> > =C2=A0tools/verification/dot2/dot2k_templates/Kconfig | 2 ++
> > =C2=A06 files changed, 9 insertions(+)
>=20
> While I'm waiting for Peter's answer on the scheduler tracepoints,
> I'll
> take these first two patches now, as they are agnostic to the rest of
> the
> changes.
>=20
> -- Steve
>=20

Great, thank you!

I just found a problem in 3/11: current_restore_rtlock_saved_state
doesn't pass the correct state to the new tracepoint.
I'm going to send a V5 and will leave the first 2 patches out.

Gabriele

