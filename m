Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BC1346786
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 08:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768896414; cv=none; b=GAbP/Ouik9NUoT/rKjK4n1Ti0TnKghpRYTiLrZiDrJKwKlSuag0ujl0YUagS0fnuVmA3VVfE8Yo1Vb7CzjUzxsy+Qj1oVeNNxPadl7zdfrt3c1NSZtIC0GqDh9h/l+KnCf1cah3ZY/VQcOGOcVTXlFx0AJUMvV5Rxf+zSmlveRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768896414; c=relaxed/simple;
	bh=8w5tcm4WLnxiXrxrgHIZ8ff3Wu3v5gxtpnsuOPkgZ3Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xy5qgbiYyJfnzX0+jHfjap8+HBYv4cUJNUQ8KlFXLkjnZCF1cZcLlELjSStoBrigHWJ5/3LJewDxMPs9n1w0veyu9KngQ1Yn/n0T2iwyayrW65fgbrEO0/QV3F35IvaAHJfQbKEPF8C8fq6PICJqAAR6ebqFcCXqsKqr3UiyvqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ONtZhOFc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ONtZhOFc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768896411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8w5tcm4WLnxiXrxrgHIZ8ff3Wu3v5gxtpnsuOPkgZ3Y=;
	b=ONtZhOFcfWFMJ5CMh67OnKHJFHWvz7wnIREMetw4+hVkIbWBzk2eqP1vc70N8aMB0poQt4
	3teTrw1rxiY+sXYMhRia2bymoXDsOvOLB1ek7GWPYdVNGwObOsSciVb54Kv2S9de8lqnlV
	avYn3XJLU9UJjVWt+BUton9/w/4q530=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-1tnPWhjzNY6s4-Dtvx3w3w-1; Tue, 20 Jan 2026 03:06:50 -0500
X-MC-Unique: 1tnPWhjzNY6s4-Dtvx3w3w-1
X-Mimecast-MFC-AGG-ID: 1tnPWhjzNY6s4-Dtvx3w3w_1768896409
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-430fc83f58dso3390425f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 00:06:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768896409; x=1769501209;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8w5tcm4WLnxiXrxrgHIZ8ff3Wu3v5gxtpnsuOPkgZ3Y=;
        b=W9NfvbbiZ3iwtBhGKzULFnJBk+6FQT4760dLJr++T7PAEmZ1ozBfNmhJtCIPicZBlE
         BWgbkSBPZoniR8gEdNV8RvUZduoV+fq/aHVCZO3za+XKdfGuB+cMTUEyGczsFBeQwhxR
         J32yfxLe+0HPv7FT/riq1wSC41KyFu1qyfAGJLECG4+24hM+Qkh9GKYkaOYOyiHCJ0CF
         eCHyinyyeEjzHv1fipPireJpi66NrW85+KdR69d6U+yAaEgdGIErF0p2EIRuI/DfOc9k
         u6qVu8A4p2gwiUlKZ3KYFm5nMhwAQLeJzlLRPVDePjIYuNhrgFVaEgS3O+24iocJ9uWf
         ObBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUftofXlUA4i8Qh7CLjq+jugt6flLgL4r/byyyfu1mGNz59Je5xL6ln4G2SsmTbpjJf25iLifEQzwP1Z2XHG4Ja3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz5KQgVt66wjfc1oqToGNyBh8LA4tgB1z1sgamYyQzI7kvIsz7
	tcoQAOfBWhrEEonkEW/KLYn4iTBKU+MOJHz0MPrqdGgH63dc7TLjdWQG+Zi1/ApW29utLVz0jJZ
	4V5Y71G99iyeCoJmNUSNs4ABchpMzyO5nCsD7XewxEIrm/ooIChG9/IxtIBi+OHw0WlVjD3ADpw
	==
