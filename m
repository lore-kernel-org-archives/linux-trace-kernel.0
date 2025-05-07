Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEF3205E3E;
	Wed,  7 May 2025 06:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746600563; cv=none; b=uusGlUwlL67OaTeCGud9fMzkkFVbL/+eXa7AsdguFf10nwDgIdt07KWKLjLfewvZLqTG2eGqqfTR+pGxgYboplR2fWbZwirDOMrJ9GOUrloCzp4DZq/ZdTHilydCVTPlr9agNEayS8MUfkaFhxrF4AYQ/P+v6PqqMZVoSngFL8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746600563; c=relaxed/simple;
	bh=8ugSN/Q++fFeHEFwZ8K/qUbkB7KehZljJdjvuuNIdSw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sH325H0h0RY0xco1KHoL9CL2e0IFkckhklMtVYHmLIYeAVb/Zty3wknbzPQscpk8LgRS9V2RC/BoLGSxFcJ5cKpZexjIZEwaP5WY7LP1Bzf6ObesD+ngFgCPDqyjFo5agKMcNj0yDYtIyhHi4k7+piktQTiewO/Af++QfyKSEuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Le5lyCpN; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Le5lyCpN"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39c1ef4ae3aso351580f8f.1;
        Tue, 06 May 2025 23:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746600560; x=1747205360; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=txqfYmUpRqf0tzhQiLRxaSFOm23Kw9v4JDWZZtETggU=;
        b=Le5lyCpNNKrQyxYnHwyGBIHSuRci0RZyICBDWShAFC7ufJlsYIcSMBp3LagWJwfJkB
         qhBCqdFDajfWefgaXTPgdTt+4FFn5tGiSvGBhwtfsUS3M8RUMvNOgNav29T/MJ82z1CZ
         dR9c9Pt1iu4b6VID+5cdKcnSNqEvbQ8eBPFfidWlM/WWZZnePxjE2e7KKGvpb1hQFXDe
         Tod/fsqkJDlDXZE4EaChYmbXVYvcbnowfx7E9dT53myZ9+zNbzm0yxLAb8GvQQBwkP0n
         rZ48bOBHx6Wf2tFnvhYDYpVjJG2OkKio2sNjQIsAQhe0ZLxiHVUiGeciYn+VMbOKIcFH
         vd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746600560; x=1747205360;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=txqfYmUpRqf0tzhQiLRxaSFOm23Kw9v4JDWZZtETggU=;
        b=s7P28bo5ZuKdh/VAjSXZcuijARcTGMMFtIeKADtfiWuiGIhn1dLuXiN/exfTjPcuIV
         FVkaQF4o3Xg6GORXOSUJi1duMnnRON1d+GtC7LxBm8Yr3frtIsdaeXkm3iHfshhUVKug
         p0I3bvsVpYwX8xlJ2Fnyp9jFivRDUsfTWaicz1I4smVfL+fjLOmiYFXxRlloa5jPcZYZ
         y35VtrZ9BUlDl31/jBxwq2CRKEApFL49mCJDZEorQPLdyOyf72jTOWxKuYnb8xSXFeiI
         5v2PWOZLhsKjnyo1MczyIirVa4kzocGp39iF3sd3Ize1bSrQEqD0U2G2OlOHaDYaTn4L
         fefw==
X-Forwarded-Encrypted: i=1; AJvYcCWVQXLWeR/VWBCHyZzK7Es+tGDFOYtDjInKl8FR5qIxWcvuTeWUBVnn0ROqcTZwYEznaRJj9xv0w7+fAniQXXJenfe1@vger.kernel.org, AJvYcCX5q9i4g61O/K2qR6OLCwgFpjfn6fISboXsL3M2OQtRTwrGBhJPICFut+mlj7wpKSbyyD3ljhg2PNNg5V4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+T+/KLhpjirc8X+SfEUjIMKTM8Q22vc+uPfBYSIg0MCWucI3N
	bIPfg4VEShRIW7QeyE7yuRmIFFJ32agXsylJ4LE85QdhrS/ugcIR
X-Gm-Gg: ASbGncvHmgGnETeT6PsvavM5NWtSvINeQpt7tnvZgh3fICizpUbhKQ2Ntvpk0w9s9ke
	eDIMg2+QdGbyStL3qRstgTeDLpZLGqHCff3/GW46c99ptuIjjY8iBRP6z7Kg6E7fWClCBOoN9L+
	MAwKguYybIiLCDEnkyUq7FWkVM4Rz1FKcnhZrXpx6K7fq6/G/kweTl2VBRqeinMvapb+DvVDFmp
	wcVXyoxs5e87Hm88N8mmRiHFbdonovuaTx8zfG1ogvOjCJhF6UVhPPOL4rwio++xPpQhalUED3l
	IFNoAhib0pwbRoUV+lfzrVgorTRhQNQrjscrV/GuLMUu36AtJJUhStBaUYG5IykjJ54z+BgnqGC
	j/xOaZ/bSDfs3LVwl2F7io8MAwzu7S72QLydwClBbeIMtGuVvca+dCRGQra8rOTzMqw40Hs2rpw
	==
