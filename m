Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F104369998
	for <linux-trace-kernel@vger.kernel.org>; Fri, 30 Jan 2026 23:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769815621; cv=pass; b=rs4FuBY1FBFq0PUZRxnPMl4LLpG6MYKZROb3wKa+EzUbcZPTVWOzlM9R+3j6y3r28muHHWp3pJ5ioqLMfhSEpfdv/Io7FeAb1zJtGrH9fNc+wDGGqw1n1SFEJ852OMcu/ci5uRFCMhNnRFatEd/e5yyc9LeOzz5UzLPKeiTzFwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769815621; c=relaxed/simple;
	bh=G5mIdlkGe41SIr2b9xVsZbuMUzOe4YNCoHr31oBulDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z4BNjLMH7m5sZzAGhQ3+hhZ8uiMEeXapVOWzg+u479y8xiisE9BAQDv2ZWrQHBbr9QBR6CfgMsZ1G+mbSyuG+DlMSWwN96jakd3YCOQVsBDZxmmZH4sJNnICd9ONBilGkC0Tp+LBKH7wgO1xlMMG+3ScQfFlBTAVpStqDw5zSHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=grZWw5gb; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="grZWw5gb"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5014b5d8551so73121cf.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 30 Jan 2026 15:27:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769815619; cv=none;
        d=google.com; s=arc-20240605;
        b=WssAfQRtiBPnA370+hl75gmymON8junQVgmkYHzqRLq2Fmv4WBRct/GCxYLuOo+jV6
         e1BSyCxP24UWdqIKvkyj0+QD/MuAIKdsppSOWdBotzCSHy6VTS2ixn8FckK6rdvj5TjM
         021Olj8REUZLHVjlleoAlEvwbmZYKBlLYLhR303BNC45PKQQ31ZsWZjJk8Svu1r35DYA
         WWWYBogwWtnNPsRYkgYX95qqcYorIEZyGsW1+fCjrKa2IyVPqjW4SH9F0teFK1QuMG0I
         TPrGDYCQDnR8WTbHZ9n7O7+Hbg7+Y8604CwuDRTTCXtIdCZegP9RFMJedjrJ0RnncteM
         /rgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3zGcOxudK+N0DjFET7hVAVkmiFhbCBpncrsfdi7eEAM=;
        fh=GRYN1++WyXX/7+jV9HN3uv9tTw34ve+bRRwU4cGWASs=;
        b=bxdQ17xQoYoXVbd0T/UxftViTIa9+UBKmlUj04l7Siq9PSGtG4Zei3rd0zEDRsu5jI
         qK1WwsgfZ1AJslac3sGKmpWkJCUeIGfesolEiSsw5ldaIlPTyYD7YJ9QZdk6ZB3nVH4m
         e1yatdiQorhou9B9WUukybn2rcouh/HS0idcVbA3thNe6bL74BpHFIdoXum6j+J+5wtc
         7kAHJqtDmOSa4RAJnj3qUJCdc7yvLWsH9mSZCKHVJyxVYUAy1wV50Bh8gYCOXRYFVp2h
         S/LpJqQUFEhJGBvQGX3UEYnnJp3rPI5PMk07qsrOU+gI77/tx7kj5smGLFvzqmtF9lnV
         II7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769815619; x=1770420419; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3zGcOxudK+N0DjFET7hVAVkmiFhbCBpncrsfdi7eEAM=;
        b=grZWw5gbKkRN/961gn7aO3SvXRqGmmp1qa1vUMo6iK04Q4DX2F7kr+9CVxQlmarQ4I
         my3vlTw02G6lScjjv+nTP3eLi1T51WSlQcMEdwWGzFuIhM/Oy1yVxUkQOr+US5LYgsN4
         DgPz3rLnLiZ7TUMcW/cHxHd/8n78eBb3TisYnN/ubWnKul9/OieksARY/GbHB4TmcAzt
         d3xexh46OQgrt1933P3McRtKMVsuWZRomOYjpCNPWRNjBifcNLL5P9BAuSr+Rn/9vnj5
         g5MTz0IiuRReLRYM6SeQCb6LUcfDOUaGffSKaKhh4zWr2gFnuL+V7LArW+GlGkr8gnVw
         ziGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769815619; x=1770420419;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3zGcOxudK+N0DjFET7hVAVkmiFhbCBpncrsfdi7eEAM=;
        b=F5R+Den9QKTXnf/8zs7VqbToxEpiA4Vd58wP+YdWAR7EuZ84O4WFWUlad9MFlb4dfT
         hRs1S8rYvrDt2d4xMVl2jkgM4JRBuTaC6GB0uvyOHWbBagcIGGt1x/h2e7GBDg79tprD
         5bJXsPQ2rYbbl0okKxhJuxT5+wcUmqOXzAjlxcS1sADusLO3w8dExU4qTEkaOUoDAWzD
         54RNQYUA/c9YYktcpbgHLzjZyYxq54gD7SdMummtZ56temE2TjbppaqkQhK5ad9GWNEK
         GW1myxYGHRkiZkfRbGzxeUqIZVUFwC/hBB3OZkHkUCU9t7LPOrY74uhSrwJ91NqqgrLa
         7Y4g==