X-Gm-Gg: AY/fxX7z8XRw7f39sia+L9fjEpnnVk3TCOfgetTBC3bSdWdpIhgR8GjIICXMQPaoiwX
	TO2uXHws8+6PSjba5VYDQPZbNb3BThiaGMaj7B9Q2QazCDsx2ndBHFu6sh1CAqo1TgsTaw56P/n
	lLHLr+mYF2QlIsdLQtNUHHL+1Xa6EWEY5SUYmLuKHJhKnRfNF1/6RZGkSF4O4UazJ1RyxDtXpWT
	5IpsCXVW3flcb4zS4HgD14IBtlaoNOpTPVF1dkB/pUY2VvGRpOfjoCwg76TRIEIfmVlNWiP0va0
	zKhI+xupzWxcXd5KSATrgszewgBdbmxepJiNuidrobwq+74AGtIwWcvltDUr5TmrHdvAJiWGlMd
	lU4F7Il6BrRgR1At+RPPmKmZlnYi6zvlc2MXnwfCxEZlIH/uIQACfZjKsVXOlqaXKeLB4UlSiQ9
	SsADoDFIx1
X-Received: by 2002:a05:600c:1f8e:b0:47b:df60:8a14 with SMTP id 5b1f17b1804b1-4801e30ef39mr172534375e9.9.1768896408974;
        Tue, 20 Jan 2026 00:06:48 -0800 (PST)
X-Received: by 2002:a05:600c:1f8e:b0:47b:df60:8a14 with SMTP id 5b1f17b1804b1-4801e30ef39mr172534025e9.9.1768896408581;
        Tue, 20 Jan 2026 00:06:48 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e8c9cbcsm232707945e9.12.2026.01.20.00.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 00:06:48 -0800 (PST)
Message-ID: <dafb08f254efaa7ba5703b5a0fb17f901ca5fa1c.camel@redhat.com>
Subject: Re: [PATCH 15/26] rv/rvgen: use class constant for init marker
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
 open list <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION
 (RV)"	 <linux-trace-kernel@vger.kernel.org>
Date: Tue, 20 Jan 2026 09:06:47 +0100
In-Reply-To: <20260119205601.105821-16-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
	 <20260119205601.105821-16-wander@redhat.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eMq9HycFFHcZ_UTRJ0eLmD44S6e3HtQA3Z8DWK96xLk_1768896409
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-01-19 at 17:45 -0300, Wander Lairson Costa wrote:
> Replace hardcoded string literal and magic number with a class
> constant for the initial state marker in DOT file parsing. The
> previous implementation used the magic string "__init_" directly
> in the code along with a hardcoded length of 7 for substring
> extraction, which made the code less maintainable and harder to
> understand.
>=20
> This change introduces a class constant init_marker to serve as
> a single source of truth for the initial state prefix. The code
> now uses startswith() for clearer intent and calculates the
> substring position dynamically using len(), eliminating the magic
> number. If the marker value needs to change in the future, only
> the constant definition requires updating rather than multiple
> locations in the code.
>=20
> The refactoring improves code readability and maintainability
> while preserving the exact same runtime behavior.
>=20

Looks good, thanks.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> ---
> =C2=A0tools/verification/rvgen/rvgen/automata.py | 5 +++--
> =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/verification/rvgen/rvgen/automata.py
> b/tools/verification/rvgen/rvgen/automata.py
> index b302af3e5133e..8548265955570 100644
> --- a/tools/verification/rvgen/rvgen/automata.py
> +++ b/tools/verification/rvgen/rvgen/automata.py
> @@ -25,6 +25,7 @@ class Automata:
> =C2=A0=C2=A0=C2=A0=C2=A0 """
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 invalid_state_str =3D "INVALID_STATE"
> +=C2=A0=C2=A0=C2=A0 init_marker =3D "__init_"
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 def __init__(self, file_path, model_name=3DNone)=
:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.__dot_path =3D file=
_path
> @@ -96,8 +97,8 @@ class Automata:
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
#=C2=A0 "enabled_fired"}; -> enabled_fired
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
state =3D raw_state.replace('"', '').replace('};', '').replace(',',
> '_')
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if st=
ate[0:7] =3D=3D "__init_":
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 initial_state =3D state[7:]
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if st=
ate.startswith(self.init_marker):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 initial_state =3D state[len(self.init_marker):]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
else:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 states.append(state)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 if "doublecircle" in self.__dot_lines[cursor]:

