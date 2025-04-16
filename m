Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137011C5486
	for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Apr 2025 14:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744813868; cv=none; b=Bhb4WJdxb1f2P81T/HdXOQqQVR7K9dSgbnPOrGoDTih2blYerJbhegLSlqtRpDJVC3/01g40r3D0UOqYqYnQrUD6tqyVWAcmUWXUQmYP89n2RmJ8r98hHuB5ctkmO0LHGtRpxY/Hyes0okwrE3g0X7feP2DEVdi4kBNONhoXym0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744813868; c=relaxed/simple;
	bh=M3aKjuBSofdl/WfprYl6DJmKZ07dVKfFKg7ZK124i70=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+5pcYDutW7PLzSqJumps/HitFTow/4fMMRB9LGemuXoE2LZUYCKzVpIcEc7TYWR1f5ImL25tY1ANGVYi/wmfnxEibFZfy3TfFv+ErqnYl57/fP47Iawsn3hUUi0nlRlKC7oJYt/hnplY9ZqfMPIkOlyBHgrfXwPaMDqZLcT8cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ASYFs3fa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ASYFs3fa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744813865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=M3aKjuBSofdl/WfprYl6DJmKZ07dVKfFKg7ZK124i70=;
	b=ASYFs3fa9yHLj0JC+HCIeziT8jwngFXXc9lVzyUjjFF2GVaPMf5wxFtlEKEcZAspbPRp5Q
	kY+M7l51qZIT5bO1nsASkpy1KPRQY8zungRziALCx3U7pL2wRWqY1gICx0+q7mpIIgSlY6
	RyINGcFcKrk4mMfxrg5ZxUIQ5ABBoIo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-K78ywhTWPeebuDH1vhqxew-1; Wed, 16 Apr 2025 10:29:57 -0400
X-MC-Unique: K78ywhTWPeebuDH1vhqxew-1
X-Mimecast-MFC-AGG-ID: K78ywhTWPeebuDH1vhqxew_1744813796
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d0830c3f7so52143515e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Apr 2025 07:29:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744813796; x=1745418596;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M3aKjuBSofdl/WfprYl6DJmKZ07dVKfFKg7ZK124i70=;
        b=mc5Myb/RDIILCKgfPzoI4/UbqbV6GN0jImeCbV+Btj65yeiMsLk3VJqD03A9hHVcyM
         XxQ6RBuN837q80IUPp6DXSy4s07niYG4mVcP/tu00oQgW+DAHjLTZ8uwlKhIXM5XnPzK
         4o32h80eI9L5u6kPDQfIuLDdVC9xf0rJhpGhyy3asEZJoHyjqTlQ+5eSWT3V0SpOn0xS
         2W1OcVC9tQe9S8K8fSL23tIALcjB+cxnGMcj5A/IIcfFWTg0pn22ukX3TPgXIco79EAs
         wU+ycfOqEABMScJ4e02oKmo77FGzms4J2vJJvhqjZTyTLmbHEIc0sgKKVXmhQopjcI36
         JmzQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1O4PmXwschkiDY1xWazv9WUbfJ84wH6BQc79h+skwmn7svJzSvOZQBuwD95Zce1eiALY7DZ6GOUaoQWosLG1ciOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv0yq/QZjg/EP1DGuF9TwlDITdOJk4mufu+h8OpjfivJtRIeOe
	jgBifiry1A/YtwNVDc1a9qpnn+WOs56li3pU50EBjYIXegzO4bPvEcbN/wFK6LJQpXrP6/cYSeG
	qMCDYaY6JG4QNHODwwq14z8ZZmfS1yD8B7D7a2mO9Tc5dK0PWggRurKxBAkO6UPiQAsyf9J6L16
	rF2fht
X-Gm-Gg: ASbGnctboPoX0xmOq4TwP0pWm3bOu6TqFjkIKaEIX+A3cIFb1TvNXxPoSBWyXTUzjli
	dIupp+IBmexXklEhFDOeeL3i+1BmXfDtdvnouWT8u1eimHFeJvOKmNGp29PiX3TDwBNyPV6wwuQ
	T/2OPwt0qlpKiMuJsRh5GilRwY6cC3ZfIAslBp4674T3p/ee3WMQ4PMjZ7pMT+r1adQZiFSMaHA
	/2QZQdg9ke5yZQowMABb5UvTw3JixnKA+k7RWIx15UQ9Jgy+1KH0qehwDGnOmAecmXYZ+lPDmKo
	aNl/hJ+Wbm2cCmyqQvt+qmH3K+Woytg+y9o+QlM=
