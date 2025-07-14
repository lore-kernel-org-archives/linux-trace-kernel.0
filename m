Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513291E9B21
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752495494; cv=none; b=g6L091iKnCrrrKrHh9xHQFxlYYZyZOLONR5HPzmSmSR7ejDN/dI/eHtweCcOPj3go0EHODo7M7rrwHCi/tqITheqIfSgy0zX1s4sQld7La2+Ez+5JZKfcuWs3p2/+Q5DSfbhSosAvB3kOpALlrruCF7wxuBDw9BM0Ca34/lKeJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752495494; c=relaxed/simple;
	bh=tpyZrfjK3/WcrqF7VXBm0Hsd0QSVr/A2eNjiyRsHCeA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LD+a26gvCiFmkt/7y3gw//BTLuagKlKLrgLumeymA7V8E1m4Bx+Fre4I3IEwnX059eCXBe3uTTN27u67LNzISkDBvdBe4NOGm45EjfB/GA9y9+F59pDrIKqRjG0C7kOG1I0LexdcX41gODqkSPqJIqv6RKH40e4ZRy0r6ubjuf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HSJm7ZHP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HSJm7ZHP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752495491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=928LM1KO/zpxgAyYjp/u6gQCJhK9PkM2m7p9bLtw7m0=;
	b=HSJm7ZHPU6PP194736XM6kAvUOH3jIIwBzKNIOpEIMKtpVkVjRaq+0OeowSGPy9zx8Q18i
	x6XxbA9YgeuWK0Ayz/eZdBOTgWJUK4+9BgZ+ojUVqjIMaGZfymQYuACdrrXSPiyeJYIZuo
	S6KiBZnzo/lrN9CG/CIkhyTe0oQPdeg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-01yosOqdNiqW6cn6Mdulsw-1; Mon, 14 Jul 2025 08:18:09 -0400
X-MC-Unique: 01yosOqdNiqW6cn6Mdulsw-1
X-Mimecast-MFC-AGG-ID: 01yosOqdNiqW6cn6Mdulsw_1752495489
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4fabcafecso2062571f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Jul 2025 05:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752495489; x=1753100289;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vF4RRl/e27zgqzxDxG5kIPXppzZTec0QHAD68B9ffyk=;
        b=l9gc2o4eo3RBbRxphR4q2C9LNxLfkont1gvohwlkxywoqBkUGL+878d8Bnk6Pm3/u5
         bdm+G4wQjFBmKPWMPFdof3lEHkC3S0fPmfZ4X1GWRZBszoim0xs99PmNft8KK7VPaDMh
         0Y8f5oflRaUwRGKm66xi07BKxDeDQDyT+9DKzkiImDY73Nut2w9LPTqTYmgQONf62H5U
         xqU3cf2DXDWgEmhx+3lV0evZ24DnbwGDtPRkTjFhQQz46ysuSIKJhFn/sEKQe9Qli/8g
         Ml7bRoLc9NxxIt61BMWq5t6ACXr6RJ6UCwRQr9saMMfbgktOLx/kmavrRr2VUqo3IeJG
         CARg==
X-Forwarded-Encrypted: i=1; AJvYcCU6P0FhUzsKCPBQueHH4SS2ebuJ8kIYr1mrvEoA31bKd+pBhiAb71PAPdhfnbl3TeZ0qFLr1kJfEkA3f+MaJPVpqbw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1iHkClBOEuaGK94NAroi86yz99wFQTu7/ymQYfHgM6XcycLA3
	8UwZ7/EJa/arAZM/B5cMQkb66b5NOI9I8EftEkp4kXylUxDbYg1Y8//6EU/IERVa/gy9SKM1Nxf
	FRHxKQmIbQKIEk9W0FHIUyYOzlVDpnEiNioFKAD0hN7TcSSNqpyg+cTiAWtbFxTVUnSR2NPkdAw
	==
X-Gm-Gg: ASbGncsX2PO7XcJds18XEZ8KJZFMJvEb1zPrAbQSR41nxoud9pY+BamZMzyG26Bgqwh
	WM1gb92v+zrmJBz7sj+SnjXe254SV2JEMMEbeSR33eOzZyaqOE4x2QC3UjYX/mEcyYeawft5gmT
	ZQQX8ZFdt6yZ8nv+5OvFLeSlq+fCTnzNnJuihdJVbGoptjKVtv6rwu9THLCo5s2HlHcl3BC0v7k
	oHj8I2DejYLDkiA9jjTcoKHN32Z6y2TdkNwtPiHAP4oZ4fU8/Ed+2X7XUNPzyuE7otmeZdXejXe
	ZoAcLtn31ETwW014+NLEbe7sd37bXH0MFcopLAcjmLLoTWdrpduAJiSoStu6+dH4Tw==
