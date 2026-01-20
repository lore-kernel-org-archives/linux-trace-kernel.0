Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE42381710
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 13:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768914714; cv=none; b=fGeDvWO742CYYziGa+iWoc0epnjhD9yREUXk1ZOFIId/zD8a2SCjjC4kSYrV4MXk7mifJuSjxZN82E3K7y/3DUQINOzaCO2veuyP1eO9ooByweK5YRMjPwNibWRyXP01ZutCeJCWqFqX7Nbqwq7eAF1LkT1FNG1WgbXCI8UkMTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768914714; c=relaxed/simple;
	bh=IjmP9Ryi85s9+rZFklMkA94sn+toExpDe2wDripnhfc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HhboG2727PAuwHhyveiQI14cNIPF+I4MsXbX2EEybagQDTSuk4BB3f3nkpoPewa2RR0GXrt9BR53ByYkNTWXRyWS5FNprS91A/pkANneLYgghDX7SF+gR+k8fsOyuleHU1lUfBdGCVZNUX4c09Xew930WCb0DSB7NwcpCqJyMeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JlVpGUgX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JlVpGUgX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768914711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IjmP9Ryi85s9+rZFklMkA94sn+toExpDe2wDripnhfc=;
	b=JlVpGUgXhudZELYlseStpguo5UR0JooToeaDL2+jLfFgEbzKBnGTd5npw27ePUZLYM8SyM
	r9rXyyu5uWLgGH6VmN6Umc1q5zNWcd0bjJMkBVK53aRffNOI3JE0aDR8r+XYXIRJTf5Ab9
	lkLp/cxUCsV1Pdhqx/I+q7Ce8iHvsck=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-c45GfC1eNdCupTjADfiWOQ-1; Tue, 20 Jan 2026 08:11:50 -0500
X-MC-Unique: c45GfC1eNdCupTjADfiWOQ-1
X-Mimecast-MFC-AGG-ID: c45GfC1eNdCupTjADfiWOQ_1768914709
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4779ecc3cc8so39172685e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 05:11:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768914709; x=1769519509;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IjmP9Ryi85s9+rZFklMkA94sn+toExpDe2wDripnhfc=;
        b=Ff+ebbsOxvPQdM2iR0dobHp4LFcjNztV6KSyX+0U/M9WOMOwt7NrXGifvVxBHHK64K
         bSDKVOCpEOMbLSS5skT8bkCcusPE0BVftJR3RC9E20ATIH0psNzhsBfjxuFVrkFb2dW1
         ZjvQzG9ePmkyjcjB4jHwFrWkDWbkrpfE/c/YUjpg3lGARy/j5QQISIbFS2rZDwoVw5rg
         A2BWowBwgOKktWRFP0u7TLb7yznmY+kyBM21llM3yyQ/uK7RA06l9+sKmIcxHpidgMJ2
         ccbIgv7WCNg0KHuAmcanCOIOLVWVJSlxj94X29W5KjGrBGTDPdg4/27Tut3JeykFZugR
         RlTQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1kNZIvgTZ+FJ/eTu0l7D67TSQholuA71Pz3XEROrrFMZeWJsHMLhSHRQVXqrx09nRPGY2fELxxu25a47IakKIixQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCdbKNFkQ+Ajf+Lf3padTvi4+7A2Dw3ZkNd9H4qhB7eW4cbhvI
	mg0JoQ2pywPlbS++8Ru/7eLDP6LRqsWvZ5ZlesnIHejzWkGlhQlQbal7RErxQZ90OOh5KIzOacQ
	zMnnZc07LTcUJZA5qX1sKgPHc8LQSaY+YZrKXVb6tDjK23VcU8W1gu4tQ4kvRZcq3Xr8WgbLa0w
	==
X-Gm-Gg: AY/fxX4az4DB3Su7r1PjuCcIl7DJvTRPlFzkGHln+0mk/qIdNZytl2vQvk8Tho+K8Fs
	GVztoAIsGhq4MTpp+KTzfoZkqK8n9nU2Iacsn85h062nOdeSbHuLgjinFsfw1oVAMlhsECZoZxY
	fTAIkWLsBZ3JU9zNd9VGb0DmvXdzOusImg0l6dBlLdrWURO/bE/X5i0PeT1Oxhkr6LzOgHeJEys
	SlthlCWiezLzrWRcR4pps3WYy1OXwBf8Tu3cvMXaPCdGEDFskPJe75xlDD29q3ka9rqoC/jsBGQ
	oHDfo58UQdgqZQUosXEAg8FueWHL0qtVqSWUFyVYaIAKfJvezdqbOOtwnQbMmes7i+jBD/em2Rw
	nCqb1NYald19PdA/fhlKfhxb4u/fr6aRFy48YGE9R0zgCv/FC3p+1K51Y/7BSLJIQUJmiLPU5Rj
	n6P9HpWkfZ
X-Received: by 2002:a05:600c:1f88:b0:47d:18b0:bb9a with SMTP id 5b1f17b1804b1-4803e801d8dmr22531785e9.33.1768914708845;
        Tue, 20 Jan 2026 05:11:48 -0800 (PST)
X-Received: by 2002:a05:600c:1f88:b0:47d:18b0:bb9a with SMTP id 5b1f17b1804b1-4803e801d8dmr22531325e9.33.1768914708295;
        Tue, 20 Jan 2026 05:11:48 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f428b954esm302419555e9.7.2026.01.20.05.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 05:11:47 -0800 (PST)
