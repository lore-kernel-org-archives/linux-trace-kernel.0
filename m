Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D6146AEFC
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Sep 2026 07:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788248256; cv=none; b=TyxcV2N6Xpqz9mvPVEbKqG1IoJEsmcW+QNq3YD8Igz2a1gr4EyJq0Wi7T4Mw+Fuy8x5pfdtPAxfQUi5+/DgTKs4GEEevAhjHPh5iX5ihudY6Vxfup+oqT1F6E+8U1//gTxaHp7bqhmH9/0CB+4qevefJFHdPEnE2EQT2kd4nK9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788248256; c=relaxed/simple;
	bh=K4whIrp1pNPEOzUr6rWkDT7pTMOtTqyyOI4wtAV+6Fg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V2iT+aK1a6F9U/9MvBEVDWVXr0jvoZTefJc784hhePFyDBG5fMUmZK1NGUPSr2MRjWpqCsJxJwKYGIE7hSX2MdsPqRfR+sU3hT1Jbl1hHBdFDvB8bZf1en0UONHhJECM7ei7F0tpjRrBfWIq19KHJr3S5i9UbR4DdawvF5F09fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hLEdJ3Wh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLEdJ3Wh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788248253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wjsUtVP0vVMcIYKMR24Ou/avzPDLmevZdJbSMcHJbPE=;
	b=hLEdJ3Wh5JejpwRJx0T88GtHjGrSVJjq/dEOGSnDLNZgX8iIs/AkfafGv2v1K3CHyH3f+h
	sV96BWPmLwXx+0LtjK6+aHJqOZo/LND0eAGlXjZov4Fv+OGteC3WZXmYz4iYd+VTjC2ptx
	jsboztnCKwDYYAq+krrgw7vEJ9mw5nk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-R33akhyMM4OpbfIT_LXo6A-1; Tue, 01 Sept 2026 03:37:32 -0400
X-MC-Unique: R33akhyMM4OpbfIT_LXo6A-1
X-Mimecast-MFC-AGG-ID: R33akhyMM4OpbfIT_LXo6A_1788248251
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49a1b4ea633so40251035e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 01 Sep 2026 00:37:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788248251; x=1788853051;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Rk6MoM1HIB054uV59BcMTgA//1R4qE5kuR4lQOsz+qc=;
        b=F7j56GvXEkAX3EAe7hb7+EKBgSPFyow8HKp1mJ8dEBKnXrUmkgBo2OF+SVKEe6XKF7
         mHric/1OHHE+2P7zJhDAWJxpfbl8QmORmXLX7V5lEQoO1iFzFq6jmjnUBhH14MhgHFW1
         aNfOfnYmwfN98f+qK+V7+oOXu0o70wWd0MD+WNXl50bLws5956K5OOkbHTbpFQYHg1zb
         HyRH0HUu0NIFi5dqsLitG0+VHQx8+8DwXguAwBon6AEvFlc3Xc/Z6A2E4ygy510udAKE
         Vkpho9vUjyvnbTo1TuELzgBC5pLEPmol2NxTwN7zP9hQgPcyPXf2mawtYjQJT8VhJQN5
         hNTw==
X-Forwarded-Encrypted: i=1; AHgh+RoOf8bwKiZhmU66ut6Od1B++mR18CXK7VSPEgiTv+pc4skujKUUjVBorYd34eDWqyot97mcLnX7ezwOhOZwyI43iWM=@vger.kernel.org
X-Gm-Message-State: AFuF++kMSsEpQ6R0IQOkgq1hZUX8fsbRtmjTMMjM+1K/RRLRE3Qt+WyU
	b7ERFuAPWHN9zCl/BXmJGT1lEBfLpa6pG/25/wqqeR5y2P8e4HeuNC2CwODRaA+u6gbf8kLpcHk
	0PuKcbkgDJ1hP4iL8HMOP4ZbUlFFs7jRhihUgt2iVHql9UJA+A8QJksra4LZmKPcz6vploy3N1R
	1c4c3kZ46u
X-Gm-Gg: AR+sD12S4/zBSu+wqJndGVtG2IOZu1r4HAlUhjT7pIv41ELr106UxnuTkP0TSZ2mwJx
	F1zkpVLw+P7HBhN2TDcuZW5Yt8dhEzyEDzry/tAWDSg+xAlFL3pZp84uSBcYebaNpku4GauSYUu
	8vEF2WMhkb5LLEQm5bgile471sOYlVeGGj6TMzSqnSiDjtQxqw1wXw6QR59TZExyv8dBNZn/om5
	HWvd1xGysX+ZwRvW+TF0nWeEXOUQN/B5HThauyJl25KnjPd2XhPr1j6ogxJVkmz0Hj33+cnD0ci
	C76wKCbOUkqfCaJw7/g2rIN29MlF0RLa1Ly/E4p069xnjBnprO4SW5JmVSHIbaEVnoFMbIv73YC
	Vqh3J6Z+zMq/ZvxkNlh4EkJn30sdv7g==
X-Received: by 2002:a05:600c:a418:b0:499:b65e:49c9 with SMTP id 5b1f17b1804b1-49cdc558513mr101959705e9.10.1788248251554;
        Tue, 01 Sep 2026 00:37:31 -0700 (PDT)
X-Received: by 2002:a05:600c:a418:b0:499:b65e:49c9 with SMTP id 5b1f17b1804b1-49cdc558513mr101958885e9.10.1788248251168;
        Tue, 01 Sep 2026 00:37:31 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.135.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b91c5790csm286144315e9.0.2026.09.01.00.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 00:37:30 -0700 (PDT)
Message-ID: <0b0b115713a6d5a10d719085284dc7cef21ed892.camel@redhat.com>
Subject: Re: [RFC 1/3] rv: add per-edge dwell-time statistics primitive
From: Gabriele Monaco <gmonaco@redhat.com>
To: Tobias Schaffner <tobias.schaffner@siemens.com>, Steven Rostedt
	 <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>,  Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jan Kiszka	
 <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 01 Sep 2026 09:37:28 +0200
In-Reply-To: <20260827072400.45734-2-tobias.schaffner@siemens.com>
References: <20260827072400.45734-1-tobias.schaffner@siemens.com>
	 <20260827072400.45734-2-tobias.schaffner@siemens.com>
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
X-Mimecast-MFC-PROC-ID: FIk0hTJI25p0OLYBz4HpqEZKygt4xxnXYEBOjDasJXs_1788248251
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-08-27 at 09:23 +0200, Tobias Schaffner wrote:
> +=09while (dwell_ns > (u64)max) {
> +=09=09s64 prev =3D local64_cmpxchg(&s->max_ns, max, dwell_ns);
> +
> +=09=09if (prev =3D=3D max)
> +=09=09=09break;
> +=09=09max =3D prev;
> +=09}

try_cmpxchg() functions produce arguably cleaner code, would you mind doing=
:

  while (dwell_ns > (u64)max) {
      if (local64_try_cmpxchg(&s->max_ns, &max, dwell_ns))
          break;
  }

Also, although issues are practically impossible, I'd avoid an unbound loop=
 in
hot paths, you could go up to MAX_DA_RETRY_RACING_EVENTS (already existing =
in
da_monitor) and put some warning in case you reach the maximum amount of
retries.

Thanks,
Gabriele

