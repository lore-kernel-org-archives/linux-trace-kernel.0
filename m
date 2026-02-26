Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8725945BD59
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Feb 2026 16:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772123183; cv=none; b=Ynvz1/N4DtWbJvzIYP58UAZK+jEeWTXfRapkkpWGDJncpPQeEPRcrxJOSdidAUNz6OwWPSG3IxXoD6q9Rdk5mmh1KHp9k6/FURES4OgmhDmcEFl0KSR+OmeRtVhtysYx/TH6BNf1/9brEKEzVsqFBqVVFB9/exWP9FWjIJZU1vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772123183; c=relaxed/simple;
	bh=XFaNZAqmnHcozUU72k8HWucrxaLqBXr+lVplmNcNFuU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=doKoMMzLKrXykfkt15H0JVwo7RanbXCx/5xG+AhG0N0TI7BfvGzkCQExfIOOJNC2tdl4q/iLcxeN5hdAR99GyZ4cB7Zai7hYp7QQmD+Rj9ngpwkRA4MB3uJHnXiqD24/htRlpIWMet/vS4U51vl5Ok+hainzeMykcYkxFphsJZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LAR9ckqI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LAR9ckqI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772123181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=XFaNZAqmnHcozUU72k8HWucrxaLqBXr+lVplmNcNFuU=;
	b=LAR9ckqIr6cK4Gy+hmugnbzuOPl8kw8eW7jUu4t00S0n22ekqIM3yFgA7Cb6dXTP+HFtWt
	LPaBNAH/pi7tWxy8dMrC1g6y2UA0GjbLfB6+jE9c0SaFFoKcBITIqqVAHvIc+2iORNjBCo
	rYxaXlfkP6o6Eetm3GZ71PGx83X08/8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-zpDFxRjYNKqKSiDyw_ZqAQ-1; Thu, 26 Feb 2026 11:26:20 -0500
X-MC-Unique: zpDFxRjYNKqKSiDyw_ZqAQ-1
X-Mimecast-MFC-AGG-ID: zpDFxRjYNKqKSiDyw_ZqAQ_1772123178
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-65faa6716b4so1446215a12.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Feb 2026 08:26:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772123178; x=1772727978;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XFaNZAqmnHcozUU72k8HWucrxaLqBXr+lVplmNcNFuU=;
        b=GeNQV2BpSlMfmXjUJiqKiG+TaWOwfSAKAAITktYlQCnbCMSjQ8/94jF7nvFd28IZId
         JDxg8dZfu5hAzYw0+QxCZwr3V+5mJ4p7bFX9jdz+yq8TibhTb5GS81o6pSh5eWbco0hP
         4LSPtuanCsnX5wsLb6S6skqpTNzs9PBsRLyxDT6/0pz2IEwUXQSfJ5RT+41nVQf2Pdwv
         hYR6/OZy7kb6ItqqWTyAfKZCWkwGt4YN6VUrHP4BKbzas4bzD9d+HR6SscPZdChNmm1a
         uhnTufdXhJRZksdmjNmGW/KPAxAeX1dOqvD9FFJbx+J+/thrifRxYeqUca0VIEbyXL57
         z5Mg==
X-Gm-Message-State: AOJu0YytgPiKoCko54F7z062CQwGQSUeNuca2H9xxPuwxHnWC9a5OP/n
	JSHY/vZ/adhofigF656a5R2ygVwyZTCQskyLZrJnRW0ZQQbaVxOkE21/DM0mf7TwfLsjKN+9b2j
	tCFGeVUgGpWxIUcm291kmtZ4g3UIYSRXecmRRSb+8XKlw2EDyl8s7yP06bGInCoBTNlDS2e97Yl
	Altu5HqV5GNwSIlCsT/XPHKFdg2aDe8DwP+V+0O7Jq0tooxo5m0E0DWxmP
X-Gm-Gg: ATEYQzzOL8ATWpH+gqd/SPWoOKndx41+Rd22E7p/Oo1lR6R0rfX7TIjoAYJ4LktYGB4
	gSQAX8sDibs+pdOexwMFVtgybaQGUvVtEM3Jrn/SiiHR8+k8dDeddHDG+gtL7PhbTwWGV18mIgx
	qHBmIloxa7p8L14ul2nwDJbFV64NDeLA91HdFQOx4C9QG+4IXoAV2V05q5DM/dDfv6ATeHhSlvR
	CpBE6HgatW4M74cifLZjHqavoWTIuxVYcI4o+N6LUNrrGO+XA3BPcEG4StWnB1KuT7e
X-Received: by 2002:a05:6402:26ce:b0:658:e665:766c with SMTP id 4fb4d7f45d1cf-65fb6820198mr1581854a12.8.1772123177740;
        Thu, 26 Feb 2026 08:26:17 -0800 (PST)
X-Received: by 2002:a05:6402:26ce:b0:658:e665:766c with SMTP id
 4fb4d7f45d1cf-65fb6820198mr1581829a12.8.1772123177294; Thu, 26 Feb 2026
 08:26:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Paul Murphy <paumurph@redhat.com>
Date: Thu, 26 Feb 2026 10:26:06 -0600
X-Gm-Features: AaiRm52yIQMwZtwfelpB7OVBI2ZecFnWKyBzAmd9RWNaVqcWHR43CqeyJhUvOJU
Message-ID: <CALYDSrR0rcAsYmqv_yxkh8ojvDEmkKgOnrx=uFn9aCJoWcCX2A@mail.gmail.com>
Subject: mcount/fentry, patchable function entries, and ftrace toolchain support
To: linux-trace-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Og-f3PpBVJfmuFrLDAUYagOODWLmJ22PRh5iwdOUHls_1772123178
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

Hi,

I am working on adding more robust mcount/fentry functionality for
Rust. Particularly, support for equivalents of the gcc extensions used
by the kernel (-mrecord-mcount and -mnop-mcount). I am unsure about a
few details.

Are patchable function entries meant to replace the usage of
mcount/fentry? The fedora x86-64 kernel uses both, and fentry for
tracing. Do some kernel configurations require both? Is fentry/mcount
support needed in a toolchain which supports patchable entries?

Thanks,
Paul Murphy

