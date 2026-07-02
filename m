Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4963C4BC02A
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Jul 2026 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783000894; cv=none; b=CYe46kwfjdycFeaQWgXE1bHMZP/2ELjgaWFKflgZScf+Oxj/2j+biyFa7Q4/rZPPgmzqFDqYy63Dt22GTrmGi1IhxeUpkTPoK2IT0Q7kgZj5f9NUfpt3YltTEwOTCSCMyHWfaH7E2bGlYVyG0U9cWsMB/WCZ3C967SUydzrkJcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783000894; c=relaxed/simple;
	bh=8kyNQRirnf2cKiXwYG/vWHQxapmPf4XUteIF+6/Ckms=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PbU7c7usWAAUfeql2UEly6tZYUB6XXLQ36oJqGvwfq4d6Ni0350sCnqSoChB8bSBiWB3VvADIMd8IMw4EOsOsMjSOMJLNMEButbZUkVEpxEkw7mCBCIRgVdF24i64biLhl+lLNuGN88IbzqBIqFC06rhoH5AsQ/VWfvyr9i7gOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Co3K6r1k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Co3K6r1k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783000892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5/yT65UjojWRzyrirEnnS2FwfXKiYApvhR4+/iODC0c=;
	b=Co3K6r1kGjunjRElszqX/Qm6he7q29qEKhnuVaKoygFZMBMXXRhG6aP8+fRMIsUSM6E/To
	dBZJEmC9olQe0F8p2Xfp9kOc7N9qKMBDtoj9pp5ZdY/8PYenOWx6DtXqOOIeKrLXCM0Q28
	6TXOzK3+cf6h8HfyZmRRg5ro3y+/FRk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-tme_SmZHOEqHRT-vwlqi8Q-1; Thu, 02 Jul 2026 10:01:31 -0400
X-MC-Unique: tme_SmZHOEqHRT-vwlqi8Q-1
X-Mimecast-MFC-AGG-ID: tme_SmZHOEqHRT-vwlqi8Q_1783000890
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c126bfee5a0so177743766b.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 02 Jul 2026 07:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783000890; x=1783605690;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5/yT65UjojWRzyrirEnnS2FwfXKiYApvhR4+/iODC0c=;
        b=GaCxYjSNYxVbGrynKAUq6t4tBWqkkWQK5vfxlHudXQSo6qqrSDlNzH04j7fvocnxlC
         btYZqZJSeGWUdLYKLyTrcPmOjB5DIDRxOeVH05c9pwskNMdDP6TTNRbMfxZi/586br9l
         Hca84ebCsT5JJEIIYVMWqgdhtUXqGHKueoBaaz1wJs6u/acRRqTve+8XL5Wj2deMuKy5
         HUJE2P6Mun8uowPVIf0BC2UUpiy+rQClirwHL+87u6vqqyxiQ1gpm8tMFHnDWcLjH51t
         +A9RFB9i+qVdP6ylO6kTlGIkjfLHN8tyDdd2KXcwmx2divTQbVoL/Ii85rirvJ9YVDug
         0JFw==
X-Forwarded-Encrypted: i=1; AHgh+Rp2IgZlglUup1PpbZsEBp6J/GMPNu+7WvJRuesxafBrE0ZOMDsku5HbzGEMtF9wyFQbdnakXhOSic+FCCHOKyBB/fA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqpL4Blxg6I+Y/kFJfDFqHpDcIfU1ASnBAPR4HpLkwjm36h559
	5R10GG6dbjgDF6pEdgGHUe0Tp4QmCi3IOh814P2vAdyjA09XBV63Hq3AcNps46qUX2tfh/TIm0D
	PHBeDcCgdcu1u4WUhxXVFOEsSCUzAGqCjH/v6Oo5dcOcz4W5Pw7v3If9pMOOVACIb5E/vUWX/Ww
	==
