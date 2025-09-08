Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A382264B6
	for <linux-trace-kernel@vger.kernel.org>; Mon,  8 Sep 2025 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757339661; cv=none; b=lcgI7bdCzSku8xi4T5qYEO3t60km1OUYwDKfVb9qG53xjuDEa0K4MjebGSx9Cv5ZcHbiUBDhvkr+T1+LbFQg5Lkv+nrMiIdSH2RS0K+ASrRzMwh88ML2JUhg+obenQhWGMJRal0bOgCOVe0s6tr0arQZjxRjmZeKYJxvBqEXaVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757339661; c=relaxed/simple;
	bh=LmBLgVJxu//LFMs3vEa9WRRTXpymDfbTwqtICnWZo1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GXdRGCD7Gsm4wcDhPB9DaYCCWw/1Tm/rpYTVXLLjzhkEtMj5aqV1pfeu5PPBhMp6crhvEnieKy9CqKNdigR8YpSzQ3i//5MeF2iiUqutdswLlyeV5uUkLX/O0XljwXQ2Ta7VvkAXd8Eirgvr9qpqVYGKaFxOK68YqzRncV96j3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aO8c9FP6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aO8c9FP6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757339659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ShDuty5Bz8sZ2WGVZsWE/9pYA0uQbfqbzKQmAjJJn1M=;
	b=aO8c9FP6k6LarsOMwFq/7Fbk43oTvc56Tw/SVMiaIez3GpGFyIrvlY/EAZQU00J7zyDfcG
	n6RkHhW98hsTa8A52dhSbkxf9bQMcuZ0yC08yieYzGQ5OQPjUoS6fl241JUOqT39dyx/Lv
	Ssqr4FUPD9Wif1I2pdD7bAWvXmPji+o=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-hR8dJ_PuObyMs4E9x3RNsw-1; Mon, 08 Sep 2025 09:54:17 -0400
X-MC-Unique: hR8dJ_PuObyMs4E9x3RNsw-1
X-Mimecast-MFC-AGG-ID: hR8dJ_PuObyMs4E9x3RNsw_1757339656
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-628cc072d53so858990a12.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 08 Sep 2025 06:54:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757339656; x=1757944456;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ShDuty5Bz8sZ2WGVZsWE/9pYA0uQbfqbzKQmAjJJn1M=;
        b=lhnNKdIc65OyNAZ4tklDHnRsQS4cwueUTsIGDhHk+DJIPADvCy2QeOVXdewA8erLfk
         Mm6ezBilH9iwa+iHXJ+N4R12xSqj+EYaYbsJwAzcRLz2fDUcNYHOn8rxovBfuBH1MfO9
         8b6wSbVN8xB1d+OQFknf52YncbFcOCK4DaZT5RE8TQSvjtTrRTrVoIVjdR446rjzJvpE
         ssR2AlVBLaprrjsfqnGG91A3q0n9L2V6qgXffKs0V+4QDqRy21l44wJjxYYTXqsbHOoM
         g4BuAN6N3L0vlHENYA/HfDfQDX5sgOu2RUu75I08u5XW6irjIrajpNReGtsPBiD5GjU+
         uEAA==
X-Forwarded-Encrypted: i=1; AJvYcCXCYWu/JOjqjX6d5a4gONjkGOwr0XaIZdVwsbc/eAyyr+Q9iR4q393MnzTBtt3/+0Js3tBvKJmD4854gLHH5gRmsOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIl8+g1hDxL3X3enc3AtDSBuDA/l2FdMwh4trT56FnK2RSRZjL
	g06QMt3eS84wtQm/jAZgTWM0kQiqlckn7z0YISfu8YDdG3GXITvpRsp6dWeS/4p2NDnh7FuAATj
	s3NGdXr+nnj/jZ84kTQX3cxONqM1RMfsdcgG5SCOIllOGmOs386I++ror9Yx+DwTzQuiaaRfPgJ
	3O0TOjfrvBaNHwZzH7UXY6HOKe+a4x+tK2TtYPt3mgGtEP54yz
X-Gm-Gg: ASbGncvlfkRzRulb2m/vzptPvu9TrtnXEOBiP1qWK94bxe883doucAWi10atly6vRC8
	Hyq4YVi4/QrnY3rNP5YQ1ewHERXZiU861eqlJTQEyBxZLTcaOLrI18dM4nFazokAOjvpTzLu7Zt
	uZ6A309sc9IwpMq8x0us583Xpvv+c1E6AFB6xg0a1+ao2py3m7HpoTo6o=
X-Received: by 2002:a05:6402:51d2:b0:62b:1e19:8f2e with SMTP id 4fb4d7f45d1cf-62b1e199266mr886676a12.12.1757339656116;
        Mon, 08 Sep 2025 06:54:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3qSuI6CazOKpJgNQ70OQqfF5fRK95lqE70itD7bbl8vTVoJM8VLR9MsyQkJoUPIGm1BCRaqkBFN+14CZsXhU=
X-Received: by 2002:a05:6402:51d2:b0:62b:1e19:8f2e with SMTP id
 4fb4d7f45d1cf-62b1e199266mr886652a12.12.1757339655672; Mon, 08 Sep 2025
 06:54:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250907022325.243930-1-crwood@redhat.com> <20250907022325.243930-5-crwood@redhat.com>
 <CADDUTFwg7aLjrcaXnkGb85ZnqtXvnyMV50+SBDfZO98sNQ7yrg@mail.gmail.com>
In-Reply-To: <CADDUTFwg7aLjrcaXnkGb85ZnqtXvnyMV50+SBDfZO98sNQ7yrg@mail.gmail.com>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Mon, 8 Sep 2025 16:53:38 +0300
X-Gm-Features: AS18NWCT1HUw5CTj6dtKpyhg2DYg1JE72xO3L7m3xGKCWEwYxoluiYs_gxy03Ng
Message-ID: <CADDUTFx6EcsoBuL5UN19O7S+HB6GrGgkMWvKf_MFd+hgk595wA@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] tools/rtla: Consolidate code between
 osnoise/timerlat and hist/top
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
	John Kacur <jkacur@redhat.com>, Tomas Glozar <tglozar@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BuNARdP1NP0P0raJVZm-y83_9AL16ZnVIApgtiEBd1E_1757339656
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 7 Sept 2025 at 22:51, Costa Shulyupin <costa.shul@redhat.com> wrote:
>
> On Sun, 7 Sept 2025 at 05:23, Crystal Wood <crwood@redhat.com> wrote:
> > -static struct osnoise_params
> > +static struct common_params
> >  *osnoise_hist_parse_args(int argc, char *argv[])
...

> Why do you replace specific params with common params, breaking the hierarchy?
> common_params is meant to remain at the lower level - tool-agnostic
> and reusable across tools.

I see. You use it as an abstraction.

