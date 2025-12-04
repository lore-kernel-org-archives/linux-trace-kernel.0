Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05951F5846
	for <linux-trace-kernel@vger.kernel.org>; Thu,  4 Dec 2025 06:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764830225; cv=none; b=nPrpDyxo0U/vRT7GX1Y8PVQk1PFqJ1yGQCNSx9E8ltGB4ZxMZlONRwI486ppkLt1tOAt5LnqdwKluzNs9wugxCYuQqTjkxG15SLRwZvDk9dyKUNSj9rlKMm3YxAChfmMGYi/1RU2gEipMijCYllQk5LLZpuuUw/hwJxmfSajyoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764830225; c=relaxed/simple;
	bh=rlvpXp4vXIUjCAdr/hHyOvzOZjcIFPmn9CfhMS22lG4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JymzorjKD+sJ4TV6i9CLIYg0obORJZLzuW51z5rHQJ1JJBWo4/9PYs9bKugl94xssIBGtBR02GCPm4a5exidyXsOcrYdpHWKF428LKtcOuFY0hwV+fAmtPiKQ8KWE441apg15zSJZ5RJazIRWVzK+18qMsI0BQFkF7OQMytxV7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gk0W4+H0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gk0W4+H0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764830222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rlvpXp4vXIUjCAdr/hHyOvzOZjcIFPmn9CfhMS22lG4=;
	b=Gk0W4+H0PkMFbZh0jDhEO2kef+qmkCZqXu35IAGynyMMlXtdP6udT5pd4kmhVNiVEAFM52
	DclIycr7jYIKYvRweaf2rTQLAsmQL4QuqPRg3V+gmBtBNZUDGdEs1Bje2t72mwoDeVT8w5
	LzLFROb2oTKpt7oWEV2QHl76l+py9Jo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-XwgN5sgcOgG2FRHSMzCg6Q-1; Thu, 04 Dec 2025 01:37:01 -0500
X-MC-Unique: XwgN5sgcOgG2FRHSMzCg6Q-1
X-Mimecast-MFC-AGG-ID: XwgN5sgcOgG2FRHSMzCg6Q_1764830220
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42e2e50cfaeso387992f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Dec 2025 22:37:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764830220; x=1765435020;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rlvpXp4vXIUjCAdr/hHyOvzOZjcIFPmn9CfhMS22lG4=;
        b=IqmEA5ieyhpCDODOkw9dzBuKIfA9c8o+zLOaqA7WEl1Nlg79L+cp8p5HD3qoE82RC/
         B01fmqwuSpkAIXX2EmyhXzzAjg61r8b3TynOTtwYkoe2a1Lsy6efUnWuf1uR4vJQ6Mrn
         MBIBtbjnylb7C7mh7z5z2EghBw7uaREwn8RYAyhC5/f2Ll3XDHEKIFUATvC6AssVK5Ce
         jvwbMuBYmrpBnaGI/zXvsoDQ+qJ7LWav0YpOsYuoaG+VJN78fw7Gaml/FhG6jLFSPxgH
         23owrafeofDLlBbBPIBz0z6aDCj2NDYxTvlEt7s4SgvZWulpILfdrOZ3j6gdm5W0bTUA
         OcNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFFu+9eqpksJWBUe0Gu1g8pj2K5EHWqvVmIQkXtbgttORMNSs+zfsW7HiBUuyAa0XTsrVRa1ZqnUKauWLGfGpDfms=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsk91DMIVLE52tV9G0EF9BgcqyA84EyweifbnJ1vk5QgLy2t5Y
	vYxICaXj5GqbPsPqqpr7lbrKIg6lzJadEonw1u1DUbpfYKqyms6X1H8kFKbowCsIYFXCUO/26EY
	4JO9eNfJsqihpZ4s+r1sEuMgi665MDyS5RMypgVfsKQIzjinTesdLAde3J5omw460Q3TqD1DtLA
	==
X-Gm-Gg: ASbGncuCBbgd6LNTJcL5K+XArbHv9ILZ8jZT3YErGjFvG68LRNZ1zK1pMsaPL7pkCGf
	cn9IDQhnCvqWrg+ZFQAv8aDKudYwJglULCqnnE1xX1Ye8DZIUJSKY8hSIoVYtCaKwIUYYlyTxmR
	9D2WHfhu5DsTxtUa1qImBFGnqykav2YYBRhua51zhynh503+tvhNTNNdwFl/PhDGrZOwn19r5z9
	2zIM4yLEr36LJ0Dc3Zd/SwlYuALNecUEO9qGo6z6HPstcLSPxvyZh5Elt970LfMjTNVjBeO78zR
	Xctxsv/fmfCOO1IIi/HRJgFVu9cKkQaO/rPc9ZhgER3kfgSkda8UV5FRZ/zE+o72MbEeSYVQK9p
	2IXWaifg0bvebuFXSQOR2KVxlsx59aWghZIE=
