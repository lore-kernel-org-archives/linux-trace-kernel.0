Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F67C3A0E94
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 07:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768894399; cv=none; b=Q0Rgd6F/vRu6tuuefBCXxFL5z+lsgxAnRazD1b9BndpVKKXVRdjq0uMkgDCde6umOH0q0D22C7CPOX+9Ra+YeLtTkTLIh6ctnE6mvcgfvxNJfYGjzeC6qGjPcccGFKw84duV5KLH36LztPHIV3SmF5cUo+0Gml38C0wdLyiFQ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768894399; c=relaxed/simple;
	bh=Xv+nfey/sbanLOZ8/OEiohWzkP4B3iWQQjkmu1gYWpQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s8dcufZd4rQ84plQNtJJDTwfb6inrScUuaSku5rb9IP3JYI2Uw8m2lkrrelu18kyY21+hMWyk42woa0evTtmzyepmKA11jHK0q/KjzMNw4NrVUAf3tCQrUFb/EfYg2wBJl0qf1I7CvWyfFg47S8Nalt+UsYUo40BHqP3Tvq8UyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jIfRrODT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jIfRrODT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768894395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Xv+nfey/sbanLOZ8/OEiohWzkP4B3iWQQjkmu1gYWpQ=;
	b=jIfRrODTK3KypmVJV/8QMWPcqpQElLNeFESFgDwxNAXI7HlwYZ+bWn5E6AAdR1CpuhkYoJ
	gNRAKbLd7dIOVOsg2lOw5a//X4KGdERJOwdJEMHfzI35mhhCDmGbhaShkKrY0qAV9bBAOZ
	6zVvxdCVI8/oM0HaFoa9jW4gO1Mt5ho=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-NzjzRk5_PPaVQ6oox3iCiw-1; Tue, 20 Jan 2026 02:33:13 -0500
X-MC-Unique: NzjzRk5_PPaVQ6oox3iCiw-1
X-Mimecast-MFC-AGG-ID: NzjzRk5_PPaVQ6oox3iCiw_1768894393
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-430f5dcd4cdso2814933f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Jan 2026 23:33:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768894392; x=1769499192;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xv+nfey/sbanLOZ8/OEiohWzkP4B3iWQQjkmu1gYWpQ=;
        b=uALjWKnS+KZ5mx49NbP2I/Hd6Dru6zweOOaebzJsHqOESg9Te3nxxL+3G456pUWYpb
         Bpi1yYolIQHX7ilqo26GF+bfoyRnFPJl7DnIhxa/idTKCo4aphht1/Silc2fPrCGFoLN
         d0ItcObIV4xQcIhMOfO34prUIK4jekdGl/pagNqYh6AGbC3bmk9EaNrOXbfjl5rgIHnB
         YVYIhyRVa1uGASq7GQPtx61os6LJvgKv8bxb5ZwIqFWoYVJJvbGJHpuYviZbF+68136t
         5jA+Q3pP4R7IaqIJBZ+yQf86CzKchXuiLBinifc1nj6EIfzBTvh+8QYDGAblK8SfyQ2R
         Y/7w==
X-Forwarded-Encrypted: i=1; AJvYcCXFr/DAI1z6+sg5egS3J8+A5o7l5hp/PkhYnS23A6WFPkTzs6bO0djgHtdp1QqJ1EMR87x7PYwKBa6uKz0Fbj9QjhM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3fiDg0s0nWu7AnUA1VdmU0M93hu07LaXP+0fFItFXDIBCrcW/
	seRL487jQVDXHxb9D8BNqLhYDUfnxXeEtdFlysdOd8gD7tLyogBOrK6gQCfw96m81cGXN4dfGMJ
	7iEIWwNl1dMCkmBJOzalAuW7X9/i2YqsWuD+/3aZ9EZHLMAjuBU+IzwUfTMcElwK1YgDTzCaMiA
	==
