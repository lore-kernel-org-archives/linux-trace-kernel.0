Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CC633B6DC
	for <linux-trace-kernel@vger.kernel.org>; Fri,  3 Apr 2026 07:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775201390; cv=pass; b=ejwHT0fqP7OQDFCgNpjO7D217VYHLXC+soYKXt8cbqgjoDDacyPyCMKNf6bZPeQiwsGFix1+3lxI2W2cPS4/nhiXZfvCFlpqXN6g7j72qFl/WqRgOUmJO8NYg73+dd+189vigsBvVXsaYgiJ89QvBd5EEvw50MUwbWYG94QiDkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775201390; c=relaxed/simple;
	bh=dSP9B67PcIPNXOWEGqbunqNIwVnLKDc4bsAJSGFgwk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=orT08fNAvJ4LUCCcqR3B5/tulJXio1zuwLQUsoolEP3RsnE/b/nDFgJt3k7X49VjwziPg2SJtKBxFJTCfgVrCS+CHwRWxq1gG0yJ5fYWStZP6okIDTfhNEOYnls+eyDLsksHU9M1MRGS+dKK6VM95bjXiM3nRal8OBqjtWkI9wA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jlq//Wxx; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jlq//Wxx"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2c5b3d8eab1so1173677eec.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 03 Apr 2026 00:29:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775201388; cv=none;
        d=google.com; s=arc-20240605;
        b=hq+Iof0vd9WhAxXQBeURFTB+o9GQJFABHoPU94b8UpwgVmLo/SBQfMKThFSU0ttaEU
         V4Ht0jNnkiS2akzKVmI0dFJf3owNgN5LvUXutnBZ1/ya//q+m//lF00mfskDakTI5NVv
         rvrbQsH6vZIctDutUO6HYB2KL4qCMuZwCIRZwqHB5cpTUIHDR0/lngTXMvElxLqlnajW
         DxL6fQEsDGxhY8iYxkT6rIdgOz/yIyNLdM7vytIlMJAwRkUMFA+bYqL7hab6GTZX0OjD
         gajVT+VHSUEJe3XYaLOzl7egfJRrfIRSGtiEurCEEMaoM2tS/QSubOT8u6Ncsua6af+J
         aFUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dSP9B67PcIPNXOWEGqbunqNIwVnLKDc4bsAJSGFgwk4=;
        fh=XHcP1jN0zM1sQf5p8PTiiVaT7yft3BmFq/4dWZyMSpg=;
        b=koZ7kVDH00WxYLtdiiAerksMw5DqhfgHkBRYW6D3c0a3l6H41eE5zJJP4M6WqDQcle
         QqeTSDg23yAyNivSFbzbiAEF8oHT3G0+ul2au5NoY8KU3AmaEfKjUeaFeMD3cyJcVxsV
         5GvnsDQbvfhzeHgm4psMrlz/726CM1Ft2wJvlQGyIltrWjf9W/7v9FgbnRE/ofJtjbP1
         VvRrLRJ6nxv2TD8neSHv2sTdUtfBJiIw/WYLl8aT2VKDZERb+h+adv4sv8Sr2hkPazmX
         hZaElL0mQ6MFhu5+FGrOVOA1U+b7GNX4x3nDSfpOvvr1/PuZ4AboMEyQKPudBaId4C31
         pkJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775201388; x=1775806188; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSP9B67PcIPNXOWEGqbunqNIwVnLKDc4bsAJSGFgwk4=;
        b=Jlq//WxxF0oIPcOHH6KCAOZs6vz4B9oWVWoF9z6v9NMprs/Wc5aj4uE6JcN4+e+IhH
         3iTOZmOyIHpWdXDExa1m/Q+obj4F9Sib24IYRbW2xudw6E0wuxad2i92+kfHgP5FAhVB
         65Kzjah1NEKxxD1/NJMr9Nc2oJv48cOhTQWUZOwPyAb6dy5mdJNs2ek9NDSwQ3Pu7/ZK
         dS7AtlfAWwhtM/sCua7AWILfcWnUcwj16210KdjpgM9C8jCg/xiow1HHmVjlOrlPt3u8
         7TsB3+FN73YxBxrpipjKCbCt82GjKdygV9fHqPpS5Q7WMxGnpOnas+YHlkeZvlNTBCL0
         G69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775201388; x=1775806188;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dSP9B67PcIPNXOWEGqbunqNIwVnLKDc4bsAJSGFgwk4=;
        b=ewnRQ28jaCF9wL8Mkkl9VzgSN/CVXOaTnBVRXxvmNGEwmUChqFNVTtJKbjHJ2kf9Ut
         t1nSPsIuG5qoUcni/ID3+1TxpV3IE2UVi1ufScNVgNqkplrn6V7xlCW99T6aUNlLC8+P
         veYNDMh1BN2RYY0VgqTe0Fccom1rR//uZfPrFwnuBSwHudb3DoZ8n5FfbbnjB38f3IMa
         T4tiCaX24/nH7sKHih9XufLbBWhu3KS3rZPqMOiXANztoTOiLUBKN8/bKOSczAhufINu
         6PYTIMpDBzGDoA13G1Gus1mT8AnKYTx09wL1cCHIa69n8n5GUtv6l4YB3yE9SHXUQzLa
         5EcA==