X-Received: by 2002:a05:6000:3c1:b0:3b5:e792:18ce with SMTP id ffacd0b85a97d-3b5f3535dacmr7518353f8f.22.1752495488569;
        Mon, 14 Jul 2025 05:18:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8Nf6WPAKZGYybLTu8M3aBAKMcW9iO8m3H/R8fR2RDf0WhuGHwniepHzcEfAGdHD7s4onvbw==
X-Received: by 2002:a05:6000:3c1:b0:3b5:e792:18ce with SMTP id ffacd0b85a97d-3b5f3535dacmr7518329f8f.22.1752495487950;
        Mon, 14 Jul 2025 05:18:07 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc3a54sm12452681f8f.39.2025.07.14.05.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 05:18:07 -0700 (PDT)
Message-ID: <7f4409eae10023a804d24ad2a9c67d368db152cb.camel@redhat.com>
Subject: Re: [PATCH 2/2] verification/rvgen: Support the 'next' operator
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers	 <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 14 Jul 2025 14:18:05 +0200
In-Reply-To: <9c32cec04dd18d2e956fddd84b0e0a2503daa75a.1752239482.git.namcao@linutronix.de>
References: <cover.1752239482.git.namcao@linutronix.de>
		 <9c32cec04dd18d2e956fddd84b0e0a2503daa75a.1752239482.git.namcao@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: 4gmyPUWR0pdP65hAygGRYITTs01X2JVbFHBRqcEzP7s_1752495489
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-07-11 at 15:17 +0200, Nam Cao wrote:
> The 'next' operator is a unary operator. It is defined as: "next
> time, the
> operand must be true".
>=20
> Support this operator. For RV monitors, "next time" means the next
> invocation of ltl_validate().
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>

Hi Nam,

thanks for the series, I did a very stupid test like this:

  RULE =3D always (SCHEDULING imply next SWITCH)

Despite the monitor working or not, the generator created code that
doesn't build, specifically:

1. It creates a variable named switch
  - sure I could change the name, but perhaps we could prepend
something to make sure local variables are not C keywords

2. It created unused variables in ltl_start
  - _fill_atom_values creates all variables but _fill_start uses only
those where the .init field is true (maybe the model is wrong though)

Now, this specific model reports errors without the sched_switch_vain
tracepoint which I'm introducing in another patch.

For it to work, I have to define it in such a way that scheduling
becomes true at schedule_entry and becomes false right after the
switch:

schedule_entry
=09SCHEDULING=3Dtrue

sched_switch
=09SWITCH=3Dtrue

schedule_exit
=09SCHEDULING=3Dfalse
=09SWITCH=3Dfalse

If I understood correctly that's intended behaviour since swapping the
assignments in schedule_exit (or doing a pulse in sched_switch) would
add another event when scheduling is true, which is against the next
requirement.

Now I can't think of a way to rewrite the model to allow a pulse in
sched_switch, that is /whenever scheduling turns to true, the next
event is a switch/ instead of /any time scheduling is true, the next
event is a switch/.

I tried something like:
  RULE =3D always ((not SCHEDULING and next SCHEDULING) imply next
SWITCH)
but the parser got the two SCHEDULING as two different atoms, so I
guess I did something I was not supposed to do..

Is the next operator only meaningful for atoms that are mutually
exclusive (e.g. RED next GREEN, if GREEN is true RED turns to false)
and/or when playing with ltl_atom_set without triggering validations?

What am I missing here?

Thanks,
Gabriele

