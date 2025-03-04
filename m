Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C251F2BB8
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741075257; cv=none; b=PAo2onSVHQIEwqrscM2wzOg6zAhG0cvSaYSb5o+WGf41YCmCtokB2RYLeEonKcW3OTZLHdHYvDXEpokoWRzdMAlUly0O/KoZNSPF68nVj6imxgbnoB5ND+zHMTtSnN/CHXbgvNAVd2mwe9tvfiE9ql2/sLIK40SlGpfL24NRRAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741075257; c=relaxed/simple;
	bh=grlvUcq+n0ZHUeHH4YRjJJgBrlyFS1tT7OsIfZ6MtKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a2tagAJwSUCkIbytWILxZUeFdStPhHQddTQ6DEivtSymMgXz6D+8Ln1SYibKZ7bif54pD7rIafpd7B1E1y0l5sIV9KWnZMtBdArTS47chT81fo4XKcDwP5rvpSp9mgBr5q4o/KeeSfEX+3SMf3Gcgf+C0J6JN4Wk5IlLuHkWpe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HaH/ezKP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HaH/ezKP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741075254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IFiLdPv0wJgydI+E9BMmh4MKMo+mTex0R96kXh25It4=;
	b=HaH/ezKPCy4lSBpk5Cg2gpZU3IKZNyrs8+2ka2A6fLTw/z6i8DDnK51px969K2F2orS86n
	sWc2GSnFv15HKPjAQFouQ/yoG9yau6x6mlQvWq6RJb1IMQ1AD5lPnPBvtuZjSC8VEDrAsF
	NYb3AhFFKiL/vsfvA7Ld4Y3ntC2pPjM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-orPnYUf1PsW_0BtPo9RItQ-1; Tue, 04 Mar 2025 03:00:53 -0500
X-MC-Unique: orPnYUf1PsW_0BtPo9RItQ-1
X-Mimecast-MFC-AGG-ID: orPnYUf1PsW_0BtPo9RItQ_1741075252
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-abf553044abso280674966b.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Mar 2025 00:00:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741075252; x=1741680052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IFiLdPv0wJgydI+E9BMmh4MKMo+mTex0R96kXh25It4=;
        b=E+5i1Oy5P+hpJ4ToMazbzpRU+65vHWSrtQZt6KXkQv/9ooW/FAxgFKl76fbWuWFs+k
         d3VVpBZUn4S5zI9kbrRU/bcWy7W36XdOhpAajLUz4KvGVJLnmu/M4IgRMBIu8czc0JXD
         uU592RdSf0CLL75XresZkvI87HvKDj59Qz2CT0XH2GNe8YIPPPXjZAvl/H0eSRyuD1fK
         nzCCS5wvSsbnxWfGxSZOMox+mZElFYT0lNnPGNQZGExcDPzK6kV8xi/ecdSSNGK/rjpj
         K80Bue88ficovEefww6HwbCYYjk/DR/b0wemocy1jUzgJDzAQQzh6q5npDJveWYelwt7
         fZ1w==
X-Forwarded-Encrypted: i=1; AJvYcCXbhkFizEG8Wp/nMDpqsHOwyGrBytRFaum4BbOUHicUiHhqMmYMzm1fvzinl/WGT/F9KYJMXo20hp/V0v4GzuK7b7M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw22q1Sm+tinlqhYHsQaVh+ViaOPQcyWShcwPQhQ613OS//3W6F
	VYwx7ONW2+TbLbAxcMJ3CU0qHsmLBiZzkiO8IngAPR482myMeOszkTGQczcnyhWHQ5gzvNl+7zF
	C06PpkG+XSBu0/LBOTI2qAgHrsgq/oXN+RtDSpvAiC9lKakAKP0KWl7z9N0tIOnYxXk6bOVjERN
	ik8SsIWhoPKI29LKCDEbSzM6fOkcpr4F89JjKZJnBFZMqI
X-Gm-Gg: ASbGnctZy++POp+aUg5Ohs3Px/CweaJzDy7tqqDGOcVpfZDS/swf9vkNt9s4YVrk8dw
	vfM0/guKqSmdXnvHQmvjUM0B40wb3PuSNsj4f/u6n8u5c2Gyya1El1Gh619Bb4Ft9fAr/zzsI
X-Received: by 2002:a17:907:97c9:b0:ac1:fa6f:4941 with SMTP id a640c23a62f3a-ac1fa6f56b3mr77297966b.13.1741075251963;
        Tue, 04 Mar 2025 00:00:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6YcRUoE+PQsHcF94LU8vESBGW89cDx3MC01IA3KlNUw4Ta0bQ9PK+pMZlo0Tp04vd/FuLAgkki0nl8YikaVQ=
X-Received: by 2002:a17:907:97c9:b0:ac1:fa6f:4941 with SMTP id
 a640c23a62f3a-ac1fa6f56b3mr77295666b.13.1741075251611; Tue, 04 Mar 2025
 00:00:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127170251.744751-1-costa.shul@redhat.com>
 <20250227200623.60f20571@gandalf.local.home> <CAP4=nvQXaFmemBeW8U3U9zTMK0gVYvp23gfq_6ALsBJPTXt9Uw@mail.gmail.com>
 <20250303150351.28007ad1@gandalf.local.home>
In-Reply-To: <20250303150351.28007ad1@gandalf.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 4 Mar 2025 09:00:40 +0100
X-Gm-Features: AQ5f1JpjC5uI6iD9gjjgeuoX5GcZz2a7tfefoRMXBLfWQDJ3fcDoPMA4HZz7dWk
Message-ID: <CAP4=nvQ9pXYtihL7HTTRK=EzUEubtWbxDr78JswksSo-wa7zYw@mail.gmail.com>
Subject: Re: [PATCH v1] rtla: Save trace when option `--trace` is specified
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Costa Shulyupin <costa.shul@redhat.com>, John Kacur <jkacur@redhat.com>, 
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>, Eder Zulian <ezulian@redhat.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: D5veRVv_qWkqZy3M9WHJ4ffwS5Iwyzfw4wauCRGaO74_1741075252
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 3. 3. 2025 v 21:04 odes=C3=ADlatel Steven Rostedt <rostedt@goodmis.org> =
napsal:
>
> Not sure what you mean by "main instance"?
>

By "main instance", I meant tool->trace.inst. My point was that
record->trace.inst, which is a different instance, would be still on.
But that's not the case, osnoise_stop_tracing() stops *all* osnoise
instances, not just the first one - sorry, that was my mistake.

>
> The code being changed is:
>
> -       if (osnoise_trace_is_off(tool, record)) {
> +       if (osnoise_trace_is_off(tool, record))
>                 printf("rtla osnoise hit stop tracing\n");
> -               if (params->trace_output) {
> -                       printf("  Saving trace to %s\n", params->trace_ou=
tput);
> -                       save_trace_to_file(record->trace.inst, params->tr=
ace_output);
> -               }
> +       if (params->trace_output) {
> +               printf("  Saving trace to %s\n", params->trace_output);
> +               save_trace_to_file(record->trace.inst, params->trace_outp=
ut);
>         }
>

So we need to stop tracing here, before we save the trace, if we want
to do that. Perhaps combining this with the cleanup patch [1] and
doing the stopping in save_trace_to_file would make sense?

[1] - https://lore.kernel.org/linux-trace-kernel/20250219115138.406075-1-co=
sta.shul@redhat.com/

Tomas