X-Forwarded-Encrypted: i=1; AJvYcCWOYFL8hK0zW638dkUPTwMdiFkQFkJJtgH9TzqbBCWRDxIS7WgIFEQk5+reBJdkDPUkatN7qjs4kyQyltTvG8oO+bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE8bBVwqx/14QnxguI26CvIzMHmIF5HizJmoLv4O0OBv+Suw2Q
	IiW2XXgL3OjIqPmcnHhlgX6njNVh63AVy9h+zObMm5MwDpJicvqiRbgTWrnq3rxWoUIGgAmW2Hd
	4YhGARJw20iwXtQZO4VoBOxrkLyQvnxg+EGujTg9osm/8FiAOLIG+ZUG3
X-Gm-Gg: AZuq6aKMKPsf5VhtmeATrPkEtASDvQRQHUL80uKI6KvlO+Fb23IQAf29W/ul+RC8CQ1
	Rno4tU26pNrsZt3SZtmT98XpyukgTJ1MWoLNzWTSdZNGv529wCLq1HQr5w+AZjkZykT0kCBzD/T
	23wQvpQvpmNoFk7ZV4Ovw9BG8Vam4DAzW2Fu7hJ/pm72DXxrGWTBirCkzaFAm8Lt9IxzYVMHNCU
	u+zXK3fCDfQPnY88icROzOj5nqNzCNNFgyqfka861AyMlCI8yqW+tlhe0LOgGPf3Abb
X-Received: by 2002:a05:622a:24b:b0:4ed:70d6:6618 with SMTP id
 d75a77b69052e-505dee57bc3mr3909751cf.10.1769815618818; Fri, 30 Jan 2026
 15:26:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176974810577.124104.16012554973099890517.stgit@devnote2> <20260130095331.5c9f754e@gandalf.local.home>
In-Reply-To: <20260130095331.5c9f754e@gandalf.local.home>
From: Julius Werner <jwerner@google.com>
Date: Fri, 30 Jan 2026 15:26:46 -0800
X-Gm-Features: AZwV_QhHblAbtaz2_IBBRLzgCfQayk9YypcLuOpsAiTzGqjWuiltX_q5jtsrCOo
Message-ID: <CAODwPW90ALuMy6kFPqQSj_vN7krRz6cpksAUm2WHJNYwRNxHnA@mail.gmail.com>
Subject: Re: [PATCH] bootconfig: Fix to terminate value search if it hits a newline
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000005158150649a34f22"

--0000000000005158150649a34f22
Content-Type: text/plain; charset="UTF-8"

> > Note that if the line has a comment, it still keep searching the
> > value to the next line::
> >
> >   foo = # comment
> >   value

This seems inconsistent to me tbh. I think someone could reasonably
write a bootconfig like this:

foo =                  # We leave foo empty here because <reason>
bar = value

and expect it to work. There's nothing in the documentation that
suggests empty values would behave differently if there is a comment
behind them.

Also, I believe your patch might inadvertently break this case (which
I think(?) is supposed to work):

foo = first array value,
      second array value,
      third array value

Because __xbc_parse_value() returns from the first value with `&next`
pointing at the newline behind the comma, and that is passed to the
next iteration of __xbc_parse_value() which will now no longer skip
it. I think an already started array may need to be treated as a
special case here and you may want to add another
skip_spaces()/skip_comment() to the loop in xbc_parse_array().

--0000000000005158150649a34f22
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
DQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIBPbIo47QnBTCT32QZKEBeCtxrQ6no+g
2quhmMkpkUeWMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDEz
MDIzMjY1OVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEB
AQUABIIBAKYMuq/4WGgWTlY7q9B/IhrXCzyJAnCzCRSGIEHmRxd+hYxepOLQJrjBD79QPZVl3azU
1E0DNZWVJq5xbpwsfNmgQpfNeNKxrX1wWAWXvqje656YNd+64bJKqr36WVTP/d127r4lVnXkY4oK
G5Nugz9ZohxukH7t68Mv05t5KBhiM/xTSShswvihwAEWrs/NpEN+JlO2jkJFFZwntoKJRdvAwHgo
7NtSA6RPZxMI9xs2VDPComTF4zerNWhH4HnyizaaJDA7l7i+nYhhyLgL0FPBmZdOtRsAAKA/qjDs
2Az7hTImsztHVD00AVIH5fOikwdZ748ezlZ++ExMM9dbLOQ=
--0000000000005158150649a34f22--
