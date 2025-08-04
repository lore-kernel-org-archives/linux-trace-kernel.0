Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A179F223DFB
	for <linux-trace-kernel@vger.kernel.org>; Mon,  4 Aug 2025 18:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754331522; cv=none; b=BXO9Ki+CZdmoiuwC9h4Pba8O8ltN/lsd+3ohl8lU1i1g5wQ8ENpq8i1YGwml8RcwtuO1FR/w5VT/E4VTLHCLmlQCCAkB2jJ94kxh/LZuyai/mJn0cLYyIjUCTAkkFxH2cHPcu3QGZ5Z84JvQ7xKCBDMjqMHUR9zQwSMgEUK5BN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754331522; c=relaxed/simple;
	bh=sJmIS+4VMfjqdG20GuSrtYDj9UHHKpW7QBhkO353ZHU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YA0+y+faqLXhZ1hCycP6lX0zvnC7vkX9nH9JQaQ9NeQUEkTT99PMsWZPacEXDRVg4nJRt/6/4yEcWQBFarQS+5uRFNsLrpTXi50rpaCGY9aFjzWKMfB2Dn6YcZHac2a3XwPeCIumei22/NEWmI0f5aNiVUMzARmORdDoeJ1g+bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bu0fBxRB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bu0fBxRB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754331519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qPFuA3XT5rZs0YkAQkaYeJ3lMViwpDLOl0oehXQ14cg=;
	b=Bu0fBxRB3Xwib2LPTtJz/ZZaXeAzINqf5EkMlZnDZSQvHinoiHmquD2aTuSYXSqGEmoVdB
	yG64JGyTFdambR6b6LlafCZHnBsM7XW7oO+3cOFGC/vGtSnraG9QNhcyBQuSUjBxkVXO/z
	E7RwUcfvj3BS2YVhilnXU5v0rFpDUn4=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-Uqod6vOaOmiSSNMFQNUBiQ-1; Mon, 04 Aug 2025 14:18:36 -0400
X-MC-Unique: Uqod6vOaOmiSSNMFQNUBiQ-1
X-Mimecast-MFC-AGG-ID: Uqod6vOaOmiSSNMFQNUBiQ_1754331516
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-87c43c2af72so352329339f.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 04 Aug 2025 11:18:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754331515; x=1754936315;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qPFuA3XT5rZs0YkAQkaYeJ3lMViwpDLOl0oehXQ14cg=;
        b=fEPDA+aKceMs4qoN7HwWWTZbIlaE5f5BYaq5qE9rOQlTbYEPV3f4UftU2QG7pnWmFV
         QCqstrGGcU+4XZgSsJBHRwy4OXr7Ws0VTVu8EtgOhT9XbxBh04qZE5DgKcpW+bc93Ssc
         T9gldeCJiKoJOX7HymvFpRCcp1T1RkVa0VoFm5ANl5fZdSBTsZ4p+PfEUZwzkvAk2wJM
         FwzD9z0+r8b7roGwznd9tmwnl6zEMA9o7cEU9PLeZcflXxNQtmwAZGh9ZwW/UgYfQlCP
         MBFR3xDmrrGxybFGW5Hu+TM55sTvYN12zyEFFrasFEZuuPtlI5Ko6uRuFw5x+JJ4/Qk+
         8+tQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4QTOLYlo56L7EeDELPwi77UxIswgQJ9A5mk+Lzxj7sn7QLsG7GnAS81m/XJvNYvRuqwqZD8h8v6/8O1LuxCJUdg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgaoA+V0lRctuNWHdMdRI5SCsmeHbsmGPhgQBAkFkCEfU/G73G
	Q60JAQvbByEauuL9BMRlGeryuk52XIxi7FF87ReOcjWJF18ir58pNQEWv5aSv+hqd70STCaIn9k
	YiJG6tqu6DyQhWppc8An+2UE9DutsEIRgM2k4LAreut7G9E3sJsmi4cSnvpsJL1B78Bd2M6BtIQ
	==
