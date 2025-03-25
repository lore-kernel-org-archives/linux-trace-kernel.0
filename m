Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA4A1A316E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742917735; cv=none; b=HBKzEMyNGBMec7bgcXU6ag00r3wYLInMdqfaL6DDqojCcLnVOHNC3h8q7k0KQy7eMRCp29GEBzU1B3/c96Rz0mKC0UePvbhqBkQVysKCkJ+RCyJbqHna3BR/uGtj0c/wOzRrdsFHZEd52hxxrfqkEM9pVIPsF9nOpRK/YMriNXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742917735; c=relaxed/simple;
	bh=yqgGOiWrNPG+wQbjX2ddul66Titgdg7RfSlbjzQ1Hks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WvMcNZp9I8CamJjDK22uqh4G19hh1faAdgib4annLskpq+fQAPpuLsBN2CoUDcOqSYsxLHYV2HMnchl6VjLSh8LgnBY0kfhZeyKGIBIemtBhx/nwN+duINwI6jICkkAXNBGU9ZaoQbJ7NmGiCLQhN3eF4oMCzB1sG3IEh/0fHf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BqhMHwwg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BqhMHwwg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742917732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yqgGOiWrNPG+wQbjX2ddul66Titgdg7RfSlbjzQ1Hks=;
	b=BqhMHwwglYXCD5/8d7Iq3lZBU0IbAwbKVCFfyMc0T1ZMgkWO1COlpEZI+eK/5PTVfjLECq
	ifZ05WOl97r5mRLqUNB24NkyjL1F4tJSHh177VaLcbMJSxsKtDCxsq/clfit25ZKBg/7+c
	aB+j8DLoK7k+0KjxZyGamQbeh3L6uhg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-fwCWwJG2OMOwmgbWl6cI2g-1; Tue, 25 Mar 2025 11:48:51 -0400
X-MC-Unique: fwCWwJG2OMOwmgbWl6cI2g-1
X-Mimecast-MFC-AGG-ID: fwCWwJG2OMOwmgbWl6cI2g_1742917730
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac3dca41591so432786966b.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Mar 2025 08:48:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742917730; x=1743522530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yqgGOiWrNPG+wQbjX2ddul66Titgdg7RfSlbjzQ1Hks=;
        b=M3XxVDRUljtNmM9aO+1YspRZkskr1sMTnmOh60PPZuhUXaJjQxqX1E9SUhJyubqxDN
         526rHpFy5XxwA8Nh5+yStS9I6gDLJl6KVOluK4uERg/g9fiwOU62LnXT7KceSiz/Ijqn
         4mXXbnB+zz8Tkk8nK/6KLee4GAcC4iJE1/ZF4XmnTAOc7gf6lUndQupOVGB2Q1U2PufA
         cLHgJOjoW4zHQG2KQYlFW082DswrNEqxz0FKoQBo8y6RL6qcBy98HBYe0VJ3xzPh1i7Z
         toVZxZKYUU4x3+hawmPlLAchM3gHjXiU91hexK2dx3h+YWN9fXMkIvY5QwgnKUpFs5GJ
         1RmA==
X-Forwarded-Encrypted: i=1; AJvYcCWS/UFbVgHVaLyvCRQLVWMPtUf7UWiQycSPd5N3Yc2cER6bBNCcROPv0f2hwUNLcCh5/CJJrwE4b7E7K2vmeQ26oo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKuWedVo4duoIDiZWDRe1kuaymz188o482gfFD2vdjNelOUewA
	cmGHykICH2RfPGzwMdiFHAzsC+C8K/AbDpInLUaF9ovPOkTLYtQ1KZ0q3e22NT8mrOvwgp/sAgG
	+OS02jfM1YPcjyUUjNaDKm6/Dtbdm6Tnn2SM92pReWbSlf/qiiU7m5BxxRQZyyJ2IO1hOyhl8mK
	mgqmHur9WeDpELY8nsXdgDutAzUgjwUFhpEbfp6oCRGLkd
X-Gm-Gg: ASbGnctg/riXYNESN9SudvwOJR8HixSjpuTbMPi060WFM41vuwgrnpjD7vDLDlIiuI0
	c8HkCF8t7rsxLAWG51AkR7LY0HIv9PV/L7hl+I1A3HzspnYsPNuNV8SdBLNtEHeHWpA6G+rx48g
	==
X-Received: by 2002:a17:907:f50a:b0:ac3:45b5:d325 with SMTP id a640c23a62f3a-ac3f253011emr1834030566b.52.1742917730277;
        Tue, 25 Mar 2025 08:48:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFD64oBfGmIy4l7ipkxycYxKe6ZIbenXBCa1X1NVXvuOTgJbZUFc6bXWv82qD2ySlajcuBwkr3lQOUImvYCoOM=
X-Received: by 2002:a17:907:f50a:b0:ac3:45b5:d325 with SMTP id
 a640c23a62f3a-ac3f253011emr1834028166b.52.1742917729882; Tue, 25 Mar 2025
 08:48:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250322183439.393533-2-costa.shul@redhat.com>
In-Reply-To: <20250322183439.393533-2-costa.shul@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 25 Mar 2025 16:48:36 +0100
X-Gm-Features: AQ5f1Jr0dsAtsjzTVe3U7QzJt6ah2IQQOliT5wpbbU_ZQBdQgNVZsG0gU14KJaI
Message-ID: <CAP4=nvTXEO=i7Rf4ONOpr89XoFLnkGYKp78xMLZk4yYh6dnZEA@mail.gmail.com>
Subject: Re: [PATCH v1] rtla: Fix crash due to NULL record dereference
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Daniel Bristot de Oliveira <bristot@kernel.org>, 
	John Kacur <jkacur@redhat.com>, "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>, 
	Eder Zulian <ezulian@redhat.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Gabriele Monaco <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 46A8xmzzb2sWXsALssuMje6vmL-NIDdHxUzP2OIsAKo_1742917730
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

so 22. 3. 2025 v 19:40 odes=C3=ADlatel Costa Shulyupin
<costa.shul@redhat.com> napsal:
>
> The previous patch introduced a crash by dereferencing record,
> which can be NULL.
>
> Add checks to prevent the crash.
>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>

This is a duplicate of my fix [1]. I added a NULL check inside the
function and made the callers pass NULL if the record instance is not
initialized.

[1] https://lore.kernel.org/linux-trace-kernel/20250313141034.299117-1-tglo=
zar@redhat.com/

Tomas

