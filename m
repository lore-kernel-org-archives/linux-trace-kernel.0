Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC36913957E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 28 Aug 2025 06:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756363994; cv=none; b=SL5nbsffbsVhCQIKjvrbssb1th7tzpwbl4tvDCHF7oUKmXu+ffyoEJV8HxhlCqItFI7WTPaArVPgl/KGZQ1N6jjrJTBDm136ld6tLbUPKe2bq3mNpdKgdx7WFfMto1gMwQfAJxw6IPCqVZOXzypko0zQvU6VC4i95u5bvcaXoE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756363994; c=relaxed/simple;
	bh=3R2A0X9jcrId3uVLOqivrclwkr/91oEKCBENyJHtKy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LhZ0uo7suNf0B1xJrtvKw2MjVbTUJuf9OPQdBl3+HQZwPzWJFMmMbU3ZoBsrp9xo1tFbDZF70W1BS/FkOxIcR3jb9r02s26vnbUp0t1OFwQqZeZ6Nc/UBasOtPtFD2BbSTusPxIwS03NJNJ+LBNZ1uzZ2kD/DO5oxCp7qP0Wx10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hZv5P4pK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZv5P4pK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756363990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3R2A0X9jcrId3uVLOqivrclwkr/91oEKCBENyJHtKy0=;
	b=hZv5P4pKQ9JGbsA9cQfvpFLvk+15e+SrxNyEqCM38wUI8eilINqkKwXe7RFo7myE6x5dPN
	vOLUCh8peDbkqvaRW0BwZASobV0CFVUp/nuNN+tAeQ1igQcZwYdBFK+3Fw8ZRrlQEBHj5r
	Zx1Kv31JrBFUyyPyCeN4WPAu6qySnQE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-yw3OLu70Nwmej_Q_lsoPsA-1; Thu, 28 Aug 2025 02:53:09 -0400
X-MC-Unique: yw3OLu70Nwmej_Q_lsoPsA-1
X-Mimecast-MFC-AGG-ID: yw3OLu70Nwmej_Q_lsoPsA_1756363988
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-afec9fd1a3eso36481166b.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 27 Aug 2025 23:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756363988; x=1756968788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3R2A0X9jcrId3uVLOqivrclwkr/91oEKCBENyJHtKy0=;
        b=D3WmlQApP7kCPtV8VZoonzjvlR90jA04RvLUnmH7U5gWZWdHF4KYHwBcP+7oL2XwWI
         ikkZT5+5oGraU18uTFDb525ZVpjwVyRng3YqwAmhw2tRC89DYfCwdQn82Ltas8lqTfEb
         LuFMuu3tR58tZILv4tRPjK/jNBv3W/lUOTPOEhwT9BNdejqsWvH/gO/pIWeAZbSWA8rk
         l7XSUvNWPk0ntdmJke9g9wjFLI535QEYTRrINkfd3LJ7//xcVAITuOpNcy7TY5ODyHQ+
         rLCg1nOxDAum9PMtjRwm7LASsmHrYyRVx6yta+/PpmJU056dH8mCvEuF07gjgcC7R56z
         bw0w==
X-Forwarded-Encrypted: i=1; AJvYcCVpyZTvuyJVGd8Isros0QIo874z3HCsAsBixvhHWQiTJ36Nflkw7rpILQtJ/CO+V7to764OVRbPjLydKEhdCv2vODM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPmBS00iLet2KIZE+Jw1D58s28OCkwgNxzLuuMvNiQXbsWN9ek
	ancP3lebF3lkFjro+RfULJE5k4UzuVe/PqnlaCbwphIKMOrYjyr20syw0vzTzuYYi7oO0NmuGMi
	veolnJ/hl90ZtF2Pky4waJaTzvtZ4kmOZrZToXhAGQ6rjdqzKJehD0AX1SvXiGnsFAhNglWN7Xy
	ZyE7FfuxWkJNOIiStmtW/AM/ZiViBNW5/3rL+wSIWC1BMFw2lk
X-Gm-Gg: ASbGncvqGBz9ZhNaAv+EOkS9FUe0JWCBwXxtRpuSD1zuf5cvyShSVUzXJHueeTAHfCS
	qllY97rRE6N9WrAFJe5YyqGJgB7JX/CjXuow0RcaMub/upga2ZDicCEhDxKEWbHGDUxneGbNy4G
	hEEOo/8iHzIrvbeWLGOO4=
X-Received: by 2002:a17:907:25c5:b0:afe:ed3c:1f4e with SMTP id a640c23a62f3a-afeed3c3959mr58868866b.14.1756363987864;
        Wed, 27 Aug 2025 23:53:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnqhF7jF5cYYRgG1SWlyxvi2aSi1JY45ZaeHC9ZcfZCdAM/dgGrjRPs+PEe0Fp0SzDSOe6xgD+HE3NPfxRMI4=
X-Received: by 2002:a17:907:25c5:b0:afe:ed3c:1f4e with SMTP id
 a640c23a62f3a-afeed3c3959mr58867466b.14.1756363987506; Wed, 27 Aug 2025
 23:53:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821035719.137161-1-crwood@redhat.com> <20250821035719.137161-6-crwood@redhat.com>
In-Reply-To: <20250821035719.137161-6-crwood@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 28 Aug 2025 08:52:55 +0200
X-Gm-Features: Ac12FXxxzlzMonshrCvtIuIHuJR_CYv4ug4CidcR0xsM6sCEoT_5Ol8e2svZgsQ
Message-ID: <CAP4=nvSSh22tHQ3yqS+t8VjcpYxYQUi5VV2Qh27bJyXynGYbFQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] tools/rtla: Fix -A option name in test comment
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
	John Kacur <jkacur@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _SbXjrtEKmaCCO1Q8a6LFLXZHEBxN2wR13jiz3N7ZPE_1756363988
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 21. 8. 2025 v 5:58 odes=C3=ADlatel Crystal Wood <crwood@redhat.com>=
 napsal:
>
> This was changed to --on-threshold when the patches were applied.
>

Right, that was changed at Arnaldo's suggestion in the next version of
the patchset. Good catch.

Reviewed-by: Tomas Glozar <tglozar@redhat.com>

Tomas

