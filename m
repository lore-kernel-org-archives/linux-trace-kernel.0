Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A567D28C5AB
	for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752651629; cv=none; b=lrdR6sexYZrud2keoFvX2k90Wswbkw9Jj+jI5A6pFPThXkC2/gxyQVLQQWlCOUJEwv608XJwjb0vY4QA4gMxjxax0ttXEdzw7C0nOnM9qg2P4be3X3p+ImM4Hessz8X/PFP6Hb0BBWDUM3/vnlTvSOUO7ytpK4S3B8accVNIZMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752651629; c=relaxed/simple;
	bh=9/JsRao4W8gcufB8ylLI/aFwupgEJaxwTsIkuenlRG8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f/NltohZJKekNqmJafxI01r8AVskE4dX/CUl3+oIQiA/jew1pUvVqndu01xBED1fqomvb3LvdG2tsz1z2G4nXhylBG7WRNCFdoQZHiIBDcfmLD/y1QeUPCQgIriHeD8oUYtDK87Jxa1yXSAMaPkQtEDiTK0m7ZSBd4YT9LopThw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hpLCfxku; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hpLCfxku"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752651626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9/JsRao4W8gcufB8ylLI/aFwupgEJaxwTsIkuenlRG8=;
	b=hpLCfxkuXU6JVhCsHra15uHug2fucb7PheyY6+/CFJ+Yz+4uiB6Aq0MivFY4f8wFNHanWF
	OC18zIt/0suGZ+vrXcgObQsRjYojBHkt2k2CwwtCU3J02T2O8WOjEjdBGw0lPKFW1nNwWO
	O2vbd6TCsCZVqNbibPyq29xqe6j0ZKA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-bkk_uczUPPOGSIrkqLvqmg-1; Wed, 16 Jul 2025 03:40:23 -0400
X-MC-Unique: bkk_uczUPPOGSIrkqLvqmg-1
X-Mimecast-MFC-AGG-ID: bkk_uczUPPOGSIrkqLvqmg_1752651622
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45626532e27so11376835e9.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Jul 2025 00:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752651622; x=1753256422;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9/JsRao4W8gcufB8ylLI/aFwupgEJaxwTsIkuenlRG8=;
        b=ZFVmYkHwtUimn0+kkAd5xZKaK3GYk5+0EwM0kHBC0/6rhej9jk/3xUzzB5pxy2YqoA
         CHwxYhmknEGmHalC4PUIY7fpA8AlZC6WI0VFHv/zGk9lyIo727tvjuPPiXrSOkMJJ3Sz
         VxnDFM4xt8GFl+vrnZCSMLLiVCmzigZDn93VBYVqfnzEiCu4gazdcrpsw40bk9TVKPHb
         b2dxfjSDC0uG5qKxRlM8KS8Y8xU+FX4BLQja9DPb1aK+FmRQb3/ZwfnpK4oRiLmwTRLQ
         XUimw91PEWeYjLktx5yxNJHZYs03LK8uN6jlya+Hn+uj1mCCIBmmHl0zZtve629ZnOL7
         hVrg==
X-Forwarded-Encrypted: i=1; AJvYcCVwtfIOGmo7oJx06AIwgBdXaDf39AI0zcGWed/HwZrEawLIlO/OCOpy5uHVYQsWcvXm8acf8teGi1TEhbevJoEk/Ic=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZpk/Jt8ef49PUduZkA7hqP8RBtelcI71gyXeJHEBVT00VmLNK
	XRaJwOvsCrQWxsQp3uhwxIED7RFtKMfMz+F6ZqgyIzKByNwvk5WsudY73ZQbhgLcjPeESqzwreC
	fo/wTd/IOG5weJqMfUnB01r9Kb+28yuNatSeDSglVMfZVZAJoTWbkCLF0i3qo+GW3O3i4KzuPRw
	==
X-Gm-Gg: ASbGnctUYjcVDuHWwU22o57ddQRHnzxv9VgKSxZDIj/MMDWo2zZljzqhXsgio03RM5S
	bdNjhsEKTc0CtMXEoo241OcDCAMMAbLbSnmateZZruAhE8eM77foTca6P8FpIOue/MVB0Hw6yCl
	EYcehsp9BQDQD70jYuBho2oLq1itQP9EDRa3LrGXwQoZOLq7vN4ktt8YQoNyxg4OIh6fkj+e2PW
	brcnKzDMDAstlIgMcP/DFXBlEqZ4f8L9K/b9FPlXvFRzem+s45DABdpH7tsEC6wtpLZO7XhkLzd
	tnNRYfP11KhM4VhO0xJS0KMsL+bNzd9QBFuOYG8laWQPT01Yt/1dyx2FhajGgMnmeg==
