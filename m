Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B45E202F8B
	for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 20:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756500402; cv=none; b=dWxAxIelFVh4yYheWYDUF7fRFiHZKWOQqNU7XxthNRig4Xz1Xya8szkVdzQvKnWxl6vBcTm/A3RSVMGLzGam57PmjCuopsT/YGdWBVw+mc3cUsY6ej10MWqk2qMPhUB7abe3AMpM5/8xjlLiMOVqTgJe1hhn/In7sAvrT87vMBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756500402; c=relaxed/simple;
	bh=2gQME/CeTQ1ZytLJ1lREM6veXoc5GPUWunrdD5LXriE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MfmDSmMYE/tfWh9IChCx+5ODIglw6hn0U3myQp8zw53DmPq+xRSl2uvUhFo370JH2CTog5Wf05XyhIr3qC8Jc+xltpg+DmhpWS/pg4/iUaABEolm0eyhAA3M1Dmv8hjHC7Tcv90/Nmg2OrzSf4GytvKOLeKkDvt2l85JZFJBYXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TJjyEXEa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TJjyEXEa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756500400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6kzUkpqFISW7ZamONykuS6OxgwuNYWSEt03dU4WXD9A=;
	b=TJjyEXEaSV0yAF9SphloFDW5eEcvy/EUPvQDRJw+hXXkeC5hmEZqYuaPYEoptZFii3jzfO
	RIrhsoCbeCltFTjGvpMRPxOkWYbrDyPf+aLFEGw8wZSxyCOwD5eSc+nLcllTkzEhlevvvX
	l3sz4Cf8iQQlBwje8dmsghII7G1GNvY=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-Zn_Vv1N5NpGYqCuBKub-2w-1; Fri, 29 Aug 2025 16:46:38 -0400
X-MC-Unique: Zn_Vv1N5NpGYqCuBKub-2w-1
X-Mimecast-MFC-AGG-ID: Zn_Vv1N5NpGYqCuBKub-2w_1756500398
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3eca67caa2bso27702225ab.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 13:46:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756500398; x=1757105198;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6kzUkpqFISW7ZamONykuS6OxgwuNYWSEt03dU4WXD9A=;
        b=akZkJ3WpERVUS+VBihvp5LZxEDHzKOs/RtkubsGWJkl3N1Wk8RiEpGNCGzgntaSTfR
         BQteW10pqX4YXViyVXaeo/tP1cCziXmQlkWJ0qavg8IxVQs6d2GWgO+ncMlpYeiZlwJO
         Wz6fSwg7WjDkddo0G13K8itBOOcveNQSaR2MRNQq6ajC51iSxRVEhTVGk+PRNwmoNGDY
         YNMITkeTIHTAzp6ON6l44cIEF6NjForTz/yVl8gil7+12ylHt8tfAGo666hYDDHE8qd1
         6XqW2EpybNgCMjKRdgge/XHsBfS3EgjfOgFHFBT/DY4craNYtPwGvaBLbj901NBbFyhF
         XxkA==
X-Forwarded-Encrypted: i=1; AJvYcCUHikI/HZ20RIjdGBtin7/aOhYPKFB7bJKz0dHcpLdFgAYDRIOlmi3ivU318SNxtOAak1/t5HmUQE+OrBp0mLkjwvA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl2YtRQzrwzOz8s9zRQCvaZEos+glHINrvEKXkLNe6R6ntc0+0
	oEDbGvnYws7oYbd9qUzRr1GiHDk+BnnCQzl7bLT4JVyCTx6lBFGg8uGFY1uZBtBUjiO2Rb9Y+oK
	QL1HpplnNnIVYtB79DTmWGqsEkG177iYT9EKoLo76fryLlCCvfoZ0jakprxECRUJJN26qY9v/dQ
	==
X-Gm-Gg: ASbGncu/CRgeugBTTaek7CjxJ8uLCiLYr5Ce8PtThLooY8mQ+fFxDfoemCzRVR8Bx/W
	yH1K5jn2wmWRKxdgAOOoV5yMbgG6IdCKIKAF9mwGw0pdzIBAI14ur/hR7Qvylv7nC+YJlfK5hU/
	09ZqVhY/l/dbYMBg6vuEdBD7GAal1fs2Gw7Khk6olVUNi4kyqbtrAd8TP+L8WeL27mmEkfJC9+G
	MNWBOAdsmn5B559xsX+qTfO0H2S/H92QDfpfWB8dMd9hA/8Y1wAfL73iqiEat1Q6RqrY+eXTQOZ
	LJqHLyeAUCA7+ZBpozzsTHV1q8D4gYBeD8eX/ehQzP2wx9T6MNdwzrEJlhrj2XzWoywF
