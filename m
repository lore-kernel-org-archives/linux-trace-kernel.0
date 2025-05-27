Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B54B2A1A4
	for <linux-trace-kernel@vger.kernel.org>; Tue, 27 May 2025 07:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748329303; cv=none; b=CJxIVwBpw/gGfJyIY6r3qhAxi0bYkWwlxBcDjpRLUuKBxUI+hJFQSaY8vgjb9ciOblqnm+GOaOqnuwPN0AlbTGXBRBV4fqoOHTd94F6PURhdWnsENfMf/Z37wGqavFfKrSMd3hOOhi7V9gltx4x0A/v1hSJF3awR7blGqqnfu+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748329303; c=relaxed/simple;
	bh=B5q7fiYtct7ipR5s9umhDhISGNUUlTK6+ka1EtTe6qU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XkwqAhdjbngf0TAZRcovcY0iuBCb50Jdm+FBL3MCvE0ERWcauTi2qqdddI8Lc1GUGUTHLeRr77xyYngSMK5X7znS6gPofWfyuyNOb3E+GLjSeyf0kEl5H3tkQ8mG3bwmpv/rVLrlXj9fvZTgJv2F83vh1gKNh+BHhLcGKZ5tpR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JBpewaTf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JBpewaTf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748329301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B5q7fiYtct7ipR5s9umhDhISGNUUlTK6+ka1EtTe6qU=;
	b=JBpewaTfDyGi9JiocNwtCtJmyM3gXKY2cRZ5cWn09lMQsfDefDYf0DTpM7lYE85WC1t7V7
	Quqfw4UkNub/kM8rt/gU4NC6D4pD4suRsxbR5a+ARqMdQK0oPFiCtDS8JnlEdXiFk89ggm
	Rpx/OVc3TwryABqLYPbJvTX4SI+xhxk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-ESp0J0bwOVWdhBbtSXk7kw-1; Tue, 27 May 2025 03:01:39 -0400
X-MC-Unique: ESp0J0bwOVWdhBbtSXk7kw-1
X-Mimecast-MFC-AGG-ID: ESp0J0bwOVWdhBbtSXk7kw_1748329298
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-acbbb00099eso265939766b.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 27 May 2025 00:01:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748329298; x=1748934098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B5q7fiYtct7ipR5s9umhDhISGNUUlTK6+ka1EtTe6qU=;
        b=oGZJhknPvAiYgdmWaEPXWm+8CQIywf1nvM3YXKAcx1hIN9t1TXrbVjkIPjnC3j33Le
         VUqpYCliqjYc6pg+DHucGhSjgAlPdhCA7tyJftT2pFQY8oh6FwbaizQ7+O2F+Q+Q20yJ
         5CWG0m91n+3gadHx4ayrbhWF17xsUtKhB1JimfWqemNlQNk4SW96rjVAK9V4cSF8CTje
         lNSQ+qKMzdBl5zBDEsNMdG+wQsA9tDjiOZtgmBqeHDq4jzozjQUfZ1BzWkxVw8z8Im7S
         DvlT1c1nk7+AyNNl71z7dZZoHmtdjs/eGW2eg7ET8zFM7OfcHepBXVR03/1gd+p5kraW
         DdhA==
X-Gm-Message-State: AOJu0YyjWv/LVALUzJTLOh938Q/emdpzdJ5xhqk8xgcOHtW0mvG7bMvH
	WgR7MF5zPO40bRqVt60TsdRPPGRzcXBXxr0ZGKqIriEkS8rALULJlsNPRd1UJG2P6EFxvZFNbjR
	kP858aDvOe6ho9zpGN8Ka5vv6AE5zyWKH45D6wmrDgX9xbyGsoWIKaQx4WNDagcPvZVLUfevCXb
	lr2J0g/YY8kLo/JwVxpXcKOBDd8Qe/eFrCyWV8+EC0xttge9+O
X-Gm-Gg: ASbGnctB/peOOQWCgVY4hAJQlfbKdbr7WfeMOhXQHCtIROnACCCXE6rlmxixXLK+UoQ
	HQG5JSoS4C4BKkAyfZDo6y/sYZPjgqPs99wXP+2IbbEfw9PQOqQYbpX0/P4NxKa9zvrE=
X-Received: by 2002:a17:907:6d0c:b0:ad5:a16:93ce with SMTP id a640c23a62f3a-ad85b111dc6mr992590566b.30.1748329298068;
        Tue, 27 May 2025 00:01:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoQBshOQNw97WrbnykVFfOBwRPiPHbWbzrFmHE02npKzwvCurG8dt9putxaRx9X0qa8QomW5NOXAbhteVt21I=
X-Received: by 2002:a17:907:6d0c:b0:ad5:a16:93ce with SMTP id
 a640c23a62f3a-ad85b111dc6mr992587766b.30.1748329297696; Tue, 27 May 2025
 00:01:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430144651.621766-1-tglozar@redhat.com>
In-Reply-To: <20250430144651.621766-1-tglozar@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 27 May 2025 09:01:26 +0200
X-Gm-Features: AX0GCFsfTr9K0cUsZVpZPJfwip0fpw-4aurjv4tMnr2TVu5DG8n8tuv2Ka7He_8
Message-ID: <CAP4=nvR80FQydq+4PWpD80KZfHbS43jnV72Q-brhnK22G+Dt9Q@mail.gmail.com>
Subject: Re: [PATCH] rtla: Define _GNU_SOURCE in timerlat_bpf.c
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	John Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZR5SguH8ruMXtlRhaqTF6d54XNLXb1K5Sp6J5v_7Glw_1748329298
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

st 30. 4. 2025 v 16:47 odes=C3=ADlatel Tomas Glozar <tglozar@redhat.com> na=
psal:
>
> Because of the shift, timerlat_bpf_init incorrectly reads
> params->entries as 0 for timerlat-hist and disables the creation of
> histogram maps, causing breakage in BPF sample collection mode:
>
> $ rtla timerlat hist -d 1s
> Error pulling BPF data

Linux 6.15 was released with broken rtla on systems with latest glibc
due to this patch not being merged:

$ rtla --version
rtla version 6.15.0
...
$ rtla timerlat hist -d 1s
Error pulling BPF data

Please have a look at this as soon as possible, so the fix can get
into 6.16 and stable.

Thanks,
Tomas

