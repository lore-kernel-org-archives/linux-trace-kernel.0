Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F2636AB77
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Feb 2026 23:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770073561; cv=pass; b=WylbyRO3b6SrLcyj/KFjtTR7JR+i/JO0RjKIkGs1+yhaISy69Dkx069jGlShOovvW5/tDiYh0v04aH/eTo1ISMpcjrjlp9ruvqEkQWslsbPlgQ+yh3nLeh3uICNa6p9j8eegTHsuDdz10CY6iQvsPWY0EOf1QNRvqXq4BklYr4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770073561; c=relaxed/simple;
	bh=e55rtiTYanS4YjLKxss9VH2FSyU7ZTZdynNXLBTp29Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Noarqnsuqdon3jljG55HE8xT4NNECbsQCzY+E6RH7SVaZAY1whqNNtymGDtqsXEZqhfvCb2gB0JtHvBaRnnk9AqjumCXNx7GXNSGpZmzVAt9iYXPx0W/44GxtIqojei3sMgV/U9d7rNXwae+5jdaloeSJsOmQPxNQdgYGfsQsDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WXSJTwBc; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WXSJTwBc"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50299648ae9so83081cf.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Feb 2026 15:05:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770073558; cv=none;
        d=google.com; s=arc-20240605;
        b=ASN/na/yT1g7kCbDypsRTbFOehe4waXTUEuWv58DQAiMnf9HNR600PuKzEn2ysG8f0
         8B6J697J39dnMYZ6Hz6mKb9rpwosfmoUUZ4ecHLY+MnqYqpJaJcYtOIF1GOf2HBCw8gE
         LDD0tAF/a01zDg86d3KdIhY5kx3X48kGYs+4NBSdtXL/m3cH90U8k/5ix9kBhlab02GO
         7cZ1756gQhHUgGBuvBm2k7+7hce/2VIka1OxusM1u+DP140K14hv9N/QrCrhbXVQM8Iv
         v5Ms+kLDOAczYyLf4s+lkpkO2h8hmo4i1vjbkZ3P0/JACEZOq9gysbHM/eM1E7YnxlIF
         QtEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=eGZ+Ja4rYwhOdeYm42Ruf/29iYZGTr/utUliEYlJ8EA=;
        fh=ssVEm/wmI0zngzKmG051zu7lxtfSevRFsopHwMtsjR4=;
        b=BBHkhiZ3fyp55zt8zIDHMpOlbrcrSaKNFvXD661ldzS69fq0soelZ483UCWZWuo1Kb
         X/f4IyzOUmbcW7U9oqSAZyFboQ+CnHhVpjg3u3r8Zy0MD3CAlgQ7BrqyxeVdoWqo/6rZ
         52+NA60hNafdTGUsMh6ONmeN9KcmzRgsDurGhn7FT2jHeDqhvicEurIhowl9EJ496TNO
         rN90dvnGSGOwG5ZouRqW53zDM76F0u1Eu3r83zWQ6TIORKh4YArMO1w8kRD41hg7W/ZG
         Z/MR7pEuvYKx7fKG5f1SZFTv9pokaGyH9rU6vy8g2r6S8MXmvCY4aUK8W0syPLNdwhg5
         m+GA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770073558; x=1770678358; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eGZ+Ja4rYwhOdeYm42Ruf/29iYZGTr/utUliEYlJ8EA=;
        b=WXSJTwBcvTOrTiGn8Z49Ihs7IsL4SHQHOqllkIQo/9z1HrimJR9Uk1tzWMq8aAStb7
         V00Cr5B8AbMHK4z9D+a4WTTHKQ/26vVLftfNGDJ2ZOlA/XMYOBlGlHkM3DGc207kBxpv
         7zEg79eiPQY89tj+dNfCpHSA5z0/rmbFT3f8OPtgzhBQbg+bEpsWo0csvmGtrkaUAiTX
         wvXuGCnin8RKlNWEMBk1lhYIR1BVa0hSQXMe6NOuIDgbgBuohJ4GjJmfaewC3gLLnlK8
         Di5Ye1Owc81sWJkJgFv4V0aaITHzNBA25NTsn/kQZNoj/wKqxrdO3PRMwqVT/K6QrJ45
         5zHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770073558; x=1770678358;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGZ+Ja4rYwhOdeYm42Ruf/29iYZGTr/utUliEYlJ8EA=;
        b=Bs5LsX35FxnXTwclPEQkgDuPlRfkWDXvJS498jOxdDn/uc/fkRbEfBDU9r8mGemJVC
         yOuBKvd4RAxkYVZ30QrSRCe5TUBgWVYGApxTOnIJ5iXTRx6dXNofYxiqGb2mKtAbU5lq
         BZ9udh/DT4NOGhW47uUDE2u+wLh/k7omgRQ5T+4xpy6W59yImW8qOqSQwsu7orZaO390
         2q2anreJYeC/7DDGdn6ZNIVEGgMRaKFaUVXcArgNW26hMi13x2V59J+oLNs+VkwIWQsY
         PqM1b/V9s/ay/yUt/DZsjcSyRvySzioQKw7d9yMTqDTBUyuJk92fbzlwdLV9tBGBjKoL
         dGhg==