X-Gm-Gg: ASbGnctVw8rSCHUmveiIXezecYLGm6YVNsUCtXjXCRg6fFQ4f5lTT7iRJK7Sjz4q/iM
	9zIMAh7CrZBdyz0k6L4ca+1kmVOGxGcoCTPno35Hd6obqULDKErMsE2P8Jgc3d5j1yZ15DWNBay
	ywpUa4RruXQohvJmTdoXzj4EWPOLUAl4frYSeWfjjJMuPd6/bpNgu3QPdE6ajM3JPfb3GFqBBN8
	WuXf5QLhwN9QFUypUqxFJ/8EySHjNxSWKwxYODowqIjljVZhxNZPte0gWEdOCHQjw2ZkDf+gVtX
	cocxDmx6YDgm3wJc8HxNxMlEtU9Aej2tZyWOdoPvoKRQ5wZyPZzPflrezGZzruLbzhgg
X-Received: by 2002:a05:6602:2cd5:b0:87c:2f66:70f9 with SMTP id ca18e2360f4ac-8816824b198mr1908989939f.0.1754331515398;
        Mon, 04 Aug 2025 11:18:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRY7UzzPxt1OP5gyqT0uCW4Gog0m9+ZLLEFgonjkQDZIWdxputL/74lAccIGpspoDTOpfy5Q==
X-Received: by 2002:a05:6602:2cd5:b0:87c:2f66:70f9 with SMTP id ca18e2360f4ac-8816824b198mr1908985239f.0.1754331514891;
        Mon, 04 Aug 2025 11:18:34 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([50.145.183.242])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-88187f182a7sm60068839f.6.2025.08.04.11.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 11:18:34 -0700 (PDT)
Message-ID: <0faa958ef9cc4b834a5ecdc92acd89520f522d44.camel@redhat.com>
Subject: Re: [PATCH v2] tools/rtla: Consolidate common parameters into
 shared structure
From: Crystal Wood <crwood@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>, Steven Rostedt
	 <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, John Kacur
	 <jkacur@redhat.com>, Eder Zulian <ezulian@redhat.com>, Dan Carpenter
	 <dan.carpenter@linaro.org>, Jan Stancek <jstancek@redhat.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Date: Mon, 04 Aug 2025 13:18:33 -0500
In-Reply-To: <20250726072455.289445-1-costa.shul@redhat.com>
References: <20250726072455.289445-1-costa.shul@redhat.com>
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wrAGqgaSYP9CdDf4BlbwpxQBRY1vehciFYASOg0jBaw_1754331516
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2025-07-26 at 10:24 +0300, Costa Shulyupin wrote:
> timerlat_params and osnoise_params structures contain 15 identical
> fields.
>=20
> Introduce a common_params structure and move those fields into it to
> eliminate the code duplication and improve maintainability.
>=20
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

FWIW I have a bigger consolidation patchset in the works, that merges a
lot of the codepaths as well as having everything use osnoise_params
(with some members being tool-specific, indicated by comments).  If you
want, I could rebase that on this and use container_of() to for tool-
specific params... but then that adds complexity with the top and hist-
specific params, most of which are common between timerlat and osnoise
(and not merged by this patch).  So we might want to just keep it simple
with one big struct.

Any thoughts?

> diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/util=
s.h
> index a2a6f89f342d..4c99a3746380 100644
> --- a/tools/tracing/rtla/src/utils.h
> +++ b/tools/tracing/rtla/src/utils.h
> @@ -59,6 +59,32 @@ struct sched_attr {
>  };
>  #endif /* SCHED_ATTR_SIZE_VER0 */
> =20
> +/*
> + * common_params - Parameters shared between timerlat_params and osnoise=
_params
> + */
> +struct common_params {

I'm not sure that util.h makes sense for this... it's pretty core rtla
stuff rather than helper utilities.  I'd just put it in osnoise.h (or a
new common.h if we want to keep the actual-osnoise-tracer stuff
separate, though currently it's a jumble).

Do we have any naming conventions for the actual osnoise tracer as
opposed to the broader osnoise family?  I don't know if it's likely
we'll ever try to put something outside the osnoise family to rtla, but
if we do "common" could be a bit too generic.  Not sure if that's worth
worrying about at this point.  Certainly better than using "osnoise" for
both without clarifying.

-Crystal

