Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D643233140
	for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Apr 2025 08:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744793792; cv=none; b=PbFyKGXdvIggGftYdCb7l1WaT1Pphr2wdqD6TdvXqBgxYFivd1UbGIWu0bN9V3ENtfrZHKM+1wgPBBeAfYd92Izl6W01D4y5wOZplSpIFJS8sfZ0w8PS6Zn9T6zSG+r6+I1TIiTwBytCd0teduUDJsDaGQpzuu/b2Q7h8MIst3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744793792; c=relaxed/simple;
	bh=q+FWIo5cQ2XMQv5SOsjmuvZf1xhMIdGuo1Ssz/xAWXw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=twkHEyEY2iPeLbxRhuMjixzdaFpCUp8AjrZe4Q+vlRCN8KL8AuRBpNlOeMHvecdlVGXARzVJyDkMAjsqn6yh2CAWg09KMz6YTa3q4oslgZNl2k0ipuzkNxOpM3O52OJwSVCFy7G5lf5SDksJtGnZ8KCyaPHz7x5lexeodBxYYuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RW1QKeXf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RW1QKeXf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744793789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=q+FWIo5cQ2XMQv5SOsjmuvZf1xhMIdGuo1Ssz/xAWXw=;
	b=RW1QKeXfy+Df2hugtBiYzYOr9mVyGggnWHlMiF7t1rWn2RbjsebqCCgPxlV4LlpZo4wGEd
	4Cpl6zHx0FajhdAgivPbPlonuPPXZBIp77fhjFzRoqUSs/M66ynSuNhxRBNJvoTgb+t0fZ
	sEIr0PGzH7BU5WXOI/qs5URfGm2WnwY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-6mUMAboSMDySxjKibXAqjQ-1; Wed, 16 Apr 2025 04:56:25 -0400
X-MC-Unique: 6mUMAboSMDySxjKibXAqjQ-1
X-Mimecast-MFC-AGG-ID: 6mUMAboSMDySxjKibXAqjQ_1744793784
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3912a0439afso2693175f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Apr 2025 01:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744793784; x=1745398584;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q+FWIo5cQ2XMQv5SOsjmuvZf1xhMIdGuo1Ssz/xAWXw=;
        b=ZYLo9+aMdUdH1FRBWvpVxkHcSskUv9iJkn2UghyXd1/89uTh10NkTpRpwDStG7SZKN
         smvXPbQDqiDHb9OqKzpG7hqSWZ3YC2PiQT66enBUE75QSY6bWV2c2j52RGk0DkO6rd7v
         MSeG0tZ/8Tuvb+H3V2o2Lyyv+pEqFi/PqtjRC+6IvKv82QNAUitRW0pqd7Lt7JDe78tR
         DwJ47Syw/xVKXaFk9PEwZwHpYDmm/VG0g+McnxAU0BSf6Z2BRArvYWZWiGJ9P+k7x8Da
         nByE9VFFsMabx76j089x/wALLY0zRkt327GiHbCu3iLmkTYclRPiY6ZgqHlkcR6hNeAi
         2YPA==
X-Forwarded-Encrypted: i=1; AJvYcCWJUMUREYAMdpK+TKzFVU8cp20PGPdRC/Og7gU4G83BcMEo7sjU12L+OkFv0CwKvtwkzQu5oRrGD9MrAjrNoDf/CKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZXRrsKprk5y39N0YQFUmegeuPxWwkoHbLjV6NJJAAP1sIbIpT
	u7CwtRFxr7QhqtRPN6kvChEn3cjq0RVIpziyvJSUqz1GuN6kuyTvA8MuffFjD0CBuCkAqvh7Jyn
	YIZ7zpnW+7CXEW2Ya8rR5E7oIIZ+m5NSjgxBxXQ7lA5sCFO6mBWiSZArYEqURPNbAFSSELaOnh8
	Xzuh98
X-Gm-Gg: ASbGncuNoXAplrNlxMTZK2+QkPP27NEYpmyoPlDj2sJAXGRFFjNgxjszTOyosGUwvkb
	WPsTD8LlCnEqWkthI1ZJMXjmWLO+2llE49dwutJubewVwwZxOQqq53AHdpAQJgLjLzB8/VFKJjf
	d88YLkvc4gFlGRQAOjayypEVBelk+UvZ2CXvaYeSeSXdwWnHNw8bbGEVnPEcMCA3NUCtNlyoaDK
	f1V+plFHRDSfFZ+18piAocEIDkv7jq0bwZDar9Vf5fttg9ydqp1dzXNnv0YSZwKCegRQ8/CD9R4
	xd3HNB5iYYVN4i/B92oh9x0+ZWK/7N7j3qNGbQ8=
X-Received: by 2002:a5d:5f82:0:b0:39c:1f02:449f with SMTP id ffacd0b85a97d-39ee5b11211mr1082766f8f.2.1744793783865;
        Wed, 16 Apr 2025 01:56:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEL1qnnZyEc17y5GlPdSxW/6hCGr29jeLtRFM8D1Bd0LeBYgj2P+87yDlHJjQ0t2h0EmudnQw==
X-Received: by 2002:a5d:5f82:0:b0:39c:1f02:449f with SMTP id ffacd0b85a97d-39ee5b11211mr1082742f8f.2.1744793783543;
        Wed, 16 Apr 2025 01:56:23 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.134.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b590255sm14607635e9.28.2025.04.16.01.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 01:56:23 -0700 (PDT)
Message-ID: <db410a0036a7603262217a2e60a2fa14b1f1dcf4.camel@redhat.com>
Subject: Re: [PATCH v3 21/22] rv: Add documentation for rtapp monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de
Date: Wed, 16 Apr 2025 10:56:21 +0200
In-Reply-To: <5236862a1dc65592caf0529922aa33c42b8aa3e8.1744785335.git.namcao@linutronix.de>
References: <cover.1744785335.git.namcao@linutronix.de>
	 <5236862a1dc65592caf0529922aa33c42b8aa3e8.1744785335.git.namcao@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: pDIt3v8DoHcubjmq8qcaN4vAlX51ikUYFQyT4PuErlU_1744793784
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-04-16 at 08:51 +0200, Nam Cao wrote:
> Add documentation describing the rtapp monitor.
>=20
> Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> =C2=A0Documentation/trace/rv/monitor_rtapp.rst | 107
> +++++++++++++++++++++++
> =C2=A01 file changed, 107 insertions(+)
> =C2=A0create mode 100644 Documentation/trace/rv/monitor_rtapp.rst
>=20

Documentation/trace/rv/monitor_rtapp.rst: WARNING: document isn't
included in any toctree

You forgot adding this document to the index (and I forgot while
reviewing ;) )

Thanks,
Gabriele