X-Received: by 2002:a05:600c:3496:b0:456:c50:1b3 with SMTP id 5b1f17b1804b1-4562e298f87mr13635715e9.29.1752651621968;
        Wed, 16 Jul 2025 00:40:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWw7bp5M0Awu61tKVOsiz+n22ba4tULTX21yMcMb+kNy1CV1I+gr+ff7CFrTUNp3zfrIgOxw==
X-Received: by 2002:a05:600c:3496:b0:456:c50:1b3 with SMTP id 5b1f17b1804b1-4562e298f87mr13635365e9.29.1752651621501;
        Wed, 16 Jul 2025 00:40:21 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e81a6f1sm12523195e9.21.2025.07.16.00.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 00:40:21 -0700 (PDT)
Message-ID: <141b94c0b9a1933f59a662f4c5d2dac9cb62db68.camel@redhat.com>
Subject: Re: [PATCH v3 08/17] verification/rvgen: Organise Kconfig entries
 for nested monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,  Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Wed, 16 Jul 2025 09:40:19 +0200
In-Reply-To: <20250715144858.ZS4_m8Qm@linutronix.de>
References: <20250715071434.22508-1-gmonaco@redhat.com>
	 <20250715071434.22508-9-gmonaco@redhat.com>
	 <20250715144858.ZS4_m8Qm@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: zOmfMP3k7X6q-iwPxsgO5C7o5b_LPGv1Rr4xdYne_qA_1752651622
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Tue, 2025-07-15 at 16:48 +0200, Nam Cao wrote:
> On Tue, Jul 15, 2025 at 09:14:25AM +0200, Gabriele Monaco wrote:
> > The current behaviour of rvgen when running with the -a option is
> > to
> > append the necessary lines at the end of the configuration for
> > Kconfig,
> > Makefile and tracepoints.
> > This is not always the desired behaviour in case of nested
> > monitors:
> > while tracepoints are not affected by nesting and the Makefile's
> > only
> > requirement is that the parent monitor is built before its
> > children, in
> > the Kconfig it is better to have children defined right after their
> > parent, otherwise the result has wrong indentation:
> >=20
> > [*]=C2=A0=C2=A0 foo_parent monitor
> > [*]=C2=A0=C2=A0=C2=A0=C2=A0 foo_child1 monitor
> > [*]=C2=A0=C2=A0=C2=A0=C2=A0 foo_child2 monitor
> > [*]=C2=A0=C2=A0 bar_parent monitor
> > [*]=C2=A0=C2=A0=C2=A0=C2=A0 bar_child1 monitor
> > [*]=C2=A0=C2=A0=C2=A0=C2=A0 bar_child2 monitor
> > [*]=C2=A0=C2=A0 foo_child3 monitor
> > [*]=C2=A0=C2=A0 foo_child4 monitor
> >=20
> > Adapt rvgen to look for a different marker for nested monitors in
> > the
> > Kconfig file and append the line right after the last sibling,
> > instead
> > of the last monitor.
> > Also add the marker when creating a new parent monitor.
> >=20
> > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> > ---
> > =C2=A0kernel/trace/rv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 5 +++++
> > =C2=A0tools/verification/rvgen/rvgen/container.py | 13 +++++++++++++
> > =C2=A0tools/verification/rvgen/rvgen/generator.py | 13 ++++++++-----
> > =C2=A03 files changed, 26 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
> > index c11bf7e61ebf0..26017378f79b8 100644
> > --- a/kernel/trace/rv/Kconfig
> > +++ b/kernel/trace/rv/Kconfig
> > @@ -43,6 +43,7 @@ config RV_PER_TASK_MONITORS
> > =C2=A0
> > =C2=A0source "kernel/trace/rv/monitors/wip/Kconfig"
> > =C2=A0source "kernel/trace/rv/monitors/wwnr/Kconfig"
> > +
> > =C2=A0source "kernel/trace/rv/monitors/sched/Kconfig"
> > =C2=A0source "kernel/trace/rv/monitors/tss/Kconfig"
> > =C2=A0source "kernel/trace/rv/monitors/sco/Kconfig"
> > @@ -50,9 +51,13 @@ source "kernel/trace/rv/monitors/snroc/Kconfig"
> > =C2=A0source "kernel/trace/rv/monitors/scpd/Kconfig"
> > =C2=A0source "kernel/trace/rv/monitors/snep/Kconfig"
> > =C2=A0source "kernel/trace/rv/monitors/sncid/Kconfig"
> > +# Add new sched monitors here
> > +
> > =C2=A0source "kernel/trace/rv/monitors/rtapp/Kconfig"
> > =C2=A0source "kernel/trace/rv/monitors/pagefault/Kconfig"
> > =C2=A0source "kernel/trace/rv/monitors/sleep/Kconfig"
> > +# Add new rtapp monitors here
> > +
> > =C2=A0# Add new monitors here
> > =C2=A0
> > =C2=A0config RV_REACTORS
> > diff --git a/tools/verification/rvgen/rvgen/container.py
> > b/tools/verification/rvgen/rvgen/container.py
> > index 47d8ab2ad3ec4..fee493f89fde6 100644
> > --- a/tools/verification/rvgen/rvgen/container.py
> > +++ b/tools/verification/rvgen/rvgen/container.py
> > @@ -20,3 +20,16 @@ class Container(generator.RVGenerator):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 main_h =3D self.main_h
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 main_h =3D main_h.repl=
ace("%%MODEL_NAME%%", self.name)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return main_h
> > +
> > +=C2=A0=C2=A0=C2=A0 def fill_kconfig_tooltip(self):
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """Override to produce a ma=
rker for this container in the
> > Kconfig"""
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 container_marker =3D f"# Ad=
d new {self.name} monitors
> > here\n"
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if self.auto_patch:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sel=
f._patch_file("Kconfig",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 "# Add new monitors here", "")
>=20
> Isn't this one excessive? I gave it a try, but I had double blank
> line:
>=20
> python3 tools/verification/rvgen -a container -n hello
>=20
> =C2=A0=C2=A0 61 source "kernel/trace/rv/monitors/sleep/Kconfig"
> =C2=A0=C2=A0 62 # Add new rtapp monitors here
> =C2=A0=C2=A0 63=20
> +=C2=A0 64=20
> +=C2=A0 65 source "kernel/trace/rv/monitors/hello/Kconfig"
> +=C2=A0 66 # Add new hello monitors here
> +=C2=A0 67=20
> =C2=A0=C2=A0 68 # Add new monitors here
> =C2=A0=C2=A0 69=20
> =C2=A0=C2=A0 70 config RV_REACTORS
>=20