X-Gm-Gg: AZuq6aKC1FHFaCPl2x46f7E0+GpisdKrgCvqYhSx9ERdPRW0N0DIXlKIAEYmEzFyxLK
	F+lF/qp6nU7baHm9VZFIDADPb21fTOUndybJ8/snrjcuCXnRX05RYXZtjx9UpADJWIogdaQBQYW
	r5aCq49jW61q8gnjszUTQeKfZYP7/jcmIVXTFEfTS15ilUTEESyT6/d6fWa0tWSCZ8X1eAwG2SV
	8iJUqik8uQbNDyVN1G9dzANSD1iv488a/UaPSclivlGi+c7YVfQ0fWKxCqz6l+QKAdwL2eIf+Zx
	tew8TShIgx469Y1kET/uWE/NoOFSEmDl5Qs8WEo4Rk8j0FLWu61LxNO1LZoAy9JmxkRdVlblyO/
	sBSyy8zDJfjfJcPVzABcov6bPR6YcSxGfbXUfZ6fqI12oDiKFOCl2gC8yTuivxZuj0ePwyuq7ag
	csKdVTbUn6
X-Received: by 2002:a5d:5d03:0:b0:431:a50:6ead with SMTP id ffacd0b85a97d-4356a02c4e5mr16395251f8f.20.1768894392541;
        Mon, 19 Jan 2026 23:33:12 -0800 (PST)
X-Received: by 2002:a5d:5d03:0:b0:431:a50:6ead with SMTP id ffacd0b85a97d-4356a02c4e5mr16395216f8f.20.1768894392053;
        Mon, 19 Jan 2026 23:33:12 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356996dadbsm27603648f8f.21.2026.01.19.23.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 23:33:11 -0800 (PST)
Message-ID: <24e308b019cf9272884091f85b6675fd05201a2b.camel@redhat.com>
Subject: Re: [PATCH 01/26] rv/rvgen: introduce AutomataError exception class
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>, Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, open list
	 <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION (RV)"
	 <linux-trace-kernel@vger.kernel.org>
Date: Tue, 20 Jan 2026 08:33:10 +0100
In-Reply-To: <20260119205601.105821-2-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
	 <20260119205601.105821-2-wander@redhat.com>
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
X-Mimecast-MFC-PROC-ID: WGiwncNNUmQRwIIHXT02Wg-E4Su0psHQIi2ylEAbWso_1768894393
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-01-19 at 17:45 -0300, Wander Lairson Costa wrote:
> Replace generic Exception usage with a custom AutomataError class
> that inherits from OSError throughout the rvgen tool. This change
> provides more precise exception handling for automata parsing and
> validation errors while avoiding overly broad exception catches that
> could mask programming errors like SyntaxError or TypeError.
>=20
> The AutomataError class inherits from OSError rather than Exception
> because most error conditions involve file I/O operations such as
> reading DOT files or handling file access issues. This semantic
> alignment makes exception handling more specific and appropriate.
> The exception is raised when DOT file processing fails due to invalid
> format, I/O errors, or malformed automaton definitions.
>=20
> Additionally, remove the broad try-except block from __main__.py that
> was catching all exceptions. This allows Python's default exception
> handling to provide complete stack traces, making debugging
> significantly easier by showing exact error types and locations.
>=20
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>

Thanks for the extensive series!
See my comments below.
Mind that I likely know python less than you do, so just call me out when I
start babbling.