X-Google-Smtp-Source: AGHT+IFoy0Mjb7OZG3tS9F/YAZ6Z+ylLZSL8zsjE8WRH4kHA8aG2EgKEizH30q+B2qwM1XzEXcEUgg==
X-Received: by 2002:a05:6000:2403:b0:39c:30d8:32a4 with SMTP id ffacd0b85a97d-3a0b443f32bmr1800389f8f.26.1746600559533;
        Tue, 06 May 2025 23:49:19 -0700 (PDT)
Received: from ?IPv6:2a01:cb08:fd:9b00:540e:212e:2ac4:9aae? (2a01cb0800fd9b00540e212e2ac49aae.ipv6.abo.wanadoo.fr. [2a01:cb08:fd:9b00:540e:212e:2ac4:9aae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae0ca4sm16128355f8f.14.2025.05.06.23.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 23:49:19 -0700 (PDT)
Message-ID: <d9ada0e159c130885dc43aaf3a672b2ea5a3b623.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] tracing: protect trace_probe_log with mutex
From: Paul Cacheux <paulcacheux@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>, Paul Cacheux via B4 Relay
	 <devnull+paulcacheux.gmail.com@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
	 <mathieu.desnoyers@efficios.com>, Namhyung Kim <namhyung@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Date: Wed, 07 May 2025 08:49:18 +0200
In-Reply-To: <20250502095025.1bc0426e@gandalf.local.home>
References: <20250502-fix-trace-probe-log-race-v2-0-511ecc1521ec@gmail.com>
		<20250502-fix-trace-probe-log-race-v2-2-511ecc1521ec@gmail.com>
	 <20250502095025.1bc0426e@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42app2) 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-05-02 at 09:50 -0400, Steven Rostedt wrote:
> On Fri, 02 May 2025 15:15:53 +0200
> Paul Cacheux via B4 Relay <devnull+paulcacheux.gmail.com@kernel.org>
> wrote:
>=20
> > From: Paul Cacheux <paulcacheux@gmail.com>
> >=20
> > The shared trace_probe_log variable can be accessed and modified
> > by multiple processes using tracefs at the same time, this new
> > mutex will guarantee it's always in a coherent state.
> >=20
> > There is no guarantee that multiple errors happening at the same
> > time will each have the correct error message, but at least this
> > won't crash.
> >=20
> > Fixes: ab105a4fb894 ("tracing: Use tracing error_log with probe
> > events")
> >=20
>=20
> No space needed between Fixes and SOB.

Sorry about that, fixed in v3

>=20
> > Signed-off-by: Paul Cacheux <paulcacheux@gmail.com>
> > ---
> > =C2=A0kernel/trace/trace_probe.c | 6 ++++++
> > =C2=A01 file changed, 6 insertions(+)
> >=20
> > diff --git a/kernel/trace/trace_probe.c
> > b/kernel/trace/trace_probe.c
> > index
> > 2eeecb6c95eea55502b83af6775b7b6f0cc5ab94..14a7a0b59cd20a8bc43e3e7c6
> > 53e986081f924c8 100644
> > --- a/kernel/trace/trace_probe.c
> > +++ b/kernel/trace/trace_probe.c
> > @@ -154,9 +154,11 @@ static const struct fetch_type
> > *find_fetch_type(const char *type, unsigned long
> > =C2=A0}
> > =C2=A0
> > =C2=A0static struct trace_probe_log trace_probe_log;
> > +static DEFINE_MUTEX(trace_probe_log_lock);
>=20
> Probably should add a comment here saying something like:
>=20
> /*
> =C2=A0* The trace_probe_log_lock only protects against the individual
> =C2=A0* modification of the trace_probe_log. It does not protect against
> =C2=A0* the log from producing garbage if two probes use it at the same
> =C2=A0* time. That would only happen if two admins were trying to add
> =C2=A0* probes simultaneously which they shouldn't be doing.
> =C2=A0*/

I sent a v3 with the space removed and this comment added, thank you
for the review.

>=20
> -- Steve
>=20
>=20
> > =C2=A0
> > =C2=A0void trace_probe_log_init(const char *subsystem, int argc, const
> > char **argv)
> > =C2=A0{
> > +	guard(mutex)(&trace_probe_log_lock);
> > =C2=A0	trace_probe_log.subsystem =3D subsystem;
> > =C2=A0	trace_probe_log.argc =3D argc;
> > =C2=A0	trace_probe_log.argv =3D argv;
> > @@ -165,11 +167,13 @@ void trace_probe_log_init(const char
> > *subsystem, int argc, const char **argv)
> > =C2=A0
> > =C2=A0void trace_probe_log_clear(void)
> > =C2=A0{
> > +	guard(mutex)(&trace_probe_log_lock);
> > =C2=A0	memset(&trace_probe_log, 0, sizeof(trace_probe_log));
> > =C2=A0}
> > =C2=A0
> > =C2=A0void trace_probe_log_set_index(int index)
> > =C2=A0{
> > +	guard(mutex)(&trace_probe_log_lock);
> > =C2=A0	trace_probe_log.index =3D index;
> > =C2=A0}
> > =C2=A0
> > @@ -178,6 +182,8 @@ void __trace_probe_log_err(int offset, int
> > err_type)
> > =C2=A0	char *command, *p;
> > =C2=A0	int i, len =3D 0, pos =3D 0;
> > =C2=A0
> > +	guard(mutex)(&trace_probe_log_lock);
> > +
> > =C2=A0	if (!trace_probe_log.argv)
> > =C2=A0		return;
> > =C2=A0
> >=20

Best regards,

Paul Cacheux
