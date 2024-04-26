Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22DB13AD0E
	for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Apr 2024 07:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714115438; cv=none; b=rcWVc1XgVCfHAyrlLzGF26Y8qp4nbftmzbd0AaNcwcixp1WxzsSdrHjPnUUzLRQwO+kl4ucMNBA1v57ham6ncpU9+9nKUpIacE2WYtVAigrUtcqsocDWx9XaCnOcjEb38Qv5uRvu27dQaeqZcHNBWNdfIlPXWwvKRAoUn42BE5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714115438; c=relaxed/simple;
	bh=1HdpD17zv53tya5nbRQzb37y9JH7H8Qt7TstbCf4e9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ULxN2U7DGvqJuAIMoqIpE0c5Im2RAGVnL+5H7641iuf8iIyQRmq/tiHFwpk2WfTGnayGHic6GPcwtUcfPHIJ5b29kEM5KXisr351zB60s6OhsSguXT4gdZWpnqmGUarl25BRLaWNgvp2dYcQgjpOwKer4RZAHPRpyRbAqBZH2qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V1nzFXP6; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V1nzFXP6"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-518948e1ec8so2405e87.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Apr 2024 00:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714115435; x=1714720235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HdpD17zv53tya5nbRQzb37y9JH7H8Qt7TstbCf4e9M=;
        b=V1nzFXP6Qc8Ri5JkSMuMOxlH2DEcILCGuV7Z0Ip/YkwZCySI5Zv80HJ0CjS/iHLQ+s
         yYzPRacuQUQZtbf26qcfbUjIK0IrBer7iXf1U1ZsUIu+XyC2+A4HDoVoUIdPBUkqg3mL
         9IozcjxsJrmYxvpWclXpYqTYBOwAv1Mgw8qvwiX76Ih2SA/84dgxatUjI0nALUvYkWQb
         D4uiJ3zWlCFtIjXo66VLxNkNWMcrb5o6ylN/yix/1fIXAfwKFLXjqFQg75WSEhaqPcuw
         6m9i2ci1OiI2ozowsNmFLyiiu5bl79XbX/laruOuBQkR4bizk6U8ezBbpycO5TiSFk/Z
         SdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714115435; x=1714720235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1HdpD17zv53tya5nbRQzb37y9JH7H8Qt7TstbCf4e9M=;
        b=pSLdF+yZdkyaZtRoXpF+AAbYpHbpGeR43kVGCe7bHBnA4uuAWu4lTQgEHQSLMu/lHa
         nMQZsARLQ39RUdVgr5hLh2YiMJHP6PD4Q8nA/GQn/NSm05RAjlTlachrWcfXCAUGhuyU
         MMUxU4UZ3UBMY7HxAJpOr093SiHep5EHODjhFYo5xgwh33JnZGecH5IIzuvtaxBsvwDF
         3z0/XMTeZj+gXg49yJ4ItMgzWDM3ZYkGzDJtFt89oXnHnHJ86W1WTWtWFgloo3r5X2Id
         jfED/MWRUP2jXAJ+jsgQtno9inFGp9m09wqktdub8neCgq4hkt7VzBk8rnSfGTILq7di
         SLKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGGH84mupNAdjJwT2Q3iddeVTvs/iLfLVDFoVwOR1yjtOHz2FRaRooA+IVaSHC4AaXQZAGBN4iCJgiYRp5uy9+dsKmiLPDlH9dCRWa371bNots
X-Gm-Message-State: AOJu0YzoEy4cFF1dAZ+oxm9fC39o65j+cu5vvfHlaUc6+8XSjkqKPYam
	6p6CmisEaJ83iB2YNfuFYBD8Eaq49Dj3ZRUy7BoglJ49G6V91SQ61EufBS5CpK0VmT3P0zacdio
	PKhW9kowSA7vQEauq1herf8xsBi8bp04K9xaS
X-Google-Smtp-Source: AGHT+IFLgpcyXrDmw4mPYNfyBndZ+UooKXi1ffmkUY+z0h851PXJpHkoqiepekOpKxRIe7dBf7Vsq7Vu2v8cQmWJEz8=
X-Received: by 2002:a19:384e:0:b0:51b:badf:a650 with SMTP id
 d14-20020a19384e000000b0051bbadfa650mr87566lfj.4.1714115434548; Fri, 26 Apr
 2024 00:10:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425031340.46946-1-kerneljasonxing@gmail.com> <20240425031340.46946-3-kerneljasonxing@gmail.com>
In-Reply-To: <20240425031340.46946-3-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Apr 2024 09:10:23 +0200
Message-ID: <CANn89iKbzuPGN=M4YcE5gFGBXDR+DrDigf3E7FfGSr5ac8u=WQ@mail.gmail.com>
Subject: Re: [PATCH net-next v9 2/7] rstreason: prepare for passive reset
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: dsahern@kernel.org, matttbe@kernel.org, martineau@kernel.org, 
	geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, 
	rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	atenart@kernel.org, horms@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 5:14=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Adjust the parameter and support passing reason of reset which
> is for now NOT_SPECIFIED. No functional changes.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>
