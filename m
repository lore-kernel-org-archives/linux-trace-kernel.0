Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A88238C0E
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Apr 2025 10:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744367876; cv=none; b=Ei+A3ndKLE24S6mbmKw4Lpg6r/ZloPYv2lHklodH7GRQVPlXc/GZb9xhGS2YxXn1kSKxv/SGWEc3LD3oYJ3K/WRV1Yt8HnFwpIXH1a9nNLxUiTyDyf6fuUdAeuFWKyWbBO6RISkS9YGlCYvqlqsNdqQ8s/3lzDujqGdiSpCoOLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744367876; c=relaxed/simple;
	bh=OlLhVTTqWwTBNjngeM/UqJrVFZsmAFzsC5kCdagQ6p0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=phMLQryobHAheGWL334M+uvZJiRFKNwAqTtJ2s/APEBnYj/88XhR8doSGecWe+mHK4dHoBSrf+/B3m7quaCU+MKZFbnWJxxyIkF8iBOt2mF6hYBP8BCRI6JwhHa5zMqYmYTxOnpURO2d2ey0LtPD011+M1jCu/O3K2PsEV1szvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JM3sOmqi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JM3sOmqi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744367871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OlLhVTTqWwTBNjngeM/UqJrVFZsmAFzsC5kCdagQ6p0=;
	b=JM3sOmqiG6PgpJblHzyCRKWEOhwNycpjsXLpCI94pZMa+XanZzrFnyVt7fIeCzhmlYkhJa
	tA4qVsUBINx0zzRiBVy0d6UlBIjsApr31a5Nj+O/lYwcbGjXpGuu9fh8BsEU4UzaTmbiJm
	uHJoXGhkEvn/uVeg80wjSebXU4qvUB0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-b8NMO5DHNUGplgDXoHgPVg-1; Fri, 11 Apr 2025 06:37:50 -0400
X-MC-Unique: b8NMO5DHNUGplgDXoHgPVg-1
X-Mimecast-MFC-AGG-ID: b8NMO5DHNUGplgDXoHgPVg_1744367869
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39135d31ca4so1066292f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Apr 2025 03:37:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744367869; x=1744972669;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OlLhVTTqWwTBNjngeM/UqJrVFZsmAFzsC5kCdagQ6p0=;
        b=HDub9ELfHKqz21byfEW8NSSxh2jRtX9PUi1dOq7ATj3TFibWUFnpPHG618w7aDUvGP
         0+IokIn/qy/xIvsxIkKKzo7wrfhGb8v+/araLDEhXmCpBegNUsj8iwI66doouix8HfXB
         wjZ10sJ6PvRVx3YAFPWgXYsE8ToiF1OJVsxqrEPNmtlGQSbEp32hH8EcrHeUQav//MLx
         mHBTR76jdg+2HbwSRtjLuqQGyzG+68598Was5yh6z/viQr146kCTlC//zbE9aDGEeP7/
         WgJgf8yuj4ogDyj3N1QopVNLaJvf1cqzaJjQXga4ILhRT9U/PvQqNmpc0D4ckE0ItEuS
         jEKw==
X-Forwarded-Encrypted: i=1; AJvYcCWLEmbDWu4eOcwmXoGYP9fYU/7NeWM4Pm3CnwObaOWzsqfsBKMNdJ9N059a0bnwynmhAfuVXgIfPdfbwbu8zyRaYfs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk2N44gXS3Z7UT0As+jbTzhPkNWCkQucxpr4zfIxloNKKPgc5F
	H6Ku+yHNXXXSQ4a8Q8xVRpF/mPIms7Gn2BIKAsh0S5t5usH010Rxc8uncWnmO2LvQYfKvJbuJ1p
	CbGrMiqrIAYOj4rWecQUycEtPNxnElOwBrdaxk+wIZINpuzuf67AcrmXmBxf0Hq0nHTOpdZ5msE
	O2ay7z
X-Gm-Gg: ASbGnctf9cs+rUBbiFW/E/UL4Z1QW+XyjGx7w8QlAiraAOMAgkaz+5e61E791aXz7oO
	wY9cp3l47zRMLk46Nl2jsBqDpl8XKblhLMjem5wOO72cYewlaI9A4FX5VXlCttRL9tZ9BdKI+qQ
	FGkEwK2HT7Rd70K+rwjTuNLrAOnQ7Wv1EWxirFxKc3Eif32ekbDscTDZeLosXm+iOxgx674x9t+
	bDJwvSMxb6p8lAPHXZTOjpDTp5VNaP6pOuLUx8YDtuAvlaOb9/8f5M3FCoM3T7TB1yq1mmSLN7A
	HkLa9zO7wOdO2j6chSSYXNyL0/lUugl8uTN7Lg==
X-Received: by 2002:a05:6000:2508:b0:39c:1efb:f7c4 with SMTP id ffacd0b85a97d-39d8f4dcd59mr5693421f8f.25.1744367869195;
        Fri, 11 Apr 2025 03:37:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1SqxGkQrmtZzx93bTad8QenbXEjXeF6uEDWDfABdDgNVt3W6DDjxqe9tezOB13nGD8+rzxA==
X-Received: by 2002:a05:6000:2508:b0:39c:1efb:f7c4 with SMTP id ffacd0b85a97d-39d8f4dcd59mr5693399f8f.25.1744367868846;
        Fri, 11 Apr 2025 03:37:48 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f23572cf0sm82101865e9.27.2025.04.11.03.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 03:37:48 -0700 (PDT)
Message-ID: <46bd23c323846b1bec2400df2e87ab98abd0f6ab.camel@redhat.com>
Subject: Re: [PATCH v2 08/22] rv: rename CONFIG_DA_MON_EVENTS to
 CONFIG_RV_MON_EVENTS
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de
Date: Fri, 11 Apr 2025 12:37:46 +0200
In-Reply-To: <ecc2c812b595926f940ee93e2e34c4451544e10c.1744355018.git.namcao@linutronix.de>
References: <cover.1744355018.git.namcao@linutronix.de>
	 <ecc2c812b595926f940ee93e2e34c4451544e10c.1744355018.git.namcao@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: 33ROxuzD4N-oqoLnadNPStqCn0oup4eCsAqtTWVw--E_1744367869
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Fri, 2025-04-11 at 09:37 +0200, Nam Cao wrote:
> CONFIG_DA_MON_EVENTS is not specific to deterministic automaton. It
> could
> be used for other monitor types. Therefore rename it to
> CONFIG_RV_MON_EVENTS.
>=20
> This prepares for the introduction of linear temporal logic monitor.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

