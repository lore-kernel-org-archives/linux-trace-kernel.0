Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB62619DF9A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Jul 2025 14:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753885097; cv=none; b=f+n4Ec7s14mXSIAoIY+QR0PLj9vFIJ2rvcR6aZPbepudogm7b4607AgwNiY2uLNbUiNgNBqba4xlvwFhy+sR7pVXmHi16U8Yj9QimqpW9JGqxFUrXkWHPmXwsyPpTYkiB5Wdriz5of9uScq8eT0/dQAQ5HZ1keUvNpBz5nKTsCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753885097; c=relaxed/simple;
	bh=t+XdUySbetWUIJJo0KSa7Zw1Ei6449339h1xdEc7AKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u69DVGp5bqDOsWx42MLGr63+sm+zYFjdIpWCBvdSFlWp+r+5+hW5a3th5rk6Fa8yd28iacYfF8YmvP5wx5uqKA+x0OUbn2G/brqR8J9gB6wmDK02+0ZzPBf8sunzi9YCyvqFDNstpPh4D0r2+W6G3jlQjuJ+OzrVfZFxa3vMLow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LTBTAClu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LTBTAClu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753885094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t+XdUySbetWUIJJo0KSa7Zw1Ei6449339h1xdEc7AKk=;
	b=LTBTACluNUdKxhLxKVC8p6LQjySG8N7BO3IX0aDsI0m1sbuj/otGj8vFazcPDrGFfkGUy3
	bEZdoOEbp5tS56EOnKdebbHjtCT1HCwbm0mJNlRQhGnB0mN0YtXU7Fc0z1/LV3TLwkMVxB
	GxLxC7ZfHDOxviRvX96uzMC7BX2JvJM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-oyhaRKnEPmqCt5Evx8vvNw-1; Wed, 30 Jul 2025 10:18:13 -0400
X-MC-Unique: oyhaRKnEPmqCt5Evx8vvNw-1
X-Mimecast-MFC-AGG-ID: oyhaRKnEPmqCt5Evx8vvNw_1753885092
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ae0c11adcd2so470807066b.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Jul 2025 07:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753885092; x=1754489892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+XdUySbetWUIJJo0KSa7Zw1Ei6449339h1xdEc7AKk=;
        b=G9fagsvrmp//lwAacMQSUam9xsBITm0azqMQ929mHfkX+2bXFxo/RbNWTPU2wh8kAN
         sD/A1DdgRQlc4boJIjVFthXh2jKtbmRFVsFb8XGZvUU5xXBA9S2CO7fmOfBngZC44PJX
         +6UIVMnkUGtZLAi0qBD/GJ3vdedRoe/YSfoaMIgXoHZmpko+5tTmQKkGp0fUmaHrm5W/
         WOXVIEayL1/kgVcgo+BopVSzUDWX1iEtKukvi5F7+xEaeiftVAYj2KmbHVR5mjynXn/D
         k+GdMzwaIt1+ZMvvrS43OipCPUtJscslSvlGL8mAc3ca4rE5/RSNpln28Duyxuq7fOSO
         H7lQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxcI/9tkQs0khcEiX0q7ROUdkNtPpLJ5m3+xo2Z+PkCYRnbbzVgDm5wKAcBEm9VpGQ0wAta/efZHCmqvzD7NvTc1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzopnLjLU0dUbb0HQwIE2zQJdJ6SLMFgXjrqF5n5Z9Rx1VmJx+d
	btOyPWTCuMa3VUsmE9MH0tMlKUVrU4uyDh5QMd+Tc7rDsnr0nbN1zeOqJ9sg4T+9c15IUoDya/M
	xbMXpLEQLEYULIoWdkC3Ki0IdoK0oLk+LjQJ42XHAauSFejheUPea3RVSyT0Qiu4ryqw/4qxzvu
	6VP5YjK3Qy7hme3PEdJZ1TPIJozoF1gqapi7bfvnP5luSjrN4e
X-Gm-Gg: ASbGncuAM88W0zIL/mAT95mCd8BqImFMe+kGIl3GzgvVMCdQM1JCMQNZKcacKdCMUCP
	JUz/qlUT609RGRtVeJZKAP4swnrhi55exXlqqfmC0MbobOuomk/xzeg3u+ly522OLyTd3B1RV1J
	IhtdLdL376VNOkKSe54dzNxAeo+m/iNxt9q85eRkgsTAFC3+rRK44=
X-Received: by 2002:a17:907:d88:b0:ae0:1883:78ce with SMTP id a640c23a62f3a-af8fd9b15a2mr449199166b.47.1753885092394;
        Wed, 30 Jul 2025 07:18:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlSNefCMn8VL1asAYFBErw9EQVssdL+ytIqdvxN27jklDKwvouyVj4iHUy3iqQTvHr0jMpgoVmlIpd0cOzuIM=
X-Received: by 2002:a17:907:d88:b0:ae0:1883:78ce with SMTP id
 a640c23a62f3a-af8fd9b15a2mr449195666b.47.1753885091955; Wed, 30 Jul 2025
 07:18:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250726072455.289445-1-costa.shul@redhat.com>
In-Reply-To: <20250726072455.289445-1-costa.shul@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 30 Jul 2025 16:18:00 +0200
X-Gm-Features: Ac12FXx4xowUzfg1QpHqAj2vPs_ZSJpkqZBvPfLdbkfVkH-lOdJVad_fyktbcHo
Message-ID: <CAP4=nvREsJ=y0F4UhwhvUvK4JUxCKAGXNmDmiDpPB4bdGTs78g@mail.gmail.com>
Subject: Re: [PATCH v2] tools/rtla: Consolidate common parameters into shared structure
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Kacur <jkacur@redhat.com>, 
	Eder Zulian <ezulian@redhat.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Jan Stancek <jstancek@redhat.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hpL1jp08vKk-vQDesKt5sjoRpfttCOjdfUoXs9QPUFQ_1753885092
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

so 26. 7. 2025 v 9:25 odes=C3=ADlatel Costa Shulyupin <costa.shul@redhat.co=
m> napsal:
> ---
> Changes since v1:
> - Rebase on top of recent changes
> - Address Tomas's comments
> - Don't change already not common members: trace_output, runtime
>

Just a clarification: runtime was never a common parameter, it was
just mistakenly added (but unused) in timerlat_params. On the other
hand trace_output used to be common before the actions patchset, when
it was moved to the actions structure for rtla-timerlat, but stayed
separate for rtla-osnoise. If rtla-osnoise also adopt actions, it will
go away there, too.

Reviewed-by: Tomas Glozar <tglozar@redhat.com>

Tomas

