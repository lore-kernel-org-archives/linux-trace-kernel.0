Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EDE33E7
	for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Jul 2025 11:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753700857; cv=none; b=euJPI9qbEUwZ2H6w3I38Zcw1qkWxG77R9rHT1FEcv5Oy8ZfWKfWkfTqndDGfA2pDrO5KraJo4Wz5L8mWofQczrt0Nd7d6PKm5pjFqh7WbraZ5gDlPfyS4uvKAOQkeNNROyPX9YlOY5NjtsuD0VpF7eAE4xSujsRhRqQaa4eedw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753700857; c=relaxed/simple;
	bh=3pLYVdF0nsoFSAeexE3LC5Q4ZaY3uvZPzbJ5RP104kw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rHzr7FXJkQsjmF6OfkYXSLy/ibQGv9uArzyD2jKN+jjOj9UBKPjf8bylkBHT1ZVRpQEn8bUzo0Im9Mo2cCluegkxlqIp2BRS4+AYPkiN7a/S2UjptAgFwDYbVVXChPHbrYFy788DLASmbSEXFOzI5oh2Xbz5cwKu/pJP9UBjqHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SFtYPbyN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SFtYPbyN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753700855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3pLYVdF0nsoFSAeexE3LC5Q4ZaY3uvZPzbJ5RP104kw=;
	b=SFtYPbyN7O9idVotXqppmllDRewcGD++72RQ8jRZ0W2lpqesLqTt9c1s0Cud1XbC92k+Ph
	rehI1a588A7o0foZQZssgMCFb5lPd7lPgYEM1dvHw4P4nPk+BjanikLTHItV4k97N1sqdm
	tBzJ60etsUK8FqvRPAkSAgdXx5SXtts=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-Be45GStLOGmi0H8OBXz3Pw-1; Mon, 28 Jul 2025 07:07:34 -0400
X-MC-Unique: Be45GStLOGmi0H8OBXz3Pw-1
X-Mimecast-MFC-AGG-ID: Be45GStLOGmi0H8OBXz3Pw_1753700853
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b7806a620cso839108f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Jul 2025 04:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753700853; x=1754305653;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3pLYVdF0nsoFSAeexE3LC5Q4ZaY3uvZPzbJ5RP104kw=;
        b=gBTdh/IhxDORJotz+r1traK1caNult6bgHmbz89TFDel8vQ/r4jYaunuy1XBRENQu8
         bLAobNGHEPCNFQNoJlfCPlr/ayXYuqtjNsNmHC2JTPf/bpNQXd15EnnALHz8ukCcjNP9
         GSW+6l2roGKJeAgEpShcpedKFZmxaZbUjm2oGo9IPH7/xOhu1GQEVG8GeGPF66vjbF97
         Q1c5DcAkUUndj3EzW8BYQZajC8OTSkO14BPLDiWS+548cwi9cDWoiaOJcjLvTiJaKAwH
         b/9eiJV7rusdBTIuo+npFDnYMwm+uYLxNRXv50HlkVKTvkHIjh5huZ/nLxeATxGKBhTv
         pZTg==
X-Forwarded-Encrypted: i=1; AJvYcCXikK3jzsGxbid0Ba5H+FqBWX1S61cl0ys9D3gZzojgC4ZfNX1mWlYe0sE8UXExZGSEX0y28nnXc/Vbb1ed+u5DW3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+5O5COmcO/6BTfzde1gW9eavlTrNUhxAH6PUsuf/tevf+sUHD
	kjyCBEvVK0wg6DMhqs0XTL469xZt51Du3fJGjiOzyZv8whqtcezpFOd6ZID4xtWxBz/XTGuCW0W
	lNkKVHhO5wansgUJh9Cm64OGzPUc0HpLX9jB5v1DfdEeS59X6m7CJpQRj9Zacf7+gVsmd9VOnLA
	==
X-Gm-Gg: ASbGnctk+TBGxjKslIT/Acwn5MDYJIoZY5vLhkewjin03XcDnNs9E6oR6QCm4nPQLPV
	firLwhfJ7OHQK4u1BV5jWqJETp4c1qzwgzp2mxNUKjaSiLeG9BqYc7F+enJHnAgKKfFJKSOAeRZ
	HdNWQE2SXlrcX64EpWHYJeEk9UnygFmINmUAGHsmPkUyY9Aw3nhCCfF/AKxMhpdh348t4nT+4n8
	6801mbFvdT+jiIBHRxZF7g6X3LyMSal85R07Sya8FYKn3/HEODOXXSaH9uCFuGIZZp/F8FpCzXS
	mHaNsqXzV5ObmQEHDpRC0K7sqzBaycbKmgOL6DDgKAU/mksNQ7kuD3ysvSlcrsvwqg==
X-Received: by 2002:a5d:5d0d:0:b0:3b7:8ac1:5e30 with SMTP id ffacd0b85a97d-3b78ac161c4mr1349606f8f.52.1753700852640;
        Mon, 28 Jul 2025 04:07:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHc9z70EWwmlpMr+OkfM8TnShKy6POOVuw5YobTxWmrC2LyX9zPwQLNTb4Hr7NxYaUNLOK9aQ==
X-Received: by 2002:a5d:5d0d:0:b0:3b7:8ac1:5e30 with SMTP id ffacd0b85a97d-3b78ac161c4mr1349575f8f.52.1753700852173;
        Mon, 28 Jul 2025 04:07:32 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587abeb39esm93840635e9.13.2025.07.28.04.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 04:07:31 -0700 (PDT)
Message-ID: <8d2c34e9d1ac5534ccf856242c13f2fd3c1000bd.camel@redhat.com>
Subject: Re: [PATCH 1/2] rv: Fix wrong type cast in monitors_show()
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 28 Jul 2025 13:07:30 +0200
In-Reply-To: <20250728092756.C8zMlJtT@linutronix.de>
References: <cover.1753625621.git.namcao@linutronix.de>
	 <35e49e97696007919ceacf73796487a2e15a3d02.1753625621.git.namcao@linutronix.de>
	 <786688d8a5ab0d5228d271861416d49cc3a8ebc3.camel@redhat.com>
	 <20250728092756.C8zMlJtT@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: q1ylcKepmppcy_XxVlPVF5WZZqQ7EBI5t1HdTO_nulg_1753700853
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-07-28 at 11:36 +0200, Nam Cao wrote:
> On Mon, Jul 28, 2025 at 10:59:01AM +0200, Gabriele Monaco wrote:
> > Good catch, thanks! The container_of is the way to go.
> > Do you have valid reasons not to move the list_head to the top?
> > It's
> > not a big deal but it would save computing and summing the offset.
> > It
> > doesn't seem name (the current first element) really needs to stay
> > there.
>=20
> I checked x86_64 and riscv64, the generated assembly of this function
> before & after moving the list_head on top is almost the same except
> for
> some instructions' intermediate values. Both architectures have
> instructions which load data at (pointer + offset), so this offset
> computing does not require any extra instruction.
>=20
> Best regards,
> Nam

Alright then, thanks for checking!

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

