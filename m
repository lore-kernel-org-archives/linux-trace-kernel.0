Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59297202F70
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Nov 2025 13:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764077767; cv=none; b=G+z3Fe1sUSIQ9nWaZSwT4k1Da384rpiR6K2RAjRm5CEDzJP0yTDpgeh4h9cEgQfcgDQxmX/VRhpKDaOcpQeI3wwa2J22Q7nt38r2t7aO6GDyZEQLsTnVQFAmZOGY74RU6tqff84IwfyyLSRZX0JTTmtPt5oXBWRsFSi2r/ycYZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764077767; c=relaxed/simple;
	bh=xwY3y3HDGheQGyX9/WqkHxlFNQGZJRxalK/IgYXKa3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ueDsqA48TwmecvxHtS9k3l7aTYLpqro5xlbi+HPwBlqOm64WFB33Ijwyinglk0zny8+NfIeVPl2N3FWDX08+Ldy5up1jkGdq1WImqjSar2T8+Eo+fOgVgujLUWi0RNUxdn8xzDj+aKY+pWV06/U4QtGeKpeTA1Xw5WVNrlkNHEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hQriu8vB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQriu8vB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764077765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mv5Bj08W6kUB9lAgfyoQC3HTxuz+qjQY+LBVveT3DZM=;
	b=hQriu8vB6DoTmizSWgOdJ8gJQtztnDRrE/Jb5uubf1jHcAlcA/oU0+HAIalWuX508AKWAp
	pYxVGDFt0SyX4DauI8d+H7yFsRanijl5IEeAsXxH95nGmK57pbMyTCLQOqr8V7YJIWH067
	ExchUMjbBQspmzghXHHeq9FgViIIWBI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-SMHQG-i-MSKMYy9ie-tAxA-1; Tue, 25 Nov 2025 08:36:03 -0500
X-MC-Unique: SMHQG-i-MSKMYy9ie-tAxA-1
X-Mimecast-MFC-AGG-ID: SMHQG-i-MSKMYy9ie-tAxA_1764077762
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5957bd7530aso4757109e87.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Nov 2025 05:36:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764077762; x=1764682562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mv5Bj08W6kUB9lAgfyoQC3HTxuz+qjQY+LBVveT3DZM=;
        b=NcAg20t1xm0cIik9WCjzYZq4/oh4+vAxcRRkGjMgd0ZCCOfDbExfxtts17gWlQftrY
         z4UfCOkJ63QlUdPSJASy8GApVUw4sTRhJ6clB4HAVivNhrSwsRGnlgsVO5bPx9KdE+es
         J06ETpEn31nOiarYkf4FAvXo6xSriMbj86o0Uf3rN0AmshPzrGwAoeDzJJj3PSdwef6W
         yIHig8bFGXJcAZ1jR9cH03STWR/zTgBsARfThNUxA3beBzF8+0CmubFUU5FN5cmkdf3p
         LXItOsCDms+DcBgBFIJl9rE01EAku3zWtAmxCbvI+vMMhT4y4hey31L2nET74v5/99cD
         mlmw==
X-Forwarded-Encrypted: i=1; AJvYcCXEFLoRQi0YNFW7NRWWr8pHnIIg32Hsmf5dQesKuW4/zNyRurAOwEbLTxIZ2k9fuGJjoaUzAsok6dxJjwOOdilTGIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB1uMzrDoHZvv25TRVzsfd72WMc2HGKVCm/0qIX2YTu+8BiHmn
	1W4xXjNlDFvTf7g1Lx4L7cbGLQa80kjw1vX8unRXFCOiX3UGHJZh6n5GjxxV665BoJRVn28Yuad
	B3esZ+rXkWwAh3Rykm33WQTgghzI6NPg+6bIM0wcS8G8rEXMQrzqBDnMziYwjPDPa/jWVyQ1sAF
	Gu0bcsiQB4ZUd0OcduzxRIUs/YhN5+8Rm8Yd5JEojGJsX8DxM9
X-Gm-Gg: ASbGncu/b86E2bKvZSsqhv77FGMBb3F3Ivk0vxrz+78pMNA4jlzlKnPcuR72hSk7v+z
	8jclHCjWDDfMggN7qWUay6VSQSoF/dvCDfRneaCLIERToEqeRkwe9fqqYbyjugusJMWNfg6J8Z8
	zMuG52NRWl5hMEfO3bWCUMvSi66b9fNUCvIY3jK9ZIrB1FTrHsRiDCiG2cj2Gr/KP1tA==
X-Received: by 2002:a05:6512:3341:b0:595:8258:cccd with SMTP id 2adb3069b0e04-596b5268d1dmr1075022e87.45.1764077762229;
        Tue, 25 Nov 2025 05:36:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7DCISxfPZfZPbnSRrXL2OgS9ShigQz7dQ6aM4hWiY/ATXquxoPvJj1PZY8LQSXEOXXZhX7IYCH7WkuGAToeA=
X-Received: by 2002:a05:6512:3341:b0:595:8258:cccd with SMTP id
 2adb3069b0e04-596b5268d1dmr1075006e87.45.1764077761765; Tue, 25 Nov 2025
 05:36:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027153401.1039217-1-tglozar@redhat.com> <20251027153401.1039217-2-tglozar@redhat.com>
 <ijizcoufpxwtrutqpurumsx7zls2dixyanlcn6oshvhpon5osd@aeuzrsmkidrz>
In-Reply-To: <ijizcoufpxwtrutqpurumsx7zls2dixyanlcn6oshvhpon5osd@aeuzrsmkidrz>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 25 Nov 2025 14:35:50 +0100
X-Gm-Features: AWmQ_bm-QxT3Aw-Lll45vO5xpV4xdxbIAWkL0k_5LflxFNWwkMDM7UGCrMDOakg
Message-ID: <CAP4=nvQ69aK8NQno4X-WoHWF1yPPTiHwMOOKrzVGFoh-=oepRw@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] rtla/timerlat: Support tail call from BPF program
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Crystal Wood <crwood@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: C3RVDc1qxQUrTVZxgF2rN4VszHGDoajhHJxX6b-ArB4_1764077762
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 3. 11. 2025 v 15:24 odes=C3=ADlatel Wander Lairson Costa
<wander@redhat.com> napsal:
>> +/*
>> + * timerlat_bpf_set_action - set action on threshold executed on BPF si=
de
>> + */
>> +static int timerlat_bpf_set_action(struct bpf_program *prog)
>> +{
>> +     unsigned int key =3D 0, value =3D bpf_program__fd(prog);
>> +
>> +     return bpf_map__update_elem(bpf->maps.bpf_action,
>> +                                 &key, sizeof(key),
>> +                                 &value, sizeof(value),
>> +                                 BPF_ANY);
>> +}
>> +
>
> I believe it makes more sense to add the definition of this function to
> the patch where it is called.
>

Maybe, but I wrote this patch first, the rest of the patchset some
time after that. That is why it is this way; either way, it doesn't
hurt to define something before using it, the other way is worse.

Tomas

