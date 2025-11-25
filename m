Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4F6191484
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Nov 2025 01:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764032512; cv=none; b=WbPtBfEQPYu1n2YMg7sGA3oHHF/16hy5Ql+EToAWFm8I5Gq8k5AlRUBi7wPrh06O87vchgusE0kG2jTs/j6vAQMRsjdCrEcN2FUT+0EN2xLVzWy6En7Ee6vLcMvQOxfdKtVF12Z6Sq/NtDY6nDTyzZbgUNZQtqEJffKnNg10Sfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764032512; c=relaxed/simple;
	bh=aS+1cJa75nrWpjPePFv55yi2LEwUdzX1MEm1hb7W8f4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZnVLDvZRhPB2Htkbc+vmBP+jPFoYE7/x3FBeH8dyFQ74c+16wGY6T5aYqcq6sWWUtrjlb1aKccdCV7gNcRWAX+dzirEOTUyV0qDZVdIcIQ9ArLQLUyH0fpz8BRG8q0eSBrrsa3aML021K3OcLkyossKQGgvnHJibWpgp9zKUPak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DR5GJ8US; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DR5GJ8US"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764032506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Krdw59DF8mDry2N50mIsRLclxBge7cgrOeMU5xjuesc=;
	b=DR5GJ8US/ACb9nurPcRmPfjveg6+HN8PBdaJfEHbhpznznfsYIXTLLcTa6Pa0di7jw6qov
	6vYBh7nWwX7q4LLqlF9789R283fI2uRcWLpG+C4yxr2vFxq7LQInarTNLwiCX4nviinU/A
	gvtGFyuHLrRZ6f0KFnRyl/FgZ2Qm0Tg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-RZKS6P7uON--NzxBRjLZNQ-1; Mon, 24 Nov 2025 20:01:44 -0500
X-MC-Unique: RZKS6P7uON--NzxBRjLZNQ-1
X-Mimecast-MFC-AGG-ID: RZKS6P7uON--NzxBRjLZNQ_1764032504
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ee09693109so107156021cf.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Nov 2025 17:01:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764032504; x=1764637304;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Krdw59DF8mDry2N50mIsRLclxBge7cgrOeMU5xjuesc=;
        b=mLEVg2awMpNXJ2FrN5nT4ETGqtuMp7Cf83bqq6bqWiBQY8Jas7ntXo88UvqF3f2gHv
         4quqdufWUjlKYuEh6NO+C0a8kZKQIOgWn96kWiC7J7CjMP0ujI3G7roWsgeYOnekNdU2
         2Oc8wK+9sImGtVAj76o+LKfBVjVBGrtryJquMIiy70eKQ7IUez7bgZUKBIGmCguq+up7
         q5ejuZm+mdJijC5p6qf18R3xY0dVHPJfMBkLMNlY6qWJUx1kmcXOEYarEQO8TsTnMrzC
         t13XxZlybpTC5St3o4wcGDBsYP5xiviGVJmz3e082F3uCN+dSxmHT08AN8wSDuGnEEKX
         r9SQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQgUVZuC5Ec3z3z1igNffOc19qeXUzJdm9wm7eEywiz3Fw6HRPKV1GTMj3CeEkfeWeIw5NMHj67jl3lSI6dA2jWc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxtVBDkMqYZCGMZDidA9YbYIrLpXvdGJc/oJibv0HBfTyqwvqu
	JFa0DHZXnvyL+3bzCgrZpM3hUFH7X0Y7FGb4FpLuPPf35sU95JDUnS9e8ZySQVAzM+nLSTFWTAQ
	zaazCVZTbb9xhMyV06r1N+Ba+jjoGgzjNW2IsWVJGusIn+pI14jXVB6wHLhCr39SmIjYDapdnaA
	==
X-Gm-Gg: ASbGnctVdG2ADRcJKvWrwzKM1Na+itX++Z1TQY6rqPdqMoMPHFM+cEfgqYEzsjC0oCz
	R9eDhrLyFGuXXSq9gPtUxTTtGO1hXehPkKLYcV48pS40aBTVGrWpi4bWzYWYUh9/FA/WgTy8gA9
	QHCcMMCVToqY9w4zXKyyV1eZs9uCHOqbT2HDaALsCybsNaWqHC4i+NStkgDhgiUD5URa4ZmSNXH
	fvLCj+DGelHzwfoWRi9JOHVo12+r+1T8IZ9YGuQHUPt757UKnNzlgIJQiHol6cJOYmzmmghwibS
	yoApbd2Nlft9H2x6LwSpPgr8jnIJfbVfNuNXrVGUXImWyPg4NywQlF4/1IhFQJjIy1WX3hpQ+Lb
	lmpeSEkJbKzidbT4ndYO89hOLmmoC2xkmgZwWaqRxfQ==
