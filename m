Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B47B44DB6A
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 15:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768921710; cv=none; b=uSetff9fJAcvQ8i35U/SmyqZvCE2/WVDaCzTlU4a2gDLno4J2zi2BzXYw7JT9dhskE5u2soFr+2JWUetUkZT4Iq1Wo0riZc09Fjxiop1MgmjZaU/SoPCf9G8sWK/P/TRktBYA8wdgtFRQ4q10RKW10Lz9GgaB+zAcgJLoicPgkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768921710; c=relaxed/simple;
	bh=EVI4jkeh3zL/fFfXmk1dmFj/bIJk4+q7h5X87OJKKk0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BEbXIr3wHAert1CrXG97UQSzAHybbHmWdmMZotZcKGeCYhtU6oyXU8K6sCXLiJJKum53AUUsplgJ16+sYhBo1Jat5CioTiciJXBtrC4SZJ5JD/ftgg+zvjw0yTukn21TVyPukKcPutUkfz7/WaI8iA3uDa1pnF6jw5t9+GKhxTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U/6J6QKL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/6J6QKL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768921707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EVI4jkeh3zL/fFfXmk1dmFj/bIJk4+q7h5X87OJKKk0=;
	b=U/6J6QKLMj/LTpO07Kg3fweLh/HGTvq9rBg75B3Q+i2bSOCgR3VrVD6TUNu4Y9r3zIhtaT
	vPgGb4EcPhX+M31yWJQVsPeiKZOzIjZRUIA3wenpX/qOd8apBnaA2uxW9gVB0fV8wfbs2Z
	gxnll7P0Ye+epURZ8nBzTN/ND9TmspM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-tl9IIXZlPMqzn4542FKI7A-1; Tue, 20 Jan 2026 10:08:26 -0500
X-MC-Unique: tl9IIXZlPMqzn4542FKI7A-1
X-Mimecast-MFC-AGG-ID: tl9IIXZlPMqzn4542FKI7A_1768921704
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43284f60a8aso4665808f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 07:08:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768921704; x=1769526504;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EVI4jkeh3zL/fFfXmk1dmFj/bIJk4+q7h5X87OJKKk0=;
        b=Gmx8LgfNSQ8TG7GBW44Lb+jAUgb1uBtDbQw/OY54U/e5wmy2wKLzqltw0mVQuKllus
         c00yA2O4AZ6PtbW3wL5qneTWg4GhWa8mp0ajVTt/I9vFvmi7hWu6AK0DucWQZS7gETgz
         ko3hHjvwtt46LI16s+sFR6AU7gkweOL8zvoHf31pMVGz194ScpaWLRNXghRRUTE3MGDx
         K6nJ84dwQP9IvHudysO+oQe/zt0NGAeKFunKYPjBWRZIzigIc+9aekR9UYqxJqnZeMMQ
         lz0ksYi9zc6n0G5pMg8VPa1QfCJ5A+Sa+dii208kVaILpzcb/dMO8tFbFjDwA/5jdv96
         yZbA==
X-Forwarded-Encrypted: i=1; AJvYcCW/EFM+ZRt6kMxZ9kYZx9rGR95RvSOzzGz39XgkEaBkIhhVRFo4GTmQAB8Est56yZ3cmUszy3EVxDxxXFUSmlYqi6I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxabBXxtofl+DS+zt6p2aQicMIYklhujMBN0nDiUwBZviOdVHiu
	EAVWH33u6v7BYuHJvhUHYWneam65sT96tTgDPzZzPGgd6E1WLWTXzdxp5Mgy6e4LnuIPPCS6KTp
	c0uR2ss6cnc8Y7TIQMLDkbH7Nb5RhMUALwft4U9c2W/W5Sh5IrfGE6jN+NvRdbuejIheHdXgKsQ
	==