X-Gm-Gg: AfdE7ckbtsyzb/IHDa2Y/eEa75hj1FlFrOfJK8yhEluEW3BiEiv0YJgll+/6Q8fYMeP
	4eKXz3tUf0v45+IKXHRuU/Ey08N4AF1Bpav0JvSLlBsdWxHHT+WfmeUrYDIuTQVTJMQTF7axxBn
	3Ysp9Ll8Zh3+UF6pUkXU9fAbgwdL4RrDJh/6BGkNEulSCSoVKm/PhOee7B0fkLf+CCyCKVz0Tjm
	W/pw8JWWdbPzY7Ivrj/qPkEuvcNCdDYD5r8JyUtENLp8gtTkWuIDvHmVBVg5XTJAmZnqj0xgfWY
	xFWJJXBfaloPKdIuq0YCDb8RAh/BLH+cPk4T50DQarVDZw4rtDrUBr5aRlWUW7ExlfgBEpIBNO5
	LqCwY304FXQwgcQcfc272hmgvyNY358mDp5b136HhfGp+CBp5uDRoFhR4LyG28rkZuBmyXVjlE8
	bGgnOy
X-Received: by 2002:a17:907:1b1e:b0:c12:b17e:f8c with SMTP id a640c23a62f3a-c12b17e10b1mr184028566b.65.1783000886926;
        Thu, 02 Jul 2026 07:01:26 -0700 (PDT)
X-Received: by 2002:a17:907:1b1e:b0:c12:b17e:f8c with SMTP id a640c23a62f3a-c12b17e10b1mr184007566b.65.1783000883713;
        Thu, 02 Jul 2026 07:01:23 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477dde19e8dsm9874217f8f.27.2026.07.02.07.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 07:01:23 -0700 (PDT)
Message-ID: <4dc81b777bb8daaf4687c0d9db7ce740abd0a825.camel@redhat.com>
Subject: Re: [PATCH v3 03/17] verification/rvgen: Improve rv_dir discovery
 in RVGenerator
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
	 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang
	 <wen.yang@linux.dev>
Date: Thu, 02 Jul 2026 16:01:21 +0200
In-Reply-To: <87y0ftijkw.fsf@yellow.woof>
References: <20260625121440.116317-1-gmonaco@redhat.com>
	 <20260625121440.116317-4-gmonaco@redhat.com> <87y0ftijkw.fsf@yellow.woof>
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
X-Mimecast-MFC-PROC-ID: opGmYIwEx1zJd4X99z41V-wcnwQa3VxVWP5adGMfeYw_1783000890
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Thu, 2026-07-02 at 15:53 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > The RVGenerator class can find the RV directory (kernel/trace/rv) in th=
e
> > kernel tree to do some auto patching. This works by assuming PWD is
> > either the kernel tree or tools/verification, which isn't always the
> > case (e.g. when running from selftests).
> >=20
> > Make discovery more robust by relying on the absolute path of the
> > current script and traversing backwards the right number of times.
> > This should work from any location if rvgen is in the kernel tree.
>=20
> Agree.
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # find the kernel tree root=
 relative to this file's location
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 current_dir =3D os.path.dir=
name(os.path.abspath(__file__))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_root =3D os.path.abs=
path(os.path.join(current_dir,
> > "../../../.."))
>=20
>=20
> The=C2=A0 "../../../.." makes me sad.
>=20
> We can find the git project root instead. For example:
>=20
> def getGitRoot():
> =C2=A0=C2=A0=C2=A0 return subprocess.Popen(['git', 'rev-parse', '--show-t=
oplevel'],
> stdout=3Dsubprocess.PIPE).communicate()[0].rstrip().decode('utf-8')
>=20
> (stolen from
> https://stackoverflow.com/questions/22081209/find-the-root-of-the-git-rep=
ository-where-the-file-lives
> )
>=20
> But that's not important, up to you.

Mmh good point, but what if we're running from a tarball?

I could still fall back to something that uses directory parents (maybe
something arguably nicer like

  os.path.join(current_dir, *([".."] * 4))

But that may not be more readable..

Thanks,
Gabriele

