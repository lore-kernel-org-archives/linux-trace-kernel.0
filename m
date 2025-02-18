Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364F8267B6C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Feb 2025 13:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739884896; cv=none; b=NRX6xlnktmcI+bNnle1DflKCNskmWc1O98TXQJu7UzVFYt8kTB7I+59V8TySOiFPRm5LG0Vsull671Ugt70eMsoad+zz28+taLuIgbAMsOIqrFE9cve646vHqbEm8flej1Dr4NVp65kt2Cf5bHvFPj19hlnsdYrjW4xX9vZH9G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739884896; c=relaxed/simple;
	bh=vNJSYCuYen7yBiUlt8/F/NhDj/0DDvBzBZsO/cYBZN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=udtCicX4wUkNlwik9VYIQNfIejmrJPYFz2xr+87coepmutZhjTsC3W6KHR1ANRsZKlu2YTwWy//1ldG1EM4sFRBCVV0ovf3f9zBvUWwCn/4pdfQJISMIO1MHtcGG4fg/HP+8pUqjoqoNWnu53ivExKtQlScRupgwckCz4Uo6Nps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nPbVYq27; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nPbVYq27"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ab771575040so1260266366b.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Feb 2025 05:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739884891; x=1740489691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+VRsn+AEynXrzDApi3GOCSB7kda1CeXhMpv+TvTGpE8=;
        b=nPbVYq27ZawqQJs54gG+N7vhAULaE74Dqem+QI0sRYaGaOIjWBLt2QoG5tcUwc3LMp
         djms69G1IJbBIk1ct6zk7pVYqfjOSgeYAf1iWCENh67LoeMVSEmtydzKgGJj8Tc9l76C
         WuuqeQDDCyIOEkOllnD6jyoXevFsQcasuZukogKipx1PWdsMNubuA/XAumbQ6PQB0tCr
         LDq4O7XA4VwzBc0u7AbTzZgXWfg3RuYBBH7nZtFulbaQoQ33NLbqRW0+sYsNyXBfmtlh
         B7bTNzWWkIdw/MSwZRTtOdCcvSY0gklRCtR63UEM1Bl4QUWvq/a9E0hNY2sAlnXk0UBj
         MlSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739884891; x=1740489691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+VRsn+AEynXrzDApi3GOCSB7kda1CeXhMpv+TvTGpE8=;
        b=lEuKqKpVq6U+F+DzMutKoDomJbOw0jUtfiWqkDL5YNzlN/1ORv8jMOSUVMsofPxh8j
         L8dlPEr2NIqvWSd3yWsSqCvgMVOJuYukhbrHtQ6dzrW/heBA9/Z9jElkaFmgUJOtyuFN
         21/O9+/8RbDCW1ckSZROjNMoOnVHZ1Y+HsuH8ieYKiTI6hWEv+zqUT4kPmbz9EZicpZB
         5fu6DrFlvQ2OzQpdFcgnAKKOR4OfV+OXilOacxfG1EG6oeARPIOG55tLBWhAhPahz8IV
         2cRVfhyF9+tAhaqipimDf/BcOgQnC45hW53Em4DfCyDzDQJ7zKMpxe2wFBo+gbPbv7yP
         wtJA==
X-Forwarded-Encrypted: i=1; AJvYcCXw9SKesMJO3LAU2/+fGXg/13bw4Fl/S65awJXNQfvuyUN+AZu/0ZRcBC0Wtdk6ynlFTlX/sPiiGrfSOAthzSfPN+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxClY888oT+CRp5L6eg/JkM161NW1m7aX06z5jtgOzLarPEaXzr
	600OdcTWOoNRKDjNrxfkAH7IX68dBslbC+uyOq6dUDTFWSap7KwG48T0Y66b925P7rzdXiIKhqJ
	AJhb7GiAjPdRpHVJ5w10sTvRELb9k/RODVeDe
X-Gm-Gg: ASbGncsKv+mkx2MAb8xjfiMCkv9U9CrQADLUw12CmT+Lj9WJeK33sIlZTlFBLNPe/sS
	sTGC6QfU/9NDWslsWH1Gg1kYuo5yNWdqU22GDHFP54UHoiOAVwVnb2LwLkOFQtS60kFSoFJ0D
X-Google-Smtp-Source: AGHT+IHENWMLQyMCFNyQoxq+tfzbXqrmhbnicTEoipxWjXHMkPQJj0dvAxcA8gbOg9IcuPizgSbv9RYX5Ub2iiHYQEw=
X-Received: by 2002:a17:907:1903:b0:abb:c457:af69 with SMTP id
 a640c23a62f3a-abbc457b75emr101178366b.0.1739884891353; Tue, 18 Feb 2025
 05:21:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214-cwnd_tracepoint-v2-1-ef8d15162d95@debian.org>
In-Reply-To: <20250214-cwnd_tracepoint-v2-1-ef8d15162d95@debian.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 18 Feb 2025 14:21:19 +0100
X-Gm-Features: AWEUYZn0nWNA0Mz8GXU5V1iIM17iCX9C2BuP0-zp0BUC-CYDsMjMQia2EAIfB_0
Message-ID: <CANn89iKyKTD+vQwG-h=oczX=tfBJeY9SVmXFX4a7yMXJCvuJ7w@mail.gmail.com>
Subject: Re: [PATCH net-next v2] trace: tcp: Add tracepoint for tcp_cwnd_reduction()
To: Breno Leitao <leitao@debian.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 6:07=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Add a lightweight tracepoint to monitor TCP congestion window
> adjustments via tcp_cwnd_reduction(). This tracepoint enables tracking
> of:
> - TCP window size fluctuations
> - Active socket behavior
> - Congestion window reduction events
>
> Meta has been using BPF programs to monitor this function for years.
> Adding a proper tracepoint provides a stable API for all users who need
> to monitor TCP congestion window behavior.
>
> Use DECLARE_TRACE instead of TRACE_EVENT to avoid creating trace event
> infrastructure and exporting to tracefs, keeping the implementation
> minimal. (Thanks Steven Rostedt)
>
> Given that this patch creates a rawtracepoint, you could hook into it
> using regular tooling, like bpftrace, using regular rawtracepoint
> infrastructure, such as:
>
>         rawtracepoint:tcp_cwnd_reduction_tp {
>                 ....
>         }
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>
