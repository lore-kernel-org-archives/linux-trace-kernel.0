Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECB1243367
	for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757590215; cv=none; b=dPB46pgAjRW+0osZiEz1yXxlz1yWzWTfXY1bi2V78uyht+vqQJs5t+H3wTzROCl7KzhWrepT1/Jtlu4DCkxPdYOo5IEoQz5fGDLiTTdd0EWH8Oo6+bkoncLrkN5BUrjqOEevxBLrFY5yonSVgpM3aiYVH4cbFR9hzhVRlIYKZNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757590215; c=relaxed/simple;
	bh=NUmiUFiqfUg6KgSkyEEB4x1tZCu5PrZcN4T6cI6Oiyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpXRLXOf5J18kz6IfUvGHMYwSX05qdvsTzIWvz6ufQYGAWmPeSB1YZzLra9/Qt7ekI4LTc+dEkn+f6YS6eaJB48zxZ/oK1K1Py1G72c6bg+T7Hz2YprP19tRMRJG3JZMDPgPjXD4RLlDywgEDnhPnbUQjRafmW9bHjYUwAOgKWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fwFaA+vg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwFaA+vg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757590213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NUmiUFiqfUg6KgSkyEEB4x1tZCu5PrZcN4T6cI6Oiyc=;
	b=fwFaA+vgpU9xZuo+01BlbtZmEGTeuCaa94JaZa3Gx9OLiYE/YS2JPaLHZHza22nsva2K0s
	mLjtJp56e4hVba1sLIAOAjQ1ZunL8uDOckr0ZI9aPZNahybscqNVOchUP28kv5tMeaMZwx
	zUaE6l5StAby89WD5iP0jR8z5sCtjwY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-v86A4UUGOK2zsKWew4ZsSg-1; Thu, 11 Sep 2025 07:30:12 -0400
X-MC-Unique: v86A4UUGOK2zsKWew4ZsSg-1
X-Mimecast-MFC-AGG-ID: v86A4UUGOK2zsKWew4ZsSg_1757590211
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b0787fed7c0so58628466b.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Sep 2025 04:30:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757590211; x=1758195011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NUmiUFiqfUg6KgSkyEEB4x1tZCu5PrZcN4T6cI6Oiyc=;
        b=NpjP2A5qSy1GxAolMfb2RJ06jRhLrzI0bWJH1rQ6WfSpasDb0woTR3djXhn4Qi/M+i
         7zZVubve+xZcDytdSC0UdNi7TxAfrrWblydibM1u3QCPh+86X1384CDtkAWalIcJPhvc
         /odA8ZrmMrUGp7f/1PwI2akXxo+6CEG+WUwbWq0m1PbT66Oj1tjGjDGjBGMJ8mK/UYeL
         iD9gl/kzXdCxd1vP/o4K2y0xdElkqGEafrbouPTjTl4zE5XCThR8+TXpobJ+yY40pH1P
         J1PG05oIfdGVuXJtkWmym8ECyNhYi1kwJ3oAcYDTY2P5PyCbwBosCsTjezwZaXxJ/pV6
         /0RA==
X-Forwarded-Encrypted: i=1; AJvYcCXsGwB9G150IkZ5eTRwW7IroeqXu+zfnKBnZSLOFlYJrW0AEW7crMBMF9YcsiWV/rnkWRwn4cis6XxU7cvsb7v84mo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye3UoVcK66RC/DlZP5CX6VGajk1NLclgyrP9XOV+fMvb3xdTfC
	4ww5wptAmazDuo/JnTjIah3JiGkRibjxT29rz0W3EhCOX8sQmtxE2U+dbSsKlN7ws4kNt0d9WIK
	t45ukqp7QJEpW6lwu9q4mB6YsyuK9iKBPbMLHGrk9OEXb+/bMMzr+JJ8DowXYysbec1LmWmBQUm
	0gPXQNfZYhrwcBiSK0U/HN/MZTMo69Q0yUvMpi2DCETCz1hAIP
X-Gm-Gg: ASbGncsJyBNDP3fnHDHiGXrY3kCqIaZacY35AhGpGFis7gixc7sy2icjPQ2smnvnOcS
	nYSHd/icx8EeEpIhORrC8X+NUr7osgOebmH5+XjE9lUvzA5XeMSIgL3eQz9FzhfMo/fRRFOdUfX
	nvyVpF/BlqWzr92rjR20c=
X-Received: by 2002:a17:906:7308:b0:b04:ae68:afdf with SMTP id a640c23a62f3a-b04b14afdaamr1804647366b.28.1757590210887;
        Thu, 11 Sep 2025 04:30:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnABc+KFrFpfTUERSeqlhV9AtywAZEQJi2YB1sLvQMPoBwEtOIxY8SSmmHUt7hjQ06toD5GKHKNh8zL+UX7Lk=
X-Received: by 2002:a17:906:7308:b0:b04:ae68:afdf with SMTP id
 a640c23a62f3a-b04b14afdaamr1804645166b.28.1757590210487; Thu, 11 Sep 2025
 04:30:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1757034919.git.ipravdin.official@gmail.com> <a093065d78b7a4377c084fb4dc56942aedc5f6f2.1757034919.git.ipravdin.official@gmail.com>
In-Reply-To: <a093065d78b7a4377c084fb4dc56942aedc5f6f2.1757034919.git.ipravdin.official@gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 11 Sep 2025 13:29:59 +0200
X-Gm-Features: Ac12FXzz8um6-S3OMseB0U311Zcv84vqKdIlRtKjeumvmaIu22hPwQtw_OK_DKE
Message-ID: <CAP4=nvTZN6G+KAovidAZbYNt8Ubh64bfkKVDUMDCJVwPO+=DNQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] rtla: fix -C/--cgroup interface
To: Ivan Pravdin <ipravdin.official@gmail.com>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Y4UeP9bVbKNRwAcdm5KMIRoXd4BU5yZD7Ct82EFQZcQ_1757590211
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 8. 9. 2025 v 4:06 odes=C3=ADlatel Ivan Pravdin
<ipravdin.official@gmail.com> napsal:
>
> Refactor identical logic between -t/--trace and -C/--cgroup into a
> common function.
>
> Change documentation to reflect this user interface change.
>

Looks good to me, thank you for implementing the refactoring, now that
the logic is shared.

Reviewed-by: Tomas Glozar <tglozar@redhat.com>

Tomas