X-Received: by 2002:a5d:47cb:0:b0:391:139f:61af with SMTP id ffacd0b85a97d-39ee5b1cf87mr2140985f8f.32.1744813796228;
        Wed, 16 Apr 2025 07:29:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmzjek8Rw/7fmoyQ/sF0qY6jOKHwHwLvp4Y/yffnHxieGarrZnnOuxkacClA21nZkn7yg+rw==
X-Received: by 2002:a5d:47cb:0:b0:391:139f:61af with SMTP id ffacd0b85a97d-39ee5b1cf87mr2140964f8f.32.1744813795804;
        Wed, 16 Apr 2025 07:29:55 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.134.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b4d3453sm22492985e9.16.2025.04.16.07.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 07:29:55 -0700 (PDT)
Message-ID: <a85dcc1c6b493838abdc8716ae35fe4ad734db2b.camel@redhat.com>
Subject: Re: [PATCH v3 13/22] rv: Add support for LTL monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de
Date: Wed, 16 Apr 2025 16:29:53 +0200
In-Reply-To: <19f424c910bfa0f4854117e3f8771aeb6e98a9d2.1744785335.git.namcao@linutronix.de>
References: <cover.1744785335.git.namcao@linutronix.de>
	 <19f424c910bfa0f4854117e3f8771aeb6e98a9d2.1744785335.git.namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BcgDrTdOsUOJAv_bayT8EGnj9FNOr_Y3knBm_QvIQ4I_1744813796
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-04-16 at 08:51 +0200, Nam Cao wrote:
> diff --git a/Documentation/trace/rv/linear_temporal_logic.rst
> b/Documentation/trace/rv/linear_temporal_logic.rst
> new file mode 100644
> index 000000000000..232f9700cbaa
> --- /dev/null
> +++ b/Documentation/trace/rv/linear_temporal_logic.rst
> @@ -0,0 +1,119 @@
> +Introduction
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +

Just noticed you misplaced the sections in this file, it should be like:

Linear Temporal Logic
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Introduction
------------

[...]

Grammar
-------

[...]

Example linear temporal logic
-----------------------------

[...]

E.g. use =3D=3D=3D only for the page's title (which is missing) and --- for
the sections, otherwise you get it oddly integrated in the index.

Thanks,
Gabriele