> ---
> =C2=A0tools/verification/rvgen/__main__.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 25 +++++++++------------
> =C2=A0tools/verification/rvgen/rvgen/automata.py=C2=A0 | 17 +++++++++----=
-
> =C2=A0tools/verification/rvgen/rvgen/dot2c.py=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 4 ++--
> =C2=A0tools/verification/rvgen/rvgen/generator.py |=C2=A0 7 ++----
> =C2=A04 files changed, 26 insertions(+), 27 deletions(-)
>=20
> diff --git a/tools/verification/rvgen/__main__.py
> b/tools/verification/rvgen/__main__.py
> index fa6fc1f4de2f7..768b11a1e978b 100644
> --- a/tools/verification/rvgen/__main__.py
> +++ b/tools/verification/rvgen/__main__.py
> @@ -39,22 +39,17 @@ if __name__ =3D=3D '__main__':
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 params =3D parser.parse_args()
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 try:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if params.subcmd =3D=3D "moni=
tor":
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print=
("Opening and parsing the specification file %s" %
> params.spec)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if pa=
rams.monitor_class =3D=3D "da":
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 monitor =3D dot2k(params.spec, params.monitor_type,
> vars(params))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 elif =
params.monitor_class =3D=3D "ltl":
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 monitor =3D ltl2k(params.spec, params.monitor_type,
> vars(params))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 print("Unknown monitor class:", params.monitor_class)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 sys.exit(1)
> +=C2=A0=C2=A0=C2=A0 if params.subcmd =3D=3D "monitor":
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print("Opening and parsing th=
e specification file %s" % params.spec)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if params.monitor_class =3D=
=3D "da":
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 monit=
or =3D dot2k(params.spec, params.monitor_type, vars(params))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 elif params.monitor_class =3D=
=3D "ltl":
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 monit=
or =3D ltl2k(params.spec, params.monitor_type, vars(params))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 monit=
or =3D Container(vars(params))
> -=C2=A0=C2=A0=C2=A0 except Exception as e:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print('Error: '+ str(e))
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print("Sorry : :-(")
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sys.exit(1)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print=
("Unknown monitor class:", params.monitor_class)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sys.e=
xit(1)
> +=C2=A0=C2=A0=C2=A0 else:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 monitor =3D Container(vars(pa=
rams))
> =C2=A0

I agree catching all exceptions like this is quite detrimental while debugg=
ing,
but I see the original intent.
When you run commands written in python, you normally don't expect them to =
blurt
a stack trace when doing relatively normal things, like opening a wrong fil=
e.
Sure that might be useful when debugging, but for a user-facing tool we wan=
t to
write a meaningful error message and gracefully fail.

Other story is when the exception is something unexpected (that's why leavi=
ng a
generic Exception here is bad).

> =C2=A0=C2=A0=C2=A0=C2=A0 print("Writing the monitor into the directory %s=
" % monitor.name)
> =C2=A0=C2=A0=C2=A0=C2=A0 monitor.print_files()
> diff --git a/tools/verification/rvgen/rvgen/automata.py
> b/tools/verification/rvgen/rvgen/automata.py
> index d9a3fe2b74bf2..8d88c3b65d00d 100644
> --- a/tools/verification/rvgen/rvgen/automata.py
> +++ b/tools/verification/rvgen/rvgen/automata.py
> @@ -10,6 +10,13 @@
> =C2=A0
> =C2=A0import ntpath
> =C2=A0
> +class AutomataError(OSError):
> +=C2=A0=C2=A0=C2=A0 """Exception raised for errors in automata parsing an=
d validation.
> +
> +=C2=A0=C2=A0=C2=A0 Raised when DOT file processing fails due to invalid =
format, I/O errors,
> +=C2=A0=C2=A0=C2=A0 or malformed automaton definitions.
> +=C2=A0=C2=A0=C2=A0 """
> +

I'm not quite familiar with modern python best practices (so again, take my
comments with a grain of salt ;) ), but what is the advantage of using this
custom exception instead of using pre-existing specific exception types?

Although the difference is minimal, here you're throwing an OSError for
something that quite isn't (e.g. wrong format for the dot file).
A ValueError feels more appropriate to me in most of the instances here.