X-Received: by 2002:a05:6e02:1a02:b0:3eb:5f74:ed9b with SMTP id e9e14a558f8ab-3eb5f74ef09mr314715665ab.2.1756500397887;
        Fri, 29 Aug 2025 13:46:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTi9DBDru2DOpJGlCwQecioGmeKnR4OH9pY0SkIysVPjC67bKuhyCOwV3cDU1fogNpJUbyYA==
X-Received: by 2002:a05:6e02:1a02:b0:3eb:5f74:ed9b with SMTP id e9e14a558f8ab-3eb5f74ef09mr314715235ab.2.1756500397456;
        Fri, 29 Aug 2025 13:46:37 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([50.145.183.242])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3f3de24e731sm1089075ab.8.2025.08.29.13.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 13:46:37 -0700 (PDT)
Message-ID: <98364b9384961b9598db6127c2f01d099102a0e4.camel@redhat.com>
Subject: Re: [PATCH 4/7] tools/rtla: Consolidate code between
 osnoise/timerlat and hist/top
From: Crystal Wood <crwood@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org,  John Kacur <jkacur@redhat.com>, Costa
 Shulyupin <costa.shul@redhat.com>
Date: Fri, 29 Aug 2025 15:46:36 -0500
In-Reply-To: <CAP4=nvQPDEy_GZWTUhQcMYW32-3DvyeyjzDjNLcEEG1AwZnczg@mail.gmail.com>
References: <20250821035719.137161-1-crwood@redhat.com>
		 <20250821035719.137161-5-crwood@redhat.com>
		 <CAP4=nvQPDEy_GZWTUhQcMYW32-3DvyeyjzDjNLcEEG1AwZnczg@mail.gmail.com>
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ix7xyoisbgvvoUdLFsdWK16qW2eZgUfHrJjtBGNawk8_1756500398
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-08-27 at 15:34 +0200, Tomas Glozar wrote:
> =C4=8Dt 21. 8. 2025 v 5:58 odes=C3=ADlatel Crystal Wood <crwood@redhat.co=
m> napsal:
> >=20
> > Some bits like aa_only and the user stuff are in common even though the=
y
> > are only used by timerlat.  In the case of user stuff I plan to submit
> > patches for supporting that on osnoise, and it doesn't seem worthwhile =
to
> > jump through hoops to move some of that code out of code that is otherw=
ise
> > able to be shared.  For aa_only, making it non-common would have preclu=
ded
> > sharing some code, and the code that the flag inhibits isn't tool-speci=
fic
> > (unlike no_aa).  Plus, there's other common code referring to tool->aa.
> > ---
>=20
> aa_only is implemented only for top, because the behavior would be the
> same for hist: just do auto-analysis, no histogram, no top. Of course,
> it doesn't hurt that it is included as a common parameter.
>=20
> > +       stopped =3D osnoise_trace_is_off(tool, tool->record) && !stop_t=
racing;
> > +       if (stopped) {
> > +               printf("rtla hit stop tracing\n");
> > +               return_value =3D FAILED;
> > +       }
> > +
>=20
> Is the output change necessary? The original "osnoise hit stop
> tracing"/"timerlat hit stop tracing" refers to the osnoise and
> timerlat tracers, which stop tracing on threshold (unless mode is
> TRACING_MODE_BPF
> ). We already have ops->tracer for the tracer name, that can be used here=
.

Certainly not necessary, but it didn't seem like an important
distinction to maintain -- unless there are scripts out there (beyond
our test cases) checking for it that we don't want to break.  Though
for not-yet-written scripts I'd imagine having to deal with different
names could be an annoyance as well.

> >  /*
> >   * timerlat_top_bpf_main_loop - main loop to process events (BPF varia=
nt)
> >   */
> >  static int
> > -timerlat_top_bpf_main_loop(struct osnoise_tool *top,
> > -                          struct osnoise_tool *record,
> > -                          struct osnoise_tool *aa,
> > -                          struct timerlat_params *params,
> > -                          struct timerlat_u_params *params_u)
> > +__timerlat_top_bpf_main_loop(struct osnoise_tool *tool)
>=20
> The naming here should be consistent with the comment and with
> timerlat-hist, that is, without the __ prefix, there is no other
> timerlat_top_bpf_main_loop that would create a conflict in this
> version of the patch.

Oops... I think there used to be a non-underscore version at some point
during development.  Will fix.

-Crystal