X-Forwarded-Encrypted: i=1; AJvYcCVKq6xaL/Xjl893aYkcpk8dq+h88I5QPTXiBPRjmAm6Tfs8NrbqVKi6zn55wCGUWKQPhDOhYkk6bOR4dToeafPLyvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGGQ2N+nJrR8B8ssjoEQfyD75D6+zeyRDErMFhW9qRLNFb7Pb6
	CWiWOzYln0CeoObBNgqYI5VQivNWwk1UQsSMH4NmpjO5pdOzOMb3Ce4LEsMzndLSJx5HVORHhH3
	ShrUe7kAEvCm8Xq7DGQvAZ6bjaVZmvhUuwZ2i37k=
X-Gm-Gg: AeBDietJYfrEv5lDwy6geLA+2U7F2+J0HzEwldlhtiLx4GCVh9/pUJ+ZplzZBTd38Qb
	74pouiwaBvTET/T4Bkpnfea0UbojiMbrJZ9sS6HX2GoQovfxiED9EkWzvYBeY7AIC6usb0WbVFT
	hMeur7EsHSZ/Nu42iSNg552r860DdowjRqiyNoVZddzWsMhIrUAYQDcFSYnbX0Qv2tbgJ5stJOn
	TqPJRShLocdfcfbZko636Lb8zxyVciMVR7aPlSRgSbAc5L6MOCA3DI5X9lMTTEmfJVCoZW105mn
	6/bPOvywMoYa9pcoT9QnM6G4PuwxDbqcxo+AisA=
X-Received: by 2002:a05:7301:2f8b:b0:2c4:ab8f:1da2 with SMTP id
 5a478bee46e88-2cbfb98efe6mr1116475eec.21.1775201388267; Fri, 03 Apr 2026
 00:29:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402195405.21316-1-abhijithsriram95@gmail.com>
In-Reply-To: <20260402195405.21316-1-abhijithsriram95@gmail.com>
From: Abhijith Sriram <abhijithsriram95@gmail.com>
Date: Fri, 3 Apr 2026 09:29:36 +0200
X-Gm-Features: AQROBzBaCaTNkYJrgY14UhC_qZSIqEI50-XLMLvEJH3xMGQNY-wpQ5UqzfVkZ7s
Message-ID: <CAMTgpFfrrznFgk1EDyr6C==VEcwsAv2eCR98wB9=d33t1=WxLg@mail.gmail.com>
Subject: Re: [PATCH] kernel/trace: fixed static warnings
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	"open list:TRACING" <linux-kernel@vger.kernel.org>, 
	"open list:TRACING" <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 9:55=E2=80=AFPM <abhijithsriram95@gmail.com> wrote:
>
> From: Abhijith Sriram <abhijithsriram95@gmail.com>
>
> The change in the function argument description
> was due to the static code checker script reading
> the word filter back to back
>
> Signed-off-by: Abhijith Sriram <abhijithsriram95@gmail.com>
>

I have corrected and made a new patch, please have a look here:
https://lore.kernel.org/linux-trace-kernel/20260403071108.23422-2-abhijiths=
riram95@gmail.com/

--=20
Regards
Abhijith Sriram
