Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279882E88A6
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766271; cv=none; b=QlRW+7OgKUjMKMhKxRWxdQt7hV7OscEzz1R7xaN/CBcuV8Jrhsg//+pFON8aNZAAn5ZDtATSOC7GBuO3WFXv55lhIbgvNBiHkhjkAz3Eiv3JZpS7nQChOwh550RWcvfEcMfQ0hcyWUpJ954lp0GhVZSyMMBDdI4nXqf2YyzAM2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766271; c=relaxed/simple;
	bh=X6kIUevNVnbOU9WmlCvFJDogVu2n7XAzdX0bs9u7nAg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ogn4Dx4jy+yoPZxLmW0vF4ZlR9FwCJfkwlHSxy9dJo74+zF3MhommuWKynLIq8AKfqAvlctujwc4I7GTQQW4+KFVdvHOO7fIpX2z6pZyvWXKoHgvi5ehF0exjVhG2HL0dssfL8Rmqu/fOYdLABW14iPTHBSozALeEJKhPIEu+Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d/cFcfLI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d/cFcfLI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755766269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=X6kIUevNVnbOU9WmlCvFJDogVu2n7XAzdX0bs9u7nAg=;
	b=d/cFcfLItZd08Z95n5oG/WTrD1rZOWnks3W8F4lbWGYVM5vDDok7gFt04KJwJozWtymOCT
	OI31i3rv8+zv6Y1k+cIe44di+ulj+8r2aqV06GJwkpw9Cl4w+sQto/ycIvijO3QwqJOz4r
	5Z9JbbEyPWTM4HGmj8TgpNJ79QiOUzc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-XWGHA-hCNZqnRe09dh6Lbw-1; Thu, 21 Aug 2025 04:51:07 -0400
X-MC-Unique: XWGHA-hCNZqnRe09dh6Lbw-1
X-Mimecast-MFC-AGG-ID: XWGHA-hCNZqnRe09dh6Lbw_1755766267
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e87062832bso201881185a.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:51:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755766267; x=1756371067;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X6kIUevNVnbOU9WmlCvFJDogVu2n7XAzdX0bs9u7nAg=;
        b=UWcyLjBOHrqsZuR1IyoQq2ebH+kcWq9s+saK9cR302IG21YpDCW8DZ8T+0s3KdRKW+
         ov/WF/hdi4zPx+ZM0bxt26onqNSz+0otspUQquY8i6ihcDoF8Y0tMD8ymgFdsWL7sNik
         QeOU6Pbc1joNYUf4NsdZz0fznItNzW54vulPR4EM4Dq1F8ibL9bOHU8td5aKIm6Tj4Wn
         J2dsw2WwzSdqXhSDqAN21YkCx8sIpS1D7yPMf2u9N6UvHIaTBvi31WJ0j+/goa78RNBy
         f3MTm0Ctd73B7pgjl+tOuI7GE5s/twf5JzA/i6xBFxvkg5cBnooZT7pl96hM0RvLP7em
         uFIA==
X-Forwarded-Encrypted: i=1; AJvYcCWr+mB+QII/7JtzWBflY2kSX/bYQw4NONZdG2N5ndl82VxbdUnA4X5cSxcVIsFgerMpzsLlIBk7JkwcVQ4PgOio0Yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXwLBluX9g4Oqsazzl2TA4Z+PODU8Ca+Y29ZjywjIdfGDySfw2
	br+s2VADjUyWiafnIgyCs6umAUCFH2v0Jv5kC8SQUNB1T2XaL+j+NmWxpOeOVSZ8JITJ9mJhIrJ
	viCGhOGpc1q6S+Oax9TjeY0dFcdFT4MCeEquMelIBGy5VFF0Y4BLgYmlywsq7uRAfTdX+oY3aUg
	==
X-Gm-Gg: ASbGncu9dYGh9gstX5Eljp1HEpLpi9NpNm2c6MNIUjXua+nVIPr/rt4BDeDWtMjryaa
	VqTgO4wYNTLUQSnjBnAcJqIQEDDqCC83sCYm83DMuDlKB9Df06j5Q+ycfmYvPSbm2pByH//onEL
	MVPv411JYgQ5eibrsyC/J3qp9Pz3UL8e8//oU1tjkl03z9Q39XwV/pc4an92Thn/pBaCOVwxfKp
	z4Z3MSF3ObJ9sW8Zn43/58akKLIi5hkC9SamGdB5IV0YhfLvf73OxMVeUiOI/om+lspuy9Ewdzm
	TdCwE56iyL3aNEA6O7Ci8JxjsXIurAXEIU0BEsRvxd3xpXglJExuG9GimgVClkAJlw==
X-Received: by 2002:a05:620a:4042:b0:7e9:f820:2b92 with SMTP id af79cd13be357-7ea08ed4d75mr139021085a.83.1755766266847;
        Thu, 21 Aug 2025 01:51:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEK/XLaMLV8iagxPgHwEg6DkFLLoNJvZLFK83g7DciD1/OyAVesIqZuoqMHrVAM/eDT5oQ0aQ==
X-Received: by 2002:a05:620a:4042:b0:7e9:f820:2b92 with SMTP id af79cd13be357-7ea08ed4d75mr139019285a.83.1755766266431;
        Thu, 21 Aug 2025 01:51:06 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11ddd693asm96733851cf.37.2025.08.21.01.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 01:51:06 -0700 (PDT)
Message-ID: <aac621d698dbb38458a1e701f0d177c6110f5447.camel@redhat.com>
Subject: Re: [RFC PATCH 05/17] verification/rvgen: Annotate DA functions
 with types
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, Tomas Glozar <tglozar@redhat.com>, Juri
 Lelli <jlelli@redhat.com>, Clark Williams <williams@redhat.com>, John Kacur
 <jkacur@redhat.com>
Date: Thu, 21 Aug 2025 10:51:02 +0200
In-Reply-To: <20250821082934.trGZCw9D@linutronix.de>
References: <20250814150809.140739-1-gmonaco@redhat.com>
	 <20250814150809.140739-6-gmonaco@redhat.com>
	 <20250821082934.trGZCw9D@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: 4d4tPhZZG8__Cw6-zRp0utZZ62fr_HM839JpOb9VsOE_1755766267
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-08-21 at 10:29 +0200, Nam Cao wrote:
> On Thu, Aug 14, 2025 at 05:07:57PM +0200, Gabriele Monaco wrote:
> > Functions in automata.py, dot2c.py and dot2k.py don't have type
> > annotations and it can get complicated to remember how to use them.
> >=20
> > Add minimal type annotations.
>=20
> Nice, Python is sometimes hard to read because the type is not clear.
>=20
> > -=C2=A0=C2=A0=C2=A0 def __get_event_variables(self):
> > +=C2=A0=C2=A0=C2=A0 def __get_event_variables(self) -> tuple[list[str],
> > list[str]]:
>=20
> This annotation is wrong. It becomes correct only after your later
> patch
> (verification/rvgen: Add support for Hybrid Automata)

Mmh, good point, that happened after I moved all cleanup patches before
the main changes (this was done after). I'm going to fix that.

Thanks,
Gabriele