X-Gm-Gg: AY/fxX7+0mQxuMZp8LgO4Qwl2hTVfUCeSQ2Sq9ui9OyQLTfZwMa5LQJMOI70DOFK+5/
	Rm0Wze1YIt/THz8LnwnvNtsnuv59eOYWaYd2InFoYinA+vTLUny/oZr/YuUvoj0n4INlsAbeZ7L
	aNyKWt4p29qDPc6q2O18fjHnbMuqRr1EeY7I+IJGbBNA/bM32VoeIiVgBayGM+Ed+wYTpJOUjfP
	ibduu9WRI/gv5UqKo6RHf+w6KoMaDQv5wMY7N0y2XtQIV9rzq7s4I93BewdtR8CMeFty+6DAb6V
	O94qBbmt98vK8zDgQL11zrbJp64RkG9/6HhVvCxzxoM2pjYgqr6Edcl8mmSrvCKocOdjMYLf6OQ
	trXBkLCUzfVKtMztAFoFOfALdui50xdS2WKD63SZFSeZhYkPrFOEHEBJN3eZdV2Ei8Z2yngXqx4
	oF4PeDsJrg
X-Received: by 2002:a05:600c:630e:b0:479:3a86:dc1e with SMTP id 5b1f17b1804b1-4801e34f6e7mr212601965e9.36.1768921703851;
        Tue, 20 Jan 2026 07:08:23 -0800 (PST)
X-Received: by 2002:a05:600c:630e:b0:479:3a86:dc1e with SMTP id 5b1f17b1804b1-4801e34f6e7mr212601405e9.36.1768921703214;
        Tue, 20 Jan 2026 07:08:23 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e8c9cbcsm250037655e9.12.2026.01.20.07.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 07:08:22 -0800 (PST)
Message-ID: <fb6b81910e32dbf7aa16e1961dc1dca0a9bfbf57.camel@redhat.com>
Subject: Re: [PATCH 01/26] rv/rvgen: introduce AutomataError exception class
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
 open list <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION
 (RV)"	 <linux-trace-kernel@vger.kernel.org>
Date: Tue, 20 Jan 2026 16:08:21 +0100
In-Reply-To: <aW9ySuaPMZVm-MrN@fedora>
References: <20260119205601.105821-1-wander@redhat.com>
	 <20260119205601.105821-2-wander@redhat.com>
	 <24e308b019cf9272884091f85b6675fd05201a2b.camel@redhat.com>
	 <aW9ySuaPMZVm-MrN@fedora>
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
X-Mimecast-MFC-PROC-ID: Oxdz9df6_T8Nip0VAHBqM48rJH7VouIxKgAoZU2Q3vk_1768921704
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-01-20 at 09:39 -0300, Wander Lairson Costa wrote:
> On Tue, Jan 20, 2026 at 08:33:10AM +0100, Gabriele Monaco wrote:
> > I agree catching all exceptions like this is quite detrimental while
> > debugging,
> > but I see the original intent.
> > When you run commands written in python, you normally don't expect them=
 to
> > blurt
> > a stack trace when doing relatively normal things, like opening a wrong
> > file.
> > Sure that might be useful when debugging, but for a user-facing tool we=
 want
> > to
> > write a meaningful error message and gracefully fail.
> >=20
>=20
> One option I thought was to keep it as it is but adding a --debug option
> which would reraise the exception and then print the stack trace.
> But as the users are developers themselves, leaving the exception
> unchaught would help them identify the error (although I am strongly
> against doing this in server side code). Another reason is the case
> when the code itself has a bug. That would facilitate bug reports.

That could be a good tradeoff. Users are developer but (although I'm not su=
re if
it really happened yet) are not the rvgen developers, they don't need to kn=
ow
where exactly the code complained, unless it really broke.
All errors that are expected (OSError or wrong format) should have a meanin=
gful
message for the user, I believe by doing that we'd have a pretty clear idea
where the error came from in the code too (e.g. event parsing, opening a fi=
le,
etc.).

If the code has a bug, then yes we should throw the exception as is, that's=
 why
