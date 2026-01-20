Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AB83A1A5D
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 10:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768903542; cv=none; b=B+jZhjO3jEQpOIakF+CTQ2q10KjTtINu1HRYWcqJCe0HjFLzJ3BOf7vXy3xvg/2cyvIkZs6cFYF8RQ9Hk9zs0p7QO1odHJKwnwX5WB/BfBDQMruNJbkjZeFv3lxbNhluFitp0+ZTAWkJZkw2s+bAIc9sl1uvIOB7Z/icsqGO3oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768903542; c=relaxed/simple;
	bh=s9Db6hnd+tq7fewLpdNWptLw0uJIGOyxuVnvykQWJAs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ibWSVbcHW6sXYIPvih/YHvEdy9jL7uWz1Nl8ej06sgn/+OPkNO843iwDgduS/kazug/sHSpln7zVGuqO0wjksKltsdipcTOfvTfOO8mdiIW/D8Sial2Mdjmtl0zWJYxRb5/XDuNgLxGl2Z7MoNTJwzf55sxewJmSFPwE0/0RZFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ur6v2u8r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ur6v2u8r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768903538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=s9Db6hnd+tq7fewLpdNWptLw0uJIGOyxuVnvykQWJAs=;
	b=Ur6v2u8r6lP9op7uQJZR6sqxlWYw32mBaoUZHOq08hsTD4zdvg5oXB+2hcfV6z8vR/ytDR
	0XwJrmnxpuk9kwhF3mfFAhIDxglsRbgzOUyTKT1aI9P3amTqr4N2CTul4fPpNw9NhUREL7
	939IDa/WeEcMTEInrp1UPjIhPJsLKxU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-ilrlP6GRN-CvhJ_y098TMg-1; Tue, 20 Jan 2026 05:05:35 -0500
X-MC-Unique: ilrlP6GRN-CvhJ_y098TMg-1
X-Mimecast-MFC-AGG-ID: ilrlP6GRN-CvhJ_y098TMg_1768903534
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43102ac1da8so4356797f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Jan 2026 02:05:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768903534; x=1769508334;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s9Db6hnd+tq7fewLpdNWptLw0uJIGOyxuVnvykQWJAs=;
        b=KjqCzWWHY+jDtS7TBig3xjBicb+riswl6lRGOoMNCFVAa3ESftRmRSgP7L5Jvg0XTS
         /2zuP24P5MCQ9nNEGTa66GbUNT9Kw8PXQYgT9Oa6S1Xwd/E0l1kjrYWjZnAnzTEbg0xn
         tuqPe3sBJPsj13aC9qUtnhOotOQiY5MpX0Z8PHzk5n6nZH+1XuZcbRut27Z6+Yog3GrR
         V5QJE1jxGynB8v5lT+UPL9LemOx0nLD4n/QSwBpUfTC3CG00Gt21bwMFeGBhZpmIAgre
         pgyDlIdc5PHM1jYXCeKorLDEKPgjCFpc0NpeU9EviXnWNZbi0gXWeC/SbnFwKqeLZy2g
         v9Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUF7PXsEifwBjozfOnuCt50dHDfhvh4MDQDQ9R6CR77V9DL1fhlrfWyyK2fBbsWYnooCkBJBi+vGLS0CcPN1pEcB1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBgk0yBrkF629kF8R/cNPlSbUBr4sFC7+wVeOoKugZC1OnkXzl
	HaTS5A02bS3QBUdGd+U9A3guSWswkKC2KHE6I8ENMNB7p01PrsbbyZ44yI3WuMPOI0dQBIrtkDy
	el14eTbjulmyuUqfrJgUq1A2uCzTd710YctRNtucf/+EqP/+44PFBKiNPzyfJjFLWvzSwLaFDoA
	==
