Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949B62AD3E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753269510; cv=none; b=H/hvgV4newG9N/zMf1CUebs9cWIByyVHYPD2O9nfLbtcjJbwCX/a6Xf3WEM/JK3KEKP9IH0FW2Im5LaNt4th5YttVzSm8TvfSsQ9Joz8NrI2R/8o5Nd5h8neRTXQv33aL2BBIU1s0h6OYRzcsesD1S1hLaobOScW3Ni3cDoj4OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753269510; c=relaxed/simple;
	bh=NCsjaUI2FgWzArbYhZfq+jli7Z84VPLHoBN6tS76E3s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KH6wv+4Af+NgOOzf+6qXpvbH7NUOX2xyoASq5Nc1Z92FtFhR9QR9/wmXJjsUCpGUPvsUJlSj1+M3bidoyhypF+Rzl/VIzd/V1nVGprkPNESzrQs1hzXY6K593ykM0q5880EWZdFa+tc6j4e+0i8SQz+GyVRJOQnUxzIhG1WH81M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g8tKKvsf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g8tKKvsf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753269506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NCsjaUI2FgWzArbYhZfq+jli7Z84VPLHoBN6tS76E3s=;
	b=g8tKKvsfhM9C+pNay108G1RzAwlHCRywIbmgXnjvdqxhPsGbUqOYZCDwEIEaw7BnlQE7A5
	+RC2asafdLfhdP7mok5fqaw+pquPV6TDA/Lj64ga1vG/kfKTttYeD2VU/b29gPV2kEMtpD
	ETNAUV8Iz6zFduHxEYDOf2eF4uduEcE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-DUoyh_MvNQiA7PCdpWEWDw-1; Wed, 23 Jul 2025 07:18:25 -0400
X-MC-Unique: DUoyh_MvNQiA7PCdpWEWDw-1
X-Mimecast-MFC-AGG-ID: DUoyh_MvNQiA7PCdpWEWDw_1753269504
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45624f0be48so37458525e9.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Jul 2025 04:18:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753269504; x=1753874304;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NCsjaUI2FgWzArbYhZfq+jli7Z84VPLHoBN6tS76E3s=;
        b=DEYnsibE9KGtwun1c3lHUaEXDvARwv1ZLcFVEi+/dO2skOMefDqaCKz37p/7zAAXkT
         VKY3JkTFV4z0C0fGbrTuI/kP2RbJWcJM+ZL3FEX4JybfsPcPXTODnzrQgVsHmMLFk601
         3uOmI3TRkupjmAFJPDY8kniCAT5SroIlnZoR2sdu+g0KODByQpY4h/88zIfcK9ouvV6r
         5gwtyoT64RYP0fUKZ4qCKdYbx5qeVg7EVNKcrzt+rZ4Cbr+FItPjxq1KVp9j3dwNsqh/
         jjrDxXC+/H/w+l3FAQzhJAAhExl8EoaVZuQ+SYR1LyKB1/eqEv0PWorbRkFM6o2n8dQG
         P+cw==
X-Forwarded-Encrypted: i=1; AJvYcCWty03yQey+SG/ZKivne0ylWA7j5ZDkckSis/i3AoGFmjysEYTwGoBqhJNOUJpyeZNNoDWUEB7pl31/RaElBnQA0BE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTaR9SG8m+WX8sgp6AphiUX5MlnOOQITWD64nOzE5iFmrH0rJY
	MN4veXVuy/yP18P4T3E+5eWr0Gf1tELgju8+Tuwa58oEjX+DZigk1PlrzKD/n4wYcAXXeVzpjID
	QbDoJDWC/flaVS24R+rAA+7Dhgoh8ZYtLA/2O/NqRTJMiTLJADQVaZbjbKYLiFq10ndNLpumeew
	==
X-Gm-Gg: ASbGncvpb4B6vwKPtGnSKj+sTX5G4nwX+U79ovHldWe8IaQC8z6ohBPQK2y27tgPbQ6
	Dm157At+dHLCKvhnHW9SV4Wbt40UaKFgvzOgd+TV7dAYFS8rpJj7FJrW+FSy/9b5Pt/fZODmHtw
	CFxzuHOBX0rNihHclfdE297hfOedgRacLB/TagsWoZJ86COxxAgHl5euSHmHFl44Q3z3c5DjzBh
	WKmlnwh8WMMneNl2bPOx/uJ7nj35WoCfXMlBwJDpSfZ4rNgwdsHTTAC+FRDWi988J6J95yXqtVW
	tSRvY/DiCUQTQyd2JsUB1j2exQxwEspCb8qz8SMk08nMSsHG6Rg20E5Y6v3Qh7GBAw==
X-Received: by 2002:a05:600c:3f07:b0:456:1d61:b0f2 with SMTP id 5b1f17b1804b1-45868d80dd4mr24977915e9.30.1753269503736;
        Wed, 23 Jul 2025 04:18:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGy5TCWxQoAdDPCS7gnjL4Nc9CVcn2kV1G0g/sNAUjUbZay7cLSZYcSITz14tFnwyBCBiPeDw==
X-Received: by 2002:a05:600c:3f07:b0:456:1d61:b0f2 with SMTP id 5b1f17b1804b1-45868d80dd4mr24977445e9.30.1753269503141;
        Wed, 23 Jul 2025 04:18:23 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4586918c6c4sm19870955e9.11.2025.07.23.04.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 04:18:22 -0700 (PDT)
Message-ID: <d6d432828fb542903cf87e1c0be57812cda92b0a.camel@redhat.com>
Subject: Re: [PATCH v4 09/14] tools/dot2c: Fix generated files going over
 100 column limit
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Tomas Glozar
 <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,  Clark Williams
 <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Wed, 23 Jul 2025 13:18:21 +0200
In-Reply-To: <20250721145254.WPp6FNzS@linutronix.de>
References: <20250721082325.71554-1-gmonaco@redhat.com>
	 <20250721082325.71554-10-gmonaco@redhat.com>
	 <20250721145254.WPp6FNzS@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: r4AiPSABfxgn-m-knWBiL9NThOezdpHE9H6cjFyxn_c_1753269504
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-07-21 at 16:52 +0200, Nam Cao wrote:
> On Mon, Jul 21, 2025 at 10:23:19AM +0200, Gabriele Monaco wrote:
> > The dot2c.py script generates all states in a single line. This
> > breaks the
> > 100 column limit when the state machines are non-trivial.
> >=20
> > Change dot2c.py to generate the states in separate lines in case
> > the
> > generated line is going to be too long.
> >=20
> > Also adapt existing monitors with line length over the limit.
> >=20
> > Suggested-by: Nam Cao <namcao@linutronix.de>
> > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> > ---
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strformat =3D self.__get_st=
ate_string_length()
> > -
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxlen =3D self.__get_max_s=
trlen_of_states() +
> > len(self.enum_suffix)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tab_braces =3D 2 * 8 + 2 + =
1 # "\t\t{ " ... "}"
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 comma_space =3D 2 # ", " co=
unt last comma here
>=20
> PEP8 prefers two spaces before the comments.
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 linetoolong =3D tab_braces =
+ (maxlen + comma_space) *
> > nr_events >=3D self.line_length
>=20
> Shouldn't this be '>' instead of '>=3D'? 100 columns are still within
> the limit.

Right, will do.

Thanks,
Gabriele