I think it's good not to catch Exception, but to catch only the few excepti=
ons
we know can happen, all others would be bugs.

>=20
> Perhaps we could catch more specific exceptions that would indicate a
> problem with the dot files instead of Exception. Like
>=20
> try: ...
> except AutomataError as e:
> =C2=A0=C2=A0=C2=A0 print(f"There was a problem processing {dot_file}: {st=
r(e)}",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file=3Dsys.stderr)
> =C2=A0=C2=A0=C2=A0 sys.exit(1)
>=20
> Which would be a common case. And leaving other types of exceptions
> unchaught.

Yeah pretty much

>=20
> > Other story is when the exception is something unexpected (that's why
> > leaving a
> > generic Exception here is bad).
> >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0 print("Writing the monitor into the director=
y %s" % monitor.name)
> > > =C2=A0=C2=A0=C2=A0=C2=A0 monitor.print_files()
> > > diff --git a/tools/verification/rvgen/rvgen/automata.py
> > > b/tools/verification/rvgen/rvgen/automata.py
> > > index d9a3fe2b74bf2..8d88c3b65d00d 100644
> > > --- a/tools/verification/rvgen/rvgen/automata.py
> > > +++ b/tools/verification/rvgen/rvgen/automata.py
> > > @@ -10,6 +10,13 @@
> > > =C2=A0
> > > =C2=A0import ntpath
> > > =C2=A0
> > > +class AutomataError(OSError):
> > > +=C2=A0=C2=A0=C2=A0 """Exception raised for errors in automata parsin=
g and validation.
> > > +
> > > +=C2=A0=C2=A0=C2=A0 Raised when DOT file processing fails due to inva=
lid format, I/O
> > > errors,
> > > +=C2=A0=C2=A0=C2=A0 or malformed automaton definitions.
> > > +=C2=A0=C2=A0=C2=A0 """
> > > +
> >=20
> > I'm not quite familiar with modern python best practices (so again, tak=
e my
> > comments with a grain of salt ;) ), but what is the advantage of using =
this
> > custom exception instead of using pre-existing specific exception types=
?
> >=20
> > Although the difference is minimal, here you're throwing an OSError for
> > something that quite isn't (e.g. wrong format for the dot file).
> > A ValueError feels more appropriate to me in most of the instances here=
.
> >=20
> > All in all, I would do something like:
> > * throw a ValueError (or a custom one based on that) whenever we expect
> > wrong
> > data not dependent on OS features
> > * throw OSError whenever that was the exception, perhaps changing the
> > message to
> > something more meaningful to us (like you're already doing here)
> > * intercept only those errors in main.py and print the message without =
stack
> > trace (if the message is clear enough we shouldn't need it).
> >=20
> > Does it make sense to you?
> >=20
>=20
> The reasoning behind specific exception types is to allow the calling cod=
e
> process diferent exceptions in more specialized code paths, like the
> example above.
>=20
> AutomataError could derive from both OSError and ValueError.
>=20
> class AutomataError(OSError, ValueError): ...
>=20
> Which would address your (valid) point. This way, the calling code could
> either process specific automata related errors with AutomataError, or
> handle general file error, like that:
>=20
> try...
> except OSError as e:
> =C2=A0=C2=A0=C2=A0 print(f"File error: {str(e)", file=3Dsys.stderr)
> except AutomataError as e:
> =C2=A0=C2=A0=C2=A0 print(f"Ill formed dot file: {str(e)", file=3Dstderr)
>=20

Yes! That's exactly what I mean, those are exceptions we expect, so no spla=
t,
all others can just propagate.

Thanks,
Gabriele

> > Thanks,
> > Gabriele
> >=20
> > > =C2=A0class Automata:
> > > =C2=A0=C2=A0=C2=A0=C2=A0 """Automata class: Reads a dot file and part=
 it as an automata.
> > > =C2=A0
> > > @@ -32,11 +39,11 @@ class Automata:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 basename =3D ntpath.=
basename(self.__dot_path)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not basename.ends=
with(".dot") and not
> > > basename.endswith(".gv"):
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 print("not a dot file")
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
aise Exception("not a dot file: %s" % self.__dot_path)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
aise AutomataError("not a dot file: %s" % self.__dot_path)
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 model_name =3D ntpat=
h.splitext(basename)[0]
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if model_name.__len_=
_() =3D=3D 0:
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
aise Exception("not a dot file: %s" % self.__dot_path)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
aise AutomataError("not a dot file: %s" % self.__dot_path)
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return model_name
> > > =C2=A0
> > > @@ -45,8 +52,8 @@ class Automata:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dot_lines =3D []
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 try:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 dot_file =3D open(self.__dot_path)
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 except:
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
aise Exception("Cannot open the file: %s" % self.__dot_path)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 except OSError as exc:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
aise AutomataError(f"Cannot open the file:
> > > {self.__dot_path}")
> > > from exc
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dot_lines =3D dot_fi=
le.read().splitlines()
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dot_file.close()
> > > @@ -55,7 +62,7 @@ class Automata:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 line =3D dot_lines[c=
ursor].split()
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (line[0] !=3D "di=
graph") and (line[1] !=3D "state_automaton"):
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
aise Exception("Not a valid .dot format: %s" %
> > > self.__dot_path)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
aise AutomataError("Not a valid .dot format: %s" %
> > > self.__dot_path)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 cursor +=3D 1
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return dot_lines
> > > diff --git a/tools/verification/rvgen/rvgen/dot2c.py
> > > b/tools/verification/rvgen/rvgen/dot2c.py
> > > index b9b6f14cc536a..1a1770e7f20c0 100644
> > > --- a/tools/verification/rvgen/rvgen/dot2c.py
> > > +++ b/tools/verification/rvgen/rvgen/dot2c.py
> > > @@ -13,7 +13,7 @@
> > > =C2=A0# For further information, see:
> > > =C2=A0#=C2=A0=C2=A0 Documentation/trace/rv/deterministic_automata.rst
> > > =C2=A0
> > > -from .automata import Automata
> > > +from .automata import Automata, AutomataError
> > > =C2=A0
> > > =C2=A0class Dot2c(Automata):
> > > =C2=A0=C2=A0=C2=A0=C2=A0 enum_suffix =3D ""
> > > @@ -93,7 +93,7 @@ class Dot2c(Automata):
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 min_type =3D "unsigned int"
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if self.states.__len=
__() > 1000000:
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
aise Exception("Too many states: %d" %
> > > self.states.__len__())
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
aise AutomataError("Too many states: %d" %
> > > self.states.__len__())
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return min_type
> > > =C2=A0
> > > diff --git a/tools/verification/rvgen/rvgen/generator.py
> > > b/tools/verification/rvgen/rvgen/generator.py
> > > index 3441385c11770..a7bee6b1ea70c 100644
> > > --- a/tools/verification/rvgen/rvgen/generator.py
> > > +++ b/tools/verification/rvgen/rvgen/generator.py
> > > @@ -51,10 +51,7 @@ class RVGenerator:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise FileNotFoundEr=
ror("Could not find the rv directory, do you
> > > have
> > > the kernel source installed?")
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0 def _read_file(self, path):
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 try:
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f=
d =3D open(path, 'r')
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 except OSError:
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
aise Exception("Cannot open the file: %s" % path)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fd =3D open(path, 'r')
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 content =3D fd.read(=
)
> > > =C2=A0
> > > @@ -65,7 +62,7 @@ class RVGenerator:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 try:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 path =3D os.path.join(self.abs_template_dir, file)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return self._read_file(path)
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 except Exception:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 except OSError:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 # Specific template file not found. Try the generic template
> > > file
> > > in the template/
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 # directory, which is one level up
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 path =3D os.path.join(self.abs_template_dir, "..", file)
> >=20