X-Forwarded-Encrypted: i=1; AJvYcCXgpp3HqQ2sld3ih8X17/xDU/HZ585qNtO1rJWx/WkDS1irreJN2KGm6uoAiZPwJJV1sPEk90NqzFs1lfhtOm7jBWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXnD245psvuT20Zy9SZw8T4URbmfaX3pUxKbDJdIdjr7q4QPyr
	NCMHl1AufTCsGxNiI1SJ2B98buEe96so7sVBsaezS4pzSZ2PB0OCvCe+QYeiRbd3xAvAlCU3CvK
	WqYFg4sAx3oJOSCo2Xg5jAaLqE7eSlXlFvoIs/awAqXmFUV9R/QP7OA==
X-Gm-Gg: AZuq6aKzcQBuSeRfVnDIjth4OV6okGEwCGKu/U7KqyaQSfnvZQkuAQViXioc2DcV/ZB
	4CBRJ5QrYv0fhGTYu7JWaMrZZ/KwA6uKZzGkxukBz+l+YSsPO6yLMZFCK+/SqOoNZ8YKXjN7z/K
	niysxBBBi4WGROfVxmf7UJQEMSOWjWj3kkwDTitnI9rO7CZtBdQ00O34aJTfOKXTXzSSGUyvlmI
	DpWkHuspYsbUX9DwoDG8KAgqvBN85iGy0PTmADkSsYw4JxXuJJTG73sOGuBhPQa0G3F
X-Received: by 2002:ac8:7fcf:0:b0:4ff:cb25:998b with SMTP id
 d75a77b69052e-5060a22d229mr3522541cf.12.1770073557819; Mon, 02 Feb 2026
 15:05:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176974810577.124104.16012554973099890517.stgit@devnote2>
 <20260130095331.5c9f754e@gandalf.local.home> <CAODwPW90ALuMy6kFPqQSj_vN7krRz6cpksAUm2WHJNYwRNxHnA@mail.gmail.com>
 <20260131111951.99058146c69f2a729f7be643@kernel.org>
In-Reply-To: <20260131111951.99058146c69f2a729f7be643@kernel.org>
From: Julius Werner <jwerner@google.com>
Date: Mon, 2 Feb 2026 15:05:45 -0800
X-Gm-Features: AZwV_Qg-Ryz6YIg2qcJpuCrzK9JSg6xv1hQw3NElC24JtUI2Zz898svBgflBEP8
Message-ID: <CAODwPW8A1B8hi4L3e9kO5p2HBMLfCvHuaENZNWQWqYv9uSLMsg@mail.gmail.com>
Subject: Re: [PATCH] bootconfig: Fix to terminate value search if it hits a newline
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ae4d480649df5dcf"

--000000000000ae4d480649df5dcf
Content-Type: text/plain; charset="UTF-8"

> > This seems inconsistent to me tbh. I think someone could reasonably
> > write a bootconfig like this:
> >
> > foo =                  # We leave foo empty here because <reason>
> > bar = value
> >
> > and expect it to work. There's nothing in the documentation that
> > suggests empty values would behave differently if there is a comment
> > behind them.
>
> But we already accept that example in the tree.
>
>   tools/bootconfig/samples/good-array-space-comment.bconf
>
> So it is hard to change this syntax. But without comment, the
> document defines the value is terminated with a newline. Thus
> it needs to be fixed.

Hmm... okay. I think it would be good to add an example like this
(without array) to admin-guide/bootconfig.rst. It isn't very clear to
me that the comment "negates" the following newline in the way it is
written right now.