X-Received: by 2002:ac8:5f84:0:b0:4ee:2c3c:6e with SMTP id d75a77b69052e-4efbda49e09mr15667291cf.30.1764032503820;
        Mon, 24 Nov 2025 17:01:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHF3NXobiMfICuyWEqcwkYMU0xyrtWHnGIXntf9dW3FH87Z1BqC8via9eZBQaJyMrtfaj5VyQ==
X-Received: by 2002:ac8:5f84:0:b0:4ee:2c3c:6e with SMTP id d75a77b69052e-4efbda49e09mr15666251cf.30.1764032502882;
        Mon, 24 Nov 2025 17:01:42 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ee48e8cdebsm97590441cf.31.2025.11.24.17.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 17:01:42 -0800 (PST)
Message-ID: <e58d366c0eec0efb602293f502f64be2df39ea89.camel@redhat.com>
Subject: Re: [PATCH v1 0/8] tools/rtla: Consolidate common command line
 options
From: Crystal Wood <crwood@redhat.com>
To: Costa Shulyupin <costa.shul@redhat.com>, Steven Rostedt	
 <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, Wander Lairson
 Costa	 <wander@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 24 Nov 2025 19:01:41 -0600
In-Reply-To: <20251121174504.519230-1-costa.shul@redhat.com>
References: <20251121174504.519230-1-costa.shul@redhat.com>
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: n5jnV6qS6Esf-oomihFHtltURklvH6zXwy1j43VZ-Ig_1764032504
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-11-21 at 19:44 +0200, Costa Shulyupin wrote:
> Argument parsing functions are the longest functions of the project:
>=20
> lizard --warnings_only --sort nloc -L100 | head -n 4
> ./src/timerlat_hist.c:766: warning: timerlat_hist_parse_args has 247 NLOC=
, 76 CCN, 1579 token, 1 PARAM, 287 length, 0 ND
> ./src/timerlat_top.c:538: warning: timerlat_top_parse_args has 217 NLOC, =
64 CCN, 1338 token, 2 PARAM, 262 length, 0 ND
> ./src/osnoise_hist.c:469: warning: osnoise_hist_parse_args has 195 NLOC, =
56 CCN, 1225 token, 1 PARAM, 216 length, 0 ND
> ./src/osnoise_top.c:322: warning: osnoise_top_parse_args has 169 NLOC, 46=
 CCN, 1019 token, 2 PARAM, 191 length, 0 ND
>=20
> Moreover, they contain a lot of duplicate code and growing.
>=20
> Refactor these functions to reduce code duplication.
>=20
> Benefits:
> - Single implementation for common options
> - Easier maintenance and consistent behavior
>=20
> Costa Shulyupin (8):
>   tools/rtla: Add common_parse_options()
>   tools/rtla: Consolidate -c/--cpus option parsing
>   tools/rtla: Consolidate -C/--cgroup option parsing
>   tools/rtla: Consolidate -D/--debug option parsing
>   tools/rtla: Consolidate -d/--duration option parsing
>   tools/rtla: Consolidate -e/--event option parsing
>   tools/rtla: Consolidate -P/--priority option parsing
>   tools/rtla: Consolidate -H/--house-keeping option parsing
>=20
>  tools/tracing/rtla/src/common.c        | 78 ++++++++++++++++++++++++++
>  tools/tracing/rtla/src/common.h        |  1 +
>  tools/tracing/rtla/src/osnoise_hist.c  | 53 ++---------------
>  tools/tracing/rtla/src/osnoise_top.c   | 53 ++---------------
>  tools/tracing/rtla/src/timerlat_hist.c | 53 ++---------------
>  tools/tracing/rtla/src/timerlat_top.c  | 52 ++---------------
>  6 files changed, 95 insertions(+), 195 deletions(-)

Reviewed-by: Crystal Wood <crwood@redhat.com>

-Crystal