X-Gm-Gg: AZuq6aI/vuVfdKzkYcYcTdkdNi3FBE3shD4WhceiSv4YxWt9Fsvzemf7D06oGlo9AOC
	qGXYrLKJ97B19PxL1iQ2fxeSPBTu9TxD+4vLDTOyHtbro3gjZiGkrpUBaVtXCVtwqcmLYX0pH5I
	XtUB0JcyP/9Kbuh6a787bJ0Ye0R81a8lqERm/sgtJOj/ty1eg+IjPAXP1mqsToot0uVETkx/Fm5
	c4p9X5mk0gruLDLzjx7/+9SqblS/9+FyKxaqbfr7a7R0NtTObANfxvgGQIuuHCQM0ZUN+L5yE+Z
	XdbtT5IjCa8sJtP7nPr89xEMKDANg6vIJ3k8YzPt2/a+WdkODVBBCQ3nz/0FsTmpHxIYCYnMxHH
	Wnmym+dhSwsxWbLQ55UJjZTl90Rq6Bt+3ELiXwrxOw1kMM5zYKwH7aEiZ59GLUNH4DROl2LOQhT
	zQAMsFU6go
X-Received: by 2002:a05:6000:40cc:b0:432:8651:4070 with SMTP id ffacd0b85a97d-4358fed143dmr1830437f8f.10.1768903533856;
        Tue, 20 Jan 2026 02:05:33 -0800 (PST)
X-Received: by 2002:a05:6000:40cc:b0:432:8651:4070 with SMTP id ffacd0b85a97d-4358fed143dmr1830398f8f.10.1768903533296;
        Tue, 20 Jan 2026 02:05:33 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997ed8bsm28863121f8f.36.2026.01.20.02.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 02:05:33 -0800 (PST)
Message-ID: <a277296a5fcfdca0c744f01a59d68a8864ef5e8c.camel@redhat.com>
Subject: Re: [PATCH 02/26] rv/rvgen: remove bare except clauses in generator
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
 open list <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION
 (RV)"	 <linux-trace-kernel@vger.kernel.org>
Date: Tue, 20 Jan 2026 11:05:31 +0100
In-Reply-To: <20260119205601.105821-3-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
	 <20260119205601.105821-3-wander@redhat.com>
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
X-Mimecast-MFC-PROC-ID: F2GiasSc_hhROb6FTFC7N9c0pb2gf-H1mg8PmZSmZzw_1768903534
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-01-19 at 17:45 -0300, Wander Lairson Costa wrote:
> Remove bare except clauses from the generator module that were
> catching all exceptions including KeyboardInterrupt and SystemExit.
> This follows the same exception handling improvements made in the
> previous AutomataError commit and addresses PEP 8 violations.
>=20
> The bare except clause in __create_directory was silently catching
> and ignoring all errors after printing a message, which could mask
> serious issues. For __write_file, the bare except created a critical
> bug where the file variable could remain undefined if open() failed,
> causing a NameError when attempting to write to or close the file.
>=20
> These methods now let OSError propagate naturally, allowing callers
> to handle file system errors appropriately. This provides clearer
> error reporting and allows Python's exception handling to show
> complete stack traces with proper error types and locations.
>=20
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>

Looks good to me, thanks!

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

> ---
> =C2=A0tools/verification/rvgen/rvgen/generator.py | 9 +--------
> =C2=A01 file changed, 1 insertion(+), 8 deletions(-)
>=20
> diff --git a/tools/verification/rvgen/rvgen/generator.py
> b/tools/verification/rvgen/rvgen/generator.py
> index a7bee6b1ea70c..af1662e2c20a7 100644
> --- a/tools/verification/rvgen/rvgen/generator.py
> +++ b/tools/verification/rvgen/rvgen/generator.py
> @@ -198,17 +198,10 @@ obj-$(CONFIG_RV_MON_%s) +=3D monitors/%s/%s.o
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
os.mkdir(path)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 except FileExistsError:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
return
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 except:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print=
("Fail creating the output dir: %s" % self.name)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 def __write_file(self, file_name, content):
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 try:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file =
=3D open(file_name, 'w')
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 except:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print=
("Fail writing to file: %s" % file_name)
> -
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file =3D open(file_name, 'w')
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file.write(content)
> -
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file.close()
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 def _create_file(self, file_name, content):