--000000000000ae4d480649df5dcf
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUmwYJKoZIhvcNAQcCoIIUjDCCFIgCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghICMIIGkTCCBHmgAwIBAgIQfofDAVIq0iZG5Ok+mZCT2TANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNDdaFw0zMjA0MTkwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFI2IFNNSU1FIENBIDIwMjMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDYydcdmKyg
4IBqVjT4XMf6SR2Ix+1ChW2efX6LpapgGIl63csmTdJQw8EcbwU9C691spkltzTASK2Ayi4aeosB
mk63SPrdVjJNNTkSbTowej3xVVGnYwAjZ6/qcrIgRUNtd/mbtG7j9W80JoP6o2Szu6/mdjb/yxRM
KaCDlloE9vID2jSNB5qOGkKKvN0x6I5e/B1Y6tidYDHemkW4Qv9mfE3xtDAoe5ygUvKA4KHQTOIy
VQEFpd/ZAu1yvrEeA/egkcmdJs6o47sxfo9p/fGNsLm/TOOZg5aj5RHJbZlc0zQ3yZt1wh+NEe3x
ewU5ZoFnETCjjTKz16eJ5RE21EmnCtLb3kU1s+t/L0RUU3XUAzMeBVYBEsEmNnbo1UiiuwUZBWiJ
vMBxd9LeIodDzz3ULIN5Q84oYBOeWGI2ILvplRe9Fx/WBjHhl9rJgAXs2h9dAMVeEYIYkvW+9mpt
BIU9cXUiO0bky1lumSRRg11fOgRzIJQsphStaOq5OPTb3pBiNpwWvYpvv5kCG2X58GfdR8SWA+fm
OLXHcb5lRljrS4rT9MROG/QkZgNtoFLBo/r7qANrtlyAwPx5zPsQSwG9r8SFdgMTHnA2eWCZPOmN
1Tt4xU4v9mQIHNqQBuNJLjlxvalUOdTRgw21OJAFt6Ncx5j/20Qw9FECnP+B3EPVmQIDAQABo4IB
ZTCCAWEwDgYDVR0PAQH/BAQDAgGGMDMGA1UdJQQsMCoGCCsGAQUFBwMCBggrBgEFBQcDBAYJKwYB
BAGCNxUGBgkrBgEEAYI3FQUwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUM7q+o9Q5TSoZ
18hmkmiB/cHGycYwHwYDVR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwewYIKwYBBQUHAQEE
bzBtMC4GCCsGAQUFBzABhiJodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vcm9vdHI2MDsGCCsG
AQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9yb290LXI2LmNydDA2
BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QtcjYuY3JsMBEG
A1UdIAQKMAgwBgYEVR0gADANBgkqhkiG9w0BAQwFAAOCAgEAVc4mpSLg9A6QpSq1JNO6tURZ4rBI
MkwhqdLrEsKs8z40RyxMURo+B2ZljZmFLcEVxyNt7zwpZ2IDfk4URESmfDTiy95jf856Hcwzdxfy
jdwx0k7n4/0WK9ElybN4J95sgeGRcqd4pji6171bREVt0UlHrIRkftIMFK1bzU0dgpgLMu+ykJSE
0Bog41D9T6Swl2RTuKYYO4UAl9nSjWN6CVP8rZQotJv8Kl2llpe83n6ULzNfe2QT67IB5sJdsrNk
jIxSwaWjOUNddWvCk/b5qsVUROOuctPyYnAFTU5KY5qhyuiFTvvVlOMArFkStNlVKIufop5EQh6p
jqDGT6rp4ANDoEWbHKd4mwrMtvrh51/8UzaJrLzj3GjdkJ/sPWkDbn+AIt6lrO8hbYSD8L7RQDqK
C28FheVr4ynpkrWkT7Rl6npWhyumaCbjR+8bo9gs7rto9SPDhWhgPSR9R1//WF3mdHt8SKERhvtd
NFkE3zf36V9Vnu0EO1ay2n5imrOfLkOVF3vtAjleJnesM/R7v5tMS0tWoIr39KaQNURwI//WVuR+
zjqIQVx5s7Ta1GgEL56z0C5GJoNE1LvGXnQDyvDO6QeJVThFNgwkossyvmMAaPOJYnYCrYXiXXle
A6TpL63Gu8foNftUO0T83JbV/e6J8iCOnGZwZDrubOtYn1QwggWDMIIDa6ADAgECAg5F5rsDgzPD
hWVI5v9FUTANBgkqhkiG9w0BAQwFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
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
AxMCAwEAAaOCAd8wggHbMB0GA1UdEQQWMBSBEmp3ZXJuZXJAZ29vZ2xlLmNvbTAOBgNVHQ8BAf8E
BAMCBaAwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMCMB0GA1UdDgQWBBSk7IgbgeQbrP3K
uNk5xD4fT0uLeTBYBgNVHSAEUTBPMAkGB2eBDAEFAQIwQgYKKwYBBAGgMgoDAzA0MDIGCCsGAQUF
BwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAMBgNVHRMBAf8EAjAA
MIGaBggrBgEFBQcBAQSBjTCBijA+BggrBgEFBQcwAYYyaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5j
b20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMwSAYIKwYBBQUHMAKGPGh0dHA6Ly9zZWN1cmUuZ2xv
YmFsc2lnbi5jb20vY2FjZXJ0L2dzYXRsYXNyNnNtaW1lY2EyMDIzLmNydDAfBgNVHSMEGDAWgBQz
ur6j1DlNKhnXyGaSaIH9wcbJxjBGBgNVHR8EPzA9MDugOaA3hjVodHRwOi8vY3JsLmdsb2JhbHNp
Z24uY29tL2NhL2dzYXRsYXNyNnNtaW1lY2EyMDIzLmNybDANBgkqhkiG9w0BAQsFAAOCAgEAHOZL
uL9T1R5SLtrk/9qeSCYDd9aGRQpNoukUTvZQDuxu7pUIqxD+kOexB42BBcSII4wvX9bUvbQD1RWp
gurg60UAEtO3fqm0jrdaVgc3BLw8/ZV7Ts581r/K8OXVdHlR/sbMN6g4ojSRKNn9VOEO184Ql+6q
a8jZtlGT9q55xhNLCzLyqykM0hwxDCZjYw7G0IdvaCH0QhY5JtEWFUMDqaOxgaxT3mXr3D4eEaca
nP2ARcI3fe1tjyXS4r+tHkuqdx+YLkKFEdxRVAzntnsrERtpBSAfSqUgL0g6XVjmYtABtzDCL4V5
WQvThi7X7YJtDXDgVR5yPmZrHadmHG3QasPwfFPxa+65d4XvB+iLttbY4Epy27qcASDNpVi/TZBn
jJ4rP6wP9Eo9N6QU3wUw9lHNAaeVMGwuk5zynwXMM6AsFX8LcLUgkIO8++d50eVdjHUyc7jwDRke
qQR9g/DIm9n2bkCUbc8DmCeK8rhyMjv3yT2YhmjtCvoSJODHBf7OplD+F5wR4zRRrmOrXq2LsBUP
wcbsXjPgco7AhSkxvU4thFwBvtvRpWuHSH/1LFpP60IrRbXy7XjLIuuRme+x/9/GguA9uzt0Dizt
EAxREWHEmSwuqlvZn00rTKzAIQfxqEXS7p4MLglEiXksEI0xbon8ZC+8QRaoFjsJCnq0bBgxggJd
MIICWQIBATBoMFQxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYD
VQQDEyFHbG9iYWxTaWduIEF0bGFzIFI2IFNNSU1FIENBIDIwMjMCEAGeDKjduNvs1UGGx3C7BlYw
DQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIAK8NRWLmviQdd8esuZDwttg2TfA4pVl
DMBSsTQM+zIUMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDIw
MjIzMDU1OFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEB
AQUABIIBAH0qJYvkMl47UvbICP5UKhsokfBTnCEmjWS/riQ80hT5xEkc21rYfoz4DqiVeeZWVQMQ
Q2Jn/l2afuMz4eQNF7yRuyfZvm7839TstDH/hLO8ClascdjgWWAdpkXVCrOUMQF2zz6PYucJ38ro
s9QueMqZ7Ugk6/YKJThD+YWMvGvbyeoqtnyFqw//LWcmv/lu5L5eE+pxfiQmK5Xi0TEFttjp79nz
ohnkZkoQZl11Dq+/Qd/mb/1xTHzBN7VK8eiJ1HgjdO7T68vFtCAJ0Sb9GP5FTmsFfZqYGDjQztOB
Q8igVw4TuPFQa6mz1+cOLX3UR37Hn7ZT2C+1QugbAXUBbO0=
--000000000000ae4d480649df5dcf--