Message-ID: <d15348f9f6d8ed71ba3e928ae1b5da15711894e3.camel@redhat.com>
Subject: Re: [PATCH 26/26] rv/rvgen: extract node marker string to class
 constant
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
 open list <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION
 (RV)"	 <linux-trace-kernel@vger.kernel.org>
Date: Tue, 20 Jan 2026 14:11:46 +0100
In-Reply-To: <85c7d4762464e6a50b4318f4ea56a70202a4b287.camel@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
		 <20260119205601.105821-27-wander@redhat.com>
		 <0383d9a3fdaeb2b66e48a7857791bcbfe324958d.camel@redhat.com>
		 <aW9nfu8r0YcGj0z5@fedora>
	 <85c7d4762464e6a50b4318f4ea56a70202a4b287.camel@redhat.com>
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
X-Mimecast-MFC-PROC-ID: egWY08Se6Cr5GWsY7yzNETYMsC-MfYHD9NPCGXSf6ww_1768914709
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-01-20 at 13:36 +0100, Gabriele Monaco wrote:
> On Tue, 2026-01-20 at 08:34 -0300, Wander Lairson Costa wrote:
> > On Tue, Jan 20, 2026 at 10:03:20AM +0100, Gabriele Monaco wrote:
> > > On Mon, 2026-01-19 at 17:46 -0300, Wander Lairson Costa wrote:
> > > > Add a node_marker class constant to the Automata class to replace t=
he
> > > > hardcoded "{node" string literal used throughout the DOT file parsi=
ng
> > > > logic. This follows the existing pattern established by the init_ma=
rker
> > > > and invalid_state_str class constants in the same class.
> > > >=20
> > > > The "{node" string is used as a marker to identify node declaration
> > > > lines in DOT files during state variable extraction and cursor
> > > > positioning. Extracting it to a named constant improves code
> > > > maintainability and makes the marker's purpose explicit.
> > > >=20
> > > > Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> > >=20
> > > Looks fine for me, thanks!
> > >=20
> > > I wonder if we could merge this patch with 15/26 that is introducing =
a
> > > very
> > > similar change on init_marker.
> >=20
> > The idea was to make each patch doing one thing to make the reviewer's
> > life easier (I think I broke my own rule in a couple of patch). But if
> > there is a strong feeling about the merge, I could merged them in a
> > possible v2 patch series.
> >=20
>=20
> Yeah I get the idea, I guess I could just pick the most obvious patches a=
nd
> send
> a PR to Steve before the merge window, so I can see directly if it makes =
sense
> to squash them and you don't need to send them all in the v2.

Screamed victory too fast.. I tried the patches on the latest version of th=
e
tree (which reached already linux-next) and they're have several conflicts.

I don't have time to rebase them one by one right now, let's continue with =
this
series as a whole.
As a rule of thumb, considering these patches get first reviewed, then PR-e=
d to
Steve and then to Linus, I'd favour to lower the number if possible, but fe=
el
free to choose where it makes sense for them to stay separate.

Thanks,
Gabriele

>=20
> I'm leaving the longer or trickier ones for the next cycle so that I can =
test
> them a bit better and perhaps get some rvgen selftest help with that. Als=
o for
> some it's better to wait for Nam's comments.
>=20
> Will let you know the ones I pick. Thanks again for the extensive work!
>=20
> Gabriele
>=20
> > >=20
> > > Anyway:
> > >=20
> > > Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
> > >=20
> > > > ---
> > > > =C2=A0tools/verification/rvgen/rvgen/automata.py | 9 +++++----
> > > > =C2=A01 file changed, 5 insertions(+), 4 deletions(-)
> > > >=20
> > > > diff --git a/tools/verification/rvgen/rvgen/automata.py
> > > > b/tools/verification/rvgen/rvgen/automata.py
> > > > index a6889d0c26c3f..5f23db1855cd3 100644
> > > > --- a/tools/verification/rvgen/rvgen/automata.py
> > > > +++ b/tools/verification/rvgen/rvgen/automata.py
> > > > @@ -29,6 +29,7 @@ class Automata:
> > > > =C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 invalid_state_str =3D "INVALID_STATE"
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 init_marker =3D "__init_"
> > > > +=C2=A0=C2=A0=C2=A0 node_marker =3D "{node"
> > > > =C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 def __init__(self, file_path, model_name=
=3DNone):
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.__dot_path =
=3D file_path
> > > > @@ -76,7 +77,7 @@ class Automata:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for cursor, line i=
n enumerate(self.__dot_lines):
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 split_line =3D line.split()
> > > > =C2=A0
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 if len(split_line) and split_line[0] =3D=3D "{node":
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 if len(split_line) and split_line[0] =3D=3D self.node_marker:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return cursor
> > > > =C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise AutomataErro=
r("Could not find a beginning state")
> > > > @@ -91,9 +92,9 @@ class Automata:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue
> > > > =C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if state =3D=3D 0:
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 if line[0] =3D=3D "{node":
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 if line[0] =3D=3D self.node_marker:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 state =3D 1
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 elif line[0] !=3D "{node":
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 elif line[0] !=3D self.node_marker:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 raise AutomataError("Could not find beginning event")
> > > > @@ -116,7 +117,7 @@ class Automata:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # process nodes
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for line in islice=
(self.__dot_lines, cursor, None):
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 split_line =3D line.split()
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 if not split_line or split_line[0] !=3D "{node":
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 if not split_line or split_line[0] !=3D self.node_marker:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break
> > > > =C2=A0
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 raw_state =3D split_line[-1]

