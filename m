Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51FD3F9C5
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Jul 2025 12:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753444977; cv=none; b=dHnGPmpiUiUXkkJxZiviyHyh7vwvokphXcv9lJUXr1PXv3g71d5sq2YydY52ozIKbKqcdLZMjRlWuSBQ1Krb3/WaSzzsueiqtW01Yd6hfwbhWE7WxGe8yz3tu0dy+GJ5Gb745wlDo2Zhl8XsdgeGyDkH+LUNekjnO2KlcYzX/PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753444977; c=relaxed/simple;
	bh=fqZHebi6Bkb5eNifT3yZFGVku7zV66aFMdE+I3t/4aM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=izUyRCUP4jWM697lkKeYdqTR2WPsqaZ97/qOqMEmVuHKMqupw8LOvYRjg2/NneQ1/fQxPE9YSsKDghXucWQM/lHOjNfqerSXQFYTe4ezx23K5ejoTxu+MrYHr6deyZCO1WhgzZ07YftFoOx7uYph+WAgP1kNtZYII0G9k0/96E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L4HzcPLa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L4HzcPLa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753444973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DbQ/CoKfRcOyF5XiIEBvtnbaZCP8pb630WPcqbF6yL0=;
	b=L4HzcPLaXVETLVdu5Q1GBPjyLXP9NDB0FfTQvi61YI6CHXPLbldl8vXQq/YnOnQlJCTRGn
	phat4HHJJMJ9wbEwVWVf/m6xsBmHe4kHyJNzs/G+jhBDNS/rhnbOOmCBN5iLSQDwbXlVv2
	oUXUJMHJO658vhF3YTRBIQ5pNkDjXls=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-0zi3K2wQMzWYcW9nK5a7vQ-1; Fri, 25 Jul 2025 08:02:52 -0400
X-MC-Unique: 0zi3K2wQMzWYcW9nK5a7vQ-1
X-Mimecast-MFC-AGG-ID: 0zi3K2wQMzWYcW9nK5a7vQ_1753444971
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ae0cd07eeb2so216083666b.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Jul 2025 05:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753444971; x=1754049771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DbQ/CoKfRcOyF5XiIEBvtnbaZCP8pb630WPcqbF6yL0=;
        b=afMMFrpNVqeakO19AUBbIkuoUYxtHTV3cEDdDxXPNo5Hr8BaE1E18uC5SPG3aKx2PE
         vgn3HuEzYmvq/D7U3cbSpT5Ti5dLVYeQGS1rjwMvDOJj7HKnDsrK3gRsAh0vcqykDzKD
         CChk5zxIlwWj3gbmeF2zOtVqYSgfDyUbKbt2iNKk61HxmMevNQzbKw/zJeMSWm+H8p7m
         9P0ljcFrxLJKAgCPVKtCPkzLwh3jvFqeGnjx7vejHf9GFBcMvPhiuuNwqqrModEo2nq6
         e4+QghGu7FH6zovgRNBWO8BsGFLLLqdnX+JtM9mVP/CwhWU1qo5uzcxuk6sRwn1tl7r9
         qm5w==
X-Forwarded-Encrypted: i=1; AJvYcCXiwbJJy7nLYgWH6NNBrZQF98XqTpUCgvyiUSy7kHQslZItM3aklLHKG6mJPxEn+CL9ywG28lO6SzT04C41XOwOnsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwJlyNCGNkbPAwNonAoUU6W/nZVWSr4u+L00lZjapgXIkgujOL
	jogGZhq9vjbSZa2hdZBQOT2mnRcezHy1Rne5KWVKPs1NylwhKIjNPPn9bS9uJ+tZy5t8isPSjwf
	OUQcODfiMnao2kEUQvAALZqYq+Zsl77NSiE7aeuWSz1/YRgWKbxmqsRzjfc2KvWUvGFMmPb3lTR
	L1Yc1J4PG60XJdyLTrgkTmN8wORL7JeTn16wROE1RZHa7TsHSR
X-Gm-Gg: ASbGncsKeHcKoQYkVOrwF6/xQwcmLOJw7yW30bhEf7LVT1/8g2qtH+XKiJrHVZszMxq
	glLB4jpjkAMJ+p6mJ1u+2huwFKur7PMW+MUEkBNMz3hB1wvjLyQZoyzYaCJBBQMUx+W9YsJScHs
	fr2Mbqfl5lD23JK3vwMcrL6Aq/dM4n02ymrmo4aJihhg/d6pMQBLk=
X-Received: by 2002:a17:906:9fcf:b0:ae4:1149:2cbc with SMTP id a640c23a62f3a-af6191fff1bmr211864366b.46.1753444971186;
        Fri, 25 Jul 2025 05:02:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGa3CxGIXlbxFP3lOtiuZkdJlIwaUJx81JfXJ3+HOkhXlu3QfRGy7bD/MWcI9pNg2Pb+acrpaFHuNWexg0NHk0=
X-Received: by 2002:a17:906:9fcf:b0:ae4:1149:2cbc with SMTP id
 a640c23a62f3a-af6191fff1bmr211838966b.46.1753444969189; Fri, 25 Jul 2025
 05:02:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701060337.648475-1-costa.shul@redhat.com>
In-Reply-To: <20250701060337.648475-1-costa.shul@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 25 Jul 2025 14:02:37 +0200
X-Gm-Features: Ac12FXwuR1pQjDETnTbqboRWzFRIjKwg3JsbDbHR5v4frWCm-lEfoXogMPmmqq8
Message-ID: <CAP4=nvQMyBMay9unMuz0TmkF7pSmHV39iwinSnc3UbuLvOVa=Q@mail.gmail.com>
Subject: Re: [PATCH v1] tools/rtla: Consolidate common parameters into shared structure
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Kacur <jkacur@redhat.com>, 
	Eder Zulian <ezulian@redhat.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Gabriele Monaco <gmonaco@redhat.com>, Jan Stancek <jstancek@redhat.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: c0rjzSnegIxzcT5c1nrr1WnHEngCvseDLIxaCpAM4YU_1753444971
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 1. 7. 2025 v 8:04 odes=C3=ADlatel Costa Shulyupin <costa.shul@redha=
t.com> napsal:
>
> timerlat_params and osnoise_params structures contain 17 identical
> fields.
>
> Introduce a common_params structure and move those fields into it to
> eliminate the code duplication and improve maintainability.
>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---

Thank you for the patch.

> +struct common_params {
> +       /* trace configuration */
> +       char                    *cpus;
> +       cpu_set_t               monitored_cpus;
> +       struct trace_events     *events;
> +       int                     buffer_size;
> +       char                    *trace_output;
> +
> +       /* Timing parameters */
> +       int                     warmup;
> +       unsigned long long      runtime;
> +       long long               stop_us;
> +       long long               stop_total_us;
> +       int                     sleep_time;
> +       int                     duration;
> +
> +       /* Scheduling parameters */
> +       int                     set_sched;
> +       struct sched_attr       sched_param;
> +       int                     cgroup;
> +       char                    *cgroup_name;
> +       int                     hk_cpus;
> +       cpu_set_t               hk_cpu_set;
> +};

Some of these could be cleaned up further. E.g. "runtime" is actually
only used by osnoise, even though it is declared in timerlat, too, and
"period" is also used by timerlat, but it's called
"timerlat_period_us" there.

Nevertheless, that is directly not related to this patch, and tests
pass. We can fix that later.

Reviewed-by: Tomas Glozar <tglozar@redhat.com>


Tomas