Yeah indeed it is, thanks for finding out, it somehow slipped my
tests..

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D super().fill_kco=
nfig_tooltip()
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if self.auto_patch:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sel=
f._patch_file("Kconfig",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 "# Add new monitors here",
> > container_marker)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn result
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return result + container_m=
arker
> > diff --git a/tools/verification/rvgen/rvgen/generator.py
> > b/tools/verification/rvgen/rvgen/generator.py
> > index 19d0078a38032..ac97c4505ff00 100644
> > --- a/tools/verification/rvgen/rvgen/generator.py
> > +++ b/tools/verification/rvgen/rvgen/generator.py
> > @@ -137,7 +137,8 @@ class RVGenerator:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kconfig =3D kconfig.re=
place("%%MONITOR_DEPS%%",
> > monitor_deps)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return kconfig
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0 def __patch_file(self, file, marker, line):
> > +=C2=A0=C2=A0=C2=A0 def _patch_file(self, file, marker, line):
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(self.auto_patch)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file_to_patch =3D os.p=
ath.join(self.rv_dir, file)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 content =3D self._read=
_file(file_to_patch)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 content =3D content.re=
place(marker, line + "\n" + marker)
> > @@ -146,7 +147,7 @@ class RVGenerator:
> > =C2=A0=C2=A0=C2=A0=C2=A0 def fill_tracepoint_tooltip(self):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 monitor_class_type =3D=
 self.fill_monitor_class_type()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if self.auto_patch:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sel=
f.__patch_file("rv_trace.h",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sel=
f._patch_file("rv_trace.h",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 "// Add new monitors based on
> > CONFIG_%s here" % monitor_class_type,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 "#include <monitors/%s/%s_trace.h>" %
> > (self.name, self.name))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return "=C2=A0 - Patching %s/rv_trace.h, double check the
> > result" % self.rv_dir
> > @@ -158,8 +159,10 @@ Add this line where other tracepoints are
> > included and %s is defined:
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0 def fill_kconfig_tooltip(self):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if self.auto_patch:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sel=
f.__patch_file("Kconfig",
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 "# Add new monitors here",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # m=
onitors with a container should stay together in
> > the Kconfig
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sel=
f._patch_file("Kconfig",
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 "# Add new %smonitors here" %
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (self.parent + " " if self.parent
> > else ""),
>=20
> This one must be kept in sync with container_marker in
> Container.fill_kconfig_tooltip(). I think this is hard to maintain
> later
> on.
>=20
> How about we keep in centralized with a helper function, something
> like:
>=20
> def container_marker(container: str) -> str:
> =C2=A0=C2=A0=C2=A0 return f"# Add new {container} monitors here\n"
>=20

Good point, will do.

Thanks,
Gabriele

