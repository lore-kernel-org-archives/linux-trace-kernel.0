Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15023A7F40
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Feb 2026 12:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770293339; cv=none; b=nGGnIveG/xAjKj8VdJF7CG5eJ4CfaCsGf/URQKpUymKFn6Kj0HDOtOBSdu0cG6ENf1iUhpgZMxjRrovK4BkpSYTC7ACK5Eaq5ZGD05lrC1gEvy7QgatlbXIgpXV4wtR1TbWvu/Ja2u6vRHHGxZU7w/9xRGoYcRnnHpxnGzY/ltU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770293339; c=relaxed/simple;
	bh=lF+ifxsI9p1x7q6u88VjzIf4sGXCH1orLW5RIRRZ7nw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X943alSnuk+N7uk22fQt5Vz5IAxMSZLqyLc8NwaLu1sXXRFXvD31O/g+Tv+/z7nTKH/ztJwXamhKfL4lvbS1aS0FsFJBBy2n6FrGmOYNwLpBK298bh2XVUSjPY398SWFPU83zZttsJWGQp88r0Xb2qrozg/BDAJCIJ+mGchqqfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e1amls6t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e1amls6t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770293337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lF+ifxsI9p1x7q6u88VjzIf4sGXCH1orLW5RIRRZ7nw=;
	b=e1amls6tfsUp39+CNrXrXeJm0BrF/TuyZ0UJGZlI8+0QI7CTStyjhbq8t6H9jr2YNBUcVA
	GASNoq2Xj/PSluEG8Fkw0zsiH7gBIa9qE0KTwnFzRAwaYX/Vg05v8khujqlmtwgDrJyQhu
	P2D5WLnmkTBhQnNrfVDO7TUSvrO0sTE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-0OwPfRN-PX-OYHXiflVS4g-1; Thu, 05 Feb 2026 07:08:44 -0500
X-MC-Unique: 0OwPfRN-PX-OYHXiflVS4g-1
X-Mimecast-MFC-AGG-ID: 0OwPfRN-PX-OYHXiflVS4g_1770293324
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-435a11575ecso861187f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Feb 2026 04:08:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770293323; x=1770898123;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lF+ifxsI9p1x7q6u88VjzIf4sGXCH1orLW5RIRRZ7nw=;
        b=IDPVthCKNELPcmEuEFqJXcWhD8I62GQYgJsJRJCRIP7m8x+6HsS/+iIHff6TKYMoYd
         VnCUBTeyUYCQW5Ss1fD7QA3+MeWH3mcdXlZSlWKRFNfuGkDU+lvJ+75achG6hpOhfB5g
         U9U3ToJsHkuBMOUx9qtGZZd9b8WjDMH5qAPmbYfnnqXLPTk82zbpyZv5kfKNnzOhvIUw
         LcyNAgCJfBWA36mFhaOlvT6MxjjQhgjUzettf3LTmJxGnKs15Fd3I58hGjU7NCGoAhfL
         3zTYFZK21E9W+eE2PztjsmwZkqCxNrSryEBlL5vvsQVP9QNjS5ju+BgkPDrPFeWrsMLU
         wFQA==
X-Forwarded-Encrypted: i=1; AJvYcCVSR4YzUB8kDg2K94jR939+f8Jhg9c4oV9PqMAGQtEpwlQtHBcSAKlm3OOCIGef/M2rYhFL63Lz1Esr2Nyn4xQ9FM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEI4rQ5PJuDKimFvLR5ZlkQRgi50ETQ1RRy9ANt7aAUAlrA65Z
	r/mca7Wc5KtuYQc7rJgfrqSVYOdNG6JqZYuFJCR6TDRp2ZXKUFZNk/YfJYG6Ht22wovfCEBbxTB
	TMGL+USALSbVyz3u+C0G/ut6NoDFjou+CN7ikRDbaMjxmWwbHcnx/PX2uCnuNKY99SEqL7i8bew
	==
X-Gm-Gg: AZuq6aIUxpDpP77YZW1wheJMcTnN8G5ifO41C6TtHUcE1iQwvjV4l2fR9PQ4uRt3ril
	QJrWFG7CXXtcO46XIoQ6QuwwFqmRMofiNC+4D44RY0E06kCp/qOYH0iGhCL8LBGVM/XOL7M3dRf
	FEIzl9Mm0m2Je9yff7vcCToaVRnVt/0G0Uto3EVyGchkZBfRHz8et3Brs6tp/JiCdIb+9tcWsnS
	xcvwMv0DDvcprJ4PX/NP9n8JASduRLkRK240LkXpb1Tvmr+4gQN8ilrmChCle1NpUOdFlocsWIb
	/QuDTrFP7XCppGzochQ9ppqta60h92REDoezSGpjEnN2o7BWT2QTp9m+eNLqjoWiYD98H4C4fK9
	EgG87OjOHk8OmmxRtDmJzI41a9CiCc4+Qpdc2Ggy7OY1tHTN1xhWP78J0pOYNWR6KPLOo6YUF3a
	ilbWJ230Ve
X-Received: by 2002:a05:6000:40c8:b0:430:ff8b:fdc2 with SMTP id ffacd0b85a97d-4361805fc02mr9780058f8f.60.1770293323504;
        Thu, 05 Feb 2026 04:08:43 -0800 (PST)
X-Received: by 2002:a05:6000:40c8:b0:430:ff8b:fdc2 with SMTP id ffacd0b85a97d-4361805fc02mr9780022f8f.60.1770293323075;
        Thu, 05 Feb 2026 04:08:43 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617e3a546sm15995841f8f.17.2026.02.05.04.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 04:08:42 -0800 (PST)
Message-ID: <ff532aaa9f97f474c21417401654bba73e30c988.camel@redhat.com>
Subject: Re: [PATCH v2 01/20] rv/rvgen: introduce AutomataError exception
 class
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
 "open list:RUNTIME VERIFICATION (RV)"	
 <linux-trace-kernel@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Date: Thu, 05 Feb 2026 13:08:41 +0100
In-Reply-To: <20260204144914.104028-2-wander@redhat.com>
References: <20260204144914.104028-1-wander@redhat.com>
	 <20260204144914.104028-2-wander@redhat.com>
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
X-Mimecast-MFC-PROC-ID: oKJGEEX9ubHIx6-GKm8BiQSfsdxqKihdlyO7jgOvwEI_1770293324
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-02-04 at 11:42 -0300, Wander Lairson Costa wrote:
> Replace the generic except Exception block with a custom AutomataError
> class that inherits from Exception. This provides more precise exception
> handling for automata parsing and validation errors while avoiding
> overly broad exception catches that could mask programming errors like
> SyntaxError or TypeError.
>=20
> The AutomataError class is raised when DOT file processing fails due to
> invalid format, I/O errors, or malformed automaton definitions. The
> main entry point catches this specific exception and provides a
> user-friendly error message to stderr before exiting.
>=20
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
[...]
> ---
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
>=20

You probably don't want to mask all OSError in main.py and allow only this =
one.
I think it's alright to=C2=A0keep a simpler message for wrong model file (a=
lso LTL!),
while throwing a splat in other cases (e.g. missing templates).

But wouldn't it be better to show the error message of the OSError? 99% of =
the
time it's going to be ENOENT, but could also be some EPERM or who knows wha=
t.
I'm fine keeping AutomataError here but would at least propagate the error
message.

Or keep it simple and catch all OSError as well, this one included.

Thanks,
Gabriele

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
> index 06a26bf15a7e9..74147ae2942f9 100644
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
> @@ -71,7 +71,7 @@ class Dot2c(Automata):
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