> +Runtime verification monitor is a verification technique which
> checks that the kernel follows a
> +specification. It does so by using tracepoints to monitor the
> kernel's execution trace, and
> +verifying that the execution trace sastifies the specification.
> +
> +Initially, the specification can only be written in the form of
> deterministic automaton (DA).
> +However, while attempting to implement DA monitors for some complex
> specifications, deterministic
> +automaton is found to be inappropriate as the specification
> language. The automaton is complicated,
> +hard to understand, and error-prone.
> +
> +Thus, RV monitors based on linear temporal logic (LTL) are
> introduced. This type of monitor uses LTL
> +as specification instead of DA. For some cases, writing the
> specification as LTL is more concise and
> +intuitive.
> +
> +Many materials explain LTL in details. One book is::
> +
> +=C2=A0 Christel Baier aund Joost-Pieter Katoen: Principles of Model
> Checking, The MIT Press, 2008.
> +
> +Grammar
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Unlike some existing syntax, kernel's implementation of LTL is more
> verbose. This is motivated by
> +considering that the people who read the LTL specifications may not
> be well-versed in LTL.
> +
> +Grammar:
> +=C2=A0=C2=A0=C2=A0 ltl ::=3D opd | ( ltl ) | ltl binop ltl | unop ltl
> +
> +Operands (opd):
> +=C2=A0=C2=A0=C2=A0 true, false, user-defined names consisting of upper-c=
ase
> characters, digits, and underscore.
> +
> +Unary Operators (unop):
> +=C2=A0=C2=A0=C2=A0 always
> +=C2=A0=C2=A0=C2=A0 eventually
> +=C2=A0=C2=A0=C2=A0 not
> +
> +Binary Operators (binop):
> +=C2=A0=C2=A0=C2=A0 until
> +=C2=A0=C2=A0=C2=A0 and
> +=C2=A0=C2=A0=C2=A0 or
> +=C2=A0=C2=A0=C2=A0 imply
> +=C2=A0=C2=A0=C2=A0 equivalent
> +
> +This grammar is ambiguous: operator precedence is not defined.
> Parentheses must be used.
> +
> +Example linear temporal logic
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> +.. code-block::
> +
> +=C2=A0=C2=A0 RAIN imply (GO_OUTSIDE imply HAVE_UMBRELLA)
> +
> +means: if it is raining, going outside means having an umbrella.
> +
> +.. code-block::
> +
> +=C2=A0=C2=A0 RAIN imply (WET until not RAIN)
> +
> +means: if it is raining, it is going to be wet until the rain stops.
> +
> +.. code-block::
> +
> +=C2=A0=C2=A0 RAIN imply eventually not RAIN
> +
> +means: if it is raining, rain will eventually stop.
> +
> +The above examples are referring to the current time instance only.
> For kernel verification, the
> +`always` operator is usually desirable, to specify that something is
> always true at the present and
> +for all future. For example::
> +
> +=C2=A0=C2=A0=C2=A0 always (RAIN imply eventually not RAIN)
> +
> +means: *all* rain eventually stops.
> +
> +In the above examples, `RAIN`, `GO_OUTSIDE`, `HAVE_UMBRELLA` and
> `WET` are the "atomic
> +propositions".
> +
> +Monitor synthesis
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +To synthesize an LTL into a kernel monitor, the `rvgen` tool can be
> used:
> +`tools/verification/rvgen`. The specification needs to be provided
> as a file, and it must have a
> +"RULE =3D LTL" assignment. For example::
> +
> +=C2=A0=C2=A0=C2=A0 RULE =3D always (ACQUIRE imply ((not KILLED and not C=
RASHED) until
> RELEASE))
> +
> +which says: if `ACQUIRE`, then `RELEASE` must happen before `KILLED`
> or `CRASHED`.
> +
> +The LTL can be broken down using sub-expressions. The above is
> equivalent to:
> +
> +=C2=A0=C2=A0 .. code-block::
> +
> +=C2=A0=C2=A0=C2=A0 RULE =3D always (ACQUIRE imply (ALIVE until RELEASE))
> +=C2=A0=C2=A0=C2=A0 ALIVE =3D not KILLED and not CRASHED
> +
> +From this specification, `rvgen` generates the C implementation of a
> Buchi automaton - a
> +non-deterministic state machine which checks the satisfiability of
> the LTL. See
> +Documentation/trace/rv/monitor_synthesis.rst for details on using
> `rvgen`.
> +
> +References
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +One book covering model checking and linear temporal logic is::
> +
> +=C2=A0 Christel Baier aund Joost-Pieter Katoen: Principles of Model
> Checking, The MIT Press, 2008.
> +
> +For an example of using linear temporal logic in software testing,
> see::
> +
> +=C2=A0 Ruijie Meng, Zhen Dong, Jialin Li, Ivan Beschastnikh, and Abhik
> Roychoudhury. 2022. Linear-time
> +=C2=A0 temporal logic guided greybox fuzzing. In Proceedings of the 44th
> International Conference on
> +=C2=A0 Software Engineering (ICSE '22). Association for Computing
> Machinery, New York, NY, USA,
> +=C2=A0 1343=E2=80=931355. https://doi.org/10.1145/3510003.3510082
> +
> +The kernel's LTL monitor implementation is based on::
> +
> +=C2=A0 Gerth, R., Peled, D., Vardi, M.Y., Wolper, P. (1996). Simple On-
> the-fly Automatic Verification of
> +=C2=A0 Linear Temporal Logic. In: Dembi=C5=84ski, P., =C5=9Aredniawa, M.=
 (eds)
> Protocol Specification, Testing and
> +=C2=A0 Verification XV. PSTV 1995. IFIP Advances in Information and
> Communication Technology. Springer,
> +=C2=A0 Boston, MA. https://doi.org/10.1007/978-0-387-34892-6_1

