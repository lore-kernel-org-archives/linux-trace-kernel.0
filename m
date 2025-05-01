Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1204D253B4C;
	Thu,  1 May 2025 20:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746133008; cv=none; b=ZKCYheDG5nv9aUUVM16BupBZUQVJmxcyKICVQxBGHJFl7hGFgHdBekTO2GPnL73cArtn3djT1qjYPTBU4vkygmwy6pPv0Is8Y8v5JmYe6+Chd1+r99R50QDVOMBdsv7aWiym32CllP6y1RDx7tfW/agwpx+wmDiQn+X8NEkGjAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746133008; c=relaxed/simple;
	bh=yZp03o1Z50G9fI3eUVXLknB0P6oL+Hc/7Tqr5oUMmC8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u/QYYOmNvtcox7GfDrmGgfNI1GZrv+42jQo8B9h1jMSRPGH/KqrekRx9OaRfyubDoEprVCE480WSA774VvrTKwMOnvBIaSW9qidr3e3CQHkW/4vS7IMgxQng05rYsyYthhr6HEbi8RZtjyJ3TqgeLQMFP2kU444afvdcx5niluM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flQ0vCFo; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flQ0vCFo"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a064a3e143so560334f8f.3;
        Thu, 01 May 2025 13:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746133005; x=1746737805; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yZp03o1Z50G9fI3eUVXLknB0P6oL+Hc/7Tqr5oUMmC8=;
        b=flQ0vCFoauInbVrHzOpnoAOYG2AClNbolSYDDcsXLhcJkJWlcCFLckeYgMRBsIsr/z
         sjOHg6i+Pufmuw7LDffylRBM+mvbeDPdNWOa0n0AnOWHRZ0IUMAN2UEdodCLrGiBOU2p
         QN6NmucILHBXYgjzXgGciVZfrPJH3am352dZzsIhe6wk6dJaVm4FQMK7Mmdrhh9xGGyt
         b6wi63a0ciiZXOxw/wnkkJMdd60rxu9eLaH7uxsXuTD01Gd9t5rJoNiTk90qKZsMEBM3
         5UjmVrg9GkKU0S451MKvIgGl9KveuqZNnvBpcwjLX7leQN9ie8SMInVijjNp+Dq43IbE
         PpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746133005; x=1746737805;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yZp03o1Z50G9fI3eUVXLknB0P6oL+Hc/7Tqr5oUMmC8=;
        b=MWknGesm4poFvZPzCl6up2kg0ldsr4n6/9n+kOYvx5HEOh+Bf6NbebXVnTgA7XDIEm
         FUUUrtl4Qlh/oqv4qamRla003RzXik04ijIGS2gm8iMGv6jyGeuuKa6t7DBaLE+z3jHa
         Y2JRaPcDe5tU45QCAwbmT+x5eKeTiScJbJZUUKlnPUdrZ3MK5ZxK9RZDs8L7QmbaOvvM
         iI6R2IBaAWsOsP3b7O/U0XmkQSk9HLgWzqarvkTGe7jldaEg2UFMhcUn7iyrXg7rVaZF
         Dkf5u5UN9J0iG6XxIjy3cf3wjs21ZegEW8cOnjuoq4nyc2WXqiRnDoZDTwpaM9nZRdeI
         od+g==
X-Forwarded-Encrypted: i=1; AJvYcCU4Xg0a/kehO50/OgsdGrGFbF8TtD0GAPymlxO8JVb0lPTGa7VIMOmP5qMBTfGK5SvVfcSTTUqwzI3Yp8g=@vger.kernel.org, AJvYcCW1ANJnZxUV5aGXCYk2bg9/+P26FaQk9WS8UQevCGMg/O/XVvT618uQJuGPKm8CSqw62w3t6B2I0Rce0CKCX+Afm4uB@vger.kernel.org
X-Gm-Message-State: AOJu0YwtZQpsyAC91KLCA9ZQI1akcb9dDmf/d/21j6ZlHAoz3DHvjBLA
	6sgY3B9HDkRJlEskNvAg1dVntm3gf4b5HtG0kb12mJIOWsnWCzm+vCF4hTM07D4=
X-Gm-Gg: ASbGnctMI+o9617aVYrqwtZmEv5/SaVqPzIfdlT7dIFlng9WW+tCEr9shWtKvzhfU/V
	AUfr2GmPetjmbCHYQU1yLXbPt/wZASFLQMuacKuS5yiv3hcdFlc8zPk6gVmg8HGBJ1MszhOlct6
	mZldSnibSM353hWZ4gjfbXZhJn2nGAPHwytjF9Ot0LsVEj+VRDzMbq68o3/OVBnhlnA8zgFpsH8
	Y/MwGojHpbwHiueCgv2cKHpwDxKrDHeZvMYObeo8n6QAFeqhOL1Q95M7LmhWYRMjMAWd+9iwNaF
	BhgIN/5W6Zy2/7vReab0YYsBGSnKU0kXVyLHXIpZZJdbZZPLiwtBTfD11ENApA67INx8GCXyeXJ
	DKLIP5BTddyXJC9M3suImH5vFlXQAUSPB8KZNCiiOR4Lf0sUXhhmqxDnkCW1tqpHp9chSnvK9Hz
	j/Q7BC4RBv
X-Google-Smtp-Source: AGHT+IGqcd2sO4GysuHBNsbwMWiR3CqRlK0MMF5r1Nv9nH36qkof0Fl39WTgp7YzDqIZlgZ8Xsm6xA==
X-Received: by 2002:a5d:5985:0:b0:3a0:831c:dff6 with SMTP id ffacd0b85a97d-3a099ad6208mr165723f8f.18.1746133005319;
        Thu, 01 May 2025 13:56:45 -0700 (PDT)
Received: from ?IPv6:2a01:cb08:fd:9b00:540e:212e:2ac4:9aae? (2a01cb0800fd9b00540e212e2ac49aae.ipv6.abo.wanadoo.fr. [2a01:cb08:fd:9b00:540e:212e:2ac4:9aae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b170e7sm189287f8f.86.2025.05.01.13.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 13:56:44 -0700 (PDT)
Message-ID: <0b13bbd0001c41ca1866ccf58f6e9de6ca2c24d9.camel@gmail.com>
Subject: Re: [PATCH] tracing: fix race when creating trace probe log error
 message
From: Paul Cacheux <paulcacheux@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>, Paul Cacheux via B4 Relay
	 <devnull+paulcacheux.gmail.com@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
	 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Date: Thu, 01 May 2025 22:56:44 +0200
In-Reply-To: <20250501154503.2308f177@gandalf.local.home>
References: <20250422-fix-trace-probe-log-race-v1-1-d2728d42cacb@gmail.com>
	 <20250501154503.2308f177@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42app2) 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-05-01 at 15:45 -0400, Steven Rostedt wrote:
> On Tue, 22 Apr 2025 20:33:13 +0200
> Paul Cacheux via B4 Relay <devnull+paulcacheux.gmail.com@kernel.org>
> wrote:
>=20
> > From: Paul Cacheux <paulcacheux@gmail.com>
>=20
> Sorry for the late reply, I just noticed this patch.

No problem at all, thanks for looking at my patch.

>=20
> >=20
> > When creating a trace probe a global variable is modified and this
> > data used when an error is raised and the error message generated.
> >=20
> > Modification of this global variable is done without any lock and
> > multiple trace operations will race, causing some potential issues
> > when generating the error.
> >=20
> > This commit moves away from the global variable and passes the
> > error context as a regular function argument.
> >=20
> > Fixes: ab105a4fb894 ("tracing: Use tracing error_log with probe
> > events")
> >=20
> > Signed-off-by: Paul Cacheux <paulcacheux@gmail.com>
> > ---
> > As reported in [1] a race exists in the shared trace probe log
> > used to build error messages. This can cause kernel crashes
> > when building the actual error message, but the race happens
> > even for non-error tracefs uses, it's just not visible.
> >=20
> > Reproducer first reported that is still crashing:
> >=20
> > =C2=A0 # 'p4' is invalid command which make kernel run into
> > trace_probe_log_err()
> > =C2=A0 cd /sys/kernel/debug/tracing
> > =C2=A0 while true; do
> > =C2=A0=C2=A0=C2=A0 echo 'p4:myprobe1 do_sys_openat2 dfd=3D%ax filename=
=3D%dx flags=3D%cx
> > mode=3D+4($stack)' >> kprobe_events &
> > =C2=A0=C2=A0=C2=A0 echo 'p4:myprobe2 do_sys_openat2' >> kprobe_events &
> > =C2=A0=C2=A0=C2=A0 echo 'p4:myprobe3 do_sys_openat2 dfd=3D%ax filename=
=3D%dx' >>
> > kprobe_events &
> > =C2=A0 done;
> >=20
> > The original email suggested to use a mutex or to allocate the
> > trace_probe_log on the stack. The mutex can cause performance
> > issues, and require high confidence in the correctness of the
> > current trace_probe_log_clear calls. This patch implements
> > the stack solution instead and passes a pointer to using
> > functions.
> >=20
> > [1]
> > https://lore.kernel.org/all/20221121081103.3070449-1-zhengyejian1@huawe=
i.com/T/
>=20
> Honestly, I don't like either approach.
>=20
> What could be done is wrap the internals of the function in a mutex
> so they
> are not re-entrant (using guard(mutex)). If two error codes are
> happening
> together, just let it get corrupted. There should never be two
> additions at
> the same time, and if the admin is doing that then they deserve what
> they
> get.

Just to double check, what you are suggesting here is to include a
mutex in the shared trace_probe_log entry, and to lock it in all
accessors functions (trace_probe_log_{init,set_index,clear,err})?

>=20
> I don't care if the error log gets garbage if there's multiple
> accesses at
> the same time. The fix should only prevent it from crashing.
>=20
> -- Steve
>=20
>=20
> -- Steve

Thanks for the feedback,
Paul Cacheux