X-Received: by 2002:a5d:5846:0:b0:429:8daa:c6b4 with SMTP id ffacd0b85a97d-42f797fdfccmr1428232f8f.21.1764830220212;
        Wed, 03 Dec 2025 22:37:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVv89Dh0h6k8CSTD9tgFWXKJrlyWPOh6eQ1WXkpbNGabqnJgqBAuEpWofqbE43M3jSFyUU6A==
X-Received: by 2002:a5d:5846:0:b0:429:8daa:c6b4 with SMTP id ffacd0b85a97d-42f797fdfccmr1428210f8f.21.1764830219788;
        Wed, 03 Dec 2025 22:36:59 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbfeae9sm1381076f8f.13.2025.12.03.22.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 22:36:59 -0800 (PST)
Message-ID: <a34546391cc59f9f880ec271292ac201292bac61.camel@redhat.com>
Subject: Re: [PATCH v3] Documentation/rv: Fix dead link to
 monitor_synthesis.rst
From: Gabriele Monaco <gmonaco@redhat.com>
To: Soham Metha <sohammetha01@gmail.com>, 
	linux-kernel-mentees@lists.linuxfoundation.org
Cc: shuah@kernel.org, skhan@linuxfoundation.org, rostedt@goodmis.org, 
	namcao@linutronix.de, mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
	bagasdotme@gmail.com, linux-kernel@vger.kernel.org, Jonathan Corbet	
 <corbet@lwn.net>, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Date: Thu, 04 Dec 2025 07:36:57 +0100
In-Reply-To: <20251204032452.9523-1-sohammetha01@gmail.com>
References: <20251204032452.9523-1-sohammetha01@gmail.com>
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
X-Mimecast-MFC-PROC-ID: 9LwyDktDt9ITUlvMJXvnLmqec-261FMhQNK0aaoOHdY_1764830220
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-12-04 at 08:54 +0530, Soham Metha wrote:
> The file 'da_monitor_synthesis.rst' was renamed to 'monitor_synthesis.rst=
' in
> commit f40a7c06020709
> ("Documentation/rv: Prepare monitor synthesis document for LTL inclusion"=
).
>=20
> Signed-off-by: Soham Metha <sohammetha01@gmail.com>

Thanks for catching this!

> ---
> Changelog:
> v3:
> - use a 14 character commit hash
> - unwrap Code Blocks so that the references can be linked

You may want to add this to the commit message next time, you are in fact n=
ot
only fixing the broken link.
Since the change is small I wouldn't bother this time, though.

> v2:
> - Use proper commit SHA reference syntax

I suggest you run your patches through script/checkpatch.pl (in the kernel
tree), it's usually finding this kind of formatting issues and even more be=
fore
you even send it.
On a side note, apparently it wouldn't have worked this time since you quot=
ed
the hash.

Anyway looks good to me.

Acked-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks,

Gabriele

>=20
> =C2=A0Documentation/trace/rv/da_monitor_instrumentation.rst | 6 +++---
> =C2=A01 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/trace/rv/da_monitor_instrumentation.rst
> b/Documentation/trace/rv/da_monitor_instrumentation.rst
> index 6c67c7b57811..9eff38a4ad1f 100644
> --- a/Documentation/trace/rv/da_monitor_instrumentation.rst
> +++ b/Documentation/trace/rv/da_monitor_instrumentation.rst
> @@ -162,10 +162,10 @@ For example, from the wip sample model::
> =C2=A0
> =C2=A0The probes then need to be detached at the disable phase.
> =C2=A0
> -[1] The wip model is presented in::
> +[1] The wip model is presented in:
> =C2=A0
> =C2=A0=C2=A0 Documentation/trace/rv/deterministic_automata.rst
> =C2=A0
> -The wip monitor is presented in::
> +The wip monitor is presented in:
> =C2=A0
> -=C2=A0 Documentation/trace/rv/da_monitor_synthesis.rst
> +=C2=A0 Documentation/trace/rv/monitor_synthesis.rst