> ---
> =C2=A0.../trace/rv/linear_temporal_logic.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0tools/verification/rvgen/rvgen/ltl2ba.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 26
> +++++++++++++++++++
> =C2=A02 files changed, 27 insertions(+)
>=20
> diff --git a/Documentation/trace/rv/linear_temporal_logic.rst
> b/Documentation/trace/rv/linear_temporal_logic.rst
> index 57f107fcf6dd..9eee09d9cacf 100644
> --- a/Documentation/trace/rv/linear_temporal_logic.rst
> +++ b/Documentation/trace/rv/linear_temporal_logic.rst
> @@ -41,6 +41,7 @@ Operands (opd):
> =C2=A0Unary Operators (unop):
> =C2=A0=C2=A0=C2=A0=C2=A0 always
> =C2=A0=C2=A0=C2=A0=C2=A0 eventually
> +=C2=A0=C2=A0=C2=A0 next
> =C2=A0=C2=A0=C2=A0=C2=A0 not
> =C2=A0
> =C2=A0Binary Operators (binop):
> diff --git a/tools/verification/rvgen/rvgen/ltl2ba.py
> b/tools/verification/rvgen/rvgen/ltl2ba.py
> index d11840af7f5f..f14e6760ac3d 100644
> --- a/tools/verification/rvgen/rvgen/ltl2ba.py
> +++ b/tools/verification/rvgen/rvgen/ltl2ba.py
> @@ -19,6 +19,7 @@ from ply.yacc import yacc
> =C2=A0# Unary Operators (unop):
> =C2=A0#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 always
> =C2=A0#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eventually
> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 next
> =C2=A0#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 not
> =C2=A0#
> =C2=A0# Binary Operators (binop):
> @@ -35,6 +36,7 @@ tokens =3D (
> =C2=A0=C2=A0=C2=A0 'UNTIL',
> =C2=A0=C2=A0=C2=A0 'ALWAYS',
> =C2=A0=C2=A0=C2=A0 'EVENTUALLY',
> +=C2=A0=C2=A0 'NEXT',
> =C2=A0=C2=A0=C2=A0 'VARIABLE',
> =C2=A0=C2=A0=C2=A0 'LITERAL',
> =C2=A0=C2=A0=C2=A0 'NOT',
> @@ -48,6 +50,7 @@ t_OR =3D r'or'
> =C2=A0t_IMPLY =3D r'imply'
> =C2=A0t_UNTIL =3D r'until'
> =C2=A0t_ALWAYS =3D r'always'
> +t_NEXT =3D r'next'
> =C2=A0t_EVENTUALLY =3D r'eventually'
> =C2=A0t_VARIABLE =3D r'[A-Z_0-9]+'
> =C2=A0t_LITERAL =3D r'true|false'
> @@ -327,6 +330,26 @@ class AlwaysOp(UnaryOp):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # ![]F =3D=3D <>(!F)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return EventuallyOp(self=
.child.negate()).normalize()
> =C2=A0
> +class NextOp(UnaryOp):
> +=C2=A0=C2=A0=C2=A0 def normalize(self):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return self
> +
> +=C2=A0=C2=A0=C2=A0 def _is_temporal(self):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return True
> +
> +=C2=A0=C2=A0=C2=A0 def negate(self):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # not (next A) =3D=3D next (n=
ot A)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.child =3D self.child.neg=
ate()
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return self
> +
> +=C2=A0=C2=A0=C2=A0 @staticmethod
> +=C2=A0=C2=A0=C2=A0 def expand(n: ASTNode, node: GraphNode, node_set) ->
> set[GraphNode]:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp =3D GraphNode(node.incomi=
ng,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node.new=
,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node.old=
 | {n},
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node.nex=
t | {n.op.child})
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return tmp.expand(node_set)
> +
> =C2=A0class NotOp(UnaryOp):
> =C2=A0=C2=A0=C2=A0=C2=A0 def __str__(self):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "!" + str(self.ch=
ild)
> @@ -452,12 +475,15 @@ def p_unop(p):
> =C2=A0=C2=A0=C2=A0=C2=A0 '''
> =C2=A0=C2=A0=C2=A0=C2=A0 unop : ALWAYS ltl
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | EVENTUALLY ltl
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | NEXT ltl
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | NOT ltl
> =C2=A0=C2=A0=C2=A0=C2=A0 '''
> =C2=A0=C2=A0=C2=A0=C2=A0 if p[1] =3D=3D "always":
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op =3D AlwaysOp(p[2])
> =C2=A0=C2=A0=C2=A0=C2=A0 elif p[1] =3D=3D "eventually":
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op =3D EventuallyOp(p[2]=
)
> +=C2=A0=C2=A0=C2=A0 elif p[1] =3D=3D "next":
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op =3D NextOp(p[2])
> =C2=A0=C2=A0=C2=A0=C2=A0 elif p[1] =3D=3D "not":
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op =3D NotOp(p[2])
> =C2=A0=C2=A0=C2=A0=C2=A0 else:

