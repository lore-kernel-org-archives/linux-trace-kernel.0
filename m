Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E228243364
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 May 2025 06:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747635668; cv=none; b=gttaVJy3RCiQifIcjZv2AOlueJTDz7RyX0nw23XPHL5AexPUR8U+Jn4rChlK8cOI40cvvAijIlKFwjC1P8C7SMF+MlHvAgl3yUwsVwKeYmaNXaS5T7QqcrW0ga2b1vaHL7eUw5BUBaiIYeTBTQgOVq/TvBxyAeYDP4C4RhoLQiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747635668; c=relaxed/simple;
	bh=fH4ypnsI/MfhhHZ+DxWHo23PH+rJEDeMHxcWT6aZwo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kr1rDH2qyN5PgaGDN0tzlhqHDIC0OZ3C6HHjjcrOwJ3JYcA2LTmStX/nzM0UQb04oWEYveNTBF9gdC7fgTa+izWwtwr3W85m4sB40M6kVDbadEHxnqCUtLhg0n5e5CBn8XVZpRGXLkDGd3eavMBU9rwV19s2VXPRbSo60+Q1z74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SFuTk/I7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SFuTk/I7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747635666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DxY7EgT/RNd0tv3+QSKlLScSTvHaTBPFXOYePAlhj1I=;
	b=SFuTk/I7L0Pv8wZqWw0E6qDrUVs9gyj7dSf5U3Z87t8qn1SFd3LrImtr65Zc/DS6n22/HX
	XZhwoLLgyTpfCnkWMzrMKPIH6Ch0bVZnWLQeAqR3ZKuOpktew+gWTKyJl16em3mscuMIgT
	rXzg9fcKJr4Pmpy1/kN7RC7QlLKYGK0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-QhTuNKGANeiqhzg1tF5uZQ-1; Mon, 19 May 2025 02:21:04 -0400
X-MC-Unique: QhTuNKGANeiqhzg1tF5uZQ-1
X-Mimecast-MFC-AGG-ID: QhTuNKGANeiqhzg1tF5uZQ_1747635663
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ad5669ab33bso75684066b.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 18 May 2025 23:21:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747635663; x=1748240463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DxY7EgT/RNd0tv3+QSKlLScSTvHaTBPFXOYePAlhj1I=;
        b=bW+/56I7lm+MS2VKEcTxgOmWNSiak3lkpBcuWm5arc2qxTt8CGEAgDGcuadYTt9hFd
         HwnLYtypkf52cCP19UkvHVIt61mfseD4V/unEqJgMWWd+gt933wfG4dbhqpYUvzSbc1Q
         3SpvWn+xRf41ZUNXFNwpZH4KeyxKHaFVU0xOfKP7EiVx1ytK/NioOcrQcpng12jF6qrx
         RQeeyy4zAt6XxRRUXxVdG6YgNFGros8zsrauWfP9X5IaMzj5otlc8jathzQXJy1sgkd0
         C2Z6L0XwNMFiYXvMQ04pfgzizLKey6wWzpfOJrWXXWhmTSn4jk9ytCnPUlLgwjyQdzf4
         JsjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/Oz+3dxvNCRhtlGy6jY1A0SN820lrGB+ofXdu6SI6q5Cqb8HEP7csMNbZYV3dsBFW0v4m+hbkpsD5tdDZcEgB8AA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4uZpfDCmW3BkqiqaXuQI5yiJ/QAHCQ73bqBrJSJGMQdYofq0n
	NZRyWrAyT2xorigVvkYkzqRjCUAPCSBGywIZs7I/uparTiMqxro022q2w4clzikSSm/Q4vjkpqv
	PkQXApKvGpt9gBpe2C9EnScEoBE9GXW4pPKDcReMg1YQnSIvw64+KHRTGltqgdsDX0ikAZn4Lc+
	i8dMt9V9E/ekoy2X2iUbwIyIxVsirM9Fzk9/LwlXdfYRnHIBaV
X-Gm-Gg: ASbGncsl92xypFay8Pbbe6e9TJHmhrvtFHzQFW5yjP588LOfPY8HA9oIbgul5cvJqnU
	jHXMpC8ga755TxAdB2Bre7ITm8h8g8mE3DTngkBzrZNZYhrCwsnLcV4ccQnGSw5P8ub3xyoZ3ea
	E/4zGk+8+G/45Rgafe0v7tuwM=
X-Received: by 2002:a17:907:97ca:b0:ace:f2c2:5a4 with SMTP id a640c23a62f3a-ad52d49e2c7mr1055602066b.13.1747635662890;
        Sun, 18 May 2025 23:21:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAmjmvIL3o1iKm123C/5o27j1Q6dvBrOmlO7D05cMeFXjqCGVtdtOGto6dJkIIUfbXvpluId+XTMClkgAgqEQ=
X-Received: by 2002:a17:907:97ca:b0:ace:f2c2:5a4 with SMTP id
 a640c23a62f3a-ad52d49e2c7mr1055600666b.13.1747635662518; Sun, 18 May 2025
 23:21:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430144651.621766-1-tglozar@redhat.com> <5c64d78a-1650-5404-c2cb-8190627d10fc@redhat.com>
In-Reply-To: <5c64d78a-1650-5404-c2cb-8190627d10fc@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 19 May 2025 08:20:50 +0200
X-Gm-Features: AX0GCFsSVtCoIj9QVehT1OHITqlahuu0UR84rYeizFCjucynqTCzS0iI1MSeYnQ
Message-ID: <CAP4=nvThhq_0vF_xGCEnT6oNhpt_JHoEuOPmy3uT7jR_0r-YbQ@mail.gmail.com>
Subject: Re: [PATCH] rtla: Define _GNU_SOURCE in timerlat_bpf.c
To: John Kacur <jkacur@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Luis Goncalves <lgoncalv@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mYp_q0YLNpBYVOgjXi5pZn-oeamikQ30KeYBeUGIwJ0_1747635663
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

so 17. 5. 2025 v 0:22 odes=C3=ADlatel John Kacur <jkacur@redhat.com> napsal=
:
> Question for Tomas, should we spend sometime to make this work for older
> versions of glibc without a definition of struct sched_attr?

Older versions of glibc without a definition for struct sched_attr use
the one in utils.h:

#ifndef SCHED_ATTR_SIZE_VER0
struct sched_attr {
    uint32_t size;
    uint32_t sched_policy;
    uint64_t sched_flags;
    int32_t sched_nice;
    uint32_t sched_priority;
    uint64_t sched_runtime;
    uint64_t sched_deadline;
    uint64_t sched_period;
};
#endif /* SCHED_ATTR_SIZE_VER0 */

In fact, this one works fine in timerlat_bpf.c, if you build rtla on
older glibc, it will work even without this patch. It's the glibc one
which is not defined without _GNU_SOURCE.

Tomas