All in all, I would do something like:
* throw a ValueError (or a custom one based on that) whenever we expect wro=
ng
data not dependent on OS features
* throw OSError whenever that was the exception, perhaps changing the messa=
ge to
something more meaningful to us (like you're already doing here)
* intercept only those errors in main.py and print the message without stac=
k
trace (if the message is clear enough we shouldn't need it).

Does it make sense to you?

Thanks,
Gabriele

> =C2=A0class Automata:
> =C2=A0=C2=A0=C2=A0=C2=A0 """Automata class: Reads a dot file and part it =
as an automata.
> =C2=A0
> @@ -32,11 +39,11 @@ class Automata:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 basename =3D ntpath.base=
name(self.__dot_path)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not basename.endswith=
(".dot") and not basename.endswith(".gv"):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
print("not a dot file")
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise=
 Exception("not a dot file: %s" % self.__dot_path)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise=
 AutomataError("not a dot file: %s" % self.__dot_path)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 model_name =3D ntpath.sp=
litext(basename)[0]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if model_name.__len__() =
=3D=3D 0:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise=
 Exception("not a dot file: %s" % self.__dot_path)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise=
 AutomataError("not a dot file: %s" % self.__dot_path)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return model_name
> =C2=A0
> @@ -45,8 +52,8 @@ class Automata:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dot_lines =3D []
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 try:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
dot_file =3D open(self.__dot_path)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 except:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise=
 Exception("Cannot open the file: %s" % self.__dot_path)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 except OSError as exc:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise=
 AutomataError(f"Cannot open the file: {self.__dot_path}")
> from exc
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dot_lines =3D dot_file.r=
ead().splitlines()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dot_file.close()
> @@ -55,7 +62,7 @@ class Automata:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 line =3D dot_lines[curso=
r].split()
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (line[0] !=3D "digrap=
h") and (line[1] !=3D "state_automaton"):
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise=
 Exception("Not a valid .dot format: %s" % self.__dot_path)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise=
 AutomataError("Not a valid .dot format: %s" %
> self.__dot_path)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
cursor +=3D 1
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return dot_lines
> diff --git a/tools/verification/rvgen/rvgen/dot2c.py
> b/tools/verification/rvgen/rvgen/dot2c.py
> index b9b6f14cc536a..1a1770e7f20c0 100644
> --- a/tools/verification/rvgen/rvgen/dot2c.py
> +++ b/tools/verification/rvgen/rvgen/dot2c.py
> @@ -13,7 +13,7 @@
> =C2=A0# For further information, see:
> =C2=A0#=C2=A0=C2=A0 Documentation/trace/rv/deterministic_automata.rst
> =C2=A0
> -from .automata import Automata
> +from .automata import Automata, AutomataError
> =C2=A0
> =C2=A0class Dot2c(Automata):
> =C2=A0=C2=A0=C2=A0=C2=A0 enum_suffix =3D ""
> @@ -93,7 +93,7 @@ class Dot2c(Automata):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
min_type =3D "unsigned int"
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if self.states.__len__()=
 > 1000000:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise=
 Exception("Too many states: %d" % self.states.__len__())
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise=
 AutomataError("Too many states: %d" %
> self.states.__len__())
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return min_type
> =C2=A0
> diff --git a/tools/verification/rvgen/rvgen/generator.py
> b/tools/verification/rvgen/rvgen/generator.py
> index 3441385c11770..a7bee6b1ea70c 100644
> --- a/tools/verification/rvgen/rvgen/generator.py
> +++ b/tools/verification/rvgen/rvgen/generator.py
> @@ -51,10 +51,7 @@ class RVGenerator:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise FileNotFoundError(=
"Could not find the rv directory, do you have
> the kernel source installed?")
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 def _read_file(self, path):
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 try:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fd =
=3D open(path, 'r')
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 except OSError:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise=
 Exception("Cannot open the file: %s" % path)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fd =3D open(path, 'r')
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 content =3D fd.read()
> =C2=A0
> @@ -65,7 +62,7 @@ class RVGenerator:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 try:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
path =3D os.path.join(self.abs_template_dir, file)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
return self._read_file(path)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 except Exception:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 except OSError:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
# Specific template file not found. Try the generic template file
> in the template/
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
# directory, which is one level up
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
path =3D os.path.join(self.abs_template_dir, "..", file)

