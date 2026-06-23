Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C99242D89
	for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Jun 2026 13:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782220367; cv=none; b=WIybeus3GLGbyO0MeQXVbpwvexzFqd6zcmA94QkFML6vTPHcSm8UHJdw+LTKUOUMVTCmOoZL6PdzapT7iztxT2uZWtOWtHBWm/+/Gp6+vH+MZ3UM5MgFTag1b0wGni94kzUt2Fu7yFBw/E9ons4h1BXz6GUhChw4Re0qj9aoaP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782220367; c=relaxed/simple;
	bh=3AWvtOWJT2gA99BNvf8VG6vqTg7vnv+65eLP8AE21r8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lx7EKzu4qoM1xkqMEuHxudI6rv8cjzdXnFy0vnV976YMnGjCM4Fybabf9dTgHcFSjd9eOm6RFYb0ndvvcjShnwbt0Ik35/a3Y3GkhO8Q8bwnNG4aKkeZ0/U8N2PDGjwA05uGCsf4pStyz1Ws2h2tK7v8NfZ2uidWQOHNQ9tRrVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bwxcImZi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bwxcImZi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782220363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=On9dHYv8SnoFxko0GrSVdclsMr1Axpq7yAvvKv+9j2g=;
	b=bwxcImZi5StWHpQD6hpHFm14cAqL+isoLz3iyWqzngPBUXFR+qqrVZxIIpw00KATKRjWUM
	qy0KlPg1cqvzYHNrodq82qTEuUnIhXbU4f2ddvPeYEX55UkEOvo9/v1b7G65qyqnSdryAh
	LctztkCz418MzClcnDadIga2IbZ8Nw8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-fyUfbYDpO3OUZe635nSuFw-1; Tue, 23 Jun 2026 09:12:42 -0400
X-MC-Unique: fyUfbYDpO3OUZe635nSuFw-1
X-Mimecast-MFC-AGG-ID: fyUfbYDpO3OUZe635nSuFw_1782220361
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c074ac8a2ddso589197966b.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Jun 2026 06:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782220361; x=1782825161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=On9dHYv8SnoFxko0GrSVdclsMr1Axpq7yAvvKv+9j2g=;
        b=kctCVJFz8QZvIiLqhZmb36hh5YVKcGRNJfOSKj2jXUr0um4OhutfSa1H/0sk4l41J6
         qW2tUbXecahXIk5XNYWxXV4bDk2GhaW9C9BIJrGG3/sihH5cTx8Zn2eAvpKRNpUIO3IV
         zHwZJ8KSpa5C7M9mgHDA6fTvFEjNdTtL7ZVM6rgoq7PtO9RAmlVpFHqaHlAJm9OmLgET
         b/yq5nztdU0tDS1a+XVOlmBrhBmClSBJji4TCSMfj5utkYcPZWxQ29o3rPtXB0pxoQtf
         G9BxNjnBN02YLgT8WHYcgYgckRmM9/gwEHy0BRMp79Gdhb4EppJU9MVSOnYeZvzty/L1
         xs9g==
X-Forwarded-Encrypted: i=1; AFNElJ8NHeewNKNmTbOkyqQPeC2vsXs68hNxi5zclpw4TfAIyCJLKPL1X2kqWmtDTFg48v92PmmjKXDsVbnQbSTa83gWdds=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhYmKIPwh4Vvwk5S1Eoomh3iUofF+AkQSrh7+d4/8+wDaKfNJ6
	Qih0q5GjpLzWo41I48mSZHxS1J/wxwUmweA3vBF67MVhdm9GOe5Ecf8F0EfZOnP2ur/PUhu1vx0
	wmVXqvSZyiaDCqFfyMums6NPtRG/8bIeWEg+3NmK7t5kYfIyO0H4A6Y1KmO+hQZbtsqtJa1XTli
	hKL5+IpvS55AqwHy79X6UNZ+HnF9+a+wjT/sMdiHVj+xkodotO7/4WpNRQ
X-Gm-Gg: AfdE7cmCEQoJfaDdSCBAAfsxdqlat0+Rov3XmJEP3E0WCIEdPnBk0pQXvVV0eVvaJsa
	RL8SrIMZ12fzf4FTlZ1+U9xS9A/YbRkELBQIzQrpS9iLHZEjPHOPc895go1ZFvb5GZ8BLJO4H8A
	xS8Uq0sgp5oKv7MLsLd51C9VhMkxa4OkPOdhh5Wn97dYNAau50/Nc+v0ESSv7ZXfhZM2c=
X-Received: by 2002:a17:907:d1e:b0:beb:2de3:1ba1 with SMTP id a640c23a62f3a-c097adf8d40mr1100545166b.11.1782220361031;
        Tue, 23 Jun 2026 06:12:41 -0700 (PDT)
X-Received: by 2002:a17:907:d1e:b0:beb:2de3:1ba1 with SMTP id
 a640c23a62f3a-c097adf8d40mr1100541866b.11.1782220360427; Tue, 23 Jun 2026
 06:12:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260614092855.129278-1-br025@umbiko.net>
In-Reply-To: <20260614092855.129278-1-br025@umbiko.net>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 23 Jun 2026 15:12:28 +0200
X-Gm-Features: AVVi8CccVHpIRaTgj8g2hkTAcBjoO0IQfixy-1mXfHC-M_NUxxaQBYnuSNGc284
Message-ID: <CAP4=nvRozLS73PooixqWUhDh19eG6oPLTCSV8HvjhibsTLswtw@mail.gmail.com>
Subject: Re: [PATCH 1/1] tools/tracing/rtla: fix missing unistd include
To: Andreas Ziegler <br025@umbiko.net>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HUCBrrJ_6z5de1IeP98KYSTU-Zj5dWXZ7ffZS2FhKY4_1782220361
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

Please note that rtla uses "tools/rtla:" or "rtla:" prefix for
patches, not "tools/tracing/rtla".

ne 14. 6. 2026 v 11:35 odes=C3=ADlatel Andreas Ziegler <br025@umbiko.net> n=
apsal:
>
> Compiling RTLA 7.1-rc6 with GCC 16 and uClibc as standard library fails
> with these errors:
>
> ...
>
> Restore the missing unistd.h include.
>

Thanks for the fix, I missed that.

Indeed, according to POSIX, alarm() has to include unistd.h. I'll try
to add the uclibc build to my tests.

> Fixes: <115b06a00875> (tools/rtla: Consolidate nr_cpus usage across all t=
ools)
>

The conventional syntax for Fixes is:

Fixes: 115b06a00875 ("tools/rtla: Consolidate nr_cpus usage across all tool=
s")

i.e. no angle brackets, and double quotes around the commit name. See:
https://docs.kernel.org/process/submitting-patches.html#describe-changes

> Signed-off-by: Andreas Ziegler <br025@umbiko.net>
> ---
>  tools/tracing/rtla/src/common.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/com=
mon.c
> index 35e3d3aa922e..5c5398d20f40 100644
> --- a/tools/tracing/rtla/src/common.c
> +++ b/tools/tracing/rtla/src/common.c
> @@ -5,6 +5,7 @@
>  #include <signal.h>
>  #include <stdlib.h>
>  #include <string.h>
> +#include <unistd.h>
>  #include <getopt.h>

The getopt.h include was removed in master, causing a conflict when
applying the patch. Could you please rebase?

>  #include <sys/sysinfo.h>
>
> --
> 2.53.0
>

Thanks,

Tomas

